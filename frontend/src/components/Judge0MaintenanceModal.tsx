import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Wrench, X } from 'lucide-react';

interface Judge0MaintenanceModalProps {
  isOpen: boolean;
  onClose: () => void;
  errorMessage?: string | null;
  codeToCopy?: string;
}

export const Judge0MaintenanceModal: React.FC<Judge0MaintenanceModalProps> = ({
  isOpen,
  onClose
}) => {
  return (
    <AnimatePresence>
      {isOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          {/* Backdrop blur overlay */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 bg-slate-950/40 backdrop-blur-xs"
          />

          {/* Modal Container */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95, y: 10 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.95, y: 10 }}
            transition={{ type: 'spring', duration: 0.3 }}
            className="relative w-full max-w-sm overflow-hidden rounded-2xl border border-slate-200 bg-white/95 p-6 shadow-xl dark:border-slate-800 dark:bg-slate-900/95 backdrop-blur-md text-center"
          >
            {/* Close Button */}
            <button
              onClick={onClose}
              className="absolute right-3.5 top-3.5 rounded-full p-1 text-slate-400 hover:bg-slate-100 hover:text-slate-700 dark:hover:bg-slate-800 dark:hover:text-slate-200 transition-colors cursor-pointer"
              aria-label="Close"
            >
              <X className="h-4 w-4" />
            </button>

            {/* Wrench Icon */}
            <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-amber-500/10 text-amber-500 dark:bg-amber-500/20 dark:text-amber-400 mb-4 mt-2">
              <Wrench className="h-6 w-6" />
            </div>

            {/* Title */}
            <h3 className="text-lg font-bold text-slate-900 dark:text-white">
              System Maintenance
            </h3>

            {/* Message */}
            <p className="mt-2 text-xs text-slate-500 dark:text-slate-400 leading-relaxed px-2">
              The online grading system is currently undergoing maintenance. Code submission and test execution are temporarily unavailable. Please try again later.
            </p>

            {/* Got it action button */}
            <button
              onClick={onClose}
              className="mt-5 w-full rounded-xl bg-indigo-650 px-4 py-2 text-xs font-bold text-white shadow-sm hover:bg-indigo-700 active:scale-[0.98] transition-all cursor-pointer animate-pulse-indigo"
            >
              Got it
            </button>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  );
};
