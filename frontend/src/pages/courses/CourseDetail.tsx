import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { 
  BookOpen, 
  Clock, 
  Code, 
  PlayCircle, 
  ChevronDown, 
  CheckCircle2, 
  Lock, 
  ShoppingCart, 
  GraduationCap, 
  Star, 
  Users, 
  ArrowRight,
  Eye,
  Video,
  FileText
} from 'lucide-react';
import api from '../../api/axios';
import { useAuth } from '../../context/AuthContext';
import { useCart } from '../../context/CartContext';
import type { 
  ApiResponse, 
  CourseDetailResponse, 
  ChapterResponse 
} from '../../types';

const CourseDetail: React.FC = () => {
  const { courseId } = useParams<{ courseId: string }>();
  const { isAuthenticated } = useAuth();
  const { addToCart, isInCart } = useCart();
  const navigate = useNavigate();

  const [course, setCourse] = useState<CourseDetailResponse | null>(null);
  const [chapters, setChapters] = useState<ChapterResponse[]>([]);
  const [expandedChapters, setExpandedChapters] = useState<number[]>([]);
  
  const [isLoading, setIsLoading] = useState(true);
  const [isEnrolling, setIsEnrolling] = useState(false);

  useEffect(() => {
    const fetchCourseDetails = async () => {
      if (!courseId) return;
      setIsLoading(true);
      try {
        const [detailRes, curriculumRes] = await Promise.all([
          api.get<ApiResponse<CourseDetailResponse>>(`/courses/${courseId}`),
          api.get<ApiResponse<ChapterResponse[]>>(`/courses/${courseId}/curriculum`)
        ]);

        setCourse(detailRes.data.result);
        setChapters(curriculumRes.data.result || []);
        
        // Expand first chapter by default
        if (curriculumRes.data.result && curriculumRes.data.result.length > 0) {
          setExpandedChapters([curriculumRes.data.result[0].id]);
        }
      } catch (error) {
        console.error('Failed to fetch course details:', error);
      } finally {
        setIsLoading(false);
      }
    };

    fetchCourseDetails();
  }, [courseId]);

  const toggleChapter = (id: number) => {
    setExpandedChapters(prev => 
      prev.includes(id) ? prev.filter(cId => cId !== id) : [...prev, id]
    );
  };

  const handleEnrollFree = async () => {
    if (!isAuthenticated) {
      navigate('/login');
      return;
    }
    if (!courseId || isEnrolling) return;

    setIsEnrolling(true);
    try {
      await api.post(`/enrollments/free/${courseId}`);
      // Refresh course state
      const detailRes = await api.get<ApiResponse<CourseDetailResponse>>(`/courses/${courseId}`);
      setCourse(detailRes.data.result);
    } catch (error) {
      console.error('Failed to enroll free course:', error);
    } finally {
      setIsEnrolling(false);
    }
  };

  const handleAddToCart = async () => {
    if (!isAuthenticated) {
      navigate('/login');
      return;
    }
    if (!courseId) return;
    try {
      await addToCart(Number(courseId));
    } catch (error) {
      console.error('Failed to add to cart:', error);
    }
  };

  const formatVND = (amount: number) => {
    if (amount === 0) return 'Free';
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
  };

  // Find the first lesson ID in the curriculum to redirect "Learn Now"
  const getFirstLessonId = (): number | null => {
    for (const chapter of chapters) {
      if (chapter.lessonSummaryResponses && chapter.lessonSummaryResponses.length > 0) {
        return chapter.lessonSummaryResponses[0].id;
      }
    }
    return null;
  };

  const firstLessonId = getFirstLessonId();
  const isAlreadyAddedToCart = courseId ? isInCart(Number(courseId)) : false;

  if (isLoading) {
    return (
      <div className="flex h-[70vh] items-center justify-center bg-slate-50 dark:bg-slate-950">
        <div className="h-10 w-10 animate-spin rounded-full border-4 border-slate-300 border-t-indigo-600"></div>
      </div>
    );
  }

  if (!course) {
    return (
      <div className="text-center py-20">
        <p className="text-slate-500">Course does not exist or has been removed.</p>
        <Link to="/courses" className="mt-4 inline-flex items-center text-indigo-600 hover:underline">
          Back to Courses
        </Link>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-8 sm:px-6 lg:px-8 text-left relative">
      {/* Course Hero Banner */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-12 items-start">
        {/* Banner Details (Left) */}
        <div className="lg:col-span-2 space-y-6">
          <div className="space-y-4">
            {course.categories && course.categories.length > 0 && (
              <div className="flex flex-wrap gap-2 mb-3">
                {course.categories.map(cat => (
                  <span key={cat.id} className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-indigo-50 dark:bg-indigo-950/40 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/25">
                    {cat.name}
                  </span>
                ))}
              </div>
            )}
            <h1 className="text-3xl sm:text-4xl font-extrabold text-slate-900 dark:text-white leading-tight">
              {course.title}
            </h1>
            <p className="text-lg text-slate-600 dark:text-slate-300">
              {course.shortDescription}
            </p>
          </div>

          {/* Stats Bar */}
          <div className="flex flex-wrap gap-6 text-sm items-center py-4 border-y border-slate-200 dark:border-slate-800">
            <div className="flex items-center space-x-1.5">
              <Star className="h-4.5 w-4.5 fill-current text-amber-400" />
              <span className="font-bold text-slate-800 dark:text-slate-200">{course.averageRating.toFixed(1)}</span>
              <span className="text-slate-400">({course.totalReviews} reviews)</span>
            </div>

            <div className="flex items-center space-x-1.5 text-slate-500 dark:text-slate-400">
              <Users className="h-4.5 w-4.5 text-indigo-500" />
              <span>{course.totalEnrolled} students enrolled</span>
            </div>

            {course.estimatedDurationHours && (
              <div className="flex items-center space-x-1.5 text-slate-500 dark:text-slate-400">
                <Clock className="h-4.5 w-4.5 text-indigo-500" />
                <span>Approx. {course.estimatedDurationHours} hours</span>
              </div>
            )}
          </div>

          {/* Instructors Info */}
          {course.instructors && course.instructors.length > 0 && (
            <div className="flex items-center space-x-3">
              <span className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Instructors:</span>
              <div className="flex flex-wrap gap-2">
                {course.instructors.map(teacher => (
                  <span key={teacher.id} className="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-indigo-50 dark:bg-indigo-950/30 text-indigo-600 dark:text-indigo-400 border border-indigo-100/35 dark:border-indigo-900/10">
                    {teacher.fullName}
                  </span>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Floating Sidebar card (Right) */}
        <div className="lg:col-span-1 lg:sticky lg:top-24">
          <div className="rounded-2xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 shadow-xl overflow-hidden">
            {/* Thumbnail */}
            <div className="h-48 bg-slate-100 dark:bg-slate-800 overflow-hidden relative border-b border-slate-200 dark:border-slate-800">
              {course.thumbnailUrl ? (
                <img
                  src={course.thumbnailUrl}
                  alt={course.title}
                  className="h-full w-full object-cover"
                />
              ) : (
                <div className="h-full w-full flex items-center justify-center bg-gradient-to-br from-indigo-500/15 to-violet-500/15 text-indigo-600 dark:text-indigo-400">
                  <BookOpen className="h-16 w-16 opacity-50" />
                </div>
              )}
            </div>

            {/* Sidebar Pricing & Actions */}
            <div className="p-6 sm:p-8 space-y-6 text-center">
              {course.isEnrolled ? (
                <div className="space-y-4 text-left bg-slate-100/70 dark:bg-slate-950/20 p-4 rounded-2xl border border-slate-200 dark:border-slate-800">
                  <div className="flex flex-col items-center justify-center space-y-1">
                    <span className="text-[10px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-widest">Enrollment Status</span>
                    <span className="text-lg font-extrabold text-emerald-600 dark:text-emerald-400 flex items-center space-x-1.5">
                      <CheckCircle2 className="h-5 w-5 text-emerald-500" />
                      <span>Enrolled</span>
                    </span>
                  </div>
                  
                  <div className="space-y-1.5">
                    <div className="flex items-center justify-between text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                      <span>Your Progress</span>
                      <span>{course.progressPercentage ?? 0}%</span>
                    </div>
                    <div className="w-full bg-slate-100 dark:bg-slate-800 h-2 rounded-full overflow-hidden">
                      <div
                        className="bg-emerald-500 h-full transition-all duration-300"
                        style={{ width: `${course.progressPercentage ?? 0}%` }}
                      />
                    </div>
                  </div>
                </div>
              ) : (
                <div className="flex items-baseline justify-center space-x-2">
                  <span className="text-3xl font-extrabold text-indigo-600 dark:text-indigo-400">
                    {formatVND(course.price)}
                  </span>
                </div>
              )}

              {/* Dynamic CTA Button */}
              {course.isEnrolled ? (
                firstLessonId ? (
                  <Link
                    to={`/learning/${course.id}/lessons/${firstLessonId}`}
                    className="w-full flex items-center justify-center space-x-2 py-3 px-4 rounded-xl text-white bg-emerald-600 hover:bg-emerald-700 shadow-md font-semibold transition-all active:scale-97"
                  >
                    <span>Learn Now</span>
                    <ArrowRight className="h-4.5 w-4.5" />
                  </Link>
                ) : (
                  <button
                    disabled
                    className="w-full py-3 px-4 rounded-xl text-slate-400 bg-slate-100 dark:bg-slate-800 font-semibold"
                  >
                    No lessons available
                  </button>
                )
              ) : course.price === 0 ? (
                <button
                  onClick={handleEnrollFree}
                  disabled={isEnrolling}
                  className="w-full flex items-center justify-center space-x-2 py-3 px-4 rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 shadow-md font-semibold transition-all active:scale-97 disabled:opacity-50 cursor-pointer"
                >
                  <GraduationCap className="h-5 w-5" />
                  <span>{isEnrolling ? 'Enrolling...' : 'Enroll Free'}</span>
                </button>
              ) : isAlreadyAddedToCart ? (
                <Link
                  to="/cart"
                  className="w-full flex items-center justify-center space-x-2 py-3 px-4 rounded-xl text-indigo-700 dark:text-indigo-300 bg-indigo-50 dark:bg-indigo-950/40 hover:bg-indigo-100 dark:hover:bg-indigo-950/60 border border-indigo-100 dark:border-indigo-900/30 shadow-sm font-semibold transition-all active:scale-97"
                >
                  <ShoppingCart className="h-5 w-5" />
                  <span>View in Cart</span>
                </Link>
              ) : (
                <button
                  onClick={handleAddToCart}
                  className="w-full flex items-center justify-center space-x-2 py-3 px-4 rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 shadow-md font-semibold transition-all active:scale-97 cursor-pointer"
                >
                  <ShoppingCart className="h-5 w-5" />
                  <span>Add to Cart</span>
                </button>
              )}

              {/* Quick Specs */}
              <div className="w-full h-[1px] bg-slate-100 dark:bg-slate-800"></div>

              <ul className="space-y-3 text-left text-sm text-slate-600 dark:text-slate-300">
                <li className="flex items-center">
                  <PlayCircle className="h-4.5 w-4.5 text-indigo-500 mr-2.5" />
                  <span>{course.totalLessons} lessons</span>
                </li>
                {course.totalVideos > 0 && (
                  <li className="flex items-center">
                    <Video className="h-4.5 w-4.5 text-indigo-500 mr-2.5" />
                    <span>{course.totalVideos} videos</span>
                  </li>
                )}
                {course.totalQuizzes > 0 && (
                  <li className="flex items-center">
                    <CheckCircle2 className="h-4.5 w-4.5 text-indigo-500 mr-2.5" />
                    <span>{course.totalQuizzes} quizzes</span>
                  </li>
                )}
                {course.totalAssignments > 0 && (
                  <li className="flex items-center">
                    <FileText className="h-4.5 w-4.5 text-indigo-500 mr-2.5" />
                    <span>{course.totalAssignments} assignments</span>
                  </li>
                )}
                {course.totalOnlineJudgeProblems > 0 && (
                  <li className="flex items-center">
                    <Code className="h-4.5 w-4.5 text-indigo-500 mr-2.5" />
                    <span>{course.totalOnlineJudgeProblems} code challenges (OJ)</span>
                  </li>
                )}
              </ul>
            </div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
        {/* Main Details (Left) */}
        <div className="lg:col-span-2 space-y-8">
          {/* Outcomes */}
          {course.learningOutcomes && (
            <section className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm">
              <h2 className="text-xl font-bold text-slate-950 dark:text-white mb-4">What you will learn</h2>
              <div className="text-slate-600 dark:text-slate-300 text-sm leading-relaxed whitespace-pre-wrap">
                {course.learningOutcomes}
              </div>
            </section>
          )}

          {/* Highlights */}
          {course.courseHighlights && (
            <section className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm">
              <h2 className="text-xl font-bold text-slate-950 dark:text-white mb-4">Course Highlights</h2>
              <div className="text-slate-600 dark:text-slate-300 text-sm leading-relaxed whitespace-pre-wrap">
                {course.courseHighlights}
              </div>
            </section>
          )}

          {/* Detailed Course Content */}
          {course.courseContent && (
            <section className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm">
              <h2 className="text-xl font-bold text-slate-950 dark:text-white mb-4">Course Content</h2>
              <div className="text-slate-600 dark:text-slate-300 text-sm leading-relaxed whitespace-pre-wrap">
                {course.courseContent}
              </div>
            </section>
          )}

          {/* Prerequisites & Tools */}
          {(course.prerequisites || course.technologiesTools) && (
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
              {course.prerequisites && (
                <section className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm">
                  <h2 className="text-base font-bold text-slate-950 dark:text-white mb-3">Prerequisites</h2>
                  <p className="text-slate-600 dark:text-slate-300 text-xs leading-relaxed whitespace-pre-wrap">{course.prerequisites}</p>
                </section>
              )}
              {course.technologiesTools && (
                <section className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm">
                  <h2 className="text-base font-bold text-slate-950 dark:text-white mb-3">Technologies & Tools</h2>
                  <p className="text-slate-600 dark:text-slate-300 text-xs leading-relaxed whitespace-pre-wrap">{course.technologiesTools}</p>
                </section>
              )}
            </div>
          )}

          {/* Target Audience & Benefits */}
          {(course.targetAudience || course.completionBenefits) && (
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
              {course.targetAudience && (
                <section className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm">
                  <h2 className="text-base font-bold text-slate-950 dark:text-white mb-3">Target Audience</h2>
                  <p className="text-slate-600 dark:text-slate-300 text-xs leading-relaxed whitespace-pre-wrap">{course.targetAudience}</p>
                </section>
              )}
              {course.completionBenefits && (
                <section className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm">
                  <h2 className="text-base font-bold text-slate-950 dark:text-white mb-3">Completion Benefits</h2>
                  <p className="text-slate-600 dark:text-slate-300 text-xs leading-relaxed whitespace-pre-wrap">{course.completionBenefits}</p>
                </section>
              )}
            </div>
          )}

          {/* Curriculum Accordion (Chapter -> Lesson) */}
          <section className="space-y-4">
            <h2 className="text-xl font-bold text-slate-950 dark:text-white mb-2">Curriculum</h2>

            {chapters.length === 0 ? (
              <div className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 text-center text-slate-500">
                No curriculum content available for this course.
              </div>
            ) : (
              <div className="space-y-3">
                {chapters.map((chapter) => {
                  const isExpanded = expandedChapters.includes(chapter.id);
                  return (
                    <div 
                      key={chapter.id}
                      className="rounded-2xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 shadow-sm overflow-hidden"
                    >
                      {/* Chapter Toggle Button */}
                      <button
                        onClick={() => toggleChapter(chapter.id)}
                        className="w-full flex items-center justify-between p-5 text-left font-bold text-sm bg-slate-100/70 dark:bg-slate-900/50 hover:bg-slate-50 dark:hover:bg-slate-900/80 transition-colors"
                      >
                        <div className="flex items-start space-x-2">
                          <span className="text-indigo-600 dark:text-indigo-400">Chapter {chapter.orderIndex + 1}:</span>
                          <span className="text-slate-900 dark:text-white font-semibold">{chapter.title}</span>
                        </div>
                        <ChevronDown className={`h-4.5 w-4.5 text-slate-400 transition-transform ${isExpanded ? 'rotate-180' : ''}`} />
                      </button>

                      {/* Lesson List inside Chapter */}
                      <AnimatePresence initial={false}>
                        {isExpanded && (
                          <motion.div
                            initial={{ height: 0 }}
                            animate={{ height: 'auto' }}
                            exit={{ height: 0 }}
                            className="overflow-hidden"
                          >
                            <div className="divide-y divide-slate-200 dark:divide-slate-800 bg-white dark:bg-slate-900">
                              {chapter.lessonSummaryResponses && chapter.lessonSummaryResponses.length > 0 ? (
                                chapter.lessonSummaryResponses.map((lesson) => {
                                  // Access allowed: isEnrolled OR is a free trial lesson
                                  const isAccessible = course.isEnrolled || lesson.trial;
                                  
                                  return (
                                    <div 
                                      key={lesson.id}
                                      className="flex items-center justify-between py-4 px-5 text-sm"
                                    >
                                      <div className="flex items-center space-x-3 flex-grow">
                                        {/* Status Icon */}
                                        {course.isEnrolled && lesson.isCompleted ? (
                                          <CheckCircle2 className="h-5 w-5 text-emerald-500 shrink-0" />
                                        ) : isAccessible ? (
                                          <PlayCircle className="h-5 w-5 text-indigo-500 shrink-0" />
                                        ) : (
                                          <Lock className="h-5 w-5 text-slate-400 shrink-0" />
                                        )}

                                        {/* Lesson Title (Clickable if accessible) */}
                                        {isAccessible ? (
                                          <Link 
                                            to={`/learning/${course.id}/lessons/${lesson.id}`}
                                            className="text-slate-700 dark:text-slate-200 hover:text-indigo-600 dark:hover:text-indigo-400 font-medium line-clamp-1 transition-colors"
                                          >
                                            {lesson.title}
                                          </Link>
                                        ) : (
                                          <span className="text-slate-400 line-clamp-1 select-none">{lesson.title}</span>
                                        )}

                                        {/* Trial Badge */}
                                        {lesson.trial && (
                                          <span className="inline-flex items-center px-1.5 py-0.5 rounded bg-indigo-50 dark:bg-indigo-950/40 text-[10px] font-bold text-indigo-600 dark:text-indigo-400 border border-indigo-100/40 dark:border-indigo-900/10">
                                            Preview
                                          </span>
                                        )}
                                      </div>

                                      <div className="flex items-center space-x-3 text-slate-500 dark:text-slate-400 text-xs shrink-0 font-medium">
                                        <span className="flex items-center"><Clock className="h-3.5 w-3.5 mr-1" /> {lesson.estimatedDurationMinutes} mins</span>
                                        
                                        {/* Study trial button */}
                                        {lesson.trial && !course.isEnrolled && (
                                          <Link 
                                            to={`/learning/${course.id}/lessons/${lesson.id}`}
                                            className="inline-flex items-center space-x-0.5 font-bold text-indigo-600 hover:underline"
                                          >
                                            <span>Preview</span>
                                            <Eye className="h-3.5 w-3.5" />
                                          </Link>
                                        )}
                                      </div>
                                    </div>
                                  );
                                })
                              ) : (
                                <div className="py-4 px-5 text-slate-500 text-xs text-center">No lessons in this chapter yet.</div>
                              )}
                            </div>
                          </motion.div>
                        )}
                      </AnimatePresence>
                    </div>
                  );
                })}
              </div>
            )}
          </section>
        </div>
      </div>
    </div>
  );
};

export default CourseDetail;
