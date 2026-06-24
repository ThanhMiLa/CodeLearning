import React, { useState, useEffect, useMemo } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { 
  Play, 
  Check, 
  CheckCircle2, 
  Circle, 
  ChevronDown, 
  ChevronUp, 
  BookOpen, 
  ArrowLeft, 
  ArrowRight, 
  Copy, 
  FileText, 
  Loader2, 
  AlertCircle,
  Code
} from 'lucide-react';
import api from '../../api/axios';
import type { 
  ApiResponse, 
  ChapterResponse, 
  LessonDetailResponse, 
  LessonCompletionResponse
} from '../../types';
import CommentSection from '../../components/learning/CommentSection';

type TabType = 'curriculum' | 'comments';
type MobileTabType = 'content' | 'curriculum' | 'comments';

const LearningWorkspace: React.FC = () => {
  const { courseId, lessonId } = useParams<{ courseId: string; lessonId: string }>();
  const navigate = useNavigate();

  const courseIdNum = Number(courseId);
  const lessonIdNum = Number(lessonId);

  // States
  const [lesson, setLesson] = useState<LessonDetailResponse | null>(null);
  const [chapters, setChapters] = useState<ChapterResponse[]>([]);
  
  const [isLessonLoading, setIsLessonLoading] = useState(true);
  const [isCurriculumLoading, setIsCurriculumLoading] = useState(true);
  const [isCompleting, setIsCompleting] = useState(false);
  const [lessonError, setLessonError] = useState<string | null>(null);
  
  // Right sidebar tab state (desktop only)
  const [sidebarTab, setSidebarTab] = useState<TabType>('curriculum');
  
  // Mobile tab state
  const [mobileTab, setMobileTab] = useState<MobileTabType>('content');

  // Accordion of chapters expanded state
  const [expandedChapters, setExpandedChapters] = useState<number[]>([]);

  // Copy code indicator
  const [copiedCode, setCopiedCode] = useState(false);

  // Fetch lesson details
  useEffect(() => {
    const fetchLessonDetails = async () => {
      if (!lessonId) return;
      setIsLessonLoading(true);
      setLessonError(null);
      try {
        const res = await api.get<ApiResponse<LessonDetailResponse>>(`/lessons/${lessonId}`);
        setLesson(res.data.result);
      } catch (error: any) {
        console.error('Failed to fetch lesson details:', error);
        const errorMsg = error?.response?.data?.message || 'You cannot access this lesson. Please check if you have purchased or enrolled in this course.';
        setLessonError(errorMsg);
      } finally {
        setIsLessonLoading(false);
      }
    };
    fetchLessonDetails();
  }, [lessonId]);

  // Fetch curriculum details
  useEffect(() => {
    const fetchCurriculum = async () => {
      if (!courseId) return;
      setIsCurriculumLoading(true);
      try {
        const res = await api.get<ApiResponse<ChapterResponse[]>>(`/courses/${courseId}/curriculum`);
        const curriculum = res.data.result || [];
        setChapters(curriculum);
        
        // Expand the chapter that contains the active lesson by default
        const activeChapter = curriculum.find(ch => 
          ch.lessonSummaryResponses?.some(l => l.id === lessonIdNum)
        );
        if (activeChapter) {
          setExpandedChapters(prev => 
            prev.includes(activeChapter.id) ? prev : [...prev, activeChapter.id]
          );
        } else if (curriculum.length > 0) {
          setExpandedChapters([curriculum[0].id]);
        }
      } catch (error) {
        console.error('Failed to fetch curriculum:', error);
      } finally {
        setIsCurriculumLoading(false);
      }
    };
    fetchCurriculum();
  }, [courseId, lessonIdNum]);

  // Flatten lessons list to calculate next / prev navigation
  const flatLessons = useMemo(() => {
    return chapters.flatMap(chapter => chapter.lessonSummaryResponses || []);
  }, [chapters]);

  const currentLessonIndex = useMemo(() => {
    return flatLessons.findIndex(l => l.id === lessonIdNum);
  }, [flatLessons, lessonIdNum]);

  const prevLesson = currentLessonIndex > 0 ? flatLessons[currentLessonIndex - 1] : null;
  const nextLesson = currentLessonIndex < flatLessons.length - 1 ? flatLessons[currentLessonIndex + 1] : null;

  const currentLessonSummary = useMemo(() => {
    return flatLessons.find(l => l.id === lessonIdNum);
  }, [flatLessons, lessonIdNum]);

  const isCurrentLessonCompleted = currentLessonSummary?.isCompleted || false;

  // Toggle chapter accordion
  const toggleChapter = (id: number) => {
    setExpandedChapters(prev => 
      prev.includes(id) ? prev.filter(cId => cId !== id) : [...prev, id]
    );
  };

  // Complete lesson handler
  const handleCompleteLesson = async (targetLessonId?: number) => {
    const idToComplete = targetLessonId ?? lessonIdNum;
    if (!idToComplete) return;

    // Find target lesson to check if already completed
    const targetLesson = flatLessons.find(l => l.id === idToComplete);
    if (!targetLesson || targetLesson.isCompleted) return;

    const isCurrent = idToComplete === lessonIdNum;
    if (isCurrent) {
      setIsCompleting(true);
    }

    try {
      await api.post<ApiResponse<LessonCompletionResponse>>(`/lessons/${idToComplete}/complete`);
      // Update local state in chapters
      setChapters(prevChapters => 
        prevChapters.map(chapter => ({
          ...chapter,
          lessonSummaryResponses: chapter.lessonSummaryResponses.map(l => 
            l.id === idToComplete ? { ...l, isCompleted: true } : l
          )
        }))
      );
    } catch (error) {
      console.error('Failed to mark lesson completed:', error);
    } finally {
      if (isCurrent) {
        setIsCompleting(false);
      }
    }
  };

  // Copy code handler
  const handleCopyCode = (code: string) => {
    navigator.clipboard.writeText(code);
    setCopiedCode(true);
    setTimeout(() => setCopiedCode(false), 2000);
  };

  // Parse YouTube embeds
  const getYouTubeEmbedUrl = (url: string) => {
    if (!url) return null;
    const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
    const match = url.match(regExp);
    if (match && match[2].length === 11) {
      return `https://www.youtube.com/embed/${match[2]}?autoplay=0&rel=0`;
    }
    return null;
  };

  const ytEmbedUrl = useMemo(() => {
    if (!lesson?.videoUrl) return null;
    return getYouTubeEmbedUrl(lesson.videoUrl);
  }, [lesson?.videoUrl]);

  return (
    <div className="flex flex-col lg:flex-row h-full w-full overflow-hidden bg-slate-50 dark:bg-slate-950 text-left">
      
      {/* 1. Main Workspace (Video + Theory) - 2/3 Width */}
      <div className="flex-grow flex flex-col h-full overflow-hidden border-r border-slate-300 dark:border-slate-800/60">
        
        {/* Mobile Sub-Header / Navigation tabs */}
        <div className="lg:hidden flex border-b border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 sticky top-0 z-10">
          <button 
            onClick={() => setMobileTab('content')}
            className={`flex-1 py-3 text-center text-xs font-bold transition-all border-b-2 ${
              mobileTab === 'content' 
                ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400' 
                : 'border-transparent text-slate-500 hover:text-slate-800 dark:hover:text-slate-200'
            }`}
          >
            Lesson
          </button>
          <button 
            onClick={() => setMobileTab('curriculum')}
            className={`flex-1 py-3 text-center text-xs font-bold transition-all border-b-2 ${
              mobileTab === 'curriculum' 
                ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400' 
                : 'border-transparent text-slate-500 hover:text-slate-800 dark:hover:text-slate-200'
            }`}
          >
            Curriculum
          </button>
          <button 
            onClick={() => setMobileTab('comments')}
            className={`flex-1 py-3 text-center text-xs font-bold transition-all border-b-2 ${
              mobileTab === 'comments' 
                ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400' 
                : 'border-transparent text-slate-500 hover:text-slate-800 dark:hover:text-slate-200'
            }`}
          >
            Discussion
          </button>
        </div>

        {/* Video / Content scroll container */}
        <div className="flex-grow overflow-y-auto flex flex-col">
          
          {/* Main content depending on active tab for mobile, or always display for desktop */}
          <div className={`flex-grow flex flex-col ${mobileTab !== 'content' ? 'hidden lg:flex' : 'flex'}`}>
            
            {/* Loading lesson state */}
            {isLessonLoading ? (
              <div className="flex-grow flex flex-col items-center justify-center p-12 min-h-[50vh]">
                <Loader2 className="h-10 w-10 animate-spin text-indigo-600 dark:text-indigo-400 mb-3" />
                <span className="text-sm text-slate-500 dark:text-slate-400 font-medium">Loading lesson content...</span>
              </div>
            ) : lessonError ? (
              <div className="flex-grow flex flex-col items-center justify-center p-8 text-center min-h-[50vh] max-w-md mx-auto">
                <AlertCircle className="h-12 w-12 text-rose-500 mb-4 animate-bounce" />
                <h3 className="text-lg font-bold text-slate-900 dark:text-white mb-2">Access Denied</h3>
                <p className="text-sm text-slate-500 dark:text-slate-400 mb-6 leading-relaxed">
                  {lessonError}
                </p>
                <Link
                  to={`/courses/${courseId}`}
                  className="px-5 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/10 hover:shadow-indigo-600/25 active:scale-95 transition-all"
                >
                  Back to Course
                </Link>
              </div>
            ) : lesson ? (
              <>
                {/* 1.1 Video Section */}
                {lesson.videoUrl ? (
                  <div className="w-full bg-black aspect-video relative flex-shrink-0 shadow-lg group">
                    {ytEmbedUrl ? (
                      <iframe
                        src={ytEmbedUrl}
                        title={lesson.title}
                        className="w-full h-full border-0 absolute inset-0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowFullScreen
                      />
                    ) : (
                      <video 
                        src={lesson.videoUrl} 
                        controls 
                        className="w-full h-full max-h-[60vh] object-contain"
                        poster="/images/placeholder_learning.jpg"
                      />
                    )}
                  </div>
                ) : (
                  <div className="w-full bg-slate-900 border-b border-slate-800 py-12 px-6 flex flex-col items-center justify-center text-center text-white space-y-3 shrink-0">
                    <div className="h-14 w-14 rounded-full bg-indigo-500/10 text-indigo-400 flex items-center justify-center border border-indigo-500/20">
                      <FileText className="h-6 w-6" />
                    </div>
                    <div>
                      <h4 className="text-base font-bold">Theory Reading</h4>
                      <p className="text-xs text-slate-400 max-w-sm mx-auto mt-1">
                        This lesson does not include video. Please study the lesson content and practice the sample code below.
                      </p>
                    </div>
                  </div>
                )}

                {/* 1.2 Text Content Section (Title, theory, sample code) */}
                <div className="p-6 md:p-8 max-w-4xl mx-auto w-full space-y-6">
                  
                  {/* Title & Metadata */}
                  <div className="space-y-2">
                    <h1 className="text-2xl md:text-3xl font-extrabold text-slate-950 dark:text-white leading-tight">
                      {lesson.title}
                    </h1>
                    {lesson.estimatedDurationMinutes && (
                      <div className="flex items-center space-x-2 text-xs font-semibold text-slate-500 dark:text-slate-400">
                        <span>Estimated Duration: {lesson.estimatedDurationMinutes} mins</span>
                        {lesson.trial && (
                          <>
                            <span>•</span>
                            <span className="text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-950/40 px-2 py-0.5 rounded-full text-[10px]">Preview</span>
                          </>
                        )}
                      </div>
                    )}
                  </div>

                  <hr className="border-slate-300 dark:border-slate-800" />

                  {/* Description */}
                  {lesson.description && (
                    <div className="bg-slate-100/60 dark:bg-slate-900/40 p-4 rounded-2xl border border-slate-200/40 dark:border-slate-800/40 text-slate-700 dark:text-slate-300 text-sm leading-relaxed">
                      <h5 className="font-bold text-slate-900 dark:text-white mb-1">Learning Objectives:</h5>
                      <p>{lesson.description}</p>
                    </div>
                  )}

                  {/* Theory content */}
                  {lesson.theoryContent && (
                    <div className="prose dark:prose-invert prose-indigo max-w-none text-left space-y-4">
                      <h3 className="text-lg font-bold text-slate-900 dark:text-white flex items-center space-x-2">
                        <BookOpen className="h-5 w-5 text-indigo-500" />
                        <span>Detailed Content</span>
                      </h3>
                      <div className="text-sm text-slate-700 dark:text-slate-300 leading-relaxed whitespace-pre-wrap font-normal">
                        {lesson.theoryContent}
                      </div>
                    </div>
                  )}

                  {/* Sample Code Area */}
                  {lesson.sampleCode && (
                    <div className="space-y-3 pt-4 text-left">
                      <div className="flex items-center justify-between">
                        <h4 className="text-sm font-bold text-slate-900 dark:text-white flex items-center space-x-2">
                          <Code className="h-5 w-5 text-indigo-500" />
                          <span>Reference Sample Code</span>
                        </h4>
                        <button
                          onClick={() => handleCopyCode(lesson.sampleCode || '')}
                          className="flex items-center space-x-1.5 text-xs font-semibold text-indigo-600 hover:text-indigo-700 dark:text-indigo-400 dark:hover:text-indigo-300 hover:bg-indigo-50 dark:hover:bg-indigo-950/40 px-2.5 py-1.5 rounded-lg border border-indigo-200 dark:border-indigo-900/40 transition-colors"
                        >
                          <Copy className="h-3.5 w-3.5" />
                          <span>{copiedCode ? 'Copied!' : 'Copy Code'}</span>
                        </button>
                      </div>
                      <div className="relative rounded-2xl overflow-hidden bg-slate-950 text-slate-100 font-mono text-xs border border-slate-800/60 leading-relaxed">
                        <div className="flex items-center justify-between px-4 py-2 border-b border-slate-900 bg-slate-900/50 text-slate-400 text-[10px] uppercase font-bold tracking-wider">
                          <span>Source Code</span>
                          <span className="px-1.5 py-0.5 rounded bg-slate-800 text-slate-300">Syntax</span>
                        </div>
                        <pre className="p-4 overflow-x-auto whitespace-pre font-mono scrollbar-thin scrollbar-thumb-slate-800">
                          <code>{lesson.sampleCode}</code>
                        </pre>
                      </div>
                    </div>
                  )}

                  {/* Spacer to give room at the bottom for footer bar */}
                  <div className="h-20" />
                </div>
              </>
            ) : null}
          </div>

          {/* If mobile tab is curriculum, show curriculum */}
          <div className={`flex-grow overflow-y-auto lg:hidden ${mobileTab === 'curriculum' ? 'block' : 'hidden'}`}>
            <CurriculumList 
              chapters={chapters} 
              isCurriculumLoading={isCurriculumLoading}
              expandedChapters={expandedChapters}
              toggleChapter={toggleChapter}
              lessonIdNum={lessonIdNum}
              courseIdNum={courseIdNum}
              onSelectLesson={() => setMobileTab('content')}
              onCompleteLesson={handleCompleteLesson}
            />
          </div>

          {/* If mobile tab is comments, show comments */}
          <div className={`flex-grow flex flex-col lg:hidden ${mobileTab === 'comments' ? 'block' : 'hidden'}`}>
            <CommentSection lessonId={lessonIdNum} />
          </div>

        </div>

        {/* 1.3 Bottom sticky action & navigation panel */}
        {lesson && (
          <div className="border-t border-slate-200/80 dark:border-slate-800/80 bg-white dark:bg-slate-900/90 backdrop-blur-md px-6 py-4 flex items-center justify-between sticky bottom-0 z-25 shrink-0 shadow-xl">
            
            {/* Prev lesson button */}
            {prevLesson ? (
              <button
                onClick={() => navigate(`/learning/${courseIdNum}/lessons/${prevLesson.id}`)}
                className="flex items-center space-x-2 text-xs font-bold text-slate-600 hover:text-slate-950 dark:text-slate-400 dark:hover:text-white transition-colors"
              >
                <ArrowLeft className="h-4 w-4" />
                <span className="hidden sm:inline">Previous</span>
              </button>
            ) : (
              <div className="w-16" /> // Placeholder
            )}

            {/* Mark complete button */}
            {isCurrentLessonCompleted ? (
              <div className="flex items-center space-x-1.5 px-4 py-2 bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border border-emerald-500/20 rounded-xl text-xs font-extrabold">
                <CheckCircle2 className="h-4.5 w-4.5" />
                <span>Completed</span>
              </div>
            ) : (
              <button
                onClick={() => handleCompleteLesson()}
                disabled={isCompleting}
                className="flex items-center space-x-1.5 px-5 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-extrabold shadow-md shadow-indigo-600/10 hover:shadow-indigo-600/25 disabled:opacity-50 active:scale-95 transition-all"
              >
                {isCompleting ? (
                  <Loader2 className="h-4 w-4 animate-spin" />
                ) : (
                  <Check className="h-4 w-4" />
                )}
                <span>Complete Lesson</span>
              </button>
            )}

            {/* Next lesson button */}
            {nextLesson ? (
              <button
                onClick={() => navigate(`/learning/${courseIdNum}/lessons/${nextLesson.id}`)}
                className="flex items-center space-x-2 text-xs font-bold text-slate-600 hover:text-slate-950 dark:text-slate-400 dark:hover:text-white transition-colors"
              >
                <span className="hidden sm:inline">Next</span>
                <ArrowRight className="h-4 w-4" />
              </button>
            ) : (
              <div className="w-16" /> // Placeholder
            )}

          </div>
        )}

      </div>

      {/* 2. Sidebar (Curriculum & Comments tabs) - Desktop only (1/3 width) */}
      <div className="hidden lg:flex w-96 flex-col h-full bg-white dark:bg-slate-900 flex-shrink-0 select-none">
        
        {/* Sidebar tab header */}
        <div className="flex border-b border-slate-300 dark:border-slate-800/60 shrink-0">
          <button
            onClick={() => setSidebarTab('curriculum')}
            className={`flex-1 py-4 text-center text-xs font-bold transition-all border-b-2 tracking-wider uppercase ${
              sidebarTab === 'curriculum'
                ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400 bg-slate-100/70 dark:bg-slate-950/20'
                : 'border-transparent text-slate-400 hover:text-slate-800 dark:hover:text-slate-200'
            }`}
          >
            Curriculum
          </button>
          <button
            onClick={() => setSidebarTab('comments')}
            className={`flex-1 py-4 text-center text-xs font-bold transition-all border-b-2 tracking-wider uppercase ${
              sidebarTab === 'comments'
                ? 'border-indigo-600 text-indigo-600 dark:text-indigo-400 dark:border-indigo-400 bg-slate-100/70 dark:bg-slate-950/20'
                : 'border-transparent text-slate-400 hover:text-slate-800 dark:hover:text-slate-200'
            }`}
          >
            Discussion
          </button>
        </div>

        {/* Tab content area */}
        <div className="flex-grow overflow-hidden flex flex-col">
          {sidebarTab === 'curriculum' ? (
            <div className="flex-grow overflow-y-auto">
              <CurriculumList 
                chapters={chapters} 
                isCurriculumLoading={isCurriculumLoading}
                expandedChapters={expandedChapters}
                toggleChapter={toggleChapter}
                lessonIdNum={lessonIdNum}
                courseIdNum={courseIdNum}
                onCompleteLesson={handleCompleteLesson}
              />
            </div>
          ) : (
            <div className="flex-grow overflow-hidden flex flex-col">
              <CommentSection lessonId={lessonIdNum} />
            </div>
          )}
        </div>

      </div>

    </div>
  );
};

