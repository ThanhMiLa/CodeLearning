/**
 * Extracts a user-friendly error message from an API error response.
 * 
 * The backend returns errors in the format:
 * { status: number, code: number, message: string, result: any, timestamp: string }
 * 
 * This utility extracts the `message` field from the error response data,
 * falling back to a generic message only if the backend message is unavailable.
 */
export const getErrorMessage = (error: any, fallback?: string): string => {
  // Try to get message from the backend API response body
  const backendMessage = error?.response?.data?.message;
  if (backendMessage && typeof backendMessage === 'string') {
    return backendMessage;
  }

  // Try to get message from a custom API error (thrown by axios interceptor)
  if (error?.message && typeof error.message === 'string' && error.message !== 'Network Error') {
    return error.message;
  }

  // Network error
  if (error?.message === 'Network Error') {
    return 'Không thể kết nối đến máy chủ. Vui lòng kiểm tra kết nối mạng của bạn.';
  }

  return fallback || 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại sau.';
};
