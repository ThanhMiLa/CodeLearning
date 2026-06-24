import React from 'react';
import { Navigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

interface RoleRouteProps {
  children: React.ReactNode;
  allowedRoles: string[];
}

const RoleRoute: React.FC<RoleRouteProps> = ({ children, allowedRoles }) => {
  const { user, isAuthenticated, isLoading } = useAuth();

  if (isLoading) {
    return (
      <div className="flex h-screen w-screen items-center justify-center bg-slate-50 dark:bg-slate-950">
        <div className="h-10 w-10 animate-spin rounded-full border-4 border-slate-300 border-t-indigo-600"></div>
      </div>
    );
  }

  if (!isAuthenticated || !user) {
    return <Navigate to="/login" replace />;
  }

  const userRole = (user as any).role || 
    (user.roles?.includes('ADMIN') ? 'ADMIN' : null) ||
    (user.roles?.includes('TEACHER') ? 'TEACHER' : null) ||
    'USER';

  const hasAccess = allowedRoles.includes(userRole);

  if (!hasAccess) {
    return <Navigate to="/" replace />;
  }

  return <>{children}</>;
};

export default RoleRoute;
