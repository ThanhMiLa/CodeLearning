const fs = require('fs');
const path = require('path');

const quizDir = path.join(__dirname, '../quiz');
const outputPath = path.join(__dirname, '../src/data/quizzesData.ts');

function parseConcatJsonArrays(text) {
  let results = [];
  let bracketCount = 0;
  let startIdx = -1;
  let inString = false;
  let escape = false;

  for (let i = 0; i < text.length; i++) {
    const char = text[i];
    if (escape) {
      escape = false;
      continue;
    }
    if (char === '\\') {
      escape = true;
      continue;
    }
    if (char === '"') {
      inString = !inString;
      continue;
    }
    if (!inString) {
      if (char === '[') {
        if (bracketCount === 0) {
          startIdx = i;
        }
        bracketCount++;
      } else if (char === ']') {
        bracketCount--;
        if (bracketCount === 0 && startIdx !== -1) {
          const jsonStr = text.substring(startIdx, i + 1);
          try {
            const arr = JSON.parse(jsonStr);
            if (Array.isArray(arr)) {
              results = results.concat(arr);
            }
          } catch (e) {
            console.error("Failed to parse segment starting at " + startIdx + ":", e);
          }
          startIdx = -1;
        }
      }
    }
  }
  return results;
}

function getDescription(title) {
  const t = title.toUpperCase();
  if (t.includes('HSF302')) {
    if (t.includes('RE')) return 'Requirements Engineering Quiz';
    if (t.includes('B5FE')) return 'Working with Spring Framework Quiz';
    if (t.includes('FE')) return 'Working with Spring Framework Final Exam Quiz';
    return 'Working with Spring Framework Quiz';
  }
  if (t.includes('SWR302')) {
    if (t.includes('RE')) return 'Software Requirement Quiz';
    if (t.includes('FE')) return 'Software Requirement Final Exam Quiz';
    return 'Software Requirement Quiz';
  }
  if (t.includes('SWT')) {
    if (t.includes('RE')) return 'Software Testing Quiz';
    if (t.includes('FE')) return 'Software Testing Final Exam Quiz';
    return 'Software Testing Quiz';
  }
  return `${title} Quiz`;
}

try {
  if (!fs.existsSync(quizDir)) {
    console.error("Directory not found:", quizDir);
    process.exit(1);
  }

  function getTxtFilesRecursively(dir) {
    let results = [];
    if (!fs.existsSync(dir)) return results;
    const list = fs.readdirSync(dir, { withFileTypes: true });
    for (const entry of list) {
      const res = path.resolve(dir, entry.name);
      if (entry.isDirectory()) {
        results = results.concat(getTxtFilesRecursively(res));
      } else if (entry.isFile() && entry.name.endsWith('.txt')) {
        results.push(res);
      }
    }
    return results;
  }

  const files = getTxtFilesRecursively(quizDir).sort();

  const quizzes = [];

  const mapQuestion = (q, idx) => {
    const { explan, explain, ...rest } = q;
    const cleaned = {
      ...rest,
      question_id: idx + 1,
      explain: explain || explan || ''
    };
    for (const key in cleaned) {
      if (cleaned[key] === null) {
        delete cleaned[key];
      }
    }
    return cleaned;
  };

  for (const filePath of files) {
    const fileName = path.basename(filePath);
    const title = fileName.replace('.txt', '').trim();
    // Normalize id: lowercase, replace & with and, replace spaces and hyphens with single hyphens, strip invalid URL chars
    const id = title.toLowerCase().replace(/&/g, 'and').replace(/\s*-\s*/g, '-').replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '');
    
    const content = fs.readFileSync(filePath, 'utf8');
    const rawQuestions = parseConcatJsonArrays(content);
    const questions = rawQuestions.map(mapQuestion);

    console.log(`Parsed & normalized ${questions.length} questions from ${title}`);

    quizzes.push({
      id,
      title,
      description: getDescription(title),
      questionsCount: questions.length,
      questions
    });
  }

  // Auto-generate swr302-all-unique set by combining all SWR302 module questions
  const swr302Modules = quizzes.filter(q => q.id.includes('swr302-module'));
  if (swr302Modules.length > 0) {
    swr302Modules.sort((a, b) => {
      const matchA = (a.id + ' ' + a.title).match(/module[^\d]*(\d+)/i);
      const matchB = (b.id + ' ' + b.title).match(/module[^\d]*(\d+)/i);
      const numA = matchA ? parseInt(matchA[1], 10) : 99;
      const numB = matchB ? parseInt(matchB[1], 10) : 99;
      return numA - numB;
    });

    const allSwr302Questions = [];
    let qCounter = 1;
    for (const mod of swr302Modules) {
      for (const q of mod.questions) {
        allSwr302Questions.push({
          ...q,
          question_id: qCounter++
        });
      }
    }

    quizzes.push({
      id: 'swr302-all-unique',
      title: `Full Question List (All ${allSwr302Questions.length} Unique Questions)`,
      description: 'Software Requirement Full Questions Set',
      questionsCount: allSwr302Questions.length,
      questions: allSwr302Questions
    });
    console.log(`Generated swr302-all-unique master set with ${allSwr302Questions.length} questions`);
  }

  // Sort quizzes: year descending (26 > 25), then semester descending (FA > SU > SP)
  function getSortKey(title) {
    const match = title.match(/(FA|SU|SP)(\d{2})/i);
    if (match) {
      const sem = match[1].toUpperCase();
      const yr = parseInt(match[2], 10);
      const semVal = sem === 'FA' ? 3 : sem === 'SU' ? 2 : sem === 'SP' ? 1 : 0;
      return { year: yr, semesterVal: semVal };
    }
    return { year: 0, semesterVal: 0 };
  }

  quizzes.sort((a, b) => {
    const keyA = getSortKey(a.title);
    const keyB = getSortKey(b.title);

    if (keyA.year !== keyB.year) {
      return keyB.year - keyA.year; // Higher year first (26 before 25)
    }
    if (keyA.semesterVal !== keyB.semesterVal) {
      return keyB.semesterVal - keyA.semesterVal; // FA (3) > SU (2) > SP (1)
    }
    return a.title.localeCompare(b.title);
  });

  // Create src/data directory if it does not exist
  const outputDir = path.dirname(outputPath);
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  // Write TS file
  const tsContent = `// Automatically generated from quiz source txt files
export interface QuizQuestion {
  question_id: number;
  question_title: string;
  option_A: string;
  option_B: string;
  option_C?: string;
  option_D?: string;
  option_E?: string;
  option_F?: string;
  correct_anwser: string; // matches raw data key 'correct_anwser'
  explain: string;
}

export interface QuizSet {
  id: string;
  title: string;
  description: string;
  questionsCount: number;
  questions: QuizQuestion[];
}

export const QUIZZES: QuizSet[] = ${JSON.stringify(quizzes, null, 2)};
`;

  fs.writeFileSync(outputPath, tsContent, 'utf8');
  console.log(`Successfully compiled and wrote quizzes to ${outputPath}`);
} catch (e) {
  console.error('Error parsing or writing quizzes:', e);
  process.exit(1);
}
