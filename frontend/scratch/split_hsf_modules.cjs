const fs = require('fs');
const path = require('path');

const dataPath = path.join(__dirname, '../src/data/quizzesData.ts');
const quizDir = path.join(__dirname, '../quiz/HSF302');

if (!fs.existsSync(quizDir)) {
  fs.mkdirSync(quizDir, { recursive: true });
}

const data = fs.readFileSync(dataPath, 'utf8');
const quizzesMatch = data.match(/export const QUIZZES: QuizSet\[\] = (\[[\s\S]*\]);/);
if (!quizzesMatch) {
  console.error('Failed to parse quizzesData.ts');
  process.exit(1);
}

const quizzes = JSON.parse(quizzesMatch[1]);
const hsfQuizzes = quizzes.filter(q => q.id.includes('hsf302'));

let allRawQuestions = [];
for (const qSet of hsfQuizzes) {
  for (const q of qSet.questions) {
    allRawQuestions.push(q);
  }
}

console.log(`Loaded ${allRawQuestions.length} total questions from quizzesData.ts.`);

const categorize = (q) => {
  const text = (
    (q.question_title || '') + ' ' +
    (q.option_A || '') + ' ' +
    (q.option_B || '') + ' ' +
    (q.option_C || '') + ' ' +
    (q.option_D || '') + ' ' +
    (q.explan || q.explain || '')
  ).toLowerCase();

  // JavaFX keywords
  const javafxKeywords = [
    'javafx', 'fxml', 'stage', 'scene', 'tableview', 'observablelist',
    'actionevent', 'anchorpane', 'vbox', 'hbox', 'gridpane', 'borderpane',
    '@fxml', 'application.launch', 'primarystage', 'node', 'control',
    'label', 'textfield', 'button', 'alert', 'combobox', 'listview',
    'treeview', 'checkbox', 'radiobutton', 'toggleview', 'canvas'
  ];

  // Thymeleaf keywords
  const thymeleafKeywords = [
    'thymeleaf', 'th:', 'th;', 'th-', 'template engine', 'th:text', 'th:each',
    'th:field', 'th:object', 'th:href', 'th:action', 'th:if', 'th:unless',
    'th:src', 'th:value', 'th:style', 'th:replace', 'th:include', 'th:insert',
    '${', '*{', '#{', '@{', 'dialect', 'web context', 'html5', 'template'
  ];

  if (javafxKeywords.some(k => text.includes(k))) {
    return 'javafx';
  }
  if (thymeleafKeywords.some(k => text.includes(k))) {
    return 'thymeleaf';
  }

  // Default to Java Spring Boot
  return 'springboot';
};

const modules = {
  'HSF302 - Module 1 - Java Spring Boot.txt': [],
  'HSF302 - Module 2 - Thymeleaf.txt': [],
  'HSF302 - Module 3 - JavaFX.txt': []
};

allRawQuestions.forEach(q => {
  const cat = categorize(q);
  if (cat === 'springboot') {
    modules['HSF302 - Module 1 - Java Spring Boot.txt'].push(q);
  } else if (cat === 'thymeleaf') {
    modules['HSF302 - Module 2 - Thymeleaf.txt'].push(q);
  } else if (cat === 'javafx') {
    modules['HSF302 - Module 3 - JavaFX.txt'].push(q);
  }
});

console.log('Module breakdown:');
for (const [file, questions] of Object.entries(modules)) {
  console.log(`- ${file}: ${questions.length} questions`);
}

// Save the new module files
for (const [file, questions] of Object.entries(modules)) {
  const formatted = questions.map((q, idx) => ({
    ...q,
    question_id: idx + 1
  }));
  const targetPath = path.join(quizDir, file);
  fs.writeFileSync(targetPath, JSON.stringify(formatted, null, 2), 'utf8');
  console.log(`Wrote ${formatted.length} questions to ${targetPath}`);
}

console.log('Finished splitting HSF302 into 3 modules successfully!');
