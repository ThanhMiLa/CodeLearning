import React, { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { Calendar, Clock, Trophy, Lock, Unlock, Users, ChevronRight, RefreshCw, Eye, EyeOff, ShieldAlert } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import api from '../../api/axios';
import type { ApiResponse, PageResponse, ContestListResponse } from '../../types';

interface ContestCountdownProps {
  startTime: string;
  onTimerEnd: () => void;
}

const ContestCountdown: React.FC<ContestCountdownProps> = ({ startTime, onTimerEnd }) => {
  const [timeLeft, setTimeLeft] = useState<{ hours: number; minutes: number; seconds: number } | null>(null);

  useEffect(() => {
    const calculate = () => {
      const difference = new Date(startTime).getTime() - Date.now();
      if (difference <= 0) {
        return null;
      }
      const hours = Math.floor(difference / (1000 * 60 * 60));
      const minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((difference % (1000 * 60)) / 1000);
      return { hours, minutes, seconds };
    };

    const initial = calculate();
    setTimeLeft(initial);
    if (!initial) {
      onTimerEnd();
      return;
    }

    const interval = setInterval(() => {
      const remaining = calculate();
      if (!remaining) {
        clearInterval(interval);
        setTimeLeft(null);
        onTimerEnd();
      } else {
        setTimeLeft(remaining);
      }
    }, 1000);

    return () => clearInterval(interval);
  }, [startTime, onTimerEnd]);

  if (!timeLeft) return null;

  const pad = (n: number) => String(n).padStart(2, '0');

  return (
    <div className="flex flex-col items-stretch md:items-end gap-1">
      <span className="text-[10px] font-extrabold uppercase tracking-wider text-amber-500/80">Starts In</span>
      <div className="inline-flex items-center space-x-1.5 px-3 py-1.5 rounded-xl bg-amber-500/10 text-amber-600 dark:text-amber-400 border border-amber-300 text-xs font-bold shadow-sm animate-pulse">
        <Clock className="h-3.5 w-3.5" />
        <span className="font-mono tracking-wider">
          {pad(timeLeft.hours)}:{pad(timeLeft.minutes)}:{pad(timeLeft.seconds)}
        </span>
      </div>
    </div>
  );
};

const ContestList: React.FC = () => {
  const navigate = useNavigate();
  const [contests, setContests] = useState<ContestListResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState<string>('ALL'); // ALL, RUNNING, UPCOMING, ENDED
  
  // Pagination
  const [page, setPage] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [totalElements, setTotalElements] = useState(0);
  const pageSize = 10;

  // Password modal states
  const [isPasswordModalOpen, setIsPasswordModalOpen] = useState(false);
  const [selectedContest, setSelectedContest] = useState<ContestListResponse | null>(null);
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [registerError, setRegisterError] = useState<string | null>(null);
  const [registering, setRegistering] = useState(false);

  const passwordInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (isPasswordModalOpen) {
      const timer = setTimeout(() => {
        passwordInputRef.current?.focus();
      }, 50);
      return () => clearTimeout(timer);
    }
  }, [isPasswordModalOpen]);

  const fetchContests = async () => {
    setLoading(true);
    try {
      const res = await api.get<ApiResponse<PageResponse<ContestListResponse>>>('/contests', {
        params: {
          page: page,
          size: pageSize
        }
      });
      setContests(res.data.result.content || []);
      setTotalPages(res.data.result.totalPages);
      setTotalElements(res.data.result.totalElements);
    } catch (error) {
      console.error('Failed to fetch contests:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchContests();
  }, [page]);

  const filteredContests = contests.filter(c => {
    if (activeTab === 'ALL') return true;
    return c.status === activeTab;
  });

  const formatDate = (isoString: string) => {
    return new Date(isoString).toLocaleString('en-US', {
      day: 'numeric',
      month: 'short',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'RUNNING':
        return (
          <span className="inline-flex items-center space-x-1.5 px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border border-emerald-500/20 text-xs font-extrabold animate-pulse">
            <span className="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
            <span>Running</span>
          </span>
        );
      case 'UPCOMING':
        return (
          <span className="inline-flex items-center space-x-1.5 px-3 py-1 rounded-full bg-indigo-500/10 text-indigo-600 dark:text-indigo-400 border border-indigo-500/20 text-xs font-extrabold">
            <span className="w-1.5 h-1.5 rounded-full bg-indigo-500"></span>
            <span>Upcoming</span>
          </span>
        );
      case 'ENDED':
        return (
          <span className="inline-flex items-center space-x-1.5 px-3 py-1 rounded-full bg-slate-500/10 text-slate-500 dark:text-slate-400 border border-slate-500/20 text-xs font-extrabold">
            <span>Ended</span>
          </span>
        );
      case 'CANCELLED':
        return (
          <span className="inline-flex items-center space-x-1.5 px-3 py-1 rounded-full bg-rose-500/10 text-rose-500 border border-rose-500/20 text-xs font-extrabold">
            <span>Cancelled</span>
          </span>
        );
      default:
        return null;
    }
  };

  const handleContestAction = (contest: ContestListResponse) => {
    if (contest.status === 'CANCELLED') {
      navigate(`/contests/${contest.id}/leaderboard`);
      return;
    }

    if (contest.status === 'ENDED') {
      navigate(`/contests/${contest.id}`);
      return;
    }

    if (contest.registered) {
      // Already registered, enter directly
      navigate(`/contests/${contest.id}`);
      return;
    }

    const isContestPublic = contest.public ?? contest.isPublic;
    if (isContestPublic) {
      // Direct registration or entering
      registerAndEnter(contest.id, '');
    } else {
      // Show password modal
      setSelectedContest(contest);
      setPassword('');
      setShowPassword(false);
      setRegisterError(null);
      setIsPasswordModalOpen(true);
    }
  };

  const registerAndEnter = async (contestId: number, passVal: string) => {
    setRegistering(true);
    setRegisterError(null);
    try {
      await api.post(`/contests/${contestId}/register`, {
        password: passVal || null
      });

      // Update contest status in state to registered: true
      setContests(prev => prev.map(c => c.id === contestId ? { ...c, registered: true } : c));

      setIsPasswordModalOpen(false);
      navigate(`/contests/${contestId}`);
    } catch (error: any) {
      console.error('Failed to register contest:', error);
      const errCode = error?.response?.data?.code;
      const errMessage = error?.response?.data?.message;

      if (errCode === 9003) {
        setRegisterError("Incorrect room password, please try again!");
      } else if (errCode === 9005) {
        setIsPasswordModalOpen(false);
        alert("The contest has not started or has ended!");
        window.location.reload();
      } else {
        setRegisterError(
          errMessage || 'Incorrect room password or you do not have permission to join.'
        );
      }
    } finally {
      setRegistering(false);
    }
  };

  const handleModalSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedContest || registering) return;
    registerAndEnter(selectedContest.id, password);
  };

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-8 sm:px-6 lg:px-8 text-left min-h-screen">
      
      {/* Hero Banner */}
      <div className="relative rounded-3xl overflow-hidden bg-gradient-to-r from-slate-900 via-indigo-950 to-purple-950 text-white p-8 md:p-12 shadow-xl mb-8 border border-indigo-900/20">
        <div className="absolute top-0 right-0 w-96 h-96 bg-purple-500/10 rounded-full blur-3xl -mr-16 -mt-16 pointer-events-none"></div>
        <div className="relative z-10 space-y-4 max-w-2xl">
          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-purple-500/20 text-purple-300 border border-purple-500/30 text-xs font-bold uppercase tracking-wider">
            <Trophy className="h-3.5 w-3.5" />
            <span>Programming Tournaments</span>
          </div>
          <h1 className="text-3xl md:text-4xl font-extrabold tracking-tight">
            Online Programming Contests
          </h1>
          <p className="text-sm md:text-base text-slate-300 leading-relaxed font-normal">
            Join to test your skills and improve algorithms. Compete directly on the leaderboard with hundreds of other programmers.
          </p>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex border-b border-slate-200 dark:border-slate-800 mb-6 shrink-0">
        {['ALL', 'RUNNING', 'UPCOMING', 'ENDED'].map((tab) => (
          <button
            key={tab}
            onClick={() => setActiveTab(tab)}
            className={`py-3.5 px-6 text-xs font-extrabold tracking-wider uppercase border-b-2 transition-all ${
              activeTab === tab
                ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400 font-black'
                : 'border-transparent text-slate-400 hover:text-slate-800 dark:hover:text-slate-200'
            }`}
          >
            {tab === 'ALL' ? 'All' : tab === 'RUNNING' ? 'Running' : tab === 'UPCOMING' ? 'Upcoming' : 'Ended'}
          </button>
        ))}
      </div>

      {/* Contest Cards list */}
      {loading ? (
        <div className="space-y-4">
          {[1, 2, 3].map(i => (
            <div key={i} className="animate-pulse bg-white dark:bg-slate-900 rounded-2xl p-6 border border-slate-300 dark:border-slate-800 space-y-3">
              <div className="h-6 bg-slate-200 dark:bg-slate-800 rounded w-1/3"></div>
              <div className="h-4 bg-slate-100 dark:bg-slate-800 rounded w-1/4"></div>
            </div>
          ))}
        </div>
      ) : filteredContests.length === 0 ? (
        <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 p-16 text-center text-slate-500 dark:text-slate-400">
          <Calendar className="h-12 w-12 mx-auto opacity-30 mb-3" />
          <p className="font-bold text-sm">No contests found</p>
          <p className="text-xs text-slate-400 mt-1">There are currently no contests in this status.</p>
        </div>
      ) : (
        <div className="space-y-4">
          {filteredContests.map((contest) => (
            <div
              key={contest.id}
              className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 p-6 flex flex-col md:flex-row items-start md:items-center justify-between gap-6 shadow-sm hover:shadow-md transition-all duration-200 hover:-translate-y-0.5"
            >
              {/* Contest info */}
              <div className="space-y-3 text-left flex-grow">
                <div className="flex flex-wrap items-center gap-2">
                  {getStatusBadge(contest.status)}
                  
                  {/* Public/Private Badge */}
                  {(contest.public ?? contest.isPublic) ? (
                    <span className="inline-flex items-center space-x-1 px-2.5 py-0.5 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 text-[10px] font-bold">
                      <Unlock className="h-3 w-3" />
                      <span>Public</span>
                    </span>
                  ) : (
                    <span className="inline-flex items-center space-x-1 px-2.5 py-0.5 rounded-full bg-amber-500/10 text-amber-600 dark:text-amber-400 text-[10px] font-bold border border-amber-200">
                      <Lock className="h-3 w-3" />
                      <span>Protected</span>
                    </span>
                  )}
                </div>

                <div className="space-y-1.5">
                  <h3 className="text-base md:text-lg font-bold text-slate-950 dark:text-white leading-snug">
                    {contest.title}
                  </h3>
                  <div className="flex flex-wrap items-center gap-x-4 gap-y-1.5 text-xs text-slate-500 dark:text-slate-400 font-semibold">
                    <span className="flex items-center space-x-1">
                      <Calendar className="h-4 w-4" />
                      <span>Start: {formatDate(contest.startTime)}</span>
                    </span>
                    <span className="flex items-center space-x-1">
                      <Clock className="h-4 w-4" />
                      <span>End: {formatDate(contest.endTime)}</span>
                    </span>
                    <span className="flex items-center space-x-1">
                      <Users className="h-4 w-4" />
                      <span>{contest.numberOfParticipants} participants</span>
                    </span>
                  </div>
                </div>

                <p className="text-xs text-slate-400">
                  Organized by: <span className="font-semibold">{contest.createdByTeacherName || 'Organizer'}</span>
                </p>
              </div>

              {/* Action Button / Countdown */}
              <div className="shrink-0 w-full md:w-auto flex flex-col items-stretch md:items-end justify-center">
                <AnimatePresence mode="wait">
                  {contest.status === 'UPCOMING' ? (
                    <motion.div
                      key={`countdown-${contest.id}`}
                      initial={{ opacity: 0, scale: 0.95 }}
                      animate={{ opacity: 1, scale: 1 }}
                      exit={{ opacity: 0, scale: 0.95 }}
                      transition={{ duration: 0.2 }}
                    >
                      <ContestCountdown startTime={contest.startTime} onTimerEnd={fetchContests} />
                    </motion.div>
                  ) : (
                    <motion.button
                      key={`btn-${contest.id}`}
                      initial={{ opacity: 0, scale: 0.95 }}
                      animate={{ opacity: 1, scale: 1 }}
                      exit={{ opacity: 0, scale: 0.95 }}
                      transition={{ type: 'spring', stiffness: 200, damping: 15 }}
                      onClick={() => handleContestAction(contest)}
                      className={`w-full md:w-auto inline-flex items-center justify-center space-x-1.5 px-6 py-3 rounded-xl text-xs font-bold transition-all active:scale-95 shadow-md shadow-indigo-600/5 ${
                        contest.status === 'ENDED' || contest.status === 'CANCELLED'
                          ? 'bg-slate-100 hover:bg-slate-200 text-slate-700 dark:bg-slate-800 dark:hover:bg-slate-700 dark:text-slate-200'
                          : 'bg-indigo-600 hover:bg-indigo-700 text-white shadow-indigo-600/10 hover:shadow-indigo-600/20'
                      }`}
                    >
                      {contest.status === 'CANCELLED' ? (
                        <>
                          <Eye className="h-4 w-4" />
                          <span>Leaderboard</span>
                        </>
                      ) : contest.status === 'ENDED' ? (
                        <>
                          <Eye className="h-4 w-4" />
                          <span>Enter Workspace</span>
                        </>
                      ) : contest.registered ? (
                        <>
                          <Trophy className="h-4 w-4" />
                          <span>Enter Contest</span>
                        </>
                      ) : (
                        <>
                          <Trophy className="h-4 w-4" />
                          <span>Join Contest</span>
                        </>
                      )}
                      <ChevronRight className="h-3.5 w-3.5" />
                    </motion.button>
                  )}
                </AnimatePresence>
              </div>
          </div>
        ))}
      </div>
    )}

      {/* Pagination Footer */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between border-t border-slate-300 dark:border-slate-800 pt-6 mt-6">
          <div className="text-xs text-slate-500 dark:text-slate-400 font-semibold">
            Showing {contests.length} of {totalElements} contests (Page {page + 1} of {totalPages})
          </div>
          <div className="flex items-center space-x-2">
            <button
              onClick={() => setPage(prev => Math.max(prev - 1, 0))}
              disabled={page === 0}
              className="px-3.5 py-1.5 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800/50 disabled:opacity-40 transition-colors text-xs font-bold dark:text-white"
            >
              Previous
            </button>
            <button
              onClick={() => setPage(prev => Math.min(prev + 1, totalPages - 1))}
              disabled={page === totalPages - 1}
              className="px-3.5 py-1.5 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800/50 disabled:opacity-40 transition-colors text-xs font-bold dark:text-white"
            >
              Next
            </button>
          </div>
        </div>
      )}

      {/* Password Modal */}
      {isPasswordModalOpen && selectedContest && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm">
          <div className="w-full max-w-md bg-white dark:bg-slate-900 rounded-3xl border border-slate-300 dark:border-slate-800 p-6 md:p-8 space-y-6 shadow-2xl relative animate-in fade-in zoom-in-95 duration-200">
            
            {/* Header info */}
            <div className="text-center space-y-2">
              <div className="mx-auto w-12 h-12 rounded-2xl bg-amber-500/10 text-amber-600 flex items-center justify-center border border-amber-300">
                <Lock className="h-5 w-5" />
              </div>
              <h3 className="text-lg font-bold text-slate-950 dark:text-white">
                Password Required
              </h3>
              <p className="text-xs text-slate-500 dark:text-slate-400 px-4 leading-relaxed font-semibold">
                "{selectedContest.title}" is password-protected. Please enter the password to join.
              </p>
            </div>
 
            {/* Error dialog */}
            {registerError && (
              <div className="p-3 bg-rose-500/10 border border-rose-500/20 rounded-2xl text-rose-600 dark:text-rose-400 text-xs font-bold flex items-center space-x-2">
                <ShieldAlert className="h-4 w-4 shrink-0" />
                <span>{registerError}</span>
              </div>
            )}
 
            {/* Form */}
            <form onSubmit={handleModalSubmit} className="space-y-4">
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                  Contest Password:
                </label>
                <div className="relative">
                  <input
                    ref={passwordInputRef}
                    type={showPassword ? "text" : "password"}
                    required
                    placeholder="Enter password..."
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    className="w-full pl-4 pr-10 py-2.5 rounded-xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors focus:outline-none"
                  >
                    {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                  </button>
                </div>
              </div>
 
              {/* Action buttons */}
              <div className="grid grid-cols-2 gap-3 pt-2">
                <button
                  type="button"
                  onClick={() => setIsPasswordModalOpen(false)}
                  disabled={registering}
                  className="px-4 py-2.5 border border-slate-200 dark:border-slate-800 rounded-xl text-xs font-bold text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={registering || !password.trim()}
                  className="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 disabled:opacity-50 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/15 hover:shadow-indigo-600/25 transition-all flex items-center justify-center space-x-1.5"
                >
                  {registering ? (
                    <RefreshCw className="h-4.5 w-4.5 animate-spin" />
                  ) : (
                    <span>Join</span>
                  )}
                </button>
              </div>
            </form>
 
          </div>
        </div>
      )}

    </div>
  );
};

export default ContestList;
