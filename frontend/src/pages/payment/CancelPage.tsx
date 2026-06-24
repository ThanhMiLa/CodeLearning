import React from 'react';
import { useNavigate, Link, useSearchParams } from 'react-router-dom';
import { XCircle, ArrowRight, Heart } from 'lucide-react';
import { useTranslation } from 'react-i18next';

const CancelPage: React.FC = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [searchParams] = useSearchParams();

  const orderCode = searchParams.get('orderCode') || searchParams.get('transactionCode') || 'N/A';

  return (
    <div className="mx-auto max-w-md text-center py-20 px-4 min-h-[75vh] flex flex-col justify-center items-center">
      {/* Animated Glowing Error Circle */}
      <div className="relative mb-6">
        <div className="absolute inset-0 bg-rose-500/20 rounded-full blur-xl animate-pulse"></div>
        <div className="relative h-20 w-20 rounded-full bg-rose-500/10 border border-rose-500/20 text-rose-500 flex items-center justify-center">
          <XCircle className="h-10 w-10 animate-bounce" />
        </div>
      </div>

      {/* Title */}
      <h2 className="text-2xl font-black text-slate-900 dark:text-white tracking-tight mb-2">
        {t('donate.cancel_title')}
      </h2>
      <p className="text-sm text-slate-500 dark:text-slate-400 max-w-sm mb-6 leading-relaxed">
        {t('donate.cancel_desc')}
      </p>

      {/* Transaction Details Box */}
      <div className="w-full bg-white dark:bg-slate-900 border border-slate-300 dark:border-slate-800/80 rounded-2xl p-5 mb-8 text-left space-y-3 shadow-sm select-all">
        <div className="flex justify-between text-xs font-semibold">
          <span className="text-slate-400">{t('donate.transaction_id')}</span>
          <span className="text-slate-800 dark:text-white font-mono">{orderCode}</span>
        </div>
        <div className="flex justify-between text-xs font-semibold">
          <span className="text-slate-400">{t('donate.status')}</span>
          <span className="text-rose-600 dark:text-rose-400 font-bold">
            {t('donate.cancel_status')}
          </span>
        </div>
      </div>

      {/* Action buttons */}
      <div className="flex flex-col sm:flex-row gap-3 w-full">
        <button
          onClick={() => navigate('/deposit')}
          className="flex-1 inline-flex items-center justify-center space-x-1.5 px-5 py-3 bg-rose-600 hover:bg-rose-700 text-white rounded-xl text-xs font-bold shadow-md shadow-rose-600/10 hover:shadow-rose-600/25 transition-all active:scale-95 cursor-pointer"
        >
          <Heart className="h-4 w-4" />
          <span>{t('donate.button_retry')}</span>
          <ArrowRight className="h-3.5 w-3.5" />
        </button>
        <Link
          to="/"
          className="flex-1 inline-flex items-center justify-center px-5 py-3 border border-slate-200 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-bold text-slate-600 dark:text-slate-300 rounded-xl transition-colors"
        >
          {t('donate.back_home')}
        </Link>
      </div>

    </div>
  );
};

export default CancelPage;
