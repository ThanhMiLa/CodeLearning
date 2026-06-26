import React, { useState, useEffect, useRef, useMemo } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import Editor from '@monaco-editor/react';
import { 
  Play, 
  CheckCircle, 
  Clock, 
  ArrowLeft, 
  Code2, 
  RefreshCw, 
  Sparkles, 
  AlertTriangle,
  Terminal,
  BookOpen,
  Trophy,
  ListOrdered,
  XCircle,
  Medal
} from 'lucide-react';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import { useAuth } from '../../context/AuthContext';
import { useWebSocket } from '../../context/WebSocketContext';
import type { ApiResponse, ContestResponse, OjProblemDetailResponse, OjWebSocketMessage, ContestLeaderboardResponse } from '../../types';
import logoImg from '../../assets/LOGO_SINGLE.png';
import { Judge0MaintenanceModal } from '../../components/Judge0MaintenanceModal';

const LANGUAGES = [
  { id: 71, name: 'Python 3', monacoName: 'python', extension: 'py', defaultCode: 'import sys\n\ndef solve():\n    # Read data from stdin\n    # line = sys.stdin.readline()\n    print("Hello World")\n\nif __name__ == "__main__":\n    solve()' },
  { id: 54, name: 'C++ (GCC)', monacoName: 'cpp', extension: 'cpp', defaultCode: '#include <iostream>\nusing namespace std;\n\nint main() {\n    // Read data from stdin\n    // int n;\n    // cin >> n;\n    cout << "Hello World" << endl;\n    return 0;\n}' },
  { id: 62, name: 'Java (OpenJDK)', monacoName: 'java', extension: 'java', defaultCode: 'import java.util.Scanner;\n\npublic class Main {\n    public static void main(String[] args) {\n        // Read data from stdin\n        // Scanner scanner = new Scanner(System.in);\n        System.out.println("Hello World");\n    }\n}' },
  { id: 50, name: 'C (GCC)', monacoName: 'c', extension: 'c', defaultCode: '#include <stdio.h>\n\nint main() {\n    // Read data from stdin\n    // int n;\n    // scanf("%d", &n);\n    printf("Hello World\\n");\n    return 0;\n}' }
];

const detectLanguage = (code: string): number => {
  if (code.includes('#include') && code.includes('cin >>')) return 54; // C++
  if (code.includes('#include') && code.includes('printf')) return 50; // C
  if (code.includes('import java') || code.includes('class Main') || code.includes('public class')) return 62; // Java
  if (code.includes('def ') || code.includes('import ') || code.includes('print(')) return 71; // Python
  return 71; // Default
};

const getProblemColorClass = (idx: number) => {
  const colors = [
    { // A: Indigo
      bg: 'bg-indigo-50/50 dark:bg-indigo-950/30',
      text: 'text-indigo-600 dark:text-indigo-400',
      border: 'border-indigo-200 dark:border-indigo-900/20',
      hover: 'group-hover:bg-indigo-600 group-hover:border-indigo-600'
    },
    { // B: Emerald
      bg: 'bg-emerald-50/50 dark:bg-emerald-950/30',
      text: 'text-emerald-600 dark:text-emerald-400',
      border: 'border-emerald-200 dark:border-emerald-900/20',
      hover: 'group-hover:bg-emerald-600 group-hover:border-emerald-600'
    },
    { // C: Amber
      bg: 'bg-amber-50/50 dark:bg-amber-950/30',
      text: 'text-amber-600 dark:text-amber-400',
      border: 'border-amber-100/30 dark:border-amber-900/20',
      hover: 'group-hover:bg-amber-600 group-hover:border-amber-600'
    },
    { // D: Rose
      bg: 'bg-rose-50/50 dark:bg-rose-950/30',
      text: 'text-rose-600 dark:text-rose-400',
      border: 'border-rose-100/30 dark:border-rose-900/20',
      hover: 'group-hover:bg-rose-600 group-hover:border-rose-600'
    },
    { // E: Purple
      bg: 'bg-purple-50/50 dark:bg-purple-950/30',
      text: 'text-purple-600 dark:text-purple-400',
      border: 'border-purple-100/30 dark:border-purple-900/20',
      hover: 'group-hover:bg-purple-600 group-hover:border-purple-600'
    },
    { // F: Sky
      bg: 'bg-sky-50/50 dark:bg-sky-950/30',
      text: 'text-sky-600 dark:text-sky-400',
      border: 'border-sky-100/30 dark:border-sky-900/20',
      hover: 'group-hover:bg-sky-600 group-hover:border-sky-600'
    },
    { // G: Pink
      bg: 'bg-pink-50/50 dark:bg-pink-950/30',
      text: 'text-pink-600 dark:text-pink-400',
      border: 'border-pink-100/30 dark:border-pink-900/20',
      hover: 'group-hover:bg-pink-600 group-hover:border-pink-600'
    },
    { // H: Teal
      bg: 'bg-teal-50/50 dark:bg-teal-950/30',
      text: 'text-teal-600 dark:text-teal-400',
      border: 'border-teal-100/30 dark:border-teal-900/20',
      hover: 'group-hover:bg-teal-600 group-hover:border-teal-600'
    }
  ];

  const safeIdx = idx < 0 ? 0 : idx % colors.length;
  const color = colors[safeIdx];
  return `inline-flex w-9 h-9 rounded-xl ${color.bg} ${color.text} ${color.border} font-black text-sm items-center justify-center shadow-sm ${color.hover} group-hover:text-white group-hover:scale-105 transition-all duration-200`;
};

interface SimpleContestProblem {
  id: number;
  title: string;
  orderIndex?: number;
  difficulty?: string;
  isAccepted?: boolean | null;
}

