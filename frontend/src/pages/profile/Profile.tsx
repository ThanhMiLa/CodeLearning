import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { 
  User, 
  Phone, 
  Mail, 
  Lock, 
  Save, 
  RefreshCw, 
  CheckCircle, 
  AlertCircle,
  Eye,
  EyeOff
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import type { ApiResponse, UserResponse } from '../../types';

const Profile: React.FC = () => {
  const { user, refreshProfile, logout } = useAuth();
  const navigate = useNavigate();

  // Profile Form States
  const [displayName, setDisplayName] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');
  const [avatarFile, setAvatarFile] = useState<File | null>(null);
  const [avatarPreviewUrl, setAvatarPreviewUrl] = useState<string | null>(null);
  const [isProfileUpdating, setIsProfileUpdating] = useState(false);
  const [profileSuccess, setProfileSuccess] = useState<string | null>(null);
  const [profileError, setProfileError] = useState<string | null>(null);

  // Password Form States
  const [oldPassword, setOldPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmNewPassword, setConfirmNewPassword] = useState('');
  const [isPasswordUpdating, setIsPasswordUpdating] = useState(false);
  const [passwordSuccess, setPasswordSuccess] = useState<string | null>(null);
  const [passwordError, setPasswordError] = useState<string | null>(null);
  const [showOldPass, setShowOldPass] = useState(false);
  const [showNewPass, setShowNewPass] = useState(false);
  const [showConfirmNewPass, setShowConfirmNewPass] = useState(false);

  // Validation States
  const [profileErrors, setProfileErrors] = useState<{ displayName?: string; phoneNumber?: string }>({});
  const [passwordErrors, setPasswordErrors] = useState<{ oldPassword?: string; newPassword?: string; confirmNewPassword?: string }>({});

  useEffect(() => {
    if (user) {
      setDisplayName(user.displayName || '');
      setPhoneNumber(user.phoneNumber || '');
    }
  }, [user]);

  useEffect(() => {
    return () => {
      if (avatarPreviewUrl) {
        URL.revokeObjectURL(avatarPreviewUrl);
      }
    };
  }, [avatarPreviewUrl]);

  const handleAvatarChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      const file = e.target.files[0];
      setAvatarFile(file);
      setAvatarPreviewUrl(URL.createObjectURL(file));
    }
  };

  // Profile submit handler
  const handleUpdateProfile = async (e: React.FormEvent) => {
    e.preventDefault();
    setProfileSuccess(null);
    setProfileError(null);
    setProfileErrors({});

    const errors: typeof profileErrors = {};
    if (!displayName.trim() || displayName.length < 4) {
      errors.displayName = 'Display name must be at least 4 characters';
    }
    if (phoneNumber && !/^0\d{9}$/.test(phoneNumber)) {
      errors.phoneNumber = 'Phone number must be 10 digits starting with 0';
    }

    if (Object.keys(errors).length > 0) {
      setProfileErrors(errors);
      return;
    }

    setIsProfileUpdating(true);
    try {
      const formData = new FormData();
      formData.append('displayName', displayName);
      if (phoneNumber) {
        formData.append('phoneNumber', phoneNumber);
      }
      if (avatarFile) {
        formData.append('avatarFile', avatarFile);
      }

      await api.patch<ApiResponse<UserResponse>>('/users/me', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      
      await refreshProfile();
      setProfileSuccess('Profile updated successfully!');
      setAvatarFile(null);
      setAvatarPreviewUrl(null);
    } catch (err: any) {
      setProfileError(getErrorMessage(err));
    } finally {
      setIsProfileUpdating(false);
    }
  };

  // Password submit handler
  const handleUpdatePassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setPasswordSuccess(null);
    setPasswordError(null);
    setPasswordErrors({});

    const errors: typeof passwordErrors = {};
    if (!oldPassword || oldPassword.length < 4) {
      errors.oldPassword = 'Old password must be at least 4 characters';
    }
    if (!newPassword || newPassword.length < 4) {
      errors.newPassword = 'New password must be at least 4 characters';
    }
    if (newPassword !== confirmNewPassword) {
      errors.confirmNewPassword = 'Confirm password does not match';
    }

    if (Object.keys(errors).length > 0) {
      setPasswordErrors(errors);
      return;
    }

    setIsPasswordUpdating(true);
    try {
      await api.put<ApiResponse<void>>('/users/me/password', {
        oldPassword,
        newPassword,
        confirmNewPassword,
      });

      setPasswordSuccess('Password changed successfully! You will be automatically logged out in a few seconds...');
      
      // Auto logout after 3 seconds
      setTimeout(async () => {
        await logout();
        navigate('/login', { replace: true });
      }, 3000);

    } catch (err: any) {
      setPasswordError(getErrorMessage(err));
    } finally {
      setIsPasswordUpdating(false);
    }
  };

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-12 sm:px-6 lg:px-8">
      <div className="mb-10 text-left">
        <h1 className="text-3xl font-extrabold tracking-tight text-slate-900 dark:text-white">Account Settings</h1>
        <p className="text-slate-500 mt-2">Update your personal profile info and security configurations.</p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* User Card Showcase */}
        <div className="lg:col-span-1">
          <div className="p-8 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-lg text-center flex flex-col items-center">
            <img
              src={user?.avatarUrl || "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"}
              alt={user?.displayName}
              className="h-24 w-24 rounded-full object-cover shadow-md mb-6 border-4 border-indigo-50 dark:border-indigo-950"
            />
            <h2 className="text-xl font-bold text-slate-900 dark:text-white">{user?.displayName}</h2>
            <p className="text-sm text-slate-400 dark:text-slate-500 mt-1">@{user?.username || 'user'}</p>
            
            <div className="w-full h-[1px] bg-slate-100 dark:bg-slate-800 my-6"></div>

            <div className="w-full space-y-4 text-left">
              <div className="flex items-center space-x-3 text-sm text-slate-600 dark:text-slate-300">
                <Mail className="h-4.5 w-4.5 text-indigo-500" />
                <span className="truncate">{user?.email}</span>
              </div>
              {user?.phoneNumber && (
                <div className="flex items-center space-x-3 text-sm text-slate-600 dark:text-slate-300">
                  <Phone className="h-4.5 w-4.5 text-indigo-500" />
                  <span>{user?.phoneNumber}</span>
                </div>
              )}
            </div>
          </div>
        </div>

        {/* Edit Forms Grid */}
        <div className="lg:col-span-2 space-y-8">
          {/* Edit Profile Form */}
          <motion.div 
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            className="p-8 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-lg"
          >
            <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-6 flex items-center">
              <User className="h-5 w-5 mr-2 text-indigo-500" />
              <span>Personal Information</span>
            </h3>

            {profileSuccess && (
              <div className="flex items-center space-x-2 p-4 mb-6 rounded-xl bg-emerald-50 dark:bg-emerald-950/20 border border-emerald-100/50 dark:border-emerald-900/30 text-sm text-emerald-700 dark:text-emerald-400">
                <CheckCircle className="h-5 w-5 shrink-0" />
                <span>{profileSuccess}</span>
              </div>
            )}

            {profileError && (
              <div className="flex items-center space-x-2 p-4 mb-6 rounded-xl bg-red-50 dark:bg-red-950/20 border border-red-100/50 dark:border-red-900/30 text-sm text-red-700 dark:text-red-400">
                <AlertCircle className="h-5 w-5 shrink-0" />
                <span>{profileError}</span>
              </div>
            )}

            <form onSubmit={handleUpdateProfile} className="space-y-4">
              {/* Avatar Upload */}
              <div className="flex items-center space-x-4 mb-6">
                <img
                  src={avatarPreviewUrl || user?.avatarUrl || "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"}
                  alt="Avatar Preview"
                  className="h-16 w-16 rounded-full object-cover border-2 border-indigo-500/20 shadow-sm"
                />
                <div className="flex-grow">
                  <label htmlFor="avatarFileInput" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                    Profile Picture
                  </label>
                  <input
                    id="avatarFileInput"
                    type="file"
                    accept="image/*"
                    onChange={handleAvatarChange}
                    className="block w-full text-xs text-slate-500 dark:text-slate-400
                      file:mr-4 file:py-1.5 file:px-3
                      file:rounded-xl file:border-0
                      file:text-xs file:font-semibold
                      file:bg-indigo-50 file:text-indigo-700
                      dark:file:bg-indigo-950/40 dark:file:text-indigo-400
                      hover:file:bg-indigo-100 dark:hover:file:bg-indigo-950/60
                      file:cursor-pointer cursor-pointer"
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Display Name Input */}
                <div>
                  <label htmlFor="displayNameInput" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                    Display Name
                  </label>
                  <div className="relative">
                    <input
                      id="displayNameInput"
                      type="text"
                      value={displayName}
                      onChange={(e) => setDisplayName(e.target.value)}
                      className={`block w-full px-4 py-2.5 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 transition-all ${
                        profileErrors.displayName ? 'border-red-300' : 'border-slate-200'
                      }`}
                    />
                  </div>
                  {profileErrors.displayName && (
                    <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{profileErrors.displayName}</p>
                  )}
                </div>

                {/* Phone Number Input */}
                <div>
                  <label htmlFor="phoneNumberInput" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                    Phone Number
                  </label>
                  <div className="relative">
                    <input
                      id="phoneNumberInput"
                      type="text"
                      value={phoneNumber}
                      onChange={(e) => setPhoneNumber(e.target.value)}
                      className={`block w-full px-4 py-2.5 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 transition-all ${
                        profileErrors.phoneNumber ? 'border-red-300' : 'border-slate-200'
                      }`}
                      placeholder="Not updated"
                    />
                  </div>
                  {profileErrors.phoneNumber && (
                    <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{profileErrors.phoneNumber}</p>
                  )}
                </div>
              </div>

              <div className="flex justify-end pt-2">
                <button
                  type="submit"
                  disabled={isProfileUpdating}
                  className="flex items-center justify-center space-x-1.5 py-2.5 px-5 border border-transparent text-sm font-semibold rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none shadow-md shadow-indigo-500/15 hover:shadow-indigo-500/25 transition-all disabled:opacity-50 active:scale-97 cursor-pointer"
                >
                  {isProfileUpdating ? <RefreshCw className="h-4 w-4 animate-spin" /> : <Save className="h-4 w-4" />}
                  <span>Save Changes</span>
                </button>
              </div>
            </form>
          </motion.div>

          {/* Change Password Form */}
          <motion.div 
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            className="p-8 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-lg"
          >
            <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-6 flex items-center">
              <Lock className="h-5 w-5 mr-2 text-indigo-500" />
              <span>Change Password</span>
            </h3>

            {passwordSuccess && (
              <div className="flex items-center space-x-2 p-4 mb-6 rounded-xl bg-emerald-50 dark:bg-emerald-950/20 border border-emerald-100/50 dark:border-emerald-900/30 text-sm text-emerald-700 dark:text-emerald-400">
                <CheckCircle className="h-5 w-5 shrink-0" />
                <span>{passwordSuccess}</span>
              </div>
            )}

            {passwordError && (
              <div className="flex items-center space-x-2 p-4 mb-6 rounded-xl bg-red-50 dark:bg-red-950/20 border border-red-100/50 dark:border-red-900/30 text-sm text-red-700 dark:text-red-400">
                <AlertCircle className="h-5 w-5 shrink-0" />
                <span>{passwordError}</span>
              </div>
            )}

            <form onSubmit={handleUpdatePassword} className="space-y-4">
              {/* Old Password */}
              <div>
                <label htmlFor="oldPasswordInput" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                  Old Password
                </label>
                <div className="relative">
                  <input
                    id="oldPasswordInput"
                    type={showOldPass ? 'text' : 'password'}
                    value={oldPassword}
                    onChange={(e) => setOldPassword(e.target.value)}
                    className={`block w-full pl-4 pr-11 py-2.5 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 transition-all ${
                      passwordErrors.oldPassword ? 'border-red-300' : 'border-slate-200'
                    }`}
                  />
                  <button
                    type="button"
                    onClick={() => setShowOldPass(!showOldPass)}
                    className="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-600 transition-colors"
                  >
                    {showOldPass ? <EyeOff className="h-4.5 w-4.5" /> : <Eye className="h-4.5 w-4.5" />}
                  </button>
                </div>
                {passwordErrors.oldPassword && (
                  <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{passwordErrors.oldPassword}</p>
                )}
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* New Password */}
                <div>
                  <label htmlFor="newPasswordInput" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                    New Password
                  </label>
                  <div className="relative">
                    <input
                      id="newPasswordInput"
                      type={showNewPass ? 'text' : 'password'}
                      value={newPassword}
                      onChange={(e) => setNewPassword(e.target.value)}
                      className={`block w-full pl-4 pr-11 py-2.5 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 transition-all ${
                        passwordErrors.newPassword ? 'border-red-300' : 'border-slate-200'
                      }`}
                    />
                    <button
                      type="button"
                      onClick={() => setShowNewPass(!showNewPass)}
                      className="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-600 transition-colors"
                    >
                      {showNewPass ? <EyeOff className="h-4.5 w-4.5" /> : <Eye className="h-4.5 w-4.5" />}
                    </button>
                  </div>
                  {passwordErrors.newPassword && (
                    <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{passwordErrors.newPassword}</p>
                  )}
                </div>

                {/* Confirm New Password */}
                <div>
                  <label htmlFor="confirmNewPasswordInput" className="block text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400 mb-1.5">
                    Confirm New Password
                  </label>
                  <div className="relative">
                    <input
                      id="confirmNewPasswordInput"
                      type={showConfirmNewPass ? 'text' : 'password'}
                      value={confirmNewPassword}
                      onChange={(e) => setConfirmNewPassword(e.target.value)}
                      className={`block w-full pl-4 pr-11 py-2.5 rounded-xl border bg-slate-100/70 dark:bg-slate-950/40 text-sm placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:border-slate-800 transition-all ${
                        passwordErrors.confirmNewPassword ? 'border-red-300' : 'border-slate-200'
                      }`}
                    />
                    <button
                      type="button"
                      onClick={() => setShowConfirmNewPass(!showConfirmNewPass)}
                      className="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-600 transition-colors"
                    >
                      {showConfirmNewPass ? <EyeOff className="h-4.5 w-4.5" /> : <Eye className="h-4.5 w-4.5" />}
                    </button>
                  </div>
                  {passwordErrors.confirmNewPassword && (
                    <p className="mt-1.5 text-xs text-red-600 dark:text-red-400 font-medium">{passwordErrors.confirmNewPassword}</p>
                  )}
                </div>
              </div>

              <div className="flex justify-end pt-2">
                <button
                  type="submit"
                  disabled={isPasswordUpdating}
                  className="flex items-center justify-center space-x-1.5 py-2.5 px-5 border border-transparent text-sm font-semibold rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none shadow-md shadow-indigo-500/15 hover:shadow-indigo-500/25 transition-all disabled:opacity-50 active:scale-97 cursor-pointer"
                >
                  {isPasswordUpdating ? <RefreshCw className="h-4 w-4 animate-spin" /> : <Save className="h-4 w-4" />}
                  <span>Update Password</span>
                </button>
              </div>
            </form>
          </motion.div>
        </div>
      </div>
    </div>
  );
};

export default Profile;
