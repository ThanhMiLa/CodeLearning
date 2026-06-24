import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { 
  BookOpen, 
  Star, 
  Users, 
  ChevronLeft, 
  ChevronRight,
  GraduationCap,
  Check
} from 'lucide-react';
import api from '../../api/axios';
import type { ApiResponse, PageResponse, EnrolledCourseResponse } from '../../types';
import { useTranslation } from 'react-i18next';

const MyLearning: React.FC = () => {
  const { t } = useTranslation();
  const [courses, setCourses] = useState<EnrolledCourseResponse[]>([]);
  const [totalPages, setTotalPages] = useState(0);
  const [currentPage, setCurrentPage] = useState(0);
  const [totalElements, setTotalElements] = useState(0);
  const [isLoading, setIsLoading] = useState(true);

  const fetchEnrolledCourses = async (pageIndex = 0) => {
    setIsLoading(true);
    try {
      const response = await api.get<ApiResponse<PageResponse<EnrolledCourseResponse>>>('/courses/enrolled', {
        params: {
          page: pageIndex,
          size: 12
        }
      });
      const pageData = response.data.result;
      setCourses(pageData.content || []);
      setTotalPages(pageData.totalPages || 0);
      setTotalElements(pageData.totalElements || 0);
      setCurrentPage(pageData.page || 0);
    } catch (error) {
      console.error('Failed to fetch enrolled courses:', error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchEnrolledCourses(0);
  }, []);

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-8 sm:px-6 lg:px-8 flex flex-col text-left bg-gradient-to-b from-slate-50/30 via-transparent to-transparent dark:from-slate-950/10">
      {/* Page Header with modern styling */}
      <div className="relative text-left mb-10 p-8 rounded-3xl overflow-hidden bg-gradient-to-r from-indigo-500/5 via-purple-500/5 to-pink-500/5 dark:from-indigo-500/10 dark:via-purple-500/10 dark:to-pink-500/10 border border-slate-200/50 dark:border-slate-800/50 backdrop-blur-md">
        <div className="absolute top-0 right-0 -mt-8 -mr-8 w-32 h-32 rounded-full bg-gradient-to-br from-indigo-500/20 to-purple-500/20 blur-2xl dark:opacity-30"></div>
        
        <div className="relative flex flex-col sm:flex-row sm:items-center justify-between gap-6">
          <div className="flex items-center space-x-4">
            <div className="p-3 rounded-2xl bg-indigo-500/10 text-indigo-600 dark:text-indigo-400">
              <GraduationCap className="h-8 w-8" />
            </div>
            <div>
              <h1 className="text-3xl font-extrabold tracking-tight bg-gradient-to-r from-slate-900 via-indigo-950 to-slate-900 dark:from-white dark:via-indigo-100 dark:to-white bg-clip-text text-transparent">
                {t('navbar.myLearning')}
              </h1>
              <p className="text-slate-500 dark:text-slate-400 mt-1 text-sm">
                Track your progress and continue learning your enrolled courses.
              </p>
            </div>
          </div>
          <div className="flex items-center space-x-2 bg-white/80 dark:bg-slate-900/80 border border-slate-200/80 dark:border-slate-800/80 px-4 py-2.5 rounded-2xl shadow-sm backdrop-blur-sm text-sm self-start sm:self-center">
            <BookOpen className="h-5 w-5 text-indigo-500" />
            <span className="font-bold text-slate-800 dark:text-slate-200">{totalElements}</span>
            <span className="text-slate-500">enrolled courses</span>
          </div>
        </div>
      </div>

      {/* Main Content Grid */}
      <div className="w-full">
        {isLoading ? (
          /* Premium loading skeletons matching course list catalog */
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            {[1, 2, 3, 4].map((i) => (
              <div key={i} className="animate-pulse flex flex-col p-5 rounded-3xl bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-850 space-y-4 shadow-sm">
                <div className="h-44 w-full bg-slate-100 dark:bg-slate-850 rounded-2xl"></div>
                <div className="h-5 w-3/4 bg-slate-100 dark:bg-slate-850 rounded-lg"></div>
                <div className="h-4 w-1/2 bg-slate-100 dark:bg-slate-850 rounded-lg"></div>
                <div className="h-2 w-full bg-slate-100 dark:bg-slate-850 rounded-full"></div>
                <div className="flex justify-between items-center pt-2">
                  <div className="h-5 w-16 bg-slate-100 dark:bg-slate-850 rounded-lg"></div>
                  <div className="h-8 w-20 bg-slate-100 dark:bg-slate-850 rounded-xl"></div>
                </div>
              </div>
            ))}
          </div>
        ) : courses.length === 0 ? (
          /* Premium Empty State */
          <div className="text-center py-24 bg-white dark:bg-slate-900 border border-slate-200/60 dark:border-slate-800/40 rounded-3xl p-8 shadow-sm flex flex-col items-center justify-center max-w-2xl mx-auto">
            <div className="p-5 rounded-2xl bg-indigo-50 dark:bg-indigo-950/40 text-indigo-600 dark:text-indigo-400 mb-5">
              <BookOpen className="h-10 w-10 opacity-80" />
            </div>
            <h3 className="text-xl font-extrabold text-slate-900 dark:text-white">You haven't enrolled in any courses yet</h3>
            <p className="text-slate-500 dark:text-slate-400 mt-2 max-w-sm mx-auto text-sm leading-relaxed">
              Explore our Course Catalog to find the perfect learning path for you.
            </p>
            <Link 
              to="/courses" 
              className="mt-6 inline-flex items-center justify-center rounded-2xl bg-indigo-600 px-6 py-3 text-sm font-bold text-white hover:bg-indigo-700 hover:shadow-lg hover:shadow-indigo-500/20 active:scale-95 transition-all"
            >
              Browse Courses
            </Link>
          </div>
        ) : (
          /* Grid View with premium cards matching CourseCatalog */
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            {courses.map((course) => (
              <motion.div
                key={course.id}
                whileHover={{ y: -6, transition: { duration: 0.2 } }}
                className="group flex flex-col p-4 bg-white dark:bg-slate-900 border border-slate-200/60 dark:border-slate-800/50 hover:border-indigo-500/30 rounded-3xl shadow-sm hover:shadow-xl hover:shadow-indigo-500/5 dark:hover:shadow-indigo-950/20 transition-all text-left relative overflow-hidden"
              >
                {/* Thumbnail */}
                <Link 
                  to={`/courses/${course.id}`} 
                  className="relative h-44 w-full rounded-2xl bg-slate-50 dark:bg-slate-950 overflow-hidden mb-4 border border-slate-100 dark:border-slate-850 block group-hover:shadow-sm"
                >
                  {course.thumbnailUrl ? (
                    <img
                      src={course.thumbnailUrl}
                      alt={course.title}
                      className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
                    />
                  ) : (
                    <div className="h-full w-full flex items-center justify-center bg-gradient-to-br from-indigo-500/10 via-purple-500/5 to-violet-500/10 text-indigo-600 dark:text-indigo-400">
                      <BookOpen className="h-12 w-12 opacity-40 group-hover:scale-110 transition-transform duration-350" />
                    </div>
                  )}
                  {/* Status overlay */}
                  <div className="absolute top-3 left-3 flex items-center space-x-1 px-3 py-1 rounded-full text-[10px] font-extrabold bg-emerald-500/90 text-white shadow-md shadow-emerald-500/10 backdrop-blur-sm uppercase tracking-wider">
                    <Check className="h-2.5 w-2.5 stroke-[3px]" />
                    <span>Enrolled</span>
                  </div>
                </Link>

                {/* Title & Desc */}
                <div className="flex-grow flex flex-col px-1">
                  <Link to={`/courses/${course.id}`} className="hover:text-indigo-600 dark:hover:text-indigo-455 transition-colors inline-block mb-1">
                    <h3 className="font-extrabold text-slate-900 dark:text-white line-clamp-1 group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors text-[15px]">{course.title}</h3>
                  </Link>
                  <p className="text-xs text-slate-500 dark:text-slate-400 line-clamp-2 leading-relaxed mb-3 flex-grow">
                    {course.shortDescription}
                  </p>

                  {/* Teacher / Instructor Info Card Tag */}
                  <div className="flex items-center space-x-2 py-2 px-2.5 mb-3 rounded-xl bg-slate-50 dark:bg-slate-900 border border-slate-100 dark:border-slate-850">
                    <div className="flex items-center justify-center h-5 w-5 rounded-full bg-indigo-100 dark:bg-indigo-950/80 text-indigo-600 dark:text-indigo-400 text-[10px] font-extrabold">
                      <GraduationCap className="h-3.5 w-3.5" />
                    </div>
                    <span className="text-[10px] font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider truncate">
                      {course.teacherName || 'CodeLearning Instructor'}
                    </span>
                  </div>
                </div>

                <div className="w-full h-[1px] bg-slate-100 dark:bg-slate-800/60 my-3"></div>

                <div className="space-y-3.5 w-full px-1">
                  {/* Progress Bar */}
                  <div className="space-y-1.5">
                    <div className="flex items-center justify-between text-[9px] font-extrabold text-slate-400 dark:text-slate-500 uppercase tracking-widest">
                      <span>Study Progress</span>
                      <span className="text-emerald-500">{course.progressPercentage ?? 0}%</span>
                    </div>
                    <div className="w-full bg-slate-100 dark:bg-slate-850 h-2 rounded-full overflow-hidden">
                      <div 
                        className="bg-gradient-to-r from-emerald-400 to-emerald-500 h-full rounded-full transition-all duration-500"
                        style={{ width: `${course.progressPercentage ?? 0}%` }}
                      />
                    </div>
                  </div>

                  {/* Rating & Button */}
                  <div className="flex items-center justify-between text-xs pt-0.5">
                    <div className="flex items-center space-x-3 text-slate-500 dark:text-slate-400">
                      {/* Rating */}
                      <span className="flex items-center space-x-0.5">
                        <Star className="h-3.5 w-3.5 fill-current text-amber-400" />
                        <span className="font-bold text-slate-700 dark:text-slate-200">
                          {course.averageRating ? course.averageRating.toFixed(1) : '0.0'}
                        </span>
                      </span>
                      {/* Enrolled Count */}
                      <span className="flex items-center space-x-1">
                        <Users className="h-3.5 w-3.5 text-slate-400" />
                        <span className="font-semibold text-slate-700 dark:text-slate-300">{course.totalEnrolled}</span>
                      </span>
                    </div>

                    <Link
                      to={`/courses/${course.id}`}
                      className="inline-flex items-center space-x-1 px-3 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-[11px] font-extrabold transition-all active:scale-95 shadow-sm shadow-indigo-600/10 cursor-pointer"
                    >
                      <span>Study Now</span>
                    </Link>
                  </div>
                </div>
              </motion.div>
            ))}
          </div>
        )}

        {/* Pagination Controls */}
        {totalPages > 1 && (
          <div className="flex items-center justify-center space-x-2 pt-8 mt-6">
            <button
              onClick={() => fetchEnrolledCourses(currentPage - 1)}
              disabled={currentPage === 0 || isLoading}
              className="p-2.5 rounded-xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 hover:bg-slate-50 dark:hover:bg-slate-850 disabled:opacity-40 disabled:hover:bg-white dark:disabled:hover:bg-slate-900 transition-colors shadow-sm cursor-pointer"
            >
              <ChevronLeft className="h-4 w-4" />
            </button>

            {[...Array(totalPages)].map((_, index) => (
              <button
                key={index}
                onClick={() => fetchEnrolledCourses(index)}
                className={`h-10 w-10 text-xs font-bold rounded-xl transition-all cursor-pointer ${
                  currentPage === index
                    ? 'bg-indigo-600 text-white shadow-md shadow-indigo-500/10'
                    : 'border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 hover:bg-slate-50 dark:hover:bg-slate-850 text-slate-700 dark:text-slate-200'
                }`}
              >
                {index + 1}
              </button>
            ))}

            <button
              onClick={() => fetchEnrolledCourses(currentPage + 1)}
              disabled={currentPage === totalPages - 1 || isLoading}
              className="p-2.5 rounded-xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 hover:bg-slate-50 dark:hover:bg-slate-850 disabled:opacity-40 disabled:hover:bg-white dark:disabled:hover:bg-slate-900 transition-colors shadow-sm cursor-pointer"
            >
              <ChevronRight className="h-4 w-4" />
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default MyLearning;
