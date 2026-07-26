import React, { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { QUIZZES } from '../../data/quizzesData';
import { 
  ArrowLeft, 
  Sparkles, 
  Layers, 
  ChevronRight, 
  HelpCircle,
  Award,
  Flame
} from 'lucide-react';

interface ModuleInfo {
  id: string;
  moduleNum: number;
  title: string;
  subtitle?: string;
  description?: string;
  tags?: string[];
  gradient: string;
  iconBg: string;
  badgeLabel: string;
}

const MODULE_METADATA: Record<string, Partial<ModuleInfo>> = {
  'swr302-all-unique': {
    moduleNum: 0,
    badgeLabel: 'FULL LIST',
    title: 'Full Question List (All 332 Unique Questions)',
    gradient: 'from-purple-500 to-indigo-500',
    iconBg: 'bg-purple-500/10 text-purple-600 dark:text-purple-400',
  },
  'swr302-random-exam': {
    moduleNum: 0,
    badgeLabel: 'MOCK EXAM',
    title: 'Random 60-Question Mock Exam',
    gradient: 'from-rose-500 to-pink-500',
    iconBg: 'bg-rose-500/10 text-rose-600 dark:text-rose-400',
  },
  'swr302-module-1': {
    moduleNum: 1,
    badgeLabel: 'MODULE 1',
    title: 'Module 1: Fundamentals, Product Vision & BA Role',
    subtitle: 'Overview of Software Requirements, Product Vision & BA Role',
    description: 'Covers 3 levels of Requirements, Scope Creep vs Gold Plating, Software Bill of Rights & Responsibilities, and core Business Analyst tasks.',
    tags: ['Scope Creep', 'Gold Plating', 'Product Vision', 'Bill of Rights', 'BA Role'],
    gradient: 'from-indigo-500 to-blue-600',
    iconBg: 'bg-indigo-500/10 text-indigo-600 dark:text-indigo-400',
  },
  'swr302-module-2': {
    moduleNum: 2,
    badgeLabel: 'MODULE 2',
    title: 'Module 2: Requirements Elicitation & Stakeholders',
    subtitle: 'Requirements Elicitation & Stakeholder Management',
    description: 'Stakeholder Classification, User Classes, Personas, Product Champions, and 6 Elicitation Techniques: Interviews, Workshops, Observation, Surveys, Prototypes.',
    tags: ['Elicitation', 'Stakeholders', 'Personas', 'Product Champion', 'Interviews', 'Prototypes'],
    gradient: 'from-blue-500 to-cyan-600',
    iconBg: 'bg-blue-500/10 text-blue-600 dark:text-blue-400',
  },
  'swr302-module-3': {
    moduleNum: 3,
    badgeLabel: 'MODULE 3',
    title: 'Module 3: Requirements Analysis & Modeling',
    subtitle: 'Requirements Analysis & Visual Modeling',
    description: 'Context Diagrams (System Boundaries), Use Case Specifications & Diagrams, DFD, ERD, and State Machine Diagrams.',
    tags: ['Context Diagram', 'Use Cases', 'DFD', 'ERD', 'System Boundary', 'UML'],
    gradient: 'from-cyan-500 to-teal-600',
    iconBg: 'bg-cyan-500/10 text-cyan-600 dark:text-cyan-400',
  },
  'swr302-module-4': {
    moduleNum: 4,
    badgeLabel: 'MODULE 4',
    title: 'Module 4: Specification & Quality Attributes',
    subtitle: 'SRS Specification & Quality Attributes (NFR)',
    description: 'SRS Document Structure (IEEE 830), Functional vs Non-Functional Requirements, NFR Quantification using Planguage (Tom Gilb), and Business Rules.',
    tags: ['SRS (IEEE 830)', 'Quality Attributes', 'NFR', 'Planguage', 'Business Rules'],
    gradient: 'from-emerald-500 to-green-600',
    iconBg: 'bg-emerald-500/10 text-emerald-600 dark:text-emerald-400',
  },
  'swr302-module-5': {
    moduleNum: 5,
    badgeLabel: 'MODULE 5',
    title: 'Module 5: Requirements Validation & Verification',
    subtitle: 'Requirements Validation & Verification Techniques',
    description: 'Peer Reviews, Formal Inspections, Walkthroughs, Requirements Quality Criteria (Correct, Complete, Feasible), and Acceptance Criteria.',
    tags: ['Formal Inspection', 'Walkthrough', 'Peer Review', 'Acceptance Criteria', 'Test Cases'],
    gradient: 'from-amber-500 to-orange-600',
    iconBg: 'bg-amber-500/10 text-amber-600 dark:text-amber-400',
  },
  'swr302-module-6': {
    moduleNum: 6,
    badgeLabel: 'MODULE 6',
    title: 'Module 6: Management & Change Control',
    subtitle: 'Requirements Management, Traceability & Change Control',
    description: 'Requirements Traceability Matrix (RTM), Change Control Process, Change Control Board (CCB), Impact Analysis, and Baselines.',
    tags: ['Traceability (RTM)', 'Change Control (CCB)', 'Impact Analysis', 'Baseline'],
    gradient: 'from-rose-500 to-pink-600',
    iconBg: 'bg-rose-500/10 text-rose-600 dark:text-rose-400',
  },
  'swr302-module-7': {
    moduleNum: 7,
    badgeLabel: 'MODULE 7',
    title: 'Module 7: Prioritization & Agile Requirements',
    subtitle: 'Requirements Prioritization & Agile Requirements',
    description: 'Prioritization Techniques (MoSCoW, Kano Model, Pairwise Comparison), and Agile Requirements: User Stories, INVEST criteria, Epics, Product Backlog.',
    tags: ['MoSCoW', 'Kano Model', 'User Stories', 'INVEST', 'Product Backlog', 'Agile BA'],
    gradient: 'from-violet-500 to-purple-600',
    iconBg: 'bg-violet-500/10 text-violet-600 dark:text-violet-400',
  },
};

const getModuleMeta = (id: string, title: string): Partial<ModuleInfo> => {
  if (id === 'swr302-all-unique') return MODULE_METADATA['swr302-all-unique'];
  if (id === 'swr302-random-exam') return MODULE_METADATA['swr302-random-exam'];

  // Match module number 1 to 7
  const match = (id + ' ' + title).match(/module[^\d]*(\d+)/i);
  if (match) {
    const num = parseInt(match[1], 10);
    const key = `swr302-module-${num}`;
    if (MODULE_METADATA[key]) {
      return MODULE_METADATA[key];
    }
  }
  return {};
};

const SWR302Catalog: React.FC = () => {
  // Fetch SWR302 Module quiz sets sorted: Full List, Random Exam, then Modules 1-7
  const allCards = useMemo(() => {
    const list: any[] = [];

    // 1. Full list card
    const master = QUIZZES.find(q => q.id === 'swr302-all-unique');
    if (master) {
      list.push(master);
    }

    // 2. Random 60 mock exam card
    list.push({
      id: 'swr302-random-exam',
      title: 'Random 60-Question Mock Exam',
      questions: { length: 60 }
    });

    // 3. Modules 1 to 7
    const modules = QUIZZES.filter(q => q.id.includes('module'));
    modules.sort((a, b) => {
      const matchA = (a.id + ' ' + a.title).match(/module[^\d]*(\d+)/i);
      const matchB = (b.id + ' ' + b.title).match(/module[^\d]*(\d+)/i);
      const numA = matchA ? parseInt(matchA[1], 10) : 99;
      const numB = matchB ? parseInt(matchB[1], 10) : 99;
      return numA - numB;
    });
    list.push(...modules);

    return list;
  }, []);

  // Helper to calculate progress for a quiz set from localStorage
  const getProgress = (quizId: string, totalCount: number) => {
    try {
      const saved = localStorage.getItem(`quiz_progress_${quizId.toLowerCase()}`);
      if (saved) {
        const parsed = JSON.parse(saved);
        const submitted = parsed.submittedQuestions ? Object.keys(parsed.submittedQuestions).length : 0;
        return {
          submitted,
          percentage: totalCount > 0 ? Math.round((submitted / totalCount) * 100) : 0,
        };
      }
    } catch (e) {
      // ignore
    }
    return { submitted: 0, percentage: 0 };
  };

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-slate-950 py-10 px-4 sm:px-6 lg:px-8 transition-colors duration-200">
      {/* Background ambient lighting */}
      <div className="absolute top-16 left-1/3 -translate-x-1/2 w-[600px] h-[350px] bg-purple-500/10 dark:bg-purple-500/5 rounded-full blur-[140px] pointer-events-none" />
      <div className="absolute top-40 right-1/4 translate-x-1/2 w-[500px] h-[300px] bg-indigo-500/10 dark:bg-indigo-500/5 rounded-full blur-[120px] pointer-events-none" />

      <div className="mx-auto max-w-[1240px] relative z-10">
        {/* Navigation Top Bar */}
        <div className="flex items-center justify-between mb-8">
          <Link
            to="/quiz"
            className="inline-flex items-center text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-purple-600 dark:hover:text-purple-400 transition-colors bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 px-4 py-2 rounded-2xl shadow-sm hover:shadow-md"
          >
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Quiz Catalog
          </Link>

          <div className="inline-flex items-center space-x-2 px-3 py-1 rounded-full bg-purple-500/10 dark:bg-purple-500/20 text-purple-600 dark:text-purple-400 text-xs font-bold uppercase tracking-wider">
            <Sparkles className="h-3.5 w-3.5" />
            <span>Module Learning</span>
          </div>
        </div>

        {/* Section Header */}
        <div className="flex items-center justify-between mb-6 px-1">
          <h2 className="text-lg font-black text-slate-900 dark:text-white flex items-center gap-2">
            <span>Module List</span>
            <span className="text-xs font-extrabold px-2.5 py-0.5 rounded-full bg-purple-500/10 text-purple-600 dark:text-purple-400">
              {allCards.length} Learning Sets
            </span>
          </h2>
        </div>

        {/* Cards Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {allCards.map((quiz) => {
            const meta = getModuleMeta(quiz.id, quiz.title);
            const qCount = quiz.questions?.length || 0;
            const progress = getProgress(quiz.id, qCount);
            const rawTitle = meta.title || quiz.title;
            const cardTitle = rawTitle.replace(/^SWR302\s*[-:]?\s*/i, '');
            const isMaster = quiz.id === 'swr302-all-unique';
            const isExam = quiz.id === 'swr302-random-exam';

            const matchNum = (quiz.id + ' ' + quiz.title).match(/module[^\d]*(\d+)/i);
            const modNum = matchNum ? matchNum[1] : (meta.moduleNum ? String(meta.moduleNum) : '');
            const badgeLabelText = isMaster ? 'FULL LIST' : isExam ? 'MOCK EXAM' : `MODULE ${modNum}`;

            return (
              <Link
                key={quiz.id}
                to={`/quiz/${quiz.id}`}
                className="group relative rounded-3xl border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-6 shadow-sm hover:shadow-xl dark:shadow-none hover:border-purple-500/40 dark:hover:border-purple-500/40 hover:-translate-y-1 transition-all duration-300 text-left overflow-hidden flex flex-col justify-between"
              >
                {/* Header Gradient Line */}
                <div className={`absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r ${meta.gradient || 'from-purple-500 to-indigo-500'} transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left`} />

                <div>
                  {/* Top Badge & Questions Count */}
                  <div className="flex items-center justify-between mb-4">
                    <span className={`inline-flex items-center gap-1 text-xs font-black px-3 py-1 rounded-full ${meta.iconBg || 'bg-purple-500/10 text-purple-600'}`}>
                      {isMaster ? (
                        <>
                          <Award className="h-3.5 w-3.5" />
                          <span>FULL LIST</span>
                        </>
                      ) : isExam ? (
                        <>
                          <Flame className="h-3.5 w-3.5" />
                          <span>MOCK EXAM</span>
                        </>
                      ) : (
                        <>
                          <Layers className="h-3.5 w-3.5" />
                          <span>{badgeLabelText}</span>
                        </>
                      )}
                    </span>

                    <span className="inline-flex items-center gap-1 text-xs font-extrabold px-2.5 py-1 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300">
                      <HelpCircle className="h-3 w-3 text-purple-500" />
                      {qCount} questions
                    </span>
                  </div>

                  {/* Title */}
                  <h3 className="text-lg font-black text-slate-900 dark:text-white mb-2 group-hover:text-purple-600 dark:group-hover:text-purple-400 transition-colors leading-snug">
                    {cardTitle}
                  </h3>

                  {meta.subtitle && (
                    <p className="text-xs font-semibold text-slate-500 dark:text-slate-400 mb-3 line-clamp-2 leading-relaxed">
                      {meta.subtitle}
                    </p>
                  )}

                  {meta.description && (
                    <p className="text-xs text-slate-400 dark:text-slate-500 leading-relaxed mb-4 line-clamp-2">
                      {meta.description}
                    </p>
                  )}

                  {/* Tag Pills */}
                  {meta.tags && (
                    <div className="flex flex-wrap gap-1.5 mb-6">
                      {meta.tags.slice(0, 3).map((tag, i) => (
                        <span key={i} className="text-[11px] font-bold px-2 py-0.5 rounded-md bg-slate-100 dark:bg-slate-800/80 text-slate-500 dark:text-slate-400">
                          #{tag}
                        </span>
                      ))}
                    </div>
                  )}
                </div>

                {/* Bottom Action & Progress Bar */}
                <div className="pt-4 border-t border-slate-100 dark:border-slate-800/80">
                  {progress.submitted > 0 && !isExam && (
                    <div className="mb-3">
                      <div className="flex justify-between items-center text-[11px] font-bold mb-1">
                        <span className="text-slate-500 dark:text-slate-400">Progress: {progress.submitted}/{qCount} questions</span>
                        <span className="text-purple-600 dark:text-purple-400">{progress.percentage}%</span>
                      </div>
                      <div className="w-full h-1.5 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                        <div
                          className="h-full bg-gradient-to-r from-purple-500 to-indigo-500 transition-all duration-300"
                          style={{ width: `${progress.percentage}%` }}
                        />
                      </div>
                    </div>
                  )}

                  <div className="flex items-center justify-end text-xs font-extrabold text-purple-600 dark:text-purple-400 group-hover:text-purple-700 dark:group-hover:text-purple-300">
                    <div className="inline-flex items-center">
                      <span>{isExam ? 'Start Mock Exam' : 'Start Learning'}</span>
                      <ChevronRight className="h-4 w-4 ml-1 group-hover:translate-x-1 transition-transform" />
                    </div>
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

export default SWR302Catalog;