const ContestWorkspace: React.FC = () => {
  const { contestId } = useParams<{ contestId: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const { subscribe, isConnected } = useWebSocket();

  const contestIdNum = Number(contestId);

  // States
  const [contest, setContest] = useState<ContestResponse | null>(null);
  const [problems, setProblems] = useState<SimpleContestProblem[]>([]);
  const [selectedProblemId, setSelectedProblemId] = useState<number | null>(null);
  const [problemDetail, setProblemDetail] = useState<OjProblemDetailResponse | null>(null);
  
  const [loading, setLoading] = useState(true);
  const [loadingDetail, setLoadingDetail] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  // Countdown Timer state
  const [timeLeft, setTimeLeft] = useState<number>(0); // in seconds

  // Editor states
  const [selectedLanguageId, setSelectedLanguageId] = useState(71); // Python default
  const [sourceCodes, setSourceCodes] = useState<Record<number, string>>({});
  
  // Submission & Realtime Verdict states
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [verdict, setVerdict] = useState<OjWebSocketMessage | null>(null);

  // Maintenance Modal states
  const [maintenanceModalOpen, setMaintenanceModalOpen] = useState(false);
  const [submitError, setSubmitError] = useState<string | null>(null);


  // Navigation Tab State
  const [activeTab, setActiveTab] = useState<'problems' | 'submissions' | 'ranking'>('problems');

  // User Submissions State
  const [userSubmissions, setUserSubmissions] = useState<any[]>([]);
  const [loadingSubmissions, setLoadingSubmissions] = useState(false);

  // Leaderboard/Ranking State
  const [leaderboardData, setLeaderboardData] = useState<ContestLeaderboardResponse | null>(null);
  const [loadingLeaderboard, setLoadingLeaderboard] = useState(false);
  const [refreshingLeaderboard, setRefreshingLeaderboard] = useState(false);

  // Theme state for Monaco Editor
  const [editorTheme, setEditorTheme] = useState<'vs-dark' | 'vs'>(() => 
    document.documentElement.classList.contains('dark') ? 'vs-dark' : 'vs'
  );

  useEffect(() => {
    const handleThemeChange = () => {
      setEditorTheme(document.documentElement.classList.contains('dark') ? 'vs-dark' : 'vs');
    };
    window.addEventListener('theme-change', handleThemeChange);
    return () => window.removeEventListener('theme-change', handleThemeChange);
  }, []);

  // Keep ref of active submission id to avoid stale closures in websocket callback
  const activeSubIdRef = useRef<number | null>(null);

  const selectedLanguage = useMemo(() => {
    return LANGUAGES.find(l => l.id === selectedLanguageId) || LANGUAGES[0];
  }, [selectedLanguageId]);

  // Fetch contest details & problems list & user submissions list
  const fetchContestData = async () => {
    if (!contestId) return;
    setLoading(true);
    setErrorMsg(null);
    try {
      const [contestRes, problemsRes] = await Promise.all([
        api.get<ApiResponse<ContestResponse>>(`/contests/${contestId}`),
        api.get<ApiResponse<any>>(`/contests/${contestId}/problems`).catch(err => {
          console.warn('GET /contests/{id}/problems failed, trying fallback list API', err);
          return { data: { result: [] } };
        })
      ]);

      const contestData = contestRes.data.result;
      setContest(contestData);

      const problemsData = problemsRes.data.result;
      const parsedProblems: SimpleContestProblem[] = Array.isArray(problemsData) 
        ? problemsData 
        : problemsData?.content || [];
      
      setProblems(parsedProblems);

      // Initialize Timer
      const end = new Date(contestData.endTime).getTime();
      const start = new Date().getTime();
      const seconds = Math.max(Math.floor((end - start) / 1000), 0);
      setTimeLeft(seconds);

    } catch (error: any) {
      console.error('Failed to load contest workspace:', error);
      setErrorMsg(getErrorMessage(error, 'Failed to load contest workspace. Make sure you are registered.'));
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchContestData();
    fetchUserSubmissions();
  }, [contestId]);

  // Fetch user submissions in the contest
  const fetchUserSubmissions = async () => {
    if (!contestId) return;
    setLoadingSubmissions(true);
    try {
      const res = await api.get<ApiResponse<any>>(`/contests/${contestId}/submissions`, {
        params: { page: 0, size: 100 }
      });
      const data = res.data.result;
      setUserSubmissions(Array.isArray(data) ? data : data?.content || []);
    } catch (error) {
      console.error('Failed to fetch user submissions:', error);
    } finally {
      setLoadingSubmissions(false);
    }
  };

  // Fetch Leaderboard
  const fetchLeaderboard = async (isSilent = false) => {
    if (!contestId) return;
    if (!isSilent) setLoadingLeaderboard(true);
    else setRefreshingLeaderboard(true);

    try {
      const res = await api.get<ApiResponse<ContestLeaderboardResponse>>(`/contests/${contestId}/leaderboard`);
      setLeaderboardData(res.data.result);
    } catch (error) {
      console.error('Failed to fetch leaderboard:', error);
    } finally {
      setLoadingLeaderboard(false);
      setRefreshingLeaderboard(false);
    }
  };

  // Fetch data when active tab changes
  useEffect(() => {
    if (activeTab === 'submissions') {
      fetchUserSubmissions();
    } else if (activeTab === 'ranking') {
      fetchLeaderboard();
    }
  }, [activeTab]);

  // Timer interval countdown
  useEffect(() => {
    if (timeLeft <= 0) return;
    const timer = setInterval(() => {
      setTimeLeft(prev => {
        if (prev <= 1) {
          clearInterval(timer);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(timer);
  }, [timeLeft]);

  // Fetch selected problem detail
  useEffect(() => {
    const fetchProblemDetail = async () => {
      if (!selectedProblemId) return;
      setLoadingDetail(true);

      setVerdict(null);
      try {
        const res = await api.get<ApiResponse<OjProblemDetailResponse>>(`/online-judge/problems/${selectedProblemId}`, {
          params: { contestId: contestIdNum }
        });
        const data = res.data.result;
        setProblemDetail(data);

        // Prepopulate editor source code
        const initialCodes: Record<number, string> = {};
        LANGUAGES.forEach(lang => {
          initialCodes[lang.id] = lang.defaultCode;
        });

        if (data.latestSourceCode) {
          const detectedId = detectLanguage(data.latestSourceCode);
          setSelectedLanguageId(detectedId);
          initialCodes[detectedId] = data.latestSourceCode;
        }

        setSourceCodes(initialCodes);
      } catch (err) {
        console.error('Failed to fetch problem detail:', err);
      } finally {
        setLoadingDetail(false);
      }
    };
    fetchProblemDetail();
  }, [selectedProblemId]);

  // WebSocket Subscription for submissions feedback
  useEffect(() => {
    if (!user?.id) return;

    const topic = `/topic/submissions/${user.id}`;
    const subscription = subscribe(topic, (message) => {
      try {
        const data: OjWebSocketMessage = JSON.parse(message.body);
        if (data.submissionId === activeSubIdRef.current) {
          setVerdict(data);


          const finished = data.overallVerdict && 
                           data.overallVerdict !== 'PENDING' && 
                           data.overallVerdict !== 'PROCESSING';
          if (finished) {
            setIsSubmitting(false);
            if (data.overallVerdict === 'ACCEPTED' && selectedProblemId) {
              setProblems(prev => 
                prev.map(p => p.id === selectedProblemId ? { ...p, isAccepted: true } : p)
              );
            }
            // Update user submissions and leaderboard
            fetchUserSubmissions();
            if (activeTab === 'ranking') {
              fetchLeaderboard(true);
            }
          }
        }
      } catch (err) {
        console.error('WebSocket parsing error:', err);
      }
    });

    return () => {
      if (subscription) subscription.unsubscribe();
    };
  }, [user?.id, subscribe, selectedProblemId, activeTab]);

  // WebSocket Subscription for Leaderboard updates
  useEffect(() => {
    if (!contestIdNum) return;

    const topic = `/topic/contests/${contestIdNum}/leaderboard`;
    const subscription = subscribe(topic, () => {
      console.log('Leaderboard updated socket signal received! Re-fetching...');
      fetchLeaderboard(true); // Silent refresh
    });

    return () => {
      if (subscription) {
        subscription.unsubscribe();
      }
    };
  }, [contestIdNum, subscribe]);

  // Calculate problem statuses based on userSubmissions and problems info
  const problemStatuses = useMemo(() => {
    const statusMap: Record<number, 'solved' | 'failed' | 'none'> = {};
    
    problems.forEach(p => {
      if (p.isAccepted) {
        statusMap[p.id] = 'solved';
        return;
      }

      const subsForProb = userSubmissions.filter(sub => sub.problemId === p.id);
      
      if (subsForProb.length === 0) {
        statusMap[p.id] = 'none';
      } else {
        const hasAccepted = subsForProb.some(sub => sub.verdict === 'ACCEPTED');
        if (hasAccepted) {
          statusMap[p.id] = 'solved';
        } else {
          const hasCompletedVerdict = subsForProb.some(sub => 
            sub.verdict && sub.verdict !== 'PENDING' && sub.verdict !== 'PROCESSING'
          );
          if (hasCompletedVerdict) {
            statusMap[p.id] = 'failed';
          } else {
            statusMap[p.id] = 'none';
          }
        }
      }
    });

    return statusMap;
  }, [problems, userSubmissions]);


  const handleEditorChange = (value: string | undefined) => {
    if (value !== undefined && selectedProblemId) {
      setSourceCodes(prev => ({
        ...prev,
        [selectedLanguageId]: value
      }));
    }
  };

  const handleResetCode = () => {
    if (window.confirm('Are you sure you want to reset the default code for this language?')) {
      setSourceCodes(prev => ({
        ...prev,
        [selectedLanguageId]: selectedLanguage.defaultCode
      }));
    }
  };

  const handleSubmit = async () => {
    if (!selectedProblemId || isSubmitting) return;
    const code = sourceCodes[selectedLanguageId];
    if (!code?.trim()) return;

    if (timeLeft <= 0) {
      alert('The contest has ended. You cannot submit code anymore!');
      return;
    }

    setIsSubmitting(true);
    setVerdict(null);


    try {
      const payload = {
        problemId: selectedProblemId,
        contestId: contestIdNum,
        lessonId: null,
        languageId: selectedLanguageId,
        sourceCode: code
      };

      const res = await api.post<ApiResponse<{ submissionId: number; status: string; message: string }>>(
        '/online-judge/submissions',
        payload
      );

      const subId = res.data.result.submissionId;
      activeSubIdRef.current = subId;
      
      setVerdict({
        submissionId: subId,
        testcaseId: null,
        testcaseVerdict: null,
        overallVerdict: 'PENDING',
        executionTimeMs: null,
        memoryUsedKb: null,
        totalTestcases: 0,
        processedTestcases: 0,
        input: null,
        expectedOutput: null,
        actualOutput: null,
        compileOutput: null
      });
    } catch (error: any) {
      console.error('Contest submit failed:', error);
      const errMsg = getErrorMessage(error, 'An error occurred while submitting code.');
      setSubmitError(errMsg);
      setMaintenanceModalOpen(true);
      setIsSubmitting(false);
    }
  };

  // Format remaining seconds into HH:MM:SS
  const formatTimeLeft = (seconds: number) => {
    if (seconds <= 0) return '00:00:00';
    const hrs = Math.floor(seconds / 3600);
    const mins = Math.floor((seconds % 3600) / 60);
    const secs = seconds % 60;
    return [
      hrs.toString().padStart(2, '0'),
      mins.toString().padStart(2, '0'),
      secs.toString().padStart(2, '0')
    ].join(':');
  };

  const getVerdictBadgeClass = (overall: string | null) => {
    if (!overall) return 'bg-slate-100 text-slate-600 border-slate-200 dark:bg-slate-800 dark:text-slate-300 dark:border-slate-700/50';
    switch (overall) {
      case 'ACCEPTED':
        return 'bg-emerald-500/10 text-emerald-600 border-emerald-500/20 dark:text-emerald-400 dark:bg-emerald-950/30 dark:border-emerald-900/40';
      case 'WRONG_ANSWER':
        return 'bg-rose-500/10 text-rose-600 border-rose-500/20 dark:text-rose-400 dark:bg-rose-950/30 dark:border-rose-900/40';
      case 'COMPILE_ERROR':
        return 'bg-purple-500/10 text-purple-600 border-purple-500/20 dark:text-purple-400 dark:bg-purple-950/30 dark:border-purple-900/40';
      case 'PENDING':
      case 'PROCESSING':
        return 'bg-indigo-500/10 text-indigo-600 border-indigo-500/20 dark:text-indigo-400 dark:bg-indigo-950/30 dark:border-indigo-900/40';
      default:
        return 'bg-rose-500/10 text-rose-600 border-rose-500/20 dark:text-rose-400 dark:bg-rose-950/30 dark:border-rose-900/40';
    }
  };

  const getVerdictLabel = (overall: string | null) => {
    if (!overall) return 'Not Submitted';
    switch (overall) {
      case 'ACCEPTED':
        return 'Accepted';
      case 'WRONG_ANSWER':
        return 'Wrong Answer';
      case 'TIME_LIMIT_EXCEEDED':
        return 'Time Limit Exceeded';
      case 'MEMORY_LIMIT_EXCEEDED':
        return 'Memory Limit Exceeded';
      case 'COMPILE_ERROR':
        return 'Compilation Error';
      case 'RUNTIME_ERROR':
        return 'Runtime Error';
      case 'SYSTEM_ERROR':
        return 'System Error';
      case 'PENDING':
        return 'Pending...';
      case 'PROCESSING':
        return 'Processing...';
      default:
        return overall;
    }
  };

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
          <span className="text-sm font-semibold text-slate-500 dark:text-slate-400">Initializing contest environment...</span>
        </div>
      </div>
    );
  }

  if (errorMsg || !contest) {
    return (
      <div className="mx-auto max-w-md text-center py-20 px-4 min-h-[70vh] flex flex-col justify-center items-center">
        <AlertTriangle className="h-12 w-12 text-rose-500 mb-4" />
        <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-2">Access Denied</h3>
        <p className="text-sm text-slate-500 dark:text-slate-400 mb-6 leading-relaxed">{errorMsg || 'Failed to load contest room. Make sure you are registered.'}</p>
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
    <div className="flex flex-col h-[calc(100vh-3.5rem)] w-full overflow-hidden bg-slate-50 dark:bg-slate-950 text-left">
      
      {/* Contest header bar */}
      <div className="h-14 border-b border-slate-300 dark:border-slate-800 bg-white dark:bg-slate-900 px-5 flex items-center justify-between shrink-0 shadow-sm z-10 select-none">
        {/* Left info */}
        <div className="flex items-center space-x-3.5">
          <button
            onClick={() => navigate('/contests')}
            className="p-1 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-500 transition-colors"
            title="Back"
          >
            <ArrowLeft className="h-4.5 w-4.5" />
          </button>
          <div>
            <div className="flex items-center space-x-2">
              <h1 className="text-sm font-extrabold text-slate-950 dark:text-white line-clamp-1 max-w-xs md:max-w-md">
                {contest.title}
              </h1>
              <span className="text-[9px] font-bold bg-indigo-50 dark:bg-indigo-950/40 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/30 px-1.5 py-0.5 rounded uppercase">
                {contest.scoringRule}
              </span>
            </div>
          </div>
        </div>

        {/* Center Countdown timer */}
        <div className="flex items-center space-x-2">
          <Clock className={`h-4.5 w-4.5 ${timeLeft <= 600 ? 'text-rose-500 animate-pulse' : 'text-indigo-600 dark:text-indigo-400'}`} />
          <span className={`font-mono text-sm md:text-base font-extrabold tracking-widest ${
            timeLeft <= 600 ? 'text-rose-500 animate-pulse' : 'text-slate-800 dark:text-slate-100'
          }`}>
            {formatTimeLeft(timeLeft)}
          </span>
          {timeLeft <= 0 && (
            <span className="text-xs font-black text-rose-500 uppercase tracking-wider ml-1">Ended</span>
          )}
        </div>

        {/* Right action indicator */}
        <div className="flex items-center space-x-3">
          <div className="text-xs font-extrabold px-3.5 py-1.5 bg-indigo-50 dark:bg-indigo-950/30 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/25 rounded-xl select-none uppercase">
            {activeTab}
          </div>
        </div>
      </div>

      {/* Main split work area */}
      <div className="flex-grow flex flex-row overflow-hidden relative">
        
        {/* Left main content panel */}
        <div className="flex-grow h-full overflow-hidden flex flex-col">
          
          {/* PROBLEMS TAB CONTENT */}
          {activeTab === 'problems' && (
            selectedProblemId === null ? (
              // Problems List View
              <div className="flex-grow overflow-y-auto p-6 max-w-4xl mx-auto w-full">
                <div className="flex items-center justify-between mb-6">
                  <div>
                    <h2 className="text-xl font-black text-slate-900 dark:text-white tracking-tight">
                      Contest Problems
                    </h2>
                    <p className="text-xs text-slate-500 dark:text-slate-400 mt-1 font-medium">
                      Select a problem to start coding. Your progress is saved automatically.
                    </p>
                  </div>
                  <div className="text-xs font-bold text-slate-500 bg-slate-100 dark:bg-slate-800 dark:text-slate-300 px-3 py-1.5 rounded-xl border border-slate-300 dark:border-slate-700/50">
                    {problems.filter(p => problemStatuses[p.id] === 'solved').length} / {problems.length} Solved
                  </div>
                </div>

                <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800/60 shadow-sm overflow-hidden">
                  <div className="overflow-x-auto">
                    <table className="w-full border-collapse text-sm">
                      <thead>
                        <tr className="border-b border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/20 text-slate-400 dark:text-slate-400 font-bold uppercase tracking-wider text-[10px] text-left">
                          <th className="px-6 py-4 w-20 text-center">Status</th>
                          <th className="px-6 py-4 w-24 text-center">Order</th>
                          <th className="px-6 py-4 text-left">Problem Name</th>
                          <th className="px-6 py-4 w-28 text-right"></th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-200 dark:divide-slate-800">
                        {problems.map((prob, idx) => {
                          const label = String.fromCharCode(65 + idx); // A, B, C...
                          const status = problemStatuses[prob.id];
                          
                          return (
                            <tr 
                              key={prob.id}
                              onClick={() => setSelectedProblemId(prob.id)}
                              className="hover:bg-slate-100/70 dark:hover:bg-slate-800/10 transition-colors cursor-pointer group"
                            >
                              {/* Status */}
                              <td className="px-6 py-4 text-center">
                                <div className="flex justify-center">
                                  {status === 'solved' ? (
                                    <div title="Completed">
                                      <CheckCircle className="h-5 w-5 text-emerald-500 shrink-0" />
                                    </div>
                                  ) : status === 'failed' ? (
                                    <div title="Incorrect">
                                      <XCircle className="h-5 w-5 text-rose-500 shrink-0" />
                                    </div>
                                  ) : (
                                    <span className="w-5 h-5 rounded-full border border-slate-200 dark:border-slate-800 block shrink-0" />
                                  )}
                                </div>
                              </td>

                              {/* Order Index */}
                              <td className="px-6 py-4 text-center">
                                <div className="flex justify-center">
                                  <span className={getProblemColorClass(idx)}>
                                    {label}
                                  </span>
                                </div>
                              </td>

                              {/* Title */}
                              <td className="px-6 py-4 text-left font-bold text-slate-800 dark:text-white group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors text-sm">
                                {prob.title}
                              </td>

                              {/* Action */}
                              <td className="px-6 py-4 text-right whitespace-nowrap">
                                <button
                                  onClick={(e) => {
                                    e.stopPropagation();
                                    setSelectedProblemId(prob.id);
                                  }}
                                  className="inline-flex items-center space-x-1 px-3 py-1.5 bg-indigo-50 hover:bg-indigo-100 dark:bg-indigo-950/30 dark:hover:bg-indigo-950/55 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/20 rounded-xl text-xs font-bold transition-all active:scale-95 shadow-sm"
                                >
                                  <Code2 className="h-3.5 w-3.5" />
                                  <span>Solve</span>
                                </button>
                              </td>
                            </tr>
                          );
                        })}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            ) : (
              // Individual Problem Workspace Detail View
              <div className="flex flex-col h-full w-full overflow-hidden">
                {/* Back bar */}
                <div className="h-12 border-b border-slate-300 dark:border-slate-800 bg-white dark:bg-slate-900 px-4 flex items-center justify-between shrink-0 select-none z-10 shadow-sm">
                  <div className="flex items-center space-x-3">
                    <button
                      onClick={() => setSelectedProblemId(null)}
                      className="inline-flex items-center space-x-1.5 px-3 py-1.5 rounded-xl bg-slate-50 hover:bg-slate-100 dark:bg-slate-800 dark:hover:bg-slate-800/80 text-slate-600 dark:text-slate-300 border border-slate-300 dark:border-slate-700 text-xs font-bold transition-all"
                    >
                      <ArrowLeft className="h-3.5 w-3.5" />
                      <span>Back to Problems</span>
                    </button>
                    <span className="text-slate-300 dark:text-slate-700">|</span>
                    <h2 className="text-sm font-extrabold text-slate-800 dark:text-slate-200">
                      Problem {problems.findIndex(p => p.id === selectedProblemId) !== -1 ? String.fromCharCode(65 + problems.findIndex(p => p.id === selectedProblemId)) : ''}: {problemDetail?.title}
                    </h2>
                  </div>
                  
                  {/* Quick select mini problem list */}
                  <div className="flex items-center space-x-1 bg-slate-100/70 dark:bg-slate-800 p-0.5 rounded-xl">
                    {problems.map((prob, idx) => {
                      const label = String.fromCharCode(65 + idx);
                      const isSelected = prob.id === selectedProblemId;
                      const status = problemStatuses[prob.id];
                      
                      return (
                        <button
                          key={prob.id}
                          onClick={() => setSelectedProblemId(prob.id)}
                          className={`w-7 h-7 rounded-lg text-xs font-extrabold flex items-center justify-center transition-all ${
                            isSelected
                              ? 'bg-indigo-600 text-white shadow-sm'
                              : status === 'solved'
                              ? 'text-emerald-600 dark:text-emerald-400 hover:bg-emerald-50/50 dark:hover:bg-emerald-950/20'
                              : status === 'failed'
                              ? 'text-rose-600 dark:text-rose-400 hover:bg-rose-50/50 dark:hover:bg-rose-950/20'
                              : 'text-slate-600 dark:text-slate-400 hover:bg-slate-200/60 dark:hover:bg-slate-700'
                          }`}
                          title={`${prob.title} (${status === 'solved' ? 'Completed' : status === 'failed' ? 'Incorrect' : 'Unattempted'})`}
                        >
                          {label}
                        </button>
                      );
                    })}
                  </div>
                </div>

                {/* Single Scrollable Problem Workspace */}
                <div className="flex-grow overflow-y-auto w-full">
                  <div className="p-5 md:p-6 max-w-4xl mx-auto space-y-6 text-left">
                    
                    {/* Problem details (Title & Solve status) */}
                    {loadingDetail ? (
                      <div className="space-y-4 animate-pulse">
                        <div className="h-6 bg-slate-200 dark:bg-slate-800 rounded w-2/3"></div>
                        <div className="h-4 bg-slate-100 dark:bg-slate-800 rounded w-full"></div>
                        <div className="h-4 bg-slate-100 dark:bg-slate-800 rounded w-5/6"></div>
                      </div>
                    ) : problemDetail ? (
                      <div className="space-y-6">
                        {/* Title and Solve badge */}
                        <div>
                          <h2 className="text-xl font-extrabold text-slate-900 dark:text-white leading-snug">
                            {problemDetail.title}
                          </h2>
                          {problemStatuses[problemDetail.id] === 'solved' && (
                            <div className="flex items-center space-x-2 mt-1.5">
                              <span className="flex items-center space-x-0.5 text-xs font-bold text-emerald-600 dark:text-emerald-400">
                                <CheckCircle className="h-4 w-4 text-emerald-500 fill-emerald-500/10" />
                                <span>Solved</span>
                              </span>
                            </div>
                          )}
                        </div>

                        <hr className="border-slate-300 dark:border-slate-800" />

                        {/* Description */}
                        {problemDetail.description && (
                          <div className="prose dark:prose-invert prose-indigo max-w-none">
                            <h3 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider flex items-center space-x-1.5">
                              <BookOpen className="h-4.5 w-4.5 text-indigo-500" />
                              <span>Description</span>
                            </h3>
                            <p className="text-sm text-slate-700 dark:text-slate-300 whitespace-pre-wrap leading-relaxed mt-2 font-normal font-sans">
                              {problemDetail.description}
                            </p>
                          </div>
                        )}

                        {/* Input Description */}
                        {problemDetail.inputDescription && (
                          <div className="space-y-1">
                            <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                              Input
                            </h4>
                            <p className="text-sm text-slate-700 dark:text-slate-300 leading-relaxed font-normal">
                              {problemDetail.inputDescription}
                            </p>
                          </div>
                        )}

                        {/* Output Description */}
                        {problemDetail.outputDescription && (
                          <div className="space-y-1">
                            <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                              Output
                            </h4>
                            <p className="text-sm text-slate-700 dark:text-slate-300 leading-relaxed font-normal">
                              {problemDetail.outputDescription}
                            </p>
                          </div>
                        )}

                        {/* Constraints */}
                        {problemDetail.constraints && (
                          <div className="space-y-1">
                            <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                              Constraints
                            </h4>
                            <pre className="p-3.5 rounded-xl bg-slate-50/60 dark:bg-slate-950/40 text-xs font-mono border border-slate-300 dark:border-slate-800/60 leading-relaxed text-slate-700 dark:text-slate-300 overflow-x-auto whitespace-pre-wrap">
                              {problemDetail.constraints}
                            </pre>
                          </div>
                        )}

                        {/* Examples */}
                        {(problemDetail.exampleInput || problemDetail.exampleOutput) && (
                          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            {problemDetail.exampleInput && (
                              <div className="space-y-1.5">
                                <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                                  Example Input
                                </h4>
                                <pre className="p-3 rounded-xl bg-slate-50 dark:bg-slate-950 text-slate-800 dark:text-slate-100 text-xs font-mono border border-slate-200 dark:border-slate-900/60 leading-relaxed overflow-x-auto whitespace-pre">
                                  <code>{problemDetail.exampleInput}</code>
                                </pre>
                              </div>
                            )}
                            {problemDetail.exampleOutput && (
                              <div className="space-y-1.5">
                                <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                                  Example Output
                                </h4>
                                <pre className="p-3 rounded-xl bg-slate-50 dark:bg-slate-950 text-slate-800 dark:text-slate-100 text-xs font-mono border border-slate-200 dark:border-slate-900/60 leading-relaxed overflow-x-auto whitespace-pre">
                                  <code>{problemDetail.exampleOutput}</code>
                                </pre>
                              </div>
                            )}
                          </div>
                        )}

                        {/* Hint */}
                        {problemDetail.hint && (
                          <div className="bg-amber-500/5 border border-amber-200 rounded-2xl p-4 space-y-1">
                            <h4 className="text-xs font-extrabold text-amber-700 dark:text-amber-400 uppercase tracking-wider flex items-center space-x-1.5">
                              <Sparkles className="h-4 w-4" />
                              <span>Hints</span>
                            </h4>
                            <p className="text-xs text-slate-600 dark:text-slate-300 leading-relaxed font-normal">
                              {problemDetail.hint}
                            </p>
                          </div>
                        )}

                        {/* Divider */}
                        <hr className="border-slate-300 dark:border-slate-800 my-6" />

                        {/* Code Editor block */}
                        <div className="space-y-3">
                          <div className="flex items-center justify-between">
                            <h3 className="text-sm font-extrabold text-slate-900 dark:text-white uppercase tracking-wider flex items-center space-x-1.5">
                              <Code2 className="h-4.5 w-4.5 text-indigo-500" />
                              <span>Write Source Code</span>
                            </h3>

                            <div className="flex items-center space-x-3">
                              {/* Language dropdown */}
                              <select
                                value={selectedLanguageId}
                                onChange={(e) => setSelectedLanguageId(Number(e.target.value))}
                                disabled={isSubmitting || timeLeft <= 0}
                                className="px-2.5 py-1 text-xs font-bold rounded-lg border border-slate-300 bg-white text-slate-700 dark:border-slate-800 dark:bg-slate-900 dark:text-slate-300 focus:outline-none focus:ring-1 focus:ring-indigo-500 disabled:opacity-60"
                              >
                                {LANGUAGES.map(lang => (
                                  <option key={lang.id} value={lang.id}>
                                    {lang.name}
                                  </option>
                                ))}
                              </select>

                              {/* Reset code */}
                              <button
                                onClick={handleResetCode}
                                disabled={isSubmitting || timeLeft <= 0}
                                title="Reset default template"
                                className="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-500 dark:text-slate-400 hover:text-slate-800 dark:hover:text-slate-300 border border-slate-200 dark:border-slate-800 rounded-lg transition-colors disabled:opacity-50"
                              >
                                <RefreshCw className="h-3.5 w-3.5" />
                              </button>
                            </div>
                          </div>

                          {/* Monaco Editor Container */}
                          <div className="h-[450px] md:h-[550px] w-full border border-slate-300 dark:border-slate-800 rounded-2xl overflow-hidden bg-white dark:bg-slate-950 relative shadow-inner">
                            <Editor
                              height="100%"
                              language={selectedLanguage.monacoName}
                              value={sourceCodes[selectedLanguageId] || ''}
                              onChange={handleEditorChange}
                              theme={editorTheme}
                              loading={
                                <div className="absolute inset-0 flex items-center justify-center bg-white/80 dark:bg-slate-950/80">
                                  <RefreshCw className="h-6 w-6 animate-spin text-slate-500 dark:text-slate-400" />
                                </div>
                              }
                              options={{
                                fontSize: 14,
                                fontFamily: 'Fira Code, Source Code Pro, Menlo, Monaco, Consolas, monospace',
                                tabSize: 4,
                                automaticLayout: true,
                                minimap: { enabled: false },
                                scrollbar: {
                                  verticalScrollbarSize: 8,
                                  horizontalScrollbarSize: 8
                                },
                                lineNumbers: 'on',
                                wordWrap: 'on',
                                padding: { top: 12, bottom: 12 },
                                readOnly: timeLeft <= 0
                              }}
                            />
                          </div>

                          {/* Submit Actions */}
                          <div className="flex items-center justify-between pt-1">
                            {/* Verdict status next to submit button */}
                            <div>
                              {isSubmitting && (!verdict || verdict.overallVerdict === 'PENDING' || verdict.overallVerdict === 'PROCESSING') ? (
                                <div className="flex items-center space-x-2 text-xs font-bold text-slate-500 bg-slate-100 dark:bg-slate-900/60 px-3 py-1.5 rounded-xl border border-slate-200 dark:border-slate-800">
                                  <RefreshCw className="h-3.5 w-3.5 animate-spin text-indigo-600" />
                                  <span>Judging... {verdict && verdict.totalTestcases > 0 ? `(${verdict.processedTestcases}/${verdict.totalTestcases})` : ''}</span>
                                </div>
                              ) : verdict && verdict.overallVerdict ? (
                                <div className={`flex items-center space-x-2 px-3 py-1.5 rounded-xl border text-xs font-black uppercase ${getVerdictBadgeClass(verdict.overallVerdict)}`}>
                                  <span>{getVerdictLabel(verdict.overallVerdict)}</span>
                                  {verdict.overallVerdict === 'COMPILE_ERROR' && verdict.compileOutput && (
                                    <button
                                      onClick={() => alert(verdict.compileOutput)}
                                      className="ml-1 text-[9px] underline lowercase text-slate-400 hover:text-slate-600 dark:hover:text-slate-200"
                                      title="View compilation error"
                                    >
                                      (details)
                                    </button>
                                  )}
                                </div>
                              ) : null}
                            </div>

                            <button
                              onClick={handleSubmit}
                              disabled={isSubmitting || timeLeft <= 0 || !selectedProblemId}
                              className="flex items-center space-x-2 px-5 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold disabled:opacity-50 transition-all active:scale-95 shadow-md shadow-indigo-600/10 hover:shadow-indigo-600/25"
                            >
                              {isSubmitting ? (
                                <RefreshCw className="h-3.5 w-3.5 animate-spin" />
                              ) : (
                                <Play className="h-3.5 w-3.5" />
                              )}
                              <span>{timeLeft <= 0 ? 'Contest Ended' : 'Submit Code'}</span>
                            </button>
                          </div>
                        </div>

                      </div>
                    ) : (
                      <div className="h-full flex items-center justify-center text-slate-500 font-sans">
                        <p className="text-xs">No problem description available.</p>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            )
          )}

          {/* SUBMISSIONS TAB CONTENT */}
          {activeTab === 'submissions' && (
            <div className="flex-grow overflow-y-auto p-6 max-w-5xl mx-auto w-full">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6">
                <div>
                  <h2 className="text-xl font-black text-slate-900 dark:text-white tracking-tight flex items-center space-x-2">
                    <Terminal className="h-5 w-5 text-indigo-500" />
                    <span>My Submissions</span>
                  </h2>
                  <p className="text-xs text-slate-500 dark:text-slate-400 mt-1 font-medium">
                    View your coding history and verdicts for this contest.
                  </p>
                </div>
                
                <button
                  onClick={fetchUserSubmissions}
                  disabled={loadingSubmissions}
                  className="inline-flex items-center space-x-1.5 px-4 py-2 bg-white hover:bg-slate-50 dark:bg-slate-900 dark:hover:bg-slate-800 text-slate-700 dark:text-slate-300 border border-slate-300 dark:border-slate-800 rounded-xl text-xs font-bold transition-all shadow-sm active:scale-95 disabled:opacity-50"
                >
                  <RefreshCw className={`h-3.5 w-3.5 ${loadingSubmissions ? 'animate-spin' : ''}`} />
                  <span>Refresh History</span>
                </button>
              </div>

              {loadingSubmissions && userSubmissions.length === 0 ? (
                <div className="flex h-60 items-center justify-center">
                  <div className="flex flex-col items-center space-y-2">
                    <RefreshCw className="h-8 w-8 animate-spin text-indigo-600" />
                    <span className="text-xs font-bold text-slate-500">Loading submissions history...</span>
                  </div>
                </div>
              ) : (
                <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 shadow-sm overflow-hidden">
                  <div className="overflow-x-auto">
                    <table className="w-full border-collapse text-left text-sm">
                      <thead>
                        <tr className="border-b border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/20 text-slate-400 dark:text-slate-400 font-bold uppercase tracking-wider text-[10px]">
                          <th className="px-6 py-4 w-24 text-center">Problem</th>
                          <th className="px-6 py-4 w-28 text-left">Language</th>
                          <th className="px-6 py-4 w-36 text-left">Verdict</th>
                          <th className="px-6 py-4 w-24 text-left">Time</th>
                          <th className="px-6 py-4 w-28 text-left">Memory</th>
                          <th className="px-6 py-4 w-44 text-left">Submitted At</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-200 dark:divide-slate-800">
                        {userSubmissions.length === 0 ? (
                          <tr>
                            <td colSpan={6} className="px-6 py-16 text-center text-slate-500 dark:text-slate-400">
                              <div className="flex flex-col items-center justify-center space-y-2">
                                <Terminal className="h-10 w-10 opacity-20 mb-1" />
                                <p className="font-bold text-sm">No Submissions Found</p>
                                <p className="text-xs text-slate-400 dark:text-slate-500">Submit code in Problems tab and check back here!</p>
                              </div>
                            </td>
                          </tr>
                        ) : (
                          userSubmissions.map((sub) => {
                            const probIndex = problems.findIndex(p => p.id === sub.problemId);
                            const letter = probIndex !== -1 ? String.fromCharCode(65 + probIndex) : '';
                            const timeStr = new Date(sub.submittedAt).toLocaleString();
                            
                            return (
                              <tr key={sub.id} className="hover:bg-slate-50/40 dark:hover:bg-slate-800/15 transition-colors group">
                                {/* Problem (Letter badge only) */}
                                <td className="px-6 py-4 text-center w-24">
                                  <div className="flex justify-center">
                                    <span className={getProblemColorClass(probIndex)}>
                                      {letter}
                                    </span>
                                  </div>
                                </td>

                                {/* Language */}
                                <td className="px-6 py-4 whitespace-nowrap text-xs font-mono font-bold text-slate-600 dark:text-slate-400">
                                  {sub.language}
                                </td>

                                {/* Verdict Badge */}
                                <td className="px-6 py-4 whitespace-nowrap">
                                  <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-[10px] font-extrabold border uppercase shadow-sm ${getVerdictBadgeClass(sub.verdict)}`}>
                                    {getVerdictLabel(sub.verdict)}
                                  </span>
                                </td>

                                {/* Time */}
                                <td className="px-6 py-4 whitespace-nowrap font-mono text-xs font-semibold text-slate-600 dark:text-slate-400">
                                  {sub.executionTimeMs !== null ? `${sub.executionTimeMs} ms` : '-'}
                                </td>

                                {/* Memory */}
                                <td className="px-6 py-4 whitespace-nowrap font-mono text-xs font-semibold text-slate-600 dark:text-slate-400">
                                  {sub.memoryUsedKb !== null ? `${(sub.memoryUsedKb / 1024).toFixed(1)} MB` : '-'}
                                </td>

                                {/* Submitted At */}
                                <td className="px-6 py-4 whitespace-nowrap text-xs font-medium text-slate-500 dark:text-slate-400">
                                  {timeStr}
                                </td>
                              </tr>
                            );
                          })
                        )}
                      </tbody>
                    </table>
                  </div>
                </div>
              )}
            </div>
          )}

          {/* RANKING TAB CONTENT */}
          {activeTab === 'ranking' && (
            <div className="flex-grow overflow-y-auto p-6 max-w-[1600px] mx-auto w-full">
              
              {/* Leaderboard stats summary */}
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-5 mb-6">
                <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 p-5 flex items-center space-x-4 shadow-sm">
                  <div className="w-10 h-10 rounded-xl bg-indigo-500/10 text-indigo-600 dark:text-indigo-400 flex items-center justify-center shrink-0">
                    <ListOrdered className="h-5 w-5" />
                  </div>
                  <div>
                    <span className="text-[10px] text-slate-400 dark:text-slate-505 font-bold uppercase tracking-wider block">Participants</span>
                    <span className="text-base font-black text-slate-950 dark:text-white">
                      {leaderboardData?.leaderboard?.length || 0} contestants
                    </span>
                  </div>
                </div>

                <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 p-5 flex items-center space-x-4 shadow-sm">
                  <div className="w-10 h-10 rounded-xl bg-amber-500/10 text-amber-600 flex items-center justify-center shrink-0">
                    <Trophy className="h-5 w-5" />
                  </div>
                  <div>
                    <span className="text-[10px] text-slate-400 dark:text-slate-500 font-bold uppercase tracking-wider block">Scoring System</span>
                    <span className="text-base font-black text-slate-950 dark:text-white uppercase">
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
                    <span className="text-base font-black text-slate-950 dark:text-white">
                      {problems.length} problems
                    </span>
                  </div>
                </div>
              </div>

              {/* Main Scoreboard Card */}
              <div className="bg-white dark:bg-slate-900 rounded-2xl border border-slate-300 dark:border-slate-800 shadow-sm overflow-hidden">
                <div className="px-5 py-4 border-b border-slate-300 dark:border-slate-800 flex items-center justify-between">
                  <h3 className="text-sm font-extrabold text-slate-900 dark:text-white">Standings Scoreboard</h3>
                  <div className="flex items-center space-x-3">
                    <div className="flex items-center space-x-1 text-[10px] font-bold text-slate-400">
                      <div className={`w-1.5 h-1.5 rounded-full ${isConnected ? 'bg-emerald-500' : 'bg-rose-500 animate-pulse'}`} />
                      <span>{isConnected ? 'LIVE FEED SYNCED' : 'OFFLINE'}</span>
                    </div>
                    <button
                      onClick={() => fetchLeaderboard(true)}
                      disabled={refreshingLeaderboard}
                      className="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 border border-slate-200 dark:border-slate-800 rounded-lg transition-colors"
                      title="Reload Leaderboard"
                    >
                      <RefreshCw className={`h-3.5 w-3.5 ${refreshingLeaderboard ? 'animate-spin' : ''}`} />
                    </button>
                  </div>
                </div>

                {loadingLeaderboard && !leaderboardData ? (
                  <div className="p-16 text-center text-slate-500 dark:text-slate-400">
                    <RefreshCw className="h-8 w-8 animate-spin mx-auto mb-2 text-indigo-600" />
                    <span className="text-xs font-bold">Retrieving stand data...</span>
                  </div>
                ) : !leaderboardData || leaderboardData.leaderboard?.length === 0 ? (
                  <div className="p-16 text-center text-slate-500 dark:text-slate-400">
                    <Trophy className="h-12 w-12 mx-auto opacity-25 mb-3" />
                    <p className="font-bold text-sm">No submissions recorded yet</p>
                    <p className="text-xs text-slate-400 mt-1">Submit code to update leaderboard scoreboard.</p>
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
                          {problems.map((prob, idx) => {
                            const label = String.fromCharCode(65 + idx);
                            return (
                              <th key={prob.id} className="px-4 py-2 w-28 text-center" title={prob.title}>
                                <div className="flex justify-center">
                                  <span className={getProblemColorClass(idx)}>
                                    {label}
                                  </span>
                                </div>
                              </th>
                            );
                          })}
                          <th className="w-auto"></th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-200 dark:divide-slate-800">
                        {leaderboardData.leaderboard.map((row) => (
                          <tr key={row.userId} className="hover:bg-slate-100/70 dark:hover:bg-slate-800/15 transition-colors">
                            <td className="px-6 py-4 text-center">
                              <div className="flex items-center justify-center">
                                {getRankMedal(row.rank)}
                              </div>
                            </td>
                            <td className="px-6 py-4">
                              <span className="font-bold text-slate-800 dark:text-white">
                                {row.displayName}
                              </span>
                            </td>
                            <td className="px-6 py-4 text-center font-black text-slate-900 dark:text-white">
                              {row.problemsSolved}
                            </td>
                            <td className="px-6 py-4 text-center font-mono text-xs font-semibold text-slate-600 dark:text-slate-400">
                              {Math.floor(row.totalPenalty / 60)}
                            </td>
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
                                return <td key={prob.id} className="px-4 py-4 text-center text-slate-305 dark:text-slate-700">-</td>;
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
          )}

        </div>

        {/* Far Right Sidebar Navigation */}
        <div className="w-56 md:w-64 border-l border-slate-300 dark:border-slate-800 bg-white dark:bg-slate-900 flex flex-col items-center py-6 gap-3 shrink-0 z-20 shadow-sm select-none">
          {/* Logo and Name horizontally */}
          <div className="flex items-center space-x-3 px-6 pb-4 w-full justify-start border-b border-slate-200 dark:border-slate-800 mb-2">
            <img src={logoImg} className="h-8 w-auto rounded object-contain shrink-0" alt="CodeLearning Logo" />
            <span className="text-base font-extrabold tracking-wider bg-gradient-to-r from-indigo-600 to-violet-600 dark:from-indigo-400 dark:to-violet-400 bg-clip-text text-transparent">
              CodeLearning
            </span>
          </div>

          <div className="text-[9px] font-black text-slate-400 dark:text-slate-500 uppercase tracking-widest text-left px-5 w-full mb-2">
            Navigation
          </div>
          
          {/* Problems Tab button */}
          <button
            onClick={() => setActiveTab('problems')}
            className={`w-[calc(100%-1.5rem)] px-4 py-3 rounded-xl flex flex-row items-center space-x-3 border transition-all relative group ${
              activeTab === 'problems'
                ? 'bg-indigo-50 border-indigo-200 dark:bg-indigo-950/30 dark:border-indigo-900/50 text-indigo-600 dark:text-indigo-400 shadow-sm'
                : 'bg-transparent border-transparent text-slate-500 dark:text-slate-400 hover:bg-slate-50 hover:text-slate-700 dark:hover:bg-slate-800 dark:hover:text-slate-300'
            }`}
            title="Problems List"
          >
            <BookOpen className="h-4.5 w-4.5 shrink-0" />
            <span className="text-xs font-bold tracking-tight">Problems</span>
          </button>

          {/* Submissions Tab button */}
          <button
            onClick={() => setActiveTab('submissions')}
            className={`w-[calc(100%-1.5rem)] px-4 py-3 rounded-xl flex flex-row items-center space-x-3 border transition-all relative group ${
              activeTab === 'submissions'
                ? 'bg-indigo-50 border-indigo-200 dark:bg-indigo-950/30 dark:border-indigo-900/50 text-indigo-600 dark:text-indigo-400 shadow-sm'
                : 'bg-transparent border-transparent text-slate-500 dark:text-slate-400 hover:bg-slate-50 hover:text-slate-700 dark:hover:bg-slate-800 dark:hover:text-slate-300'
            }`}
            title="Submission History"
          >
            <Terminal className="h-4.5 w-4.5 shrink-0" />
            <span className="text-xs font-bold tracking-tight">Submissions</span>
          </button>

          {/* Ranking Tab button */}
          <button
            onClick={() => setActiveTab('ranking')}
            className={`w-[calc(100%-1.5rem)] px-4 py-3 rounded-xl flex flex-row items-center space-x-3 border transition-all relative group ${
              activeTab === 'ranking'
                ? 'bg-indigo-50 border-indigo-200 dark:bg-indigo-950/30 dark:border-indigo-900/50 text-indigo-600 dark:text-indigo-400 shadow-sm'
                : 'bg-transparent border-transparent text-slate-500 dark:text-slate-400 hover:bg-slate-50 hover:text-slate-700 dark:hover:bg-slate-800 dark:hover:text-slate-300'
            }`}
            title="Leaderboard Scoreboard"
          >
            <Trophy className="h-4.5 w-4.5 shrink-0" />
            <span className="text-xs font-bold tracking-tight">Ranking</span>
          </button>
        </div>

      </div>

      <Judge0MaintenanceModal
        isOpen={maintenanceModalOpen}
        onClose={() => setMaintenanceModalOpen(false)}
        errorMessage={submitError}
        codeToCopy={sourceCodes[selectedLanguageId]}
      />

    </div>
  );
};

export default ContestWorkspace;
