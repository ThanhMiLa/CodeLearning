import React, { useEffect, useState, useRef } from 'react';
import { useNavigate, useSearchParams, Link } from 'react-router-dom';
import { CheckCircle2, ArrowRight, Loader2, Sparkles, BookOpen } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import api from '../../api/axios';
import type { ApiResponse, UserBalanceResponse } from '../../types';

const SuccessPage: React.FC = () => {
  const navigate = useNavigate();
  const { user, refreshProfile } = useAuth();
  const [searchParams] = useSearchParams();
  const [syncing, setSyncing] = useState(true);
  const pollingStartedRef = useRef(false);

  const orderCode = searchParams.get('orderCode') || searchParams.get('transactionCode') || 'N/A';

  useEffect(() => {
    if (!user || pollingStartedRef.current) return;
    pollingStartedRef.current = true;

    let isSubscribed = true;
    const initialBalance = user.balance;
    const startTime = Date.now();
    const FIVE_MINUTES_MS = 5 * 60 * 1000;
    let intervalId: NodeJS.Timeout;

    const pollBalance = async () => {
      if (!isSubscribed) return;
      try {
        const response = await api.get<ApiResponse<UserBalanceResponse>>('/users/me/balance');
        if (!isSubscribed) return;

        const latestBalance = response.data.result.balance;

        if (latestBalance !== initialBalance) {
          await refreshProfile();
          if (isSubscribed) {
            setSyncing(false);
            clearInterval(intervalId);
          }
          return;
        }

        if (Date.now() - startTime >= FIVE_MINUTES_MS) {
          console.warn('Wallet balance polling timed out after 5 minutes.');
          if (isSubscribed) {
            setSyncing(false);
            clearInterval(intervalId);
          }
        }
      } catch (error) {
        console.error('Error polling wallet balance:', error);
      }
    };

    intervalId = setInterval(pollBalance, 1000);
    pollBalance();

    return () => {
      isSubscribed = false;
      clearInterval(intervalId);
    };
  }, [user, refreshProfile]);

  return (
    <div className="mx-auto max-w-md text-center py-20 px-4 min-h-[75vh] flex flex-col justify-center items-center">
      {/* Animated Glowing Success Circle */}
      <div className="relative mb-6">
        <div className="absolute inset-0 bg-emerald-500/20 rounded-full blur-xl animate-pulse"></div>
        <div className="relative h-20 w-20 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-500 flex items-center justify-center">
          <CheckCircle2 className="h-10 w-10 animate-bounce" />
        </div>
      </div>

      {/* Success Title */}
      <h2 className="text-2xl font-black text-slate-900 dark:text-white tracking-tight mb-2">
        Payment Successful!
      </h2>
      <p className="text-sm text-slate-500 dark:text-slate-400 max-w-sm mb-6 leading-relaxed">
        Your transaction has been securely processed via PayOS. The system has activated your course/service.
      </p>

      {/* Transaction Details Box */}
      <div className="w-full bg-white dark:bg-slate-900 border border-slate-300 dark:border-slate-800/80 rounded-2xl p-5 mb-8 text-left space-y-3 shadow-sm select-all">
        <div className="flex justify-between text-xs font-semibold">
          <span className="text-slate-400">Order/Transaction ID:</span>
          <span className="text-slate-800 dark:text-white font-mono">{orderCode}</span>
        </div>
        <div className="flex justify-between text-xs font-semibold">
          <span className="text-slate-400">Status:</span>
          <span className="text-emerald-600 dark:text-emerald-400 flex items-center space-x-1">
            <Sparkles className="h-3.5 w-3.5" />
            <span>Success</span>
          </span>
        </div>
        <div className="flex justify-between text-xs font-semibold border-t border-slate-200 dark:border-slate-800 pt-2.5">
          <span className="text-slate-400">Wallet Sync:</span>
          {syncing ? (
            <span className="text-indigo-600 dark:text-indigo-400 flex items-center space-x-1 font-bold">
              <Loader2 className="h-3 w-3 animate-spin" />
              <span>Syncing...</span>
            </span>
          ) : (
            <span className="text-emerald-600 dark:text-emerald-400 font-bold">✓ Synced</span>
          )}
        </div>
      </div>

      {/* Action buttons */}
      <div className="flex flex-col sm:flex-row gap-3 w-full">
        <button
          onClick={() => navigate('/dashboard')}
          className="flex-1 inline-flex items-center justify-center space-x-1.5 px-5 py-3 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/10 hover:shadow-indigo-600/25 transition-all active:scale-95"
        >
          <BookOpen className="h-4 w-4" />
          <span>Start Learning</span>
          <ArrowRight className="h-3.5 w-3.5" />
        </button>
        <Link
          to="/"
          className="flex-1 inline-flex items-center justify-center px-5 py-3 border border-slate-200 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-bold text-slate-600 dark:text-slate-300 rounded-xl transition-colors"
        >
          Back to Home
        </Link>
      </div>

    </div>
  );
};

export default SuccessPage;
