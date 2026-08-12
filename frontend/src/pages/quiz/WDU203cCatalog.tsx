import React, { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { QUIZZES } from '../../data/quizzesData';
import {
  ArrowLeft,
  Layers,
  ChevronRight,
  HelpCircle,
  Award,
  CheckCircle2,
  CheckSquare,
  ToggleLeft,
  Flame,
  AlertCircle,
  Sparkles
} from 'lucide-react';

interface ModuleInfo {
  id: string;
  moduleNum: number;
  title: string;
  gradient: string;
  iconBg: string;
  badgeLabel: string;
  description: string;
  icon: React.ReactNode;
}

const MODULE_METADATA: Record<string, Partial<ModuleInfo>> = {
  'wdu203c-random-exam': {
    moduleNum: 0,
    badgeLabel: 'MOCK EXAM',
    title: 'Random 50-Question Mock Exam',
    gradient: 'from-rose-500 to-pink-500',
    iconBg: 'bg-rose-500/10 text-rose-600 dark:text-rose-400',
    icon: <Flame className="h-5 w-5" />,
  },
  'wdu203c-module-1-single-choice': {
    moduleNum: 1,
    badgeLabel: 'MODULE 1',
    title: 'Module 1 - Single Choice',
    gradient: 'from-emerald-500 to-teal-600',
    iconBg: 'bg-emerald-500/10 text-emerald-600 dark:text-emerald-400',
    icon: <CheckCircle2 className="h-5 w-5" />,
  },
  'wdu203c-module-2-multi-choice': {
    moduleNum: 2,
    badgeLabel: 'MODULE 2',
    title: 'Module 2 - Multiple Choice',
    gradient: 'from-amber-500 to-rose-600',
    iconBg: 'bg-amber-500/10 text-amber-600 dark:text-amber-400',
    icon: <CheckSquare className="h-5 w-5" />,
  },
  'wdu203c-module-3-true-false': {
    moduleNum: 3,
    badgeLabel: 'MODULE 3',
    title: 'Module 3 - True / False',
    gradient: 'from-blue-500 to-cyan-600',
    iconBg: 'bg-blue-500/10 text-blue-600 dark:text-blue-400',
    icon: <ToggleLeft className="h-5 w-5" />,
  },
};

const getModuleMeta = (id: string, fallbackTitle: string): Partial<ModuleInfo> => {
  if (MODULE_METADATA[id]) return MODULE_METADATA[id];
  return {
    title: fallbackTitle,
    gradient: 'from-slate-500 to-slate-700',
    iconBg: 'bg-slate-500/10 text-slate-600 dark:text-slate-400',
    icon: <Layers className="h-5 w-5" />
  };
};

const WDU203cCatalog: React.FC = () => {
  const wduQuizzes = useMemo(() => {
    const list: any[] = [];

    const exam = QUIZZES.find(q => q.id === 'wdu203c-random-exam');
    if (exam) list.push(exam);

    const m1 = QUIZZES.find(q => q.id === 'wdu203c-module-1-single-choice');
    if (m1) list.push(m1);

    const m2 = QUIZZES.find(q => q.id === 'wdu203c-module-2-multi-choice');
    if (m2) list.push(m2);

    const m3 = QUIZZES.find(q => q.id === 'wdu203c-module-3-true-false');
    if (m3) list.push(m3);

    return list;
  }, []);

  const getProgress = (quizId: string, totalCount: number) => {
    try {
      const saved = localStorage.getItem(`quiz_progress_${quizId.toLowerCase()}`);
      if (saved) {
        const parsed = JSON.parse(saved);
        const submitted = parsed.submittedQuestions || {};
        const results = parsed.questionResults || {};
        const answeredCount = Object.keys(submitted).length;
        const correctCount = Object.values(results).filter(Boolean).length;
        const percent = totalCount > 0 ? Math.round((answeredCount / totalCount) * 100) : 0;
        return { answeredCount, correctCount, percent };
      }
    } catch (e) { }
    return { answeredCount: 0, correctCount: 0, percent: 0 };
  };

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-slate-950 py-8 px-4 sm:px-6 lg:px-8 transition-colors duration-200">
      {/* Background glow effects */}
      <div className="absolute top-20 left-1/3 -translate-x-1/2 w-[500px] h-[300px] bg-sky-500/10 dark:bg-sky-500/5 rounded-full blur-[140px] pointer-events-none" />
      <div className="absolute top-40 right-1/4 translate-x-1/2 w-[400px] h-[250px] bg-indigo-500/10 dark:bg-indigo-500/5 rounded-full blur-[120px] pointer-events-none" />

      <div className="mx-auto max-w-[1100px] relative z-10">
        {/* Navigation Breadcrumb */}
        <div className="mb-6">
          <Link
            to="/quiz"
            className="inline-flex items-center text-sm font-semibold text-slate-500 dark:text-slate-400 hover:text-sky-600 dark:hover:text-sky-400 transition-colors"
          >
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Quiz Catalog
          </Link>
        </div>

        {/* Notice Banner for Updated Answers */}
        <div className="mb-6 max-w-4xl mx-auto rounded-2xl border border-amber-500/30 bg-gradient-to-r from-amber-500/10 via-amber-500/5 to-slate-900/40 p-4 dark:border-amber-500/20 dark:bg-amber-950/20 shadow-sm flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div className="flex items-start sm:items-center gap-3">
            <div className="h-9 w-9 rounded-xl bg-amber-500/20 text-amber-600 dark:text-amber-400 flex items-center justify-center shrink-0 border border-amber-500/30">
              <AlertCircle className="h-4.5 w-4.5" />
            </div>
            <div>
              <h4 className="text-xs font-extrabold uppercase tracking-wider text-amber-700 dark:text-amber-300 flex items-center gap-2">
                <span>Thông Báo Cập Nhật Đáp Án Môn WDU203c</span>
                <span className="px-2 py-0.5 rounded-full text-[10px] bg-amber-500/20 text-amber-800 dark:text-amber-200 border border-amber-500/30 font-bold">
                  Lưu ý
                </span>
              </h4>
                <div className="text-xs text-slate-700 dark:text-slate-300 font-medium mt-0.5 leading-relaxed">
                  <p>
                    Ở môn WDU203c, các câu hỏi <span className="font-extrabold text-amber-600 dark:text-amber-400 bg-amber-500/15 px-1.5 py-0.5 rounded border border-amber-500/30">17, 53, 95, 142, 149, 282, 312, 353</span> đã được cập nhật lại đáp án chuẩn mới nhất.
                  </p>
                  <p className="mt-1 font-semibold text-amber-700 dark:text-amber-300">
                    👉 Vui lòng <span className="underline decoration-amber-500 font-bold">Retry Question</span> để cập nhật lại đáp án mới nhất.
                  </p>
                </div>
            </div>
          </div>
          <div className="flex items-center gap-1.5 text-xs font-bold text-amber-700 dark:text-amber-300 shrink-0 self-end sm:self-auto bg-amber-500/15 border border-amber-500/30 px-3 py-1.5 rounded-xl">
            <Sparkles className="h-3.5 w-3.5 text-amber-500" />
            <span>8 câu đã đổi đáp án</span>
          </div>
        </div>

        {/* Cards Grid - 15% smaller layout */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5 max-w-4xl mx-auto">
          {wduQuizzes.map((quiz) => {
            const meta = getModuleMeta(quiz.id, quiz.title);
            const qCount = quiz.questions?.length || 0;
            const progress = getProgress(quiz.id, qCount);

            return (
              <Link
                key={quiz.id}
                to={`/quiz/${quiz.id}`}
                className="group relative rounded-2xl border border-slate-200 dark:border-slate-800/80 bg-white dark:bg-slate-900/90 p-6 shadow-sm hover:shadow-lg dark:shadow-none hover:border-sky-500/40 dark:hover:border-sky-500/40 hover:-translate-y-0.5 transition-all duration-300 text-left overflow-hidden flex flex-col justify-between"
              >
                {/* Top border highlight gradient */}
                <div className={`absolute top-0 left-0 right-0 h-1 bg-gradient-to-r ${meta.gradient} transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left`} />

                <div>
                  {/* Top Bar: Icon & Badge */}
                  <div className="flex items-center justify-between mb-4">
                    <div className={`w-11 h-11 rounded-xl ${meta.iconBg} flex items-center justify-center group-hover:scale-105 transition-transform duration-300`}>
                      {meta.icon}
                    </div>

                    <span className={`text-[11px] font-bold uppercase tracking-wider px-2.5 py-0.5 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300`}>
                      {meta.badgeLabel}
                    </span>
                  </div>

                  {/* Title Only */}
                  <h2 className="text-xl font-bold text-slate-900 dark:text-white mb-4 group-hover:text-sky-600 dark:group-hover:text-sky-400 transition-colors duration-200">
                    {meta.title || quiz.title}
                  </h2>
                </div>

                <div>
                  {/* Stats & Progress Bar */}
                  <div className="pt-3 border-t border-slate-100 dark:border-slate-800/80 mb-4">
                    <div className="flex items-center justify-between text-xs font-semibold text-slate-500 dark:text-slate-400 mb-1.5">
                      <span className="flex items-center gap-1.5">
                        <HelpCircle className="h-3.5 w-3.5 text-sky-500" />
                        {qCount} Questions
                      </span>

                      {progress.answeredCount > 0 ? (
                        <span className="flex items-center gap-1 text-emerald-600 dark:text-emerald-400">
                          <Award className="h-3.5 w-3.5" />
                          {progress.correctCount}/{progress.answeredCount} ({progress.percent}%)
                        </span>
                      ) : (
                        <span className="text-slate-400 dark:text-slate-500">Not started</span>
                      )}
                    </div>

                    <div className="w-full bg-slate-100 dark:bg-slate-800 h-1.5 rounded-full overflow-hidden">
                      <div
                        className={`h-full bg-gradient-to-r ${meta.gradient} transition-all duration-500 rounded-full`}
                        style={{ width: `${progress.percent}%` }}
                      />
                    </div>
                  </div>

                  {/* Action Link */}
                  <div className="inline-flex items-center text-sky-600 dark:text-sky-400 font-bold text-xs">
                    <span>Start Practice</span>
                    <ChevronRight className="h-3.5 w-3.5 ml-1 group-hover:translate-x-1 transition-transform duration-200" />
                  </div>
                </div>
              </Link>
            );
          })}
        </div>
      </div>
    </div>
  );
};

export default WDU203cCatalog;