// Extracted Sub-Component for Curriculum Accordion
interface CurriculumListProps {
  chapters: ChapterResponse[];
  isCurriculumLoading: boolean;
  expandedChapters: number[];
  toggleChapter: (id: number) => void;
  lessonIdNum: number;
  courseIdNum: number;
  onSelectLesson?: () => void;
  onCompleteLesson?: (targetLessonId: number) => void;
}

const CurriculumList: React.FC<CurriculumListProps> = ({
  chapters,
  isCurriculumLoading,
  expandedChapters,
  toggleChapter,
  lessonIdNum,
  courseIdNum,
  onSelectLesson,
  onCompleteLesson
}) => {
  const navigate = useNavigate();

  if (isCurriculumLoading) {
    return (
      <div className="p-6 space-y-4">
        {[1, 2, 3].map(i => (
          <div key={i} className="animate-pulse space-y-2">
            <div className="h-6 bg-slate-200 dark:bg-slate-800 rounded-lg w-3/4"></div>
            <div className="space-y-1 ml-4">
              <div className="h-4 bg-slate-200 dark:bg-slate-800 rounded-lg w-full"></div>
              <div className="h-4 bg-slate-200 dark:bg-slate-800 rounded-lg w-5/6"></div>
            </div>
          </div>
        ))}
      </div>
    );
  }

  if (chapters.length === 0) {
    return (
      <div className="p-6 text-center text-slate-500 dark:text-slate-400">
        <p className="text-xs">No lessons in curriculum yet.</p>
      </div>
    );
  }

  return (
    <div className="divide-y divide-slate-200 dark:divide-slate-800 text-left">
      {chapters.map((chapter) => {
        const isExpanded = expandedChapters.includes(chapter.id);
        const completedCount = chapter.lessonSummaryResponses?.filter(l => l.isCompleted).length || 0;
        const totalCount = chapter.lessonSummaryResponses?.length || 0;

        return (
          <div key={chapter.id} className="transition-colors">
            {/* Chapter header trigger */}
            <button
              onClick={() => toggleChapter(chapter.id)}
              className="w-full px-5 py-4 flex items-center justify-between text-left hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-all focus:outline-none"
            >
              <div className="space-y-0.5 flex-grow pr-4">
                <span className="text-[10px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-wider">
                  Chapter {chapter.orderIndex}
                </span>
                <h4 className="text-sm font-bold text-slate-900 dark:text-white line-clamp-2">
                  {chapter.title}
                </h4>
                <p className="text-[10px] text-slate-500 dark:text-slate-400 font-semibold">
                  Completed {completedCount}/{totalCount} lessons
                </p>
              </div>
              <div className="shrink-0 text-slate-400">
                {isExpanded ? (
                  <ChevronUp className="h-4 w-4" />
                ) : (
                  <ChevronDown className="h-4 w-4" />
                )}
              </div>
            </button>

            {/* Lessons List in Accordion content */}
            <AnimatePresence initial={false}>
              {isExpanded && (
                <motion.div
                  initial={{ height: 0, opacity: 0 }}
                  animate={{ height: 'auto', opacity: 1 }}
                  exit={{ height: 0, opacity: 0 }}
                  transition={{ duration: 0.2 }}
                  className="overflow-hidden bg-slate-100/70 dark:bg-slate-950/20"
                >
                  <div className="pb-2">
                    {chapter.lessonSummaryResponses?.map((lesson) => {
                      const isActive = lesson.id === lessonIdNum;

                      return (
                        <div
                          key={lesson.id}
                          role="button"
                          onClick={() => {
                            navigate(`/learning/${courseIdNum}/lessons/${lesson.id}`);
                            if (onSelectLesson) onSelectLesson();
                          }}
                          className={`w-full px-6 py-3 flex items-start space-x-3 text-left border-l-2 focus:outline-none transition-all cursor-pointer ${
                            isActive 
                              ? 'bg-indigo-50/70 border-indigo-600 dark:bg-indigo-950/20 dark:border-indigo-400' 
                              : 'border-transparent hover:bg-slate-100 dark:hover:bg-slate-800/40'
                          }`}
                        >
                          {/* Checked icon or Play/Circle icon */}
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              if (!lesson.isCompleted) {
                                onCompleteLesson?.(lesson.id);
                              }
                            }}
                            disabled={lesson.isCompleted}
                            className={`mt-0.5 shrink-0 transition-transform ${
                              lesson.isCompleted ? 'cursor-default' : 'hover:scale-110 active:scale-95'
                            }`}
                            title={lesson.isCompleted ? "Completed" : "Mark as completed"}
                          >
                            {lesson.isCompleted ? (
                              <CheckCircle2 className="h-4 w-4 text-emerald-500" />
                            ) : isActive ? (
                              <Play className="h-4 w-4 text-indigo-600 dark:text-indigo-400 fill-indigo-600 dark:fill-indigo-400" />
                            ) : (
                              <Circle className="h-4 w-4 text-slate-300 dark:text-slate-600 hover:text-emerald-500 transition-colors" />
                            )}
                          </button>

                          <div className="flex-grow space-y-0.5">
                            <h5 className={`text-xs font-semibold leading-relaxed ${
                              isActive 
                                ? 'text-indigo-600 dark:text-indigo-400 font-bold' 
                                : 'text-slate-700 dark:text-slate-300'
                            }`}>
                              {lesson.orderIndex}. {lesson.title}
                            </h5>
                            <div className="flex items-center space-x-1.5 text-[10px] text-slate-400 font-medium">
                              <span>{lesson.estimatedDurationMinutes} mins</span>
                              {lesson.trial && (
                                <>
                                  <span>•</span>
                                  <span className="text-indigo-600 dark:text-indigo-400">Preview</span>
                                </>
                              )}
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </div>
        );
      })}
    </div>
  );
};

export default LearningWorkspace;
