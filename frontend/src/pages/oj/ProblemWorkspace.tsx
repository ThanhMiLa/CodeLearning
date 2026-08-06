import React, { useState, useEffect, useRef, useMemo } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import Editor from '@monaco-editor/react';
import { 
  Play, 
  CheckCircle, 
  Clock, 
  Cpu, 
  ArrowLeft, 
  Code2, 
  RefreshCw, 
  Sparkles, 
  AlertTriangle,
  Terminal,
  BookOpen,
  ChevronDown,
  ChevronUp,
  History,
  ChevronLeft,
  ChevronRight,
  Calendar
} from 'lucide-react';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import { useAuth } from '../../context/AuthContext';
import { useWebSocket } from '../../context/WebSocketContext';
import type { ApiResponse, OjProblemDetailResponse, OjWebSocketMessage, OjProblemSubmission, PageResponse } from '../../types';
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

const formatDate = (dateString: string): string => {
  try {
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    });
  } catch (e) {
    return dateString;
  }
};

const ProblemWorkspace: React.FC = () => {
  const { problemId } = useParams<{ problemId: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const { subscribe, isConnected } = useWebSocket();

  const problemIdNum = Number(problemId);

  // States
  const [problem, setProblem] = useState<OjProblemDetailResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  // Maintenance Modal states
  const [maintenanceModalOpen, setMaintenanceModalOpen] = useState(false);
  const [submitError, setSubmitError] = useState<string | null>(null);

  // Editor states
  const [selectedLanguageId, setSelectedLanguageId] = useState(71); // Python default
  const [sourceCodes, setSourceCodes] = useState<Record<number, string>>({});
  
  // Submission & Realtime Verdict states
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [verdict, setVerdict] = useState<OjWebSocketMessage | null>(null);
  const [testcases, setTestcases] = useState<OjWebSocketMessage[]>([]);
  const [leftTab, setLeftTab] = useState<'description' | 'results' | 'submissions'>('description');
  const [expandedTestcases, setExpandedTestcases] = useState<Record<number, boolean>>({});

  // Submission History states
  const [submissions, setSubmissions] = useState<OjProblemSubmission[]>([]);
  const [loadingSubmissions, setLoadingSubmissions] = useState(false);
  const [submissionPage, setSubmissionPage] = useState(0);
  const [submissionTotalPages, setSubmissionTotalPages] = useState(1);
  const [submissionTotalElements, setSubmissionTotalElements] = useState(0);

  const toggleTestcaseExpand = (index: number) => {
    setExpandedTestcases(prev => ({ ...prev, [index]: !prev[index] }));
  };

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

  // Fetch problem details
  useEffect(() => {
    const fetchProblemDetails = async () => {
      if (!problemId) return;
      setLoading(true);
      setErrorMsg(null);
      try {
        const res = await api.get<ApiResponse<OjProblemDetailResponse>>(`/online-judge/problems/${problemId}`);
        const data = res.data.result;
        setProblem(data);
        
        // Populate source codes
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
      } catch (error: any) {
        console.error('Failed to fetch problem:', error);
        setErrorMsg(getErrorMessage(error, 'Failed to load problem. Please try again later.'));
      } finally {
        setLoading(false);
      }
    };
    fetchProblemDetails();
  }, [problemId]);

  // Fetch submission history
  const fetchSubmissions = async (page = 0) => {
    if (!problemIdNum) return;
    setLoadingSubmissions(true);
    try {
      const res = await api.get<ApiResponse<PageResponse<OjProblemSubmission>>>(
        `/online-judge/problems/${problemIdNum}/submissions`,
        {
          params: {
            page,
            size: 10
          }
        }
      );
      const data = res.data.result;
      setSubmissions(data.content || []);
      setSubmissionPage(data.page);
      setSubmissionTotalPages(data.totalPages);
      setSubmissionTotalElements(data.totalElements);
    } catch (err) {
      console.error('Failed to fetch submissions:', err);
    } finally {
      setLoadingSubmissions(false);
    }
  };

  useEffect(() => {
    if (leftTab === 'submissions') {
      fetchSubmissions(submissionPage);
    }
  }, [leftTab, submissionPage]);

  // Reset page when problemId changes
  useEffect(() => {
    setSubmissionPage(0);
  }, [problemIdNum]);

  // Listen to WebSocket submissions topic for realtime verdict feedback
  useEffect(() => {
    if (!user?.id) return;

    const topic = `/topic/submissions/${user.id}`;
    console.log(`Subscribing to topic: ${topic}`);

    const subscription = subscribe(topic, (message) => {
      try {
        const data: OjWebSocketMessage = JSON.parse(message.body);
        console.log('Received WebSocket verdict update:', data);

        // Check if message corresponds to the active submission
        if (data.submissionId === activeSubIdRef.current) {
          setVerdict(data);
          
          // Append or update testcase details if present
          if (data.testcaseId !== null) {
            setTestcases(prev => {
              const exists = prev.some(t => t.testcaseId === data.testcaseId);
              let updated;
              if (exists) {
                updated = prev.map(t => t.testcaseId === data.testcaseId ? data : t);
              } else {
                updated = [...prev, data];
              }
              return updated.sort((a, b) => (a.testcaseId || 0) - (b.testcaseId || 0));
            });
          }
          
          const finished = data.overallVerdict && 
                           data.overallVerdict !== 'PENDING' && 
                           data.overallVerdict !== 'PROCESSING';
          
          if (finished) {
            setIsSubmitting(false);
            // If accepted, update local problem status
            if (data.overallVerdict === 'ACCEPTED') {
              setProblem(prev => prev ? { ...prev, isAccepted: true } : null);
            }
            // Refresh submission history
            fetchSubmissions(0);
          }
        }
      } catch (err) {
        console.error('Failed to parse WS submission msg:', err);
      }
    });

    return () => {
      if (subscription) {
        subscription.unsubscribe();
      }
    };
  }, [user?.id, subscribe]);

  const handleEditorChange = (value: string | undefined) => {
    if (value !== undefined) {
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
    const code = sourceCodes[selectedLanguageId];
    if (!code?.trim() || isSubmitting) return;

    setIsSubmitting(true);
    setVerdict(null);
    setTestcases([]);
    setExpandedTestcases({});
    setLeftTab('results');
    
    try {
      const payload = {
        problemId: problemIdNum,
        languageId: selectedLanguageId,
        sourceCode: code,
        lessonId: null,
        contestId: null
      };

      const res = await api.post<ApiResponse<{ submissionId: number; status: string; message: string }>>(
        '/online-judge/submissions',
        payload
      );

      const subId = res.data.result.submissionId;
      activeSubIdRef.current = subId;

      // Pre-populate verdict as PENDING
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

    } catch (err: any) {
      console.error('Failed to submit code:', err);
      const errMsg = getErrorMessage(err, 'An error occurred while submitting code.');
      setSubmitError(errMsg);
      setMaintenanceModalOpen(true);
      setIsSubmitting(false);
    }
  };

  const getVerdictBadgeClass = (overall: string | null) => {
    if (!overall) return 'bg-slate-100 text-slate-700 border-slate-200 dark:bg-slate-800 dark:text-slate-300 dark:border-slate-700';
    switch (overall) {
      case 'ACCEPTED':
        return 'bg-emerald-500/10 text-emerald-600 border-emerald-500/20 dark:text-emerald-400 dark:bg-emerald-950/30 dark:border-emerald-900/40 shadow-sm shadow-emerald-500/5';
      case 'WRONG_ANSWER':
        return 'bg-rose-500/10 text-rose-600 border-rose-500/20 dark:text-rose-400 dark:bg-rose-950/30 dark:border-rose-900/40';
      case 'TIME_LIMIT_EXCEEDED':
      case 'MEMORY_LIMIT_EXCEEDED':
        return 'bg-amber-500/10 text-amber-600 border-amber-300 dark:text-amber-400 dark:bg-amber-950/30 dark:border-amber-900/40';
      case 'COMPILATION_ERROR':
        return 'bg-purple-500/10 text-purple-600 border-purple-500/20 dark:text-purple-400 dark:bg-purple-950/30 dark:border-purple-900/40';
      case 'PENDING':
      case 'PROCESSING':
        return 'bg-indigo-500/10 text-indigo-600 border-indigo-500/20 dark:text-indigo-400 dark:bg-indigo-950/30 dark:border-indigo-900/40 animate-pulse-indigo';
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
      case 'COMPILATION_ERROR':
        return 'Compilation Error';
      case 'RUNTIME_ERROR':
        return 'Runtime Error';
      case 'INTERNAL_ERROR':
        return 'System Error';
      case 'PENDING':
        return 'Pending...';
      case 'PROCESSING':
        return 'Processing...';
      default:
        return overall;
    }
  };

  const getDifficultyColor = (diff: string) => {
    switch (diff) {
      case 'EASY':
        return 'text-emerald-600 bg-emerald-50 border-emerald-100 dark:text-emerald-400 dark:bg-emerald-950/30 dark:border-emerald-900/30';
      case 'MEDIUM':
        return 'text-amber-600 bg-amber-50 border-amber-100 dark:text-amber-400 dark:bg-amber-950/30 dark:border-amber-900/30';
      case 'HARD':
        return 'text-rose-600 bg-rose-50 border-rose-100 dark:text-rose-400 dark:bg-rose-950/30 dark:border-rose-900/30';
      default:
        return 'text-slate-600 bg-slate-50 border-slate-200';
    }
  };

  if (loading) {
    return (
      <div className="flex h-[80vh] items-center justify-center bg-slate-50 dark:bg-slate-950">
        <div className="flex flex-col items-center space-y-3">
          <RefreshCw className="h-10 w-10 animate-spin text-indigo-600 dark:text-indigo-400" />
          <span className="text-sm font-semibold text-slate-500 dark:text-slate-400">Loading workspace...</span>
        </div>
      </div>
    );
  }

  if (errorMsg || !problem) {
    return (
      <div className="mx-auto max-w-md text-center py-20 px-4 min-h-[70vh] flex flex-col justify-center items-center">
        <AlertTriangle className="h-12 w-12 text-rose-500 mb-4" />
        <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-2">An error occurred</h3>
        <p className="text-sm text-slate-500 dark:text-slate-400 mb-6">{errorMsg || 'Failed to load problem.'}</p>
        <button 
          onClick={() => navigate('/oj/practice')}
          className="px-4 py-2 bg-indigo-600 text-white rounded-xl text-xs font-bold shadow-md hover:bg-indigo-700 transition-all active:scale-95"
        >
          Back to Problems
        </button>
      </div>
    );
  }

  return (
    <div className="flex flex-col lg:flex-row h-[calc(100vh-3.5rem)] w-full overflow-hidden bg-slate-50 dark:bg-slate-950 text-left">
      
      {/* LEFT PANEL: Problem description / Testcases (50% width on large screens) */}
      <div className="w-full lg:w-1/2 flex flex-col h-1/2 lg:h-full border-r border-slate-300 dark:border-slate-800 bg-white dark:bg-slate-900">
        {/* Navigation back and title */}
        <div className="px-5 py-3.5 border-b border-slate-300 dark:border-slate-800 flex items-center justify-between shrink-0">
          <div className="flex items-center space-x-3">
            <button
              onClick={() => navigate(-1)}
              className="p-1 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-500 transition-colors"
            >
              <ArrowLeft className="h-4.5 w-4.5" />
            </button>
            <div>
              <h2 className="text-sm font-extrabold text-slate-950 dark:text-white line-clamp-1">
                {problem.title}
              </h2>
              <div className="flex items-center space-x-2 mt-0.5">
                {problem.difficulty && (
                  <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold border ${getDifficultyColor(problem.difficulty)}`}>
                    {problem.difficulty === 'EASY' ? 'Easy' : problem.difficulty === 'MEDIUM' ? 'Medium' : 'Hard'}
                  </span>
                )}
                {problem.isAccepted && (
                  <span className="flex items-center space-x-0.5 text-[10px] font-bold text-emerald-600 dark:text-emerald-400">
                    <CheckCircle className="h-3 w-3 fill-emerald-500/10" />
                    <span>Solved</span>
                  </span>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Tab Headers */}
        <div className="flex items-center justify-between border-b border-slate-300 dark:border-slate-800 shrink-0 bg-slate-100/70 dark:bg-slate-900/50 select-none px-4">
          <div className="flex space-x-1">
            <button
              onClick={() => setLeftTab('description')}
              className={`px-4 py-2.5 text-xs font-bold transition-all border-b-2 tracking-wider uppercase ${
                leftTab === 'description'
                  ? 'border-indigo-600 text-indigo-600 dark:border-indigo-400 dark:text-indigo-400'
                  : 'border-transparent text-slate-400 hover:text-slate-600 dark:hover:text-slate-300'
              }`}
            >
              Description
            </button>
            <button
              onClick={() => setLeftTab('results')}
              className={`px-4 py-2.5 text-xs font-bold transition-all border-b-2 tracking-wider uppercase flex items-center space-x-1.5 ${
                leftTab === 'results'
                  ? 'border-indigo-600 text-indigo-600 dark:border-indigo-400 dark:text-indigo-400'
                  : 'border-transparent text-slate-400 hover:text-slate-600 dark:hover:text-slate-300'
              }`}
            >
              <span>Results</span>
              {isSubmitting && (
                <span className="h-1.5 w-1.5 rounded-full bg-indigo-500 animate-ping" />
              )}
            </button>
            <button
              onClick={() => setLeftTab('submissions')}
              className={`px-4 py-2.5 text-xs font-bold transition-all border-b-2 tracking-wider uppercase flex items-center space-x-1.5 ${
                leftTab === 'submissions'
                  ? 'border-indigo-600 text-indigo-600 dark:border-indigo-400 dark:text-indigo-400'
                  : 'border-transparent text-slate-400 hover:text-slate-600 dark:hover:text-slate-300'
              }`}
            >
              <span>Submissions</span>
            </button>
          </div>

          {/* Connection status */}
          <div className="flex items-center space-x-1.5 shrink-0 select-none text-[10px] font-bold text-slate-400 dark:text-slate-500">
            <div className={`w-1.5 h-1.5 rounded-full ${isConnected ? 'bg-emerald-500' : 'bg-rose-500 animate-pulse'}`} />
            <span className="uppercase">{isConnected ? 'Sync Active' : 'Offline'}</span>
          </div>
        </div>

        {/* Scrollable Problem Info or Testcase Results */}
        <div className="flex-grow overflow-y-auto p-5 md:p-6">
          {leftTab === 'description' ? (
            <div className="space-y-6">
              {/* Tags */}
              {problem.tags && problem.tags.length > 0 && (
                <div className="flex flex-wrap gap-1.5">
                  {problem.tags.map(tag => (
                    <span key={tag} className="px-2.5 py-0.5 rounded-md bg-slate-100 text-slate-600 dark:bg-slate-800 dark:text-slate-300 text-[10px] font-bold">
                      {tag}
                    </span>
                  ))}
                </div>
              )}

              {/* Description */}
              {problem.description && (
                <div className="prose dark:prose-invert prose-indigo max-w-none">
                  <h3 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider flex items-center space-x-2">
                    <BookOpen className="h-4 w-4 text-indigo-500" />
                    <span>Problem Statement</span>
                  </h3>
                  <p className="text-sm text-slate-700 dark:text-slate-300 whitespace-pre-wrap leading-relaxed mt-2 font-normal font-sans">
                    {problem.description}
                  </p>
                </div>
              )}

              {/* Input Format */}
              {problem.inputDescription && (
                <div className="space-y-1">
                  <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                    Input
                  </h4>
                  <p className="text-sm text-slate-700 dark:text-slate-300 leading-relaxed font-normal font-sans">
                    {problem.inputDescription}
                  </p>
                </div>
              )}

              {/* Output Format */}
              {problem.outputDescription && (
                <div className="space-y-1">
                  <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                    Output
                  </h4>
                  <p className="text-sm text-slate-700 dark:text-slate-300 leading-relaxed font-normal font-sans">
                    {problem.outputDescription}
                  </p>
                </div>
              )}

              {/* Constraints */}
              {problem.constraints && (
                <div className="space-y-1">
                  <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                    Constraints
                  </h4>
                  <pre className="p-3 rounded-xl bg-slate-50 dark:bg-slate-950/40 text-xs font-mono border border-slate-300 dark:border-slate-800/60 leading-relaxed text-slate-700 dark:text-slate-300 overflow-x-auto whitespace-pre-wrap">
                    {problem.constraints}
                  </pre>
                </div>
              )}

              {/* Examples */}
              {(problem.exampleInput || problem.exampleOutput) && (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {problem.exampleInput && (
                    <div className="space-y-1.5">
                      <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                        Example Input
                      </h4>
                      <pre className="p-3.5 rounded-xl bg-slate-50 dark:bg-slate-950 text-slate-800 dark:text-slate-100 text-xs font-mono border border-slate-200 dark:border-slate-900/60 leading-relaxed overflow-x-auto whitespace-pre">
                        <code>{problem.exampleInput}</code>
                      </pre>
                    </div>
                  )}
                  {problem.exampleOutput && (
                    <div className="space-y-1.5">
                      <h4 className="text-xs font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
                        Example Output
                      </h4>
                      <pre className="p-3.5 rounded-xl bg-slate-50 dark:bg-slate-950 text-slate-800 dark:text-slate-100 text-xs font-mono border border-slate-200 dark:border-slate-900/60 leading-relaxed overflow-x-auto whitespace-pre">
                        <code>{problem.exampleOutput}</code>
                      </pre>
                    </div>
                  )}
                </div>
              )}

              {/* Hint */}
              {problem.hint && (
                <div className="bg-amber-500/5 border border-amber-200 rounded-2xl p-4 space-y-1">
                  <h4 className="text-xs font-extrabold text-amber-700 dark:text-amber-400 uppercase tracking-wider flex items-center space-x-1.5">
                    <Sparkles className="h-4 w-4" />
                    <span>Hints</span>
                  </h4>
                  <p className="text-xs text-slate-600 dark:text-slate-300 leading-relaxed font-normal font-sans">
                    {problem.hint}
                  </p>
                </div>
              )}
            </div>
          ) : leftTab === 'results' ? (
            <div className="space-y-4">
              {verdict ? (
                <div className="space-y-5 pb-4">
                  {/* Result summary card */}
                  <div className={`border p-6 rounded-2xl flex flex-col items-center justify-center text-center gap-4 ${getVerdictBadgeClass(verdict.overallVerdict)}`}>
                    <div className="space-y-2 w-full max-w-md">
                      <span className="text-[10px] uppercase font-bold tracking-widest opacity-60">Verdict</span>
                      <h4 className="text-xl md:text-2xl font-black tracking-tight uppercase">
                        {getVerdictLabel(verdict.overallVerdict)}
                      </h4>
                      
                      {/* Testcase Progress Bar */}
                      {verdict.totalTestcases > 0 && (
                        <div className="pt-2 space-y-2">
                          <div className="text-sm font-semibold opacity-90">
                            Judged: <span className="text-lg font-black">{verdict.processedTestcases}</span> / <span className="text-lg font-black">{verdict.totalTestcases}</span> testcases
                          </div>
                          <div className="w-full bg-slate-200 dark:bg-slate-800 h-3 rounded-full overflow-hidden shadow-inner">
                            <div 
                              className={`h-full transition-all duration-300 rounded-full ${
                                verdict.overallVerdict === 'ACCEPTED' ? 'bg-gradient-to-r from-emerald-500 to-teal-500' : 
                                verdict.overallVerdict === 'WRONG_ANSWER' ? 'bg-gradient-to-r from-rose-500 to-red-500' : 
                                'bg-gradient-to-r from-indigo-500 to-purple-500'
                              }`}
                              style={{ width: `${(verdict.processedTestcases / verdict.totalTestcases) * 100}%` }}
                            />
                          </div>
                        </div>
                      )}
                    </div>
                    
                    {/* Metadata (time/memory) */}
                    {(verdict.executionTimeMs !== null || verdict.memoryUsedKb !== null) && (
                      <div className="flex items-center space-x-6 shrink-0 text-xs font-bold bg-slate-100/50 dark:bg-slate-900/50 px-4 py-2 rounded-xl border border-slate-300 dark:border-slate-800/40 font-mono">
                        {verdict.executionTimeMs !== null && (
                          <div className="flex items-center space-x-1.5 text-slate-600 dark:text-slate-400">
                            <Clock className="h-4 w-4" />
                            <span>{verdict.executionTimeMs} ms</span>
                          </div>
                        )}
                        {verdict.memoryUsedKb !== null && (
                          <div className="flex items-center space-x-1.5 text-slate-600 dark:text-slate-400">
                            <Cpu className="h-4 w-4" />
                            <span>{(verdict.memoryUsedKb / 1024).toFixed(1)} MB</span>
                          </div>
                        )}
                      </div>
                    )}
                  </div>

                  {/* Compilation Error logs if exists */}
                  {verdict.overallVerdict === 'COMPILATION_ERROR' && verdict.compileOutput && (
                    <div className="space-y-1.5 text-left font-sans">
                      <h5 className="text-[10px] font-bold text-rose-400 dark:text-rose-400 uppercase tracking-wider">Compilation Logs:</h5>
                      <pre className="p-3.5 rounded-xl bg-rose-950/20 border border-rose-900/30 text-rose-300 font-mono text-xs overflow-x-auto whitespace-pre leading-relaxed select-text">
                        <code>{verdict.compileOutput}</code>
                      </pre>
                    </div>
                  )}

                  {/* List of Testcase Results (Step-by-Step) */}
                  {testcases.length > 0 && (
                    <div className="space-y-3 pt-2">
                      <h5 className="text-[10px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-wider font-sans">
                        Testcase Details ({testcases.length})
                      </h5>
                      <div className="grid grid-cols-1 gap-3">
                        {testcases.map((tc, idx) => {
                          const isFailed = tc.testcaseVerdict !== 'ACCEPTED';
                          const isExpanded = !!expandedTestcases[idx];
                          return (
                            <div 
                              key={tc.testcaseId ?? idx}
                              className={`border rounded-2xl overflow-hidden bg-white dark:bg-slate-900 transition-all ${
                                tc.testcaseVerdict === 'ACCEPTED'
                                  ? 'border-slate-200 dark:border-slate-800'
                                  : 'border-rose-200 dark:border-rose-900/40'
                              }`}
                            >
                              {/* Testcase Header Card - Click to toggle expansion */}
                              <div 
                                onClick={() => toggleTestcaseExpand(idx)}
                                className="px-4 py-3 bg-slate-100/70 dark:bg-slate-900/50 border-b border-slate-300 dark:border-slate-800 flex items-center justify-between text-xs font-sans cursor-pointer hover:bg-slate-100/50 dark:hover:bg-slate-800/50 transition-colors select-none"
                              >
                                <div className="flex items-center space-x-2">
                                  <span className={`h-2 w-2 rounded-full ${tc.testcaseVerdict === 'ACCEPTED' ? 'bg-emerald-500' : 'bg-rose-500'}`} />
                                  <span className="font-extrabold text-slate-700 dark:text-slate-300">
                                    Testcase #{idx + 1}
                                  </span>
                                  <span className={`px-2 py-0.5 rounded-full text-[9px] font-bold border ${getVerdictBadgeClass(tc.testcaseVerdict)}`}>
                                    {getVerdictLabel(tc.testcaseVerdict)}
                                  </span>
                                </div>
                                
                                <div className="flex items-center space-x-3 text-slate-400 font-medium text-[10px]">
                                  {tc.executionTimeMs !== null && (
                                    <span>{tc.executionTimeMs} ms</span>
                                  )}
                                  {tc.memoryUsedKb !== null && (
                                    <span>{(tc.memoryUsedKb / 1024).toFixed(2)} MB</span>
                                  )}
                                  {isExpanded ? (
                                    <ChevronUp className="h-4 w-4 text-slate-400" />
                                  ) : (
                                    <ChevronDown className="h-4 w-4 text-slate-400" />
                                  )}
                                </div>
                              </div>

                              {/* Testcase Inputs and Outputs - Collapsible */}
                              {isExpanded && tc.input !== null && (
                                <div className="p-4 space-y-3 font-mono text-[11px] leading-relaxed border-t border-slate-200 dark:border-slate-800/50 bg-slate-50/20 dark:bg-slate-950/20">
                                  <div className="space-y-1">
                                    <span className="text-slate-500 font-bold block text-[9px] uppercase tracking-wider">Input:</span>
                                    <pre className="p-2.5 rounded bg-slate-100 dark:bg-slate-950/80 text-slate-700 dark:text-slate-300 overflow-x-auto whitespace-pre max-h-24 leading-normal">{tc.input}</pre>
                                  </div>
                                  <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                                    <div className="space-y-1">
                                      <span className="text-slate-500 font-bold block text-[9px] uppercase tracking-wider">Actual Output:</span>
                                      <pre className={`p-2.5 rounded overflow-x-auto whitespace-pre max-h-24 leading-normal border ${
                                        isFailed 
                                          ? 'bg-rose-50/30 dark:bg-rose-950/20 border-rose-100/50 dark:border-rose-900/20 text-rose-600 dark:text-rose-400' 
                                          : 'bg-slate-100 dark:bg-slate-950/80 border-transparent text-slate-700 dark:text-slate-300'
                                      }`}>{tc.actualOutput ?? 'N/A'}</pre>
                                    </div>
                                    <div className="space-y-1">
                                      <span className="text-slate-500 font-bold block text-[9px] uppercase tracking-wider">Expected Output:</span>
                                      <pre className="p-2.5 rounded bg-emerald-50/30 dark:bg-emerald-950/20 text-emerald-600 dark:text-emerald-400 border border-emerald-100/50 dark:border-emerald-900/20 overflow-x-auto whitespace-pre max-h-24 leading-normal">{tc.expectedOutput ?? 'N/A'}</pre>
                                    </div>
                                  </div>
                                </div>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  )}
                </div>
              ) : (
                <div className="h-full flex flex-col items-center justify-center text-center text-slate-500 py-12 font-sans">
                  <Terminal className="h-8 w-8 text-slate-700 mb-2 opacity-50" />
                  <p className="text-xs">Write code and click "Submit" to compile and run tests.</p>
                </div>
              )}
            </div>
          ) : (
            <div className="space-y-4 font-sans text-left">
              {loadingSubmissions ? (
                <div className="flex flex-col items-center justify-center py-12 space-y-2">
                  <RefreshCw className="h-8 w-8 animate-spin text-indigo-600 dark:text-indigo-400" />
                  <span className="text-xs text-slate-500 dark:text-slate-400 font-semibold">Loading submissions...</span>
                </div>
              ) : submissions.length === 0 ? (
                <div className="flex flex-col items-center justify-center text-center text-slate-500 py-12 space-y-2.5">
                  <div className="p-3 bg-slate-100 dark:bg-slate-800 rounded-2xl">
                    <History className="h-6 w-6 text-slate-500 dark:text-slate-400" />
                  </div>
                  <p className="text-xs font-semibold text-slate-500 dark:text-slate-400">You have no submissions for this problem.</p>
                </div>
              ) : (
                <div className="space-y-4">
                  <div className="overflow-x-auto rounded-xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50">
                    <table className="w-full text-left text-xs">
                      <thead>
                        <tr className="border-b border-slate-200 dark:border-slate-800 bg-slate-50/50 dark:bg-slate-900/80 text-slate-400 uppercase tracking-wider text-[10px] font-bold select-none">
                          <th className="px-4 py-3">Verdict</th>
                          <th className="px-4 py-3">Language</th>
                          <th className="px-4 py-3">Execution Time</th>
                          <th className="px-4 py-3">Memory</th>
                          <th className="px-4 py-3 text-right">Submitted At</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-slate-100 dark:divide-slate-800/60 font-medium">
                        {submissions.map((sub) => (
                          <tr key={sub.id} className="hover:bg-slate-50/30 dark:hover:bg-slate-800/20 transition-colors">
                            <td className="px-4 py-3">
                              <span className={`px-2 py-0.5 rounded-full text-[9px] font-bold border ${getVerdictBadgeClass(sub.verdict)}`}>
                                {getVerdictLabel(sub.verdict)}
                              </span>
                            </td>
                            <td className="px-4 py-3 text-slate-700 dark:text-slate-300 font-mono text-[11px]">
                              {sub.language}
                            </td>
                            <td className="px-4 py-3 text-slate-500 dark:text-slate-400 font-mono text-[11px]">
                              {sub.executionTimeMs} ms
                            </td>
                            <td className="px-4 py-3 text-slate-500 dark:text-slate-400 font-mono text-[11px]">
                              {(sub.memoryUsedKb / 1024).toFixed(2)} MB
                            </td>
                            <td className="px-4 py-3 text-right text-slate-400 dark:text-slate-500 font-mono text-[10px]">
                              <div className="flex items-center justify-end space-x-1.5">
                                <Calendar className="h-3 w-3 opacity-60" />
                                <span>{formatDate(sub.submittedAt)}</span>
                              </div>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>

                  {/* Pagination */}
                  {submissionTotalPages > 1 && (
                    <div className="flex items-center justify-between border-t border-slate-200 dark:border-slate-800 pt-4 mt-2">
                      <span className="text-[11px] text-slate-500 dark:text-slate-400 font-semibold select-none">
                        Page {submissionPage + 1} of {submissionTotalPages} ({submissionTotalElements} submissions)
                      </span>
                      <div className="flex items-center space-x-2">
                        <button
                          onClick={() => setSubmissionPage(prev => Math.max(0, prev - 1))}
                          disabled={submissionPage === 0 || loadingSubmissions}
                          className="p-1.5 rounded-lg border border-slate-200 dark:border-slate-800 hover:bg-slate-100 dark:hover:bg-slate-800 disabled:opacity-40 disabled:hover:bg-transparent transition-colors shadow-sm"
                        >
                          <ChevronLeft className="h-3.5 w-3.5 text-slate-500" />
                        </button>
                        <button
                          onClick={() => setSubmissionPage(prev => Math.min(submissionTotalPages - 1, prev + 1))}
                          disabled={submissionPage === submissionTotalPages - 1 || loadingSubmissions}
                          className="p-1.5 rounded-lg border border-slate-200 dark:border-slate-800 hover:bg-slate-100 dark:hover:bg-slate-800 disabled:opacity-40 disabled:hover:bg-transparent transition-colors shadow-sm"
                        >
                          <ChevronRight className="h-3.5 w-3.5 text-slate-500" />
                        </button>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          )}
        </div>
      </div>

      {/* RIGHT PANEL: Editor (100% height on desktop now!) */}
      <div className="w-full lg:w-1/2 flex flex-col h-1/2 lg:h-full bg-white dark:bg-slate-950 overflow-hidden">
        
        {/* Editor controls bar */}
        <div className="px-4 py-2 border-b border-slate-200 dark:border-slate-900 bg-slate-50 dark:bg-slate-950 flex items-center justify-between shrink-0 select-none">
          <div className="flex items-center space-x-3">
            <div className="flex items-center space-x-1.5 text-slate-500 dark:text-slate-400">
              <Code2 className="h-4 w-4 text-indigo-500 dark:text-indigo-400" />
              <span className="text-[10px] font-bold uppercase tracking-wider">Editor</span>
            </div>
            
            {/* Language Selector */}
            <select
              value={selectedLanguageId}
              onChange={(e) => setSelectedLanguageId(Number(e.target.value))}
              disabled={isSubmitting}
              className="px-2.5 py-1 text-xs font-bold rounded-lg border border-slate-300 bg-white text-slate-700 dark:border-slate-800 dark:bg-slate-900 dark:text-slate-300 focus:outline-none focus:ring-1 focus:ring-indigo-500"
            >
              {LANGUAGES.map(lang => (
                <option key={lang.id} value={lang.id}>
                  {lang.name}
                </option>
              ))}
            </select>
          </div>

          <div className="flex items-center space-x-2">
            {/* Reset code */}
            <button
              onClick={handleResetCode}
              disabled={isSubmitting}
              title="Reset code template"
              className="p-1.5 text-slate-500 hover:text-slate-800 dark:text-slate-400 dark:hover:text-white bg-white hover:bg-slate-100 dark:bg-slate-900 dark:hover:bg-slate-800 border border-slate-300 dark:border-slate-800 rounded-lg transition-colors disabled:opacity-40"
            >
              <RefreshCw className="h-3.5 w-3.5" />
            </button>

            {/* Run / Submit button */}
            <button
              onClick={handleSubmit}
              disabled={isSubmitting}
              className="flex items-center space-x-1.5 px-4 py-1.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg text-xs font-bold disabled:opacity-50 transition-all active:scale-95 shadow-md shadow-indigo-600/10 hover:shadow-indigo-600/25"
            >
              {isSubmitting ? (
                <RefreshCw className="h-3.5 w-3.5 animate-spin" />
              ) : (
                <Play className="h-3.5 w-3.5" />
              )}
              <span>Submit</span>
            </button>
          </div>
        </div>

        {/* Monaco Editor Panel */}
        <div className="flex-grow bg-white dark:bg-slate-950 relative">
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
              padding: { top: 12, bottom: 12 }
            }}
          />
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

export default ProblemWorkspace;
