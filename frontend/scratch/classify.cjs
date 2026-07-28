const fs = require('fs');
const path = require('path');

const data = fs.readFileSync(path.join(__dirname, '../src/data/quizzesData.ts'), 'utf8');
const quizzesMatch = data.match(/export const QUIZZES: QuizSet\[\] = (\[[\s\S]*\]);/);
if (!quizzesMatch) {
  console.error('Failed to parse quizzesData.ts');
  process.exit(1);
}

const quizzes = JSON.parse(quizzesMatch[1]);
const hsfQuizzes = quizzes.filter(q => q.id.includes('hsf302'));

let allQuestions = [];
for (const qSet of hsfQuizzes) {
  for (const q of qSet.questions) {
    allQuestions.push({ ...q, setOrigin: qSet.id });
  }
}

console.log(`Loaded ${allQuestions.length} total questions across ${hsfQuizzes.length} sets.`);

const categorize = (q) => {
  const text = (
    q.question_title + ' ' +
    (q.option_A || '') + ' ' +
    (q.option_B || '') + ' ' +
    (q.option_C || '') + ' ' +
    (q.option_D || '') + ' ' +
    (q.explain || '')
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

  // Spring Boot keywords
  const springKeywords = [
    'spring', 'boot', 'jpa', 'autowired', 'controller', 'restcontroller',
    'service', 'repository', 'entity', 'requestmapping', 'getmapping',
    'postmapping', 'putmapping', 'deletemapping', 'dependency injection',
    'ioc', 'bean', 'crudrepository', 'jparepository', 'hibernate',
    'application.properties', 'model', 'modelandview', 'pathvariable',
    'requestparam', 'requestbody', 'responseentity', 'component',
    'configuration', 'enableautoconfiguration', 'transactional'
  ];

  const hasJavaFX = javafxKeywords.some(k => text.includes(k));
  const hasThymeleaf = thymeleafKeywords.some(k => text.includes(k));
  const hasSpring = springKeywords.some(k => text.includes(k));

  if (hasJavaFX && !hasThymeleaf) {
    return 'javafx';
  }
  if (hasThymeleaf) {
    return 'thymeleaf';
  }
  if (hasSpring) {
    return 'springboot';
  }

  return 'unknown';
};

const categorized = {
  springboot: [],
  thymeleaf: [],
  javafx: [],
  unknown: []
};

allQuestions.forEach((q) => {
  const cat = categorize(q);
  categorized[cat].push(q);
});

console.log('Results:');
console.log('Java Spring Boot:', categorized.springboot.length);
console.log('Thymeleaf:', categorized.thymeleaf.length);
console.log('JavaFX:', categorized.javafx.length);
console.log('Unknown/Uncategorized:', categorized.unknown.length);

if (categorized.unknown.length > 0) {
  console.log('\n--- Unknown questions ---');
  categorized.unknown.forEach((q, i) => {
    console.log(`[${i+1}] ${q.question_title}`);
  });
}
