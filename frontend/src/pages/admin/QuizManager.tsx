import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { ArrowLeft, Trash2, Plus, Check, Loader2, Sparkles, RefreshCw } from 'lucide-react';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import type { ApiResponse, QuizDetailResponse } from '../../types';

interface OptionState {
  id: number | null;
  content: string;
  isCorrect: boolean;
  orderIndex: number;
}

interface QuestionState {
  id: number | null;
  questionContent: string;
  orderIndex: number;
  options: OptionState[];
}

const QuizManager: React.FC = () => {
  const { lessonId } = useParams<{ lessonId: string }>();
  const navigate = useNavigate();

  const lessonIdNum = Number(lessonId);

  // States
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [questions, setQuestions] = useState<QuestionState[]>([]);
  
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [exists, setExists] = useState(false);

  useEffect(() => {
    const fetchQuizDetails = async () => {
      if (!lessonId) return;
      setLoading(true);
      try {
        const res = await api.get<ApiResponse<QuizDetailResponse>>(`/lessons/${lessonId}/quiz`);
        const data = res.data.result;
        if (data) {
          setTitle(data.title);
          setDescription(data.description || '');
          
          // Map to local question state structure
          const mappedQuestions: QuestionState[] = data.questions.map(q => ({
            id: q.id,
            questionContent: q.questionContent,
            orderIndex: q.orderIndex,
            options: q.options.map(o => ({
              id: o.id,
              content: o.content,
              isCorrect: o.isCorrect,
              orderIndex: o.orderIndex
            }))
          }));
          setQuestions(mappedQuestions);
          setExists(true);
        } else {
          setExists(false);
          setupDefaultQuiz();
        }
      } catch (err) {
        console.warn('Quiz does not exist yet for this lesson. Setting up default creator.', err);
        setExists(false);
        setupDefaultQuiz();
      } finally {
        setLoading(false);
      }
    };

    fetchQuizDetails();
  }, [lessonId]);

  const setupDefaultQuiz = () => {
    setTitle('Evaluation Quiz');
    setDescription('Answer the following questions to test your understanding.');
    setQuestions([
      {
        id: null,
        questionContent: 'Question #1',
        orderIndex: 0,
        options: [
          { id: null, content: 'Option A', isCorrect: true, orderIndex: 0 },
          { id: null, content: 'Option B', isCorrect: false, orderIndex: 1 }
        ]
      }
    ]);
  };

  // Add Question
  const handleAddQuestion = () => {
    setQuestions(prev => [
      ...prev,
      {
        id: null,
        questionContent: `Question #${prev.length + 1}`,
        orderIndex: prev.length,
        options: [
          { id: null, content: 'Option 1', isCorrect: true, orderIndex: 0 },
          { id: null, content: 'Option 2', isCorrect: false, orderIndex: 1 }
        ]
      }
    ]);
  };

  // Delete Question
  const handleDeleteQuestion = (qIndex: number) => {
    if (questions.length <= 1) {
      alert('The quiz must have at least 1 question.');
      return;
    }
    setQuestions(prev => 
      prev
        .filter((_, idx) => idx !== qIndex)
        .map((q, idx) => ({ ...q, orderIndex: idx }))
    );
  };

  const handleQuestionContentChange = (qIndex: number, val: string) => {
    setQuestions(prev => 
      prev.map((q, idx) => idx === qIndex ? { ...q, questionContent: val } : q)
    );
  };

  // Option operations
  const handleAddOption = (qIndex: number) => {
    setQuestions(prev => 
      prev.map((q, idx) => {
        if (idx === qIndex) {
          return {
            ...q,
            options: [
              ...q.options,
              { id: null, content: `New Option`, isCorrect: false, orderIndex: q.options.length }
            ]
          };
        }
        return q;
      })
    );
  };

  const handleDeleteOption = (qIndex: number, oIndex: number) => {
    const question = questions[qIndex];
    if (question.options.length <= 2) {
      alert('Each question must have at least 2 options.');
      return;
    }

    setQuestions(prev => 
      prev.map((q, idx) => {
        if (idx === qIndex) {
          // If deleted option was correct, mark the first remaining one as correct
          const deletedOpt = q.options[oIndex];
          let remainingOpts = q.options.filter((_, oIdx) => oIdx !== oIndex);
          
          if (deletedOpt.isCorrect && remainingOpts.length > 0) {
            remainingOpts[0].isCorrect = true;
          }

          return {
            ...q,
            options: remainingOpts.map((o, oIdx) => ({ ...o, orderIndex: oIdx }))
          };
        }
        return q;
      })
    );
  };

  const handleOptionContentChange = (qIndex: number, oIndex: number, val: string) => {
    setQuestions(prev => 
      prev.map((q, idx) => {
        if (idx === qIndex) {
          return {
            ...q,
            options: q.options.map((o, oIdx) => oIdx === oIndex ? { ...o, content: val } : o)
          };
        }
        return q;
      })
    );
  };

  const handleOptionCorrectToggle = (qIndex: number, oIndex: number) => {
    setQuestions(prev => 
      prev.map((q, idx) => {
        if (idx === qIndex) {
          return {
            ...q,
            options: q.options.map((o, oIdx) => ({
              ...o,
              isCorrect: oIdx === oIndex
            }))
          };
        }
        return q;
      })
    );
  };

  // Save Quiz handler
  const handleSaveQuiz = async () => {
    if (!title.trim() || submitting) return;

    // Validate quiz payload
    for (let i = 0; i < questions.length; i++) {
      const q = questions[i];
      if (!q.questionContent.trim()) {
        alert(`Question content for question #${i + 1} cannot be empty.`);
        return;
      }
      const hasCorrect = q.options.some(o => o.isCorrect);
      if (!hasCorrect) {
        alert(`Question #${i + 1} must have at least 1 correct option.`);
        return;
      }
      for (let j = 0; j < q.options.length; j++) {
        if (!q.options[j].content.trim()) {
          alert(`Option #${j + 1} for question #${i + 1} cannot be empty.`);
          return;
        }
      }
    }

    setSubmitting(true);
    try {
      const payload = {
        title,
        description,
        questions: questions.map(q => ({
          id: q.id,
          questionContent: q.questionContent,
          orderIndex: q.orderIndex,
          options: q.options.map(o => ({
            id: o.id,
            content: o.content,
            isCorrect: o.isCorrect,
            orderIndex: o.orderIndex
          }))
        }))
      };

      if (exists) {
        // Update quiz details
        await api.put(`/lessons/${lessonIdNum}/quiz`, payload);
      } else {
        // Create new quiz
        await api.post(`/lessons/${lessonIdNum}/quiz`, payload);
      }

      alert('Quiz saved successfully!');
      navigate('/admin/dashboard');
    } catch (error: any) {
      console.error('Failed to save quiz:', error);
      alert(getErrorMessage(error, 'An error occurred while saving the quiz.'));
    } finally {
      setSubmitting(false);
    }
  };

  // Delete Quiz completely
  const handleDeleteQuiz = async () => {
    if (!exists) return;
    if (window.confirm('Are you sure you want to delete this quiz from the lesson?')) {
      setSubmitting(true);
      try {
        await api.delete(`/lessons/${lessonIdNum}/quiz`);
        alert('Quiz deleted successfully!');
        navigate('/admin/dashboard');
      } catch (err: any) {
        console.error('Failed to delete quiz:', err);
        alert(getErrorMessage(err, 'An error occurred while deleting the quiz.'));
      } finally {
        setSubmitting(false);
      }
    }
  };

  if (loading) {
    return (
      <div className="flex h-[80vh] items-center justify-center bg-slate-50 dark:bg-slate-950">
        <div className="flex flex-col items-center space-y-3">
          <RefreshCw className="h-10 w-10 animate-spin text-indigo-600 dark:text-indigo-400" />
          <span className="text-sm font-semibold text-slate-500 dark:text-slate-400">Loading quiz configurations...</span>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-4xl px-4 py-8 sm:px-6 lg:px-8 text-left min-h-screen">
      
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
        <div className="flex items-center space-x-3.5">
          <button
            onClick={() => navigate('/admin/dashboard')}
            className="p-2 border border-slate-200 dark:border-slate-800 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800 bg-white dark:bg-slate-900 text-slate-500 transition-colors shadow-sm"
          >
            <ArrowLeft className="h-4.5 w-4.5" />
          </button>
          <div>
            <h1 className="text-xl md:text-2xl font-black text-slate-950 dark:text-white tracking-tight">
              Quiz Manager
            </h1>
            <p className="text-xs text-slate-500 dark:text-slate-400 font-semibold mt-0.5">
              Configure quiz questions and options to test lesson knowledge.
            </p>
          </div>
        </div>

        {/* Delete button if quiz exists */}
        {exists && (
          <button
            onClick={handleDeleteQuiz}
            disabled={submitting}
            className="px-4 py-2 bg-rose-50 border border-rose-200 dark:border-rose-950/20 text-rose-600 dark:text-rose-400 hover:bg-rose-100/50 dark:hover:bg-rose-950/10 rounded-xl text-xs font-bold transition-all"
          >
            Delete Quiz
          </button>
        )}
      </div>

      {/* Main Builder Form */}
      <div className="space-y-6">
        
        {/* Quiz Metadata Box */}
        <div className="bg-white dark:bg-slate-900 rounded-3xl border border-slate-202/60 dark:border-slate-800 p-6 shadow-sm space-y-4">
          <h3 className="text-xs font-extrabold text-indigo-600 dark:text-indigo-400 uppercase tracking-wider flex items-center space-x-1.5">
            <Sparkles className="h-4.5 w-4.5" />
            <span>Quiz Details</span>
          </h3>

          <div className="space-y-4">
            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Quiz Title (Required):
              </label>
              <input
                type="text"
                required
                placeholder="Enter title..."
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
              />
            </div>

            <div className="space-y-1.5">
              <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                Guide Description:
              </label>
              <textarea
                rows={2}
                placeholder="Enter short description for the quiz..."
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
              />
            </div>
          </div>
        </div>

        {/* Questions List */}
        <div className="space-y-6">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-extrabold text-slate-900 dark:text-white uppercase tracking-wider">
              Questions List ({questions.length})
            </h3>
            <button
              onClick={handleAddQuestion}
              className="inline-flex items-center space-x-1 px-3 py-1.5 bg-indigo-50 hover:bg-indigo-100 dark:bg-indigo-950/30 dark:hover:bg-indigo-950/50 text-indigo-600 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-900/20 rounded-xl text-xs font-bold transition-all active:scale-95"
            >
              <Plus className="h-4 w-4" />
              <span>Add New Question</span>
            </button>
          </div>

          {questions.map((q, qIdx) => (
            <div
              key={qIdx}
              className="bg-white dark:bg-slate-900 rounded-3xl border border-slate-300 dark:border-slate-800 p-6 shadow-sm space-y-5 relative"
            >
              {/* Question Index header */}
              <div className="flex items-center justify-between">
                <span className="text-xs font-extrabold text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-950/40 px-3 py-1 rounded-xl">
                  Question {qIdx + 1}
                </span>
                
                <button
                  type="button"
                  onClick={() => handleDeleteQuestion(qIdx)}
                  className="p-2 text-slate-400 hover:text-red-500 dark:hover:text-red-400 rounded-lg hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                  title="Delete this question"
                >
                  <Trash2 className="h-4 w-4" />
                </button>
              </div>

              {/* Question Content Input */}
              <div className="space-y-1.5">
                <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                  Question Content:
                </label>
                <input
                  type="text"
                  required
                  placeholder="Enter quiz question content..."
                  value={q.questionContent}
                  onChange={(e) => handleQuestionContentChange(qIdx, e.target.value)}
                  className="w-full px-4 py-2.5 rounded-xl border border-slate-202 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all dark:text-white font-semibold"
                />
              </div>

              {/* Options list for question */}
              <div className="space-y-3 pt-2">
                <div className="flex items-center justify-between">
                  <label className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
                    Options:
                  </label>
                  <button
                    type="button"
                    onClick={() => handleAddOption(qIdx)}
                    className="inline-flex items-center space-x-0.5 text-xs text-indigo-600 hover:text-indigo-700 dark:text-indigo-400 dark:hover:text-indigo-305 font-bold"
                  >
                    <Plus className="h-3.5 w-3.5" />
                    <span>Add Option</span>
                  </button>
                </div>

                <div className="space-y-2.5">
                  {q.options.map((opt, oIdx) => (
                    <div key={oIdx} className="flex items-center space-x-3 bg-slate-50/40 dark:bg-slate-950/15 p-2 rounded-2xl border border-slate-200 dark:border-slate-800/50">
                      
                      {/* Checkbox selector for Correct answer */}
                      <div className="shrink-0 flex items-center justify-center pl-2">
                        <input
                          type="radio"
                          name={`q-${qIdx}-correct`}
                          checked={opt.isCorrect}
                          onChange={() => handleOptionCorrectToggle(qIdx, oIdx)}
                          className="h-4.5 w-4.5 text-indigo-600 focus:ring-indigo-500 border-slate-300 dark:border-slate-800 dark:bg-slate-950"
                          title="Mark correct answer"
                        />
                      </div>

                      {/* Content input */}
                      <input
                        type="text"
                        required
                        placeholder={`Option #${oIdx + 1}`}
                        value={opt.content}
                        onChange={(e) => handleOptionContentChange(qIdx, oIdx, e.target.value)}
                        className={`flex-grow px-3 py-1.5 text-xs rounded-xl border bg-white dark:bg-slate-900 transition-all dark:text-white font-semibold ${
                          opt.isCorrect 
                            ? 'border-emerald-500 focus:ring-emerald-500/20' 
                            : 'border-slate-200 dark:border-slate-800 focus:ring-indigo-500/20 focus:border-indigo-500'
                        }`}
                      />

                      {/* Option Action */}
                      <button
                        type="button"
                        onClick={() => handleDeleteOption(qIdx, oIdx)}
                        className="p-1.5 text-slate-400 hover:text-red-500 rounded-lg transition-colors shrink-0"
                        title="Delete this option"
                      >
                        <Trash2 className="h-3.5 w-3.5" />
                      </button>

                    </div>
                  ))}
                </div>
              </div>

            </div>
          ))}
        </div>

        {/* Global form buttons */}
        <div className="flex justify-end space-x-3 pt-6 border-t border-slate-300 dark:border-slate-800 mt-8">
          <button
            onClick={() => navigate('/admin/dashboard')}
            disabled={submitting}
            className="px-5 py-2.5 border border-slate-200 dark:border-slate-800 rounded-xl text-xs font-bold text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
          >
            Cancel
          </button>
          <button
            onClick={handleSaveQuiz}
            disabled={submitting}
            className="px-6 py-2.5 bg-indigo-600 hover:bg-indigo-700 disabled:opacity-50 text-white rounded-xl text-xs font-bold shadow-md shadow-indigo-600/15 hover:shadow-indigo-600/25 transition-all flex items-center space-x-1.5 active:scale-95"
          >
            {submitting ? (
              <Loader2 className="h-4 w-4 animate-spin" />
            ) : (
              <Check className="h-4 w-4" />
            )}
            <span>Save Quiz</span>
          </button>
        </div>

      </div>

    </div>
  );
};

export default QuizManager;
