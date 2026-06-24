import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Search, Trophy, CheckCircle, Code, HelpCircle, ArrowLeft, ArrowRight } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import api from '../../api/axios';
import type { ApiResponse, PageResponse, OjPracticeProblemResponse } from '../../types';

const PracticeCatalog: React.FC = () => {
  const { t } = useTranslation();
  const [problems, setProblems] = useState<OjPracticeProblemResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [difficulty, setDifficulty] = useState<string>('ALL');
  const [status, setStatus] = useState<string>('ALL');
  
  // Pagination
  const [page, setPage] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [totalElements, setTotalElements] = useState(0);
  const pageSize = 20;

  const fetchProblems = async () => {
    setLoading(true);
    try {
      const params: any = {
        page: page,
        size: pageSize,
        sortBy: 'totalSubmissions',
        order: 'desc'
      };

      if (search.trim()) {
        params.keyword = search.trim();
      }

      if (difficulty !== 'ALL') {
        params.difficulties = difficulty; // e.g. "EASY", "MEDIUM", "HARD"
      }

      if (status === 'SOLVED') {
        params.isAccepted = true;
      } else if (status === 'UNSOLVED') {
        params.isAccepted = false;
      }

      const res = await api.get<ApiResponse<PageResponse<OjPracticeProblemResponse>>>(
        '/online-judge/problems/practice',
        { params }
      );
      
      const data = res.data.result;
      setProblems(data.content || []);
      setTotalPages(data.totalPages);
      setTotalElements(data.totalElements);
    } catch (error) {
      console.error('Failed to fetch practice problems:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchProblems();
  }, [page, difficulty, status]);

  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(0);
    fetchProblems();
  };

  const getDifficultyColor = (diff: string) => {
    switch (diff) {
      case 'EASY':
        return 'text-emerald-600 bg-emerald-50 border-emerald-100 dark:text-emerald-400 dark:bg-emerald-950/30 dark:border-emerald-900/40';
      case 'MEDIUM':
        return 'text-amber-600 bg-amber-50 border-amber-100 dark:text-amber-400 dark:bg-amber-950/30 dark:border-amber-900/40';
      case 'HARD':
        return 'text-rose-600 bg-rose-50 border-rose-100 dark:text-rose-400 dark:bg-rose-950/30 dark:border-rose-900/40';
      default:
        return 'text-slate-600 bg-slate-50 border-slate-200';
    }
  };

  const getDifficultyLabel = (diff: string) => {
    switch (diff) {
      case 'EASY':
        return t('practice.easy');
      case 'MEDIUM':
        return t('practice.medium');
      case 'HARD':
        return t('practice.hard');
      default:
        return diff;
    }
  };

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-8 sm:px-6 lg:px-8 text-left min-h-screen">
      {/* Header Banner */}
      <div className="relative rounded-3xl overflow-hidden bg-gradient-to-r from-slate-900 via-indigo-950 to-purple-950 text-white p-8 md:p-12 shadow-xl mb-8 border border-indigo-900/20">
        <div className="absolute top-0 right-0 w-96 h-96 bg-indigo-500/10 rounded-full blur-3xl -mr-16 -mt-16 pointer-events-none"></div>
        <div className="relative z-10 space-y-4 max-w-2xl">
          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-indigo-500/20 text-indigo-300 border border-indigo-500/30 text-xs font-bold uppercase tracking-wider">
            <Trophy className="h-3.5 w-3.5" />
            <span>{t('practice.badge')}</span>
          </div>
          <h1 className="text-3xl md:text-4xl font-extrabold tracking-tight">
            {t('practice.title')}
          </h1>
          <p className="text-sm md:text-base text-slate-300 leading-relaxed font-normal">
            {t('practice.desc')}
          </p>
        </div>
      </div>

      {/* Filter and Search Section */}
      <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800/60 p-5 shadow-sm mb-6 space-y-4">
        <form onSubmit={handleSearchSubmit} className="grid grid-cols-1 md:grid-cols-4 gap-4">
          {/* Search Input */}
          <div className="md:col-span-2 relative">
            <input
              type="text"
              placeholder={t('practice.search_placeholder')}
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white"
            />
            <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
          </div>

          {/* Difficulty filter */}
          <div>
            <select
              value={difficulty}
              onChange={(e) => {
                setDifficulty(e.target.value);
                setPage(0);
              }}
              className="w-full px-3 py-2.5 rounded-xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white"
            >
              <option value="ALL">{t('practice.diff_all')}</option>
              <option value="EASY">{t('practice.diff_easy')}</option>
              <option value="MEDIUM">{t('practice.diff_medium')}</option>
              <option value="HARD">{t('practice.diff_hard')}</option>
            </select>
          </div>

          {/* Status filter */}
          <div>
            <select
              value={status}
              onChange={(e) => {
                setStatus(e.target.value);
                setPage(0);
              }}
              className="w-full px-3 py-2.5 rounded-xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white"
            >
              <option value="ALL">{t('practice.status_all')}</option>
              <option value="SOLVED">{t('practice.status_solved')}</option>
              <option value="UNSOLVED">{t('practice.status_unsolved')}</option>
            </select>
          </div>
        </form>
      </div>

      {/* Main Problems Table or List */}
      <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800/60 shadow-sm overflow-hidden mb-6">
        {loading ? (
          <div className="p-12 space-y-4">
            {[1, 2, 3, 4, 5].map(i => (
              <div key={i} className="animate-pulse flex items-center justify-between py-3 border-b border-slate-200 dark:border-slate-800 last:border-0">
                <div className="space-y-2 flex-grow pr-6">
                  <div className="h-5 bg-slate-200 dark:bg-slate-800 rounded w-1/3"></div>
                  <div className="h-3 bg-slate-100 dark:bg-slate-800 rounded w-1/4"></div>
                </div>
                <div className="h-8 bg-slate-200 dark:bg-slate-800 rounded w-20"></div>
              </div>
            ))}
          </div>
        ) : problems.length === 0 ? (
          <div className="text-center py-16 text-slate-500 dark:text-slate-400">
            <HelpCircle className="h-12 w-12 mx-auto opacity-30 mb-3" />
            <p className="font-bold text-sm">{t('practice.no_problems')}</p>
            <p className="text-xs mt-1 text-slate-400">{t('practice.change_filters')}</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full min-w-[600px] border-collapse text-sm">
              <thead>
                <tr className="border-b border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/20 text-slate-400 dark:text-slate-400 font-bold uppercase tracking-wider text-[10px] text-left">
                  <th className="px-6 py-4 w-12"></th>
                  <th className="px-6 py-4 w-[40%] max-w-[40%] whitespace-nowrap">{t('practice.th_name')}</th>
                  <th className="px-6 py-4 w-32 whitespace-nowrap">{t('practice.th_difficulty')}</th>
                  <th className="px-6 py-4 w-40 whitespace-nowrap">{t('practice.th_acceptance')}</th>
                  <th className="px-6 py-4 w-40 whitespace-nowrap">{t('practice.th_submissions')}</th>
                  <th className="px-6 py-4 w-28 whitespace-nowrap"></th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-200 dark:divide-slate-800">
                {problems.map((problem) => (
                  <tr key={problem.id} className="hover:bg-slate-100/70 dark:hover:bg-slate-800/10 transition-colors">
                    {/* Status Tick */}
                    <td className="px-6 py-4 text-center">
                      {problem.isAccepted ? (
                        <CheckCircle className="h-5 w-5 text-emerald-500 shrink-0" />
                      ) : (
                        <HelpCircle className="h-5 w-5 text-slate-300 dark:text-slate-700 shrink-0" />
                      )}
                    </td>

                    {/* Title */}
                    <td className="px-6 py-4 w-[40%] max-w-[40%] truncate">
                      <Link 
                        to={`/oj/problems/${problem.id}`}
                        className="font-bold text-slate-800 dark:text-white hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors text-sm block truncate"
                        title={problem.title}
                      >
                        {problem.title}
                      </Link>
                    </td>

                    {/* Difficulty */}
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`inline-flex px-2.5 py-0.5 rounded-full text-xs font-bold border ${getDifficultyColor(problem.difficulty)}`}>
                        {getDifficultyLabel(problem.difficulty)}
                      </span>
                    </td>

                    {/* Acceptance Rate */}
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center space-x-2">
                        <span className="font-semibold text-slate-700 dark:text-slate-300 text-xs">
                          {problem.acceptanceRate.toFixed(1)}%
                        </span>
                        <div className="w-16 bg-slate-100 dark:bg-slate-800 h-1.5 rounded-full overflow-hidden hidden sm:block">
                          <div 
                            className="bg-indigo-600 dark:bg-indigo-400 h-full"
                            style={{ width: `${problem.acceptanceRate}%` }}
                          />
                        </div>
                      </div>
                    </td>

                    {/* Submissions count */}
                    <td className="px-6 py-4 text-xs font-medium text-slate-500 dark:text-slate-400 whitespace-nowrap">
                      {problem.totalSubmissions} {t('practice.subs_suffix')}
                    </td>

                    {/* Action */}
                    <td className="px-6 py-4 text-right whitespace-nowrap">
                      <Link
                        to={`/oj/problems/${problem.id}`}
                        className="inline-flex items-center space-x-1 px-3 py-1.5 bg-indigo-50 hover:bg-indigo-100 dark:bg-indigo-950/30 dark:hover:bg-indigo-950/55 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/20 rounded-xl text-xs font-bold transition-all active:scale-95 shadow-sm"
                      >
                        <Code className="h-3.5 w-3.5" />
                        <span>{t('practice.btn_solve')}</span>
                      </Link>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Pagination Footer */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between border-t border-slate-300 dark:border-slate-800 pt-6">
          <div className="text-xs text-slate-500 dark:text-slate-400 font-semibold">
            {t('practice.showing')} <span className="text-slate-800 dark:text-white">{(page * pageSize) + 1}</span> {t('practice.to')}{' '}
            <span className="text-slate-800 dark:text-white">
              {Math.min((page + 1) * pageSize, totalElements)}
            </span>{' '}
            {t('practice.of')} <span className="text-slate-800 dark:text-white">{totalElements}</span> {t('practice.problems')}
          </div>
          <div className="flex items-center space-x-2">
            <button
              onClick={() => setPage(prev => Math.max(prev - 1, 0))}
              disabled={page === 0}
              className="p-2 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800/50 disabled:opacity-40 transition-colors"
            >
              <ArrowLeft className="h-4 w-4 dark:text-white" />
            </button>
            
            <div className="flex items-center space-x-1.5">
              {Array.from({ length: totalPages }, (_, idx) => {
                // simple pagination display logic, show nearby pages
                if (idx === page || idx === 0 || idx === totalPages - 1 || Math.abs(idx - page) <= 1) {
                  return (
                    <button
                      key={idx}
                      onClick={() => setPage(idx)}
                      className={`px-3 py-1.5 text-xs font-bold rounded-xl border transition-all ${
                        page === idx
                          ? 'bg-indigo-600 text-white border-indigo-600 shadow-sm shadow-indigo-600/15'
                          : 'border-slate-200 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/50 dark:text-slate-300'
                      }`}
                    >
                      {idx + 1}
                    </button>
                  );
                } else if (idx === 1 || idx === totalPages - 2) {
                  return <span key={idx} className="text-slate-400 dark:text-slate-600 px-1">...</span>;
                }
                return null;
              })}
            </div>

            <button
              onClick={() => setPage(prev => Math.min(prev + 1, totalPages - 1))}
              disabled={page === totalPages - 1}
              className="p-2 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800/50 disabled:opacity-40 transition-colors"
            >
              <ArrowRight className="h-4 w-4 dark:text-white" />
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default PracticeCatalog;
