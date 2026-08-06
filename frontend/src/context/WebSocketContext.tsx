import React, { createContext, useContext, useState, useEffect, useRef, useCallback } from 'react';
import SockJS from 'sockjs-client';
import Stomp from 'stompjs';
import { useAuth } from './AuthContext';

interface WebSocketContextType {
  isConnected: boolean;
  subscribe: (topic: string, callback: (message: Stomp.Message) => void) => Stomp.Subscription | null;
  send: (destination: string, body: any) => void;
}

const WebSocketContext = createContext<WebSocketContextType | undefined>(undefined);

export const WebSocketProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { isAuthenticated } = useAuth();
  const [isConnected, setIsConnected] = useState<boolean>(false);
  const stompClientRef = useRef<Stomp.Client | null>(null);
  const reconnectTimeoutRef = useRef<NodeJS.Timeout | null>(null);
  const subscriptionsMapRef = useRef<Map<string, Set<(msg: Stomp.Message) => void>>>(new Map());
  const activeSubscriptionsRef = useRef<Map<string, Stomp.Subscription>>(new Map());

  const connect = useCallback(() => {
    if (stompClientRef.current && stompClientRef.current.connected) {
      return;
    }

    console.log('Connecting to WebSocket...');
    
    try {
      // Use SockJS fallback endpoint
      const apiBaseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/codelearning';
      const socket = new SockJS(`${apiBaseUrl}/ws`);
      const client = Stomp.over(socket);

      // Disable logging in production
      if (process.env.NODE_ENV === 'production') {
        client.debug = () => {};
      } else {
        client.debug = (str) => console.log('[STOMP]', str);
      }

      const getCookie = (name: string) => {
        const value = `; ${document.cookie}`;
        const parts = value.split(`; ${name}=`);
        if (parts.length === 2) return parts.pop()?.split(';').shift();
        return null;
      };

      const token = getCookie('access_token');
      const headers = token ? { Authorization: `Bearer ${token}` } : {};

      client.connect(
        headers,
        (frame) => {
          console.log('Connected to WebSocket successfully', frame);
          stompClientRef.current = client;
          setIsConnected(true);

          // Re-subscribe all active topics
          subscriptionsMapRef.current.forEach((callbacks, topic) => {
            if (callbacks.size > 0) {
              console.log(`Re-subscribing to topic: ${topic}`);
              const sub = client.subscribe(topic, (message) => {
                callbacks.forEach((cb) => cb(message));
              });
              activeSubscriptionsRef.current.set(topic, sub);
            }
          });
        },
        (error) => {
          console.error('WebSocket connection error:', error);
          setIsConnected(false);
          stompClientRef.current = null;
          
          // Reconnect after 5 seconds
          if (reconnectTimeoutRef.current) {
            clearTimeout(reconnectTimeoutRef.current);
          }
          reconnectTimeoutRef.current = setTimeout(() => {
            connect();
          }, 5000);
        }
      );
    } catch (error) {
      console.error('Failed to initialize SockJS client:', error);
      setIsConnected(false);
      stompClientRef.current = null;
    }
  }, []);

  const disconnect = useCallback(() => {
    if (reconnectTimeoutRef.current) {
      clearTimeout(reconnectTimeoutRef.current);
      reconnectTimeoutRef.current = null;
    }

    if (stompClientRef.current) {
      console.log('Disconnecting from WebSocket...');
      stompClientRef.current.disconnect(() => {
        console.log('Disconnected from WebSocket');
        setIsConnected(false);
        stompClientRef.current = null;
        activeSubscriptionsRef.current.clear();
      });
    }
  }, []);

  // Connect on mount / when auth state changes
  useEffect(() => {
    if (isAuthenticated) {
      connect();
    } else {
      disconnect();
    }
    return () => {
      disconnect();
    };
  }, [connect, disconnect, isAuthenticated]);

  const subscribe = useCallback((topic: string, callback: (message: Stomp.Message) => void): Stomp.Subscription | null => {
    // Add callback to map
    if (!subscriptionsMapRef.current.has(topic)) {
      subscriptionsMapRef.current.set(topic, new Set());
    }
    subscriptionsMapRef.current.get(topic)!.add(callback);

    const client = stompClientRef.current;
    
    // If client is connected, subscribe immediately
    if (client && client.connected && !activeSubscriptionsRef.current.has(topic)) {
      const sub = client.subscribe(topic, (message) => {
        const callbacks = subscriptionsMapRef.current.get(topic);
        if (callbacks) {
          callbacks.forEach((cb) => cb(message));
        }
      });
      activeSubscriptionsRef.current.set(topic, sub);
    }

    // Return custom unsubscriber
    const subscriptionMock: Stomp.Subscription = {
      id: `${topic}-${Date.now()}-${Math.random()}`,
      unsubscribe: () => {
        const callbacks = subscriptionsMapRef.current.get(topic);
        if (callbacks) {
          callbacks.delete(callback);
          if (callbacks.size === 0) {
            subscriptionsMapRef.current.delete(topic);
            const activeSub = activeSubscriptionsRef.current.get(topic);
            if (activeSub) {
              activeSub.unsubscribe();
              activeSubscriptionsRef.current.delete(topic);
            }
          }
        }
      }
    };

    return subscriptionMock;
  }, []);

  const send = useCallback((destination: string, body: any) => {
    const client = stompClientRef.current;
    if (client && client.connected) {
      client.send(destination, {}, JSON.stringify(body));
    } else {
      console.warn('Cannot send WebSocket message: STOMP client is not connected');
    }
  }, []);

  return (
    <WebSocketContext.Provider value={{ isConnected, subscribe, send }}>
      {children}
    </WebSocketContext.Provider>
  );
};

export const useWebSocket = () => {
  const context = useContext(WebSocketContext);
  if (context === undefined) {
    throw new Error('useWebSocket must be used within a WebSocketProvider');
  }
  return context;
};
