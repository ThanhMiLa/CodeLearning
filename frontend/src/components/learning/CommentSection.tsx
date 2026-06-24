import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { MessageSquare, Send, CornerDownRight, Loader, ChevronDown, ChevronUp } from 'lucide-react';
import api from '../../api/axios';
import { useAuth } from '../../context/AuthContext';
import type { ApiResponse, SpringPageResponse, LessonCommentResponse } from '../../types';

interface CommentSectionProps {
  lessonId: number;
}

interface ExtendedComment extends LessonCommentResponse {
  replies?: LessonCommentResponse[];
  showReplies?: boolean;
  isRepliesLoading?: boolean;
  repliesPage?: number;
  hasMoreReplies?: boolean;
}

const CommentSection: React.FC<CommentSectionProps> = ({ lessonId }) => {
  const { user } = useAuth();
  const [comments, setComments] = useState<ExtendedComment[]>([]);
  const [newCommentContent, setNewCommentContent] = useState('');
  const [replyContent, setReplyContent] = useState('');
  
  // Replying state (holds comment ID being replied to)
  const [activeReplyId, setActiveReplyId] = useState<number | null>(null);

  // Pagination states
  const [page, setPage] = useState(0);
  const [hasMore, setHasMore] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [isSubmitLoading, setIsSubmitLoading] = useState(false);

  const fetchComments = async (pageNum = 0, append = false) => {
    setIsLoading(true);
    try {
      const response = await api.get<ApiResponse<SpringPageResponse<LessonCommentResponse>>>(
        `/lessons/${lessonId}/comments`,
        {
          params: {
            page: pageNum,
            size: 10,
            sort: 'createdAt,desc' // Show newest comments first
          }
        }
      );
      
      const pageData = response.data.result;
      const fetchedComments: ExtendedComment[] = pageData.content.map(c => ({
        ...c,
        replies: [],
        showReplies: false,
        isRepliesLoading: false,
        repliesPage: 0,
        hasMoreReplies: c.replyCount > 0
      }));

      if (append) {
        setComments(prev => [...prev, ...fetchedComments]);
      } else {
        setComments(fetchedComments);
      }
      
      setPage(pageData.number);
      // Check if it's the last page
      setHasMore(!pageData.last);
    } catch (error) {
      console.error('Failed to fetch comments:', error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    setComments([]);
    setPage(0);
    fetchComments(0, false);
  }, [lessonId]);

  const loadMoreComments = () => {
    if (hasMore && !isLoading) {
      fetchComments(page + 1, true);
    }
  };

  // Fetch replies for a comment
  const handleToggleReplies = async (commentId: number) => {
    const commentIndex = comments.findIndex(c => c.id === commentId);
    if (commentIndex === -1) return;
    
    const comment = comments[commentIndex];
    
    // Toggle off if already showing
    if (comment.showReplies) {
      setComments(prev => prev.map(c => c.id === commentId ? { ...c, showReplies: false } : c));
      return;
    }

    // Mark as showing and loading
    setComments(prev => prev.map(c => c.id === commentId ? { ...c, showReplies: true, isRepliesLoading: true } : c));
    
    try {
      const response = await api.get<ApiResponse<SpringPageResponse<LessonCommentResponse>>>(
        `/lessons/${lessonId}/comments/${commentId}/replies`,
        {
          params: {
            page: 0,
            size: 20,
            sort: 'createdAt,asc' // Oldest replies first
          }
        }
      );
      
      const pageData = response.data.result;
      
      setComments(prev => prev.map(c => c.id === commentId ? { 
        ...c, 
        replies: pageData.content,
        isRepliesLoading: false,
        hasMoreReplies: !pageData.last
      } : c));
    } catch (error) {
      console.error('Failed to fetch replies:', error);
      setComments(prev => prev.map(c => c.id === commentId ? { ...c, isRepliesLoading: false } : c));
    }
  };

  // Submit root comment
  const handleSubmitComment = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newCommentContent.trim() || isSubmitLoading) return;

    setIsSubmitLoading(true);
    try {
      const response = await api.post<ApiResponse<LessonCommentResponse>>(`/lessons/${lessonId}/comments`, {
        content: newCommentContent,
        parentCommentId: null
      });

      const newComment: ExtendedComment = {
        ...response.data.result,
        replies: [],
        showReplies: false,
        isRepliesLoading: false,
        repliesPage: 0,
        hasMoreReplies: false
      };

      // Push new comment to the top of list
      setComments(prev => [newComment, ...prev]);
      setNewCommentContent('');
    } catch (error) {
      console.error('Failed to submit comment:', error);
    } finally {
      setIsSubmitLoading(false);
    }
  };

  // Submit reply
  const handleSubmitReply = async (commentId: number) => {
    if (!replyContent.trim() || isSubmitLoading) return;

    setIsSubmitLoading(true);
    try {
      const response = await api.post<ApiResponse<LessonCommentResponse>>(`/lessons/${lessonId}/comments`, {
        content: replyContent,
        parentCommentId: commentId
      });

      const newReply = response.data.result;

      // Update parent comment replies list
      setComments(prev => prev.map(c => {
        if (c.id === commentId) {
          return {
            ...c,
            replyCount: c.replyCount + 1,
            replies: [...(c.replies || []), newReply],
            showReplies: true
          };
        }
        return c;
      }));

      setReplyContent('');
      setActiveReplyId(null);
    } catch (error) {
      console.error('Failed to submit reply:', error);
    } finally {
      setIsSubmitLoading(false);
    }
  };

  const formatDate = (isoString: string) => {
    const date = new Date(isoString);
    return date.toLocaleDateString('vi-VN', { 
      day: 'numeric', 
      month: 'short', 
      hour: '2-digit', 
      minute: '2-digit' 
    });
  };

  return (
    <div className="flex flex-col h-full flex-grow bg-white dark:bg-slate-900 overflow-hidden">
      {/* Comment Form */}
      <form onSubmit={handleSubmitComment} className="p-4 border-b border-slate-200 dark:border-slate-800 flex items-center space-x-3 shrink-0">
        <div className="h-8 w-8 rounded-full bg-indigo-600 text-white flex items-center justify-center font-bold text-xs uppercase shadow-sm">
          {user?.displayName.substring(0, 2)}
        </div>
        <div className="relative flex-grow">
          <input
            type="text"
            placeholder="Write a comment or ask a question..."
            value={newCommentContent}
            onChange={(e) => setNewCommentContent(e.target.value)}
            className="w-full pl-4 pr-11 py-2 rounded-full border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all"
          />
          <button 
            type="submit" 
            disabled={!newCommentContent.trim() || isSubmitLoading}
            className="absolute right-1 top-1/2 -translate-y-1/2 p-1.5 text-indigo-600 hover:text-indigo-700 disabled:opacity-30 transition-colors rounded-full"
          >
            <Send className="h-4 w-4" />
          </button>
        </div>
      </form>

      {/* Comments Scrollable area */}
      <div className="flex-grow overflow-y-auto p-4 space-y-6">
        {comments.length === 0 && !isLoading ? (
          <div className="text-center py-10 text-slate-500 dark:text-slate-400">
            <MessageSquare className="h-10 w-10 mx-auto opacity-30 mb-3" />
            <p className="text-xs">No discussions yet. Start the conversation!</p>
          </div>
        ) : (
          <div className="space-y-6">
            {comments.map((comment) => (
              <div key={comment.id} className="space-y-4">
                {/* Root Comment Container */}
                <div className="flex items-start space-x-3 text-left">
                  <div className="h-8 w-8 rounded-full bg-slate-200 dark:bg-slate-800 text-slate-700 dark:text-slate-300 flex items-center justify-center font-semibold text-xs uppercase shrink-0">
                    {comment.displayName.substring(0, 2)}
                  </div>
                  <div className="flex-grow space-y-1.5">
                    <div className="flex items-baseline space-x-2">
                      <span className="font-bold text-slate-900 dark:text-white text-xs">{comment.displayName}</span>
                      <span className="text-[10px] text-slate-400 dark:text-slate-500">{formatDate(comment.createdAt)}</span>
                    </div>
                    <p className="text-sm text-slate-700 dark:text-slate-300 leading-relaxed whitespace-pre-wrap">
                      {comment.content}
                    </p>
                    <div className="flex items-center space-x-4 pt-1">
                      {/* Reply Button */}
                      <button
                        onClick={() => {
                          setActiveReplyId(activeReplyId === comment.id ? null : comment.id);
                          setReplyContent('');
                        }}
                        className="text-xs font-semibold text-slate-500 hover:text-indigo-600 dark:text-slate-400 dark:hover:text-indigo-400 transition-colors"
                      >
                        Reply
                      </button>

                      {/* Toggle Replies button */}
                      {comment.replyCount > 0 && (
                        <button
                          onClick={() => handleToggleReplies(comment.id)}
                          className="text-xs font-semibold text-indigo-600 hover:text-indigo-700 dark:text-indigo-400 flex items-center space-x-1"
                        >
                          {comment.showReplies ? <ChevronUp className="h-3.5 w-3.5" /> : <ChevronDown className="h-3.5 w-3.5" />}
                          <span>{comment.showReplies ? 'Hide replies' : `Show ${comment.replyCount} replies`}</span>
                        </button>
                      )}
                    </div>
                  </div>
                </div>

                {/* Reply Form (Appears under comment) */}
                <AnimatePresence>
                  {activeReplyId === comment.id && (
                    <motion.div 
                      initial={{ opacity: 0, height: 0 }}
                      animate={{ opacity: 1, height: 'auto' }}
                      exit={{ opacity: 0, height: 0 }}
                      className="ml-11 flex items-center space-x-3 overflow-hidden text-left"
                    >
                      <div className="h-7 w-7 rounded-full bg-indigo-600 text-white flex items-center justify-center font-bold text-[10px] uppercase shrink-0">
                        {user?.displayName.substring(0, 2)}
                      </div>
                      <div className="relative flex-grow">
                        <input
                          type="text"
                          placeholder={`Reply to ${comment.displayName}...`}
                          value={replyContent}
                          onChange={(e) => setReplyContent(e.target.value)}
                          className="w-full pl-3 pr-10 py-1.5 rounded-full border border-slate-300 dark:border-slate-800 bg-slate-100/70 dark:bg-slate-950/40 text-xs focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500"
                        />
                        <button 
                          onClick={() => handleSubmitReply(comment.id)}
                          disabled={!replyContent.trim() || isSubmitLoading}
                          className="absolute right-1 top-1/2 -translate-y-1/2 p-1 text-indigo-600 hover:text-indigo-700 disabled:opacity-30"
                        >
                          <Send className="h-3.5 w-3.5" />
                        </button>
                      </div>
                    </motion.div>
                  )}
                </AnimatePresence>

                {/* Nested Replies Container */}
                <AnimatePresence>
                  {comment.showReplies && (
                    <motion.div 
                      initial={{ opacity: 0, height: 0 }}
                      animate={{ opacity: 1, height: 'auto' }}
                      exit={{ opacity: 0, height: 0 }}
                      className="ml-11 pl-4 border-l border-slate-200 dark:border-slate-800 space-y-4 overflow-hidden"
                    >
                      {comment.isRepliesLoading ? (
                        <div className="flex justify-start py-2">
                          <Loader className="h-4 w-4 animate-spin text-slate-400" />
                        </div>
                      ) : (
                        comment.replies && comment.replies.map((reply) => (
                          <div key={reply.id} className="flex items-start space-x-2 text-left">
                            <CornerDownRight className="h-4.5 w-4.5 text-slate-300 dark:text-slate-700 mt-1 shrink-0" />
                            <div className="h-7 w-7 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 flex items-center justify-center font-semibold text-[10px] uppercase shrink-0">
                              {reply.displayName.substring(0, 2)}
                            </div>
                            <div className="flex-grow space-y-1">
                              <div className="flex items-baseline space-x-2">
                                <span className="font-bold text-slate-950 dark:text-white text-xs">{reply.displayName}</span>
                                <span className="text-[9px] text-slate-400 dark:text-slate-500">{formatDate(reply.createdAt)}</span>
                              </div>
                              <p className="text-xs text-slate-700 dark:text-slate-300 leading-relaxed whitespace-pre-wrap">
                                {reply.content}
                              </p>
                            </div>
                          </div>
                        ))
                      )}
                    </motion.div>
                  )}
                </AnimatePresence>
              </div>
            ))}
          </div>
        )}

        {/* Load More Button */}
        {hasMore && (
          <button
            onClick={loadMoreComments}
            disabled={isLoading}
            className="w-full py-2.5 text-xs font-bold text-indigo-600 dark:text-indigo-400 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-xl border border-slate-200 dark:border-slate-800 transition-colors"
          >
            {isLoading ? <Loader className="h-4 w-4 animate-spin mx-auto" /> : 'Load more comments'}
          </button>
        )}

        {/* Loading Indicator for first load */}
        {isLoading && comments.length === 0 && (
          <div className="flex items-center justify-center py-10">
            <Loader className="h-6 w-6 animate-spin text-indigo-600" />
          </div>
        )}
      </div>
    </div>
  );
};

export default CommentSection;
