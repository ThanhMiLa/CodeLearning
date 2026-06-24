import React, { useEffect, useState, useRef } from 'react';
import { useNavigate, useSearchParams, Link } from 'react-router-dom';
import { Heart, ArrowRight, Loader2, Sparkles } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useTranslation } from 'react-i18next';
import { motion } from 'framer-motion';
import api from '../../api/axios';
import type { ApiResponse, UserBalanceResponse } from '../../types';

interface Particle {
  x: number;
  y: number;
  size: number;
  color: string;
  speedX: number;
  speedY: number;
  rotation: number;
  rotationSpeed: number;
  opacity: number;
  type: 'heart' | 'rect' | 'circle';
}

const SuccessPage: React.FC = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const { user, refreshProfile } = useAuth();
  const [searchParams] = useSearchParams();
  const [syncing, setSyncing] = useState(true);
  const pollingStartedRef = useRef(false);
  
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const triggerBurstRef = useRef<((x: number, y: number, isInteractive?: boolean) => void) | null>(null);

  const orderCode = searchParams.get('orderCode') || searchParams.get('transactionCode') || 'N/A';

  // Ambient floating background hearts
  const [floatingHearts] = useState(() => 
    Array.from({ length: 25 }).map((_, i) => ({
      id: i,
      x: Math.random() * 95 + 2.5,
      delay: Math.random() * 5,
      duration: 6 + Math.random() * 5,
      size: 12 + Math.random() * 20,
      opacity: 0.12 + Math.random() * 0.28,
    }))
  );

  // Canvas particle engine
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    let animationFrameId: number;
    let particles: Particle[] = [];

    const colors = ['#f43f5e', '#ec4899', '#d946ef', '#a855f7', '#6366f1', '#3b82f6', '#10b981', '#f59e0b', '#ff007f'];

    const resizeCanvas = () => {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    };
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    // Create a particle burst
    const createBurst = (x: number, y: number, angle: number, count: number, isCenter: boolean = false) => {
      for (let i = 0; i < count; i++) {
        const velocity = isCenter 
          ? (4 + Math.random() * 12) 
          : (16 + Math.random() * 18);
        const spread = isCenter
          ? (Math.random() * Math.PI * 2) 
          : angle + (Math.random() * 0.5 - 0.25);
        
        const shapeRand = Math.random();
        const type = shapeRand < 0.45 ? 'heart' : (shapeRand < 0.75 ? 'rect' : 'circle');

        particles.push({
          x: x,
          y: y,
          size: type === 'heart' ? (8 + Math.random() * 12) : (4 + Math.random() * 8),
          color: type === 'heart' 
            ? ['#f43f5e', '#ec4899', '#f472b6', '#fb7185', '#ff007f'][Math.floor(Math.random() * 5)]
            : colors[Math.floor(Math.random() * colors.length)],
          speedX: Math.cos(spread) * velocity,
          speedY: Math.sin(spread) * velocity,
          rotation: Math.random() * 360,
          rotationSpeed: Math.random() * 8 - 4,
          opacity: 1,
          type: type,
        });
      }
    };

    // Assign reference function for interactive clicks
    triggerBurstRef.current = (clickX: number, clickY: number, isInteractive = false) => {
      createBurst(clickX, clickY, 0, isInteractive ? 45 : 80, true);
    };

    // Orchestrate multiple automated bursts for a grand fireworks show
    const triggerShow = () => {
      const midX = window.innerWidth / 2;
      const midY = window.innerHeight * 0.28;

      // 1. Initial burst: Corners and Center
      createBurst(0, window.innerHeight, -Math.PI / 4.8, 80);
      createBurst(window.innerWidth, window.innerHeight, -Math.PI * 3.8 / 4.8, 80);
      createBurst(midX, midY, 0, 90, true);
    };

    // Sequential timing of fireworks explosions
    triggerShow();
    const timers = [
      setTimeout(() => {
        createBurst(window.innerWidth / 2, window.innerHeight * 0.28, 0, 70, true);
      }, 250),
      setTimeout(() => {
        createBurst(0, window.innerHeight, -Math.PI / 4.5, 60);
        createBurst(window.innerWidth, window.innerHeight, -Math.PI * 3.5 / 4.5, 60);
      }, 500),
      setTimeout(() => {
        createBurst(window.innerWidth / 2, window.innerHeight * 0.28, 0, 80, true);
      }, 800),
      setTimeout(() => {
        createBurst(0, window.innerHeight, -Math.PI / 4.8, 70);
        createBurst(window.innerWidth, window.innerHeight, -Math.PI * 3.8 / 4.8, 70);
        createBurst(window.innerWidth / 2, window.innerHeight * 0.28, 0, 100, true);
      }, 1400)
    ];

    const updateAndDraw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      for (let i = particles.length - 1; i >= 0; i--) {
        const p = particles[i];
        p.x += p.speedX;
        p.y += p.speedY;
        p.speedY += 0.22; // gravity
        p.speedX *= 0.975; // drag
        p.speedY *= 0.975;
        p.rotation += p.rotationSpeed;
        p.opacity -= 0.0075; // fade out speed

        if (p.opacity <= 0) {
          particles.splice(i, 1);
          continue;
        }

        ctx.save();
        ctx.translate(p.x, p.y);
        ctx.rotate((p.rotation * Math.PI) / 180);
        ctx.fillStyle = p.color;
        ctx.globalAlpha = p.opacity;
        
        if (p.type === 'heart') {
          ctx.beginPath();
          const size = p.size;
          ctx.moveTo(0, -size / 4);
          ctx.bezierCurveTo(-size / 2, -size / 2, -size, -size / 4, -size, size / 4);
          ctx.bezierCurveTo(-size, size * 0.7, -size / 4, size, 0, size * 1.25);
          ctx.bezierCurveTo(size / 4, size, size, size * 0.7, size, size / 4);
          ctx.bezierCurveTo(size, -size / 4, size / 2, -size / 2, 0, -size / 4);
          ctx.closePath();
          ctx.fill();
        } else if (p.type === 'circle') {
          ctx.beginPath();
          ctx.arc(0, 0, p.size / 2, 0, Math.PI * 2);
          ctx.closePath();
          ctx.fill();
        } else {
          ctx.fillRect(-p.size / 2, -p.size / 2, p.size, p.size);
        }
        
        ctx.restore();
      }

      animationFrameId = requestAnimationFrame(updateAndDraw);
    };

    updateAndDraw();

    return () => {
      window.removeEventListener('resize', resizeCanvas);
      cancelAnimationFrame(animationFrameId);
      timers.forEach(t => clearTimeout(t));
    };
  }, []);

  // Trigger interactive explosion on badge click
  const triggerInteractiveBurst = (e: React.MouseEvent) => {
    if (triggerBurstRef.current) {
      triggerBurstRef.current(e.clientX, e.clientY, true);
    }
  };

  // Sync wallet balance
  useEffect(() => {
    if (!user || pollingStartedRef.current) return;
    pollingStartedRef.current = true;

    let isSubscribed = true;
    const initialBalance = user.balance;
    const startTime = Date.now();
    const FIVE_MINUTES_MS = 5 * 60 * 1000;
    let intervalId: NodeJS.Timeout;

    const pollBalance = async () => {
      if (!isSubscribed) return;
      try {
        const response = await api.get<ApiResponse<UserBalanceResponse>>('/users/me/balance');
        if (!isSubscribed) return;

        const latestBalance = response.data.result.balance;

        if (latestBalance !== initialBalance) {
          await refreshProfile();
          if (isSubscribed) {
            setSyncing(false);
            clearInterval(intervalId);
          }
          return;
        }

        if (Date.now() - startTime >= FIVE_MINUTES_MS) {
          console.warn('Wallet balance polling timed out after 5 minutes.');
          if (isSubscribed) {
            setSyncing(false);
            clearInterval(intervalId);
          }
        }
      } catch (error) {
        console.error('Error polling wallet balance:', error);
      }
    };

    intervalId = setInterval(pollBalance, 1000);
    pollBalance();

    return () => {
      isSubscribed = false;
      clearInterval(intervalId);
    };
  }, [user, refreshProfile]);

  return (
    <div className="relative min-h-[85vh] flex items-center justify-center overflow-hidden bg-slate-50 dark:bg-slate-950 transition-colors duration-200">
      
      {/* Canvas for Confetti / Fireworks */}
      <canvas 
        ref={canvasRef} 
        className="fixed inset-0 w-full h-full pointer-events-none z-40" 
      />

      {/* Floating Hearts in background */}
      <div className="fixed inset-0 pointer-events-none overflow-hidden z-20">
        {floatingHearts.map((heart) => (
          <motion.div
            key={heart.id}
            initial={{ y: '105vh', x: `${heart.x}vw`, scale: 0.5, opacity: 0 }}
            animate={{
              y: '-10vh',
              x: `${heart.x + Math.sin(heart.id) * 8}vw`,
              scale: [0.5, 1.2, 0.9, 1],
              opacity: [0, heart.opacity, heart.opacity, 0],
            }}
            transition={{
              duration: heart.duration,
              delay: heart.delay,
              repeat: Infinity,
              ease: 'easeInOut',
            }}
            className="absolute text-rose-500/80 dark:text-rose-500/60 fill-rose-500/30 dark:fill-rose-500/20"
            style={{ width: heart.size, height: heart.size }}
          >
            <Heart className="w-full h-full" />
          </motion.div>
        ))}
      </div>

      <div className="relative z-30 mx-auto max-w-md w-full text-center py-16 px-6">
        
        {/* Animated Glowing Success Circle with Heart (Clickable for bursts!) */}
        <div 
          onClick={triggerInteractiveBurst}
          className="relative mb-8 inline-block cursor-pointer group active:scale-95 transition-transform"
          title="Click me for more love!"
        >
          <div className="absolute inset-0 bg-rose-500/25 rounded-full blur-xl animate-pulse group-hover:bg-rose-500/35 transition-colors"></div>
          <div className="relative h-24 w-24 rounded-full bg-rose-500/10 border-2 border-rose-500/30 text-rose-500 flex items-center justify-center shadow-lg shadow-rose-500/10 group-hover:border-rose-500/50 group-hover:bg-rose-500/20 transition-all">
            <Heart className="h-12 w-12 fill-rose-500 animate-bounce group-hover:scale-110 transition-transform" />
          </div>
        </div>

        {/* Success Title */}
        <h2 className="text-3xl font-black text-slate-955 dark:text-white tracking-tight mb-3">
          {t('donate.thank_you_title')}
        </h2>
        <p className="text-sm text-slate-500 dark:text-slate-400 max-w-sm mx-auto mb-8 leading-relaxed">
          {t('donate.thank_you_desc')}
        </p>

        {/* Transaction Details Box */}
        <div className="w-full bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800/80 rounded-3xl p-6 mb-8 text-left space-y-4.5 shadow-xl select-all">
          <div className="flex justify-between text-xs font-semibold">
            <span className="text-slate-400">{t('donate.transaction_id')}</span>
            <span className="text-slate-800 dark:text-white font-mono">{orderCode}</span>
          </div>
          <div className="flex justify-between text-xs font-semibold">
            <span className="text-slate-400">{t('donate.status')}</span>
            <span className="text-rose-600 dark:text-rose-400 flex items-center space-x-1.5 font-black">
              <Sparkles className="h-4 w-4 fill-rose-500 text-rose-500 animate-pulse" />
              <span>{t('donate.success')}</span>
            </span>
          </div>
          {syncing && (
            <div className="flex justify-between text-xs font-semibold border-t border-slate-100 dark:border-slate-800/50 pt-4">
              <span className="text-slate-400">Verifying donation:</span>
              <span className="text-rose-600 dark:text-rose-455 flex items-center space-x-1.5 font-bold">
                <Loader2 className="h-3.5 w-3.5 animate-spin" />
                <span>Checking...</span>
              </span>
            </div>
          )}
        </div>

        {/* Action buttons */}
        <div className="flex flex-col sm:flex-row gap-3.5 w-full">
          <button
            onClick={() => navigate('/')}
            className="flex-1 inline-flex items-center justify-center space-x-2 px-6 py-3.5 bg-rose-600 hover:bg-rose-700 text-white rounded-2xl text-xs font-bold shadow-lg shadow-rose-600/15 hover:shadow-rose-600/25 transition-all active:scale-[0.98] cursor-pointer"
          >
            <span>{t('donate.back_home')}</span>
            <ArrowRight className="h-4 w-4" />
          </button>
          <Link
            to="/practice"
            className="flex-1 inline-flex items-center justify-center px-6 py-3.5 border border-slate-200 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-bold text-slate-600 dark:text-slate-300 rounded-2xl transition-all hover:border-slate-300 active:scale-[0.98]"
          >
            {t('navbar.practice')}
          </Link>
        </div>

      </div>
    </div>
  );
};

export default SuccessPage;
