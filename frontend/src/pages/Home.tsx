import React from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Code, Trophy, ArrowRight, Cpu } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { useTranslation } from 'react-i18next';

const Home: React.FC = () => {
  const { isAuthenticated } = useAuth();
  const { t } = useTranslation();

  return (
    <div className="flex flex-col items-center justify-center overflow-hidden">
      {/* Hero Section */}
      <section className="relative w-full py-20 md:py-32 bg-gradient-to-b from-indigo-50/70 to-white dark:from-slate-900/40 dark:to-slate-950 flex flex-col items-center justify-center text-center px-4">
        {/* Background Decorative Blob */}
        <div className="absolute top-1/4 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[500px] h-[500px] bg-indigo-500/10 dark:bg-indigo-500/5 rounded-full blur-3xl pointer-events-none -z-10" />

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="max-w-4xl mx-auto"
        >
          <div className="inline-flex items-center space-x-2 px-3.5 py-1.5 rounded-full bg-indigo-50 dark:bg-indigo-950/50 border border-indigo-100/80 dark:border-indigo-900/30 text-xs font-semibold text-indigo-600 dark:text-indigo-400 mb-6 uppercase tracking-wider">
            <Cpu className="h-3.5 w-3.5" />
            <span>{t('home.hero_badge')}</span>
          </div>

          <h1 className="text-4xl sm:text-5xl md:text-6xl font-bold tracking-tight text-slate-900 dark:text-white leading-[1.15]">
            {t('home.hero_title_1')} <br />
            <span className="bg-gradient-to-r from-indigo-600 to-violet-500 bg-clip-text text-transparent">
              {t('home.hero_title_2')}
            </span>
          </h1>

          <p className="mt-6 text-base sm:text-lg md:text-xl text-slate-600 dark:text-slate-300 max-w-2xl mx-auto leading-relaxed">
            {t('home.hero_desc')}
          </p>

          <div className="mt-10 flex flex-wrap justify-center gap-4">
            <Link
              to="/oj/practice"
              className="inline-flex items-center justify-center rounded-full bg-indigo-600 px-6 py-3.5 text-base font-semibold text-white hover:bg-indigo-700 shadow-lg shadow-indigo-500/20 hover:shadow-indigo-500/35 transition-all hover:-translate-y-0.5 active:scale-95 duration-150 group"
            >
              <span>{t('home.btn_get_started')}</span>
              <ArrowRight className="ml-2 h-4 w-4 transition-transform group-hover:translate-x-1" />
            </Link>
            {!isAuthenticated && (
              <Link
                to="/register"
                className="inline-flex items-center justify-center rounded-full border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 px-6 py-3.5 text-base font-semibold text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800/60 transition-all hover:-translate-y-0.5 active:scale-95 duration-150"
              >
                {t('home.btn_create_account')}
              </Link>
            )}
          </div>
        </motion.div>
      </section>

      {/* Feature Section */}
      <section className="w-full py-16 sm:py-24 px-4 bg-slate-50 dark:bg-slate-950">
        <div className="max-w-7xl mx-auto">
          <div className="text-center max-w-3xl mx-auto mb-16">
            <h2 className="text-3xl font-bold tracking-tight text-slate-900 dark:text-white sm:text-4xl">
              {t('home.features_title')}
            </h2>
            <p className="mt-4 text-slate-600 dark:text-slate-300">
              {t('home.features_desc')}
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-4xl mx-auto">
            {/* Feature 1 */}
            <motion.div
              whileHover={{ y: -6 }}
              transition={{ duration: 0.2 }}
              className="p-8 rounded-2xl border border-slate-200 dark:border-slate-900 bg-white dark:bg-slate-900/30 shadow-sm hover:shadow-md transition-shadow flex flex-col items-start text-left"
            >
              <div className="h-12 w-12 rounded-xl bg-indigo-500/10 text-indigo-600 dark:text-indigo-400 flex items-center justify-center mb-6">
                <Code className="h-6 w-6" />
              </div>
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-3">{t('home.feature_oj_title')}</h3>
              <p className="text-slate-600 dark:text-slate-400 text-sm leading-relaxed mb-4">
                {t('home.feature_oj_desc')}
              </p>
              <Link to="/oj/practice" className="text-indigo-600 dark:text-indigo-400 font-semibold text-sm hover:underline inline-flex items-center group">
                {t('home.btn_practice')} <ArrowRight className="ml-1 h-3.5 w-3.5 transition-transform group-hover:translate-x-0.5" />
              </Link>
            </motion.div>

            {/* Feature 2 */}
            <motion.div
              whileHover={{ y: -6 }}
              transition={{ duration: 0.2 }}
              className="p-8 rounded-2xl border border-slate-200 dark:border-slate-900 bg-white dark:bg-slate-900/30 shadow-sm hover:shadow-md transition-shadow flex flex-col items-start text-left"
            >
              <div className="h-12 w-12 rounded-xl bg-indigo-500/10 text-indigo-600 dark:text-indigo-400 flex items-center justify-center mb-6">
                <Trophy className="h-6 w-6" />
              </div>
              <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-3">{t('home.feature_contest_title')}</h3>
              <p className="text-slate-600 dark:text-slate-400 text-sm leading-relaxed mb-4">
                {t('home.feature_contest_desc')}
              </p>
              <Link to="/contests" className="text-indigo-600 dark:text-indigo-400 font-semibold text-sm hover:underline inline-flex items-center group">
                {t('home.btn_view_contests')} <ArrowRight className="ml-1 h-3.5 w-3.5 transition-transform group-hover:translate-x-0.5" />
              </Link>
            </motion.div>
          </div>
        </div>
      </section>

      {/* Stats Section */}
      <section className="w-full py-16 px-4 bg-slate-50 dark:bg-slate-900/20 border-y border-slate-200 dark:border-slate-900">
        <div className="max-w-7xl mx-auto grid grid-cols-1 sm:grid-cols-3 gap-8 max-w-5xl mx-auto">
          <div className="text-center">
            <div className="text-3xl sm:text-4xl font-extrabold text-indigo-600 dark:text-indigo-400">10,000+</div>
            <div className="mt-2 text-sm text-slate-500 dark:text-slate-400 font-medium">{t('home.stat_students')}</div>
          </div>
          <div className="text-center">
            <div className="text-3xl sm:text-4xl font-extrabold text-indigo-600 dark:text-indigo-400">1,000+</div>
            <div className="mt-2 text-sm text-slate-500 dark:text-slate-400 font-medium">{t('home.stat_problems')}</div>
          </div>
          <div className="text-center">
            <div className="text-3xl sm:text-4xl font-extrabold text-indigo-600 dark:text-indigo-400">500,000+</div>
            <div className="mt-2 text-sm text-slate-500 dark:text-slate-400 font-medium">{t('home.stat_submissions')}</div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default Home;
