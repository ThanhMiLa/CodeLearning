import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { 
  Trash2, 
  ShoppingCart, 
  ArrowRight, 
  CreditCard, 
  AlertCircle, 
  QrCode,
  Loader
} from 'lucide-react';
import { useCart } from '../../context/CartContext';
import api from '../../api/axios';
import { getErrorMessage } from '../../utils/errorUtils';
import type { ApiResponse, OrderCheckoutResponse, PaymentDepositResponse } from '../../types';

const CartPage: React.FC = () => {
  const { cartItems, cartCount, removeFromCart, clearCart, fetchCart } = useCart();
  
  const [isProcessing, setIsProcessing] = useState(false);
  const [checkoutError, setCheckoutError] = useState<string | null>(null);
  
  // Payment Deposit Modal/State
  const [showDepositModal, setShowDepositModal] = useState(false);
  const [checkoutDetails, setCheckoutDetails] = useState<OrderCheckoutResponse | null>(null);
  const [isCreatingDepositLink, setIsCreatingDepositLink] = useState(false);

  const handleRemove = async (courseId: number) => {
    try {
      await removeFromCart(courseId);
    } catch (error: any) {
      console.error('Failed to remove item:', error);
    }
  };

  const handleClear = async () => {
    if (window.confirm('Are you sure you want to clear all courses from the cart?')) {
      try {
        await clearCart();
      } catch (error) {
        console.error('Failed to clear cart:', error);
      }
    }
  };

  // Step 1: Checkout Cart
  const handleCheckout = async () => {
    if (cartItems.length === 0) return;
    setIsProcessing(true);
    setCheckoutError(null);

    const courseIds = cartItems.map(item => item.course.id);
    
    try {
      const response = await api.post<ApiResponse<OrderCheckoutResponse>>('/orders/checkout', { courseIds });
      const orderData = response.data.result;
      setCheckoutDetails(orderData);
      
      // Step 2: Show deposit modal to proceed with PayOS deposit
      setShowDepositModal(true);
    } catch (error: any) {
      console.error('Checkout failed:', error);
      setCheckoutError(getErrorMessage(error));
    } finally {
      setIsProcessing(false);
    }
  };

  // Step 3: Create deposit link & redirect
  const handleProceedToPayment = async () => {
    if (!checkoutDetails) return;
    setIsCreatingDepositLink(true);
    
    try {
      const response = await api.post<ApiResponse<PaymentDepositResponse>>('/payment/deposit', {
        amount: checkoutDetails.totalAmount
      });
      
      const { checkoutUrl } = response.data.result;
      
      // Clear local cart since checkout was initiated
      await clearCart();
      await fetchCart();
      
      // Redirect browser to PayOS payment link
      window.location.href = checkoutUrl;
    } catch (error: any) {
      console.error('Failed to create payment link:', error);
      alert(getErrorMessage(error));
    } finally {
      setIsCreatingDepositLink(false);
    }
  };

  const calculateTotal = () => {
    return cartItems.reduce((acc, item) => acc + item.course.price, 0);
  };

  const totalAmount = calculateTotal();

  const formatVND = (amount: number) => {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
  };

  return (
    <div className="mx-auto max-w-[1600px] w-full px-4 py-8 sm:px-6 lg:px-8 text-left">
      <div className="mb-8 flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-extrabold tracking-tight text-slate-900 dark:text-white flex items-center">
            <ShoppingCart className="h-8 w-8 mr-2.5 text-indigo-600 dark:text-indigo-400" />
            <span>Your Cart</span>
          </h1>
          <p className="text-slate-500 mt-2">Review your selected courses before checking out</p>
        </div>
        {cartCount > 0 && (
          <button 
            onClick={handleClear}
            className="flex items-center space-x-1 py-2 px-4 rounded-xl border border-red-200 dark:border-red-950/20 text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-950/10 text-sm font-semibold transition-colors"
          >
            <Trash2 className="h-4 w-4" />
            <span>Clear All</span>
          </button>
        )}
      </div>

      {checkoutError && (
        <div className="flex items-center space-x-2 p-4 mb-8 rounded-xl bg-red-50 dark:bg-red-950/20 border border-red-100/50 dark:border-red-900/30 text-sm text-red-700 dark:text-red-400">
          <AlertCircle className="h-5 w-5 shrink-0" />
          <span>{checkoutError}</span>
        </div>
      )}

      {cartCount === 0 ? (
        /* Empty State */
        <div className="text-center py-20 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl p-8 shadow-sm">
          <ShoppingCart className="h-16 w-16 text-slate-300 dark:text-slate-700 mx-auto mb-4" />
          <h3 className="text-lg font-bold text-slate-900 dark:text-white">Your Cart is Empty</h3>
          <p className="text-slate-500 mt-2 max-w-sm mx-auto">Your cart is empty. Please browse the course catalog to find the right courses for you!</p>
          <Link to="/courses" className="mt-6 inline-flex items-center justify-center rounded-full bg-indigo-600 px-5 py-2.5 text-sm font-semibold text-white hover:bg-indigo-700 transition-colors">
            Explore Courses
          </Link>
        </div>
      ) : (
        /* Cart Content Grid */
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
          {/* Cart Items List */}
          <div className="lg:col-span-2 space-y-4">
            {cartItems.map((item) => (
              <motion.div
                key={item.id}
                layout
                exit={{ opacity: 0, scale: 0.95 }}
                className="flex flex-col sm:flex-row items-start sm:items-center justify-between p-4 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl shadow-sm gap-4"
              >
                {/* Course Details */}
                <div className="flex items-center space-x-4 flex-grow">
                  <div className="h-20 w-32 rounded-xl bg-slate-100 dark:bg-slate-800 overflow-hidden shrink-0 border border-slate-200 dark:border-slate-800">
                    {item.course.thumbnailUrl ? (
                      <img
                        src={item.course.thumbnailUrl}
                        alt={item.course.title}
                        className="h-full w-full object-cover"
                      />
                    ) : (
                      <div className="h-full w-full flex items-center justify-center bg-indigo-50 dark:bg-indigo-950/20 text-indigo-600 dark:text-indigo-400">
                        <ShoppingCart className="h-8 w-8 opacity-40" />
                      </div>
                    )}
                  </div>
                  <div>
                    <Link to={`/courses/${item.course.id}`} className="font-bold text-slate-900 dark:text-white hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors line-clamp-1 text-sm sm:text-base">
                      {item.course.title}
                    </Link>
                    <p className="text-xs text-slate-400 mt-1 line-clamp-1">@{item.course.shortDescription}</p>
                  </div>
                </div>

                {/* Price & Actions */}
                <div className="flex items-center justify-between sm:justify-end w-full sm:w-auto gap-6 sm:gap-8 border-t sm:border-t-0 border-slate-200 dark:border-slate-800 pt-3 sm:pt-0 shrink-0">
                  <span className="font-bold text-indigo-600 dark:text-indigo-400 text-sm sm:text-base">
                    {formatVND(item.course.price)}
                  </span>
                  
                  <button
                    onClick={() => handleRemove(item.course.id)}
                    className="p-2 text-slate-400 hover:text-red-500 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800 transition-all active:scale-95 cursor-pointer"
                    title="Remove Course"
                  >
                    <Trash2 className="h-4.5 w-4.5" />
                  </button>
                </div>
              </motion.div>
            ))}
          </div>

          {/* Order Summary (Right) */}
          <div className="lg:col-span-1">
            <div className="p-6 rounded-2xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-md space-y-6">
              <h3 className="font-bold text-slate-950 dark:text-white text-lg border-b border-slate-200 dark:border-slate-800 pb-4">Order Summary</h3>

              <div className="space-y-4 text-sm">
                <div className="flex justify-between text-slate-500 dark:text-slate-400">
                  <span>Quantity</span>
                  <span className="font-semibold text-slate-800 dark:text-slate-200">{cartCount}</span>
                </div>
                <div className="flex justify-between text-slate-500 dark:text-slate-400">
                  <span>Subtotal</span>
                  <span className="font-semibold text-slate-800 dark:text-slate-200">{formatVND(totalAmount)}</span>
                </div>
                <div className="flex justify-between text-slate-500 dark:text-slate-400">
                  <span>Discounts</span>
                  <span className="font-semibold text-slate-800 dark:text-slate-200">{formatVND(0)}</span>
                </div>

                <div className="w-full h-[1px] bg-slate-100 dark:bg-slate-800"></div>

                <div className="flex justify-between text-base font-bold">
                  <span>Total Price</span>
                  <span className="text-indigo-600 dark:text-indigo-400">{formatVND(totalAmount)}</span>
                </div>
              </div>

              <button
                onClick={handleCheckout}
                disabled={isProcessing}
                className="w-full flex items-center justify-center space-x-2 py-3.5 px-4 border border-transparent text-sm font-semibold rounded-xl text-white bg-indigo-600 hover:bg-indigo-700 shadow-lg shadow-indigo-500/15 hover:shadow-indigo-500/25 transition-all disabled:opacity-50 active:scale-97 cursor-pointer"
              >
                {isProcessing ? (
                  <Loader className="h-5 w-5 animate-spin" />
                ) : (
                  <>
                    <span>Checkout Now</span>
                    <ArrowRight className="h-4.5 w-4.5" />
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* PayOS Deposit Redirection Modal */}
      <AnimatePresence>
        {showDepositModal && checkoutDetails && (
          <motion.div 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4"
          >
            <motion.div 
              initial={{ scale: 0.95 }}
              animate={{ scale: 1 }}
              exit={{ scale: 0.95 }}
              className="w-full max-w-md bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl shadow-xl overflow-hidden p-6 sm:p-8 space-y-6"
            >
              <div className="text-center">
                <QrCode className="h-12 w-12 text-indigo-600 dark:text-indigo-400 mx-auto mb-4" />
                <h3 className="font-bold text-slate-950 dark:text-white text-xl">Confirm Deposit & Checkout</h3>
                <p className="text-slate-500 text-sm mt-2">
                  Order <span className="font-semibold">#{checkoutDetails.orderId}</span> has been created. Please deposit funds into your wallet to complete the purchase.
                </p>
              </div>

              <div className="p-4 rounded-xl bg-slate-50 dark:bg-slate-950/40 border border-slate-200 dark:border-slate-800 space-y-3 text-sm">
                <div className="flex justify-between">
                  <span className="text-slate-500">Order ID:</span>
                  <span className="font-bold text-slate-800 dark:text-slate-200">#{checkoutDetails.orderId}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-slate-500">Required Deposit:</span>
                  <span className="font-bold text-indigo-600 dark:text-indigo-400 text-base">{formatVND(checkoutDetails.totalAmount)}</span>
                </div>
              </div>

              <div className="flex gap-4">
                <button
                  onClick={() => setShowDepositModal(false)}
                  className="flex-grow py-3 text-sm font-semibold rounded-xl border border-slate-200 dark:border-slate-800 text-slate-500 dark:text-slate-400 text-center hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                >
                  Cancel
                </button>
                <button
                  onClick={handleProceedToPayment}
                  disabled={isCreatingDepositLink}
                  className="flex-grow flex items-center justify-center space-x-1.5 py-3 text-sm font-semibold rounded-xl bg-indigo-600 text-white text-center hover:bg-indigo-700 shadow-md shadow-indigo-500/10 disabled:opacity-50 transition-all active:scale-97 cursor-pointer"
                >
                  {isCreatingDepositLink ? (
                    <Loader className="h-4.5 w-4.5 animate-spin" />
                  ) : (
                    <>
                      <CreditCard className="h-4.5 w-4.5" />
                      <span>Deposit Now</span>
                    </>
                  )}
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};

export default CartPage;
