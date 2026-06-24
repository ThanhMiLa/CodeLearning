import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Lock, User, Mail, Phone, Eye, EyeOff, Loader, AlertCircle } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { getErrorMessage } from '../../utils/errorUtils';
import { useTranslation } from 'react-i18next';

const Register: React.FC = () => {
  const { register } = useAuth();
  const navigate = useNavigate();
  const { t } = useTranslation();
  
  const [displayName, setDisplayName] = useState('');
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  
  const [error, setError] = useState<string | null>(null);
  const [isLoadingState, setIsLoadingState] = useState(false);
  const [validationErrors, setValidationErrors] = useState<{
    displayName?: string;
    username?: string;
    email?: string;
    phoneNumber?: string;
    password?: string;
    confirmPassword?: string;
  }>({});

  const validate = () => {
    const errors: typeof validationErrors = {};
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^0\d{9}$/;

    if (!displayName.trim() || displayName.length < 4) {
      errors.displayName = t('register.validation.displayName_len');
    }
    if (!username.trim() || username.length < 4) {
      errors.username = t('register.validation.username_len');
    }
    if (!email.trim()) {
      errors.email = t('register.validation.email_required');
    } else if (!emailRegex.test(email)) {
      errors.email = t('register.validation.email_invalid');
    }
    if (phoneNumber.trim() && !phoneRegex.test(phoneNumber)) {
      errors.phoneNumber = t('register.validation.phone_invalid');
    }
    if (!password || password.length < 4) {
      errors.password = t('register.validation.password_len');
    }
    if (password !== confirmPassword) {
      errors.confirmPassword = t('register.validation.confirmPassword_match');
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
      await register({
        displayName,
        username,
        email,
        phoneNumber: phoneNumber || null,
        password,
        confirmPassword
      });
      navigate('/profile', { replace: true });
    } catch (err: any) {
      setError(getErrorMessage(err, t('register.error_failed')));
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
        className="w-full max-w-lg space-y-8 p-8 sm:p-10 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-xl"
      >
        <div className="text-center">
          <h2 className="text-3xl font-extrabold tracking-tight text-slate-900 dark:text-white">
            {t('register.title')}
          </h2>
          <p className="mt-2.5 text-sm text-slate-500 dark:text-slate-400">
            {t('register.subtitle')}
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

        <form className="mt-8 space-y-5" onSubmit={handleSubmit}>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {/* Display Name */}
            <div>
              <label htmlFor="displayName" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                {t('register.displayName_label')}
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <User className="h-4.5 w-4.5" />
                </div>
                <input
                  id="displayName"
                  type="text"
                  value={displayName}
                  onChange={(e) => {
                    setDisplayName(e.target.value);
                    if (validationErrors.displayName) setValidationErrors(prev => ({ ...prev, displayName: undefined }));
                  }}
                  className={`block w-full pl-11 pr-4 py-3 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 dark:focus:ring-indigo-500/10 transition-all ${
                    validationErrors.displayName ? 'border-red-300 focus:border-red-500' : 'border-slate-200 dark:border-slate-800'
                  }`}
                  placeholder={t('placeholders.displayName')}
                />
              </div>
              {validationErrors.displayName && (
                <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{validationErrors.displayName}</p>
              )}
            </div>

            {/* Username */}
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
                  type="text"
                  value={username}
                  onChange={(e) => {
                    setUsername(e.target.value);
                    if (validationErrors.username) setValidationErrors(prev => ({ ...prev, username: undefined }));
                  }}
                  className={`block w-full pl-11 pr-4 py-3 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 dark:focus:ring-indigo-500/10 transition-all ${
                    validationErrors.username ? 'border-red-300 focus:border-red-500' : 'border-slate-200 dark:border-slate-800'
                  }`}
                  placeholder={t('placeholders.username')}
                />
              </div>
              {validationErrors.username && (
                <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{validationErrors.username}</p>
              )}
            </div>

            {/* Email */}
            <div>
              <label htmlFor="email" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                {t('register.email_label')}
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <Mail className="h-4.5 w-4.5" />
                </div>
                <input
                  id="email"
                  type="email"
                  value={email}
                  onChange={(e) => {
                    setEmail(e.target.value);
                    if (validationErrors.email) setValidationErrors(prev => ({ ...prev, email: undefined }));
                  }}
                  className={`block w-full pl-11 pr-4 py-3 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 dark:focus:ring-indigo-500/10 transition-all ${
                    validationErrors.email ? 'border-red-300 focus:border-red-500' : 'border-slate-200 dark:border-slate-800'
                  }`}
                  placeholder={t('placeholders.email')}
                />
              </div>
              {validationErrors.email && (
                <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{validationErrors.email}</p>
              )}
            </div>

            {/* Phone Number */}
            <div>
              <label htmlFor="phoneNumber" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                {t('register.phone_label')} <span className="text-slate-400 dark:text-slate-500 font-normal">({t('register.optional')})</span>
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <Phone className="h-4.5 w-4.5" />
                </div>
                <input
                  id="phoneNumber"
                  type="text"
                  value={phoneNumber}
                  onChange={(e) => {
                    setPhoneNumber(e.target.value);
                    if (validationErrors.phoneNumber) setValidationErrors(prev => ({ ...prev, phoneNumber: undefined }));
                  }}
                  className={`block w-full pl-11 pr-4 py-3 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 dark:focus:ring-indigo-500/10 transition-all ${
                    validationErrors.phoneNumber ? 'border-red-300 focus:border-red-500' : 'border-slate-200 dark:border-slate-800'
                  }`}
                  placeholder={t('placeholders.phone')}
                />
              </div>
              {validationErrors.phoneNumber && (
                <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{validationErrors.phoneNumber}</p>
              )}
            </div>

            {/* Password */}
            <div>
              <label htmlFor="password" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                {t('login.password_label')}
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <Lock className="h-4.5 w-4.5" />
                </div>
                <input
                  id="password"
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => {
                    setPassword(e.target.value);
                    if (validationErrors.password) setValidationErrors(prev => ({ ...prev, password: undefined }));
                  }}
                  className={`block w-full pl-11 pr-11 py-3 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 dark:focus:ring-indigo-500/10 transition-all ${
                    validationErrors.password ? 'border-red-300 focus:border-red-500' : 'border-slate-200 dark:border-slate-800'
                  }`}
                  placeholder={t('placeholders.password_placeholder')}
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

            {/* Confirm Password */}
            <div>
              <label htmlFor="confirmPassword" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                {t('register.confirmPassword_label')}
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                  <Lock className="h-4.5 w-4.5" />
                </div>
                <input
                  id="confirmPassword"
                  type={showConfirmPassword ? 'text' : 'password'}
                  value={confirmPassword}
                  onChange={(e) => {
                    setConfirmPassword(e.target.value);
                    if (validationErrors.confirmPassword) setValidationErrors(prev => ({ ...prev, confirmPassword: undefined }));
                  }}
                  className={`block w-full pl-11 pr-11 py-3 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 dark:focus:ring-indigo-500/10 transition-all ${
                    validationErrors.confirmPassword ? 'border-red-300 focus:border-red-500' : 'border-slate-200 dark:border-slate-800'
                  }`}
                  placeholder={t('placeholders.confirmPassword')}
                />
                <button
                  type="button"
                  onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  className="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 transition-colors"
                >
                  {showConfirmPassword ? <EyeOff className="h-4.5 w-4.5" /> : <Eye className="h-4.5 w-4.5" />}
                </button>
              </div>
              {validationErrors.confirmPassword && (
                <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{validationErrors.confirmPassword}</p>
              )}
            </div>
          </div>

          <div className="pt-2">
            <button
              type="submit"
              disabled={isLoadingState}
              className="relative w-full flex justify-center py-3.5 px-4 border border-transparent text-sm font-semibold rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 dark:focus:ring-indigo-500/10 shadow-lg shadow-indigo-500/20 hover:shadow-indigo-500/30 transition-all disabled:opacity-50 active:scale-98"
            >
              {isLoadingState ? (
                <Loader className="h-5 w-5 animate-spin" />
              ) : (
                t('buttons.register')
              )}
            </button>
          </div>
        </form>

        <div className="text-center pt-2 text-sm text-slate-500 dark:text-slate-400">
          {t('register.already_account')}{' '}
          <Link to="/login" className="font-semibold text-indigo-600 hover:text-indigo-500 dark:text-indigo-400 hover:underline">
            {t('login.login_now')}
          </Link>
        </div>
      </motion.div>
    </div>
  );
};

export default Register;
