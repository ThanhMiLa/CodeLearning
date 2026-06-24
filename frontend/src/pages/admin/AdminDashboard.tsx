import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { 
  BookOpen, 
  Plus, 
  Edit, 
  Trash2, 
  ArrowUp, 
  ArrowDown, 
  Settings, 
  RefreshCw, 
  FolderPlus, 
  FilePlus, 
  Code,
  FolderOpen,
  ChevronRight,
  Loader2,
  ArrowLeft,
  ArrowRight,
  Trophy,
  GripVertical
} from 'lucide-react';
import { Reorder } from 'framer-motion';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import type { 
  ApiResponse, 
  CourseListItemResponse, 
  ChapterResponse, 
  LessonSummaryResponse, 
  OjAdminProblemResponse,
  PageResponse,
  ContestListResponse,
  ContestResponse
} from '../../types';

type DashboardTab = 'courses' | 'problems' | 'contests';

const AdminDashboard: React.FC = () => {
  const [activeTab, setActiveTab] = useState<DashboardTab>('courses');

  // Courses states
  const [courses, setCourses] = useState<CourseListItemResponse[]>([]);
  const [loadingCourses, setLoadingCourses] = useState(true);
  const [selectedCourseId, setSelectedCourseId] = useState<number | null>(null);
  const [curriculum, setCurriculum] = useState<ChapterResponse[]>([]);
  const [loadingCurriculum, setLoadingCurriculum] = useState(false);

  // Problems states
  const [problems, setProblems] = useState<OjAdminProblemResponse[]>([]);
  const [loadingProblems, setLoadingProblems] = useState(true);
  const [problemsPage, setProblemsPage] = useState(0);
  const [problemsTotalPages, setProblemsTotalPages] = useState(0);
  const [problemsTotalElements, setProblemsTotalElements] = useState(0);

  // Contests states
  const [contests, setContests] = useState<ContestListResponse[]>([]);
  const [loadingContests, setLoadingContests] = useState(true);
  const [contestsPage, setContestsPage] = useState(0);
  const [contestsTotalPages, setContestsTotalPages] = useState(0);
  const [contestsTotalElements, setContestsTotalElements] = useState(0);

  // Contest CRUD Modals
  const [showContestModal, setShowContestModal] = useState(false);
  const [editingContestId, setEditingContestId] = useState<number | null>(null);
  const [contestTitle, setContestTitle] = useState('');
  const [contestDesc, setContestDesc] = useState('');
  const [contestPassword, setContestPassword] = useState('');
  const [contestScoringRule, setContestScoringRule] = useState<'ICPC' | 'IOI' | 'CUSTOM'>('ICPC');
  const [contestStartTime, setContestStartTime] = useState('');
  const [contestEndTime, setContestEndTime] = useState('');
  const [savingContest, setSavingContest] = useState(false);

  // Contest Problems Management
  const [selectedContest, setSelectedContest] = useState<ContestListResponse | null>(null);
  const [contestProblems, setContestProblems] = useState<any[]>([]);
  const [loadingContestProblems, setLoadingContestProblems] = useState(false);
  const [showAddProblemToContestModal, setShowAddProblemToContestModal] = useState(false);
  const [searchProblemKeyword, setSearchProblemKeyword] = useState('');
  const [allProblemsForSelection, setAllProblemsForSelection] = useState<OjAdminProblemResponse[]>([]);
  const [loadingSelectionProblems, setLoadingSelectionProblems] = useState(false);

  // Ref to always track latest contestProblems for drag and drop without stale closures
  const contestProblemsRef = React.useRef(contestProblems);
  React.useEffect(() => {
    contestProblemsRef.current = contestProblems;
  }, [contestProblems]);

  // Modal triggers
  const [showChapterModal, setShowChapterModal] = useState(false);
  const [editingChapter, setEditingChapter] = useState<ChapterResponse | null>(null);
  const [chapterTitle, setChapterTitle] = useState('');

  const [showLessonModal, setShowLessonModal] = useState(false);
  const [editingLessonId, setEditingLessonId] = useState<number | null>(null);
  const [selectedChapterId, setSelectedChapterId] = useState<number | null>(null);
  // Lesson form
  const [lessonTitle, setLessonTitle] = useState('');
  const [lessonDesc, setLessonDesc] = useState('');
  const [lessonDuration, setLessonDuration] = useState('15');
  const [lessonTrial, setLessonTrial] = useState(false);
  const [lessonStatus, setLessonStatus] = useState('PUBLISHED');
  const [lessonTheory, setLessonTheory] = useState('');
  const [lessonSampleCode, setLessonSampleCode] = useState('');
  const [lessonVideoFile, setLessonVideoFile] = useState<File | null>(null);
  const [uploadingLesson, setUploadingLesson] = useState(false);

  // Problem creation modal
  const [showProblemModal, setShowProblemModal] = useState(false);
  const [probTitle, setProbTitle] = useState('');
  const [probDesc, setProbDesc] = useState('');
  const [probInput, setProbInput] = useState('');
  const [probOutput, setProbOutput] = useState('');
  const [probConstraints, setProbConstraints] = useState('');
  const [probExampleInput, setProbExampleInput] = useState('');
  const [probExampleOutput, setProbExampleOutput] = useState('');
  const [probHint, setProbHint] = useState('');
  const [probDifficulty, setProbDifficulty] = useState('EASY');
  const [probTimeLimit, setProbTimeLimit] = useState('1000');
  const [probMemoryLimit, setProbMemoryLimit] = useState('262144');
  const [probScore] = useState('10');
  const [savingProblem, setSavingProblem] = useState(false);

  // Fetch initial data
  useEffect(() => {
    fetchCourses();
  }, []);

  useEffect(() => {
    fetchProblems(problemsPage);
  }, [problemsPage]);

  useEffect(() => {
    if (activeTab === 'contests') {
      fetchContests(contestsPage);
    }
  }, [activeTab, contestsPage]);

  // Date converters with browser local timezone support
  const convertToIsoWithOffset = (datetimeLocalStr: string) => {
    if (!datetimeLocalStr) return '';
    const date = new Date(datetimeLocalStr);
    const tzOffset = -date.getTimezoneOffset();
    const diff = tzOffset >= 0 ? '+' : '-';
    const pad = (num: number) => String(num).padStart(2, '0');
    const offsetStr = diff + pad(Math.floor(Math.abs(tzOffset) / 60)) + ':' + pad(Math.abs(tzOffset) % 60);
    return `${datetimeLocalStr}:00${offsetStr}`;
  };

  const convertFromIsoToLocal = (isoStr: string) => {
    if (!isoStr) return '';
    const date = new Date(isoStr);
    const pad = (num: number) => String(num).padStart(2, '0');
    const yyyy = date.getFullYear();
    const MM = pad(date.getMonth() + 1);
    const dd = pad(date.getDate());
    const hh = pad(date.getHours());
    const mm = pad(date.getMinutes());
    return `${yyyy}-${MM}-${dd}T${hh}:${mm}`;
  };

  const formatDateTime = (isoStr: string) => {
    if (!isoStr) return '';
    const date = new Date(isoStr);
    return date.toLocaleString('vi-VN', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const getContestStatusColor = (status: string) => {
    switch (status) {
      case 'RUNNING': return 'text-emerald-600 bg-emerald-50 border-emerald-100 dark:text-emerald-400 dark:bg-emerald-950/30';
      case 'UPCOMING': return 'text-blue-600 bg-blue-50 border-blue-100 dark:text-blue-400 dark:bg-blue-950/30';
      case 'ENDED': return 'text-slate-500 bg-slate-50 border-slate-100 dark:text-slate-400 dark:bg-slate-950/30';
      default: return 'text-slate-500 bg-slate-50 border-slate-100';
    }
  };

  const fetchContests = async (page: number = 0) => {
    setLoadingContests(true);
    try {
      const res = await api.get<ApiResponse<PageResponse<ContestListResponse>>>('/contests', {
        params: { page, size: 10 }
      });
      const data = res.data.result;
      setContests(data.content || []);
      setContestsPage(data.page);
      setContestsTotalPages(data.totalPages);
      setContestsTotalElements(data.totalElements);
    } catch (err) {
      console.error('Failed to load contests:', err);
    } finally {
      setLoadingContests(false);
    }
  };

  const handleOpenContestModal = async (contest: ContestListResponse | null = null) => {
    if (contest) {
      setEditingContestId(contest.id);
      setContestTitle(contest.title);
      setContestScoringRule('ICPC');
      setContestPassword('');
      setContestStartTime(convertFromIsoToLocal(contest.startTime));
      setContestEndTime(convertFromIsoToLocal(contest.endTime));
      
      try {
        const res = await api.get<ApiResponse<ContestResponse>>(`/contests/${contest.id}`);
        const data = res.data.result;
        setContestDesc(data.description || '');
        setContestScoringRule(data.scoringRule);
      } catch (err) {
        console.error('Failed to load contest detail:', err);
      }
    } else {
      setEditingContestId(null);
      setContestTitle('');
      setContestDesc('');
      setContestPassword('');
      setContestScoringRule('ICPC');
      const now = new Date();
      const formatStr = (d: Date) => {
        const pad = (num: number) => String(num).padStart(2, '0');
        return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
      };
      setContestStartTime(formatStr(now));
      const end = new Date();
      end.setHours(end.getHours() + 3);
      setContestEndTime(formatStr(end));
    }
    setShowContestModal(true);
  };

  const handleSaveContest = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!contestTitle.trim() || !contestStartTime || !contestEndTime) return;

    setSavingContest(true);
    try {
      const payload: any = {
        title: contestTitle,
        description: contestDesc,
        scoringRule: contestScoringRule,
        startTime: convertToIsoWithOffset(contestStartTime),
        endTime: convertToIsoWithOffset(contestEndTime)
      };
      
      if (contestPassword.trim()) {
        payload.password = contestPassword.trim();
      }

      if (editingContestId) {
        const updatePayload = {
          title: contestTitle,
          description: contestDesc,
          scoringRule: contestScoringRule,
          startTime: convertToIsoWithOffset(contestStartTime),
          endTime: convertToIsoWithOffset(contestEndTime),
          newPassword: contestPassword.trim() || undefined
        };
        await api.put(`/contests/${editingContestId}`, updatePayload);
      } else {
        await api.post('/contests', payload);
      }
      setShowContestModal(false);
      fetchContests(contestsPage);
    } catch (err: any) {
      console.error('Failed to save contest:', err);
      alert(getErrorMessage(err));
    } finally {
      setSavingContest(false);
    }
  };

  const fetchContestProblems = async (contestId: number) => {
    setLoadingContestProblems(true);
    try {
      const res = await api.get<ApiResponse<any[]>>(`/contests/${contestId}/problems`);
      setContestProblems(res.data.result || []);
    } catch (err) {
      console.error('Failed to load contest problems:', err);
    } finally {
      setLoadingContestProblems(false);
    }
  };

  const handleRemoveProblemFromContest = async (problemId: number) => {
    if (!selectedContest) return;
    if (window.confirm('Are you sure you want to remove this problem from the contest?')) {
      try {
        await api.delete(`/contests/${selectedContest.id}/problems/${problemId}`);
        fetchContestProblems(selectedContest.id);
      } catch (err) {
        console.error('Failed to remove problem:', err);
        alert(getErrorMessage(err));
      }
    }
  };

  const handleSendReorderRequest = async () => {
    if (!selectedContest) return;
    
    const payload = contestProblemsRef.current.map((prob, idx) => ({
      problemId: Number(prob.id),
      orderIndex: idx + 1
    }));

    try {
      console.log('Sending reorder request:', payload);
      await api.put(`/contests/${Number(selectedContest.id)}/problems/reorder`, payload);
    } catch (err) {
      console.error('Failed to reorder contest problems on backend:', err);
      // Re-fetch to restore database order if API call fails
      fetchContestProblems(selectedContest.id);
    }
  };

  const fetchSelectionProblems = async () => {
    setLoadingSelectionProblems(true);
    try {
      const res = await api.get<ApiResponse<PageResponse<OjAdminProblemResponse>>>('/online-judge/admin/problems', {
        params: { page: 0, size: 100, scope: 'CONTEST' }
      });
      setAllProblemsForSelection(res.data.result.content || []);
    } catch (err) {
      console.error('Failed to fetch selection problems:', err);
    } finally {
      setLoadingSelectionProblems(false);
    }
  };

  const handleAddProblemToContest = async (problemId: number) => {
    if (!selectedContest) return;
    try {
      const contestIdNum = Number(selectedContest.id);
      const problemIdNum = Number(problemId);
      console.log('Adding problem to contest:', { contestId: contestIdNum, problemIds: [problemIdNum] });
      await api.post(`/contests/${contestIdNum}/problems`, {
        problemIds: [problemIdNum]
      });
      fetchContestProblems(selectedContest.id);
      setShowAddProblemToContestModal(false);
    } catch (err: any) {
      console.error('Failed to add problem to contest error details:', err?.response?.data || err);
      alert(getErrorMessage(err));
    }
  };

  const fetchCourses = async () => {
    setLoadingCourses(true);
    try {
      const res = await api.get<ApiResponse<any>>('/courses', {
        params: { page: 0, size: 20 }
      });
      setCourses(res.data.result.content || []);
    } catch (err) {
      console.error('Failed to load courses:', err);
    } finally {
      setLoadingCourses(false);
    }
  };

  const fetchProblems = async (page: number = 0) => {
    setLoadingProblems(true);
    try {
      const res = await api.get<ApiResponse<PageResponse<OjAdminProblemResponse>>>('/online-judge/admin/problems', {
        params: { page }
      });
      const data = res.data.result;
      setProblems(data.content || []);
      setProblemsPage(data.page);
      setProblemsTotalPages(data.totalPages);
      setProblemsTotalElements(data.totalElements);
    } catch (err) {
      console.error('Failed to load OJ problems:', err);
    } finally {
      setLoadingProblems(false);
    }
  };

  const handleToggleVisibility = async (problemId: number, currentStatus: boolean) => {
    try {
      const newStatus = !currentStatus;
      await api.put(`/online-judge/admin/problems/${problemId}/public`, null, {
        params: { isPublic: newStatus }
      });
      setProblems(prev => prev.map(p => p.id === problemId ? { ...p, isPublic: newStatus } : p));
    } catch (err) {
      console.error('Failed to update problem visibility:', err);
      alert(getErrorMessage(err));
    }
  };

  // Fetch course curriculum outline
  const fetchCurriculumOutline = async (courseId: number) => {
    setLoadingCurriculum(true);
    setSelectedCourseId(courseId);
    try {
      const res = await api.get<ApiResponse<ChapterResponse[]>>(`/courses/${courseId}/curriculum`);
      setCurriculum(res.data.result || []);
    } catch (err) {
      console.error('Failed to fetch curriculum:', err);
    } finally {
      setLoadingCurriculum(false);
    }
  };

  // CHAPTER CRUD
  const handleOpenChapterModal = (chap: ChapterResponse | null = null) => {
    if (chap) {
      setEditingChapter(chap);
      setChapterTitle(chap.title);
    } else {
      setEditingChapter(null);
      setChapterTitle('');
    }
    setShowChapterModal(true);
  };

  const handleSaveChapter = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedCourseId || !chapterTitle.trim()) return;

    try {
      if (editingChapter) {
        await api.put(`/chapters/${editingChapter.id}`, { title: chapterTitle });
      } else {
        await api.post(`/courses/${selectedCourseId}/chapters`, { title: chapterTitle });
      }
      setShowChapterModal(false);
      fetchCurriculumOutline(selectedCourseId);
    } catch (err) {
      console.error('Failed to save chapter:', err);
    }
  };

  const handleDeleteChapter = async (chapId: number) => {
    if (!selectedCourseId) return;
    if (window.confirm('Are you sure you want to delete this chapter and all lessons inside?')) {
      try {
        await api.delete(`/chapters/${chapId}`);
        fetchCurriculumOutline(selectedCourseId);
      } catch (err) {
        console.error('Failed to delete chapter:', err);
      }
    }
  };

  const handleReorderChapters = async (direction: 'up' | 'down', index: number) => {
    if (!selectedCourseId || curriculum.length <= 1) return;
    const targetIdx = direction === 'up' ? index - 1 : index + 1;
    if (targetIdx < 0 || targetIdx >= curriculum.length) return;

    // Swap locally and map order index
    const listCopy = [...curriculum];
    const temp = listCopy[index];
    listCopy[index] = listCopy[targetIdx];
    listCopy[targetIdx] = temp;

    const payload = listCopy.map((chap, idx) => ({
      id: chap.id,
      orderIndex: idx
    }));

    try {
      await api.put(`/courses/${selectedCourseId}/chapters/reorder`, payload);
      // Update local state immediately
      setCurriculum(listCopy.map((c, i) => ({ ...c, orderIndex: i })));
    } catch (err) {
      console.error('Failed to reorder chapters:', err);
      fetchCurriculumOutline(selectedCourseId);
    }
  };

  // LESSON CRUD
  const handleOpenLessonModal = async (chapId: number, lesson: LessonSummaryResponse | null = null) => {
    setSelectedChapterId(chapId);
    setLessonVideoFile(null);
    if (lesson) {
      setEditingLessonId(lesson.id);
      setLessonTitle(lesson.title);
      setLessonDuration(lesson.estimatedDurationMinutes.toString());
      setLessonTrial(lesson.trial);
      
      // Fetch details to populate description, theory, code
      try {
        const res = await api.get<ApiResponse<any>>(`/lessons/${lesson.id}`);
        const data = res.data.result;
        setLessonDesc(data.description || '');
        setLessonTheory(data.theoryContent || '');
        setLessonSampleCode(data.sampleCode || '');
      } catch (err) {
        console.error('Failed to load lesson detail:', err);
      }
    } else {
      setEditingLessonId(null);
      setLessonTitle('');
      setLessonDesc('');
      setLessonDuration('15');
      setLessonTrial(false);
      setLessonStatus('PUBLISHED');
      setLessonTheory('');
      setLessonSampleCode('');
    }
    setShowLessonModal(true);
  };

  const handleSaveLesson = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedCourseId || !selectedChapterId || !lessonTitle.trim()) return;

    setUploadingLesson(true);
    try {
      const formData = new FormData();
      formData.append('title', lessonTitle);
      formData.append('description', lessonDesc);
      formData.append('estimatedDurationMinutes', lessonDuration);
      formData.append('trial', lessonTrial.toString());
      formData.append('status', lessonStatus);
      formData.append('theoryContent', lessonTheory);
      formData.append('sampleCode', lessonSampleCode);

      if (lessonVideoFile) {
        formData.append('videoFile', lessonVideoFile);
      }

      if (editingLessonId) {
        await api.put(`/lessons/${editingLessonId}`, formData, {
          headers: { 'Content-Type': 'multipart/form-data' }
        });
      } else {
        await api.post(`/lessons/chapters/${selectedChapterId}/lessons`, formData, {
          headers: { 'Content-Type': 'multipart/form-data' }
        });
      }

      setShowLessonModal(false);
      fetchCurriculumOutline(selectedCourseId);
    } catch (err) {
      console.error('Failed to save lesson:', err);
      alert(getErrorMessage(err));
    } finally {
      setUploadingLesson(false);
    }
  };

  const handleDeleteLesson = async (lessonId: number) => {
    if (!selectedCourseId) return;
    if (window.confirm('Are you sure you want to delete this lesson from the curriculum?')) {
      try {
        await api.delete(`/lessons/${lessonId}`);
        fetchCurriculumOutline(selectedCourseId);
      } catch (err) {
        console.error('Failed to delete lesson:', err);
      }
    }
  };

  const handleReorderLessons = async (chapId: number, direction: 'up' | 'down', index: number) => {
    const chapter = curriculum.find(c => c.id === chapId);
    if (!chapter || !chapter.lessonSummaryResponses || chapter.lessonSummaryResponses.length <= 1) return;

    const targetIdx = direction === 'up' ? index - 1 : index + 1;
    if (targetIdx < 0 || targetIdx >= chapter.lessonSummaryResponses.length) return;

    const lessonsCopy = [...chapter.lessonSummaryResponses];
    const temp = lessonsCopy[index];
    lessonsCopy[index] = lessonsCopy[targetIdx];
    lessonsCopy[targetIdx] = temp;

    const payload = lessonsCopy.map((l, idx) => ({
      id: l.id,
      orderIndex: idx
    }));

    try {
      await api.put(`/lessons/chapters/${chapId}/lessons/reorder`, payload);
      // Update local state
      setCurriculum(prev => prev.map(c => {
        if (c.id === chapId) {
          return {
            ...c,
            lessonSummaryResponses: lessonsCopy.map((l, i) => ({ ...l, orderIndex: i }))
          };
        }
        return c;
      }));
    } catch (err) {
      console.error('Failed to reorder lessons:', err);
      if (selectedCourseId) fetchCurriculumOutline(selectedCourseId);
    }
  };

  // PROBLEM CRUD
  const handleSaveProblem = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!probTitle.trim()) return;

    setSavingProblem(true);
    try {
      const payload = {
        title: probTitle,
        description: probDesc,
        inputDescription: probInput,
        outputDescription: probOutput,
        constraints: probConstraints,
        exampleInput: probExampleInput,
        exampleOutput: probExampleOutput,
        hint: probHint,
        problemScope: 'PRACTICE',
        difficulty: probDifficulty,
        timeLimitMs: Number(probTimeLimit),
        memoryLimitKb: Number(probMemoryLimit),
        score: Number(probScore),
        tagIds: []
      };

      await api.post('/online-judge/admin/problems', payload);
      setShowProblemModal(false);
      fetchProblems();
      
      // Clear inputs
      setProbTitle('');
      setProbDesc('');
      setProbInput('');
      setProbOutput('');
      setProbConstraints('');
      setProbExampleInput('');
      setProbExampleOutput('');
      setProbHint('');
    } catch (err: any) {
      console.error('Failed to create problem:', err);
      alert(getErrorMessage(err));
    } finally {
      setSavingProblem(false);
    }
  };

  const getDifficultyColor = (diff: string) => {
    switch (diff) {
      case 'EASY': return 'text-emerald-600 bg-emerald-50 dark:text-emerald-400 dark:bg-emerald-950/30';
      case 'MEDIUM': return 'text-amber-600 bg-amber-50 dark:text-amber-400 dark:bg-amber-950/30';
      case 'HARD': return 'text-rose-600 bg-rose-50 dark:text-rose-400 dark:bg-rose-950/30';
      default: return '';
    }
  };

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-8 sm:px-6 lg:px-8 text-left min-h-screen">
      
      {/* Header Banner */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
        <div>
          <h1 className="text-2xl md:text-3xl font-black text-slate-950 dark:text-white tracking-tight">
            Admin Dashboard
          </h1>
          <p className="text-xs text-slate-500 dark:text-slate-400 font-semibold mt-0.5">
            Comprehensive management of courses, curriculum, quizzes, and algorithm problems.
          </p>
        </div>
        <div className="flex items-center space-x-2 shrink-0">
          <Link
            to="/admin/courses/new"
            className="inline-flex items-center space-x-1 px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/15 transition-all active:scale-95"
          >
            <FolderPlus className="h-4 w-4" />
            <span>Create Course</span>
          </Link>
          <button
            onClick={() => setShowProblemModal(true)}
            className="inline-flex items-center space-x-1 px-4 py-2 bg-purple-600 hover:bg-purple-700 text-white rounded-xl text-xs font-bold shadow-md shadow-purple-600/15 transition-all active:scale-95"
          >
            <FilePlus className="h-4 w-4" />
            <span>Create Problem</span>
          </button>
          <button
            onClick={() => handleOpenContestModal(null)}
            className="inline-flex items-center space-x-1 px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white rounded-xl text-xs font-bold shadow-md shadow-emerald-600/15 transition-all active:scale-95"
          >
            <Trophy className="h-4 w-4" />
            <span>Create Contest</span>
          </button>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex border-b border-slate-200 dark:border-slate-800 mb-6 shrink-0">
        <button
          onClick={() => setActiveTab('courses')}
          className={`py-3.5 px-6 text-xs font-extrabold tracking-wider uppercase border-b-2 transition-all ${
            activeTab === 'courses'
              ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400 font-black'
              : 'border-transparent text-slate-400 hover:text-slate-800 dark:hover:text-slate-200'
          }`}
        >
          Courses & Syllabus
        </button>
        <button
          onClick={() => setActiveTab('problems')}
          className={`py-3.5 px-6 text-xs font-extrabold tracking-wider uppercase border-b-2 transition-all ${
            activeTab === 'problems'
              ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400 font-black'
              : 'border-transparent text-slate-400 hover:text-slate-800 dark:hover:text-slate-255'
          }`}
        >
          Problem Bank (OJ)
        </button>
        <button
          onClick={() => setActiveTab('contests')}
          className={`py-3.5 px-6 text-xs font-extrabold tracking-wider uppercase border-b-2 transition-all ${
            activeTab === 'contests'
              ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400 font-black'
              : 'border-transparent text-slate-400 hover:text-slate-800 dark:hover:text-slate-200'
          }`}
        >
          Contests Management
        </button>
      </div>

      {/* 1. COURSES TAB CONTENT */}
      {activeTab === 'courses' && (
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
          
          {/* Left panel: Courses list (1/3 width) */}
          <div className="space-y-4">
            <h3 className="text-sm font-extrabold text-slate-900 dark:text-white uppercase tracking-wider flex items-center space-x-2">
              <BookOpen className="h-5 w-5 text-indigo-500" />
              <span>Courses List</span>
            </h3>

            {loadingCourses ? (
              <div className="space-y-3">
                {[1, 2].map(i => (
                  <div key={i} className="animate-pulse bg-white dark:bg-slate-900 h-20 rounded-2xl border border-slate-300 dark:border-slate-800"></div>
                ))}
              </div>
            ) : courses.length === 0 ? (
              <p className="text-xs text-slate-500">No courses found.</p>
            ) : (
              <div className="space-y-3">
                {courses.map((course) => (
                  <button
                    key={course.id}
                    onClick={() => fetchCurriculumOutline(course.id)}
                    className={`w-full p-4 rounded-2xl border text-left flex items-center justify-between transition-all ${
                      selectedCourseId === course.id
                        ? 'bg-indigo-50/70 border-indigo-500 dark:bg-indigo-950/20 dark:border-indigo-800'
                        : 'bg-white dark:bg-slate-900 border-slate-300 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/30'
                    }`}
                  >
                    <div className="space-y-1 pr-3 flex-grow overflow-hidden">
                      <h4 className="text-sm font-bold text-slate-900 dark:text-white line-clamp-1">{course.title}</h4>
                      <p className="text-[10px] text-slate-400 font-semibold uppercase">{course.price === 0 ? 'Free' : `${course.price.toLocaleString('vi-VN')} VND`}</p>
                    </div>
                    <ChevronRight className={`h-4.5 w-4.5 text-slate-400 transition-transform ${selectedCourseId === course.id ? 'translate-x-1 text-indigo-500' : ''}`} />
                  </button>
                ))}
              </div>
            )}
          </div>

          {/* Right panel: Course Curriculum Manager (2/3 width) */}
          <div className="lg:col-span-2 space-y-4">
            {selectedCourseId ? (
              <>
                <div className="flex items-center justify-between">
                  <h3 className="text-sm font-extrabold text-slate-900 dark:text-white uppercase tracking-wider flex items-center space-x-2">
                    <FolderOpen className="h-5 w-5 text-indigo-500" />
                    <span>Manage Curriculum</span>
                  </h3>
                  
                  <button
                    onClick={() => handleOpenChapterModal(null)}
                    className="inline-flex items-center space-x-1 px-3 py-1.5 bg-indigo-50 hover:bg-indigo-100 dark:bg-indigo-950/30 dark:hover:bg-indigo-950/50 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/25 rounded-xl text-xs font-bold transition-all active:scale-95"
                  >
                    <Plus className="h-4 w-4" />
                    <span>Add Chapter</span>
                  </button>
                </div>

                {loadingCurriculum ? (
                  <div className="p-12 text-center">
                    <RefreshCw className="h-8 w-8 animate-spin text-indigo-600 mx-auto" />
                  </div>
                ) : curriculum.length === 0 ? (
                  <div className="bg-white dark:bg-slate-900 rounded-3xl p-12 border border-slate-300 dark:border-slate-800 text-center text-slate-400 dark:text-slate-400">
                    <FolderPlus className="h-10 w-10 mx-auto opacity-35 mb-2" />
                    <p className="font-bold text-xs">Syllabus Empty</p>
                    <p className="text-[10px] text-slate-400 mt-0.5">Start creating chapters to build the course curriculum.</p>
                  </div>
                ) : (
                  <div className="space-y-4">
                    {curriculum.map((chapter, chapIdx) => (
                      <div
                        key={chapter.id}
                        className="bg-white dark:bg-slate-900 rounded-3xl border border-slate-300 dark:border-slate-800 p-5 shadow-sm space-y-4"
                      >
                        {/* Chapter header */}
                        <div className="flex items-start justify-between border-b border-slate-200 dark:border-slate-800 pb-3.5">
                          <div className="space-y-0.5">
                            <span className="text-[9px] font-bold text-slate-400 uppercase tracking-wider">Chapter {chapter.orderIndex + 1}</span>
                            <h4 className="text-sm font-extrabold text-slate-900 dark:text-white">{chapter.title}</h4>
                          </div>
                          
                          {/* Actions */}
                          <div className="flex items-center space-x-1 bg-slate-50 dark:bg-slate-950/40 p-1 rounded-xl">
                            <button
                              onClick={() => handleReorderChapters('up', chapIdx)}
                              disabled={chapIdx === 0}
                              className="p-1.5 text-slate-400 hover:text-slate-800 dark:hover:text-slate-200 disabled:opacity-30 transition-colors"
                            >
                              <ArrowUp className="h-4 w-4" />
                            </button>
                            <button
                              onClick={() => handleReorderChapters('down', chapIdx)}
                              disabled={chapIdx === curriculum.length - 1}
                              className="p-1.5 text-slate-400 hover:text-slate-800 dark:hover:text-slate-200 disabled:opacity-30 transition-colors"
                            >
                              <ArrowDown className="h-4 w-4" />
                            </button>
                            <button
                              onClick={() => handleOpenChapterModal(chapter)}
                              className="p-1.5 text-slate-400 hover:text-indigo-600 transition-colors"
                            >
                              <Edit className="h-4 w-4" />
                            </button>
                            <button
                              onClick={() => handleDeleteChapter(chapter.id)}
                              className="p-1.5 text-slate-400 hover:text-rose-500 transition-colors"
                            >
                              <Trash2 className="h-4 w-4" />
                            </button>
                          </div>
                        </div>

                        {/* Lessons List in chapter */}
                        <div className="space-y-2.5">
                          {chapter.lessonSummaryResponses?.map((lesson, lIdx) => (
                            <div
                              key={lesson.id}
                              className="p-3.5 rounded-2xl border border-slate-200 hover:border-slate-200/80 dark:border-slate-800 dark:hover:border-slate-800 flex items-center justify-between gap-4 transition-all bg-slate-50/20 dark:bg-slate-950/10"
                            >
                              <div className="space-y-0.5 text-left flex-grow">
                                <h5 className="text-xs font-bold text-slate-800 dark:text-slate-300">
                                  {lesson.orderIndex + 1}. {lesson.title}
                                </h5>
                                <div className="flex items-center space-x-2 text-[10px] text-slate-400 font-semibold">
                                  <span>{lesson.estimatedDurationMinutes} mins</span>
                                  {lesson.trial && (
                                    <span className="text-indigo-600 bg-indigo-50 px-1.5 py-0.5 rounded">Preview</span>
                                  )}
                                </div>
                              </div>

                              {/* Lesson operations */}
                              <div className="flex items-center space-x-3 shrink-0">
                                {/* Quiz link */}
                                <Link
                                  to={`/admin/quizzes/${lesson.id}`}
                                  className="px-2.5 py-1.5 rounded-xl border border-slate-200 dark:border-slate-800 text-[10px] font-black text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800 bg-white dark:bg-slate-900 transition-colors"
                                >
                                  Manage Quiz
                                </Link>

                                {/* Order & edit */}
                                <div className="flex items-center space-x-0.5 bg-white dark:bg-slate-905 border border-slate-200 dark:border-slate-800 p-0.5 rounded-lg">
                                  <button
                                    onClick={() => handleReorderLessons(chapter.id, 'up', lIdx)}
                                    disabled={lIdx === 0}
                                    className="p-1 text-slate-400 hover:text-slate-800 disabled:opacity-30"
                                  >
                                    <ArrowUp className="h-3 w-3" />
                                  </button>
                                  <button
                                    onClick={() => handleReorderLessons(chapter.id, 'down', lIdx)}
                                    disabled={lIdx === chapter.lessonSummaryResponses.length - 1}
                                    className="p-1 text-slate-400 hover:text-slate-800 disabled:opacity-30"
                                  >
                                    <ArrowDown className="h-3 w-3" />
                                  </button>
                                  <button
                                    onClick={() => handleOpenLessonModal(chapter.id, lesson)}
                                    className="p-1 text-slate-400 hover:text-indigo-600"
                                  >
                                    <Edit className="h-3 w-3" />
                                  </button>
                                  <button
                                    onClick={() => handleDeleteLesson(lesson.id)}
                                    className="p-1 text-slate-400 hover:text-rose-500"
                                  >
                                    <Trash2 className="h-3 w-3" />
                                  </button>
                                </div>
                              </div>

                            </div>
                          ))}

                          {/* Add lesson button */}
                          <button
                            onClick={() => handleOpenLessonModal(chapter.id, null)}
                            className="w-full py-2.5 border-2 border-dashed border-slate-200 hover:border-indigo-400 dark:border-slate-800/80 rounded-2xl flex items-center justify-center space-x-1.5 text-xs text-slate-400 hover:text-indigo-600 dark:hover:text-indigo-400 transition-all font-bold"
                          >
                            <Plus className="h-4 w-4 animate-pulse" />
                            <span>Create New Lesson</span>
                          </button>
                        </div>

                      </div>
                    ))}
                  </div>
                )}
              </>
            ) : (
              <div className="bg-white dark:bg-slate-900 rounded-3xl p-16 border border-slate-300 dark:border-slate-800 text-center text-slate-500 dark:text-slate-400 h-64 flex flex-col justify-center items-center">
                <BookOpen className="h-10 w-10 opacity-30 mb-2" />
                <p className="font-bold text-xs">No Course Selected</p>
                <p className="text-[10px] text-slate-400 mt-0.5">Please click and select a course from the left sidebar to manage curriculum.</p>
              </div>
            )}
          </div>

        </div>
      )}

      {/* 2. PROBLEMS TAB CONTENT */}
      {activeTab === 'problems' && (
        <div className="bg-white dark:bg-slate-900 rounded-3xl border border-slate-300 dark:border-slate-800 shadow-sm overflow-hidden">
          {loadingProblems ? (
            <div className="p-12 text-center">
              <RefreshCw className="h-8 w-8 animate-spin text-indigo-600 mx-auto" />
            </div>
          ) : problems.length === 0 ? (
            <div className="p-16 text-center text-slate-500">
              <Code className="h-12 w-12 mx-auto opacity-30 mb-3" />
              <p className="font-bold text-xs">Problem bank empty</p>
              <button
                onClick={() => setShowProblemModal(true)}
                className="mt-4 inline-flex items-center space-x-1 px-4 py-2 bg-indigo-600 text-white rounded-xl text-xs font-bold"
              >
                <Plus className="h-4 w-4" />
                <span>Add New Problem</span>
              </button>
            </div>
          ) : (
            <div>
              <div className="overflow-x-auto select-none text-left">
                <table className="w-full min-w-[700px] border-collapse text-sm">
                  <thead>
                    <tr className="border-b border-slate-200 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/20 text-slate-400 dark:text-slate-400 font-bold uppercase tracking-wider text-[10px]">
                      <th className="px-6 py-4">Problem Name</th>
                      <th className="px-6 py-4 w-32">Difficulty</th>
                      <th className="px-6 py-4 w-36 text-center">Visibility</th>
                      <th className="px-6 py-4 w-40 text-center">Submissions</th>
                      <th className="px-6 py-4 w-48 text-center">Config</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-200 dark:divide-slate-800">
                    {problems.map((prob) => (
                      <tr key={prob.id} className="hover:bg-slate-50/40 dark:hover:bg-slate-800/10 transition-colors">
                        <td className="px-6 py-4 font-bold text-slate-800 dark:text-white">
                          {prob.title}
                        </td>
                        <td className="px-6 py-4">
                          <span className={`inline-flex px-2 py-0.5 rounded-full text-[10px] font-bold border ${getDifficultyColor(prob.difficulty)}`}>
                            {prob.difficulty === 'EASY' ? 'Easy' : prob.difficulty === 'MEDIUM' ? 'Medium' : 'Hard'}
                          </span>
                        </td>
                        <td className="px-6 py-4 text-center">
                          <button
                            onClick={() => handleToggleVisibility(prob.id, prob.isPublic)}
                            className="inline-flex items-center space-x-2 focus:outline-none cursor-pointer"
                          >
                            <div className={`relative w-10 h-5.5 rounded-full transition-colors duration-200 ${prob.isPublic ? 'bg-indigo-600' : 'bg-slate-300 dark:bg-slate-700'}`}>
                              <div className={`absolute top-0.5 left-0.5 bg-white w-4.5 h-4.5 rounded-full shadow transition-transform duration-200 ${prob.isPublic ? 'translate-x-4.5' : 'translate-x-0'}`} />
                            </div>
                            <span className={`text-xs font-bold ${prob.isPublic ? 'text-indigo-600 dark:text-indigo-400' : 'text-slate-500 dark:text-slate-400'}`}>
                              {prob.isPublic ? 'Public' : 'Private'}
                            </span>
                          </button>
                        </td>
                        <td className="px-6 py-4 text-center text-xs font-semibold text-slate-500">
                          {prob.totalSubmissions}
                        </td>
                        <td className="px-6 py-4 text-center">
                          <Link
                            to={`/admin/problems/${prob.id}/testcases`}
                            className="inline-flex items-center space-x-1 px-3 py-1.5 bg-indigo-50 hover:bg-indigo-100 dark:bg-indigo-950/30 dark:hover:bg-indigo-950/50 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/20 rounded-xl text-xs font-bold transition-all shadow-sm"
                          >
                            <Settings className="h-3.5 w-3.5" />
                            <span>Sinh Testcases</span>
                          </Link>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {/* Pagination for Problems */}
              {problemsTotalPages > 1 && (
                <div className="flex items-center justify-between border-t border-slate-200 dark:border-slate-800 p-6 bg-slate-50/20 dark:bg-slate-950/10">
                  <div className="text-xs text-slate-500 dark:text-slate-400 font-semibold">
                    Showing <span className="text-slate-800 dark:text-white">{(problemsPage * 20) + 1}</span> to{' '}
                    <span className="text-slate-800 dark:text-white">
                      {Math.min((problemsPage + 1) * 20, problemsTotalElements)}
                    </span>{' '}
                    of <span className="text-slate-800 dark:text-white">{problemsTotalElements}</span> problems
                  </div>
                  <div className="flex items-center space-x-2">
                    <button
                      onClick={() => setProblemsPage(prev => Math.max(prev - 1, 0))}
                      disabled={problemsPage === 0}
                      className="p-2 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800/50 disabled:opacity-40 transition-colors cursor-pointer"
                    >
                      <ArrowLeft className="h-4 w-4 dark:text-white" />
                    </button>
                    
                    <div className="flex items-center space-x-1.5">
                      {Array.from({ length: problemsTotalPages }, (_, idx) => {
                        if (idx === problemsPage || idx === 0 || idx === problemsTotalPages - 1 || Math.abs(idx - problemsPage) <= 1) {
                          return (
                            <button
                              key={idx}
                              onClick={() => setProblemsPage(idx)}
                              className={`px-3 py-1.5 text-xs font-bold rounded-xl border transition-all cursor-pointer ${
                                problemsPage === idx
                                  ? 'bg-indigo-600 text-white border-indigo-600 shadow-sm shadow-indigo-600/15'
                                  : 'border-slate-200 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/50 dark:text-slate-300'
                              }`}
                            >
                              {idx + 1}
                            </button>
                          );
                        } else if (idx === 1 || idx === problemsTotalPages - 2) {
                          return <span key={idx} className="text-slate-400 dark:text-slate-600 px-1">...</span>;
                        }
                        return null;
                      })}
                    </div>

                    <button
                      onClick={() => setProblemsPage(prev => Math.min(prev + 1, problemsTotalPages - 1))}
                      disabled={problemsPage === problemsTotalPages - 1}
                      className="p-2 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800/50 disabled:opacity-40 transition-colors cursor-pointer"
                    >
                      <ArrowRight className="h-4 w-4 dark:text-white" />
                    </button>
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {/* 3. CONTESTS TAB CONTENT */}
      {activeTab === 'contests' && (
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
          
          {/* Left panel: Contests list (1/3 width) */}
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <h3 className="text-sm font-extrabold text-slate-900 dark:text-white uppercase tracking-wider flex items-center space-x-2">
                <Trophy className="h-5 w-5 text-indigo-500" />
                <span>Contests List ({contestsTotalElements})</span>
              </h3>
              <button
                onClick={() => handleOpenContestModal(null)}
                className="inline-flex items-center space-x-1 px-3 py-1.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold transition-all active:scale-95 cursor-pointer"
              >
                <Plus className="h-3.5 w-3.5" />
                <span>Create Contest</span>
              </button>
            </div>

            {loadingContests ? (
              <div className="space-y-3">
                {[1, 2].map(i => (
                  <div key={i} className="animate-pulse bg-white dark:bg-slate-900 h-20 rounded-2xl border border-slate-300 dark:border-slate-800"></div>
                ))}
              </div>
            ) : contests.length === 0 ? (
              <p className="text-xs text-slate-500">No contests found.</p>
            ) : (
              <div className="space-y-3">
                {contests.map((c) => (
                  <button
                    key={c.id}
                    onClick={() => {
                      setSelectedContest(c);
                      fetchContestProblems(c.id);
                    }}
                    className={`w-full p-4 rounded-2xl border text-left flex items-center justify-between transition-all ${
                      selectedContest?.id === c.id
                        ? 'bg-indigo-50/70 border-indigo-500 dark:bg-indigo-950/20 dark:border-indigo-800'
                        : 'bg-white dark:bg-slate-900 border-slate-300 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/30'
                    }`}
                  >
                    <div className="space-y-1 pr-3 flex-grow overflow-hidden">
                      <div className="flex items-center justify-between">
                        <span className={`inline-flex px-1.5 py-0.5 rounded-full text-[9px] font-bold border ${getContestStatusColor(c.status)}`}>
                          {c.status}
                        </span>
                      </div>
                      <h4 className="text-sm font-bold text-slate-900 dark:text-white line-clamp-1">{c.title}</h4>
                      <p className="text-[10px] text-slate-400 font-semibold uppercase">{formatDateTime(c.startTime)}</p>
                    </div>
                    <ChevronRight className={`h-4.5 w-4.5 text-slate-400 transition-transform ${selectedContest?.id === c.id ? 'translate-x-1 text-indigo-500' : ''}`} />
                  </button>
                ))}

                {/* Contests Pagination */}
                {contestsTotalPages > 1 && (
                  <div className="flex items-center justify-between pt-4 border-t border-slate-200 dark:border-slate-800 select-none">
                    <button
                      onClick={() => setContestsPage(prev => Math.max(prev - 1, 0))}
                      disabled={contestsPage === 0}
                      className="p-1.5 border border-slate-200 dark:border-slate-800 rounded-xl disabled:opacity-30 cursor-pointer bg-white dark:bg-slate-900 text-slate-700 dark:text-slate-300"
                    >
                      <ArrowLeft className="h-3.5 w-3.5" />
                    </button>
                    <span className="text-xs text-slate-500 font-bold dark:text-slate-400">
                      Page {contestsPage + 1} of {contestsTotalPages}
                    </span>
                    <button
                      onClick={() => setContestsPage(prev => Math.min(prev + 1, contestsTotalPages - 1))}
                      disabled={contestsPage === contestsTotalPages - 1}
                      className="p-1.5 border border-slate-200 dark:border-slate-800 rounded-xl disabled:opacity-30 cursor-pointer bg-white dark:bg-slate-900 text-slate-700 dark:text-slate-300"
                    >
                      <ArrowRight className="h-3.5 w-3.5" />
                    </button>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Right panel: Contest Problems Manager (2/3 width) */}
          <div className="lg:col-span-2 space-y-4">
            {selectedContest ? (
              <>
                {/* Contest Info Card */}
                <div className="bg-white dark:bg-slate-900 rounded-3xl border border-slate-300 dark:border-slate-800 p-6 shadow-sm space-y-4 text-left">
                  <div className="flex items-start justify-between">
                    <div className="space-y-1">
                      <div className="flex items-center space-x-2">
                        <h4 className="text-lg font-black text-slate-950 dark:text-white">{selectedContest.title}</h4>
                        <span className="text-[10px] font-bold bg-indigo-50 dark:bg-indigo-950/40 text-indigo-700 dark:text-indigo-300 px-2 py-0.5 rounded border border-indigo-100 dark:border-indigo-900/35">
                          {selectedContest.status}
                        </span>
                      </div>
                      <p className="text-xs text-slate-450 dark:text-slate-400 font-medium">
                        Starts: {formatDateTime(selectedContest.startTime)} | Ends: {formatDateTime(selectedContest.endTime)}
                      </p>
                    </div>
                    <button
                      onClick={() => handleOpenContestModal(selectedContest)}
                      className="inline-flex items-center space-x-1 px-3 py-1.5 border border-slate-200 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800 text-slate-700 dark:text-slate-300 rounded-xl text-xs font-bold transition-all cursor-pointer"
                    >
                      <Edit className="h-4 w-4" />
                      <span>Edit Contest Info</span>
                    </button>
                  </div>
                </div>

                {/* Problems Management for Contest */}
                <div className="flex items-center justify-between pt-2">
                  <h3 className="text-sm font-extrabold text-slate-900 dark:text-white uppercase tracking-wider flex items-center space-x-2">
                    <Code className="h-5 w-5 text-indigo-500" />
                    <span>Contest Problems</span>
                  </h3>
                  
                  <button
                    onClick={() => {
                      fetchSelectionProblems();
                      setShowAddProblemToContestModal(true);
                    }}
                    className="inline-flex items-center space-x-1 px-3 py-1.5 bg-indigo-50 hover:bg-indigo-100 dark:bg-indigo-950/30 dark:hover:bg-indigo-950/50 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/25 rounded-xl text-xs font-bold transition-all active:scale-95 cursor-pointer"
                  >
                    <Plus className="h-4 w-4" />
                    <span>Assign Problem</span>
                  </button>
                </div>

                {loadingContestProblems ? (
                  <div className="p-12 text-center">
                    <RefreshCw className="h-8 w-8 animate-spin text-indigo-600 mx-auto" />
                  </div>
                ) : contestProblems.length === 0 ? (
                  <div className="bg-white dark:bg-slate-900 rounded-3xl p-12 border border-slate-300 dark:border-slate-800 text-center text-slate-400 dark:text-slate-400">
                    <Code className="h-10 w-10 mx-auto opacity-35 mb-2" />
                    <p className="font-bold text-xs">No Problems Assigned</p>
                    <p className="text-[10px] text-slate-400 mt-0.5">Start assigning problems from the Problem Bank to this contest.</p>
                  </div>
                ) : (
                  <Reorder.Group
                    axis="y"
                    values={contestProblems}
                    onReorder={setContestProblems}
                    className="space-y-3"
                  >
                    {contestProblems.map((prob, lIdx) => (
                      <Reorder.Item
                        key={prob.id}
                        value={prob}
                        onDragEnd={handleSendReorderRequest}
                        className="p-4 rounded-2xl border border-slate-200 dark:border-slate-800 flex items-center justify-between gap-4 bg-white dark:bg-slate-900 cursor-grab active:cursor-grabbing select-none hover:border-slate-350 dark:hover:border-slate-700 shadow-sm"
                      >
                        <div className="flex items-center space-x-3 text-left flex-grow">
                          <GripVertical className="h-4 w-4 text-slate-400 shrink-0 cursor-grab" />
                          <div className="space-y-0.5">
                            <h5 className="text-xs font-bold text-slate-800 dark:text-slate-300">
                              {String.fromCharCode(65 + lIdx)}. {prob.title}
                            </h5>
                          </div>
                        </div>

                        {/* Actions */}
                        <div className="flex items-center">
                          <button
                            onClick={(e) => {
                              e.stopPropagation();
                              handleRemoveProblemFromContest(prob.id);
                            }}
                            className="p-1.5 text-slate-400 hover:text-rose-500 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-850 transition-colors cursor-pointer"
                          >
                            <Trash2 className="h-3.5 w-3.5" />
                          </button>
                        </div>
                      </Reorder.Item>
                    ))}
                  </Reorder.Group>
                )}
              </>
            ) : (
              <div className="bg-white dark:bg-slate-900 rounded-3xl p-16 border border-slate-300 dark:border-slate-800 text-center text-slate-500 dark:text-slate-400 h-64 flex flex-col justify-center items-center">
                <Trophy className="h-10 w-10 opacity-30 mb-2" />
                <p className="font-bold text-xs">No Contest Selected</p>
                <p className="text-[10px] text-slate-400 mt-0.5">Please click and select a contest from the left sidebar to manage details and problems.</p>
              </div>
            )}
          </div>

        </div>
      )}

      {/* CONTEST MODAL */}
      {showContestModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm overflow-y-auto">
          <div className="w-full max-w-lg bg-white dark:bg-slate-900 rounded-3xl border border-slate-200 dark:border-slate-800 p-6 md:p-8 space-y-6 shadow-2xl relative text-left my-8">
            <h3 className="text-base font-black text-slate-950 dark:text-white">
              {editingContestId ? 'Edit Contest' : 'Create New Contest'}
            </h3>
            
            <form onSubmit={handleSaveContest} className="space-y-5">
              {/* Title */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Contest Title:</label>
                <input
                  type="text"
                  required
                  placeholder="Example: ACM-ICPC Round 1"
                  value={contestTitle}
                  onChange={(e) => setContestTitle(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                />
              </div>

              {/* Description */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Description:</label>
                <textarea
                  rows={3}
                  placeholder="Details about participation rules..."
                  value={contestDesc}
                  onChange={(e) => setContestDesc(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                />
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Scoring Rule */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Scoring Rule:</label>
                  <select
                    value={contestScoringRule}
                    onChange={(e: any) => setContestScoringRule(e.target.value)}
                    className="w-full px-3 py-2.5 rounded-xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/20 text-xs focus:outline-none focus:ring-2 focus:ring-indigo-500/20"
                  >
                    <option value="ICPC">ICPC</option>
                    <option value="IOI">IOI</option>
                    <option value="CUSTOM">Custom</option>
                  </select>
                </div>

                {/* Password */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Participation Password (Optional):</label>
                  <input
                    type="password"
                    placeholder="Leave blank for public access"
                    value={contestPassword}
                    onChange={(e) => setContestPassword(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Start Time */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Start Time:</label>
                  <input
                    type="datetime-local"
                    required
                    value={contestStartTime}
                    onChange={(e) => setContestStartTime(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                  />
                </div>

                {/* End Time */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">End Time:</label>
                  <input
                    type="datetime-local"
                    required
                    value={contestEndTime}
                    onChange={(e) => setContestEndTime(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3 pt-2">
                <button
                  type="button"
                  onClick={() => setShowContestModal(false)}
                  disabled={savingContest}
                  className="px-4 py-2.5 border border-slate-200 dark:border-slate-800 rounded-xl text-xs font-bold text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors cursor-pointer"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={savingContest}
                  className="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/15 cursor-pointer flex justify-center items-center"
                >
                  {savingContest ? <Loader2 className="h-4 w-4 animate-spin" /> : 'Save'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* ASSIGN PROBLEM TO CONTEST MODAL */}
      {showAddProblemToContestModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm">
          <div className="w-full max-w-lg bg-white dark:bg-slate-900 rounded-3xl border border-slate-200 dark:border-slate-800 p-6 md:p-8 space-y-4 shadow-2xl relative text-left">
            <h3 className="text-base font-black text-slate-950 dark:text-white">
              Assign Problem to Contest
            </h3>
            
            {/* Search filter input */}
            <input
              type="text"
              placeholder="Search problems by name..."
              value={searchProblemKeyword}
              onChange={(e) => setSearchProblemKeyword(e.target.value)}
              className="w-full px-4 py-2 rounded-xl border border-slate-350 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 text-slate-900 dark:text-white"
            />

            {/* List of problems */}
            <div className="max-h-64 overflow-y-auto divide-y divide-slate-100 dark:divide-slate-800 border border-slate-200 dark:border-slate-850 rounded-2xl bg-slate-50/20 dark:bg-slate-950/10">
              {loadingSelectionProblems ? (
                <div className="p-8 text-center">
                  <Loader2 className="h-6 w-6 animate-spin text-indigo-600 mx-auto" />
                </div>
              ) : allProblemsForSelection.filter(p => p.title.toLowerCase().includes(searchProblemKeyword.toLowerCase())).length === 0 ? (
                <p className="text-xs text-slate-500 p-4 text-center">No matching problems found.</p>
              ) : (
                allProblemsForSelection
                  .filter(p => p.title.toLowerCase().includes(searchProblemKeyword.toLowerCase()))
                  .map((prob) => {
                    const isAlreadyAssigned = contestProblems.some(cp => cp.id === prob.id);
                    return (
                      <div key={prob.id} className="flex items-center justify-between p-3.5">
                        <div>
                          <p className="text-xs font-bold text-slate-800 dark:text-slate-300">{prob.title}</p>
                          <p className="text-[10px] text-slate-400 font-semibold uppercase">{prob.difficulty}</p>
                        </div>
                        <button
                          onClick={() => handleAddProblemToContest(prob.id)}
                          disabled={isAlreadyAssigned}
                          className={`px-3 py-1 rounded-lg text-[10px] font-black tracking-wider uppercase border transition-all ${
                            isAlreadyAssigned
                              ? 'bg-slate-100 text-slate-400 border-slate-200 dark:bg-slate-800 dark:border-slate-700/50'
                              : 'bg-indigo-600 text-white border-indigo-600 hover:bg-indigo-700 shadow-sm shadow-indigo-600/10 cursor-pointer active:scale-95'
                          }`}
                        >
                          {isAlreadyAssigned ? 'Assigned' : 'Select'}
                        </button>
                      </div>
                    );
                  })
              )}
            </div>

            <div className="flex justify-end pt-2">
              <button
                type="button"
                onClick={() => {
                  setShowAddProblemToContestModal(false);
                  setSearchProblemKeyword('');
                }}
                className="px-4 py-2 border border-slate-200 dark:border-slate-800 rounded-xl text-xs font-bold text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors cursor-pointer"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}

      {/* CHAPTER MODAL */}
      {showChapterModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm">
          <div className="w-full max-w-md bg-white dark:bg-slate-900 rounded-3xl border border-slate-200 dark:border-slate-800 p-6 md:p-8 space-y-6 shadow-2xl relative text-left">
            <h3 className="text-base font-black text-slate-950 dark:text-white">
              {editingChapter ? 'Edit Chapter' : 'Add New Chapter'}
            </h3>
            <form onSubmit={handleSaveChapter} className="space-y-4">
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Chapter Title (Required):</label>
                <input
                  type="text"
                  required
                  placeholder="Example: Chapter 1: Introduction..."
                  value={chapterTitle}
                  onChange={(e) => setChapterTitle(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                />
              </div>
              <div className="grid grid-cols-2 gap-3 pt-2">
                <button
                  type="button"
                  onClick={() => setShowChapterModal(false)}
                  className="px-4 py-2.5 border border-slate-200 dark:border-slate-800 rounded-xl text-xs font-bold text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="px-4 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/15"
                >
                  Save
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* LESSON MODAL */}
      {showLessonModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm overflow-y-auto">
          <div className="w-full max-w-2xl bg-white dark:bg-slate-900 rounded-3xl border border-slate-200 dark:border-slate-800 p-6 md:p-8 space-y-6 shadow-2xl relative text-left my-8">
            <h3 className="text-base font-black text-slate-950 dark:text-white">
              {editingLessonId ? 'Edit Lesson' : 'Add New Lesson'}
            </h3>
            
            <form onSubmit={handleSaveLesson} className="space-y-5">
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Title */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Lesson Title:</label>
                  <input
                    type="text"
                    required
                    placeholder="Example: Number Data Type"
                    value={lessonTitle}
                    onChange={(e) => setLessonTitle(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                  />
                </div>

                {/* Duration */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Duration (Minutes):</label>
                  <input
                    type="number"
                    min="1"
                    required
                    value={lessonDuration}
                    onChange={(e) => setLessonDuration(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                  />
                </div>
              </div>

              {/* Status and Trial */}
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Status:</label>
                  <select
                    value={lessonStatus}
                    onChange={(e) => setLessonStatus(e.target.value)}
                    className="w-full px-3 py-2 rounded-xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/20 text-xs focus:outline-none focus:ring-2 focus:ring-indigo-500/20"
                  >
                    <option value="PUBLISHED">Published</option>
                    <option value="DRAFT">Draft</option>
                  </select>
                </div>
                
                <div className="flex items-center space-x-2 pt-6">
                  <input
                    type="checkbox"
                    id="trial-check"
                    checked={lessonTrial}
                    onChange={(e) => setLessonTrial(e.target.checked)}
                    className="h-4.5 w-4.5 text-indigo-600 focus:ring-indigo-500 border-slate-300 rounded"
                  />
                  <label htmlFor="trial-check" className="text-xs font-bold text-slate-600 dark:text-slate-400">Allow Preview (Trial)</label>
                </div>
              </div>

              {/* Description */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Lesson Description:</label>
                <textarea
                  rows={2}
                  placeholder="Enter lesson description..."
                  value={lessonDesc}
                  onChange={(e) => setLessonDesc(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none dark:text-white font-semibold"
                />
              </div>

              {/* Video file upload */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                  Upload Lecture Video (MP4 - Optional):
                </label>
                <input
                  type="file"
                  accept="video/*"
                  onChange={(e) => {
                    if (e.target.files && e.target.files[0]) {
                      setLessonVideoFile(e.target.files[0]);
                    }
                  }}
                  className="w-full text-xs text-slate-500 dark:text-slate-400 file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:text-xs file:font-bold file:bg-indigo-50 file:text-indigo-600 hover:file:bg-indigo-100"
                />
              </div>

              {/* Theory Content */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Theory Content (Markdown):</label>
                <textarea
                  rows={4}
                  placeholder="Enter theory content..."
                  value={lessonTheory}
                  onChange={(e) => setLessonTheory(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs font-mono focus:outline-none dark:text-white"
                />
              </div>

              {/* Sample Code */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Reference Source Code:</label>
                <textarea
                  rows={3}
                  placeholder="Paste reference code here..."
                  value={lessonSampleCode}
                  onChange={(e) => setLessonSampleCode(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-900/40 text-xs font-mono focus:outline-none dark:text-white"
                />
              </div>

              {/* Footer buttons */}
              <div className="flex justify-end space-x-3 pt-4 border-t border-slate-200 dark:border-slate-800">
                <button
                  type="button"
                  onClick={() => setShowLessonModal(false)}
                  disabled={uploadingLesson}
                  className="px-4 py-2.5 border border-slate-200 dark:border-slate-800 rounded-xl text-xs font-bold text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={uploadingLesson}
                  className="px-5 py-2.5 bg-indigo-600 hover:bg-indigo-700 disabled:opacity-50 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/15 flex items-center space-x-1.5"
                >
                  {uploadingLesson ? (
                    <Loader2 className="h-4 w-4 animate-spin" />
                  ) : (
                    <span>Save Lesson</span>
                  )}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* CREATE PROBLEM MODAL */}
      {showProblemModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm overflow-y-auto">
          <div className="w-full max-w-2xl bg-white dark:bg-slate-900 rounded-3xl border border-slate-200 dark:border-slate-800 p-6 md:p-8 space-y-6 shadow-2xl relative text-left my-8">
            <h3 className="text-base font-black text-slate-950 dark:text-white">
              Create New OJ Problem
            </h3>
            
            <form onSubmit={handleSaveProblem} className="space-y-4">
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Title */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Problem Title (Required):</label>
                  <input
                    type="text"
                    required
                    placeholder="Example: Calculate Sum of 2 Numbers"
                    value={probTitle}
                    onChange={(e) => setProbTitle(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                  />
                </div>

                {/* Difficulty */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Difficulty:</label>
                  <select
                    value={probDifficulty}
                    onChange={(e) => setProbDifficulty(e.target.value)}
                    className="w-full px-3 py-2.5 rounded-xl border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/20 text-xs focus:outline-none"
                  >
                    <option value="EASY">Easy (Easy)</option>
                    <option value="MEDIUM">Medium (Medium)</option>
                    <option value="HARD">Hard (Hard)</option>
                  </select>
                </div>
              </div>

              {/* Description */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Problem Description:</label>
                <textarea
                  rows={3}
                  required
                  placeholder="Enter detailed description..."
                  value={probDesc}
                  onChange={(e) => setProbDesc(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none dark:text-white"
                />
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Input Desc */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Input Description:</label>
                  <textarea
                    rows={2}
                    placeholder="Single line containing 2 integers..."
                    value={probInput}
                    onChange={(e) => setProbInput(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none dark:text-white"
                  />
                </div>
                {/* Output Desc */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Output Description:</label>
                  <textarea
                    rows={2}
                    placeholder="Sum of 2 integers..."
                    value={probOutput}
                    onChange={(e) => setProbOutput(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none dark:text-white"
                  />
                </div>
              </div>

              {/* Constraints */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Constraints:</label>
                <input
                  type="text"
                  placeholder="-10^9 <= A, B <= 10^9"
                  value={probConstraints}
                  onChange={(e) => setProbConstraints(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none dark:text-white"
                />
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Time limits */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Time Limit (ms) (Min 1000):</label>
                  <input
                    type="number"
                    min="1000"
                    value={probTimeLimit}
                    onChange={(e) => setProbTimeLimit(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none dark:text-white"
                  />
                </div>
                {/* Memory limit */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Memory Limit (KB):</label>
                  <input
                    type="number"
                    min="256000"
                    value={probMemoryLimit}
                    onChange={(e) => setProbMemoryLimit(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none dark:text-white"
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {/* Example Input */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Example Input:</label>
                  <input
                    type="text"
                    placeholder="2 3"
                    value={probExampleInput}
                    onChange={(e) => setProbExampleInput(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs font-mono focus:outline-none dark:text-white"
                  />
                </div>
                {/* Example Output */}
                <div className="space-y-1.5">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Example Output:</label>
                  <input
                    type="text"
                    placeholder="5"
                    value={probExampleOutput}
                    onChange={(e) => setProbExampleOutput(e.target.value)}
                    className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs font-mono focus:outline-none dark:text-white"
                  />
                </div>
              </div>

              {/* Hint */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Hints:</label>
                <input
                  type="text"
                  placeholder="Enter hints..."
                  value={probHint}
                  onChange={(e) => setProbHint(e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none dark:text-white"
                />
              </div>

              {/* Footer actions */}
              <div className="flex justify-end space-x-3 pt-4 border-t border-slate-200 dark:border-slate-800">
                <button
                  type="button"
                  onClick={() => setShowProblemModal(false)}
                  disabled={savingProblem}
                  className="px-4 py-2.5 border border-slate-200 dark:border-slate-800 rounded-xl text-xs font-bold text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={savingProblem}
                  className="px-5 py-2.5 bg-indigo-600 hover:bg-indigo-700 disabled:opacity-50 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/15 flex items-center space-x-1.5"
                >
                  {savingProblem ? (
                    <RefreshCw className="h-4 w-4 animate-spin" />
                  ) : (
                    <span>Save Problem</span>
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

export default AdminDashboard;
