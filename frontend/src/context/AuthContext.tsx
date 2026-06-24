import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import api from '../api/axios';
import type { 
  AuthenticationResponse, 
  UserResponse, 
  ApiResponse,
  UserBalanceResponse
} from '../types';

export interface AuthUser {
  id: number;
  displayName: string;
  email: string;
  phoneNumber: string | null;
  balance: number;
  username?: string;
  avatarUrl?: string | null;
}

interface AuthContextType {
  user: AuthUser | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  login: (credentials: { username: string; password: string }) => Promise<AuthUser>;
  register: (data: any) => Promise<AuthUser>;
  logout: () => Promise<void>;
  refreshProfile: () => Promise<AuthUser>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<AuthUser | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  const fetchProfile = useCallback(async (): Promise<AuthUser> => {
    try {
      const response = await api.get<ApiResponse<UserResponse>>('/users/me');
      const profileData = response.data.result;
      
      let balance = 0;
      try {
        const balanceRes = await api.get<ApiResponse<UserBalanceResponse>>('/users/me/balance');
        balance = balanceRes.data.result.balance;
      } catch (err) {
        console.error('Failed to fetch balance in fetchProfile:', err);
      }

      const loggedInUser: AuthUser = {
        id: profileData.id,
        displayName: profileData.displayName,
        email: profileData.email,
        phoneNumber: profileData.phoneNumber,
        username: profileData.username,
        balance: balance,
        avatarUrl: profileData.avatarUrl
      };
      
      setUser(loggedInUser);
      return loggedInUser;
    } catch (error) {
      setUser(null);
      throw error;
    }
  }, []);

  const login = async (credentials: { username: string; password: string }): Promise<AuthUser> => {
    try {
      const response = await api.post<ApiResponse<AuthenticationResponse>>('/auth/login', credentials);
      const authData = response.data.result;
      const loggedInUser: AuthUser = {
        id: authData.id,
        displayName: authData.displayName,
        email: authData.email,
        phoneNumber: authData.phoneNumber,
        balance: authData.balance,
        username: credentials.username,
        avatarUrl: authData.avatarUrl
      };
      setUser(loggedInUser);
      return loggedInUser;
    } catch (error) {
      setUser(null);
      throw error;
    }
  };

  const register = async (data: any): Promise<AuthUser> => {
    try {
      const response = await api.post<ApiResponse<AuthenticationResponse>>('/auth/register', data);
      const authData = response.data.result;
      const registeredUser: AuthUser = {
        id: authData.id,
        displayName: authData.displayName,
        email: authData.email,
        phoneNumber: authData.phoneNumber,
        balance: authData.balance,
        username: data.username,
        avatarUrl: authData.avatarUrl
      };
      setUser(registeredUser);
      return registeredUser;
    } catch (error) {
      setUser(null);
      throw error;
    }
  };

  const logout = async (): Promise<void> => {
    try {
      await api.post('/auth/logout');
    } finally {
      setUser(null);
    }
  };

  const refreshProfile = async (): Promise<AuthUser> => {
    try {
      const response = await api.get<ApiResponse<UserResponse>>('/users/me');
      const profileData = response.data.result;
      
      let balance = user?.balance ?? 0;
      try {
        const balanceRes = await api.get<ApiResponse<UserBalanceResponse>>('/users/me/balance');
        balance = balanceRes.data.result.balance;
      } catch (err) {
        console.error('Failed to fetch balance in refreshProfile:', err);
      }

      const updatedUser: AuthUser = {
        id: profileData.id,
        displayName: profileData.displayName,
        email: profileData.email,
        phoneNumber: profileData.phoneNumber,
        username: profileData.username,
        balance: balance,
        avatarUrl: profileData.avatarUrl
      };

      setUser(updatedUser);
      return updatedUser;
    } catch (error) {
      throw error;
    }
  };

  // Check auth status on startup
  useEffect(() => {
    const initAuth = async () => {
      try {
        await fetchProfile();
      } catch (error) {
        setUser(null);
      } finally {
        setIsLoading(false);
      }
    };
    initAuth();
  }, [fetchProfile]);

  return (
    <AuthContext.Provider
      value={{
        user,
        isAuthenticated: !!user,
        isLoading,
        login,
        register,
        logout,
        refreshProfile
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
