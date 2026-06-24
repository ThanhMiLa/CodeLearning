import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Heart, Loader2, ArrowLeft, Sparkles } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import type { ApiResponse, PaymentDepositResponse } from '../../types';

const DepositPage: React.FC = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [depositAmount, setDepositAmount] = useState<number>(50000);
  const [customAmountText, setCustomAmountText] = useState<string>('');
  const [isCreatingLink, setIsCreatingLink] = useState(false);

  const formatVND = (amount: number) => {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
  };

  const handleDeposit = async () => {
    if (depositAmount < 10000 || isCreatingLink) {
      alert('Minimum donation is 10,000 VND.');
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
      console.error('Donation failed:', err);
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
            className="flex items-center space-x-2 text-xs font-bold text-slate-500 hover:text-rose-600 dark:hover:text-rose-400 transition-colors cursor-pointer group"
          >
            <ArrowLeft className="h-4 w-4 transition-transform group-hover:-translate-x-1" />
            <span>{t('donate.back_home')}</span>
          </button>
        </div>

        {/* Content Card */}
        <div className="bg-white dark:bg-slate-900 border border-slate-300 dark:border-slate-800 rounded-3xl p-6 md:p-10 shadow-xl space-y-8 relative overflow-hidden select-none">
          {/* Accent Glow decoration */}
          <div className="absolute top-0 right-0 w-48 h-48 bg-rose-500/10 rounded-full blur-3xl pointer-events-none" />
          <div className="absolute bottom-0 left-0 w-48 h-48 bg-rose-600/5 rounded-full blur-3xl pointer-events-none" />

          {/* Header */}
          <div className="text-center space-y-4">
            <div className="mx-auto w-16 h-16 rounded-2xl bg-rose-500/10 text-rose-600 dark:text-rose-400 flex items-center justify-center border border-rose-500/20 shadow-inner">
              <Heart className="h-8 w-8 fill-rose-500 animate-pulse" />
            </div>
            <div className="space-y-2">
              <h2 className="text-3xl font-black tracking-tight text-slate-950 dark:text-white">
                {t('donate.title')}
              </h2>
              <p className="text-xs text-slate-500 dark:text-slate-400 max-w-md mx-auto leading-relaxed">
                {t('donate.subtitle')}
              </p>
            </div>
          </div>

          {/* Amount Selection */}
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <label className="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider block">
                {t('donate.select_amount')}
              </label>
              <span className="text-[10px] font-black text-rose-600 dark:text-rose-400 uppercase tracking-wider flex items-center space-x-1">
                <Sparkles className="h-3 w-3 animate-pulse" />
                <span>Instant Payment</span>
              </span>
            </div>
            
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
              {[20000, 50000, 100000, 200000, 500000].map((amount) => (
                <button
                  key={amount}
                  type="button"
                  onClick={() => {
                    setDepositAmount(amount);
                    setCustomAmountText(amount.toString());
                  }}
                  className={`py-3 px-4 border rounded-2xl text-sm font-extrabold transition-all relative ${
                    depositAmount === amount
                      ? 'bg-rose-650 bg-rose-600 text-white border-rose-600 shadow-md shadow-rose-600/15 scale-[1.02]'
                      : 'bg-white dark:bg-slate-800 border-slate-200 dark:border-slate-800 text-slate-700 dark:text-slate-300 hover:bg-slate-50 hover:border-slate-350 dark:hover:bg-slate-800'
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
              {t('donate.custom_amount')}
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
                className="w-full pl-5 pr-12 py-3.5 rounded-2xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-rose-500/20 focus:border-rose-500 transition-all dark:text-white font-extrabold"
              />
              <span className="absolute right-4 top-1/2 -translate-y-1/2 text-xs font-bold text-slate-400 dark:text-slate-500">
                VND
              </span>
            </div>
            <div className="flex items-center space-x-1 text-[10px] text-slate-400 dark:text-slate-500 font-semibold italic">
              <span>{t('donate.min_amount')}</span>
            </div>
          </div>

          {/* Confirm Button */}
          <div className="pt-2">
            <button
              type="button"
              onClick={handleDeposit}
              disabled={isCreatingLink || depositAmount < 10000}
              className="w-full py-4 bg-rose-600 hover:bg-rose-700 disabled:opacity-50 text-white rounded-2xl text-sm font-extrabold shadow-lg shadow-rose-600/20 hover:shadow-rose-600/30 transition-all flex items-center justify-center space-x-2 active:scale-[0.99] cursor-pointer"
            >
              {isCreatingLink ? (
                <>
                  <Loader2 className="h-5 w-5 animate-spin" />
                  <span>{t('donate.button_loading')}</span>
                </>
              ) : (
                <>
                  <span>{t('donate.button_submit')}</span>
                  <span className="font-bold opacity-90">({formatVND(depositAmount)})</span>
                </>
              )}
            </button>
          </div>



        </div>

      </div>
    </div>
  );
};

export default DepositPage;
