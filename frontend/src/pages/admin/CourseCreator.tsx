import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, Upload, Check, Loader2, Sparkles } from 'lucide-react';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import type { ApiResponse, CategoryResponse, CourseDetailResponse } from '../../types';

const CourseCreator: React.FC = () => {
  const navigate = useNavigate();
  const [categories, setCategories] = useState<CategoryResponse[]>([]);
  const [loadingCats, setLoadingCats] = useState(true);
  const [submitting, setSubmitting] = useState(false);

  // Form states
  const [title, setTitle] = useState('');
  const [price, setPrice] = useState('0');
  const [estimatedDurationHours, setEstimatedDurationHours] = useState('');
  const [shortDescription, setShortDescription] = useState('');
  const [courseContent, setCourseContent] = useState('');
  const [learningOutcomes, setLearningOutcomes] = useState('');
  const [courseHighlights, setCourseHighlights] = useState('');
  const [technologiesTools, setTechnologiesTools] = useState('');
  const [prerequisites, setPrerequisites] = useState('');
  const [targetAudience, setTargetAudience] = useState('');
  const [completionBenefits, setCompletionBenefits] = useState('');
  const [selectedCategoryIds, setSelectedCategoryIds] = useState<number[]>([]);
  const [thumbnailFile, setThumbnailFile] = useState<File | null>(null);
  const [thumbnailPreview, setThumbnailPreview] = useState<string | null>(null);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const res = await api.get<ApiResponse<CategoryResponse[]>>('/courses/categories');
        setCategories(res.data.result || []);
      } catch (err) {
        console.error('Failed to load categories:', err);
      } finally {
        setLoadingCats(false);
      }
    };
    fetchCategories();
  }, []);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      const file = e.target.files[0];
      setThumbnailFile(file);
      setThumbnailPreview(URL.createObjectURL(file));
    }
  };

  const handleCategoryToggle = (catId: number) => {
    setSelectedCategoryIds(prev => 
      prev.includes(catId) ? prev.filter(id => id !== catId) : [...prev, catId]
    );
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim() || submitting) return;

    setSubmitting(true);
    try {
      const formData = new FormData();
      formData.append('title', title);
      formData.append('price', price);
      
      if (estimatedDurationHours) {
        formData.append('estimatedDurationHours', estimatedDurationHours);
      }
      formData.append('shortDescription', shortDescription);
      formData.append('courseContent', courseContent);
      formData.append('learningOutcomes', learningOutcomes);
      formData.append('courseHighlights', courseHighlights);
      formData.append('technologiesTools', technologiesTools);
      formData.append('prerequisites', prerequisites);
      formData.append('targetAudience', targetAudience);
      formData.append('completionBenefits', completionBenefits);

      selectedCategoryIds.forEach(id => {
        formData.append('categoryIds', id.toString());
      });

      if (thumbnailFile) {
        formData.append('thumbnailFile', thumbnailFile);
      }

      await api.post<ApiResponse<CourseDetailResponse>>('/courses', formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });

      alert('Course created successfully!');
      navigate('/admin/dashboard');
    } catch (error: any) {
      console.error('Failed to create course:', error);
      alert(getErrorMessage(error, 'An error occurred while creating course.'));
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="mx-auto max-w-4xl px-4 py-8 sm:px-6 lg:px-8 text-left min-h-screen">
      
      {/* Header */}
      <div className="flex items-center space-x-3 mb-8">
        <button
          onClick={() => navigate('/admin/dashboard')}
          className="p-2 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800 bg-white dark:bg-slate-900 text-slate-500 transition-colors shadow-sm"
        >
          <ArrowLeft className="h-4.5 w-4.5" />
        </button>
        <div>
          <h1 className="text-xl md:text-2xl font-black text-slate-950 dark:text-white tracking-tight">
            Create New Course
          </h1>
          <p className="text-xs text-slate-500 dark:text-slate-400 font-semibold mt-0.5">
            Create high-quality courses and upload cover thumbnails.
          </p>
        </div>
      </div>

      {/* Main Form */}
      <form onSubmit={handleSubmit} className="space-y-8 bg-white dark:bg-slate-900 rounded-3xl border border-slate-300 dark:border-slate-800 p-6 md:p-8 shadow-sm">
        
        {/* Basic Information Section */}
        <div className="space-y-6">
          <h3 className="text-sm font-extrabold text-indigo-600 dark:text-indigo-400 uppercase tracking-wider flex items-center space-x-1.5">
            <Sparkles className="h-4.5 w-4.5" />
            <span>Basic Info</span>
          </h3>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Title */}
            <div className="md:col-span-2 space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Course Title (Required):
              </label>
              <input
                type="text"
                required
                placeholder="Enter course name..."
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
              />
            </div>

            {/* Price */}
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Price (VND) (Enter 0 for Free):
              </label>
              <input
                type="number"
                min="0"
                required
                placeholder="Example: 200000"
                value={price}
                onChange={(e) => setPrice(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
              />
            </div>

          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {/* Estimated hours */}
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Estimated Duration (Hours):
              </label>
              <input
                type="number"
                min="1"
                placeholder="Example: 30"
                value={estimatedDurationHours}
                onChange={(e) => setEstimatedDurationHours(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
              />
            </div>

            {/* Categories */}
            <div className="md:col-span-2 space-y-2">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Course Category:
              </label>
              {loadingCats ? (
                <div className="h-10 bg-slate-100 dark:bg-slate-800 animate-pulse rounded-xl w-1/2"></div>
              ) : (
                <div className="flex flex-wrap gap-2">
                  {categories.map(cat => {
                    const isSelected = selectedCategoryIds.includes(cat.id);
                    return (
                      <button
                        key={cat.id}
                        type="button"
                        onClick={() => handleCategoryToggle(cat.id)}
                        className={`px-3 py-1.5 rounded-xl text-xs font-bold border transition-all ${
                          isSelected
                            ? 'bg-indigo-50 dark:bg-indigo-950/40 border-indigo-500 text-indigo-600 dark:text-indigo-400'
                            : 'border-slate-200 dark:border-slate-800 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800'
                        }`}
                      >
                        {cat.name}
                      </button>
                    );
                  })}
                </div>
              )}
            </div>
          </div>

          {/* Short Description */}
          <div className="space-y-1.5">
            <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
              Short Description:
            </label>
            <textarea
              rows={2}
              placeholder="Enter course summary..."
              value={shortDescription}
              onChange={(e) => setShortDescription(e.target.value)}
              className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
            />
          </div>
        </div>

        <hr className="border-slate-200 dark:border-slate-800" />

        {/* Thumbnail Section */}
        <div className="space-y-4">
          <h3 className="text-sm font-extrabold text-indigo-600 dark:text-indigo-400 uppercase tracking-wider block">
            Course Thumbnail (URL / File)
          </h3>
          
          <div className="flex flex-col md:flex-row gap-6 items-start">
            {/* Upload Area */}
            <div className="w-full md:w-1/2">
              <label className="flex flex-col items-center justify-center border-2 border-dashed border-slate-200 dark:border-slate-800 hover:border-indigo-500 dark:hover:border-indigo-500/70 rounded-2xl p-6 cursor-pointer bg-slate-100/70 dark:bg-slate-950/20 transition-all select-none">
                <Upload className="h-8 w-8 text-slate-400 mb-2" />
                <span className="text-xs font-bold text-slate-600 dark:text-slate-400">Select image file to upload</span>
                <span className="text-[10px] text-slate-400 dark:text-slate-500 mt-1">Supports PNG, JPG (Max 5MB)</span>
                <input 
                  type="file" 
                  accept="image/*" 
                  onChange={handleFileChange}
                  className="hidden" 
                />
              </label>
            </div>

            {/* Preview Image */}
            {thumbnailPreview && (
              <div className="w-full md:w-1/2 space-y-1.5 text-left">
                <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Preview Image:</span>
                <div className="relative rounded-2xl overflow-hidden aspect-video border border-slate-200 dark:border-slate-800 bg-slate-100 dark:bg-slate-950">
                  <img 
                    src={thumbnailPreview} 
                    alt="Course Preview" 
                    className="w-full h-full object-cover" 
                  />
                </div>
              </div>
            )}
          </div>
        </div>

        <hr className="border-slate-200 dark:border-slate-800" />

        {/* Detailed Marketing Info */}
        <div className="space-y-6">
          <h3 className="text-sm font-extrabold text-indigo-600 dark:text-indigo-400 uppercase tracking-wider flex items-center space-x-1.5">
            <Sparkles className="h-4.5 w-4.5" />
            <span>Detailed Content & Landing Page</span>
          </h3>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            {/* Course Highlights */}
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Course Highlights:
              </label>
              <textarea
                rows={3}
                placeholder="Example: Over 50 coding problems; 24/7 online support..."
                value={courseHighlights}
                onChange={(e) => setCourseHighlights(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white text-xs font-semibold"
              />
            </div>

            {/* Learning Outcomes */}
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Learning Outcomes:
              </label>
              <textarea
                rows={3}
                placeholder="Example: Students will master data structures, submit OJ C++ code..."
                value={learningOutcomes}
                onChange={(e) => setLearningOutcomes(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white text-xs font-semibold"
              />
            </div>

            {/* Target Audience */}
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Target Audience:
              </label>
              <textarea
                rows={3}
                placeholder="Example: IT students, coding beginners..."
                value={targetAudience}
                onChange={(e) => setTargetAudience(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white text-xs font-semibold"
              />
            </div>

            {/* Course Content */}
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Detailed Curriculum (Markdown):
              </label>
              <textarea
                rows={3}
                placeholder="Describe teaching syllabus in detail..."
                value={courseContent}
                onChange={(e) => setCourseContent(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white text-xs font-semibold"
              />
            </div>

            {/* Technologies */}
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Technologies & Tools Used:
              </label>
              <input
                type="text"
                placeholder="Example: VS Code, Git, Python 3.10"
                value={technologiesTools}
                onChange={(e) => setTechnologiesTools(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
              />
            </div>

            {/* Prerequisites */}
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Basic Prerequisites:
              </label>
              <input
                type="text"
                placeholder="Example: Basic understanding of arrays"
                value={prerequisites}
                onChange={(e) => setPrerequisites(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
              />
            </div>

            {/* Completion Benefits */}
            <div className="md:col-span-2 space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Completion Benefits:
              </label>
              <textarea
                rows={2}
                placeholder="Example: Completion certificate, internship support..."
                value={completionBenefits}
                onChange={(e) => setCompletionBenefits(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white text-xs font-semibold"
              />
            </div>

          </div>
        </div>

        {/* Buttons */}
        <div className="flex justify-end space-x-3 pt-4 border-t border-slate-200 dark:border-slate-800">
          <button
            type="button"
            onClick={() => navigate('/admin/dashboard')}
            disabled={submitting}
            className="px-5 py-2.5 border border-slate-200 dark:border-slate-800 rounded-xl text-xs font-bold text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
          >
            Cancel
          </button>
          <button
            type="submit"
            disabled={submitting}
            className="px-6 py-2.5 bg-indigo-600 hover:bg-indigo-700 disabled:opacity-50 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/15 hover:shadow-indigo-600/25 transition-all flex items-center space-x-1.5 active:scale-95"
          >
            {submitting ? (
              <Loader2 className="h-4 w-4 animate-spin" />
            ) : (
              <Check className="h-4 w-4" />
            )}
            <span>Create Course</span>
          </button>
        </div>

      </form>
    </div>
  );
};

export default CourseCreator;
