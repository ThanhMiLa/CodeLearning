import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import translationEN from './locales/en.json';
import translationVI from './locales/vi.json';

// Get saved language from localStorage or default to 'en'
const savedLanguage = localStorage.getItem('lng') || 'en';

// Resource bundles
const resources = {
  en: {
    translation: translationEN,
  },
  vi: {
    translation: translationVI,
  },
};

i18n
  .use(initReactI18next) // passes i18n down to react-i18next
  .init({
    resources,
    lng: savedLanguage,
    fallbackLng: 'en',
    interpolation: {
      escapeValue: false, // react already safes from xss
    },
  });

// Automatically sync language changes to localStorage
i18n.on('languageChanged', (lng) => {
  localStorage.setItem('lng', lng);
});

export default i18n;
