const fs = require('fs');
const path = require('path');

const quizDir = '/Users/ngocthanh/Documents/Project/codelearning-frontend/quiz';

try {
  if (!fs.existsSync(quizDir)) {
    console.error("Directory not found:", quizDir);
    process.exit(1);
  }

  const files = fs.readdirSync(quizDir).filter(f => f.endsWith('.txt'));

  for (const file of files) {
    const filePath = path.join(quizDir, file);
    let content = fs.readFileSync(filePath, 'utf8');

    // Replace consecutive backslashes followed by a quote with a single escaped quote
    content = content.replace(/\\+\"/g, '\\"');

    // Replace consecutive backslashes followed by n/r/t with their single escaped counterparts
    content = content.replace(/\\+n/g, '\\n');
    content = content.replace(/\\+r/g, '\\r');
    content = content.replace(/\\+t/g, '\\t');

    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Cleaned backslashes in ${file}`);
  }
  console.log("All quiz files successfully cleaned.");
} catch (e) {
  console.error("Error cleaning backslashes:", e);
  process.exit(1);
}
