import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Trophy, Medal, ArrowLeft, RefreshCw, AlertTriangle, Users, BookOpen } from 'lucide-react';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import { useWebSocket } from '../../context/WebSocketContext';
import type { ApiResponse, ContestLeaderboardResponse, ContestResponse } from '../../types';

interface SimpleProblem {
  id: number;
  title: string;
}

const ContestLeaderboard: React.FC = () => {
  const { contestId } = useParams<{ contestId: string }>();
  const navigate = useNavigate();
  const { subscribe, isConnected } = useWebSocket();

  const contestIdNum = Number(contestId);

  // States
  const [leaderboardData, setLeaderboardData] = useState<ContestLeaderboardResponse | null>(null);
  const [problems, setProblems] = useState<SimpleProblem[]>([]);
  const [contest, setContest] = useState<ContestResponse | null>(null);
  
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  const fetchLeaderboardAndMetadata = async (isSilent = false) => {
    if (!isSilent) setLoading(true);
    else setRefreshing(true);
    
    try {
      const [leaderboardRes, problemsRes, contestRes] = await Promise.all([
        api.get<ApiResponse<ContestLeaderboardResponse>>(`/contests/${contestId}/leaderboard`),
        api.get<ApiResponse<any>>(`/contests/${contestId}/problems`).catch(() => ({ data: { result: [] } })),
        api.get<ApiResponse<ContestResponse>>(`/contests/${contestId}`).catch(() => ({ data: { result: null } }))
      ]);

      setLeaderboardData(leaderboardRes.data.result);
      
      const rawProblems = problemsRes.data.result;
      setProblems(Array.isArray(rawProblems) ? rawProblems : rawProblems?.content || []);
      
      if (contestRes.data.result) {
        setContest(contestRes.data.result);
      }
    } catch (error: any) {
      console.error('Failed to fetch leaderboard:', error);
      setErrorMsg(getErrorMessage(error, 'Failed to load contest leaderboard data.'));
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useEffect(() => {
    if (contestId) {
      fetchLeaderboardAndMetadata();
    }
  }, [contestId]);

  // Subscribe to live leaderboard updates via WebSocket
  useEffect(() => {
    if (!contestIdNum) return;

    const topic = `/topic/contests/${contestIdNum}/leaderboard`;
    console.log(`Subscribing to leaderboard topic: ${topic}`);

    const subscription = subscribe(topic, () => {
      console.log('Leaderboard updated socket signal received! Re-fetching...');
      fetchLeaderboardAndMetadata(true); // Silent refresh
    });

    return () => {
      if (subscription) {
        subscription.unsubscribe();
      }
    };
  }, [contestIdNum, subscribe]);


  const getRankMedal = (rank: number) => {
    switch (rank) {
      case 1:
        return <Medal className="h-5 w-5 text-amber-500 fill-amber-500/10 shrink-0" />;
      case 2:
        return <Medal className="h-5 w-5 text-slate-400 fill-slate-400/10 shrink-0" />;
      case 3:
        return <Medal className="h-5 w-5 text-amber-700 fill-amber-700/10 shrink-0" />;
      default:
        return <span className="font-mono text-xs font-bold text-slate-400 dark:text-slate-500">{rank}</span>;
    }
  };

  if (loading) {
    return (
      <div className="flex h-[80vh] items-center justify-center bg-slate-50 dark:bg-slate-950">
        <div className="flex flex-col items-center space-y-3">
          <RefreshCw className="h-10 w-10 animate-spin text-indigo-600 dark:text-indigo-400" />
          <span className="text-sm font-semibold text-slate-500 dark:text-slate-400">Loading leaderboard...</span>
        </div>
      </div>
    );
  }

  if (errorMsg || !leaderboardData) {
    return (
      <div className="mx-auto max-w-md text-center py-20 px-4 min-h-[70vh] flex flex-col justify-center items-center">
        <AlertTriangle className="h-12 w-12 text-rose-500 mb-4" />
        <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-2">Leaderboard Load Error</h3>
        <p className="text-sm text-slate-500 dark:text-slate-400 mb-6 leading-relaxed">{errorMsg || 'Failed to display leaderboard.'}</p>
        <button 
          onClick={() => navigate('/contests')}
          className="px-4 py-2.5 bg-indigo-600 text-white rounded-xl text-xs font-bold shadow-md hover:bg-indigo-700 transition-all active:scale-95"
        >
          Back to Contests
        </button>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-8 sm:px-6 lg:px-8 text-left min-h-screen">
      
      {/* Back to contest room & Title section */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
        <div className="flex items-center space-x-3.5">
          <button
            onClick={() => navigate(-1)}
            className="p-2 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800 bg-white dark:bg-slate-900 text-slate-500 transition-colors shadow-sm"
          >
            <ArrowLeft className="h-4.5 w-4.5" />
          </button>
          <div>
            <div className="flex items-center space-x-2">
              <Trophy className="h-5 w-5 text-amber-500" />
              <h1 className="text-xl md:text-2xl font-black text-slate-950 dark:text-white tracking-tight">
                Leaderboard
              </h1>
            </div>
            <p className="text-xs text-slate-500 dark:text-slate-400 font-semibold mt-0.5">
              Contest: <span className="text-slate-700 dark:text-slate-300 font-bold">{leaderboardData.title}</span>
            </p>
          </div>
        </div>

        {/* Live sync badge & manual refresh */}
        <div className="flex items-center space-x-3">
          <div className="flex items-center space-x-1.5 px-3 py-1.5 rounded-xl bg-slate-100 dark:bg-slate-800/80 border border-slate-300 dark:border-slate-700/50">
            <div className={`w-2 h-2 rounded-full ${isConnected ? 'bg-emerald-500 animate-pulse' : 'bg-rose-500'}`} />
            <span className="text-[10px] text-slate-500 dark:text-slate-400 font-bold uppercase tracking-wider">
              {isConnected ? 'Realtime Connected' : 'Disconnected'}
            </span>
          </div>

          <button
            onClick={() => fetchLeaderboardAndMetadata(true)}
            disabled={refreshing}
            className="p-2.5 border border-slate-200 dark:border-slate-800 rounded-xl bg-white dark:bg-slate-900 hover:bg-slate-50 dark:hover:bg-slate-800 text-slate-500 transition-all hover:scale-105 active:scale-95 shadow-sm disabled:opacity-40"
            title="Refresh Leaderboard"
          >
            <RefreshCw className={`h-4 w-4 ${refreshing ? 'animate-spin' : ''}`} />
          </button>
        </div>
      </div>

      {/* Leaderboard statistics summary */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-5 mb-8">
        <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 p-5 flex items-center space-x-4 shadow-sm">
          <div className="w-10 h-10 rounded-xl bg-indigo-500/10 text-indigo-500 dark:text-indigo-400 flex items-center justify-center shrink-0">
            <Users className="h-5 w-5" />
          </div>
          <div>
            <span className="text-[10px] text-slate-400 dark:text-slate-500 font-bold uppercase tracking-wider block">Participants</span>
            <span className="text-lg font-black text-slate-950 dark:text-white">
              {leaderboardData.leaderboard?.length || 0} participants
            </span>
          </div>
        </div>

        <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 p-5 flex items-center space-x-4 shadow-sm">
          <div className="w-10 h-10 rounded-xl bg-amber-500/10 text-amber-600 flex items-center justify-center shrink-0">
            <Trophy className="h-5 w-5" />
          </div>
          <div>
            <span className="text-[10px] text-slate-400 dark:text-slate-500 font-bold uppercase tracking-wider block">Scoring Rule</span>
            <span className="text-lg font-black text-slate-950 dark:text-white uppercase">
              {contest?.scoringRule || 'ICPC'}
            </span>
          </div>
        </div>

        <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 p-5 flex items-center space-x-4 shadow-sm">
          <div className="w-10 h-10 rounded-xl bg-purple-500/10 text-purple-500 flex items-center justify-center shrink-0">
            <BookOpen className="h-5 w-5" />
          </div>
          <div>
            <span className="text-[10px] text-slate-400 dark:text-slate-500 font-bold uppercase tracking-wider block">Total Problems</span>
            <span className="text-lg font-black text-slate-950 dark:text-white">
              {problems.length} problems
            </span>
          </div>
        </div>
      </div>

      {/* Main Leaderboard Table */}
      <div className="bg-white dark:bg-slate-900 rounded-3xl border border-slate-300 dark:border-slate-800 shadow-sm overflow-hidden">
        {leaderboardData.leaderboard?.length === 0 ? (
          <div className="p-16 text-center text-slate-500 dark:text-slate-400">
            <Trophy className="h-12 w-12 mx-auto opacity-25 mb-3" />
            <p className="font-bold text-sm">No submissions yet</p>
            <p className="text-xs text-slate-400 mt-1">Participant submissions will be shown here.</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full border-collapse text-left text-sm">
              <thead>
                <tr className="border-b border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/20 text-slate-400 dark:text-slate-400 font-bold uppercase tracking-wider text-[10px]">
                  <th className="px-6 py-4 w-16 text-center">Rank</th>
                  <th className="px-6 py-4 w-64 text-left">Participant</th>
                  <th className="px-6 py-4 w-24 text-center">Solved</th>
                  <th className="px-6 py-4 w-28 text-center">Penalty</th>
                  
                  {/* Problems headers */}
                  {problems.map((prob, idx) => {
                    const label = String.fromCharCode(65 + idx);
                    return (
                      <th 
                        key={prob.id} 
                        className="px-4 py-4 w-28 text-center"
                        title={prob.title}
                      >
                        <span className="text-xs font-black text-indigo-600 dark:text-indigo-400">{label}</span>
                      </th>
                    );
                  })}
                  <th className="w-auto"></th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-200 dark:divide-slate-800">
                {leaderboardData.leaderboard.map((row) => (
                  <tr key={row.userId} className="hover:bg-slate-100/70 dark:hover:bg-slate-800/15 transition-colors">
                    {/* Rank */}
                    <td className="px-6 py-4 text-center">
                      <div className="flex items-center justify-center">
                        {getRankMedal(row.rank)}
                      </div>
                    </td>

                    {/* Participant Name */}
                    <td className="px-6 py-4">
                      <span className="font-bold text-slate-800 dark:text-white">
                        {row.displayName}
                      </span>
                    </td>

                    {/* Solved Count */}
                    <td className="px-6 py-4 text-center font-black text-slate-900 dark:text-white">
                      {row.problemsSolved}
                    </td>

                    {/* Penalty */}
                    <td className="px-6 py-4 text-center font-mono text-xs font-semibold text-slate-600 dark:text-slate-400">
                      {Math.floor(row.totalPenalty / 60)}
                    </td>

                    {/* Individual problem cells */}
                    {problems.map((prob) => {
                      const probStatus = row.problemStatuses?.find(ps => ps.problemId === prob.id);
                      
                      if (!probStatus) {
                        return <td key={prob.id} className="px-4 py-4 text-center text-slate-300 dark:text-slate-700">-</td>;
                      }

                      if (probStatus.isSolved) {
                        const failedAttempts = probStatus.failedAttemptsCount;
                        return (
                          <td key={prob.id} className="px-3 py-4 text-center">
                            <div className="inline-flex flex-col items-center justify-center rounded-xl bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border border-emerald-500/20 w-24 h-14 shadow-sm mx-auto">
                              {probStatus.solvedAtSeconds >= 0 && (
                                <span className="text-base font-black leading-tight">
                                  {Math.floor(probStatus.solvedAtSeconds / 60)}
                                </span>
                              )}
                              {failedAttempts > 0 && (
                                <span className="text-xs font-bold leading-none opacity-80 mt-0.5">
                                  (-{failedAttempts})
                                </span>
                              )}
                            </div>
                          </td>
                        );
                      } else {
                        const failedAttempts = probStatus.failedAttemptsCount;
                        if (failedAttempts > 0) {
                          return (
                            <td key={prob.id} className="px-3 py-4 text-center">
                              <div className="inline-flex flex-col items-center justify-center rounded-xl bg-rose-500/10 text-rose-600 dark:text-rose-400 border border-rose-500/20 w-24 h-14 mx-auto">
                                <span className="text-sm font-bold">-{failedAttempts}</span>
                              </div>
                            </td>
                          );
                        }
                        return <td key={prob.id} className="px-4 py-4 text-center text-slate-300 dark:text-slate-700">-</td>;
                      }
                    })}
                    <td className="w-auto"></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

    </div>
  );
};

export default ContestLeaderboard;
