import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { QUIZZES } from '../../data/quizzesData';
import { HelpCircle, CheckSquare, Sparkles, ArrowRight, BookOpenCheck, ArrowLeft, Code2, FileSpreadsheet, ChevronRight } from 'lucide-react';

const QuizCatalog: React.FC = () => {
  const { t } = useTranslation();
  const [selectedSubject, setSelectedSubject] = useState<'HSF302' | 'SWR302' | null>(null);

  // Group and filter quizzes dynamically
  const hsfQuizzes = QUIZZES.filter(q => q.title.toUpperCase().includes('HSF302'));
  const swrQuizzes = QUIZZES.filter(q => q.title.toUpperCase().includes('SWR302'));

  const hsfCount = hsfQuizzes.length;
  const swrCount = swrQuizzes.length;

  const headerTitle = selectedSubject 
    ? (selectedSubject === 'HSF302' ? 'HSF302' : 'SWR302') 
    : t('quiz.title', 'Source');

  const headerSubtitle = selectedSubject
    ? (selectedSubject === 'HSF302' 
        ? t('quiz.subject_hsf_title', 'Working with Spring Framework') 
        : t('quiz.subject_swr_title', 'Software Requirement'))
    : t('quiz.subtitle', '');

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
            {headerTitle}
          </h1>
          {headerSubtitle && (
            <p className="text-lg text-slate-600 dark:text-slate-400 font-medium">
              {headerSubtitle}
            </p>
          )}
        </div>

        {selectedSubject === null ? (
          /* Subject Selector View */
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-10 max-w-4xl mx-auto pt-4">
            {/* HSF302 Subject Card */}
            <button
              onClick={() => setSelectedSubject('HSF302')}
              className="group relative rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-8 shadow-md hover:shadow-xl dark:shadow-none hover:border-indigo-500/30 dark:hover:border-indigo-500/30 hover:-translate-y-1 transition-all duration-300 text-left overflow-hidden flex flex-col justify-between min-h-[300px]"
            >
              <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-indigo-500 to-purple-500 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left" />
              <div className="absolute -right-16 -top-16 w-36 h-36 bg-indigo-500/5 dark:bg-indigo-500/[0.03] rounded-full blur-2xl group-hover:bg-indigo-500/10 transition-all duration-500" />
              <div>
                <div className="flex items-center justify-between mb-6">
                  <div className="w-14 h-14 rounded-2xl bg-indigo-500/10 dark:bg-indigo-500/20 flex items-center justify-center text-indigo-600 dark:text-indigo-400 group-hover:scale-110 transition-transform duration-300">
                    <Code2 className="h-7 w-7" />
                  </div>
                  <span className="text-xs font-bold px-3 py-1 rounded-full bg-indigo-500/10 dark:bg-indigo-500/20 text-indigo-600 dark:text-indigo-400">
                    {t('quiz.quizzes_count', { count: hsfCount, defaultValue: `${hsfCount} quiz sets` })}
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
            </button>

            {/* SWR302 Subject Card */}
            <button
              onClick={() => setSelectedSubject('SWR302')}
              className="group relative rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-8 shadow-md hover:shadow-xl dark:shadow-none hover:border-purple-500/30 dark:hover:border-purple-500/30 hover:-translate-y-1 transition-all duration-300 text-left overflow-hidden flex flex-col justify-between min-h-[300px]"
            >
              <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-purple-500 to-pink-500 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left" />
              <div className="absolute -right-16 -top-16 w-36 h-36 bg-purple-500/5 dark:bg-purple-500/[0.03] rounded-full blur-2xl group-hover:bg-purple-500/10 transition-all duration-500" />
              <div>
                <div className="flex items-center justify-between mb-6">
                  <div className="w-14 h-14 rounded-2xl bg-purple-500/10 dark:bg-purple-500/20 flex items-center justify-center text-purple-600 dark:text-purple-400 group-hover:scale-110 transition-transform duration-300">
                    <FileSpreadsheet className="h-7 w-7" />
                  </div>
                  <span className="text-xs font-bold px-3 py-1 rounded-full bg-purple-500/10 dark:bg-purple-500/20 text-purple-600 dark:text-purple-400">
                    {t('quiz.quizzes_count', { count: swrCount, defaultValue: `${swrCount} quiz sets` })}
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
            </button>
          </div>
        ) : (
          /* Specific Subject Quiz List View */
          <>
            {/* Back Button */}
            <div className="mb-8 flex justify-start">
              <button
                onClick={() => setSelectedSubject(null)}
                className="inline-flex items-center space-x-2 px-4 py-2 rounded-2xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-indigo-600 dark:hover:text-indigo-400 hover:border-indigo-500/30 transition-all duration-200 shadow-sm"
              >
                <ArrowLeft className="h-4 w-4" />
                <span>{t('quiz.back_to_subjects', 'Back to Subjects')}</span>
              </button>
            </div>

            {/* Quiz Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-10">
              {(selectedSubject === 'HSF302' ? hsfQuizzes : swrQuizzes).map((quiz) => (
                <div
                  key={quiz.id}
                  className="group relative rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-8 shadow-md hover:shadow-xl dark:shadow-none hover:border-indigo-500/30 dark:hover:border-indigo-500/30 hover:-translate-y-1 transition-all duration-300 flex flex-col justify-between overflow-hidden"
                >
                  {/* Card top gradient accent */}
                  <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-indigo-500 via-purple-500 to-indigo-500 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left" />
                  
                  {/* Decorative background glow */}
                  <div className="absolute -right-16 -top-16 w-36 h-36 bg-indigo-500/5 dark:bg-indigo-500/[0.03] rounded-full blur-2xl group-hover:bg-indigo-500/10 dark:group-hover:bg-indigo-500/5 transition-all duration-500" />

                  <div>
                    {/* Icon & Title */}
                    <div className="flex items-center justify-between mb-6">
                      <div className="w-12 h-12 rounded-2xl bg-indigo-500/10 dark:bg-indigo-500/20 flex items-center justify-center text-indigo-600 dark:text-indigo-400 group-hover:scale-110 transition-transform duration-300">
                        <BookOpenCheck className="h-6 w-6" />
                      </div>
                      <span className="text-[10px] font-extrabold uppercase tracking-widest px-2.5 py-1 rounded-md bg-slate-100 dark:bg-slate-800 text-slate-500 dark:text-slate-400">
                        Active
                      </span>
                    </div>

                    <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-3 group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors duration-200">
                      {quiz.title}
                    </h2>
                    
                    <p className="text-sm text-slate-500 dark:text-slate-400 leading-relaxed mb-6">
                      {quiz.description}
                    </p>

                    {/* Stats */}
                    <div className="grid grid-cols-2 gap-4 border-t border-slate-100 dark:border-slate-800/80 pt-6 mb-8">
                      <div className="flex items-center space-x-2.5">
                        <HelpCircle className="h-4.5 w-4.5 text-slate-400 shrink-0" />
                        <div>
                          <span className="text-xs font-semibold text-slate-400 dark:text-slate-500 block leading-tight">Questions</span>
                          <span className="text-sm font-bold text-slate-700 dark:text-slate-300">
                            {t('quiz.question_count', { count: quiz.questionsCount, defaultValue: `${quiz.questionsCount} questions` })}
                          </span>
                        </div>
                      </div>

                      <div className="flex items-center space-x-2.5">
                        <CheckSquare className="h-4.5 w-4.5 text-slate-400 shrink-0" />
                        <div>
                          <span className="text-xs font-semibold text-slate-400 dark:text-slate-500 block leading-tight">Time Estimate</span>
                          <span className="text-sm font-bold text-slate-700 dark:text-slate-300">
                            {t('quiz.minutes_count', { count: quiz.questionsCount, defaultValue: `${quiz.questionsCount} mins` })}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>

                  {/* Action Button */}
                  <Link
                    to={`/quiz/${quiz.id}`}
                    className="w-full inline-flex items-center justify-center rounded-2xl bg-slate-900 dark:bg-slate-800 text-white font-bold text-sm py-4 px-6 hover:bg-indigo-600 dark:hover:bg-indigo-600 shadow-md hover:shadow-indigo-500/20 active:scale-98 transition-all group/btn"
                  >
                    <span>{t('quiz.start_learning', 'Start Learning')}</span>
                    <ArrowRight className="h-4 w-4 ml-2 group-hover/btn:translate-x-1.5 transition-transform duration-200" />
                  </Link>
                </div>
              ))}
            </div>
          </>
        )}
      </div>
    </div>
  );
};
export default QuizCatalog;
