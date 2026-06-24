import fs from 'fs';
import path from 'path';

const quizDir = '/Users/ngocthanh/Documents/Project/codelearning-frontend/quiz';

if (!fs.existsSync(quizDir)) {
  console.error("Directory not found:", quizDir);
  process.exit(1);
}

const files = fs.readdirSync(quizDir).filter(f => f.endsWith('.txt'));

const keys = [
  "question_id",
  "question_title",
  "option_A",
  "option_B",
  "option_C",
  "option_D",
  "option_E",
  "option_F",
  "correct_anwser",
  "explan",
  "explain"
];

function extractKeyValue(block, key) {
  const prefix = `"${key}": "`;
  const startIdx = block.indexOf(prefix);
  if (startIdx === -1) {
    // Check if it's integer like question_id
    const intPrefix = `"${key}":`;
    const intStartIdx = block.indexOf(intPrefix);
    if (intStartIdx === -1) return null;
    const rest = block.substring(intStartIdx + intPrefix.length).trim();
    const commaIdx = rest.indexOf(',');
    const val = commaIdx === -1 ? rest : rest.substring(0, commaIdx);
    return parseInt(val.trim(), 10);
  }
  
  const contentStart = startIdx + prefix.length;
  let nextBoundaryIdx = block.length;
  
  for (const k of keys) {
    if (k === key) continue;
    const idx1 = block.indexOf(`"${k}":`, contentStart);
    if (idx1 !== -1 && idx1 < nextBoundaryIdx) {
      nextBoundaryIdx = idx1;
    }
  }
  
  let valueText = block.substring(contentStart, nextBoundaryIdx).trim();
  
  if (valueText.endsWith('}')) {
    valueText = valueText.substring(0, valueText.length - 1).trim();
  }
  if (valueText.endsWith(',')) {
    valueText = valueText.substring(0, valueText.length - 1).trim();
  }
  if (valueText.endsWith('"')) {
    valueText = valueText.substring(0, valueText.length - 1);
  }
  
  return valueText;
}

for (const file of files) {
  const filePath = path.join(quizDir, file);
  console.log(`Processing: ${file}`);
  const content = fs.readFileSync(filePath, 'utf8');

  // Find all question blocks. A question block is between { and }
  let blocks = [];
  let braceCount = 0;
  let startIdx = -1;

  for (let i = 0; i < content.length; i++) {
    const char = content[i];
    if (char === '{') {
      if (braceCount === 0) {
        startIdx = i;
      }
      braceCount++;
    } else if (char === '}') {
      braceCount--;
      if (braceCount === 0 && startIdx !== -1) {
        blocks.push(content.substring(startIdx, i + 1));
        startIdx = -1;
      }
    }
  }

  if (blocks.length === 0) {
    console.log(`No blocks found in ${file}, skipping.`);
    continue;
  }

  const cleanedQuestions = [];
  for (const block of blocks) {
    const qObj = {};
    for (const key of keys) {
      const val = extractKeyValue(block, key);
      if (val !== null && val !== undefined) {
        qObj[key] = val;
      }
    }
    cleanedQuestions.push(qObj);
  }

  console.log(`Successfully extracted ${cleanedQuestions.length} questions from ${file}`);

  // Group into arrays of 10 questions to match original format
  const groups = [];
  for (let i = 0; i < cleanedQuestions.length; i += 10) {
    groups.push(cleanedQuestions.slice(i, i + 10));
  }

  let newFileContent = "";
  for (let i = 0; i < groups.length; i++) {
    newFileContent += JSON.stringify(groups[i], null, 2);
    if (i < groups.length - 1) {
      newFileContent += "\n\n";
    }
  }

  fs.writeFileSync(filePath, newFileContent, 'utf8');
  console.log(`Cleaned and wrote valid JSON back to ${file}`);
}
console.log("All files cleaned successfully.");
