import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Wallet, Loader2, ArrowLeft, ShieldCheck, Sparkles } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import type { ApiResponse, PaymentDepositResponse } from '../../types';

const DepositPage: React.FC = () => {
  const { user } = useAuth();
  const navigate = useNavigate();
  const [depositAmount, setDepositAmount] = useState<number>(50000);
  const [customAmountText, setCustomAmountText] = useState<string>('');
  const [isCreatingLink, setIsCreatingLink] = useState(false);

  const formatVND = (amount: number) => {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
  };

  const handleDeposit = async () => {
    if (depositAmount < 10000 || isCreatingLink) {
      alert('Minimum deposit is 10,000 VND.');
      return;
    }
    setIsCreatingLink(true);
    try {
      const res = await api.post<ApiResponse<PaymentDepositResponse>>('/payment/deposit', {
        amount: depositAmount
      });
      const { checkoutUrl } = res.data.result;
      window.location.href = checkoutUrl;
    } catch (err: any) {
      console.error('Deposit failed:', err);
      alert(getErrorMessage(err, 'Failed to create payment link. Please try again later.'));
    } finally {
      setIsCreatingLink(false);
    }
  };

  return (
    <div className="min-h-[80vh] flex flex-col justify-center items-center py-12 px-4 sm:px-6 lg:px-8 bg-slate-50 dark:bg-slate-950 transition-colors duration-200">
      <div className="w-full max-w-xl space-y-6">
        
        {/* Back Button */}
        <div className="flex justify-start">
          <button 
            onClick={() => navigate(-1)}
            className="flex items-center space-x-2 text-xs font-bold text-slate-500 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors cursor-pointer group"
          >
            <ArrowLeft className="h-4 w-4 transition-transform group-hover:-translate-x-1" />
            <span>Go Back</span>
          </button>
        </div>

        {/* Content Card */}
        <div className="bg-white dark:bg-slate-900 border border-slate-300 dark:border-slate-800 rounded-3xl p-6 md:p-10 shadow-xl space-y-8 relative overflow-hidden select-none">
          {/* Accent Glow decoration */}
          <div className="absolute top-0 right-0 w-48 h-48 bg-indigo-500/10 rounded-full blur-3xl pointer-events-none" />
          <div className="absolute bottom-0 left-0 w-48 h-48 bg-indigo-600/5 rounded-full blur-3xl pointer-events-none" />

          {/* Header */}
          <div className="text-center space-y-2.5">
            <div className="mx-auto w-14 h-14 rounded-2xl bg-indigo-500/10 text-indigo-600 dark:text-indigo-400 flex items-center justify-center border border-indigo-500/20 shadow-inner">
              <Wallet className="h-6 w-6" />
            </div>
            <h2 className="text-2xl font-black tracking-tight text-slate-950 dark:text-white">
              Deposit to Wallet
            </h2>
          </div>

          {/* Wallet Balance Info Widget */}
          <div className="flex items-center justify-between p-4.5 rounded-2xl bg-indigo-50/40 dark:bg-indigo-950/20 border border-indigo-200 dark:border-indigo-900/30">
            <div className="space-y-0.5 text-left">
              <span className="text-[10px] font-extrabold text-indigo-700 dark:text-indigo-400 uppercase tracking-widest block">
                Current Balance
              </span>
              <span className="text-lg font-black text-slate-900 dark:text-white leading-none">
                {formatVND(user?.balance ?? 0)}
              </span>
            </div>
            <div className="p-2 bg-indigo-500 text-white rounded-xl shadow-md shadow-indigo-500/15">
              <ShieldCheck className="h-5 w-5" />
            </div>
          </div>

          {/* Amount Selection */}
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <label className="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider block">
                Select Deposit Amount:
              </label>
              <span className="text-[10px] font-black text-indigo-600 dark:text-indigo-400 uppercase tracking-wider flex items-center space-x-1">
                <Sparkles className="h-3 w-3" />
                <span>Instant Payment</span>
              </span>
            </div>
            
            <div className="grid grid-cols-2 gap-3">
              {[50000, 100000, 200000, 500000].map((amount) => (
                <button
                  key={amount}
                  type="button"
                  onClick={() => {
                    setDepositAmount(amount);
                    setCustomAmountText(amount.toString());
                  }}
                  className={`py-3 px-4 border rounded-2xl text-sm font-extrabold transition-all relative ${
                    depositAmount === amount
                      ? 'bg-indigo-600 text-white border-indigo-600 shadow-md shadow-indigo-600/15 scale-[1.02]'
                      : 'bg-white dark:bg-slate-800 border-slate-200 dark:border-slate-800 text-slate-700 dark:text-slate-300 hover:bg-slate-50 hover:border-slate-300 dark:hover:bg-slate-800'
                  }`}
                >
                  {formatVND(amount)}
                </button>
              ))}
            </div>
          </div>

          {/* Custom Amount */}
          <div className="space-y-2">
            <label className="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider block text-left">
              Or enter custom amount (VND):
            </label>
            <div className="relative">
              <input
                type="text"
                placeholder="Example: 150000"
                value={customAmountText}
                onChange={(e) => {
                  const cleanVal = e.target.value.replace(/[^0-9]/g, '');
                  setCustomAmountText(cleanVal);
                  if (cleanVal) {
                    setDepositAmount(Number(cleanVal));
                  } else {
                    setDepositAmount(10000); // Default to minimum
                  }
                }}
                className="w-full pl-5 pr-12 py-3.5 rounded-2xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-extrabold"
              />
              <span className="absolute right-4 top-1/2 -translate-y-1/2 text-xs font-bold text-slate-400 dark:text-slate-500">
                VND
              </span>
            </div>
            <div className="flex items-center space-x-1 text-[10px] text-slate-400 dark:text-slate-500 font-semibold italic">
              <span>* Minimum deposit is 10,000 VND via PayOS gateway.</span>
            </div>
          </div>

          {/* Confirm Button */}
          <div className="pt-2">
            <button
              type="button"
              onClick={handleDeposit}
              disabled={isCreatingLink || depositAmount < 10000}
              className="w-full py-4 bg-indigo-600 hover:bg-indigo-700 disabled:opacity-50 text-white rounded-2xl text-sm font-extrabold shadow-lg shadow-indigo-600/20 hover:shadow-indigo-600/30 transition-all flex items-center justify-center space-x-2 active:scale-[0.99]"
            >
              {isCreatingLink ? (
                <>
                  <Loader2 className="h-5 w-5 animate-spin" />
                  <span>Generating Secure Link...</span>
                </>
              ) : (
                <>
                  <span>Proceed to Deposit</span>
                  <span className="font-bold opacity-90">({formatVND(depositAmount)})</span>
                </>
              )}
            </button>
          </div>

          {/* Secure Payment Note */}
          <div className="flex items-center justify-center space-x-1.5 text-[10px] font-bold text-slate-400 dark:text-slate-500 tracking-wide">
            <ShieldCheck className="h-4 w-4 text-emerald-505 shrink-0" />
            <span>Secure 256-bit encrypted checkout via PayOS</span>
          </div>

        </div>

      </div>
    </div>
  );
};

export default DepositPage;
