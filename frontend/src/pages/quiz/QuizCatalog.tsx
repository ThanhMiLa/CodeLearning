import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { QUIZZES } from '../../data/quizzesData';
import { Sparkles, Code2, FileSpreadsheet, ChevronRight, ShieldCheck, HelpCircle, ExternalLink } from 'lucide-react';

const QuizCatalog: React.FC = () => {
  const { t } = useTranslation();

  // Count total questions per subject (merged from all quiz modules)
  const hsfQuestions = QUIZZES.filter(q => q.id.includes('hsf302-module')).reduce((sum, q) => sum + q.questions.length, 0);
  const swrQuestions = QUIZZES.filter(q => q.id.includes('swr302-module')).reduce((sum, q) => sum + q.questions.length, 0);
  const swtQuestions = QUIZZES.filter(q => q.title.toUpperCase().includes('SWT301')).reduce((sum, q) => sum + q.questions.length, 0);

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-slate-950 py-12 px-4 sm:px-6 lg:px-8 transition-colors duration-200">
      {/* Decorative top lights */}
      <div className="absolute top-16 left-1/4 -translate-x-1/2 w-[500px] h-[300px] bg-indigo-500/10 dark:bg-indigo-500/5 rounded-full blur-[120px] pointer-events-none" />
      <div className="absolute top-32 right-1/4 translate-x-1/2 w-[400px] h-[250px] bg-purple-500/10 dark:bg-purple-500/5 rounded-full blur-[100px] pointer-events-none" />

      <div className="mx-auto max-w-[1200px] relative z-10">
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto mb-12">
          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-indigo-500/10 dark:bg-indigo-500/20 text-indigo-600 dark:text-indigo-400 text-xs font-bold uppercase tracking-wider mb-4 animate-pulse">
            <Sparkles className="h-3.5 w-3.5" />
            <span>Interactive Learning</span>
          </div>
          <h1 className="text-4xl sm:text-5xl font-extrabold text-slate-900 dark:text-white tracking-tight leading-none mb-4">
            {t('quiz.title', 'Source')}
          </h1>
        </div>

        {/* Subject Cards - navigate directly to merged quiz */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 lg:gap-8 max-w-6xl mx-auto pt-4">
          {/* HSF302 Subject Card */}
          <Link
            to="/quiz/hsf302"
            className="group relative rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-8 shadow-md hover:shadow-xl dark:shadow-none hover:border-indigo-500/30 dark:hover:border-indigo-500/30 hover:-translate-y-1 transition-all duration-300 text-left overflow-hidden flex flex-col justify-between min-h-[300px]"
          >
            <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-indigo-500 to-purple-500 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left" />
            <div className="absolute -right-16 -top-16 w-36 h-36 bg-indigo-500/5 dark:bg-indigo-500/[0.03] rounded-full blur-2xl group-hover:bg-indigo-500/10 transition-all duration-500" />
            <div>
              <div className="flex items-center justify-between mb-6">
                <div className="w-14 h-14 rounded-2xl bg-indigo-500/10 dark:bg-indigo-500/20 flex items-center justify-center text-indigo-600 dark:text-indigo-400 group-hover:scale-110 transition-transform duration-300">
                  <Code2 className="h-7 w-7" />
                </div>
                <span className="inline-flex items-center gap-1.5 text-xs font-bold px-3 py-1 rounded-full bg-indigo-500/10 dark:bg-indigo-500/20 text-indigo-600 dark:text-indigo-400">
                  <HelpCircle className="h-3 w-3" />
                  {hsfQuestions} questions
                </span>
              </div>
              <h2 className="text-3xl font-extrabold text-slate-900 dark:text-white mb-2 group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors duration-200">
                HSF302
              </h2>
              <p className="text-sm font-semibold text-slate-400 dark:text-slate-500 mb-4">
                {t('quiz.subject_hsf_title', 'Working with Spring Framework')}
              </p>
              <p className="text-sm text-slate-500 dark:text-slate-400 leading-relaxed mb-8">
                {t('quiz.subject_hsf_desc', 'Master enterprise Java applications with Spring Boot, JPA, REST APIs, and JavaFX desktop UI development.')}
              </p>
            </div>
            <div className="inline-flex items-center text-indigo-600 dark:text-indigo-400 font-bold text-sm">
              <span>{t('quiz.start_learning', 'Start Learning')}</span>
              <ChevronRight className="h-4 w-4 ml-1.5 group-hover:translate-x-1 transition-transform duration-200" />
            </div>
          </Link>

          {/* SWR302 Subject Card */}
          <Link
            to="/quiz/swr302"
            className="group relative rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-8 shadow-md hover:shadow-xl dark:shadow-none hover:border-purple-500/30 dark:hover:border-purple-500/30 hover:-translate-y-1 transition-all duration-300 text-left overflow-hidden flex flex-col justify-between min-h-[300px]"
          >
            <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-purple-500 to-pink-500 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left" />
            <div className="absolute -right-16 -top-16 w-36 h-36 bg-purple-500/5 dark:bg-purple-500/[0.03] rounded-full blur-2xl group-hover:bg-purple-500/10 transition-all duration-500" />
            <div>
              <div className="flex items-center justify-between mb-6">
                <div className="w-14 h-14 rounded-2xl bg-purple-500/10 dark:bg-purple-500/20 flex items-center justify-center text-purple-600 dark:text-purple-400 group-hover:scale-110 transition-transform duration-300">
                  <FileSpreadsheet className="h-7 w-7" />
                </div>
                <span className="inline-flex items-center gap-1.5 text-xs font-bold px-3 py-1 rounded-full bg-purple-500/10 dark:bg-purple-500/20 text-purple-600 dark:text-purple-400">
                  <HelpCircle className="h-3 w-3" />
                  {swrQuestions} questions
                </span>
              </div>
              <h2 className="text-3xl font-extrabold text-slate-900 dark:text-white mb-2 group-hover:text-purple-600 dark:group-hover:text-purple-400 transition-colors duration-200">
                SWR302
              </h2>
              <p className="text-sm font-semibold text-slate-400 dark:text-slate-500 mb-4">
                {t('quiz.subject_swr_title', 'Software Requirement')}
              </p>
              <p className="text-sm text-slate-500 dark:text-slate-400 leading-relaxed mb-8">
                {t('quiz.subject_swr_desc', 'Master software requirements elicitation, analysis, specification, validation, and requirements management techniques.')}
              </p>
            </div>
            <div className="inline-flex items-center text-purple-600 dark:text-purple-400 font-bold text-sm">
              <span>{t('quiz.start_learning', 'Start Learning')}</span>
              <ChevronRight className="h-4 w-4 ml-1.5 group-hover:translate-x-1 transition-transform duration-200" />
            </div>
          </Link>

          {/* SWT301 Subject Card */}
          <Link
            to="/quiz/swt301"
            className="group relative rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-8 shadow-md hover:shadow-xl dark:shadow-none hover:border-emerald-500/30 dark:hover:border-emerald-500/30 hover:-translate-y-1 transition-all duration-300 text-left overflow-hidden flex flex-col justify-between min-h-[300px]"
          >
            <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-emerald-500 to-teal-500 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left" />
            <div className="absolute -right-16 -top-16 w-36 h-36 bg-emerald-500/5 dark:bg-emerald-500/[0.03] rounded-full blur-2xl group-hover:bg-emerald-500/10 transition-all duration-500" />
            <div>
              <div className="flex items-center justify-between mb-6">
                <div className="w-14 h-14 rounded-2xl bg-emerald-500/10 dark:bg-emerald-500/20 flex items-center justify-center text-emerald-600 dark:text-emerald-400 group-hover:scale-110 transition-transform duration-300">
                  <ShieldCheck className="h-7 w-7" />
                </div>
                <span className="inline-flex items-center gap-1.5 text-xs font-bold px-3 py-1 rounded-full bg-emerald-500/10 dark:bg-emerald-500/20 text-emerald-600 dark:text-emerald-400">
                  <HelpCircle className="h-3 w-3" />
                  {swtQuestions} questions
                </span>
              </div>
              <h2 className="text-3xl font-extrabold text-slate-900 dark:text-white mb-2 group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition-colors duration-200">
                SWT301
              </h2>
              <p className="text-sm font-semibold text-slate-400 dark:text-slate-500 mb-4">
                {t('quiz.subject_swt_title', 'Software Testing')}
              </p>
              <p className="text-sm text-slate-500 dark:text-slate-400 leading-relaxed mb-8">
                {t('quiz.subject_swt_desc', 'Master software testing methods, test design techniques, static and dynamic testing processes according to ISTQB standards.')}
              </p>
            </div>
            <div className="inline-flex items-center text-emerald-600 dark:text-emerald-400 font-bold text-sm">
              <span>{t('quiz.start_learning', 'Start Learning')}</span>
              <ChevronRight className="h-4 w-4 ml-1.5 group-hover:translate-x-1 transition-transform duration-200" />
            </div>
          </Link>
        </div>

        {/* Moving red banner note */}
        <div className="mt-14 text-center overflow-hidden py-4">
          <div className="inline-block animate-move-side">
            <p className="text-rose-500 dark:text-rose-400 font-bold text-base sm:text-lg flex items-center justify-center gap-2 drop-shadow-sm">
              <span>Source PE HSF302:</span>
              <a 
                href="https://github.com/ThanhMiLa/source-hsf-pe" 
                target="_blank" 
                rel="noopener noreferrer"
                className="underline hover:text-rose-600 dark:hover:text-rose-300 transition-colors inline-flex items-center gap-1"
              >
                https://github.com/ThanhMiLa/source-hsf-pe
                <ExternalLink className="h-4 w-4" />
              </a>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default QuizCatalog;
