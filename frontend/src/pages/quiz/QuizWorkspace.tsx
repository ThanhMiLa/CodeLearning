import React, { useState, useMemo, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { QUIZZES } from '../../data/quizzesData';
import type { QuizQuestion } from '../../data/quizzesData';
import { 
  ArrowLeft, 
  CheckCircle2, 
  XCircle, 
  AlertCircle, 
  RotateCcw, 
  ChevronLeft, 
  ChevronRight, 
  Sparkles, 
  BookOpen,
  Check,
  X
} from 'lucide-react';


// Subject code mapping
const SUBJECT_CODES: Record<string, string> = {
  'hsf302': 'HSF302',
  'swr302': 'SWR302',
  'swt301': 'SWT301',
};

const SUBJECT_TITLES: Record<string, string> = {
  'hsf302': 'HSF302 - All Questions (Shuffled)',
  'swr302': 'SWR302 - All Questions (Shuffled)',
  'swt301': 'SWT301 - All Questions (Shuffled)',
};

const QuizWorkspaceContent: React.FC = () => {
  const { quizId } = useParams<{ quizId: string }>();
  const navigate = useNavigate();
  const { t } = useTranslation();

  // Check if quizId is a subject code (merged mode) or a specific quiz set
  const isSubjectMode = quizId ? quizId.toLowerCase() in SUBJECT_CODES : false;
  const isExamMode = quizId === 'swr302-random-exam' || quizId === 'hsf302-random-exam';

  // Build the merged & shuffled question list (or single quiz set / random exam)
  const { questions: activeQuestions, title: activeTitle } = useMemo(() => {
    if (!quizId) return { questions: [] as QuizQuestion[], title: '' };

    if (quizId === 'hsf302-random-exam') {
      let examQuestions: QuizQuestion[] = [];
      try {
        const saved = localStorage.getItem('hsf302_random_exam_questions');
        if (saved) {
          examQuestions = JSON.parse(saved);
        }
      } catch (e) {}

      if (!examQuestions || examQuestions.length === 0) {
        const targetCounts: Record<number, number> = {
          1: 24, // Java Spring Boot
          2: 8,  // Thymeleaf
          3: 18, // JavaFX
        };

        const sampled: QuizQuestion[] = [];
        Object.entries(targetCounts).forEach(([modNum, count]) => {
          const qSet = QUIZZES.find(q => q.id.includes(`hsf302-module-${modNum}`));
          if (qSet && qSet.questions.length > 0) {
            const shuffled = [...qSet.questions].sort(() => 0.5 - Math.random());
            sampled.push(...shuffled.slice(0, count));
          }
        });

        examQuestions = sampled.sort(() => 0.5 - Math.random());
        try {
          localStorage.setItem('hsf302_random_exam_questions', JSON.stringify(examQuestions));
        } catch (e) {}
      }

      return {
        questions: examQuestions,
        title: 'HSF302 - 50-Question Mock Exam (Real Exam Simulation)',
      };
    }

    if (quizId === 'swr302-random-exam') {
      let examQuestions: QuizQuestion[] = [];
      try {
        const saved = localStorage.getItem('swr302_random_exam_questions');
        if (saved) {
          examQuestions = JSON.parse(saved);
        }
      } catch (e) {}

      if (!examQuestions || examQuestions.length === 0) {
        const targetCounts: Record<number, number> = {
          1: 11,
          2: 10,
          3: 7,
          4: 7,
          5: 10,
          6: 6,
          7: 9,
        };

        const sampled: QuizQuestion[] = [];
        Object.entries(targetCounts).forEach(([modNum, count]) => {
          const qSet = QUIZZES.find(q => q.id.includes(`swr302-module-${modNum}`));
          if (qSet && qSet.questions.length > 0) {
            const shuffled = [...qSet.questions].sort(() => 0.5 - Math.random());
            sampled.push(...shuffled.slice(0, count));
          }
        });

        examQuestions = sampled.sort(() => 0.5 - Math.random());
        try {
          localStorage.setItem('swr302_random_exam_questions', JSON.stringify(examQuestions));
        } catch (e) {}
      }

      return {
        questions: examQuestions,
        title: 'SWR302 - 60-Question Mock Exam (Real Exam Simulation)',
      };
    }

    if (isSubjectMode) {
      const subjectKey = SUBJECT_CODES[quizId.toLowerCase()];
      // Merge all questions from all quiz sets of this subject
      const allQuestions = QUIZZES
        .filter(q => q.title.toUpperCase().includes(subjectKey))
        .flatMap(q => q.questions);
      // Shuffle them
      return {
        questions: allQuestions,
        title: SUBJECT_TITLES[quizId.toLowerCase()] || quizId.toUpperCase(),
      };
    } else {
      const targetId = quizId ? decodeURIComponent(quizId).toLowerCase().replace(/&/g, 'and') : '';
      const quiz = QUIZZES.find(q => {
        const qIdNorm = q.id.toLowerCase().replace(/&/g, 'and');
        return qIdNorm === targetId ||
               qIdNorm.replace(/-/g, '') === targetId.replace(/-/g, '') ||
               q.id === quizId;
      });
      return {
        questions: quiz ? quiz.questions : [],
        title: quiz ? quiz.title : '',
      };
    }
  }, [quizId, isSubjectMode]);

  if (activeQuestions.length === 0) {
    return (
      <div className="min-h-screen bg-slate-50 dark:bg-slate-950 flex items-center justify-center p-4">
        <div className="max-w-md w-full text-center bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-3xl p-8 shadow-lg">
          <AlertCircle className="h-16 w-16 text-rose-500 mx-auto mb-4" />
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-2">Quiz Not Found</h2>
          <p className="text-slate-500 dark:text-slate-400 mb-6">The quiz paper you are looking for does not exist or has been removed.</p>
          <Link to="/quiz" className="inline-flex items-center justify-center rounded-2xl bg-indigo-600 px-6 py-3 font-bold text-white hover:bg-indigo-700 transition-colors">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Go to Quiz Hub
          </Link>
        </div>
      </div>
    );
  }

  const totalQuestions = activeQuestions.length;
  const localStorageKey = `quiz_progress_${quizId?.toLowerCase() || ''}`;

  // Exam mode submission state
  const [isExamSubmitted, setIsExamSubmitted] = useState<boolean>(() => {
    if (!isExamMode) return false;
    try {
      const saved = localStorage.getItem(localStorageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        return !!parsed.isExamSubmitted;
      }
    } catch (e) {}
    return false;
  });

  // Local state with safe bound check against activeQuestions.length
  const [currentQuestionIdx, setCurrentQuestionIdx] = useState<number>(() => {
    try {
      const saved = localStorage.getItem(localStorageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        if (typeof parsed.currentQuestionIdx === 'number' && parsed.currentQuestionIdx < activeQuestions.length) {
          return Math.max(0, parsed.currentQuestionIdx);
        }
      }
    } catch (e) {
      console.error('Failed to load currentQuestionIdx', e);
    }
    return 0;
  });

  const [selectedOptions, setSelectedOptions] = useState<Record<number, string[]>>(() => {
    try {
      const saved = localStorage.getItem(localStorageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        if (parsed.selectedOptions) {
          return parsed.selectedOptions;
        }
      }
    } catch (e) {
      console.error('Failed to load selectedOptions', e);
    }
    return {};
  });

  const [submittedQuestions, setSubmittedQuestions] = useState<Record<number, boolean>>(() => {
    try {
      const saved = localStorage.getItem(localStorageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        if (parsed.submittedQuestions) {
          return parsed.submittedQuestions;
        }
      }
    } catch (e) {
      console.error('Failed to load submittedQuestions', e);
    }
    return {};
  });

  const [questionResults, setQuestionResults] = useState<Record<number, boolean>>(() => {
    try {
      const saved = localStorage.getItem(localStorageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        if (parsed.questionResults) {
          return parsed.questionResults;
        }
      }
    } catch (e) {
      console.error('Failed to load questionResults', e);
    }
    return {};
  });

  // Save progress to localStorage whenever state changes
  useEffect(() => {
    if (!quizId) return;
    const progress = {
      currentQuestionIdx,
      selectedOptions,
      submittedQuestions,
      questionResults,
      isExamSubmitted,
    };
    localStorage.setItem(localStorageKey, JSON.stringify(progress));
  }, [localStorageKey, quizId, currentQuestionIdx, selectedOptions, submittedQuestions, questionResults, isExamSubmitted]);

  const safeIdx = Math.min(Math.max(0, currentQuestionIdx), Math.max(0, activeQuestions.length - 1));
  const currentQuestion = activeQuestions[safeIdx];
  const userAnswers = selectedOptions[safeIdx] || [];
  const isSubmitted = isExamMode ? isExamSubmitted : (submittedQuestions[safeIdx] || false);

  // Parse correct answers
  const correctAnswers = useMemo(() => {
    if (!currentQuestion) return [];
    return currentQuestion.correct_anwser.split(',').map(s => s.trim()).filter(Boolean);
  }, [currentQuestion]);

  const isMultipleChoice = useMemo(() => {
    if (!currentQuestion) return false;
    return currentQuestion.correct_anwser.includes(',');
  }, [currentQuestion]);

  const correctCount = useMemo(() => {
    return Object.keys(submittedQuestions).filter(
      key => submittedQuestions[Number(key)] && questionResults[Number(key)]
    ).length;
  }, [submittedQuestions, questionResults]);

  const incorrectCount = useMemo(() => {
    return Object.keys(submittedQuestions).filter(
      key => submittedQuestions[Number(key)] && !questionResults[Number(key)]
    ).length;
  }, [submittedQuestions, questionResults]);

  const handleOptionClick = (optionKey: string) => {
    if (isSubmitted) return;

    if (isMultipleChoice) {
      if (userAnswers.includes(optionKey)) {
        setSelectedOptions({
          ...selectedOptions,
          [currentQuestionIdx]: userAnswers.filter(key => key !== optionKey)
        });
      } else {
        setSelectedOptions({
          ...selectedOptions,
          [currentQuestionIdx]: [...userAnswers, optionKey]
        });
      }
    } else {
      setSelectedOptions({
        ...selectedOptions,
        [currentQuestionIdx]: [optionKey]
      });
    }
  };

  const handleSubmit = () => {
    if (userAnswers.length === 0 || isSubmitted) return;

    // Check answers
    const isCorrect = correctAnswers.length === userAnswers.length &&
      correctAnswers.every(opt => userAnswers.includes(opt));

    setSubmittedQuestions({
      ...submittedQuestions,
      [currentQuestionIdx]: true
    });

    setQuestionResults({
      ...questionResults,
      [currentQuestionIdx]: isCorrect
    });
  };

  const handleFinalExamSubmit = () => {
    const answeredCount = Object.keys(selectedOptions).filter(k => (selectedOptions[Number(k)] || []).length > 0).length;
    const unAnswered = totalQuestions - answeredCount;

    const msg = unAnswered > 0
      ? `You have answered ${answeredCount}/${totalQuestions} questions (${unAnswered} unanswered). Are you sure you want to submit your exam?`
      : `Are you sure you want to submit your ${totalQuestions}-question exam now for final evaluation?`;

    if (window.confirm(msg)) {
      const newSubmitted: Record<number, boolean> = {};
      const newResults: Record<number, boolean> = {};

      activeQuestions.forEach((q, idx) => {
        const uAnswers = selectedOptions[idx] || [];
        const cAnswers = q.correct_anwser.split(',').map(s => s.trim()).filter(Boolean);
        const isCorrect = cAnswers.length === uAnswers.length && cAnswers.every(opt => uAnswers.includes(opt));

        newSubmitted[idx] = true;
        newResults[idx] = isCorrect;
      });

      setSubmittedQuestions(newSubmitted);
      setQuestionResults(newResults);
      setIsExamSubmitted(true);
    }
  };

  const handleRetakeRandomExam = () => {
    if (window.confirm(`Generate a new random ${totalQuestions}-question mock exam? Current progress will be reset.`)) {
      if (quizId === 'hsf302-random-exam') {
        localStorage.removeItem('hsf302_random_exam_questions');
      } else {
        localStorage.removeItem('swr302_random_exam_questions');
      }
      localStorage.removeItem(localStorageKey);
      setSelectedOptions({});
      setSubmittedQuestions({});
      setQuestionResults({});
      setIsExamSubmitted(false);
      setCurrentQuestionIdx(0);
      window.location.reload();
    }
  };

  const handleRetryCurrentQuestion = () => {
    const newSelected = { ...selectedOptions };
    delete newSelected[currentQuestionIdx];

    const newSubmitted = { ...submittedQuestions };
    delete newSubmitted[currentQuestionIdx];

    const newResults = { ...questionResults };
    delete newResults[currentQuestionIdx];

    setSelectedOptions(newSelected);
    setSubmittedQuestions(newSubmitted);
    setQuestionResults(newResults);
  };

  const handleResetQuiz = () => {
    if (window.confirm(t('quiz.reset_confirm_message', 'Are you sure you want to reset this quiz? All your answers will be cleared.'))) {
      setSelectedOptions({});
      setSubmittedQuestions({});
      setQuestionResults({});
      setCurrentQuestionIdx(0);
      localStorage.removeItem(localStorageKey);
    }
  };

  const optionsList = useMemo(() => {
    const list = [
      { key: 'A', text: currentQuestion.option_A },
      { key: 'B', text: currentQuestion.option_B }
    ];
    if (currentQuestion.option_C) {
      list.push({ key: 'C', text: currentQuestion.option_C });
    }
    if (currentQuestion.option_D) {
      list.push({ key: 'D', text: currentQuestion.option_D });
    }
    // Cast currentQuestion to any to access dynamic option keys without TS compilation issues
    const q = currentQuestion as any;
    if (q.option_E) {
      list.push({ key: 'E', text: q.option_E });
    }
    if (q.option_F) {
      list.push({ key: 'F', text: q.option_F });
    }
    return list;
  }, [currentQuestion]);

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-slate-950 py-8 px-4 sm:px-6 lg:px-8 transition-colors duration-200">
      <style>{`
        @media (min-width: 1024px) {
          .quiz-split-container {
            display: grid !important;
            grid-template-columns: 7fr 3fr !important;
            gap: 2rem !important;
            align-items: start !important;
          }
          .quiz-left-panel {
            grid-column: span 1 / span 1 !important;
            width: 100% !important;
          }
          .quiz-right-panel {
            grid-column: span 1 / span 1 !important;
            width: 100% !important;
          }
          .quiz-scroll-container {
            max-height: 564px !important;
            overflow-y: auto !important;
          }
        }
        .quiz-matrix-grid {
          display: grid !important;
          grid-template-columns: repeat(5, minmax(0, 1fr)) !important;
          gap: 0.625rem !important;
        }
      `}</style>
      <div className="mx-auto max-w-[1400px] w-full">
        {/* Workspace Top Header */}
        <div className="flex flex-col md:flex-row md:items-center md:justify-between border-b border-slate-200 dark:border-slate-800/80 pb-6 mb-8 gap-4">
          <div className="flex items-center space-x-4">
            <button
              onClick={() => {
                if (quizId && quizId.toLowerCase().includes('swr302')) {
                  navigate('/quiz/swr302');
                } else if (quizId && quizId.toLowerCase().includes('hsf302')) {
                  navigate('/quiz/hsf302');
                } else {
                  navigate('/quiz');
                }
              }}
              className="inline-flex items-center justify-center h-10 w-10 rounded-full border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 text-slate-500 hover:text-indigo-600 dark:hover:text-indigo-400 hover:border-indigo-500/20 shadow-sm active:scale-95 transition-all"
              title={t('quiz.back_to_catalog', 'Back to Hub')}
            >
              <ArrowLeft className="h-5 w-5" />
            </button>
            <div>
              <span className="text-[10px] font-extrabold uppercase tracking-widest text-indigo-600 dark:text-indigo-400 block mb-0.5">
                Quiz Workspace
              </span>
              <h1 className="text-xl sm:text-2xl font-bold text-slate-900 dark:text-white">
                {activeTitle}
              </h1>
            </div>
          </div>

          <div className="flex items-center space-x-3 self-end md:self-auto">
            <button
              onClick={handleResetQuiz}
              className="inline-flex items-center justify-center rounded-2xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 px-4 py-2 text-xs font-bold text-slate-600 dark:text-slate-300 hover:text-rose-500 dark:hover:text-rose-400 hover:border-rose-500/20 shadow-sm transition-all active:scale-98"
            >
              <RotateCcw className="h-3.5 w-3.5 mr-2" />
              <span>{t('quiz.reset_quiz', 'Reset Quiz')}</span>
            </button>
          </div>
        </div>

        {/* Exam Score Banner if Exam Mode is Finished */}
        {isExamMode && isExamSubmitted && (
          <div className="mb-8 rounded-3xl border-2 border-emerald-500/40 bg-gradient-to-r from-slate-900 via-emerald-950/60 to-slate-900 p-6 sm:p-8 text-white shadow-xl flex flex-col md:flex-row items-center justify-between gap-6">
            <div>
              <div className="flex items-center gap-2 mb-2">
                <span className={`text-xs font-black uppercase px-3 py-1 rounded-full ${
                  (correctCount / totalQuestions) >= 0.7 ? 'bg-emerald-500/20 text-emerald-400 border border-emerald-500/30' : 'bg-rose-500/20 text-rose-400 border border-rose-500/30'
                }`}>
                  {(correctCount / totalQuestions) >= 0.7 ? 'PASSED (ĐẠT)' : 'FAILED (CHƯA ĐẠT)'}
                </span>
                <span className="text-slate-400 text-xs font-semibold">Real Exam Simulation (60 Questions)</span>
              </div>
              <h3 className="text-2xl font-black text-white mb-1">
                Final Exam Score: {correctCount} / {totalQuestions} ({Math.round((correctCount / totalQuestions) * 100)}%)
              </h3>
              <p className="text-slate-300 text-xs">
                Answers and detailed explanations are unlocked below. You can review each question or generate a new test.
              </p>
            </div>

            <button
              onClick={handleRetakeRandomExam}
              className="inline-flex items-center justify-center gap-2 bg-gradient-to-r from-emerald-500 to-teal-500 hover:from-emerald-600 hover:to-teal-600 text-white font-extrabold px-6 py-3 rounded-2xl shadow-md transition-all shrink-0 text-sm active:scale-95"
            >
              <RotateCcw className="h-4 w-4" />
              <span>Generate New 60-Question Exam</span>
            </button>
          </div>
        )}

        {/* Workspace Grid Layout */}
        <div className="grid grid-cols-1 lg:grid-cols-10 gap-8 items-start quiz-split-container">
          {/* Main workspace (Question Area) */}
          <div className="lg:col-span-7 flex flex-col gap-6 quiz-left-panel">
            
            {/* Question Card */}
            <div className="rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-6 sm:p-8 shadow-sm relative overflow-hidden">
              {/* Type Badge */}
              <div className="flex items-center justify-between border-b border-slate-100 dark:border-slate-800/80 pb-4 mb-6">
                <span className="text-xs font-bold text-slate-400 dark:text-slate-500 uppercase tracking-wider">
                  Question {currentQuestionIdx + 1} of {totalQuestions}
                </span>
                
                <span className="inline-flex items-center px-2.5 py-1 rounded-md text-[10px] font-bold uppercase tracking-wider bg-indigo-500/10 text-indigo-600 dark:text-indigo-400">
                  {isMultipleChoice ? 'Multiple Choice' : 'Single Choice'}
                </span>
              </div>

              {/* Title */}
              <h3 className="text-lg sm:text-xl font-bold text-slate-900 dark:text-white leading-snug mb-8 whitespace-pre-line">
                {currentQuestion.question_title ? currentQuestion.question_title.replace(/[ \t]+(i|ii|iii|iv|v|vi|vii|viii|ix|x|[1-9])\)/g, '\n$1)') : ''}
              </h3>

              {/* Option Mode Instruction Hint */}
              <p className="text-xs font-bold text-slate-400 dark:text-slate-500 mb-4 uppercase tracking-wider">
                {isMultipleChoice 
                  ? t('quiz.multi_choice_hint', 'Select all correct options (Multiple Choice):') 
                  : t('quiz.single_choice_hint', 'Select the single best answer:')
                }
              </p>

              {/* Options */}
              <div className="flex flex-col gap-4 mb-8">
                {optionsList.map((opt) => {
                  const isOptSelected = userAnswers.includes(opt.key);
                  const isOptCorrect = correctAnswers.includes(opt.key);

                  // Set background/border styles based on states
                  let cardStyle = "border-slate-200 dark:border-slate-800 hover:border-indigo-500/30 dark:hover:border-indigo-500/20 bg-slate-50/50 dark:bg-slate-900/50 hover:bg-slate-50 dark:hover:bg-slate-800/40 text-slate-700 dark:text-slate-300";
                  
                  if (!isSubmitted) {
                    if (isOptSelected) {
                      cardStyle = "border-indigo-500 bg-indigo-50/40 dark:bg-indigo-950/20 text-indigo-900 dark:text-indigo-200 ring-2 ring-indigo-500/20";
                    }
                  } else {
                    // After submission logic
                    if (isOptCorrect) {
                      // Correct option style (Green border and background)
                      cardStyle = "border-emerald-500 bg-emerald-500/10 dark:bg-emerald-950/20 text-emerald-900 dark:text-emerald-300 font-medium ring-2 ring-emerald-500/20";
                    } else if (isOptSelected && !isOptCorrect) {
                      // User selected incorrect option (Red border and background)
                      cardStyle = "border-rose-500 bg-rose-500/10 dark:bg-rose-950/20 text-rose-900 dark:text-rose-300 ring-2 ring-rose-500/20";
                    } else {
                      // Normal non-selected incorrect options after submit (muted)
                      cardStyle = "border-slate-200/60 dark:border-slate-800/60 bg-slate-50/20 dark:bg-slate-900/20 text-slate-400 dark:text-slate-500 cursor-not-allowed";
                    }
                  }

                  return (
                    <button
                      key={opt.key}
                      onClick={() => handleOptionClick(opt.key)}
                      disabled={isSubmitted}
                      className={`flex items-start p-4.5 rounded-2xl border text-left text-sm transition-all duration-150 ${cardStyle} ${!isSubmitted ? 'cursor-pointer active:scale-[0.995]' : ''}`}
                    >
                      {/* Badge Letter A, B, C, D */}
                      <span 
                        className={`inline-flex items-center justify-center h-7 w-7 rounded-xl text-xs font-bold shrink-0 mr-6 border uppercase ${
                          isSubmitted && isOptCorrect
                            ? 'bg-emerald-500 border-emerald-500 text-white'
                            : isSubmitted && isOptSelected && !isOptCorrect
                              ? 'bg-rose-500 border-rose-500 text-white'
                              : isOptSelected
                                ? 'bg-indigo-600 border-indigo-600 text-white'
                                : 'bg-white dark:bg-slate-850 border-slate-200 dark:border-slate-800 text-slate-500 dark:text-slate-400'
                        }`}
                        style={{ marginRight: '1.25rem' }}
                      >
                        {opt.key}
                      </span>
                      
                      <span className="flex-grow pt-0.5 leading-relaxed">
                        {opt.text}
                      </span>

                      {/* Icons for check/cross */}
                      {isSubmitted && (
                        <span className="shrink-0 ml-3">
                          {isOptCorrect ? (
                            <CheckCircle2 className="h-5 w-5 text-emerald-500" />
                          ) : isOptSelected && !isOptCorrect ? (
                            <XCircle className="h-5 w-5 text-rose-500" />
                          ) : null}
                        </span>
                      )}
                    </button>
                  );
                })}
              </div>

              {/* Action and Navigation Section */}
              <div className="flex flex-col sm:flex-row items-center sm:justify-between border-t border-slate-100 dark:border-slate-800/80 pt-6 gap-4">
                <div className="flex items-center space-x-3 w-full sm:w-auto">
                  <button
                    onClick={() => setCurrentQuestionIdx(prev => Math.max(0, prev - 1))}
                    disabled={currentQuestionIdx === 0}
                    className="flex-grow sm:flex-grow-0 inline-flex items-center justify-center rounded-2xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 px-4 py-3 text-sm font-semibold text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-850 hover:border-slate-300 dark:hover:border-slate-700 disabled:opacity-40 disabled:cursor-not-allowed transition-all active:scale-97"
                  >
                    <ChevronLeft className="h-4.5 w-4.5 mr-1" />
                    <span>{t('quiz.prev_question', 'Prev')}</span>
                  </button>

                  <button
                    onClick={() => setCurrentQuestionIdx(prev => Math.min(totalQuestions - 1, prev + 1))}
                    disabled={currentQuestionIdx === totalQuestions - 1}
                    className="flex-grow sm:flex-grow-0 inline-flex items-center justify-center rounded-2xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 px-4 py-3 text-sm font-semibold text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-850 hover:border-slate-300 dark:hover:border-slate-700 disabled:opacity-40 disabled:cursor-not-allowed transition-all active:scale-97"
                  >
                    <span>{t('quiz.next_question', 'Next')}</span>
                    <ChevronRight className="h-4.5 w-4.5 ml-1" />
                  </button>
                </div>

                {!isSubmitted ? (
                  isExamMode ? (
                    <button
                      onClick={handleFinalExamSubmit}
                      className="w-full sm:w-auto inline-flex items-center justify-center rounded-2xl bg-gradient-to-r from-rose-600 to-pink-600 hover:from-rose-700 hover:to-pink-700 text-white font-extrabold text-sm py-3 px-6 shadow-md hover:shadow-rose-500/20 active:scale-97 transition-all"
                    >
                      <span>Submit Exam ({totalQuestions} Questions)</span>
                    </button>
                  ) : (
                    <button
                      onClick={handleSubmit}
                      disabled={userAnswers.length === 0}
                      className="w-full sm:w-auto inline-flex items-center justify-center rounded-2xl bg-indigo-600 hover:bg-indigo-700 disabled:bg-slate-200 dark:disabled:bg-slate-800 disabled:text-slate-400 dark:disabled:text-slate-600 text-white font-bold text-sm py-3 px-6 shadow-md hover:shadow-indigo-500/20 active:scale-97 transition-all"
                    >
                      <span>{t('quiz.submit_answer', 'Submit Answer')}</span>
                    </button>
                  )
                ) : (
                  <div className="flex items-center space-x-3 w-full sm:w-auto justify-center sm:justify-start">
                    {questionResults[currentQuestionIdx] ? (
                      <span className="inline-flex items-center px-4 py-2 rounded-2xl bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 font-bold text-sm">
                        <Check className="h-4.5 w-4.5 mr-1.5 stroke-[3]" />
                        {t('quiz.correct', 'Correct')}
                      </span>
                    ) : (
                      <span className="inline-flex items-center px-4 py-2 rounded-2xl bg-rose-500/10 text-rose-600 dark:text-rose-400 font-bold text-sm">
                        <X className="h-4.5 w-4.5 mr-1.5 stroke-[3]" />
                        {t('quiz.incorrect', 'Incorrect')}
                      </span>
                    )}

                    <button
                      onClick={handleRetryCurrentQuestion}
                      className="inline-flex items-center justify-center rounded-2xl border border-indigo-500/30 bg-indigo-500/10 hover:bg-indigo-500/20 text-indigo-600 dark:text-indigo-400 font-bold text-xs px-3.5 py-2.5 transition-all active:scale-95 shadow-sm"
                      title={t('quiz.retry_question', 'Retry Question')}
                    >
                      <RotateCcw className="h-3.5 w-3.5 mr-1.5" />
                      <span>{t('quiz.retry_question', 'Retry Question')}</span>
                    </button>
                  </div>
                )}
              </div>
            </div>

            {/* Explanation box (Only display if submitted) */}
            {isSubmitted && (
              <div className="rounded-3xl border border-emerald-500/20 bg-emerald-50/20 dark:bg-emerald-950/5 p-6 sm:p-8 shadow-sm animate-in fade-in slide-in-from-top-4 duration-300">
                <div className="flex items-center justify-between mb-4">
                  <div className="flex items-center space-x-3">
                    <div className="h-8 w-8 rounded-lg bg-emerald-500/10 dark:bg-emerald-500/20 flex items-center justify-center text-emerald-600 dark:text-emerald-400">
                      <Sparkles className="h-4.5 w-4.5" />
                    </div>
                    <h4 className="text-sm font-extrabold uppercase tracking-wider text-slate-800 dark:text-slate-200">
                      {t('quiz.explanation', 'Explanation')}
                    </h4>
                  </div>

                  <button
                    onClick={handleRetryCurrentQuestion}
                    className="inline-flex items-center space-x-1.5 text-xs font-extrabold text-indigo-600 dark:text-indigo-400 hover:text-indigo-700 dark:hover:text-indigo-300 bg-white dark:bg-slate-900 border border-indigo-500/20 px-3 py-1.5 rounded-xl shadow-sm hover:shadow-md transition-all active:scale-95"
                  >
                    <RotateCcw className="h-3.5 w-3.5" />
                    <span>{t('quiz.retry_question', 'Retry Question')}</span>
                  </button>
                </div>
                <p className="text-sm text-slate-600 dark:text-slate-350 leading-relaxed font-medium whitespace-pre-line">
                  {currentQuestion.explain}
                </p>
              </div>
            )}
          </div>

          {/* Sidebar Area (Stats and Question Grid) */}
          <div className="lg:col-span-3 flex flex-col gap-6 quiz-right-panel">

             {/* Question Grid Card */}
             <div className="rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-6 shadow-sm">
               <h3 className="text-base font-bold text-slate-900 dark:text-white mb-4 flex items-center justify-between">
                 <span className="flex items-center">
                   <BookOpen className="h-4.5 w-4.5 text-indigo-500 mr-2" />
                   <span>Question Sheet</span>
                 </span>
                 <span className="text-xs font-bold px-2.5 py-1 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-500 dark:text-slate-400">
                   {Object.keys(submittedQuestions).length}/{totalQuestions}
                 </span>
               </h3>

               {/* Correct & Incorrect Counts */}
               <div className="grid grid-cols-2 gap-3 mb-4">
                 <div className="bg-emerald-500/10 dark:bg-emerald-500/5 border border-emerald-500/10 rounded-2xl p-3 text-center">
                   <span className="text-[10px] font-bold uppercase tracking-wider text-emerald-600 dark:text-emerald-400 block mb-0.5">
                     {t('quiz.correct', 'Correct')}
                   </span>
                   <span className="text-lg font-extrabold text-emerald-600 dark:text-emerald-400">
                     {correctCount}
                   </span>
                 </div>
                 <div className="bg-rose-500/10 dark:bg-rose-500/5 border border-rose-500/10 rounded-2xl p-3 text-center">
                   <span className="text-[10px] font-bold uppercase tracking-wider text-rose-600 dark:text-rose-400 block mb-0.5">
                     {t('quiz.incorrect', 'Incorrect')}
                   </span>
                   <span className="text-lg font-extrabold text-rose-600 dark:text-rose-400">
                     {incorrectCount}
                   </span>
                 </div>
               </div>
 
               {/* Scrollable grid for large question sets */}
               <div className="max-h-[564px] lg:max-h-[564px] overflow-y-auto pr-1 quiz-scroll-container" style={{ scrollbarWidth: 'thin' }}>
                <div className="grid grid-cols-5 gap-2 quiz-matrix-grid">
                  {Array.from({ length: totalQuestions }).map((_, idx) => {
                    const hasSubmitted = submittedQuestions[idx];
                    const isCorrect = questionResults[idx];
                    const isCurrent = currentQuestionIdx === idx;

                    // Dynamic styles based on states
                    let buttonStyle = "border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 hover:bg-slate-50 dark:hover:bg-slate-850 hover:border-slate-300 dark:hover:border-slate-700 text-slate-600 dark:text-slate-400";
                    
                    if (hasSubmitted) {
                      if (isCorrect) {
                        buttonStyle = "bg-emerald-500 border-emerald-500 text-white hover:bg-emerald-600";
                      } else {
                        buttonStyle = "bg-rose-500 border-rose-500 text-white hover:bg-rose-600";
                      }
                    } else {
                      const isSelected = (selectedOptions[idx] || []).length > 0;
                      if (isSelected) {
                        // Option selected but not submitted yet
                        buttonStyle = "border-indigo-400 bg-indigo-50/20 text-indigo-600 dark:text-indigo-400";
                      }
                    }

                    // Active highlight
                    const currentStyle = isCurrent 
                      ? "ring-2 ring-indigo-600 dark:ring-indigo-400 ring-offset-2 dark:ring-offset-slate-950 scale-105 z-10 font-bold" 
                      : "";

                    return (
                      <button
                        key={idx}
                        onClick={() => setCurrentQuestionIdx(idx)}
                        className={`inline-flex items-center justify-center h-9 w-full rounded-xl border text-xs font-semibold select-none cursor-pointer transition-all duration-150 ${buttonStyle} ${currentStyle}`}
                      >
                        {idx + 1}
                      </button>
                    );
                  })}
                </div>
              </div>
            </div>

          </div>
        </div>

      </div>
    </div>
  );
};

const QuizWorkspace: React.FC = () => {
  const { quizId } = useParams<{ quizId: string }>();
  return <QuizWorkspaceContent key={quizId} />;
};

export default QuizWorkspace;
