import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion';
import { BookOpen, CheckCircle, GraduationCap, Play, RefreshCw, AlertCircle } from 'lucide-react';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import { useAuth } from '../../context/AuthContext';
import type { ApiResponse, CourseProgressResponse } from '../../types';

const Dashboard: React.FC = () => {
  const { user } = useAuth();
  const [progressCourses, setProgressCourses] = useState<CourseProgressResponse[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchProgress = async () => {
    setIsLoading(true);
    setError(null);
    try {
      const response = await api.get<ApiResponse<CourseProgressResponse[]>>('/users/me/progress/courses');
      setProgressCourses(response.data.result || []);
    } catch (err: any) {
      console.error('Failed to fetch progress courses:', err);
      setError(getErrorMessage(err));
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchProgress();
  }, []);

  const totalCourses = progressCourses.length;
  const completedCourses = progressCourses.filter(c => c.completionPercentage === 100).length;
  const totalCompletedLessons = progressCourses.reduce((acc, c) => acc + c.completedLessons, 0);

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-12 sm:px-6 lg:px-8">
      {/* Welcome Banner */}
      <div className="mb-10 text-left flex flex-col md:flex-row md:items-center md:justify-between gap-4">
        <div>
          <h1 className="text-3xl font-extrabold tracking-tight text-slate-900 dark:text-white flex items-center">
            <GraduationCap className="h-8 w-8 mr-2.5 text-indigo-600 dark:text-indigo-400" />
            <span>Your Learning Dashboard</span>
          </h1>
          <p className="text-slate-500 mt-2">
            Welcome back, <span className="font-semibold text-slate-800 dark:text-slate-200">{user?.displayName}</span>! Let's continue your coding journey.
          </p>
        </div>
        <button 
          onClick={fetchProgress}
          className="self-start md:self-auto flex items-center space-x-1.5 py-2 px-4 rounded-xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
        >
          <RefreshCw className={`h-4 w-4 ${isLoading ? 'animate-spin' : ''}`} />
          <span>Reload</span>
        </button>
      </div>

      {/* Stats Summary Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-12">
        <div className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm flex items-center space-x-4">
          <div className="p-3.5 rounded-xl bg-indigo-500/10 text-indigo-600 dark:text-indigo-400">
            <BookOpen className="h-6 w-6" />
          </div>
          <div>
            <div className="text-2xl font-extrabold text-slate-900 dark:text-white">{totalCourses}</div>
            <div className="text-xs font-semibold uppercase tracking-wider text-slate-400 dark:text-slate-500 mt-1">Enrolled Courses</div>
          </div>
        </div>

        <div className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm flex items-center space-x-4">
          <div className="p-3.5 rounded-xl bg-emerald-500/10 text-emerald-600 dark:text-emerald-400">
            <CheckCircle className="h-6 w-6" />
          </div>
          <div>
            <div className="text-2xl font-extrabold text-slate-900 dark:text-white">{completedCourses}</div>
            <div className="text-xs font-semibold uppercase tracking-wider text-slate-400 dark:text-slate-500 mt-1">Completed Courses</div>
          </div>
        </div>

        <div className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-sm flex items-center space-x-4">
          <div className="p-3.5 rounded-xl bg-violet-500/10 text-violet-600 dark:text-violet-400">
            <GraduationCap className="h-6 w-6" />
          </div>
          <div>
            <div className="text-2xl font-extrabold text-slate-900 dark:text-white">{totalCompletedLessons}</div>
            <div className="text-xs font-semibold uppercase tracking-wider text-slate-400 dark:text-slate-500 mt-1">Lessons Completed</div>
          </div>
        </div>
      </div>

      {/* Error State */}
      {error && (
        <div className="flex items-center space-x-2 p-4 mb-8 rounded-xl bg-red-50 dark:bg-red-950/20 border border-red-100/50 dark:border-red-900/30 text-sm text-red-700 dark:text-red-400">
          <AlertCircle className="h-5 w-5 shrink-0" />
          <span>{error}</span>
        </div>
      )}

      {/* Loading Skeletons */}
      {isLoading ? (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {[1, 2].map((i) => (
            <div key={i} className="animate-pulse flex flex-col p-6 rounded-2xl border border-slate-200 dark:border-slate-900 bg-white dark:bg-slate-900 space-y-4 shadow-sm">
              <div className="h-48 w-full bg-slate-200 dark:bg-slate-800 rounded-xl"></div>
              <div className="h-6 w-3/4 bg-slate-200 dark:bg-slate-800 rounded"></div>
              <div className="h-4 w-1/2 bg-slate-200 dark:bg-slate-800 rounded"></div>
              <div className="h-3 w-full bg-slate-200 dark:bg-slate-800 rounded"></div>
            </div>
          ))}
        </div>
      ) : progressCourses.length === 0 ? (
        /* Empty State */
        <div className="text-center py-16 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl p-8 shadow-sm">
          <GraduationCap className="h-16 w-16 text-slate-300 dark:text-slate-700 mx-auto mb-4" />
          <h3 className="text-lg font-bold text-slate-900 dark:text-white">No enrolled courses</h3>
          <p className="text-slate-500 mt-2 max-w-sm mx-auto">You have not registered for any courses. Let's explore the catalog to start learning!</p>
          <Link to="/courses" className="mt-6 inline-flex items-center justify-center rounded-full bg-indigo-600 px-5 py-2.5 text-sm font-semibold text-white hover:bg-indigo-700 transition-colors">
            Explore Courses
          </Link>
        </div>
      ) : (
        /* Course List Grid */
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {progressCourses.map((course) => {
            const isCompleted = course.completionPercentage === 100;
            return (
              <motion.div 
                key={course.courseId}
                whileHover={{ y: -4 }}
                transition={{ duration: 0.2 }}
                className="flex flex-col p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-md hover:shadow-lg transition-all text-left"
              >
                {/* Course Thumbnail */}
                <div className="relative h-48 w-full rounded-xl bg-slate-100 dark:bg-slate-800 overflow-hidden mb-6 group border border-slate-200 dark:border-slate-800">
                  {course.thumbnailUrl ? (
                    <img 
                      src={course.thumbnailUrl} 
                      alt={course.title}
                      className="h-full w-full object-cover transition-transform duration-300 group-hover:scale-105"
                    />
                  ) : (
                    <div className="h-full w-full flex items-center justify-center bg-gradient-to-br from-indigo-500/10 to-violet-500/10 text-indigo-600 dark:text-indigo-400">
                      <BookOpen className="h-14 w-14 opacity-55" />
                    </div>
                  )}

                  {isCompleted && (
                    <span className="absolute top-3 right-3 inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-emerald-500 text-white shadow-sm">
                      Completed
                    </span>
                  )}
                </div>

                {/* Course Info */}
                <h3 className="text-lg font-bold text-slate-900 dark:text-white line-clamp-1 mb-2">
                  {course.title}
                </h3>
                <p className="text-sm text-slate-500 dark:text-slate-400 font-medium mb-6">
                  Learned {course.completedLessons}/{course.totalLessons} lessons
                </p>

                {/* Progress Bar */}
                <div className="w-full bg-slate-100 dark:bg-slate-800 h-2.5 rounded-full mb-6 overflow-hidden">
                  <div 
                    className={`h-full rounded-full transition-all duration-500 ${isCompleted ? 'bg-emerald-500' : 'bg-indigo-600'}`} 
                    style={{ width: `${course.completionPercentage}%` }}
                  />
                </div>

                <div className="mt-auto flex items-center justify-between">
                  <span className="text-sm font-bold text-slate-700 dark:text-slate-300">
                    {course.completionPercentage}% Completed
                  </span>

                  <Link 
                    to={`/courses/${course.courseId}`}
                    className="inline-flex items-center justify-center space-x-1 py-2 px-4 rounded-xl bg-indigo-50 hover:bg-indigo-100 dark:bg-indigo-950/40 dark:hover:bg-indigo-950/60 text-indigo-600 dark:text-indigo-400 text-xs font-bold transition-all active:scale-95 group"
                  >
                    <span>{isCompleted ? 'Review Course' : 'Continue Learning'}</span>
                    <Play className="h-3 w-3 fill-indigo-600 dark:fill-indigo-400 transition-transform group-hover:translate-x-0.5" />
                  </Link>
                </div>
              </motion.div>
            );
          })}
        </div>
      )}
    </div>
  );
};

export default Dashboard;
