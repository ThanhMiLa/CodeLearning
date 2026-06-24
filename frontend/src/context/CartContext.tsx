import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import api from '../api/axios';
import { useAuth } from './AuthContext';
import type { CartResponse, CartItemResponse, ApiResponse } from '../types';

interface CartContextType {
  cartItems: CartItemResponse[];
  cartCount: number;
  isLoading: boolean;
  fetchCart: () => Promise<CartItemResponse[]>;
  addToCart: (courseId: number) => Promise<void>;
  removeFromCart: (courseId: number) => Promise<void>;
  clearCart: () => Promise<void>;
  isInCart: (courseId: number) => boolean;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

export const CartProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { isAuthenticated } = useAuth();
  const [cartItems, setCartItems] = useState<CartItemResponse[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const fetchCart = useCallback(async (): Promise<CartItemResponse[]> => {
    if (!isAuthenticated) {
      setCartItems([]);
      return [];
    }
    setIsLoading(true);
    try {
      const response = await api.get<ApiResponse<CartResponse>>('/carts');
      const items = response.data.result.items || [];
      setCartItems(items);
      return items;
    } catch (error) {
      console.error('Failed to fetch cart:', error);
      return [];
    } finally {
      setIsLoading(false);
    }
  }, [isAuthenticated]);

  const addToCart = async (courseId: number): Promise<void> => {
    if (!isAuthenticated) return;
    try {
      const response = await api.post<ApiResponse<CartResponse>>('/carts/items', { courseId });
      setCartItems(response.data.result.items || []);
    } catch (error) {
      console.error('Failed to add to cart:', error);
      throw error;
    }
  };

  const removeFromCart = async (courseId: number): Promise<void> => {
    if (!isAuthenticated) return;
    try {
      const response = await api.delete<ApiResponse<CartResponse>>(`/carts/items/${courseId}`);
      setCartItems(response.data.result.items || []);
    } catch (error) {
      console.error('Failed to remove from cart:', error);
      throw error;
    }
  };

  const clearCart = async (): Promise<void> => {
    if (!isAuthenticated) return;
    try {
      await api.delete<ApiResponse<void>>('/carts/items');
      setCartItems([]);
    } catch (error) {
      console.error('Failed to clear cart:', error);
      throw error;
    }
  };

  const isInCart = (courseId: number): boolean => {
    return cartItems.some(item => item.course.id === courseId);
  };

  // Load cart when authenticated
  useEffect(() => {
    fetchCart();
  }, [fetchCart]);

  return (
    <CartContext.Provider
      value={{
        cartItems,
        cartCount: cartItems.length,
        isLoading,
        fetchCart,
        addToCart,
        removeFromCart,
        clearCart,
        isInCart
      }}
    >
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => {
  const context = useContext(CartContext);
  if (context === undefined) {
    throw new Error('useCart must be used within a CartProvider');
  }
  return context;
};
