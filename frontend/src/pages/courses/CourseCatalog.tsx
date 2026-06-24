import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { 
  Search, 
  Filter, 
  Star, 
  Users, 
  ArrowUpDown, 
  BookOpen, 
  ChevronLeft, 
  ChevronRight,
  SlidersHorizontal,
  X,
  User,
  Sparkles,
  Check,
  GraduationCap
} from 'lucide-react';
import api from '../../api/axios';
import type { ApiResponse, PageResponse, CourseListItemResponse, CategoryResponse } from '../../types';

const CourseCatalog: React.FC = () => {
  // Courses & Pagination State
  const [courses, setCourses] = useState<CourseListItemResponse[]>([]);
  const [totalPages, setTotalPages] = useState(0);
  const [currentPage, setCurrentPage] = useState(0);
  const [totalElements, setTotalElements] = useState(0);
  const [isLoading, setIsLoading] = useState(true);
  const [isFilterOpen, setIsFilterOpen] = useState(false);

  // Dynamic Categories State
  const [categories, setCategories] = useState<CategoryResponse[]>([]);
  const [isCategoriesLoading, setIsCategoriesLoading] = useState(true);

  // Raw User Input States (will be debounced)
  const [keywordInput, setKeywordInput] = useState('');
  const [teacherNameInput, setTeacherNameInput] = useState('');
  const [minPriceInput, setMinPriceInput] = useState('');
  const [maxPriceInput, setMaxPriceInput] = useState('');

  // Debounced/Active Filter States
  const [keyword, setKeyword] = useState('');
  const [teacherName, setTeacherName] = useState('');
  const [minPrice, setMinPrice] = useState('');
  const [maxPrice, setMaxPrice] = useState('');
  const [selectedCategories, setSelectedCategories] = useState<number[]>([]);
  const [minRating, setMinRating] = useState(0);
  const [sortBy, setSortBy] = useState('totalEnrolled');
  const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('desc');

  // Fetch Categories on Mount
  useEffect(() => {
    const fetchCategories = async () => {
      setIsCategoriesLoading(true);
      try {
        const response = await api.get<ApiResponse<CategoryResponse[]>>('/courses/categories');
        setCategories(response.data.result || []);
      } catch (err) {
        console.error('Failed to fetch categories:', err);
        // Fallback list if API fails
        setCategories([
          { id: 1, name: 'Frontend Development' },
          { id: 2, name: 'Backend Development' },
          { id: 3, name: 'Computer Science & Algorithms' },
          { id: 4, name: 'Databases' },
          { id: 5, name: 'Mobile Development' },
        ]);
      } finally {
        setIsCategoriesLoading(false);
      }
    };
    fetchCategories();
  }, []);

  // Debounce hook replacement using useEffect
  useEffect(() => {
    const timer = setTimeout(() => {
      setKeyword(keywordInput);
      setTeacherName(teacherNameInput);
      setMinPrice(minPriceInput);
      setMaxPrice(maxPriceInput);
    }, 300);

    return () => clearTimeout(timer);
  }, [keywordInput, teacherNameInput, minPriceInput, maxPriceInput]);

  // Fetch Courses Core Function
  const fetchCourses = async (pageIndex = 0) => {
    setIsLoading(true);
    try {
      const params: any = {
        page: pageIndex,
        size: 9,
        sortBy: [sortBy],
        order: [sortOrder]
      };

      if (keyword.trim()) params.keyword = keyword.trim();
      if (teacherName.trim()) params.teacherName = teacherName.trim();
      if (selectedCategories.length > 0) params.categoryIds = selectedCategories.join(',');
      if (minPrice) params.minPrice = minPrice;
      if (maxPrice) params.maxPrice = maxPrice;
      if (minRating > 0) params.minRating = minRating;

      const response = await api.get<ApiResponse<PageResponse<CourseListItemResponse>>>('/courses', { params });
      const pageData = response.data.result;
      
      setCourses(pageData.content || []);
      setTotalPages(pageData.totalPages);
      setTotalElements(pageData.totalElements);
      setCurrentPage(pageData.page);
    } catch (error) {
      console.error('Failed to fetch courses:', error);
    } finally {
      setIsLoading(false);
    }
  };

  // Auto-search effect: Refetch courses whenever filters or sorting changes
  useEffect(() => {
    fetchCourses(0);
  }, [keyword, teacherName, selectedCategories, minPrice, maxPrice, minRating, sortBy, sortOrder]);

  const handleCategoryToggle = (id: number) => {
    setSelectedCategories(prev => 
      prev.includes(id) ? prev.filter(c => c !== id) : [...prev, id]
    );
  };

  const handleClearFilters = () => {
    setKeywordInput('');
    setTeacherNameInput('');
    setMinPriceInput('');
    setMaxPriceInput('');
    setKeyword('');
    setTeacherName('');
    setMinPrice('');
    setMaxPrice('');
    setSelectedCategories([]);
    setMinRating(0);
    setSortBy('totalEnrolled');
    setSortOrder('desc');
  };

  const formatVND = (amount: number) => {
    if (amount === 0) return 'Free';
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
  };

  // Animation variants
  const cardContainerVariants = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.05
      }
    }
  };

  const cardItemVariants = {
    hidden: { opacity: 0, y: 15 },
    show: { opacity: 1, y: 0, transition: { type: 'spring' as const, stiffness: 100, damping: 15 } }
  };

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-8 sm:px-6 lg:px-8 flex flex-col bg-gradient-to-b from-slate-50/30 via-transparent to-transparent dark:from-slate-950/10">
      {/* Header section with rich aesthetics */}
      <div className="relative text-left mb-10 p-8 rounded-3xl overflow-hidden bg-gradient-to-r from-indigo-500/5 via-purple-500/5 to-pink-500/5 dark:from-indigo-500/10 dark:via-purple-500/10 dark:to-pink-500/10 border border-slate-200/50 dark:border-slate-800/50 backdrop-blur-md">
        <div className="absolute top-0 right-0 -mt-8 -mr-8 w-32 h-32 rounded-full bg-gradient-to-br from-indigo-500/20 to-purple-500/20 blur-2xl dark:opacity-30"></div>
        <div className="absolute bottom-0 left-1/3 -mb-10 w-40 h-40 rounded-full bg-gradient-to-tr from-pink-500/10 to-violet-500/10 blur-3xl dark:opacity-20"></div>
        
        <div className="relative flex flex-col md:flex-row md:items-center justify-between gap-6">
          <div>
            <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-indigo-50 dark:bg-indigo-950/50 border border-indigo-100 dark:border-indigo-900/30 text-indigo-600 dark:text-indigo-400 text-xs font-bold uppercase tracking-wider mb-3">
              <Sparkles className="h-3 w-3" />
              <span>Discover Knowledge</span>
            </div>
            <h1 className="text-3xl md:text-4xl font-extrabold tracking-tight bg-gradient-to-r from-slate-900 via-indigo-950 to-slate-900 dark:from-white dark:via-indigo-100 dark:to-white bg-clip-text text-transparent">
              Explore Our Course Catalog
            </h1>
            <p className="text-slate-500 dark:text-slate-400 mt-2 max-w-2xl text-sm leading-relaxed">
              Enhance your programming skills, build real projects, and learn directly from certified software engineering teachers.
            </p>
          </div>
          <div className="flex items-center space-x-2 self-start md:self-center bg-white/80 dark:bg-slate-900/80 border border-slate-200/80 dark:border-slate-800/80 px-4 py-2.5 rounded-2xl shadow-sm backdrop-blur-sm text-sm">
            <BookOpen className="h-5 w-5 text-indigo-500" />
            <span className="font-bold text-slate-800 dark:text-slate-200">{totalElements}</span>
            <span className="text-slate-500">courses available</span>
          </div>
        </div>
      </div>

      {/* Control bar */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
        {/* Keyword Search Input */}
        <div className="relative flex-grow max-w-md">
          <input
            type="text"
            placeholder="Search by course title..."
            value={keywordInput}
            onChange={(e) => setKeywordInput(e.target.value)}
            className="w-full pl-11 pr-10 py-3 rounded-2xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 text-sm placeholder-slate-400 text-slate-800 dark:text-slate-100 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 dark:focus:border-indigo-500/80 transition-all shadow-sm"
          />
          <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
            <Search className="h-4.5 w-4.5" />
          </div>
          {keywordInput && (
            <button 
              onClick={() => setKeywordInput('')}
              className="absolute inset-y-0 right-0 pr-3 flex items-center text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors"
            >
              <X className="h-4 w-4" />
            </button>
          )}
        </div>

        <div className="flex items-center gap-3 self-end md:self-auto">
          {/* Mobile Filter Toggle */}
          <button
            onClick={() => setIsFilterOpen(true)}
            className="flex lg:hidden items-center space-x-2 py-3 px-5 rounded-2xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 text-sm font-semibold hover:bg-slate-50 dark:hover:bg-slate-850 active:scale-95 transition-all shadow-sm"
          >
            <Filter className="h-4 w-4 text-indigo-500" />
            <span>Filters</span>
            {(selectedCategories.length > 0 || minRating > 0 || teacherName || minPrice || maxPrice) && (
              <span className="h-2 w-2 rounded-full bg-indigo-600"></span>
            )}
          </button>

          {/* Sorting Dropdown */}
          <div className="flex items-center space-x-2.5 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl px-4 py-3 text-sm font-semibold shadow-sm">
            <ArrowUpDown className="h-4 w-4 text-slate-400" />
            <select
              value={`${sortBy}-${sortOrder}`}
              onChange={(e) => {
                const [field, order] = e.target.value.split('-');
                setSortBy(field);
                setSortOrder(order as 'asc' | 'desc');
              }}
              className="bg-transparent focus:outline-none text-slate-700 dark:text-slate-200 text-sm cursor-pointer border-none p-0 pr-2"
            >
              <option value="totalEnrolled-desc">Most Popular</option>
              <option value="price-asc">Price: Low to High</option>
              <option value="price-desc">Price: High to Low</option>
              <option value="averageRating-desc">Highest Rated</option>
            </select>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
        {/* Desktop Filter Sidebar */}
        <aside className="hidden lg:block lg:col-span-1 space-y-6 text-left">
          <div className="p-6 rounded-3xl bg-white dark:bg-slate-900 border border-slate-200/80 dark:border-slate-800/80 shadow-sm space-y-6 sticky top-24">
            <div className="flex items-center justify-between border-b border-slate-100 dark:border-slate-800/60 pb-4">
              <h3 className="font-extrabold text-slate-900 dark:text-white flex items-center text-base">
                <SlidersHorizontal className="h-4.5 w-4.5 mr-2 text-indigo-500" />
                <span>Search Filters</span>
              </h3>
              <button 
                onClick={handleClearFilters}
                className="text-xs font-bold text-slate-400 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors"
              >
                Clear All
              </button>
            </div>

            {/* Teacher Search Filter */}
            <div className="space-y-2.5">
              <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Instructor</h4>
              <div className="relative">
                <input
                  type="text"
                  placeholder="Filter by teacher name..."
                  value={teacherNameInput}
                  onChange={(e) => setTeacherNameInput(e.target.value)}
                  className="w-full pl-9 pr-8 py-2 text-xs rounded-xl border border-slate-200 dark:border-slate-850 bg-slate-50/50 dark:bg-slate-950/40 text-slate-800 dark:text-slate-200 placeholder-slate-400 focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 transition-all"
                />
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                  <User className="h-3.5 w-3.5" />
                </div>
                {teacherNameInput && (
                  <button 
                    onClick={() => setTeacherNameInput('')}
                    className="absolute inset-y-0 right-0 pr-2.5 flex items-center text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors"
                  >
                    <X className="h-3 w-3" />
                  </button>
                )}
              </div>
            </div>

            {/* Categories filter */}
            <div className="space-y-3">
              <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Categories</h4>
              <div className="space-y-2 max-h-[220px] overflow-y-auto pr-1 scrollbar-thin scrollbar-thumb-slate-200 dark:scrollbar-thumb-slate-800">
                {isCategoriesLoading ? (
                  // Categories Skeleton
                  [1, 2, 3].map((i) => (
                    <div key={i} className="flex items-center space-x-2 animate-pulse">
                      <div className="h-4 w-4 bg-slate-200 dark:bg-slate-800 rounded"></div>
                      <div className="h-3 w-28 bg-slate-200 dark:bg-slate-800 rounded"></div>
                    </div>
                  ))
                ) : (
                  categories.map(category => (
                    <label key={category.id} className="flex items-center space-x-2.5 text-sm font-medium text-slate-600 dark:text-slate-350 cursor-pointer select-none group hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors">
                      <div className="relative flex items-center justify-center">
                        <input
                          type="checkbox"
                          checked={selectedCategories.includes(category.id)}
                          onChange={() => handleCategoryToggle(category.id)}
                          className="peer sr-only"
                        />
                        <div className="w-4 h-4 rounded border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-950 transition-all peer-checked:border-indigo-600 peer-checked:bg-indigo-600 flex items-center justify-center">
                          <Check className="h-2.5 w-2.5 text-white opacity-0 peer-checked:opacity-100 transition-opacity" />
                        </div>
                      </div>
                      <span className="text-xs truncate">{category.name}</span>
                    </label>
                  ))
                )}
              </div>
            </div>

            {/* Price Filter */}
            <div className="space-y-3">
              <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Price Range (VND)</h4>
              <div className="flex items-center space-x-2">
                <div className="relative flex-1">
                  <span className="absolute inset-y-0 left-0 pl-2.5 flex items-center text-[10px] text-slate-400">₫</span>
                  <input
                    type="number"
                    placeholder="Min"
                    value={minPriceInput}
                    onChange={(e) => setMinPriceInput(e.target.value)}
                    className="w-full pl-6 pr-2 py-2 rounded-xl border border-slate-200 dark:border-slate-850 bg-slate-50/50 dark:bg-slate-950/40 text-xs placeholder-slate-400 focus:outline-none focus:ring-1 focus:ring-indigo-500 transition-all"
                  />
                </div>
                <span className="text-slate-400 text-xs">-</span>
                <div className="relative flex-1">
                  <span className="absolute inset-y-0 left-0 pl-2.5 flex items-center text-[10px] text-slate-400">₫</span>
                  <input
                    type="number"
                    placeholder="Max"
                    value={maxPriceInput}
                    onChange={(e) => setMaxPriceInput(e.target.value)}
                    className="w-full pl-6 pr-2 py-2 rounded-xl border border-slate-200 dark:border-slate-850 bg-slate-50/50 dark:bg-slate-950/40 text-xs placeholder-slate-400 focus:outline-none focus:ring-1 focus:ring-indigo-500 transition-all"
                  />
                </div>
              </div>
            </div>

            {/* Rating Filter */}
            <div className="space-y-3">
              <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Ratings</h4>
              <div className="space-y-1.5">
                {[4, 3, 2, 1].map(stars => (
                  <button
                    key={stars}
                    onClick={() => setMinRating(minRating === stars ? 0 : stars)}
                    className={`flex items-center space-x-2 text-xs font-semibold transition-all w-full text-left py-2 px-2.5 rounded-xl border ${
                      minRating === stars 
                        ? 'border-indigo-200 bg-indigo-50/80 text-indigo-700 dark:border-indigo-900/40 dark:bg-indigo-950/40 dark:text-indigo-400' 
                        : 'border-transparent text-slate-600 dark:text-slate-350 hover:bg-slate-50 dark:hover:bg-slate-900/50 hover:text-indigo-600'
                    }`}
                  >
                    <div className="flex text-amber-400">
                      {[...Array(5)].map((_, i) => (
                        <Star key={i} className={`h-3.5 w-3.5 ${i < stars ? 'fill-current' : 'opacity-20 text-slate-400'}`} />
                      ))}
                    </div>
                    <span>{stars} stars & up</span>
                  </button>
                ))}
              </div>
            </div>
          </div>
        </aside>

        {/* Course Grid & Main Catalog View */}
        <div className="lg:col-span-3 space-y-8 flex flex-col">
          {isLoading ? (
            /* Loading skeletons with clean design */
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
              {[1, 2, 3, 4, 5, 6].map((i) => (
                <div key={i} className="animate-pulse flex flex-col p-5 rounded-3xl bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-850 space-y-4">
                  <div className="h-44 w-full bg-slate-100 dark:bg-slate-850 rounded-2xl"></div>
                  <div className="h-5 w-3/4 bg-slate-100 dark:bg-slate-850 rounded-lg"></div>
                  <div className="h-4 w-1/2 bg-slate-100 dark:bg-slate-850 rounded-lg"></div>
                  <div className="h-1 w-full bg-slate-100 dark:bg-slate-850 rounded-full"></div>
                  <div className="flex justify-between items-center pt-2">
                    <div className="h-5 w-16 bg-slate-100 dark:bg-slate-850 rounded-lg"></div>
                    <div className="h-8 w-20 bg-slate-100 dark:bg-slate-850 rounded-xl"></div>
                  </div>
                </div>
              ))}
            </div>
          ) : courses.length === 0 ? (
            /* Premium Empty State */
            <div className="text-center py-24 bg-white dark:bg-slate-900 border border-slate-200/60 dark:border-slate-800/40 rounded-3xl p-8 shadow-sm flex flex-col items-center justify-center">
              <div className="p-5 rounded-2xl bg-indigo-50 dark:bg-indigo-950/40 text-indigo-600 dark:text-indigo-400 mb-5">
                <BookOpen className="h-10 w-10 opacity-80" />
              </div>
              <h3 className="text-xl font-extrabold text-slate-900 dark:text-white">No courses match your filters</h3>
              <p className="text-slate-500 dark:text-slate-400 mt-2 max-w-md mx-auto text-sm leading-relaxed">
                We couldn't find any courses matching your specific criteria. Try adjusting search queries, price ranges, or category tags.
              </p>
              <button 
                onClick={handleClearFilters} 
                className="mt-6 inline-flex items-center justify-center rounded-2xl bg-indigo-600 px-6 py-3 text-sm font-bold text-white hover:bg-indigo-700 hover:shadow-lg hover:shadow-indigo-500/20 active:scale-95 transition-all"
              >
                Clear All Filters
              </button>
            </div>
          ) : (
            /* Grid View with stagger children animations */
            <motion.div 
              variants={cardContainerVariants}
              initial="hidden"
              animate="show"
              className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6"
            >
              {courses.map((course) => (
                <motion.div
                  key={course.id}
                  variants={cardItemVariants}
                  whileHover={{ y: -6, transition: { duration: 0.2 } }}
                  className="group flex flex-col p-4 bg-white dark:bg-slate-900 border border-slate-200/60 dark:border-slate-800/50 hover:border-indigo-500/30 rounded-3xl shadow-sm hover:shadow-xl hover:shadow-indigo-500/5 dark:hover:shadow-indigo-950/20 transition-all text-left relative overflow-hidden"
                >
                  {/* Thumbnail Container */}
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

                    {course.enrolled && (
                      <div className="absolute top-3 left-3 flex items-center space-x-1 px-3 py-1 rounded-full text-[10px] font-extrabold bg-emerald-500/90 text-white shadow-md shadow-emerald-500/10 backdrop-blur-sm uppercase tracking-wider">
                        <Check className="h-2.5 w-2.5 stroke-[3px]" />
                        <span>Enrolled</span>
                      </div>
                    )}
                  </Link>

                  {/* Title & Desc */}
                  <div className="flex-grow flex flex-col px-1">
                    <Link to={`/courses/${course.id}`} className="hover:text-indigo-600 dark:hover:text-indigo-450 transition-colors inline-block mb-1">
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

                  {course.enrolled ? (
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

                      {/* Stats & Learn Now button */}
                      <div className="flex items-center justify-between text-xs pt-0.5">
                        <div className="flex items-center space-x-3 text-slate-500 dark:text-slate-400">
                          {/* Rating */}
                          <span className="flex items-center space-x-0.5">
                            <Star className="h-3.5 w-3.5 fill-current text-amber-400" />
                            <span className="font-bold text-slate-700 dark:text-slate-200">{course.averageRating.toFixed(1)}</span>
                            <span className="text-[10px] text-slate-400">({course.totalReviews})</span>
                          </span>

                          {/* Enrolled students */}
                          <span className="flex items-center space-x-1">
                            <Users className="h-3.5 w-3.5 text-slate-400" />
                            <span className="font-semibold text-slate-700 dark:text-slate-300">{course.totalEnrolled}</span>
                          </span>
                        </div>

                        <Link
                          to={`/courses/${course.id}`}
                          className="inline-flex items-center space-x-1 px-3 py-2 bg-emerald-50 hover:bg-emerald-100 dark:bg-emerald-950/30 dark:hover:bg-emerald-950/50 text-emerald-600 dark:text-emerald-400 border border-emerald-100 dark:border-emerald-900/20 rounded-xl text-[11px] font-extrabold transition-all active:scale-95 shadow-sm"
                        >
                          <span>Learn Now</span>
                        </Link>
                      </div>
                    </div>
                  ) : (
                    <div className="flex items-center justify-between text-xs px-1">
                      <div className="flex items-center space-x-3 text-slate-500 dark:text-slate-400">
                        {/* Rating */}
                        <span className="flex items-center space-x-0.5">
                          <Star className="h-3.5 w-3.5 fill-current text-amber-400" />
                          <span className="font-bold text-slate-700 dark:text-slate-200">{course.averageRating.toFixed(1)}</span>
                          <span className="text-[10px] text-slate-400">({course.totalReviews})</span>
                        </span>

                        {/* Enrolled students */}
                        <span className="flex items-center space-x-1">
                          <Users className="h-3.5 w-3.5 text-slate-400" />
                          <span className="font-semibold text-slate-700 dark:text-slate-300">{course.totalEnrolled}</span>
                        </span>
                      </div>

                      {/* Price */}
                      <div className="font-extrabold text-sm text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-950/40 px-2.5 py-1.5 rounded-xl border border-indigo-100/50 dark:border-indigo-900/20">
                        {formatVND(course.price)}
                      </div>
                    </div>
                  )}
                </motion.div>
              ))}
            </motion.div>
          )}

          {/* Pagination Controls */}
          {totalPages > 1 && (
            <div className="flex items-center justify-center space-x-2 pt-8 mt-auto">
              <button
                onClick={() => fetchCourses(currentPage - 1)}
                disabled={currentPage === 0 || isLoading}
                className="p-2.5 rounded-xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 hover:bg-slate-50 dark:hover:bg-slate-850 disabled:opacity-40 disabled:hover:bg-white dark:disabled:hover:bg-slate-900 transition-colors shadow-sm cursor-pointer"
              >
                <ChevronLeft className="h-4 w-4" />
              </button>

              {[...Array(totalPages)].map((_, index) => (
                <button
                  key={index}
                  onClick={() => fetchCourses(index)}
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
                onClick={() => fetchCourses(currentPage + 1)}
                disabled={currentPage === totalPages - 1 || isLoading}
                className="p-2.5 rounded-xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 hover:bg-slate-50 dark:hover:bg-slate-850 disabled:opacity-40 disabled:hover:bg-white dark:disabled:hover:bg-slate-900 transition-colors shadow-sm cursor-pointer"
              >
                <ChevronRight className="h-4 w-4" />
              </button>
            </div>
          )}
        </div>
      </div>

      {/* Mobile Filters Modal */}
      <AnimatePresence>
        {isFilterOpen && (
          <motion.div 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 flex justify-end bg-black/40 backdrop-blur-sm lg:hidden"
          >
            <motion.div
              initial={{ x: '100%' }}
              animate={{ x: 0 }}
              exit={{ x: '100%' }}
              transition={{ type: 'tween', duration: 0.3 }}
              className="w-full max-w-sm bg-white dark:bg-slate-900 h-full p-6 shadow-xl flex flex-col text-left overflow-y-auto"
            >
              <div className="flex items-center justify-between border-b border-slate-200 dark:border-slate-800 pb-4 mb-6">
                <h3 className="font-extrabold text-lg text-slate-950 dark:text-white flex items-center">
                  <SlidersHorizontal className="h-4.5 w-4.5 mr-2 text-indigo-500" />
                  <span>Search Filters</span>
                </h3>
                <button onClick={() => setIsFilterOpen(false)} className="p-1.5 text-slate-400 hover:text-slate-650 dark:hover:text-slate-200 rounded-lg">
                  <X className="h-5 w-5" />
                </button>
              </div>

              {/* Mobile filter content */}
              <div className="space-y-6 flex-grow">
                {/* Instructor */}
                <div className="space-y-2.5">
                  <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Instructor</h4>
                  <div className="relative">
                    <input
                      type="text"
                      placeholder="Filter by teacher name..."
                      value={teacherNameInput}
                      onChange={(e) => setTeacherNameInput(e.target.value)}
                      className="w-full pl-9 pr-8 py-2.5 text-xs rounded-xl border border-slate-200 dark:border-slate-850 bg-slate-50/50 dark:bg-slate-950/40 text-slate-850 dark:text-slate-200 focus:outline-none focus:ring-1 focus:ring-indigo-500"
                    />
                    <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                      <User className="h-3.5 w-3.5" />
                    </div>
                  </div>
                </div>

                {/* Categories */}
                <div className="space-y-3">
                  <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Categories</h4>
                  <div className="space-y-2 max-h-[220px] overflow-y-auto pr-1">
                    {isCategoriesLoading ? (
                      [1, 2, 3].map((i) => (
                        <div key={i} className="flex items-center space-x-2 animate-pulse">
                          <div className="h-4 w-4 bg-slate-200 dark:bg-slate-800 rounded"></div>
                          <div className="h-3 w-28 bg-slate-200 dark:bg-slate-800 rounded"></div>
                        </div>
                      ))
                    ) : (
                      categories.map(category => (
                        <label key={category.id} className="flex items-center space-x-2.5 text-sm font-medium text-slate-650 dark:text-slate-350 cursor-pointer">
                          <div className="relative flex items-center justify-center">
                            <input
                              type="checkbox"
                              checked={selectedCategories.includes(category.id)}
                              onChange={() => handleCategoryToggle(category.id)}
                              className="peer sr-only"
                            />
                            <div className="w-4 h-4 rounded border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-955 peer-checked:border-indigo-600 peer-checked:bg-indigo-600 flex items-center justify-center">
                              <Check className="h-2.5 w-2.5 text-white opacity-0 peer-checked:opacity-100" />
                            </div>
                          </div>
                          <span className="text-xs truncate">{category.name}</span>
                        </label>
                      ))
                    )}
                  </div>
                </div>

                {/* Price range */}
                <div className="space-y-3">
                  <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Price Range (VND)</h4>
                  <div className="flex items-center space-x-2">
                    <div className="relative flex-1">
                      <span className="absolute inset-y-0 left-0 pl-2.5 flex items-center text-[10px] text-slate-400">₫</span>
                      <input
                        type="number"
                        placeholder="Min"
                        value={minPriceInput}
                        onChange={(e) => setMinPriceInput(e.target.value)}
                        className="w-full pl-6 pr-2 py-2 rounded-xl border border-slate-200 dark:border-slate-850 bg-slate-50/50 dark:bg-slate-950/40 text-xs placeholder-slate-400 focus:outline-none"
                      />
                    </div>
                    <span>-</span>
                    <div className="relative flex-1">
                      <span className="absolute inset-y-0 left-0 pl-2.5 flex items-center text-[10px] text-slate-400">₫</span>
                      <input
                        type="number"
                        placeholder="Max"
                        value={maxPriceInput}
                        onChange={(e) => setMaxPriceInput(e.target.value)}
                        className="w-full pl-6 pr-2 py-2 rounded-xl border border-slate-200 dark:border-slate-850 bg-slate-50/50 dark:bg-slate-950/40 text-xs placeholder-slate-400 focus:outline-none"
                      />
                    </div>
                  </div>
                </div>

                {/* Rating */}
                <div className="space-y-3">
                  <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400 dark:text-slate-500">Ratings</h4>
                  <div className="space-y-2">
                    {[4, 3, 2, 1].map(stars => (
                      <button
                        key={stars}
                        onClick={() => setMinRating(minRating === stars ? 0 : stars)}
                        className={`flex items-center space-x-2 text-xs font-semibold transition-all w-full text-left py-2.5 px-3 rounded-xl border ${
                          minRating === stars 
                            ? 'border-indigo-200 bg-indigo-50 dark:border-indigo-900/40 dark:bg-indigo-950/40 dark:text-indigo-400' 
                            : 'border-slate-105 dark:border-slate-800 text-slate-600 dark:text-slate-350 hover:bg-slate-50 dark:hover:bg-slate-900/50'
                        }`}
                      >
                        <div className="flex text-amber-400">
                          {[...Array(5)].map((_, i) => (
                            <Star key={i} className={`h-3.5 w-3.5 ${i < stars ? 'fill-current' : 'opacity-20 text-slate-400'}`} />
                          ))}
                        </div>
                        <span>{stars} stars & up</span>
                      </button>
                    ))}
                  </div>
                </div>
              </div>

              <div className="border-t border-slate-200 dark:border-slate-800 pt-4 mt-6 flex gap-4">
                <button
                  onClick={() => {
                    handleClearFilters();
                    setIsFilterOpen(false);
                  }}
                  className="flex-grow py-3 text-xs font-bold rounded-xl border border-slate-200 dark:border-slate-800 text-slate-500 hover:bg-slate-50 text-center"
                >
                  Clear Filters
                </button>
                <button
                  onClick={() => setIsFilterOpen(false)}
                  className="flex-grow py-3 text-xs font-bold rounded-xl bg-indigo-600 text-white text-center shadow-md shadow-indigo-500/10 hover:bg-indigo-750"
                >
                  Close & View
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};

export default CourseCatalog;
