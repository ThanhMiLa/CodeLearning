import React, { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Lock, User, Eye, EyeOff, Loader, AlertCircle } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useTranslation } from 'react-i18next';
import { getErrorMessage } from '../../utils/errorUtils';
import { GoogleLogin } from '@react-oauth/google';

const Login: React.FC = () => {
  const { login, googleLogin } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const { t } = useTranslation();
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [isLoadingState, setIsLoadingState] = useState(false);

  // Client-side validation
  const [validationErrors, setValidationErrors] = useState<{
    username?: string;
    password?: string;
  }>({});

  const validate = () => {
    const errors: { username?: string; password?: string } = {};
    if (!username.trim()) {
      errors.username = t('login.validation.username_required');
    }
    if (!password) {
      errors.password = t('login.validation.password_required');
    }
    setValidationErrors(errors);
    return Object.keys(errors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!validate()) return;

    setIsLoadingState(true);
    try {
      const user = await login({ username, password });
      // Redirect back to original path or profile/dashboard
      let from = (location.state as any)?.from?.pathname;
      if (!from || from === '/login' || from === '/') {
        from = user.roles?.includes('ADMIN') || user.roles?.includes('TEACHER') ? '/admin/dashboard' : '/profile';
      }
      navigate(from, { replace: true });
    } catch (err: any) {
      setError(getErrorMessage(err, t('login.error_failed')));
    } finally {
      setIsLoadingState(false);
    }
  };

  return (
    <div className="flex-grow flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-slate-50 dark:bg-slate-950 transition-colors duration-200">
      <motion.div 
        initial={{ opacity: 0, y: 15 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.4 }}
        className="w-full max-w-md space-y-8 p-8 sm:p-10 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-xl"
      >
        <div className="text-center">
          <h2 className="text-3xl font-extrabold tracking-tight text-slate-900 dark:text-white">
            {t('login.welcome_back')}
          </h2>
          <p className="mt-2.5 text-sm text-slate-500 dark:text-slate-400">
            {t('login.subtitle')}
          </p>
        </div>

        {error && (
          <motion.div 
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            className="flex items-start space-x-2.5 p-4 rounded-xl bg-red-50 dark:bg-red-950/20 border border-red-100/50 dark:border-red-900/30 text-sm text-red-700 dark:text-red-400"
          >
            <AlertCircle className="h-5 w-5 shrink-0 mt-0.5" />
            <span>{error}</span>
          </motion.div>
        )}

        <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
          <div className="space-y-4">
            {/* Username Field */}
            <div>
              <label htmlFor="username" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                {t('login.username_label')}
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <User className="h-4.5 w-4.5" />
                </div>
                <input
                  id="username"
                  name="username"
                  type="text"
                  autoComplete="username"
                  value={username}
                  onChange={(e) => {
                    setUsername(e.target.value);
                    if (validationErrors.username) setValidationErrors(prev => ({ ...prev, username: undefined }));
                  }}
                  className={`block w-full pl-11 pr-4 py-3 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 dark:focus:ring-indigo-500/10 transition-all ${
                    validationErrors.username ? 'border-red-300 focus:border-red-500 focus:ring-red-500/10' : 'border-slate-200 dark:border-slate-800'
                  }`}
                  placeholder={t('placeholders.username')}
                />
              </div>
              {validationErrors.username && (
                <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{validationErrors.username}</p>
              )}
            </div>

            {/* Password Field */}
            <div>
              <div className="flex justify-between items-center mb-1.5">
                <label htmlFor="password" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400">
                  {t('login.password_label')}
                </label>
              </div>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <Lock className="h-4.5 w-4.5" />
                </div>
                <input
                  id="password"
                  name="password"
                  type={showPassword ? 'text' : 'password'}
                  autoComplete="current-password"
                  value={password}
                  onChange={(e) => {
                    setPassword(e.target.value);
                    if (validationErrors.password) setValidationErrors(prev => ({ ...prev, password: undefined }));
                  }}
                  className={`block w-full pl-11 pr-11 py-3 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 dark:focus:ring-indigo-500/10 transition-all ${
                    validationErrors.password ? 'border-red-300 focus:border-red-500 focus:ring-red-500/10' : 'border-slate-200 dark:border-slate-800'
                  }`}
                  placeholder={t('placeholders.password')}
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 transition-colors"
                >
                  {showPassword ? <EyeOff className="h-4.5 w-4.5" /> : <Eye className="h-4.5 w-4.5" />}
                </button>
              </div>
              {validationErrors.password && (
                <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{validationErrors.password}</p>
              )}
            </div>
          </div>

          <div>
            <button
              type="submit"
              disabled={isLoadingState}
              className="relative w-full flex justify-center py-3.5 px-4 border border-transparent text-sm font-semibold rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 dark:focus:ring-indigo-500/10 shadow-lg shadow-indigo-500/20 hover:shadow-indigo-500/30 transition-all disabled:opacity-50 active:scale-98"
            >
              {isLoadingState ? (
                <Loader className="h-5 w-5 animate-spin" />
              ) : (
                t('buttons.login')
              )}
            </button>
          </div>
        </form>

        <div className="mt-6">
          <div className="relative">
            <div className="absolute inset-0 flex items-center">
              <div className="w-full border-t border-slate-200 dark:border-slate-800" />
            </div>
            <div className="relative flex justify-center text-sm">
              <span className="px-2 bg-white dark:bg-slate-900 text-slate-500">
                {t('login.or_continue_with') || 'Or continue with'}
              </span>
            </div>
          </div>
          <div className="mt-6 flex justify-center">
            <GoogleLogin
              onSuccess={async (credentialResponse) => {
                try {
                  setIsLoadingState(true);
                  const user = await googleLogin(credentialResponse.credential!);
                  let from = (location.state as any)?.from?.pathname;
                  if (!from || from === '/login' || from === '/') {
                    from = user.roles?.includes('ADMIN') || user.roles?.includes('TEACHER') ? '/admin/dashboard' : '/profile';
                  }
                  navigate(from, { replace: true });
                } catch (err: any) {
                  setError(getErrorMessage(err, t('login.error_failed') || 'Login Failed'));
                } finally {
                  setIsLoadingState(false);
                }
              }}
              onError={() => {
                setError('Google Login Failed');
              }}
            />
          </div>
        </div>

        <div className="text-center pt-2 text-sm text-slate-500 dark:text-slate-400">
          {t('login.no_account')}{' '}
          <Link to="/register" className="font-semibold text-indigo-600 hover:text-indigo-500 dark:text-indigo-400 hover:underline">
            {t('login.register_now')}
          </Link>
        </div>
      </motion.div>
    </div>
  );
};

export default Login;
