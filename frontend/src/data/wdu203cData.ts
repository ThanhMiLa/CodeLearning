import type { QuizSet } from './quizzesData';

export const WDU203C_QUIZZES: QuizSet[] = [
  {
    "id": "wdu203c-random-exam",
    "title": "Random 50-Question Mock Exam",
    "description": "Bộ đề thi thử ngẫu nhiên 50 câu (mô phỏng đề thi thật gồm Single Choice, Multi-Choice và True/False).",
    "questionsCount": 50,
    "questions": []
  },
  {
    "id": "wdu203c-module-1-single-choice",
    "title": "Module 1 - Single Choice",
    "description": "Tập hợp 254 câu hỏi trắc nghiệm chọn 1 đáp án đúng duy nhất (đã loại bỏ trùng lặp).",
    "questionsCount": 254,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which of the following is NOT an element of a typical scenario?",
        "option_A": "Agent",
        "option_B": "Actions",
        "correct_anwser": "C",
        "explain": "Các yếu tố cấu thành một kịch bản (scenario) điển hình thường gồm: tác nhân (Agent), mục tiêu (Goals), hành động (Actions), và sự kiện (Events); còn \"Location\" (vị trí) không phải là một thành phần chính thức bắt buộc trong cấu trúc scenario, nên đáp án C đúng.",
        "option_C": "Location",
        "option_D": "Goals",
        "option_E": "Events"
      },
      {
        "question_id": 2,
        "question_title": "Which of the following is not a characteristic of hi-fi prototypes?",
        "option_A": "They are more resource-intensive to develop",
        "option_B": "They can be run by the tester without help",
        "correct_anwser": "C",
        "explain": "Prototype độ trung thực cao (hi-fi) thường rất hữu ích để kiểm thử usability vì gần giống sản phẩm thật; ngược lại chính prototype lo-fi mới có giá trị hạn chế hơn cho việc kiểm thử usability chi tiết, nên đáp án C là đặc điểm KHÔNG đúng với hi-fi prototype.",
        "option_C": "They are of limited usefulness for testing usability",
        "option_D": "They can be used as a part of the spec given to developers"
      },
      {
        "question_id": 3,
        "question_title": "According to Wikipedia, a \"direct manipulation interface\" is one that features \"continuous representation of objects of interest and rapid, reversible, and incremental actions and feedback.\" The \"continuous representation of objects of interest\" is best aligned with which principle of good UI design?",
        "option_A": "Prevent errors before they happen",
        "option_B": "Support recognition over recall",
        "correct_anwser": "B",
        "explain": "Việc hiển thị liên tục các đối tượng quan tâm giúp người dùng luôn nhìn thấy trạng thái hiện tại của hệ thống mà không cần phải nhớ lại (recall) thông tin, phù hợp với nguyên tắc \"hỗ trợ nhận diện hơn là ghi nhớ\" (recognition over recall), nên đáp án B đúng.",
        "option_C": "Employ aesthetic and minimalist design",
        "option_D": "Support user control and freedom"
      },
      {
        "question_id": 4,
        "question_title": "If a user of a system is unable to determine whether an action they took helped to move them closer to achieving their goal, we would say that the system fails to bridge:",
        "option_A": "The Gulf of Inspection",
        "option_B": "The Gulf of Expectation",
        "correct_anwser": "D",
        "explain": "Theo mô hình của Norman, \"Gulf of Evaluation\" (khoảng cách đánh giá) là khoảng cách giữa trạng thái hệ thống và khả năng người dùng diễn giải, đánh giá xem hành động của họ có giúp đạt được mục tiêu hay không; khi người dùng không thể xác định điều này, hệ thống đã thất bại trong việc thu hẹp khoảng cách này, nên đáp án D đúng.",
        "option_C": "The Gulf of Execution",
        "option_D": "The Gulf of Evaluation"
      },
      {
        "question_id": 5,
        "question_title": "Which of the following does NOT impact the likelihood that something in long-term memory will be recalled?",
        "option_A": "Strength of association",
        "option_B": "Frequency of use",
        "correct_anwser": "D",
        "explain": "Khả năng nhớ lại (recall) một thông tin trong trí nhớ dài hạn phụ thuộc vào độ mạnh của liên kết, tần suất sử dụng, và mức độ gần đây được sử dụng; còn tính chính xác của thông tin (accuracy) không liên quan đến khả năng nhớ lại nó, nên đáp án D đúng.",
        "option_C": "Recency of use",
        "option_D": "Accuracy of information"
      },
      {
        "question_id": 6,
        "question_title": "Which of the following is not part of a typical UX design process?",
        "option_A": "Understanding the problem",
        "option_B": "Generating possible solutions",
        "correct_anwser": "C",
        "explain": "Quy trình thiết kế UX điển hình gồm hiểu vấn đề, tạo giải pháp, và đánh giá prototype để tìm vấn đề mới; việc định giá bán sản phẩm là công việc thuộc về kinh doanh/marketing, không phải một phần của quy trình thiết kế UX, nên đáp án C đúng.",
        "option_C": "Establishing the sale price for a product",
        "option_D": "Assessing prototypes and finding new problems"
      },
      {
        "question_id": 7,
        "question_title": "By helping users form effective ________, we can help users to predict the results of actions they haven't yet performed using a system.",
        "option_A": "System images",
        "option_B": "Assumptions",
        "correct_anwser": "D",
        "explain": "Mô hình khái niệm (conceptual model) mà người dùng hình thành trong đầu giúp họ dự đoán kết quả của các hành động chưa thực hiện, dựa trên hiểu biết về cách hệ thống hoạt động, nên đáp án D đúng.",
        "option_C": "Feedback",
        "option_D": "Conceptual models"
      },
      {
        "question_id": 8,
        "question_title": "According to the original research on short-term memory, how many \"items\" can a person retain in short-term memory at one time?",
        "option_A": "One or two",
        "option_B": "About 7",
        "correct_anwser": "B",
        "explain": "Theo nghiên cứu nổi tiếng của George Miller (\"The Magical Number Seven, Plus or Minus Two\"), trí nhớ ngắn hạn của con người có thể lưu giữ khoảng 7 (±2) đơn vị thông tin cùng lúc, nên đáp án B đúng.",
        "option_C": "About 10",
        "option_D": "There is no measurable limit"
      },
      {
        "question_id": 9,
        "question_title": "Brainstorming, morphological analysis, and \"the worst idea\" are examples of what kind of technique?",
        "option_A": "Ideation",
        "option_B": "Lo-fi prototyping",
        "correct_anwser": "A",
        "explain": "Brainstorming, phân tích hình thái học (morphological analysis), và kỹ thuật \"ý tưởng tồi nhất\" đều là các phương pháp phát sinh ý tưởng (ideation techniques) nhằm tạo ra nhiều giải pháp khả thi, nên đáp án A đúng.",
        "option_C": "Convergence",
        "option_D": "Poor"
      },
      {
        "question_id": 10,
        "question_title": "Which of the following is the MOST TRUE about social exchange theory?",
        "option_A": "People consider the economic value to themselves of any given social exchange.",
        "option_B": "People think about the risk to themselves primarily in considering social exchanges.",
        "correct_anwser": "D",
        "explain": "Thuyết trao đổi xã hội (social exchange theory) cho rằng con người dựa vào mức độ tin tưởng (trust) để ước lượng chi phí/lợi ích của một cuộc trao đổi xã hội, vì họ không thể biết chính xác kết quả trước khi thực hiện, nên đáp án D đúng.",
        "option_C": "People are really bad at guessing the cost/benefit of any given social exchange.",
        "option_D": "People use trust as a basis to make a cost/benefit guess on the value of a social exchange."
      },
      {
        "question_id": 11,
        "question_title": "Which of the following is LEAST true about extrinsic, or material incentives?",
        "option_A": "You should frame incentives as gifts, not as payment.",
        "option_B": "Incentives given *before* the survey are more effective.",
        "correct_anwser": "C",
        "explain": "Nghiên cứu cho thấy mối quan hệ giữa số tiền thưởng và tỷ lệ tham gia không hoàn toàn tuyến tính (có hiệu ứng giảm dần và các yếu tố tâm lý khác chi phối), nên khẳng định \"càng nhiều tiền càng nhiều người tham gia\" là điều ÍT ĐÚNG nhất trong các lựa chọn, nên đáp án C đúng.",
        "option_C": "The more money you offer, the more likely people are to participate.",
        "option_D": "Lotteries (a chance to win a larger reward) are not very effective as incentives."
      },
      {
        "question_id": 12,
        "question_title": "Which of the following are among key tasks that were identified?",
        "option_A": "Check map, Help, Activate function \"Robbery\"",
        "option_B": "Check map, Create a post, Log Out",
        "correct_anwser": "A",
        "explain": "Đối chiếu với bảng key tasks đã liệt kê, cả ba mục \"Check map\", \"Help\", và \"Activate function Robbery\" đều xuất hiện trong danh sách các nhiệm vụ chính (mục 4, 8, 11); các đáp án khác đều chứa mục không có trong bảng như \"Create a post\" hoặc \"Log Out\", nên đáp án A đúng.",
        "option_C": "Customize automatic functions, Help, Log Out",
        "option_D": "Change security code, Create a post, Check recent events"
      },
      {
        "question_id": 13,
        "question_title": "Finding 1: No Option to delete or modify Time Sheet entries. What heuristic does this violate?",
        "option_A": "User control and freedom",
        "option_B": "Error prevention",
        "correct_anwser": "A",
        "explain": "Việc không cho phép người dùng chỉnh sửa hoặc xóa mục đã nhập, không có cách để \"UNDO\" hoặc sửa lỗi, chính là vi phạm nguyên tắc \"User control and freedom\" (quyền kiểm soát và tự do của người dùng) trong Heuristic Evaluation của Nielsen, nên đáp án A đúng.",
        "option_C": "Visibility of system status",
        "option_D": "Recognition vs recall"
      },
      {
        "question_id": 14,
        "question_title": "Which of the following is NOT something to think about if you are going to use Amazon's Mechanical Turk to recruit respondents?",
        "option_A": "How to pay a fair wage to Turkers",
        "option_B": "The shakiness of the demographic data about Turkers",
        "correct_anwser": "D",
        "explain": "Khi dùng Mechanical Turk, các vấn đề cần cân nhắc bao gồm: trả công công bằng, tính không chắc chắn của dữ liệu nhân khẩu học, và kiểm tra độ hợp lệ của câu trả lời (vì nhiều Turker làm khảo sát chỉ để lấy tiền); còn tỷ lệ phản hồi (response rate) không phải là mối quan tâm đặc thù đáng lo ngại với nền tảng này (vì nguồn cung người làm luôn dồi dào), nên đáp án D đúng.",
        "option_C": "How to check for the validity of responses",
        "option_D": "Response rates for Turkers"
      },
      {
        "question_id": 15,
        "question_title": "Is this a good scope for a user test? (Scope: Report an event, Check the map, Protect themselves in case of robbery)",
        "option_A": "Yes, it has users test the core functions of the app",
        "option_B": "No, a user test needs to include testing every single task in the application to deliver valuable data",
        "correct_anwser": "A",
        "explain": "Phạm vi kiểm thử này tập trung vào các chức năng được sử dụng thường xuyên nhất và cốt lõi của ứng dụng, đây là cách tiếp cận hợp lý và hiệu quả cho một user test, không cần thiết phải kiểm tra mọi tác vụ hay chỉ giới hạn ở một tác vụ duy nhất, nên đáp án A đúng.",
        "option_C": "No, a user test must focus on only one task",
        "option_D": "No, a user test needs to compare two different systems"
      },
      {
        "question_id": 16,
        "question_title": "Which of the following is most accurate?",
        "option_A": "Surveys are good at broad descriptions of groups, but not at precise measurements.",
        "option_B": "Surveys have largely been abandoned in modern research because they are so inaccurate.",
        "correct_anwser": "A",
        "explain": "Khảo sát (surveys) phù hợp để mô tả tổng quan về xu hướng, thái độ của một nhóm lớn người dùng, nhưng không chính xác trong việc đo lường hành vi cụ thể hay các kết quả chi tiết, nên đáp án A đúng.",
        "option_C": "Surveys should never be combined with other types of methods.",
        "option_D": "Surveys are good at measuring behavioral outcomes."
      },
      {
        "question_id": 17,
        "question_title": "Which of the following best describes why you might choose to use a panel for recruiting respondents?",
        "option_A": "To reduce recruitment costs",
        "option_B": "To make sure you get people who are experienced in answering surveys",
        "correct_anwser": "A",
        "explain": "Sử dụng panel (nhóm người tham gia đã đăng ký sẵn) giúp tiết kiệm đáng kể thời gian và chi phí tuyển dụng người tham gia khảo sát, vì nhà nghiên cứu không cần tìm kiếm và mời từng người mới mỗi lần thực hiện nghiên cứu.",
        "option_C": "To increase quality",
        "option_D": "To avoid having a convenience sample"
      },
      {
        "question_id": 18,
        "question_title": "Which of the following is the best definition of a probability sample?",
        "option_A": "Almost every member of your population has some chance to be selected for the survey.",
        "option_B": "Only those people who will probably answer the survey are sampled from the population.",
        "correct_anwser": "C",
        "explain": "Mẫu xác suất (probability sample) được định nghĩa là mẫu trong đó mọi thành viên của tổng thể đều có một cơ hội (xác suất) nhất định để được chọn tham gia khảo sát, đảm bảo tính đại diện và có thể suy rộng kết quả, nên đáp án C đúng.",
        "option_C": "Every member of your population has some chance to be selected for the survey.",
        "option_D": "You invite every member of the population to participate in the survey."
      },
      {
        "question_id": 19,
        "question_title": "Conducting an actual semi-structured interview is most consistently like which of the following activities?",
        "option_A": "Golf, because negative events can affect your performance.",
        "option_B": "Driving, because you have to navigate adversarial situations.",
        "correct_anwser": "C",
        "explain": "Phỏng vấn bán cấu trúc đòi hỏi người phỏng vấn phải linh hoạt điều chỉnh câu hỏi theo diễn biến cuộc trò chuyện, tương tự như việc ứng biến khi chơi nhạc jazz, nên đáp án C đúng.",
        "option_C": "Playing jazz, because improvisation is required.",
        "option_D": "Running a marathon, because it is exhausting."
      },
      {
        "question_id": 20,
        "question_title": "Which of the following are techniques that might be used in qualitative data analysis?\nI. Clustering\nII. Running a statistical regression\nIII. Finding patterns",
        "option_A": "I only",
        "option_B": "III only",
        "correct_anwser": "C",
        "explain": "Phân tích dữ liệu định tính thường sử dụng các kỹ thuật như phân cụm (clustering) và tìm kiếm mẫu hình (finding patterns); còn chạy hồi quy thống kê (statistical regression) là kỹ thuật thuộc về phân tích định lượng, không phải định tính, nên đáp án C đúng.",
        "option_C": "I and III",
        "option_D": "I, II and III"
      },
      {
        "question_id": 21,
        "question_title": "In which of the following contexts can you use qualitative data analysis?\nI. Understanding user needs\nII. Making sense of non-quantitative data\nIII. Condensing complex information",
        "option_A": "I only",
        "option_B": "I and II",
        "correct_anwser": "D",
        "explain": "Phân tích dữ liệu định tính có thể áp dụng trong nhiều bối cảnh: hiểu nhu cầu người dùng, diễn giải dữ liệu phi định lượng, và cô đọng thông tin phức tạp thành các insight dễ hiểu, nên đáp án đúng là D (cả ba).",
        "option_C": "I and III",
        "option_D": "I, II, and III"
      },
      {
        "question_id": 22,
        "question_title": "Which of the following should you aim for when arranging interviews?\nI. The participant should be a user or potential user of the product or service.\nII. The interview should be held where the product or service would normally be used.\nIII. The time should be when the product or service would normally be used.",
        "option_A": "I and II",
        "option_B": "I and III",
        "correct_anwser": "D",
        "explain": "Khi sắp xếp phỏng vấn, nên đảm bảo cả ba yếu tố: người tham gia là người dùng thực tế/tiềm năng, địa điểm phỏng vấn giống với bối cảnh sử dụng thực tế, và thời gian phỏng vấn trùng với thời điểm sản phẩm/dịch vụ thường được sử dụng, để thu được thông tin chân thực nhất, nên đáp án D đúng.",
        "option_C": "II and III",
        "option_D": "I, II and III"
      },
      {
        "question_id": 23,
        "question_title": "Which of the following tasks is most representative of the kind of work involved in qualitative research?",
        "option_A": "Conducting interviews about how people use Excel spreadsheets",
        "option_B": "Analyzing statistical data about visits to Amazon",
        "correct_anwser": "A",
        "explain": "Nghiên cứu định tính đặc trưng bởi các phương pháp như phỏng vấn để hiểu sâu hành vi, suy nghĩ của người dùng; các lựa chọn còn lại (phân tích số liệu thống kê, viết phần mềm phân loại, chạy thử nghiệm A/B) đều thuộc về nghiên cứu định lượng, nên đáp án A đúng.",
        "option_C": "Writing software to classify user posts on Facebook",
        "option_D": "Running an experimental trial to see if users like Google with banner ads"
      },
      {
        "question_id": 24,
        "question_title": "Which of the following is a BAD question to ask during a user needs assessment interview?",
        "option_A": "Could you tell me about a recent time when you used the \"undo\" feature?",
        "option_B": "Tell me more -- what was the context when you used the \"undo\" feature?",
        "correct_anwser": "D",
        "explain": "Câu hỏi D mang tính dẫn dắt (leading question) vì nó đã tự đưa ra giả định về nguyên nhân (do người dùng không biết tính năng undo), khiến người trả lời dễ bị định hướng thay vì tự do chia sẻ suy nghĩ thật, nên đây là câu hỏi KHÔNG tốt trong phỏng vấn, đáp án D đúng.",
        "option_C": "What functionality would you have liked to have to complete the task?",
        "option_D": "Was it because you didn't know about the \"undo\" feature that you were unable to complete the task?"
      },
      {
        "question_id": 25,
        "question_title": "What is the value of having an overarching question in an interview protocol?",
        "option_A": "It provides a focus for the interview that the interviewer keeps in mind throughout the interview.",
        "option_B": "It serves as a catch-all question to ask at the end of an interview.",
        "correct_anwser": "A",
        "explain": "Câu hỏi bao quát (overarching question) trong đề cương phỏng vấn giúp người phỏng vấn luôn giữ trọng tâm và mục tiêu chính xuyên suốt cuộc phỏng vấn, định hướng các câu hỏi chi tiết khác xoay quanh nó, nên đáp án A đúng.",
        "option_C": "It is a good opening question to ask during the interview.",
        "option_D": "It is a good way to elicit a summary of the interview participant's thoughts."
      },
      {
        "question_id": 26,
        "question_title": "At what point in a product or service's life-cycle should one conduct a user needs assessment?\nI. Before designing a new product or service.\nII. Before considering a re-design of an existing product or service.\nIII. Just before releasing a new product or service that has already been designed.",
        "option_A": "I only",
        "option_B": "II only",
        "correct_anwser": "C",
        "explain": "Đánh giá nhu cầu người dùng nên được thực hiện trước khi thiết kế sản phẩm mới hoặc trước khi tái thiết kế sản phẩm hiện có, để định hướng đúng cho quá trình thiết kế; thực hiện ngay trước khi phát hành sản phẩm đã thiết kế xong thì đã quá muộn để điều chỉnh, nên đáp án C đúng.",
        "option_C": "I and II",
        "option_D": "II and III"
      },
      {
        "question_id": 27,
        "question_title": "Which of the following is the MOST TRUE statement?",
        "option_A": "It can be hard to operationalize abstract concepts in a way that every respondent understands.",
        "option_B": "The best way to start a survey is by writing some questions, and then iterating on them.",
        "correct_anwser": "A",
        "explain": "Việc chuyển hóa các khái niệm trừu tượng (như \"hài lòng\", \"dễ sử dụng\") thành câu hỏi cụ thể mà mọi người trả lời đều hiểu theo cùng một nghĩa là một thách thức thực sự trong thiết kế khảo sát, nên đây là phát biểu đúng nhất, đáp án A.",
        "option_C": "People are very consistent in how they answer questions over time.",
        "option_D": "Pre-testing a survey is rarely worth the time it takes."
      },
      {
        "question_id": 28,
        "question_title": "Which of the following is NOT a reason to randomize your response categories in a nominal survey question?",
        "option_A": "Anchoring",
        "option_B": "Primacy",
        "correct_anwser": "D",
        "explain": "Việc ngẫu nhiên hóa thứ tự các lựa chọn trả lời nhằm giảm thiểu hiệu ứng thiên lệch như neo đậu (anchoring), hiệu ứng thứ tự đầu (primacy) và hiệu ứng thứ tự cuối (recency); còn \"gánh nặng nhận thức\" (cognitive burden) không phải là lý do trực tiếp để ngẫu nhiên hóa thứ tự, nên đáp án D đúng.",
        "option_C": "Recency",
        "option_D": "Cognitive burden"
      },
      {
        "question_id": 29,
        "question_title": "What type of question is the following survey question: How much do you like or dislike participating in surveys? (Extremely like → Extremely dislike, 5 options)",
        "option_A": "Bipolar ordinal",
        "option_B": "Unipolar ordinal",
        "correct_anwser": "A",
        "explain": "Câu hỏi này có thang đo thứ bậc với hai cực đối lập nhau (thích - không thích) và điểm trung lập ở giữa, đây là đặc trưng của thang đo lưỡng cực có thứ bậc (bipolar ordinal), nên đáp án A đúng.",
        "option_C": "Nominal",
        "option_D": "Open-ended"
      },
      {
        "question_id": 30,
        "question_title": "Effective ways of delivering findings to stakeholders include:\nI. Anecdotes of critical moments\nII. Retelling what happened during each session of a usability test\nIII. Having stakeholders attend study sessions and participating in analysing or interpreting data\nIV. Quotes or videos of critical moments",
        "option_A": "I",
        "option_B": "II",
        "correct_anwser": "D",
        "explain": "Các cách hiệu quả để truyền đạt kết quả cho các bên liên quan bao gồm: kể lại các câu chuyện/khoảnh khắc quan trọng, mời stakeholders tham gia trực tiếp vào buổi nghiên cứu, và sử dụng trích dẫn/video minh họa; còn việc kể lại chi tiết từng phiên kiểm thử (retelling mỗi session) thường dài dòng, kém hiệu quả hơn, nên đáp án D đúng.",
        "option_C": "II, IV",
        "option_D": "I, III, IV"
      },
      {
        "question_id": 31,
        "question_title": "Which of the following is NOT a best practice for writing open-ended questions?",
        "option_A": "Use an open-ended question after every closed-ended question.",
        "option_B": "Use neutral probes when possible.",
        "correct_anwser": "D",
        "explain": "Một thực hành tốt của câu hỏi mở là để người trả lời tự do diễn đạt mà không bị gợi ý trước; việc chỉ định sẵn loại câu trả lời mong muốn ngay trong câu hỏi (question stem) sẽ làm mất đi tính mở và có thể dẫn dắt câu trả lời, nên đây KHÔNG phải là thực hành tốt, đáp án D đúng.",
        "option_C": "Provide extra motivation to respond.",
        "option_D": "Specify the response wanted in the question stem."
      },
      {
        "question_id": 32,
        "question_title": "When is it most appropriate to conduct remote moderated testing?\nI. Redirection and discussion are required\nII. Users can complete tasks without instruction\nIII. Finding participants local to your lab is challenging\nIV. You want to see and explore user's digital contexts",
        "option_A": "I, II, III",
        "option_B": "I, IV",
        "correct_anwser": "D",
        "explain": "Kiểm thử từ xa có điều phối (remote moderated testing) phù hợp khi cần trao đổi/định hướng trực tiếp (I), khi khó tìm người tham gia gần phòng lab (III), và khi muốn khám phá bối cảnh số hóa thực tế của người dùng (IV); còn việc người dùng có thể tự hoàn thành nhiệm vụ mà không cần hướng dẫn (II) lại phù hợp hơn với kiểm thử không điều phối (unmoderated), nên đáp án D đúng.",
        "option_C": "I, III",
        "option_D": "I, III, IV"
      },
      {
        "question_id": 33,
        "question_title": "What is the main problem with the following survey question? \"How likely are you to participate in an online course in the future?\" [Very likely] [Somewhat likely] [Neutral] [Somewhat unlikely] [Very unlikely]",
        "option_A": "The response categories don't match the question stem.",
        "option_B": "The question stem doesn't include both poles of the scale.",
        "correct_anwser": "B",
        "explain": "Câu hỏi chỉ hỏi \"how likely\" (một chiều - khả năng xảy ra) nhưng thang đo trả lời lại có cả hai cực đối lập (likely/unlikely) mà phần thân câu hỏi (question stem) không thể hiện rõ cả hai cực đó, gây khó hiểu cho người trả lời, nên đáp án B đúng.",
        "option_C": "This should be framed as a unipolar scale.",
        "option_D": "There's nothing wrong with this question."
      },
      {
        "question_id": 34,
        "question_title": "What does the System Usability Scale measure?",
        "option_A": "Perceived usability",
        "option_B": "Number of tasks successfully completed",
        "correct_anwser": "A",
        "explain": "System Usability Scale (SUS) là một bảng câu hỏi tiêu chuẩn dùng để đo lường cảm nhận chủ quan của người dùng về tính khả dụng (perceived usability) của một hệ thống, chứ không đo các chỉ số khách quan như số lỗi hay số tác vụ hoàn thành, nên đáp án A đúng.",
        "option_C": "Frequency of errors",
        "option_D": "Number of usability principles violated"
      },
      {
        "question_id": 35,
        "question_title": "Which of the following is an example of a good use of a post-test questionnaire?",
        "option_A": "Asking open-ended questions where participants can give any answer that comes to mind",
        "option_B": "Asking follow-up questions to understand why participants gave answers that they did",
        "correct_anwser": "C",
        "explain": "Bảng câu hỏi sau kiểm thử (post-test questionnaire) thường dùng các thang đo chuẩn hóa để thu thập số liệu định lượng về cảm nhận chủ quan của người tham gia đối với hệ thống, giúp so sánh và phân tích một cách có hệ thống, nên đáp án C đúng.",
        "option_C": "Obtaining quantified measures of participants subjective reactions to using a system",
        "option_D": "Measuring the time it takes participants to complete a task"
      },
      {
        "question_id": 36,
        "question_title": "Clear \"tests\" that determine whether someone is \"in\" or \"out\" of the target population for a user test are:",
        "option_A": "Recruiting criteria",
        "option_B": "Diversity criteria",
        "correct_anwser": "A",
        "explain": "Tiêu chí tuyển chọn (recruiting criteria) là các quy tắc/điều kiện rõ ràng dùng để xác định ai đủ điều kiện (\"in\") hoặc không đủ điều kiện (\"out\") tham gia vào nhóm đối tượng mục tiêu của một kiểm thử người dùng, nên đáp án A đúng.",
        "option_C": "User tests",
        "option_D": "Tasks"
      },
      {
        "question_id": 37,
        "question_title": "Which of the following would you typically not include in a debrief interview?",
        "option_A": "Review of problems encountered during tasks",
        "option_B": "General questions about perceived usefulness and comparisons to similar systems",
        "correct_anwser": "C",
        "explain": "Các câu hỏi nhân khẩu học thường được thu thập trước khi bắt đầu kiểm thử (trong bước tuyển chọn/sàng lọc), chứ không phải trong phần phỏng vấn debrief sau khi kết thúc test, nên đáp án C đúng.",
        "option_C": "Demographic questions like age, gender, and education level",
        "option_D": "A \"wrap-up\" question in which you ask participants for any additional thoughts that weren't covered already"
      },
      {
        "question_id": 38,
        "question_title": "When reporting an issue found through user testing you should report all of the following EXCEPT:",
        "option_A": "Recommendation",
        "option_B": "Severity",
        "correct_anwser": "E",
        "explain": "Báo cáo vấn đề usability nên bao gồm khuyến nghị, mức độ nghiêm trọng, bằng chứng và mô tả rõ ràng vấn đề; tuy nhiên tên cụ thể của người tham gia không nên được nêu ra để bảo mật thông tin cá nhân của họ, nên đáp án E đúng (là điều KHÔNG nên báo cáo).",
        "option_C": "Evidence",
        "option_D": "Clear description of the problem",
        "option_E": "The names of the participants who encountered them"
      },
      {
        "question_id": 39,
        "question_title": "What can UX researchers do to minimize the impact of confirmation bias?",
        "option_A": "Wherever possible, have user tests conducted by neutral third parties who have no investment in the outcome of the test",
        "option_B": "Recruit only family and friends as participants, since they will be more honest about their feelings",
        "correct_anwser": "A",
        "explain": "Để giảm thiểu thiên kiến xác nhận (confirmation bias), nên để những bên trung lập, không có lợi ích liên quan đến kết quả kiểm thử thực hiện nghiên cứu, giúp đảm bảo tính khách quan trong việc thu thập và phân tích dữ liệu, nên đáp án A đúng.",
        "option_C": "Researchers should trust their intuition when analyzing test results, rather than seeking to be systematic and impartial",
        "option_D": "Ask participants the same questions at least 3 times, in order to confirm that the answers accurately reflect their feelings"
      },
      {
        "question_id": 40,
        "question_title": "Factors that capture the ways in which you expect your users to differ can be expressed as:",
        "option_A": "Recruiting criteria",
        "option_B": "Diversity criteria",
        "correct_anwser": "B",
        "explain": "Các yếu tố thể hiện sự khác biệt mong đợi giữa những người dùng (ví dụ: kinh nghiệm, độ tuổi, nghề nghiệp...) được gọi là tiêu chí đa dạng (diversity criteria), giúp đảm bảo mẫu kiểm thử phản ánh đầy đủ sự đa dạng của nhóm người dùng mục tiêu, nên đáp án B đúng.",
        "option_C": "Success criteria",
        "option_D": "Tasks"
      },
      {
        "question_id": 41,
        "question_title": "Personas include different types of information, from demographics to motivations and sociocultural context. How should designers decide what information to include?",
        "option_A": "They should focus on making the information as complete as possible",
        "option_B": "They should focus on idiosyncratic characteristics of people they encountered in the formative research that will make personas as vivid as possible",
        "correct_anwser": "D",
        "explain": "Persona được xây dựng để phục vụ mục đích thiết kế, nên thông tin đưa vào cần liên quan trực tiếp đến nhu cầu, rào cản và động lực sử dụng công nghệ của từng nhóm người dùng mục tiêu, thay vì cố gắng đầy đủ mọi chi tiết, chỉ tập trung nhân khẩu học, hay chỉ chọn chi tiết ấn tượng riêng lẻ không liên quan đến thiết kế.",
        "option_C": "They should focus mostly on demographic information; other types of information are secondary",
        "option_D": "They should focus on information that contributes to the distinct needs and potential barriers to and motivations for use that each class of target users has in relation to the technology being developed"
      },
      {
        "question_id": 42,
        "question_title": "Which is not an output modality commonly used in today's interactive applications?",
        "option_A": "Audio",
        "option_B": "Visual",
        "correct_anwser": "C",
        "explain": "Các ứng dụng tương tác hiện nay chủ yếu sử dụng đầu ra dạng âm thanh (audio), hình ảnh (visual) và xúc giác/rung (tactile/haptic). Đầu ra khứu giác (olfactory - mùi hương) hầu như chưa được ứng dụng phổ biến trong các hệ thống tương tác hiện tại.",
        "option_C": "Olfactory",
        "option_D": "Tactile/Haptic"
      },
      {
        "question_id": 43,
        "question_title": "Which of the following are types of user-entered inputs?",
        "option_A": "GPS",
        "option_B": "Text fields where users enter free-form responses",
        "correct_anwser": "E",
        "explain": "GPS là dữ liệu cảm biến được hệ thống tự động thu thập, không phải do người dùng chủ động nhập. Trong khi đó, văn bản tự do, các widget như lịch/công tắc, và giọng nói (dictation) đều là hình thức người dùng chủ động nhập liệu, nên đáp án đúng là tất cả các lựa chọn trừ GPS.",
        "option_C": "Widgets like calendar pickers or on/off switches",
        "option_D": "Voice input, like dictation typing",
        "option_E": "All options on this list except GPS"
      },
      {
        "question_id": 44,
        "question_title": "A recommended technique for supporting \"flexibility and efficiency of use\" is:",
        "option_A": "The use of keyboard \"accelerator\" shortcuts",
        "option_B": "Make sure all commands are represented graphically on the screen",
        "correct_anwser": "A",
        "explain": "Đây là một trong 10 nguyên tắc heuristic của Nielsen: 'Flexibility and efficiency of use'. Phím tắt (accelerator) cho phép người dùng có kinh nghiệm thao tác nhanh hơn trong khi người mới vẫn có thể dùng cách thông thường, đáp ứng cả nhu cầu người mới lẫn người thành thạo.",
        "option_C": "Streamline the design to minimize page load times",
        "option_D": "Eliminate as many commands as possible to prevent possible errors"
      },
      {
        "question_id": 45,
        "question_title": "A feature of an environment or system that communicates through verbiage or imagery what will happen if an action is taken is called:",
        "option_A": "A signifier",
        "option_B": "A signal",
        "correct_anwser": "A",
        "explain": "Signifier là dấu hiệu (bằng chữ hoặc hình ảnh) cho người dùng biết trước hành động nào có thể thực hiện và kết quả sẽ ra sao, khác với feedback là phản hồi sau khi hành động đã xảy ra.",
        "option_C": "Feedback",
        "option_D": "An icon"
      },
      {
        "question_id": 46,
        "question_title": "A change in an environment or system that indicates that a user's action was recognized and communicates the result of that action is called:",
        "option_A": "Response time",
        "option_B": "A signal",
        "correct_anwser": "C",
        "explain": "Feedback là phản hồi mà hệ thống đưa ra sau khi người dùng thực hiện một hành động, cho họ biết hành động đã được ghi nhận và kết quả ra sao. Khác với signifier (báo trước), feedback xảy ra sau khi hành động đã diễn ra.",
        "option_C": "Feedback",
        "option_D": "A dialogue box"
      },
      {
        "question_id": 47,
        "question_title": "If a user of a system is unable to find an option for action that they believe will move them closer to achieving their goal, we would say that the system fails to bridge:",
        "option_A": "The Gulf of Inspection",
        "option_B": "The Gulf of Expectation",
        "correct_anwser": "C",
        "explain": "Gulf of Execution (khoảng cách thực thi) là khoảng cách giữa mục tiêu của người dùng và hành động cụ thể mà hệ thống cho phép thực hiện. Khi người dùng không tìm được cách hành động để đạt mục tiêu, nghĩa là hệ thống chưa bắc cầu được Gulf of Execution.",
        "option_C": "The Gulf of Execution",
        "option_D": "The Gulf of Evaluation"
      },
      {
        "question_id": 48,
        "question_title": "A collection of associated concepts in long-term memory is called what?",
        "option_A": "A thought",
        "option_B": "A schema",
        "correct_anwser": "B",
        "explain": "Schema là một cấu trúc kiến thức trong trí nhớ dài hạn, tập hợp các khái niệm liên quan với nhau, giúp con người tổ chức và hiểu thông tin mới dựa trên kinh nghiệm đã có.",
        "option_C": "A mule",
        "option_D": "A gestalt"
      },
      {
        "question_id": 49,
        "question_title": "Using obscure system codes or non-intuitive imagery to represent system features and/or feedback violates which heuristic?",
        "option_A": "User control and freedom",
        "option_B": "Flexibility and efficiency of use",
        "correct_anwser": "D",
        "explain": "Nguyên tắc 'Match between system and the real world' yêu cầu hệ thống sử dụng ngôn ngữ, khái niệm và hình ảnh quen thuộc với người dùng thay vì thuật ngữ kỹ thuật khó hiểu hay hình ảnh không trực quan, giúp người dùng dễ hiểu và dễ sử dụng hơn.",
        "option_C": "Aesthetic and minimalist design",
        "option_D": "Match between system and the real world"
      },
      {
        "question_id": 50,
        "question_title": "Which of the following best describes the social desirability outcomes in interview-led survey modes?",
        "option_A": "Results can be biased because people want to be agreeable with an interviewer.",
        "option_B": "Results can be biased because interviewers will avoid questions that could be embarrassing.",
        "correct_anwser": "C",
        "explain": "Social desirability bias xảy ra khi người trả lời phỏng vấn có xu hướng vô thức (semi-consciously) điều chỉnh câu trả lời để trông tốt đẹp, được xã hội chấp nhận hơn trong mắt người phỏng vấn, thay vì trả lời hoàn toàn trung thực.",
        "option_C": "Results can be biased because people semi-consciously will try to look acceptable to the interviewer.",
        "option_D": "Results can be biased because some interviewers are more able to get people to do surveys."
      },
      {
        "question_id": 51,
        "question_title": "Which of the following is NOT a way of reducing the burden for a respondent to participate in your survey?",
        "option_A": "Asking people who use a site's shopping cart how they feel about that experience.",
        "option_B": "Keep the survey as short as you can without compromising quality.",
        "correct_anwser": "D",
        "explain": "Rút ngắn khảo sát, đơn giản hóa câu hỏi, và hỏi đúng ngữ cảnh (như hỏi ngay sau khi trải nghiệm) đều giúp giảm gánh nặng cho người trả lời. Việc nhờ người tham gia lan truyền khảo sát (snowball sampling) không liên quan đến việc giảm gánh nặng trả lời, mà liên quan đến cách thức chọn mẫu.",
        "option_C": "Reduce the complexity of questions by making them easy to understand.",
        "option_D": "Asking one group of respondents to forward the survey invite to their social networks."
      },
      {
        "question_id": 52,
        "question_title": "Which of the following would NOT be an example of a sampling frame?",
        "option_A": "A social media site, like Twitter",
        "option_B": "An organization's email directory",
        "correct_anwser": "A",
        "explain": "Sampling frame là danh sách cụ thể, xác định được của các đối tượng có thể được chọn làm mẫu (như danh bạ email, danh sách số điện thoại, danh sách người dùng đăng nhập). Một mạng xã hội như Twitter không phải là một danh sách cụ thể, xác định được người dùng để lấy mẫu, nên không phải là sampling frame.",
        "option_C": "All phone numbers in the U.S.",
        "option_D": "User names of everyone who logged into the site this month"
      },
      {
        "question_id": 54,
        "question_title": "Which of the following is NOT a dimension of survey modes?",
        "option_A": "Cost",
        "option_B": "Respondent burden",
        "correct_anwser": "C",
        "explain": "Các phương thức khảo sát (survey modes) thường được so sánh dựa trên các yếu tố như chi phí, gánh nặng cho người trả lời, và tính linh hoạt. Sampling frame (khung mẫu) là danh sách đối tượng để chọn mẫu, đây là khái niệm liên quan đến việc lấy mẫu chứ không phải là một khía cạnh để so sánh giữa các phương thức khảo sát.",
        "option_C": "Sampling frame",
        "option_D": "Flexibility"
      },
      {
        "question_id": 55,
        "question_title": "Which of the following is NOT a way to match your UX goals to survey methods?",
        "option_A": "Launch an exploratory survey to determine UX goals.",
        "option_B": "Ask why you want to have the data.",
        "correct_anwser": "A",
        "explain": "Quy trình đúng là xác định mục tiêu UX trước, sau đó mới chọn phương pháp khảo sát phù hợp (hỏi lý do cần dữ liệu, có lý do rõ ràng vì sao khảo sát là phù hợp, xác định mục tiêu trước khi chọn số liệu). Việc dùng một khảo sát thăm dò để 'xác định' mục tiêu UX là làm ngược quy trình, không phải cách đúng để khớp mục tiêu với phương pháp.",
        "option_C": "Have a story for why surveys are the best way to meet this UX goal.",
        "option_D": "Define goals before choosing metrics."
      },
      {
        "question_id": 56,
        "question_title": "This is error that is introduced when your questions somehow don't actually get to the concept you're interested in.",
        "option_A": "Coverage Error",
        "option_B": "Sampling Error",
        "correct_anwser": "C",
        "explain": "Measurement error (lỗi đo lường) xảy ra khi câu hỏi khảo sát không đo lường chính xác khái niệm mà nhà nghiên cứu thực sự muốn tìm hiểu, tức là có sự sai lệch giữa câu hỏi và khái niệm quan tâm.",
        "option_C": "Measurement error",
        "option_D": "Nonresponse Error"
      },
      {
        "question_id": 57,
        "question_title": "This term describes the total set of people you want to be able to represent with your survey.",
        "option_A": "Sample",
        "option_B": "Response Rate",
        "correct_anwser": "D",
        "explain": "Population (tổng thể) là toàn bộ nhóm người mà nhà nghiên cứu muốn đại diện và suy rộng kết quả thông qua khảo sát, khác với sample (mẫu) là tập con được chọn ra từ tổng thể đó.",
        "option_C": "Respondents",
        "option_D": "Population"
      },
      {
        "question_id": 58,
        "question_title": "Which of the following is NOT a way to increase the perceived benefit of participating in a survey?",
        "option_A": "Specify how the survey results will be used",
        "option_B": "Identify the trustworthiness of the sponsoring organization",
        "correct_anwser": "C",
        "explain": "Rút ngắn khảo sát giúp giảm gánh nặng (burden) cho người trả lời chứ không làm tăng lợi ích cảm nhận (perceived benefit) khi tham gia. Trong khi đó, nêu rõ mục đích sử dụng kết quả, khẳng định uy tín tổ chức, và nhấn mạnh cơ hội tham gia có hạn đều là cách làm tăng giá trị cảm nhận khi tham gia khảo sát.",
        "option_C": "Make the survey as short as possible",
        "option_D": "Stress that opportunities to respond are limited"
      },
      {
        "question_id": 59,
        "question_title": "The methodology you learned in this specialization is often labeled \"human-centered.\" Why?",
        "option_A": "Because it cannot be applied to animals.",
        "option_B": "Because it requires mindfulness training and centeredness to execute well.",
        "correct_anwser": "C",
        "explain": "Phương pháp 'human-centered design' (thiết kế lấy con người làm trung tâm) đặt trọng tâm vào việc thấu hiểu nhu cầu, sở thích và góc nhìn của người dùng thực tế hoặc tiềm năng trong suốt quá trình thiết kế, chứ không phải bỏ qua bối cảnh hay môi trường sử dụng.",
        "option_C": "Because it focuses on the needs, preferences, and perspectives of a human user (or potential user).",
        "option_D": "Because it focuses only on the human user and ignores the user's environment."
      },
      {
        "question_id": 60,
        "question_title": "What is qualitative data analysis?",
        "option_A": "The formal analysis of data that is not all quantified or quantifiable.",
        "option_B": "The formal analysis of numerical information.",
        "correct_anwser": "A",
        "explain": "Phân tích dữ liệu định tính (qualitative data analysis) là quá trình phân tích chính thức các dữ liệu không được (hoặc không thể) lượng hóa hoàn toàn thành con số, như lời nói, hành vi, quan sát, khác với phân tích định lượng vốn tập trung vào số liệu.",
        "option_C": "The formal analysis of product quality.",
        "option_D": "The formal analysis of how good something is."
      },
      {
        "question_id": 61,
        "question_title": "Which of the following is the best-scoped question for a small user needs assessment project?",
        "option_A": "What kinds of problems do users face when using Microsoft Word's spell-checking feature?",
        "option_B": "What kinds of problems do users face when using Microsoft products?",
        "correct_anwser": "A",
        "explain": "Đối với một dự án đánh giá nhu cầu người dùng quy mô nhỏ, câu hỏi cần đủ hẹp để khả thi nghiên cứu nhưng không quá hẹp đến mức bỏ lỡ ngữ cảnh quan trọng. Câu hỏi về tính năng kiểm tra chính tả của Word là phạm vi vừa phải — không quá rộng (như toàn bộ sản phẩm Microsoft hay toàn bộ Word) và không quá hẹp (chỉ tập trung vào việc sửa lỗi chính tả).",
        "option_C": "What kinds of problems do users face when using Microsoft Word?",
        "option_D": "What kinds of problems do users face when fixing a spelling error identified by Microsoft Word's spell-checking feature?"
      },
      {
        "question_id": 62,
        "question_title": "Which of the following is worth noticing in an observation?\nI. The physical context where the user is.\nII. Pauses or missteps the user makes.\nIII. Comments the user makes during a task.",
        "option_A": "II only",
        "option_B": "III only",
        "correct_anwser": "D",
        "explain": "Trong quan sát người dùng (observation), tất cả các yếu tố đều đáng chú ý: bối cảnh vật lý nơi người dùng đang thao tác, những khoảng dừng hay sai sót họ gặp phải, và những bình luận họ đưa ra trong lúc thực hiện nhiệm vụ đều cung cấp thông tin giá trị về trải nghiệm và khó khăn của người dùng.",
        "option_C": "II and III",
        "option_D": "I, II and III"
      },
      {
        "question_id": 63,
        "question_title": "Which of the following is a good open-ended question to ask in a semi-structured interview?",
        "option_A": "How many times a week do you use a GPS device recently?",
        "option_B": "Can you tell me about the most recent time when you used a GPS device?",
        "correct_anwser": "B",
        "explain": "Câu hỏi mở tốt trong phỏng vấn bán cấu trúc nên khuyến khích người được hỏi kể chi tiết, tự nhiên về trải nghiệm cụ thể mà không dẫn dắt hay giả định trước câu trả lời. 'Can you tell me about the most recent time...' mời gọi kể chuyện mở, trong khi các lựa chọn khác đều mang tính dẫn dắt, giả định vấn đề, hoặc chỉ yêu cầu câu trả lời đóng (có/không hoặc số liệu).",
        "option_C": "Was the GPS interface poorly designed?",
        "option_D": "Why didn't you use the landmark feature on your GPS device?"
      },
      {
        "question_id": 64,
        "question_title": "Which of the following should you NOT do when trying to establish rapport with an interview participant?",
        "option_A": "Talk about what other participants have been saying.",
        "option_B": "Make small talk at first.",
        "correct_anwser": "A",
        "explain": "Chia sẻ những gì người tham gia khác đã nói vi phạm tính bảo mật và có thể làm sai lệch câu trả lời của người được phỏng vấn hiện tại (họ có thể bị ảnh hưởng bởi ý kiến người khác). Đây không phải cách xây dựng lòng tin, trong khi trò chuyện xã giao, lắng nghe quan sát, và có tư duy học hỏi đều là cách tốt để tạo thiện cảm.",
        "option_C": "Listen and observe how they respond.",
        "option_D": "Adopt a learning mindset."
      },
      {
        "question_id": 65,
        "question_title": "What is an affinity note?",
        "option_A": "A sticky note on which you write relevant bits from your interview notes/recording and which is probably relevant for the user needs assessment.",
        "option_B": "A comment you write during an interview that indicates a common, recurring theme.",
        "correct_anwser": "A",
        "explain": "Affinity note là những mảnh ghi chú (thường trên sticky note) chứa các thông tin quan trọng, liên quan được trích từ ghi chú/bản ghi phỏng vấn, dùng để nhóm lại trong quá trình phân tích affinity diagramming (sơ đồ liên kết) phục vụ cho việc đánh giá nhu cầu người dùng.",
        "option_C": "A short summary that includes your analysis of a single interview.",
        "option_D": "A follow-up message from an interview participant that contains additional information."
      },
      {
        "question_id": 66,
        "question_title": "What does it mean to balance abstraction and precision in an affinity wall cluster summary?",
        "option_A": "The summary should be neither too long nor too short.",
        "option_B": "The summary should use some of the same vocabulary used in the notes in the cluster.",
        "correct_anwser": "D",
        "explain": "Cân bằng giữa tính trừu tượng và tính chính xác nghĩa là bản tóm tắt cụm ghi chú (cluster summary) cần khái quát được toàn bộ các ghi chú trong cụm đó (tính trừu tượng đủ rộng), đồng thời vẫn cụ thể và sâu sắc (tính chính xác) chứ không chung chung, mơ hồ.",
        "option_C": "The summary should be applicable to most but not all of the notes in the cluster.",
        "option_D": "The summary should represent all of the notes in the cluster while being as specific and insightful as possible."
      },
      {
        "question_id": 67,
        "question_title": "Which of the following is a method one would use to learn more about users' attitudes, preferences, context, and needs?\nI. Interviews (Remote or in-person)\nII. Clickstream analytics\nIII. Behavioral analytics (surveys)\nIV. A/B Testing",
        "option_A": "I and II",
        "option_B": "I and III",
        "correct_anwser": "B",
        "explain": "Để tìm hiểu thái độ, sở thích, bối cảnh và nhu cầu của người dùng - những yếu tố mang tính chủ quan, cần các phương pháp thu thập trực tiếp ý kiến như phỏng vấn và khảo sát (survey). Clickstream analytics và A/B testing chỉ cho biết người dùng làm gì (hành vi) chứ không giải thích được thái độ hay nhu cầu bên trong của họ.",
        "option_C": "I, II, and IV",
        "option_D": "I, II, III, and IV"
      },
      {
        "question_id": 68,
        "question_title": "Which of the following is NOT a method one would use to understand why people are using a product at certain times?",
        "option_A": "Surveys",
        "option_B": "Clickstream analytics",
        "correct_anwser": "C",
        "explain": "Concept Testing dùng để đánh giá phản ứng của người dùng với một ý tưởng/khái niệm sản phẩm mới, không phải để tìm hiểu lý do tại sao người dùng sử dụng sản phẩm vào những thời điểm cụ thể. Trong khi đó khảo sát, phân tích clickstream, phỏng vấn, và kiểm thử từ xa đều có thể giúp khám phá lý do và thời điểm sử dụng.",
        "option_C": "Concept Testing",
        "option_D": "Interviews",
        "option_E": "Remote testing"
      },
      {
        "question_id": 69,
        "question_title": "Which of the following is the MOST TRUE statement about how people remember things?",
        "option_A": "People remember their past behavior well enough to give accurate survey responses.",
        "option_B": "Memory can be guided back to accuracy through careful prompts.",
        "correct_anwser": "D",
        "explain": "Trí nhớ con người phai nhạt theo thời gian, và đặc biệt khó nhớ chính xác những hành động thường nhật, lặp đi lặp lại (vì chúng không gây ấn tượng đặc biệt), điều này là lý do khảo sát tự thuật về hành vi quá khứ thường không đáng tin cậy.",
        "option_C": "Memory fades over time, but people are good at remembering routine actions.",
        "option_D": "Memory fades over time, and often doesn't capture routine actions."
      },
      {
        "question_id": 70,
        "question_title": "Which of the following is the MOST IMPORTANT consideration in picking what type of question type to use?",
        "option_A": "The demographic makeup of your population",
        "option_B": "The type of analysis you plan on doing",
        "correct_anwser": "B",
        "explain": "Loại câu hỏi (đóng hay mở, thang đo, v.v.) cần được lựa chọn dựa trên cách bạn dự định phân tích dữ liệu sau này, vì kiểu phân tích quyết định định dạng dữ liệu cần thu thập để đảm bảo có thể xử lý và rút ra kết luận hiệu quả.",
        "option_C": "The type of sampling you're using",
        "option_D": "The mode your survey will be delivered in"
      },
      {
        "question_id": 71,
        "question_title": "Which of the following statement about open-ended questions is most FALSE?",
        "option_A": "They are the easiest type of question to analyze.",
        "option_B": "They allow respondents to answer without limiting the range of responses.",
        "correct_anwser": "A",
        "explain": "Thực tế, câu hỏi mở là loại khó phân tích nhất vì cần mã hóa (coding) và xử lý dữ liệu văn bản không có cấu trúc, không phải dễ phân tích nhất. Các phát biểu còn lại đều đúng về đặc điểm của câu hỏi mở.",
        "option_C": "They are more frequently skipped than other types of questions.",
        "option_D": "They are often used when we haven't pre-defined response categories."
      },
      {
        "question_id": 72,
        "question_title": "Under what circumstances is remote testing appropriate?\nI. It is difficult to access the product/experience.\nII. Participants from a variety of geographic locations are needed.\nIII. Time is limited.\nIV. There is a lot of Personally Identifiable Information required.\nV. All of the above",
        "option_A": "I, II, III",
        "option_B": "I, IV",
        "correct_anwser": "A",
        "explain": "Kiểm thử từ xa (remote testing) phù hợp khi khó tiếp cận sản phẩm/trải nghiệm trực tiếp, cần người tham gia từ nhiều khu vực địa lý khác nhau, hoặc khi thời gian hạn chế. Ngược lại, khi cần thu thập nhiều thông tin định danh cá nhân nhạy cảm (PII), kiểm thử trực tiếp thường phù hợp hơn để đảm bảo bảo mật và kiểm soát tốt hơn.",
        "option_C": "I, III, IV",
        "option_D": "II, III",
        "option_E": "V"
      },
      {
        "question_id": 73,
        "question_title": "Which of the following is the LEAST true statement about open-ended questions?",
        "option_A": "Responses require effort for coding and analysis.",
        "option_B": "Respondents are more likely to skip open-ended questions.",
        "correct_anwser": "D",
        "explain": "Câu hỏi mở không cung cấp 'dữ liệu xấu' - dữ liệu định tính từ câu hỏi mở vẫn rất giá trị và phong phú, chỉ là khó chuẩn hóa và cần nhiều công sức xử lý hơn. Các phát biểu còn lại (khó phân tích, dễ bị bỏ qua, cần làm sạch dữ liệu nhiều hơn) đều là những hạn chế thực tế và đúng của câu hỏi mở.",
        "option_C": "They can require more data cleaning.",
        "option_D": "They provide bad data because responses are not standardized."
      },
      {
        "question_id": 74,
        "question_title": "Which of the following are the hallmarks of good research questions?\nI. Clarity\nII. Consistency\nIII. Ability to be answered\nIV. Ethical excellence\nV. Significance",
        "option_A": "I, II, and III",
        "option_B": "I, II, and V",
        "correct_anwser": "E",
        "explain": "Câu hỏi nghiên cứu tốt cần rõ ràng (clarity), có khả năng trả lời được (ability to be answered), đảm bảo tính đạo đức (ethical excellence), và có ý nghĩa/quan trọng (significance). 'Consistency' (tính nhất quán) không phải là tiêu chí đặc trưng thường được nhắc đến khi đánh giá chất lượng của một câu hỏi nghiên cứu.",
        "option_C": "IV and V",
        "option_D": "II, IV, and V",
        "option_E": "I, III, IV, and V"
      },
      {
        "question_id": 75,
        "question_title": "Which of the following is NOT a best practice in writing nominal closed-ended questions?",
        "option_A": "Avoid unequal response options",
        "option_B": "Use \"select all that apply\" responses rather than forced choices.",
        "correct_anwser": "B",
        "explain": "Thực hành tốt thường khuyến khích sử dụng câu hỏi buộc chọn 1 đáp án (forced choice) hơn là 'chọn tất cả đáp án phù hợp' (select all that apply), vì kiểu 'select all' dễ khiến người trả lời bỏ sót lựa chọn hoặc không cân nhắc kỹ từng phương án so với việc phải quyết định rõ ràng cho từng lựa chọn.",
        "option_C": "Constrain the number of response options that you provide",
        "option_D": "Randomize response options when necessary"
      },
      {
        "question_id": 76,
        "question_title": "When designing the set of tasks you will use in a test, it's a good idea to:",
        "option_A": "Order them from hardest to easiest, to get the hard stuff out of the way.",
        "option_B": "Order them from easiest to hardest, so that your participants feel more comfortable.",
        "correct_anwser": "B",
        "explain": "Sắp xếp nhiệm vụ từ dễ đến khó giúp người tham gia làm quen dần với hệ thống, xây dựng sự tự tin và thoải mái trước khi đối mặt với các nhiệm vụ phức tạp hơn, tránh gây áp lực hoặc bỏ cuộc ngay từ đầu.",
        "option_C": "Ask individual participants to perform several very similar tasks one after another, to ensure that they perform consistently.",
        "option_D": "Exhaustively test every possible path a user could take through the interface, even if it means testing with dozens of users."
      },
      {
        "question_id": 77,
        "question_title": "The design process is highly iterative. Which of the following are iterative loops that a designer might do in the course of a project?",
        "option_A": "From ideation to problem framing",
        "option_B": "From creation of scenarios and storyboards to ideation",
        "correct_anwser": "E",
        "explain": "Quy trình thiết kế mang tính lặp lại (iterative) rất cao, nghĩa là nhà thiết kế có thể quay lại bất kỳ giai đoạn nào trước đó bất cứ lúc nào — từ ý tưởng quay lại định hình vấn đề, từ kịch bản/storyboard quay lại ý tưởng hoặc định hình vấn đề, hay từ tạo mẫu quay lại ý tưởng — tất cả đều là các vòng lặp hợp lý trong quá trình thiết kế.",
        "option_C": "From creation of scenarios and storyboards to problem framing",
        "option_D": "From prototyping to ideation",
        "option_E": "All of the others",
        "option_F": "None of the others"
      },
      {
        "question_id": 78,
        "question_title": "Which of the following best describes the role of a participant in a user test?",
        "option_A": "They are being evaluated to see if they are competent enough to use the system tested",
        "option_B": "Once they have agreed to participate, they are obligated to complete all tasks and answer all questions, regardless of their discomfort",
        "correct_anwser": "C",
        "explain": "Trong kiểm thử người dùng, mục tiêu là đánh giá hệ thống chứ không phải đánh giá người dùng. Người tham gia được xem như đối tác cùng nhà nghiên cứu để phát hiện lỗi thiết kế, họ có quyền dừng lại bất cứ lúc nào nếu cảm thấy khó chịu, và thường được thông báo trước về mục đích chung của bài test (dù không phải mọi chi tiết) để tham gia hiệu quả.",
        "option_C": "They are partners with the researchers administering the test, working with together to find flaws in the system design",
        "option_D": "They should remain ignorant of the goals of the test, so that they can offer more creative feedback and design suggestions"
      },
      {
        "question_id": 79,
        "question_title": "Which of the following is not an example of a subjective measure that might be collected during a user test?",
        "option_A": "Perceived usability",
        "option_B": "Perceived usefulness",
        "correct_anwser": "D",
        "explain": "Tốc độ hoàn thành nhiệm vụ (task completion speed) là một đại lượng khách quan (objective), đo lường được bằng thời gian thực tế, khác với các chỉ số mang tính cảm nhận chủ quan của người dùng như cảm nhận về tính khả dụng, tính hữu ích, hay mức độ mong muốn sử dụng.",
        "option_C": "Desirability",
        "option_D": "Task completion speed"
      },
      {
        "question_id": 80,
        "question_title": "About how many \"key findings\" should be included in a typical user test report?",
        "option_A": "1",
        "option_B": "2-3",
        "correct_anwser": "C",
        "explain": "Một báo cáo kiểm thử người dùng điển hình thường bao gồm khoảng 5-10 phát hiện chính (key findings), đủ để bao quát các vấn đề quan trọng mà không làm loãng trọng tâm hay gây quá tải thông tin cho người đọc báo cáo.",
        "option_C": "5-10",
        "option_D": "20-50"
      },
      {
        "question_id": 81,
        "question_title": "What is the problem with the following task description? \"Go to coursera.org and find a course that looks interesting to you. Find out more about it.\"",
        "option_A": "It is not realistic",
        "option_B": "It is not verifiable",
        "correct_anwser": "B",
        "explain": "Nhiệm vụ này không thể xác minh được (not verifiable) vì không có tiêu chí cụ thể, rõ ràng nào để xác định khi nào người dùng đã 'hoàn thành thành công' nhiệm vụ — 'khóa học thú vị' và 'tìm hiểu thêm' đều mang tính chủ quan và mơ hồ, không có kết quả đo lường được cụ thể.",
        "option_C": "It \"leads the witness\"",
        "option_D": "It is not the most efficient way of learning about a Coursera course"
      },
      {
        "question_id": 82,
        "question_title": "The person who greets participants and communicates with them throughout a user test session is called the:",
        "option_A": "Logger",
        "option_B": "Moderator",
        "correct_anwser": "B",
        "explain": "Moderator (người điều phối) là người trực tiếp chào đón, hướng dẫn và giao tiếp với người tham gia trong suốt phiên kiểm thử người dùng, khác với Logger là người ghi chép/quan sát và ghi lại dữ liệu trong quá trình test.",
        "option_C": "Interviewer",
        "option_D": "Technician"
      },
      {
        "question_id": 83,
        "question_title": "Why is it important to have a facilitator for a brainstorming session?",
        "option_A": "To make sure people don't go on excessive tangents",
        "option_B": "To notice when session participants feel stuck or are have hit a dead end, and to redirect the session by bringing up a new topic for brainstorming",
        "correct_anwser": "E",
        "explain": "Người điều phối (facilitator) trong buổi brainstorming đảm nhiệm nhiều vai trò cùng lúc: giữ cho phiên họp không lạc đề, nhận biết khi người tham gia bế tắc để định hướng lại, ngăn việc phê phán ý tưởng quá sớm, và cảnh báo khi nhóm đi quá sâu vào một ý tưởng duy nhất. Do đó đáp án đúng là tất cả các lựa chọn trên.",
        "option_C": "To keep in check critiquing of ideas",
        "option_D": "To flag if participants end up diving too deeply into a single idea",
        "option_E": "All of the others"
      },
      {
        "question_id": 84,
        "question_title": "Which of the following represents the system's state:",
        "option_A": "Information about the user's current location",
        "option_B": "User profile information",
        "correct_anwser": "D",
        "explain": "Trạng thái hệ thống (system's state) được định nghĩa là tập hợp giá trị hiện tại của tất cả các đầu vào và biến số của hệ thống, cùng với các quy tắc để xử lý những giá trị đó, phản ánh toàn bộ tình trạng vận hành tại một thời điểm.",
        "option_C": "Rules for providing feedback to the user",
        "option_D": "Current values of all system inputs and variables, and rules for operating on those values"
      },
      {
        "question_id": 85,
        "question_title": "Gulf of evaluation refers to which of the following?",
        "option_A": "The user's ability to understand the system's output (e.g., the graphs that the system presents the user)",
        "option_B": "The ability of the user to tell if the system did what the user was trying to do.",
        "correct_anwser": "B",
        "explain": "Gulf of evaluation (khoảng cách đánh giá) đề cập đến khả năng của người dùng trong việc xác định xem hệ thống đã thực hiện đúng những gì họ mong muốn hay chưa, dựa trên phản hồi mà hệ thống cung cấp.",
        "option_C": "The user's ability to evaluate if the system is a good match for his/her needs.",
        "option_D": "The difference between user ratings of an app in the app store and the actual quality of the app."
      },
      {
        "question_id": 86,
        "question_title": "A feature of an environment or system that, by its shape and appearance, suggests to a person that a particular action could be taken is called:",
        "option_A": "An affordance",
        "option_B": "A signal",
        "correct_anwser": "A",
        "explain": "Affordance (khả năng gợi ý hành động) là đặc điểm của một môi trường hoặc hệ thống mà thông qua hình dạng và vẻ ngoài của nó, gợi ý cho người dùng biết có thể thực hiện hành động cụ thể nào đó, ví dụ như tay nắm cửa gợi ý hành động kéo/đẩy.",
        "option_C": "A constraint",
        "option_D": "A signpost"
      },
      {
        "question_id": 88,
        "question_title": "________ means \"to make an idea real or concrete.\"",
        "option_A": "Assessment",
        "option_B": "Communication",
        "correct_anwser": "C",
        "explain": "Reification (cụ thể hóa) có nghĩa là biến một ý tưởng trừu tượng thành thứ hiện thực, cụ thể, chẳng hạn như biến ý tưởng thiết kế thành prototype hữu hình để có thể đánh giá và trải nghiệm.",
        "option_C": "Reification",
        "option_D": "Reflection"
      },
      {
        "question_id": 92,
        "question_title": "Which of the following is NOT an advantage of lo-fi prototyping?",
        "option_A": "You can identify problems before investing significant resources into a design direction.",
        "option_B": "You can work out aspects of graphic design such as fonts and color schemes, which have the largest impact on user experience.",
        "correct_anwser": "B",
        "explain": "Prototype độ trung thực thấp (lo-fi) không phù hợp để thử nghiệm các yếu tố thiết kế đồ họa chi tiết như font chữ, màu sắc - đó là công việc của hi-fi prototype. Lo-fi tập trung vào cấu trúc và luồng ý tưởng, không phải chi tiết thẩm mỹ.",
        "option_C": "Stakeholders are more likely to give honest feedback if they perceive that design ideas are \"sketchy\" rather than highly polished.",
        "option_D": "Lo-fi prototypes are easy to change, allowing you to iterate more rapidly than you could if you were creating more complex prototypes."
      },
      {
        "question_id": 93,
        "question_title": "What term is used to describe the actual questions you ask people?",
        "option_A": "Respondent",
        "option_B": "Instrument",
        "correct_anwser": "B",
        "explain": "Instrument (công cụ khảo sát) là thuật ngữ dùng để chỉ bộ câu hỏi thực tế được sử dụng để thu thập dữ liệu từ người tham gia.",
        "option_C": "Frame",
        "option_D": "Population"
      },
      {
        "question_id": 98,
        "question_title": "Which of the following is the most accurate statement?",
        "option_A": "Error can be reduced by designing surveys as well as possible within resource constraints.",
        "option_B": "Error should be reduced to zero before launching a survey.",
        "correct_anwser": "A",
        "explain": "Sai số trong khảo sát không bao giờ có thể loại bỏ hoàn toàn (bằng 0), nhưng có thể được giảm thiểu thông qua việc thiết kế khảo sát tốt nhất có thể trong giới hạn nguồn lực (thời gian, chi phí) cho phép.",
        "option_C": "It's impossible to affect error one way or another.",
        "option_D": "Surveys should never be trusted because of how much error they involve."
      },
      {
        "question_id": 100,
        "question_title": "This is the error that is introduced because the way you are asking questions is going to miss some big chunk of your population of interest.",
        "option_A": "Measurement error",
        "option_B": "Nonresponse error",
        "correct_anwser": "C",
        "explain": "Sampling frame (khung mẫu) đề cập đến danh sách người có thể được chọn để tham gia khảo sát; nếu khung mẫu không bao phủ đầy đủ, một phần lớn tổng thể mục tiêu sẽ bị bỏ sót, dẫn đến lỗi khung mẫu (đôi khi gọi là coverage error liên quan đến sampling frame).",
        "option_C": "Sampling frame",
        "option_D": "Sampling error"
      },
      {
        "question_id": 103,
        "question_title": "What is one quality that distinguishes a semi-structured interview from other kinds of interviews?",
        "option_A": "Half of the interview will be a questionnaire, the other half will be open-ended.",
        "option_B": "Half of the interview will be a questionnaire, the other half will be based on an interview protocol.",
        "correct_anwser": "C",
        "explain": "Phỏng vấn bán cấu trúc (semi-structured interview) có đặc điểm là người phỏng vấn sử dụng giao thức phỏng vấn (protocol) làm hướng dẫn chung, nhưng vẫn linh hoạt đi lệch khỏi kịch bản để khai thác sâu hơn các câu trả lời của người tham gia.",
        "option_C": "While the interviewer uses an interview protocol as a guideline, the interview itself will often go off-script.",
        "option_D": "The interviewer and the interview participant should each expect to speak about half of the time."
      },
      {
        "question_id": 105,
        "question_title": "What should you do when you create clusters in an affinity wall?",
        "option_A": "Avoid mistakes, because once a cluster is formed, it cannot be undone.",
        "option_B": "Create clusters of more than seven affinity notes.",
        "correct_anwser": "D",
        "explain": "Khi tạo các cụm (cluster) trên affinity wall, bạn nên sẵn sàng di chuyển các ghi chú và tái cấu trúc lại các cụm khi cần thiết, vì đây là một quá trình lặp đi lặp lại để tìm ra cách phân nhóm hợp lý nhất, không phải cố định ngay từ đầu.",
        "option_C": "Put all notes that use the same word in a single cluster.",
        "option_D": "Be willing to move notes and re-form clusters."
      },
      {
        "question_id": 110,
        "question_title": "Which of the following is NOT another name for the kind of qualitative research methodology you learned in this specialization?",
        "option_A": "Ethnographic research.",
        "option_B": "Contextual inquiry.",
        "correct_anwser": "D",
        "explain": "'Socio-technical extraction' không phải là thuật ngữ thực tế được sử dụng để mô tả phương pháp nghiên cứu định tính trong chuyên ngành này, trong khi ethnographic research, contextual inquiry và user needs assessment đều là các tên gọi hợp lệ, liên quan cho loại nghiên cứu này.",
        "option_C": "User needs assessment.",
        "option_D": "Socio-technical extraction."
      },
      {
        "question_id": 112,
        "question_title": "Which of the following best describes the question stem?",
        "option_A": "It's the optional instructions for how to answer a question.",
        "option_B": "It's the set of responses that a respondent can give.",
        "correct_anwser": "C",
        "explain": "Question stem (thân câu hỏi) là phần câu hỏi thực tế được đặt ra để cụ thể hóa khái niệm nghiên cứu quan tâm và yêu cầu người trả lời đưa ra phản hồi, khác với các lựa chọn trả lời hay hướng dẫn.",
        "option_C": "It's the query that operationalizes the concept of interest and prompts a response.",
        "option_D": "It's a series of questions that are used together to form a scale."
      },
      {
        "question_id": 116,
        "question_title": "Under what circumstances is remote testing appropriate?\nI. It is difficult to access the product/experience.\nII. Participants from a variety of geographic locations are needed.\nIII. Time is limited.\nIV. There is a lot of Personally Identifiable Information required.",
        "option_A": "I, II, III",
        "option_B": "I, IV",
        "correct_anwser": "A",
        "explain": "Kiểm thử từ xa (remote testing) phù hợp khi: khó tiếp cận sản phẩm/trải nghiệm trực tiếp, cần người tham gia ở nhiều vị trí địa lý khác nhau, thời gian hạn chế, hoặc có nhiều thông tin cá nhân nhạy cảm cần bảo mật. Tất cả các trường hợp trên đều là lý do hợp lý, nên đáp án là tất cả các đáp án trên.",
        "option_C": "I, III, IV",
        "option_D": "II, III",
        "option_E": "V. All of the above"
      },
      {
        "question_id": 119,
        "question_title": "Which of the following is not one of the qualities of well-design tasks for use in a user test?",
        "option_A": "Realistic",
        "option_B": "Verifiable",
        "correct_anwser": "D",
        "explain": "Nhiệm vụ được thiết kế tốt cần rõ ràng, cụ thể để đảm bảo mọi người dùng hiểu theo cùng một cách; việc để nhiệm vụ mơ hồ, cho phép người dùng diễn giải khác nhau sẽ làm giảm tính nhất quán và khả năng so sánh kết quả kiểm thử.",
        "option_C": "Doesn't \"lead the witness\"",
        "option_D": "Leaves room for different users' interpretation"
      },
      {
        "question_id": 120,
        "question_title": "You are testing the Nomaza.com website. All of your test participants will be using the same computer, which is located in your user testing lab. Which of the following is not something you ought to worry about when preparing for each test session?",
        "option_A": "making sure the browser cache is cleared so that later users don't see which links have been visited",
        "option_B": "clearing out data that was created by earlier users so that all participants see the same starting conditions",
        "correct_anwser": "C",
        "explain": "Vì tất cả người tham gia sử dụng cùng một máy tính trong phòng lab, không cần kiểm tra laptop cá nhân của họ (vì họ không dùng laptop riêng); đây là vấn đề không liên quan trong bối cảnh kiểm thử tập trung trên một máy duy nhất.",
        "option_C": "testing participants' laptops to make sure their default browser is capable of displaying Nomaza.com",
        "option_D": "giving all participants the same account capabilities and payment method in order to ensure consistency"
      },
      {
        "question_id": 123,
        "question_title": "Which of the following is NOT a key design skill?",
        "option_A": "To frame or reframe a design problem",
        "option_B": "To generate a large number of alternative solutions",
        "correct_anwser": "E",
        "explain": "Viết kế hoạch kinh doanh để bán công nghệ không phải là một kỹ năng thiết kế cốt lõi; các kỹ năng thiết kế chính bao gồm định hình vấn đề, tạo giải pháp thay thế, đánh giá đánh đổi, và tạo/kiểm thử prototype.",
        "option_C": "To evaluate tradeoffs of different alternatives",
        "option_D": "To create and test with potential users a functioning prototype of a design solution",
        "option_E": "To write a business plan for selling the technology designers created"
      },
      {
        "question_id": 124,
        "question_title": "What is the problem with the following task description? \"Go to coursera.org. Hover over the button 'Explore', then click 'Explore all of Coursera'. Scroll until you find the link to 'User Experience (UX) Research and Design' Specialization. Click on it. On the resulting page, find the first course and enroll in it.\"",
        "option_A": "It is not realistic",
        "option_B": "It is not verifiable",
        "correct_anwser": "C",
        "explain": "Nhiệm vụ này hướng dẫn chi tiết từng bước cụ thể (hover, click nút nào, cuộn ở đâu) thay vì chỉ mô tả mục tiêu, điều này 'dẫn dắt nhân chứng' - chỉ cho người dùng biết chính xác cách thực hiện thay vì để họ tự khám phá con đường của riêng mình, làm mất đi giá trị quan sát hành vi tự nhiên.",
        "option_C": "It \"leads the witness\"",
        "option_D": "It is not the most efficient way of enrolling in a Coursera course"
      },
      {
        "question_id": 125,
        "question_title": "Which of the following best describes the role of a participant in a user test?",
        "option_A": "They are being evaluated to see if they are competent enough to use the system tested",
        "option_B": "Once they have agreed to participate, they are obligated to complete all tasks and answer all questions, regardless of their discomfort",
        "correct_anwser": "C",
        "explain": "Người tham gia kiểm thử người dùng đóng vai trò như đối tác hợp tác cùng nhà nghiên cứu để phát hiện những điểm yếu trong thiết kế hệ thống, chứ không phải bị đánh giá về năng lực cá nhân hay bị ép buộc hoàn thành mọi thứ bất kể sự khó chịu.",
        "option_C": "They are partners with the researchers administering the test, working together to find flaws in the system design",
        "option_D": "They should remain ignorant of the goals of the test, so that they can offer more creative feedback and design suggestions"
      },
      {
        "question_id": 126,
        "question_title": "When is it most appropriate to conduct remote moderated testing?\nI. Redirection and discussion are required\nII. Users can complete tasks without instruction\nIII. Finding participants local to your lab is challenging\nIV. You want to see and explore user's digital contexts\nV. All of the above",
        "option_A": "I, II, III",
        "option_B": "I, IV",
        "correct_anwser": "D",
        "explain": "Remote moderated testing phù hợp khi cần điều hướng và thảo luận trực tiếp với người dùng (I), khi khó tìm được người tham gia gần phòng lab (III), và khi muốn quan sát bối cảnh số thực tế của người dùng (IV). Ý II (người dùng có thể hoàn thành task mà không cần hướng dẫn) lại phù hợp hơn với unmoderated testing, nên không thuộc nhóm này.",
        "option_C": "I, III",
        "option_D": "I, III, IV"
      },
      {
        "question_id": 129,
        "question_title": "Which of the following is LEAST true about extrinsic, or material, incentives?",
        "option_A": "You should frame incentives as gifts, not as payment.",
        "option_B": "Incentives given *before* the survey are more effective.",
        "correct_anwser": "C",
        "explain": "Nghiên cứu cho thấy mối quan hệ giữa số tiền thưởng và tỷ lệ tham gia không tuyến tính (có hiệu ứng giảm dần - diminishing returns), nên việc tăng tiền không đảm bảo tăng tương ứng tỷ lệ tham gia. Đây là phát biểu ít đúng nhất, trong khi các phát biểu khác (đóng khung như quà tặng, đưa trước khảo sát hiệu quả hơn, xổ số kém hiệu quả) đều là những nguyên tắc đúng về incentive.",
        "option_C": "The more money you offer, the more likely people are to participate.",
        "option_D": "Lotteries (a chance to win a larger reward) are not very effective as incentives."
      },
      {
        "question_id": 131,
        "question_title": "What type of question is the following survey question:\nHow much do you like or dislike participating in surveys?\n1. Extremely like\n2. Somewhat like\n3. Neither like nor dislike\n4. Somewhat dislike\n5. Extremely dislike",
        "option_A": "Bipolar ordinal",
        "option_B": "Unipolar ordinal",
        "correct_anwser": "A",
        "explain": "Đây là câu hỏi dạng ordinal (có thứ tự) vì các lựa chọn được sắp xếp theo mức độ tăng dần/giảm dần. Nó là bipolar vì có hai cực đối lập nhau (thích - ghét) với điểm trung lập ở giữa (neither like nor dislike), khác với unipolar chỉ đo một chiều cường độ (ví dụ: không hề đến rất nhiều).",
        "option_C": "Nominal",
        "option_D": "Open-ended"
      },
      {
        "question_id": 141,
        "question_title": "Which of the following are among key tasks that were identified? (Based on the table: Register and Login, Set Security Code, Report an event, Check map, Customize automatic functions, Change security Code, Delete account, Help, Cancel function \"Robbery\", Check recent events, Activate function \"Robbery\")",
        "option_A": "Check map, Help, Activate function \"Robbery\"",
        "option_B": "Customize automatic functions, Help, Log Out",
        "correct_anwser": "A",
        "explain": "Đối chiếu với bảng Key tasks trong wireframe, cả ba nhiệm vụ 'Check map', 'Help', và 'Activate function Robbery' đều xuất hiện rõ ràng trong danh sách 11 key tasks được liệt kê. Các đáp án còn lại chứa những nhiệm vụ không có trong bảng như 'Log Out' và 'Create a post', nên không chính xác.",
        "option_C": "Check map, Create a post, Log Out",
        "option_D": "Change security code, Create a post, Check recent events"
      },
      {
        "question_id": 148,
        "question_title": "Finding\n1. No Option to delete or modify Time Sheet entries.\nSeverity: 4\nHeuristic(s) Violated: Navigation\n\nWhat heuristic does this violate?",
        "option_A": "Visibility of system status",
        "option_B": "User control and freedom",
        "correct_anwser": "B",
        "explain": "Việc không cho phép người dùng sửa hoặc xóa các mục đã nhập (undo/redo hành động) là vi phạm nguyên tắc 'User control and freedom' - người dùng cần có khả năng kiểm soát và tự do sửa lỗi khi thực hiện hành động sai, đây là một trong 10 nguyên tắc heuristics của Nielsen.",
        "option_C": "Error prevention",
        "option_D": "Recognition vs recall"
      },
      {
        "question_id": 153,
        "question_title": "Is this a good scope for a user test?\nScope of the evaluation: Report an event when someone else is being a victim of robbery. Check the map to see if a place is dangerous. Protect themselves in case they are the victim of smartphone robbery.",
        "option_A": "No, a user test must focus on only one task",
        "option_B": "Yes, it has users test the core functions of the app",
        "correct_anwser": "B",
        "explain": "Phạm vi này bao gồm các chức năng cốt lõi và được sử dụng thường xuyên nhất của ứng dụng (report event, check map, protect themselves), phù hợp với nguyên tắc xác định scope hiệu quả cho một user test - không cần test toàn bộ mọi tính năng mà tập trung vào các chức năng quan trọng nhất.",
        "option_C": "No, a user test needs to compare two different systems",
        "option_D": "No, a user test needs to include testing every single task in the application to deliver valuable data"
      },
      {
        "question_id": 159,
        "question_title": "By helping users form effective _________, we can help users to predict the results of actions they haven't yet performed using a system.",
        "option_A": "System images",
        "option_B": "Assumptions",
        "correct_anwser": "D",
        "explain": "Conceptual model (mô hình khái niệm) là cách người dùng hiểu và hình dung về cách một hệ thống hoạt động. Khi người dùng có một conceptual model tốt và chính xác, họ có thể dự đoán được kết quả của các hành động mà họ chưa từng thực hiện trước đó trên hệ thống.",
        "option_C": "Feedback",
        "option_D": "Conceptual models"
      },
      {
        "question_id": 165,
        "question_title": "What does it mean when the design process is called ",
        "option_A": "Designers skip testing to save time",
        "option_B": "Designers repeat and refine ideas",
        "correct_anwser": "B",
        "explain": "Quy trình thiết kế lặp (iterative design process) có nghĩa là nhà thiết kế liên tục lặp lại các bước kiểm thử, thu thập phản hồi và tinh chỉnh ý tưởng để hoàn thiện sản phẩm.",
        "option_C": "Designers always follow linear steps",
        "option_D": "Designers focus only on wireframes"
      },
      {
        "question_id": 166,
        "question_title": "What are the benefits of brainstorming in group ideation?",
        "option_A": "Stimulates creativity and diverse perspectives",
        "option_B": "Ensures immediate solutions are found",
        "correct_anwser": "A",
        "explain": "Brainstorming theo nhóm giúp kích thích sự sáng tạo và mang lại nhiều góc nhìn đa dạng từ các thành viên khác nhau.",
        "option_C": "Eliminates the need for further design steps",
        "option_D": "Focuses on individual expertise"
      },
      {
        "question_id": 167,
        "question_title": "Which of the following is an example of a tool commonly used for creating wireframes in UX design?",
        "option_A": "Blender",
        "option_B": "Figma",
        "correct_anwser": "B",
        "explain": "Figma là công cụ phổ biến chuyên dùng để tạo wireframe và prototype trong UX/UI design. Các công cụ còn lại như Blender, Unity, Maya dành cho đồ họa 3D và phát triển game.",
        "option_C": "Unity",
        "option_D": "Maya"
      },
      {
        "question_id": 168,
        "question_title": "Which of the following best describes a low-fidelity prototype?",
        "option_A": "A fully functional product",
        "option_B": "A detailed visual representation with interactive elements",
        "correct_anwser": "C",
        "explain": "Low-fidelity prototype (bản mô phỏng độ phân giải thấp) là bản thể hiện đơn giản, thường vẽ bằng tay để thử nghiệm nhanh các khái niệm thiết kế.",
        "option_C": "A simple, often hand-drawn, representation of a design concept",
        "option_D": "A final version ready for deployment"
      },
      {
        "question_id": 169,
        "question_title": "Personas represent target users and are, thus, primarily a distillation of the findings from formative work. Scenarios begin to move designers toward a design solution. How do scenarios do this?",
        "option_A": "By envisioning how a technology might address the needs identified in formative work",
        "option_B": "By enumerating features of the technology being designed",
        "correct_anwser": "A",
        "explain": "Scenarios (kịch bản sử dụng) giúp hình dung ra cách mà giải pháp công nghệ sẽ giải quyết các nhu cầu và vấn đề của người dùng đã được xác định trong quá trình nghiên cứu.",
        "option_C": "By articulating tradeoffs of different design solutions",
        "option_D": "By providing stories that can be put into the ads for the product being designed"
      },
      {
        "question_id": 170,
        "question_title": "Which of the following is not a question that can be answered by getting feedback on wireframes?",
        "option_A": "Do screens contain the right functional components?",
        "option_B": "Does the screen layout make sense?",
        "correct_anwser": "D",
        "explain": "Wireframe chủ yếu tập trung vào bố cục (layout), thành phần chức năng và thứ tự nội dung trên từng màn hình đơn lẻ. Việc đánh giá khả năng điều hướng đầy đủ giữa các màn hình (navigation) thường yêu cầu các bản prototype có tính tương tác.",
        "option_C": "Is the displayed content ordered correctly?",
        "option_D": "Do the screens provide adequate navigation?"
      },
      {
        "question_id": 172,
        "question_title": "What is a key criterion when evaluating low-fidelity prototypes?",
        "option_A": "Ability to test core user tasks",
        "option_B": "Visual style and branding",
        "correct_anwser": "A",
        "explain": "Tiêu chí quan trọng nhất khi đánh giá low-fidelity prototype là khả năng kiểm thử các tác vụ cốt lõi của người dùng (core user tasks) thay vì tập trung vào giao diện hay hiệu ứng.",
        "option_C": "Use of advanced interaction patterns",
        "option_D": "Detailed animations"
      },
      {
        "question_id": 173,
        "question_title": "What principle helps ensure that users can discover how to use a system?",
        "option_A": "Signifiers.",
        "option_B": "Constraints",
        "correct_anwser": "A",
        "explain": "Theo Don Norman, Signifiers (dấu hiệu chỉ dẫn) truyền đạt rõ ràng nơi nào và hành động nào cần thực hiện, giúp người dùng khám phá ra cách sử dụng hệ thống.",
        "option_C": "Affordances",
        "option_D": "Feedback."
      },
      {
        "question_id": 174,
        "question_title": "What is the first step in conducting a Heuristic Evaluation?",
        "option_A": "Create a prioritized list of issues",
        "option_B": "Choose specific screens or interactions to focus on",
        "correct_anwser": "B",
        "explain": "Bước đầu tiên trong đánh giá Heuristic là xác định phạm vi đánh giá, tức chọn các màn hình hoặc luồng tương tác cụ thể cần tập trung kiểm tra.",
        "option_C": "Conduct user interviews",
        "option_D": "Test the system's speed"
      },
      {
        "question_id": 175,
        "question_title": "What does the Gulf of Execution refer to?",
        "option_A": "The gap when users interpret the results of their actions",
        "option_B": "The difficulty in understanding the actions required to achieve a goal",
        "correct_anwser": "B",
        "explain": "Gulf of Execution (Khoảng cách thực thi) mô tả sự khó khăn khi người dùng cố gắng hiểu và tìm ra các hành động cần thiết để đạt được mục tiêu của mình.",
        "option_C": "The gap when the goal is too complex to reach",
        "option_D": "The failure of actions when feedback is not provided"
      },
      {
        "question_id": 176,
        "question_title": "What is the primary purpose of conducting user interviews in UX research?",
        "option_A": "To test the final product",
        "option_B": "To gather quantitative data",
        "correct_anwser": "C",
        "explain": "Mục đích chính của phỏng vấn người dùng là thu thập thông tin định tính nhằm hiểu sâu về nhu cầu, thói quen và hành vi của họ.",
        "option_C": "To understand user needs and behaviors",
        "option_D": "To train new designers"
      },
      {
        "question_id": 177,
        "question_title": "What is the purpose of sketching in UX design?",
        "option_A": "To finalize the design",
        "option_B": "To reflect, explore, and communicate design concepts",
        "correct_anwser": "B",
        "explain": "Phác thảo giúp nhà thiết kế suy ngẫm, khám phá nhiều ý tưởng khác nhau và truyền đạt các khái niệm thiết kế một cách nhanh chóng.",
        "option_C": "To create perfect visuals",
        "option_D": "To avoid feedback from users"
      },
      {
        "question_id": 178,
        "question_title": "What is the primary focus of Heuristic Evaluation?",
        "option_A": "To analyze system speed and performance",
        "option_B": "To review a UI using Nielsen's 10 heuristics",
        "correct_anwser": "B",
        "explain": "Đánh giá Heuristic tập trung vào việc chuyên gia rà soát giao diện người dùng dựa trên các nguyên tắc thiết kế chuẩn (như 10 nguyên tắc heuristic của Jakob Nielsen).",
        "option_C": "To conduct focus groups with real users",
        "option_D": "To test the visual appeal of the design"
      },
      {
        "question_id": 181,
        "question_title": "Which of the following best describes a 'persona' in UX design?",
        "option_A": "A fictional character representing a user type",
        "option_B": "A real user interviewed during research",
        "correct_anwser": "A",
        "explain": "Persona là một nhân vật hư cấu đại diện cho một nhóm người dùng mục tiêu dựa trên dữ liệu nghiên cứu thực tế.",
        "option_C": "A list of product features",
        "option_D": "A prototype of the final product"
      },
      {
        "question_id": 182,
        "question_title": "A team proposes bypassing heuristic evaluation and moving directly to user testing for a website design. How would you assess this decision based on UX evaluation principles?",
        "option_A": "Support it, as user testing is always superior",
        "option_B": "Oppose it, as heuristic evaluation is faster and finds different issues",
        "correct_anwser": "B",
        "explain": "Nên phản đối việc bỏ qua Heuristic Evaluation vì phương pháp này nhanh hơn, tiết kiệm chi phí và phát hiện các lỗi usability phổ biến trước khi tiến hành kiểm thử phức tạp với người dùng.",
        "option_C": "Support it, as heuristic evaluation is unnecessary",
        "option_D": "Oppose it, as user testing requires more evaluators"
      },
      {
        "question_id": 183,
        "question_title": "Which of the following is the MOST TRUE statement?",
        "option_A": "It's better to get a low response rate from a small sample than it is to get a high response rate from a big sample.",
        "option_B": "Response rates are only important for national, probability studies.",
        "correct_anwser": "D",
        "explain": "Tỷ lệ phản hồi (response rate) cao trên một mẫu nhỏ giảm thiểu rủi ro chênh lệch phi phản hồi (non-response bias) và mang lại dữ liệu đại diện chất lượng hơn so với việc khảo sát một mẫu rất lớn nhưng tỷ lệ phản hồi lại thấp.",
        "option_C": "Response rates are not connected to survey quality.",
        "option_D": "It's better to get a high response rate from a small sample than a low response rate from a big sample."
      },
      {
        "question_id": 184,
        "question_title": "What method would you develop to boost survey response rates for a mobile app?",
        "option_A": "Use complex survey jargon",
        "option_B": "Offer incentives, clear opt-outs",
        "correct_anwser": "B",
        "explain": "Việc đưa ra ưu đãi/phần thưởng (incentives) và cung cấp tùy chọn hủy/thoát rõ ràng (clear opt-outs) là chiến lược hiệu quả nhất để khuyến khích người dùng tham gia và hoàn thành khảo sát.",
        "option_C": "Require all questions be answered",
        "option_D": "Hide the survey's purpose"
      },
      {
        "question_id": 185,
        "question_title": "Which of the following is NOT a reason you would want to have a high response rate?",
        "option_A": "If you want to be more confident that you've detected a difference/change.",
        "option_B": "If your population is very heterogeneous.",
        "correct_anwser": "C",
        "explain": "Tỷ lệ phản hồi cao làm tăng tính đại diện và độ chính xác của kết quả, giúp phát hiện sự thay đổi nhỏ hoặc phục vụ quần thể đa dạng. Tuy nhiên, việc thực hiện các phân tích thống kê phức tạp phụ thuộc chủ yếu vào kích thước mẫu (sample size) và loại dữ liệu thu thập chứ không phụ thuộc vào tỷ lệ phản hồi.",
        "option_C": "If you want to be able to conduct more complicated statistical analyses.",
        "option_D": "If you want to detect smaller, or more subtle differences/changes."
      },
      {
        "question_id": 186,
        "question_title": "How would you structure a preference test to compare two checkout designs?",
        "option_A": "Use only yes/no questions",
        "option_B": "Mix rating and open questions",
        "correct_anwser": "B",
        "explain": "Kết hợp câu hỏi đánh giá theo thang điểm (định lượng) và câu hỏi mở (định tính) giúp vừa đo lường mức độ yêu thích vừa hiểu được lý do đằng sau sự lựa chọn của người dùng.",
        "option_C": "Test one design per user group",
        "option_D": "Avoid using visual mockups"
      },
      {
        "question_id": 187,
        "question_title": "What is a common source of error in UX surveys that can affect data quality?",
        "option_A": "High response rates",
        "option_B": "Clear and concise questions",
        "correct_anwser": "C",
        "explain": "Các câu hỏi mơ hồ (ambiguous) hoặc mang tính dẫn dắt (leading questions) là nguyên nhân hàng đầu gây ra sai số và thiên lệch dữ liệu trong khảo sát UX.",
        "option_C": "Ambiguous or leading questions",
        "option_D": "Use of multiple-choice questions"
      },
      {
        "question_id": 188,
        "question_title": "Besides usability testing, what is another research method that can be conducted remotely?",
        "option_A": "Product assembly",
        "option_B": "Diary studies",
        "correct_anwser": "B",
        "explain": "Diary studies (Nghiên cứu nhật ký người dùng) là phương pháp nghiên cứu trải nghiệm theo thời gian rất phổ biến có thể dễ dàng thực hiện từ xa thông qua công cụ trực tuyến.",
        "option_C": "Server maintenance",
        "option_D": "Eye-tracking in physical stores"
      },
      {
        "question_id": 189,
        "question_title": "What is a primary reason for using surveys in UX research?",
        "option_A": "To replace qualitative methods",
        "option_B": "To collect data from many users",
        "correct_anwser": "B",
        "explain": "Mục đích chính của khảo sát (surveys) là thu thập dữ liệu định lượng từ một lượng lớn người dùng một cách nhanh chóng và chi phí tối ưu.",
        "option_C": "To eliminate need for analytics",
        "option_D": "To focus on expert opinions only"
      },
      {
        "question_id": 190,
        "question_title": "What is ",
        "option_A": "The number of pages visited during a single user session",
        "option_B": "The time spent on each page by a user",
        "correct_anwser": "A",
        "explain": "Khái niệm Page depth (độ sâu của trang) trong phân tích web đo lường số lượng trang mà một người dùng xem trong một phiên truy cập (session).",
        "option_C": "The number of visitors who return to the site regularly",
        "option_D": "The number of clicks on a page's primary button"
      },
      {
        "question_id": 191,
        "question_title": "Which sampling method should be used when aiming to minimize bias and ensure generalizability in research findings?",
        "option_A": "Convenience sampling",
        "option_B": "Probability sampling",
        "correct_anwser": "B",
        "explain": "Probability sampling (Chọn mẫu theo xác suất) đảm bảo mọi đối tượng trong quần thể có cơ hội được chọn như nhau, giúp tối thiểu hóa định kiến (bias) và có thể tổng quát hóa kết quả.",
        "option_C": "Purposeful sampling",
        "option_D": "Non-probability sampling"
      },
      {
        "question_id": 192,
        "question_title": "Which of the following is an example of purposive sampling?",
        "option_A": "Asking your female friends to respond to a survey via Facebook and Twitter requests.",
        "option_B": "Asking people who use a site's shopping cart how they feel about that experience.",
        "correct_anwser": "B",
        "explain": "Purposive sampling (Chọn mẫu có mục đích) là chọn những nhóm đối tượng có đặc điểm hoặc trải nghiệm cụ thể liên quan trực tiếp đến nghiên cứu, ví dụ như hỏi chính những người đang sử dụng giỏ hàng về trải nghiệm giỏ hàng.",
        "option_C": "Emailing a random sample of employees who started at the company this year based on a list provided by HR.",
        "option_D": "Asking one group of respondents to forward the survey invite to their social networks."
      },
      {
        "question_id": 193,
        "question_title": "How should affinity clusters be labeled?",
        "option_A": "With specific, precise titles that capture the essence of the common theme",
        "option_B": "With random titles for easier identification",
        "correct_anwser": "A",
        "explain": "Khi gắn nhãn cho các nhóm ý tưởng (affinity clusters), tiêu đề cần cụ thể và chính xác để phản ánh đúng bản chất của chủ đề chung mà nhóm đó đại diện.",
        "option_C": "With labels that focus solely on the user demographics",
        "option_D": "With vague, general titles to avoid bias"
      },
      {
        "question_id": 194,
        "question_title": "Which of the following best describes the correct approach to note-taking?",
        "option_A": "Writing down only the main ideas using brief phrases and key details.",
        "option_B": "Recording only the information that won't be captured by audio or video.",
        "correct_anwser": "C",
        "explain": "Trong nghiên cứu UX, không có một phương pháp ghi chép đơn lẻ nào là duy nhất đúng; phương pháp ghi chép có thể linh hoạt tùy thuộc vào bối cảnh và công cụ hỗ trợ.",
        "option_C": "Accepting that there isn't a single correct method for taking notes.",
        "option_D": "Noting only the follow-up questions you plan to ask later in the conversation."
      },
      {
        "question_id": 195,
        "question_title": "How are personas useful in user needs assessments?",
        "option_A": "They help summarize quantitative data collected through surveys",
        "option_B": "They provide archetypes that represent different subsets of users, helping design teams understand user motivations",
        "correct_anwser": "B",
        "explain": "Persona đóng vai trò là hình mẫu đại diện cho các nhóm người dùng khác nhau, giúp nhóm thiết kế thấu hiểu động lực, nhu cầu và hành vi của người dùng.",
        "option_C": "They offer insights into market trends",
        "option_D": "They analyze the effectiveness of product features"
      },
      {
        "question_id": 196,
        "question_title": "In-situ observation is particularly useful for",
        "option_A": "Understanding user behavior in their natural environment",
        "option_B": "Testing the technical performance of a product",
        "correct_anwser": "A",
        "explain": "In-situ observation (quan sát tại chỗ) là phương pháp quan sát người dùng thực hiện công việc trực tiếp trong môi trường tự nhiên thực tế của họ.",
        "option_C": "Conducting large-scale surveys",
        "option_D": "Gathering statistical data on user preferences"
      },
      {
        "question_id": 199,
        "question_title": "What is a common challenge when conducting in-situ observations?",
        "option_A": "Participants behaving unnaturally due to being observed",
        "option_B": "Difficulty in accessing the user's environment",
        "correct_anwser": "A",
        "explain": "Thách thức phổ biến nhất khi quan sát trực tiếp (hiệu ứng Hawthorne) là đối tượng nghiên cứu có thể hành xử không tự nhiên do biết mình đang bị quan sát.",
        "option_C": "Collecting too much quantitative data",
        "option_D": "Lack of visual data"
      },
      {
        "question_id": 201,
        "question_title": "What is the goal of labeling clusters in the affinity wall method?",
        "option_A": "To create catchy titles for each cluster",
        "option_B": "To summarize the common theme or issue represented by the notes in the cluster",
        "correct_anwser": "B",
        "explain": "Mục tiêu của việc dán nhãn nhóm trong sơ đồ đồng điệu là tóm tắt chủ đề chung hoặc vấn đề cốt lõi mà các ghi chú trong nhóm đó đại diện.",
        "option_C": "To provide a detailed breakdown of each user's feedback",
        "option_D": "To list all the observations without organizing them"
      },
      {
        "question_id": 202,
        "question_title": "How does qualitative research differ from quantitative research?",
        "option_A": "Qualitative research focuses on understanding in-depth user behavior and experiences, while quantitative research focuses on numerical data",
        "option_B": "Qualitative research provides statistical data, while quantitative research focuses on user behavior",
        "correct_anwser": "A",
        "explain": "Nghiên cứu định tính tập trung vào việc hiểu sâu về hành vi, cảm xúc và trải nghiệm người dùng, trong khi nghiên cứu định lượng tập trung vào đo lường dữ liệu bằng con số.",
        "option_C": "Quantitative research is more subjective than qualitative research",
        "option_D": "Qualitative research involves automated data analysis"
      },
      {
        "question_id": 203,
        "question_title": "Which of the following data types is arguably the most important to capture when conducting a formative, problem-finding user test?",
        "option_A": "Critical incidents",
        "option_B": "Perceived usability",
        "correct_anwser": "A",
        "explain": "Trong formative testing nhằm tìm lỗi thiết kế, việc ghi nhận các sự cố nghiêm trọng (critical incidents) - những thời điểm người dùng gặp vướng mắc lớn hoặc thất bại khi thực hiện tác vụ - là loại dữ liệu quan trọng nhất.",
        "option_C": "Suggested improvements",
        "option_D": "Participant demographics"
      },
      {
        "question_id": 204,
        "question_title": "Which of the following is typically NOT TRUE of user testing?",
        "option_A": "You should not know who the test participants are, and they should not know who you are.",
        "option_B": "You should observe test participants using the system directly.",
        "correct_anwser": "A",
        "explain": "User testing thông thường không yêu cầu giấu danh tính 2 chiều hoàn toàn (double-blind) như trong một số thử nghiệm y học/khoa học. Điều quan trọng là phải quan sát người dùng thực hiện nhiệm vụ cụ thể.",
        "option_C": "You should recruit test participants who are representative of your target users.",
        "option_D": "You should give test participants specific tasks to carry out using the system."
      },
      {
        "question_id": 205,
        "question_title": "What type of user testing is designed to verify if the system meets performance goals like task completion time or error rate?",
        "option_A": "Formative Testing",
        "option_B": "Benchmark Testing",
        "correct_anwser": "B",
        "explain": "Benchmark testing được thiết kế để đo lường và xác nhận xem hệ thống có đạt các mục tiêu hiệu suất định lượng cụ thể (như thời gian hoàn thành nhiệm vụ hay tỷ lệ lỗi) hay không.",
        "option_C": "Problem Identification Testing",
        "option_D": "Comparative Testing"
      },
      {
        "question_id": 207,
        "question_title": "Designers often refer to the notion of the ",
        "option_A": "Physical space (like a design studio) where design activities take place",
        "option_B": "Space into which the design has to fit (e.g., the size of the screen of a mobile phone)",
        "correct_anwser": "D",
        "explain": "Design space (không gian thiết kế) khái niệm hóa tập hợp tất cả các giải pháp và phương án khả thi mà một thiết kế có thể hướng tới.",
        "option_C": "Properties of the space (e.g., location, shape of the room) where the design will be used",
        "option_D": "The range of alternative ways that a design solution can work"
      },
      {
        "question_id": 208,
        "question_title": "When making a recommendation for how to address a problem, you should consider all of the following EXCEPT:",
        "option_A": "Identifying best practices from competitors' products",
        "option_B": "Declining to provide a recommendation, admitting you have no good ideas",
        "correct_anwser": "B",
        "explain": "Từ chối đưa ra khuyến nghị và thừa nhận không có ý tưởng không phải là một cách tiếp cận chuyên nghiệp khi đề xuất giải pháp UX.",
        "option_C": "Suggesting further research to better characterize the problem",
        "option_D": "Recommending an iterative design process to find the best solution"
      },
      {
        "question_id": 209,
        "question_title": "A test task uses the term ",
        "option_A": "Leave it as is",
        "option_B": "Add more technical jargon",
        "correct_anwser": "C",
        "explain": "Khi viết kịch bản tác vụ kiểm thử, cần tránh dùng đúng các thuật ngữ hiển thị trên UI (như ",
        "option_C": "Reword it to avoid interface-specific terms",
        "option_D": "Ask users to guess the meaning"
      },
      {
        "question_id": 210,
        "question_title": "What is the most appropriate way for a user test moderator to respond when a participant expresses confusion?",
        "option_A": "Ignore the confusion and continue with the tasks",
        "option_B": "Prompt the participant with clarifying questions to understand the issue better",
        "correct_anwser": "B",
        "explain": "Người điều phối (moderator) nên đặt các câu hỏi làm rõ (như ",
        "option_C": "Provide the participant with answers to solve the problem",
        "option_D": "Encourage the participant to skip the task"
      },
      {
        "question_id": 211,
        "question_title": "Which type of recruiting criteria would the following question screen for?\\n",
        "option_A": "Expertise",
        "option_B": "Behavioral",
        "correct_anwser": "B",
        "explain": "Câu hỏi tần suất/thời gian thực hiện một hành động cụ thể trong quá khứ (số giờ học) thuộc nhóm tiêu chí lọc theo hành vi (Behavioral criteria).",
        "option_C": "Characteristic",
        "option_D": "Attitudinal"
      },
      {
        "question_id": 212,
        "question_title": "What is a primary goal when analyzing data from user tests?",
        "option_A": "To confirm that the design meets business objectives",
        "option_B": "To identify areas where users encounter difficulties",
        "correct_anwser": "B",
        "explain": "Mục tiêu chính khi phân tích dữ liệu kiểm thử người dùng là phát hiện những điểm/khu vực mà người dùng gặp khó khăn trong quá trình sử dụng.",
        "option_C": "To validate the technical feasibility of the design",
        "option_D": "To assess the aesthetic appeal of the interface"
      },
      {
        "question_id": 213,
        "question_title": "What makes a problem \"wicked\" in design?",
        "option_A": "It has no single clear solution",
        "option_B": "It relates to app performance issues",
        "correct_anwser": "A",
        "explain": "Vấn đề \"wicked\" (nan giải) trong thiết kế là loại vấn đề phức tạp, không có giải pháp đúng/sai rõ ràng hay duy nhất, chịu ảnh hưởng bởi nhiều yếu tố và quan điểm khác nhau, nên đáp án A là chính xác.",
        "option_C": "It requires coding expertise",
        "option_D": "It is solved through visual design"
      },
      {
        "question_id": 214,
        "question_title": "In the \"Questions, Options, Criteria\" framework, what does \"Criteria\" refer to?",
        "option_A": "The possible solutions to a design problem",
        "option_B": "The questions that need answers",
        "correct_anwser": "C",
        "explain": "Trong khung QOC, \"Questions\" là các vấn đề thiết kế cần giải quyết, \"Options\" là các giải pháp khả thi, còn \"Criteria\" là các tiêu chí/thước đo dùng để đánh giá và so sánh các Option đó, nên đáp án C đúng.",
        "option_C": "The standards used to evaluate different design options",
        "option_D": "The tools used in prototyping"
      },
      {
        "question_id": 215,
        "question_title": "One of the questions a wireframe cannot answer is:",
        "option_A": "Does the overall layout make sense?",
        "option_B": "Are proper navigation elements provided?",
        "correct_anwser": "D",
        "explain": "Wireframe chỉ tập trung vào bố cục, cấu trúc và chức năng của giao diện, không thể hiện màu sắc hay yếu tố thẩm mỹ, nên câu hỏi về màu sắc (đáp án D) không thể trả lời qua wireframe.",
        "option_C": "Which components should appear on the screen?",
        "option_D": "Is the color scheme visually appealing?"
      },
      {
        "question_id": 217,
        "question_title": "Which of the following best represents the key stages of the design process?",
        "option_A": "Sketching, coding, testing, launching",
        "option_B": "Framing, exploring, refining, finalizing",
        "correct_anwser": "B",
        "explain": "Quy trình thiết kế UX điển hình gồm các giai đoạn: xác định khung vấn đề (Framing), khám phá giải pháp (Exploring), tinh chỉnh (Refining) và hoàn thiện (Finalizing), tương ứng đáp án B.",
        "option_C": "Planning, wireframing, prototyping, feedback",
        "option_D": "Researching, modeling, developing, shipping"
      },
      {
        "question_id": 218,
        "question_title": "Which of the following is NOT a type of passive input?",
        "option_A": "Application data like contacts, calendar events, or user's health information (e.g., steps)",
        "option_B": "Weather data",
        "correct_anwser": "C",
        "explain": "Passive input là dữ liệu hệ thống tự thu thập mà không cần người dùng chủ động thao tác. Việc người dùng tự chụp ảnh bằng camera là hành động chủ động (active input), nên đáp án C không phải là passive input.",
        "option_C": "Picture taken by the user using the phone camera",
        "option_D": "User's current location"
      },
      {
        "question_id": 219,
        "question_title": "What does the designer need to know in order to design effective output?",
        "option_A": "What information the user needs to accomplish the task",
        "option_B": "Context in which the information will be accessed",
        "correct_anwser": "D",
        "explain": "Để thiết kế output hiệu quả, nhà thiết kế cần hiểu cả thông tin người dùng cần, bối cảnh sử dụng, và nền tảng kiến thức của người dùng — tất cả các yếu tố này đều quan trọng, nên đáp án đúng là D (tất cả các ý trên).",
        "option_C": "User's knowledge base",
        "option_D": "All of the others"
      },
      {
        "question_id": 220,
        "question_title": "Designing thoughtful defaults is important for several reasons. Which of the following is not a reason for designing good defaults.",
        "option_A": "Defaults define out-of-the-box experience",
        "option_B": "Defaults are easily changed.",
        "correct_anwser": "B",
        "explain": "Trên thực tế, phần lớn người dùng hiếm khi thay đổi cài đặt mặc định, nên \"Defaults are easily changed\" không phải là lý do khiến việc thiết kế default tốt trở nên quan trọng; ngược lại, chính vì ít bị thay đổi nên default cần được thiết kế cẩn thận.",
        "option_C": "Defaults decrease onboarding time",
        "option_D": "Defaults can have large consequences."
      },
      {
        "question_id": 221,
        "question_title": "Which position on the social effects of technology claims that technological adoption is primarily governed by the needs of different social groups and that it has little to do with the properties of the actual technology?",
        "option_A": "Social determinists",
        "option_B": "Technical determinists",
        "correct_anwser": "A",
        "explain": "Thuyết \"Social determinism\" (quyết định luận xã hội) cho rằng việc áp dụng công nghệ chủ yếu do nhu cầu và bối cảnh xã hội quyết định, chứ không phải do đặc tính vốn có của công nghệ, khác với \"Technical determinism\" (công nghệ quyết định xã hội), nên đáp án đúng là A.",
        "option_C": "Interactionists"
      },
      {
        "question_id": 222,
        "question_title": "What are the stages of visual perception?",
        "option_A": "Perception, Memory, Response",
        "option_B": "Feature detection, pattern recognition, object recognition",
        "correct_anwser": "B",
        "explain": "Nhận thức thị giác (visual perception) trải qua các giai đoạn: phát hiện đặc trưng (feature detection) - nhận diện các thành phần cơ bản như đường nét, màu sắc; nhận diện mẫu (pattern recognition) - kết hợp các đặc trưng thành hình dạng; và nhận diện đối tượng (object recognition) - xác định đó là vật gì, nên đáp án B đúng.",
        "option_C": "Visual search, cognitive processing, feedback",
        "option_D": "Short-term memory, long-term memory, object recall."
      },
      {
        "question_id": 223,
        "question_title": "What is the 4-point severity scale used for in Heuristic Evaluation?",
        "option_A": "To assess the cost of resolving an issue",
        "option_B": "To prioritize usability issues based on their severity",
        "correct_anwser": "B",
        "explain": "Thang đo mức độ nghiêm trọng 4 điểm trong Heuristic Evaluation giúp đánh giá và xếp hạng mức độ nghiêm trọng của các vấn đề usability được phát hiện, từ đó ưu tiên xử lý những vấn đề quan trọng nhất trước, nên đáp án B đúng.",
        "option_C": "To track the amount of user feedback received",
        "option_D": "To measure the visual appeal of the UI"
      },
      {
        "question_id": 224,
        "question_title": "What is one benefit of iterative prototyping in UX design?",
        "option_A": "It helps designers avoid testing the product",
        "option_B": "It allows the final product to be delivered without any mistakes",
        "correct_anwser": "C",
        "explain": "Prototyping lặp lại (iterative prototyping) cho phép nhà thiết kế liên tục thu thập phản hồi từ người dùng qua từng vòng lặp và tối ưu hóa sản phẩm dựa trên phản hồi đó, nên đáp án C đúng.",
        "option_C": "It ensures the product is optimized based on user feedback",
        "option_D": "It reduces the number of features in the product"
      },
      {
        "question_id": 225,
        "question_title": "A website's help documentation is lengthy and not task-focused. How would you assess this based on the course's principles?",
        "option_A": "It is acceptable, as long documentation covers all scenarios",
        "option_B": "It violates help and documentation heuristic, as it should be concise and task-oriented",
        "correct_anwser": "B",
        "explain": "Theo nguyên tắc Heuristic \"Help and Documentation\" của Nielsen, tài liệu hướng dẫn nên ngắn gọn, tập trung vào nhiệm vụ cụ thể (task-oriented) và dễ tìm kiếm, việc tài liệu dài dòng không tập trung vào tác vụ là vi phạm nguyên tắc này, nên đáp án B đúng.",
        "option_C": "It supports aesthetic and minimalist design by providing details",
        "option_D": "It aligns with flexibility and efficiency of use for expert users"
      },
      {
        "question_id": 226,
        "question_title": "What does a prototype help designers achieve?",
        "option_A": "Testing ideas, assessing user needs, and reflecting on the design",
        "option_B": "Defining user personas",
        "correct_anwser": "A",
        "explain": "Prototype giúp nhà thiết kế thử nghiệm ý tưởng, đánh giá xem sản phẩm có đáp ứng nhu cầu người dùng hay không, và suy ngẫm để cải thiện thiết kế trước khi phát triển sản phẩm hoàn chỉnh, nên đáp án A đúng.",
        "option_C": "Creating high-quality visuals",
        "option_D": "Avoiding the design process"
      },
      {
        "question_id": 227,
        "question_title": "In designing a mobile app, how would you incorporate the course's concept of \"adoptability\" to enhance the user onboarding experience?",
        "option_A": "Require users to create an account before using the app",
        "option_B": "Provide a lengthy tutorial before granting access",
        "correct_anwser": "C",
        "explain": "\"Adoptability\" (khả năng dễ tiếp nhận) nhấn mạnh việc giúp người dùng mới bắt đầu sử dụng sản phẩm dễ dàng và nhanh chóng nhất có thể, cho phép trải nghiệm ngay tính năng cốt lõi mà không cần đăng ký hay rào cản ban đầu, nên đáp án C đúng.",
        "option_C": "Allow users to start using core features immediately without registration",
        "option_D": "Include complex navigation menus from the start"
      },
      {
        "question_id": 228,
        "question_title": "Which principle in UX design emphasizes the importance of consistency in interface design?",
        "option_A": "Visual hierarchy principle",
        "option_B": "Accessibility principle",
        "correct_anwser": "C",
        "explain": "Nguyên tắc nhất quán (Consistency principle) trực tiếp nhấn mạnh tầm quan trọng của việc giữ giao diện đồng nhất về cách trình bày, hành vi và thuật ngữ trong toàn bộ sản phẩm, nên đáp án C đúng.",
        "option_C": "Consistency principle",
        "option_D": "Feedback principle"
      },
      {
        "question_id": 229,
        "question_title": "Which of the following is a primary goal of UX design? What are the four main elements of User Experience?",
        "option_A": "Value, Usability, Adaptability and Reliability",
        "option_B": "Value, Usability, Adaptability and Desirability",
        "correct_anwser": "C",
        "explain": "Bốn yếu tố chính của trải nghiệm người dùng theo course thường được đề cập là: Giá trị (Value), Khả năng sử dụng (Usability), Độ tin cậy (Reliability) và Tính hấp dẫn (Desirability), nên đáp án C đúng.",
        "option_C": "Value, Usability, Reliability and Desirability",
        "option_D": "Value, Reliability, Adaptability and Desirability"
      },
      {
        "question_id": 230,
        "question_title": "What is the primary benefit of using personas in UX design?",
        "option_A": "To gather demographic data and analyze user patterns",
        "option_B": "To create user-centered designs",
        "correct_anwser": "B",
        "explain": "Persona giúp nhà thiết kế hình dung rõ nét về người dùng mục tiêu (mục tiêu, hành vi, nhu cầu), từ đó đưa ra các quyết định thiết kế lấy người dùng làm trung tâm (user-centered design), nên đáp án B đúng.",
        "option_C": "To perform usability testing on early prototypes",
        "option_D": "To design aesthetic interfaces with visual appeal"
      },
      {
        "question_id": 231,
        "question_title": "Because some users learn how to use a system through trial and error, it is important to:",
        "option_A": "provide extensive documentation to ensure that users always do the right thing",
        "option_B": "force users to undergo training before using a system so they don't break anything",
        "correct_anwser": "D",
        "explain": "Vì người dùng thường học hệ thống qua thử và sai (trial and error), việc hỗ trợ chức năng \"undo\" và \"redo\" giúp họ dễ dàng khắc phục lỗi khi thử nghiệm mà không sợ hậu quả nghiêm trọng, khuyến khích khám phá tự do, nên đáp án D đúng.",
        "option_C": "provide users with only one option at a time so that they cannot make mistakes",
        "option_D": "support \"undo\" and \"redo\" to help users recover from mistakes"
      },
      {
        "question_id": 232,
        "question_title": "What is the significance of user-centered design in survey creation?",
        "option_A": "Enhancing participant engagement",
        "option_B": "Increasing survey length",
        "correct_anwser": "A",
        "explain": "Thiết kế khảo sát lấy người dùng làm trung tâm giúp câu hỏi rõ ràng, phù hợp và dễ trả lời, từ đó tăng mức độ tham gia và cam kết hoàn thành khảo sát của người tham gia, nên đáp án A đúng.",
        "option_C": "Using complex question formats",
        "option_D": "Emphasizing irrelevant information"
      },
      {
        "question_id": 233,
        "question_title": "When designing a UX survey, why is it important to define the target population?",
        "option_A": "To ensure the survey is completed quickly",
        "option_B": "To reduce the number of questions needed",
        "correct_anwser": "C",
        "explain": "Xác định đối tượng mục tiêu (target population) đảm bảo dữ liệu thu thập được đến từ những người dùng đại diện chính xác cho nhóm người mà sản phẩm hướng tới, giúp kết quả khảo sát có giá trị và đáng tin cậy, nên đáp án C đúng.",
        "option_C": "To gather data from users who best represent the intended audience",
        "option_D": "To simplify the data analysis process"
      },
      {
        "question_id": 234,
        "question_title": "What term is used to describe the set of questions you ask survey participants?",
        "option_A": "Respondent",
        "option_B": "Instrument",
        "correct_anwser": "B",
        "explain": "Trong nghiên cứu khảo sát, thuật ngữ \"Instrument\" (công cụ khảo sát) dùng để chỉ toàn bộ tập hợp câu hỏi được đưa ra cho người tham gia, nên đáp án B đúng.",
        "option_C": "Frame",
        "option_D": "Population"
      },
      {
        "question_id": 235,
        "question_title": "How can survey researchers minimize the cognitive burden on participants?",
        "option_A": "By asking long, open-ended questions",
        "option_B": "By using complex skip patterns and technical jargon",
        "correct_anwser": "C",
        "explain": "Để giảm gánh nặng nhận thức (cognitive burden) cho người tham gia, nhà nghiên cứu nên thiết kế khảo sát đơn giản, rõ ràng và đi thẳng vào trọng tâm, tránh câu hỏi dài dòng hay thuật ngữ phức tạp, nên đáp án C đúng.",
        "option_C": "By keeping surveys simple, clear, and to the point",
        "option_D": "By asking personal questions to gather detailed insights"
      },
      {
        "question_id": 236,
        "question_title": "How does remote testing improve participant diversity?",
        "option_A": "By only testing users from one geographic location",
        "option_B": "By allowing researchers to gather feedback from participants across multiple locations",
        "correct_anwser": "B",
        "explain": "Kiểm thử từ xa (remote testing) cho phép thu thập phản hồi từ người tham gia ở nhiều địa điểm địa lý khác nhau, giúp tăng tính đa dạng của mẫu nghiên cứu so với kiểm thử tại chỗ, nên đáp án B đúng.",
        "option_C": "By ensuring that all participants use the same device",
        "option_D": "By limiting participant access to users with specific skills"
      },
      {
        "question_id": 237,
        "question_title": "Which of the following is NOT a best practice when creating ordinal closed-ended questions?",
        "option_A": "Provide a balanced scale",
        "option_B": "Use specific metrics rather than vague quantifiers",
        "correct_anwser": "C",
        "explain": "Thực hành tốt khi tạo câu hỏi đóng dạng thứ bậc (ordinal) là nên gắn nhãn rõ ràng cho các mức lựa chọn để người trả lời hiểu đúng ý nghĩa, do đó \"tránh gắn nhãn danh mục phản hồi\" là điều KHÔNG nên làm, nên đáp án C đúng (là đáp án sai/không phải best practice).",
        "option_C": "Avoid labeling response categories",
        "option_D": "Choose between unipolar and bipolar scales"
      },
      {
        "question_id": 239,
        "question_title": "What is the primary advantage of using online surveys in UX research?",
        "option_A": "They guarantee higher response rates",
        "option_B": "They eliminate the need for data analysis",
        "correct_anwser": "C",
        "explain": "Khảo sát trực tuyến cho phép thu thập dữ liệu nhanh chóng từ một lượng lớn người tham gia ở phạm vi rộng, đây là lợi thế chính so với các phương pháp khảo sát truyền thống khác, nên đáp án C đúng.",
        "option_C": "They allow for quick data collection from a broad audience",
        "option_D": "They ensure more accurate responses than in-person interviews"
      },
      {
        "question_id": 241,
        "question_title": "Why design surveys to maximize clarity and minimize time?",
        "option_A": "To increase error",
        "option_B": "For accurate data",
        "correct_anwser": "B",
        "explain": "Thiết kế khảo sát rõ ràng và tốn ít thời gian giúp người tham gia hiểu đúng câu hỏi và trả lời trung thực, giảm sai số, từ đó thu được dữ liệu chính xác hơn, nên đáp án B đúng.",
        "option_C": "To prioritize stakeholders",
        "option_D": "To reduce sampling needs"
      },
      {
        "question_id": 242,
        "question_title": "What is the primary purpose of conducting a user needs assessment in UX research?",
        "option_A": "To evaluate the technical performance of a product",
        "option_B": "To understand the needs, behaviors, and goals of users",
        "correct_anwser": "B",
        "explain": "Mục đích chính của việc đánh giá nhu cầu người dùng (user needs assessment) trong nghiên cứu UX là để hiểu rõ nhu cầu, hành vi và mục tiêu của người dùng, từ đó làm cơ sở cho việc thiết kế sản phẩm phù hợp, nên đáp án B đúng.",
        "option_C": "To test the market viability of a product",
        "option_D": "To develop marketing strategies for a product"
      },
      {
        "question_id": 245,
        "question_title": "Which of the following best describes qualitative research in the context of UX?",
        "option_A": "Research focused on numerical data and statistics",
        "option_B": "Research aimed at understanding user behaviors and motivations through observation and interviews",
        "correct_anwser": "B",
        "explain": "Nghiên cứu định tính (qualitative research) trong UX tập trung vào việc hiểu sâu hành vi và động cơ của người dùng thông qua các phương pháp như quan sát và phỏng vấn, thay vì tập trung vào số liệu thống kê, nên đáp án B đúng.",
        "option_C": "Research that uses large-scale surveys to gather user opinions",
        "option_D": "Research that tests the usability of a product through automated tools"
      },
      {
        "question_id": 246,
        "question_title": "What is the primary purpose of creating an affinity wall in UX research?",
        "option_A": "To display user interface designs",
        "option_B": "To organize and analyze qualitative data by grouping related observations",
        "correct_anwser": "B",
        "explain": "Affinity wall (bảng nhóm ý tưởng) được dùng để tổ chức và phân tích dữ liệu định tính bằng cách nhóm các quan sát, ghi chú có liên quan lại với nhau, giúp phát hiện các mẫu hình (pattern) và insight, nên đáp án B đúng.",
        "option_C": "To showcase marketing strategies",
        "option_D": "To present statistical data in a visual format"
      },
      {
        "question_id": 247,
        "question_title": "What type of question is best for encouraging detailed responses?",
        "option_A": "Yes/no questions",
        "option_B": "Ranking questions",
        "correct_anwser": "C",
        "explain": "Câu hỏi mở (open-ended questions) cho phép người trả lời tự do diễn đạt suy nghĩ, cảm nhận và trải nghiệm của họ mà không bị giới hạn bởi các lựa chọn có sẵn, từ đó khuyến khích câu trả lời chi tiết hơn, nên đáp án C đúng.",
        "option_C": "Open-ended questions",
        "option_D": "Multiple choice"
      },
      {
        "question_id": 249,
        "question_title": "After conducting interviews and observations, a UX researcher identifies conflicting user needs. What is an appropriate next step?",
        "option_A": "Disregard the conflicting data as anomalies",
        "option_B": "Prioritize the needs of the majority without further analysis",
        "correct_anwser": "C",
        "explain": "Khi phát hiện nhu cầu người dùng mâu thuẫn nhau, nhà nghiên cứu nên xem xét lại dữ liệu một cách kỹ lưỡng và có thể tiến hành nghiên cứu bổ sung để hiểu rõ nguyên nhân của sự mâu thuẫn đó, thay vì bỏ qua hay vội vàng quyết định, nên đáp án C đúng.",
        "option_C": "Re-examine the data and possibly conduct follow-up research to understand the conflicts",
        "option_D": "Choose the needs that align with the original design goals"
      },
      {
        "question_id": 250,
        "question_title": "What is a key feature of semi-structured interviews in user needs assessments?",
        "option_A": "They are rigid and do not allow for exploration of new insights",
        "option_B": "They balance prepared questions with flexibility to explore new insights",
        "correct_anwser": "B",
        "explain": "Phỏng vấn bán cấu trúc có đặc điểm là kết hợp giữa bộ câu hỏi đã chuẩn bị sẵn với sự linh hoạt để khám phá thêm những insight mới phát sinh trong quá trình trò chuyện, nên đáp án B đúng.",
        "option_C": "They rely solely on open-ended questions without any structure",
        "option_D": "They focus on structured surveys with closed-ended questions"
      },
      {
        "question_id": 251,
        "question_title": "Which type of research method is best suited for gathering in-depth, narrative-based insights from users?",
        "option_A": "Quantitative",
        "option_B": "Analytical",
        "correct_anwser": "C",
        "explain": "Nghiên cứu định tính (qualitative) phù hợp nhất để thu thập những hiểu biết sâu sắc, mang tính tường thuật (narrative-based) từ người dùng, thông qua các phương pháp như phỏng vấn và quan sát, khác với nghiên cứu định lượng tập trung vào số liệu, nên đáp án C đúng.",
        "option_C": "Qualitative",
        "option_D": "Statistical"
      },
      {
        "question_id": 252,
        "question_title": "Which of the following would be a good reason for using a high-end usability testing lab with separate control and observation room?",
        "option_A": "You will be providing a computer for participants to use during the test",
        "option_B": "You will be using the think-aloud protocol",
        "correct_anwser": "D",
        "explain": "Phòng lab cao cấp có phòng điều khiển và phòng quan sát riêng biệt rất hữu ích khi cần mời nhiều bên liên quan (stakeholders) quan sát phiên kiểm thử mà không làm ảnh hưởng hay gây phân tâm cho người tham gia, nên đáp án D đúng.",
        "option_C": "You plan to administer a post-test questionnaire",
        "option_D": "You plan to invite multiple stakeholders to observe the test sessions"
      },
      {
        "question_id": 255,
        "question_title": "What is one of the most important and challenging parts of designing user tests?",
        "option_A": "Users often ignore tasks and do what they want",
        "option_B": "Most users are unfamiliar with usability testing",
        "correct_anwser": "C",
        "explain": "Việc lựa chọn và xây dựng các nhiệm vụ (tasks) phù hợp, thực tế để yêu cầu người dùng thực hiện là một trong những phần quan trọng và khó khăn nhất khi thiết kế kiểm thử người dùng, vì nó ảnh hưởng trực tiếp đến chất lượng dữ liệu thu được, nên đáp án C đúng.",
        "option_C": "Selecting and developing the tasks that you will ask users to perform",
        "option_D": "Tasks must be identical for every test session"
      },
      {
        "question_id": 256,
        "question_title": "Which of the following are research methods that can be applied in formative research?",
        "option_A": "Interviews",
        "option_B": "Observations",
        "correct_anwser": "E",
        "explain": "Nghiên cứu hình thành (formative research) có thể áp dụng nhiều phương pháp khác nhau như phỏng vấn, quan sát, hỏi ý kiến người xung quanh, hay các nhóm thiết kế có sự tham gia của người dùng (participatory design), tất cả đều là các phương pháp hợp lệ, nên đáp án đúng là E (tất cả các ý trên).",
        "option_C": "Asking friends and family members about their experiences",
        "option_D": "Participatory design groups",
        "option_E": "All of the others"
      },
      {
        "question_id": 258,
        "question_title": "Why should tasks be realistic and verifiable in usability tests?",
        "option_A": "To meet academic standards",
        "option_B": "To simplify data entry",
        "correct_anwser": "C",
        "explain": "Nhiệm vụ trong kiểm thử usability cần thực tế và có thể xác minh được để phản ánh đúng hành vi sử dụng thực tế của người dùng, đồng thời cho phép đo lường kết quả một cách khách quan, nên đáp án C đúng.",
        "option_C": "To mirror real behavior and allow measurable outcomes",
        "option_D": "To impress clients"
      },
      {
        "question_id": 259,
        "question_title": "Under what circumstances is remote testing appropriate?",
        "option_A": "I, II, III",
        "option_B": "I, IV",
        "correct_anwser": "A",
        "explain": "Kiểm thử từ xa (remote testing) phù hợp khi: khó tiếp cận sản phẩm/trải nghiệm trực tiếp, cần người tham gia ở nhiều vị trí địa lý khác nhau, thời gian hạn chế, hoặc có nhiều thông tin cá nhân nhạy cảm (PII) cần bảo mật. Tất cả các trường hợp trên đều là lý do hợp lý để chọn remote testing, nên đáp án là 'Tất cả các đáp án trên'.",
        "option_C": "I, III, IV",
        "option_D": "II, III",
        "option_E": "V. All of the above"
      },
      {
        "question_id": 264,
        "question_title": "Which of the following questions is best answered by a qualitative research methodology?",
        "option_A": "What proportion of Gadget X users love Feature Y?",
        "option_B": "What are the different ways in which Gadget X frustrates its users?",
        "correct_anwser": "B",
        "explain": "Nghiên cứu định tính (qualitative) phù hợp để khám phá các loại/cách thức (types/ways) mà người dùng gặp vấn đề, trong khi các câu hỏi về tỷ lệ, doanh thu hay mối tương quan số liệu (A, C, D) cần phương pháp định lượng (quantitative).",
        "option_C": "How will total revenue change if Gadget X's price is reduced by 10%?",
        "option_D": "Does Gadget X tend to increase traffic accidents among its users?"
      },
      {
        "question_id": 265,
        "question_title": "What technique can you use to learn about how large numbers of users navigate through an experience during the Optimization phase?",
        "option_A": "Benchmarking",
        "option_B": "Analytics Review",
        "correct_anwser": "B",
        "explain": "Analytics Review (phân tích dữ liệu hành vi) cho phép quan sát cách một số lượng lớn người dùng thực sự điều hướng qua trải nghiệm sản phẩm dựa trên dữ liệu thực tế, phù hợp cho giai đoạn tối ưu hóa (Optimization) ở quy mô lớn.",
        "option_C": "A/B testing",
        "option_D": "Remote usability testing"
      },
      {
        "question_id": 273,
        "question_title": "Which of the following is NOT a type of sampling?",
        "option_A": "Census",
        "option_B": "Sampling Frame",
        "correct_anwser": "B",
        "explain": "Sampling Frame (khung mẫu) là danh sách các phần tử của tổng thể dùng để chọn mẫu, không phải là một loại phương pháp lấy mẫu. Census, Probability và Convenience đều là các loại/phương pháp lấy mẫu thực sự.",
        "option_C": "Probability",
        "option_D": "Convenience"
      },
      {
        "question_id": 274,
        "question_title": "What kinds of information might be part of qualitative data analysis?\nI. Quotations from interviews.\nII. Observed actions or events.\nIII. Inferred facts from interviews.",
        "option_A": "I only",
        "option_B": "I and II only",
        "correct_anwser": "D",
        "explain": "Phân tích dữ liệu định tính có thể bao gồm cả trích dẫn từ phỏng vấn (I), hành động/sự kiện được quan sát (II), và cả những suy luận rút ra từ phỏng vấn (III) - tất cả đều là các dạng thông tin định tính hợp lệ để phân tích.",
        "option_C": "II only",
        "option_D": "I, II and III"
      },
      {
        "question_id": 275,
        "question_title": "Which of the following are good guidelines for using an interview protocol?\nI. Memorize the protocol, so that you don't have to refer to it that much during the interview itself.\nII. Avoid asking any questions that are not open-ended.\nIII. Ask the questions exactly as they are written and in the order they are written.",
        "option_A": "I only",
        "option_B": "II only",
        "correct_anwser": "A",
        "explain": "Ghi nhớ giao thức phỏng vấn (protocol) để không phải tham khảo quá nhiều trong lúc phỏng vấn là một hướng dẫn tốt, giúp cuộc trò chuyện tự nhiên hơn. Tuy nhiên, không nhất thiết phải chỉ hỏi câu hỏi mở (II sai) và không cần hỏi đúng nguyên văn theo đúng thứ tự cố định (III sai), vì phỏng vấn cần linh hoạt theo ngữ cảnh.",
        "option_C": "III only",
        "option_D": "I and III"
      },
      {
        "question_id": 277,
        "question_title": "When is it most appropriate to conduct remote moderated testing?\nI. Redirection and discussion are required\nII. Users can complete tasks without instruction\nIII. Finding participants local to your lab is challenging\nIV. You want to see and explore user's digital contexts",
        "option_A": "I, II, III",
        "option_B": "I, IV",
        "correct_anwser": "D",
        "explain": "Kiểm thử từ xa có điều phối viên phù hợp khi cần định hướng và thảo luận trực tiếp (I), khi khó tìm người tham gia gần phòng lab (III), và khi muốn khám phá ngữ cảnh số của người dùng (IV). Trường hợp người dùng có thể tự hoàn thành nhiệm vụ mà không cần hướng dẫn (II) thì phù hợp hơn với kiểm thử không điều phối (unmoderated).",
        "option_C": "I, III",
        "option_D": "I, III, IV",
        "option_E": "V. All of the above"
      },
      {
        "question_id": 280,
        "question_title": "Which of the following is NOT something you should consider while writing questions?",
        "option_A": "Avoiding jargon.",
        "option_B": "Keeping language as simple as possible.",
        "correct_anwser": "D",
        "explain": "Khi viết câu hỏi khảo sát, cần tránh biệt ngữ, giữ ngôn ngữ đơn giản, và chỉ hỏi một vấn đề mỗi lần. Việc cố tình làm câu hỏi nghe có vẻ 'khoa học' không phải là nguyên tắc tốt, thậm chí có thể khiến người trả lời khó hiểu hoặc gây hiểu lầm.",
        "option_C": "Ask one question at a time.",
        "option_D": "Making the question sound scientific."
      },
      {
        "question_id": 289,
        "question_title": "This example (Questbook app flow diagram with Home Screen, Character Creation, Character Roster) would most likely be an example of (choose the BEST response):",
        "option_A": "Yes, wireframes need to look like a completely finished product",
        "option_B": "Hi-Fi Prototype",
        "correct_anwser": "B",
        "explain": "Hình ảnh minh họa có màu sắc, chi tiết trực quan đầy đủ, giao diện gần giống sản phẩm hoàn thiện, đây là đặc trưng của Hi-Fi Prototype (nguyên mẫu độ trung thực cao), khác với wireframe hay lo-fi vốn đơn giản, thiếu chi tiết thẩm mỹ.",
        "option_C": "Lo-Fi Prototype",
        "option_D": "Wireframes"
      },
      {
        "question_id": 291,
        "question_title": "Once you have a list of core questions to ask, what should you do next in constructing the interview protocol?\nI. Cluster related questions together.\nII. Try the questions on a potential subject.\nIII. Add follow-up questions.",
        "option_A": "I and II",
        "option_B": "I and III",
        "correct_anwser": "D",
        "explain": "Sau khi có danh sách câu hỏi cốt lõi, cần nhóm các câu hỏi liên quan lại với nhau (I), thử nghiệm bộ câu hỏi với một đối tượng tiềm năng (II - pilot test), và bổ sung các câu hỏi tiếp nối/đào sâu (III) để hoàn thiện giao thức phỏng vấn.",
        "option_C": "II and III",
        "option_D": "I, II and III"
      },
      {
        "question_id": 295,
        "question_title": "What types of research activities are typically engaged in by 2-3 people design teams?\nI. A/B Testing\nII. Feature driven usability testing\nIII. Competitive testing\nIV. Attitudinal analytics (surveys)",
        "option_A": "I",
        "option_B": "II",
        "correct_anwser": "E",
        "explain": "Với đội thiết kế nhỏ (2-3 người), các hoạt động phổ biến thường là kiểm thử khả năng sử dụng theo tính năng (feature driven usability testing) và khảo sát thái độ người dùng (attitudinal analytics/surveys), vì đây là các phương pháp không đòi hỏi quy mô lớn hay hạ tầng phức tạp như A/B testing hoặc competitive testing.",
        "option_C": "III",
        "option_D": "IV",
        "option_E": "II and IV"
      },
      {
        "question_id": 298,
        "question_title": "Some web forms give instantaneous feedback about the validity of data entered into a form field every time a user types a character. This type of \"in-process feedback\" helps usability because:",
        "option_A": "It can be used to manipulate users into providing data they didn't intend to provide",
        "option_B": "It encourages users to look up help and documentation to understand how the system works",
        "correct_anwser": "C",
        "explain": "Phản hồi tức thời (in-process feedback) giúp người dùng nhận biết và sửa lỗi ngay khi đang nhập liệu, từ đó ngăn ngừa lỗi xảy ra trước khi họ hoàn tất và gửi biểu mẫu, cải thiện đáng kể trải nghiệm sử dụng.",
        "option_C": "It helps prevent errors before they happen",
        "option_D": "It keeps users focused on the current task rather than getting distracted"
      },
      {
        "question_id": 324,
        "question_title": "Among responses by interview participants that are relevant to your overarching question, what should you be paying particular attention to?",
        "option_A": "Answers that confirm what you know.",
        "option_B": "Answers that are surprising or unexpected.",
        "correct_anwser": "B",
        "explain": "Những câu trả lời gây bất ngờ hoặc không như mong đợi thường chứa đựng insight giá trị nhất, vì chúng thách thức giả định ban đầu của nhà nghiên cứu và có thể tiết lộ những góc nhìn hay nhu cầu mà nhà nghiên cứu chưa từng nghĩ tới, trong khi câu trả lời chỉ xác nhận điều đã biết thì ít mang lại thông tin mới.",
        "option_C": "Answers delivered without emotion.",
        "option_D": "Answers that show off the participant's cleverness."
      },
      {
        "question_id": 327,
        "question_title": "Which of the following is NOT a best practice when designing ordinal closed-ended questions?",
        "option_A": "Use direct labels",
        "option_B": "Use vague quantifiers rather than specific metrics",
        "correct_anwser": "B",
        "explain": "Thực hành tốt là sử dụng các đại lượng cụ thể, rõ ràng (specific metrics) thay vì các từ định lượng mơ hồ (vague quantifiers như 'thường xuyên', 'thỉnh thoảng') vì chúng có thể được hiểu khác nhau bởi từng người trả lời, dẫn đến dữ liệu không nhất quán và khó so sánh.",
        "option_C": "Provide a balanced scale",
        "option_D": "Provide scales that approximate the real world distribution"
      },
      {
        "question_id": 328,
        "question_title": "What is the main problem with the \"Agree/Disagree\" response scale?",
        "option_A": "Overly familiar to respondents, leading to satisficing",
        "option_B": "Leads to acquiescence bias",
        "correct_anwser": "B",
        "explain": "Thang đo 'Đồng ý/Không đồng ý' dễ dẫn đến acquiescence bias (thiên kiến đồng thuận) - xu hướng người trả lời có khuynh hướng đồng ý với phát biểu bất kể nội dung thực sự, do tâm lý muốn tỏ ra hợp tác hoặc ít phải suy nghĩ, làm sai lệch kết quả khảo sát.",
        "option_C": "Cognitively burdensome",
        "option_D": "Not understood by most respondents"
      },
      {
        "question_id": 329,
        "question_title": "Research at scale can be carried out during the following product development lifecycles:",
        "option_A": "Discovery",
        "option_B": "Design/Development",
        "correct_anwser": "D",
        "explain": "Nghiên cứu quy mô lớn (research at scale) có thể được triển khai xuyên suốt các giai đoạn của vòng đời phát triển sản phẩm, từ khám phá ý tưởng ban đầu (Discovery), thiết kế/phát triển (Design/Development), đến tối ưu hóa sản phẩm sau khi ra mắt (Optimization) - mỗi giai đoạn đều có thể áp dụng nghiên cứu ở quy mô lớn với mục đích khác nhau.",
        "option_C": "Optimization",
        "option_D": "All of the others"
      },
      {
        "question_id": 330,
        "question_title": "Which of the following is NOT important for every survey question?",
        "option_A": "Writing a question that every respondent will interpret in the way the researcher intends.",
        "option_B": "Writing a question that every respondent will answer in the same way.",
        "correct_anwser": "B",
        "explain": "Yêu cầu mọi người trả lời 'theo cùng một cách' là không hợp lý và không thực tế, vì mỗi người có trải nghiệm, quan điểm khác nhau nên câu trả lời tất yếu sẽ khác nhau. Điều quan trọng là câu hỏi được hiểu đúng như ý định nghiên cứu, được trả lời chính xác, và người trả lời sẵn lòng trả lời - chứ không phải ép buộc mọi câu trả lời phải giống nhau.",
        "option_C": "Writing a question that every respondent will respond to accurately.",
        "option_D": "Writing a question that every respondent is willing to answer."
      },
      {
        "question_id": 331,
        "question_title": "What consideration is not important when deciding what platform or technology solution you will use for testing?\nI. Metrics that may be collected\nII. Panel access\nIII. Network speed requirements\nIV. Screen, Audio, or other data collection, as appropriate for test\nV. None of the above",
        "option_A": "I, II, III",
        "option_B": "I, II",
        "correct_anwser": "E",
        "explain": "Tất cả các yếu tố được liệt kê - chỉ số có thể thu thập, khả năng truy cập panel người dùng, yêu cầu tốc độ mạng, và khả năng thu thập màn hình/âm thanh/dữ liệu khác - đều là những cân nhắc quan trọng khi lựa chọn nền tảng hoặc công nghệ cho việc kiểm thử, do đó không có yếu tố nào trong số này là 'không quan trọng'.",
        "option_C": "II, IV",
        "option_D": "I, III, IV",
        "option_E": "V"
      },
      {
        "question_id": 332,
        "question_title": "What preparations should you make ahead of both remote moderated as well as unmoderated testing?\nI. Review alternate paths\nII. Be online 10-15 minutes early\nIII. Determine what metrics to collect and how\nIV. Obtain informed consent\nV. Overrecruit\nVI. All of the above",
        "option_A": "I, II, III",
        "option_B": "I, III, IV, V",
        "correct_anwser": "B",
        "explain": "Đối với cả kiểm thử từ xa có điều phối và không có điều phối, cần chuẩn bị: xem xét các lộ trình thay thế mà người dùng có thể thực hiện, xác định trước các chỉ số cần thu thập và cách thu thập, lấy được sự đồng ý tham gia (informed consent), và tuyển thêm người tham gia dự phòng (overrecruit) để bù đắp cho trường hợp vắng mặt hoặc dữ liệu không hợp lệ. Việc 'online sớm 10-15 phút' (II) chỉ áp dụng riêng cho testing có điều phối viên trực tiếp tương tác, không cần thiết cho unmoderated testing.",
        "option_C": "II, IV, V",
        "option_D": "I, IV",
        "option_E": "VI"
      },
      {
        "question_id": 334,
        "question_title": "Which of the following is NOT an uncommon type of survey question?",
        "option_A": "Drill Down",
        "option_B": "Nominal",
        "correct_anwser": "B",
        "explain": "Nominal (câu hỏi định danh) là loại câu hỏi khảo sát rất phổ biến và cơ bản (như chọn 1 trong nhiều lựa chọn không có thứ tự), do đó nó KHÔNG phải là loại câu hỏi hiếm gặp. Ngược lại, Drill Down, Heat Map, và Pick/Group/Rank là các dạng câu hỏi phức tạp, ít phổ biến hơn trong khảo sát thông thường.",
        "option_C": "Heat Map",
        "option_D": "Pick, Group and Rank"
      },
      {
        "question_id": 335,
        "question_title": "UX research at scale can be conducted by teams at these levels of maturity:\nI. UX team of one (Awareness)\nII. Mobilization\nIII. Collaboration\nIV. Executive Buy-In\nV. UX Obsessed",
        "option_A": "I, II, III",
        "option_B": "III, IV, V",
        "correct_anwser": "D",
        "explain": "Nghiên cứu UX ở quy mô lớn có thể được thực hiện bởi các nhóm ở mọi cấp độ trưởng thành khác nhau, từ một cá nhân đơn lẻ mới bắt đầu nhận thức (UX team of one), đến các giai đoạn huy động, hợp tác, được ban lãnh đạo ủng hộ, cho tới mức độ tổ chức 'ám ảnh' hoàn toàn với UX - tất cả các cấp độ này đều có thể triển khai nghiên cứu ở quy mô lớn.",
        "option_C": "IV, V",
        "option_D": "All"
      },
      {
        "question_id": 336,
        "question_title": "What does the concept of \"demand characteristics\" warn us about when applied to user testing?",
        "option_A": "Participants will perform differently when observed than they would if they were on their own",
        "option_B": "Participants are likely to tell us what they think we want to hear",
        "correct_anwser": "A",
        "explain": "Demand characteristics (đặc điểm nhu cầu) cảnh báo rằng khi bị quan sát trong bối cảnh nghiên cứu, người tham gia có xu hướng thay đổi hành vi so với khi họ tự nhiên một mình - họ có thể vô thức điều chỉnh cách hành động vì biết mình đang được quan sát, làm ảnh hưởng đến tính chân thực của dữ liệu thu thập được.",
        "option_C": "Participants who receive monetary compensation will typically perform better on tasks than those who don't",
        "option_D": "Researchers shouldn't ask participants to do anything in particular, rather they should let participants decide what to do"
      },
      {
        "question_id": 337,
        "question_title": "Critical incidents and verbal reports are both examples of what kind of user testing data?",
        "option_A": "Quantitative",
        "option_B": "Qualitative",
        "correct_anwser": "B",
        "explain": "Critical incidents (sự cố quan trọng) và verbal reports (báo cáo bằng lời nói) đều là dữ liệu dạng mô tả, quan sát định tính (qualitative) - phản ánh trải nghiệm, cảm nhận và sự kiện cụ thể trong quá trình sử dụng, chứ không phải số liệu đo lường được biểu diễn bằng con số như dữ liệu định lượng.",
        "option_C": "Insignificant",
        "option_D": "Performance"
      },
      {
        "question_id": 338,
        "question_title": "Which of the following are research methods that can be applied in formative research?",
        "option_A": "Interviews",
        "option_B": "Observations",
        "correct_anwser": "E",
        "explain": "Nghiên cứu hình thành (formative research) sử dụng đa dạng các phương pháp bao gồm phỏng vấn, quan sát, và các nhóm thiết kế có sự tham gia của người dùng. Tuy nhiên, việc chỉ hỏi bạn bè/người thân (thay vì đối tượng người dùng mục tiêu thực sự) thường được xem là một cách tiếp cận không chính thống nhưng vẫn có thể là một phương pháp thu thập thông tin ban đầu không chính thức, vì vậy tất cả các lựa chọn đều được xem là các phương pháp có thể áp dụng.",
        "option_C": "Asking friends and family members about their experiences",
        "option_D": "Participatory design groups",
        "option_E": "All of the others",
        "option_F": "None of the others"
      },
      {
        "question_id": 368,
        "question_title": "Which of the following is NOT a method one would use to understand why people are using a product at certain times?",
        "option_A": "Surveys",
        "option_B": "Clickstream analytics",
        "correct_anwser": "C",
        "explain": "Concept Testing là phương pháp kiểm tra phản ứng của người dùng với một ý tưởng hoặc khái niệm sản phẩm mới, không liên quan đến việc tìm hiểu lý do tại sao người dùng sử dụng sản phẩm vào những thời điểm cụ thể. Surveys, clickstream analytics, interviews và remote testing đều có thể giúp trả lời câu hỏi 'tại sao' liên quan đến thời điểm sử dụng.",
        "option_C": "Concept Testing",
        "option_D": "Interviews"
      },
      {
        "question_id": 372,
        "question_title": "Under what circumstances is remote testing appropriate?\nI. It is difficult to access the product/experience.\nII. Participants from a variety of geographic locations are needed.\nIII. Time is limited.\nIV. There is a lot of Personally Identifiable Information required.\nV. All of the above",
        "option_A": "I, II, III",
        "option_B": "I, IV",
        "correct_anwser": "A",
        "explain": "Remote testing (kiểm thử từ xa) phù hợp khi khó tiếp cận trực tiếp sản phẩm/trải nghiệm (I), cần người tham gia từ nhiều vùng địa lý khác nhau (II), và khi thời gian hạn chế (III). Yêu cầu nhiều thông tin cá nhân nhạy cảm (IV) lại là yếu tố khiến remote testing kém phù hợp hơn do vấn đề bảo mật, nên đáp án đúng là I, II, III.",
        "option_C": "I, III, IV",
        "option_D": "II, III"
      },
      {
        "question_id": 374,
        "question_title": "Which of the following are the hallmarks of good research questions?",
        "option_A": "I, II, and III",
        "option_B": "I, II, and V",
        "correct_anwser": "E",
        "explain": "Câu hỏi nghiên cứu tốt cần có tính rõ ràng (Clarity), khả năng trả lời được (Ability to be answered), đạo đức (Ethical excellence) và tính ý nghĩa (Significance). Tính nhất quán (Consistency) không phải là tiêu chí thường được nhắc đến, nên đáp án đúng là I, III, IV, và V (E).",
        "option_C": "IV and V",
        "option_D": "II, IV, and V",
        "option_E": "I, III, IV, and V"
      },
      {
        "question_id": 377,
        "question_title": "The design process is highly iterative. Which of the following are iterative loops that a designer might do in the course of a project?",
        "option_A": "From ideation to problem framing",
        "option_B": "From creation of scenarios and storyboards to ideation",
        "correct_anwser": "E",
        "explain": "Quy trình thiết kế có tính lặp lại (iterative) cao, nhà thiết kế có thể quay lại bất kỳ giai đoạn nào trước đó từ bất kỳ điểm nào trong quy trình — từ ý tưởng hóa quay lại đóng khung vấn đề, từ kịch bản/storyboard quay lại ý tưởng hoặc đóng khung vấn đề, từ tạo mẫu quay lại ý tưởng hóa. Tất cả các vòng lặp trên đều có thể xảy ra, nên đáp án đúng là 'All of the others' (E).",
        "option_C": "From creation of scenarios and storyboards to problem framing",
        "option_D": "From prototyping to ideation",
        "option_E": "All of the others"
      },
      {
        "question_id": 379,
        "question_title": "In a semi-structured interview, why would you want to avoid a question such as \"Was it because you didn't know about the 'undo' feature that you were unable to complete the task?\"",
        "option_A": "I and II",
        "option_B": "I and III",
        "option_C": "II and III",
        "option_D": "I, II and III",
        "correct_anwser": "D",
        "explain": "Câu hỏi này vi phạm cả 3 nguyên tắc: (I) Định hướng câu trả lời (leading), (II) Là câu hỏi Có/Không (closed-ended/yes-no), và (III) Áp đặt/đánh giá kiến thức người dùng (judgmental)."
      },
      {
        "question_id": 380,
        "question_title": "When choosing an environment to conduct a user test session, which of the following is NOT an important characteristic of your chosen site?",
        "option_A": "Distraction-free",
        "option_B": "Private",
        "option_C": "Dedicated only for conducting user tests",
        "option_D": "Quiet",
        "correct_anwser": "C",
        "explain": "Môi trường kiểm thử chỉ cần yên tĩnh, riêng tư và không bị xao nhãng; không bắt buộc phải là một không gian dành riêng duy nhất cho việc kiểm thử người dùng."
      },
      {
        "question_id": 381,
        "question_title": "Which of the following data types is typically not collected in a user test?",
        "option_A": "Task completion",
        "option_B": "Task timing",
        "option_C": "Critical incidents",
        "option_D": "Expected purchase price",
        "correct_anwser": "D",
        "explain": "User testing tập trung vào khả năng sử dụng (usability) như tỷ lệ hoàn thành, thời gian, sự cố; kỳ vọng giá mua (expected purchase price) là dữ liệu nghiên cứu thị trường/kinh doanh."
      },
      {
        "question_id": 383,
        "question_title": "In a semi-structured interview, why would you want to avoid a question such as \"Was it because you didn't know about the 'undo' feature that you were unable to complete the task?\"\nI. It is leading -- you are feeding a possible answer to the participant.\nII. It is closed-ended -- this is a yes-or-no question.\nIII. It is judgmental -- you are suggesting that the participant's lack of knowledge was a problem.",
        "option_A": "I and II",
        "option_B": "I and III",
        "option_C": "II and III",
        "option_D": "I, II and III",
        "correct_anwser": "D",
        "explain": "Câu hỏi này mắc cùng lúc 3 lỗi: nó gợi ý sẵn câu trả lời (leading), chỉ có thể trả lời có/không (closed-ended), và ngầm phán xét rằng người dùng thiếu hiểu biết (judgmental). Vì vậy cả I, II và III đều là lý do nên tránh câu hỏi kiểu này."
      },
      {
        "question_id": 384,
        "question_title": "Which of the following topics are NOT a common part of the introduction to an interview?",
        "option_A": "How confidentiality will be handled",
        "option_B": "Expected duration of the interview",
        "option_C": "How many other interview participants there are",
        "option_D": "Overall goals of the interview",
        "correct_anwser": "C",
        "explain": "Phần mở đầu phỏng vấn thường gồm giải thích cách bảo mật, thời lượng dự kiến và mục tiêu chung của buổi phỏng vấn. Việc tiết lộ có bao nhiêu người tham gia khác không phải là nội dung thường có, vì nó có thể ảnh hưởng đến tính bảo mật và tính khách quan của nghiên cứu."
      },
      {
        "question_id": 385,
        "question_title": "What consideration is not important when deciding what platform or technology solution you will use for testing?\nI. Metrics that may be collected\nII. Panel access\nIII. Network speed requirements\nIV. Screen, Audio, or other data collection, as appropriate for test\nV. None of the above",
        "option_A": "I, II, III",
        "option_B": "I, II",
        "option_C": "II, IV",
        "option_D": "I, III, IV",
        "correct_anwser": "E",
        "explain": "Tất cả các yếu tố được liệt kê (chỉ số thu thập được, khả năng tiếp cận panel, yêu cầu tốc độ mạng, khả năng thu thập màn hình/âm thanh/dữ liệu khác) đều là những cân nhắc quan trọng khi lựa chọn nền tảng/công nghệ kiểm thử. Do đó đáp án đúng là 'None of the above' (V), tức không có yếu tố nào trong số này là không quan trọng."
      },
      {
        "question_id": 386,
        "question_title": "Which of the following are the hallmarks of good research questions?\nI. Clarity\nII. Consistency\nIII. Ability to be answered\nIV. Ethical excellence\nV. Significance",
        "option_A": "I, II, and III",
        "option_B": "I, II, and V",
        "option_C": "IV and V",
        "option_D": "II, IV, and V",
        "correct_anwser": "E",
        "explain": "Đáp án E (I, III, IV, và V) gồm: Rõ ràng (Clarity), Có thể trả lời được (Ability to be answered), Đạo đức tốt (Ethical excellence), và Có ý nghĩa (Significance) - đây là các đặc điểm chuẩn của một câu hỏi nghiên cứu tốt. 'Consistency' (tính nhất quán) không phải là tiêu chí điển hình để đánh giá chất lượng câu hỏi nghiên cứu."
      },
      {
        "question_id": 388,
        "question_title": "Which new technological trend is not requiring designers to change how they prototype and test their systems?",
        "option_A": "Proliferation of screens (smart watches, embedded displays, etc.) for which designers need to design user experiences",
        "option_B": "Instrumented environments",
        "option_C": "Artificial Intelligence-based systems",
        "option_D": "Virtual and augmented reality",
        "correct_anwser": "E",
        "explain": "Tất cả các xu hướng công nghệ được liệt kê (màn hình đa dạng, môi trường được trang bị cảm biến, hệ thống AI, thực tế ảo/tăng cường) đều đòi hỏi nhà thiết kế phải thay đổi cách họ tạo mẫu và kiểm thử. Do đó đáp án đúng là 'None of the others' (E) - không có xu hướng nào trong số này KHÔNG yêu cầu thay đổi."
      },
      {
        "question_id": 391,
        "question_title": "Nielsen provides several recommendations for help and documentation. Which of the following is NOT one of his recommendations?",
        "option_A": "Help should be focused on users' tasks",
        "option_B": "Help should be small and searchable",
        "option_C": "Help should include step-by-step instructions",
        "option_D": "Help should be written from the system developers' point of view",
        "correct_anwser": "D",
        "explain": "Nielsen khuyến nghị tài liệu trợ giúp nên tập trung vào tác vụ của người dùng (A), dễ tìm kiếm/nhỏ gọn (B), có hướng dẫn từng bước cụ thể (C). Ông không khuyến nghị viết tài liệu trợ giúp theo góc nhìn của nhà phát triển hệ thống (D) - trái lại, nó nên được viết từ góc nhìn và ngôn ngữ của người dùng."
      },
      {
        "question_id": 392,
        "question_title": "__________ means \"to make an idea real or concrete.\"",
        "option_A": "Assessment",
        "option_B": "Communication",
        "option_C": "Reification",
        "option_D": "Reflection",
        "correct_anwser": "C",
        "explain": "'Reification' (cụ thể hóa/hiện thực hóa) có nghĩa là biến một ý tưởng trừu tượng thành thứ gì đó thực tế, cụ thể hơn - chẳng hạn như việc chuyển ý tưởng thiết kế thành bản phác thảo hoặc nguyên mẫu."
      },
      {
        "question_id": 393,
        "question_title": "For a system's response to user input to be perceived as \"instantaneous\" by the user, what is the maximum time that can elapse between the user's action and the system response?",
        "option_A": "10 milliseconds",
        "option_B": "100 milliseconds",
        "option_C": "1 second",
        "option_D": "1 minute",
        "correct_anwser": "B",
        "explain": "Theo các nguyên tắc thiết kế tương tác cổ điển (Nielsen, Miller), thời gian phản hồi tối đa để hệ thống được coi là 'tức thời' đối với người dùng là khoảng 100 mili giây (0.1 giây); nếu lâu hơn, người dùng sẽ nhận ra có độ trễ."
      },
      {
        "question_id": 394,
        "question_title": "Which of the following are among key tasks that were identified? (dựa trên bảng Key tasks trong wireframe)",
        "option_A": "Customize automatic functions, Help, Log Out",
        "option_B": "Check map, Create a post, Log Out",
        "option_C": "Change security code, Create a post, Check recent events",
        "option_D": "Check map, Help, Activate function \"Robbery\"",
        "correct_anwser": "D",
        "explain": "Theo bảng 'Key tasks' trong tài liệu wireframe, các nhiệm vụ 'Check map' (mục 4), 'Help' (mục 8), và 'Activate function Robbery' (mục 11) đều là các nhiệm vụ chính được liệt kê. Các phương án khác chứa những nhiệm vụ không có trong bảng như 'Create a post' hoặc 'Log Out'."
      },
      {
        "question_id": 395,
        "question_title": "This example (hình ảnh Questbook với nhiều màn hình chi tiết, có màu sắc, nội dung đầy đủ) would most likely be an example of (choose the BEST response):",
        "option_A": "Wireframes",
        "option_B": "Lo-Fi Prototype",
        "option_C": "Hi-Fi Prototype",
        "option_D": "Yes, wireframes need to look like a completely finished product",
        "correct_anwser": "C",
        "explain": "Hình ảnh minh họa cho thấy các màn hình có chi tiết cao, đầy đủ màu sắc, hình ảnh nền, văn bản cụ thể, và trông giống sản phẩm hoàn thiện - đây là đặc điểm của một Hi-Fi Prototype (nguyên mẫu độ trung thực cao), khác với wireframe (thường đơn giản, không màu) hay Lo-Fi Prototype (thô sơ hơn)."
      },
      {
        "question_id": 396,
        "question_title": "Which of the following is NOT important to consider when defining your population?",
        "option_A": "Number of questions you want to ask",
        "option_B": "Characteristics of the people you're interested in",
        "option_C": "Survey mode",
        "option_D": "Relationship to the product",
        "correct_anwser": "A",
        "explain": "Khi xác định đối tượng quần thể (population), bạn cần quan tâm đến đặc điểm người dùng, mối quan hệ với sản phẩm và phương thức khảo sát. Số lượng câu hỏi (Number of questions) thuộc về khâu thiết kế bảng hỏi (survey design), không ảnh hưởng đến việc định nghĩa quần thể."
      },
      {
        "question_id": 397,
        "question_title": "All of the following are important to do when observing a user testing session, EXCEPT for:",
        "option_A": "Capture recordings of the user's screen",
        "option_B": "Capture audio recordings of the user thinking aloud",
        "option_C": "Notify participants as soon as they have met each task's success criteria",
        "option_D": "Use a logging sheet to capture when critical incidents occur",
        "correct_anwser": "C",
        "explain": "Trong buổi user testing, quan sát viên cần giữ thái độ trung lập và KHÔNG thông báo cho người dùng biết họ đã hoàn thành nhiệm vụ thành công hay chưa, vì điều này sẽ can thiệp vào hành vi tự nhiên và tâm lý của người tham gia."
      },
      {
        "question_id": 398,
        "question_title": "Why would a designer create storyboards as opposed to write scenarios?",
        "option_A": "To better represent physical environment in which the technology would be used",
        "option_B": "To better represent relationships among multiple people",
        "option_C": "To better envision size or other physical constraints of the technology and its use",
        "option_D": "All of the others",
        "correct_anwser": "D",
        "explain": "Visual hóa bằng Storyboard đem lại lợi thế vượt trội so with kịch bản văn bản (scenario) trong việc thể hiện trực quan bối cảnh môi trường xung quanh, mối quan hệ giữa các nhân vật và các giới hạn kích thước vật lý của thiết bị."
      },
      {
        "question_id": 399,
        "question_title": "This example would most likely be an example of (choose the BEST response):",
        "option_A": "Hi-Fi Prototype",
        "option_B": "Wireframes",
        "option_C": "Lo-Fi Prototype",
        "option_D": "Yes, wireframes need to look like a completely finished product",
        "correct_anwser": "A",
        "explain": "Hình ảnh minh họa có đầy đủ màu sắc, đồ họa chi tiết, hình ảnh nền và UI chỉn chu tiệm cận sản phẩm thật, đây chính là bản mẫu độ phân giải cao (Hi-Fi Prototype)."
      },
      {
        "question_id": 400,
        "question_title": "Finding 1. No Option to delete or modify Time Sheet entries.\nSeverity: 4\nHeuristic(s) Violated: Navigation\nWhile the existing prototype shows the list of time entries on the Time Sheet tab, it does not provide an option to Modify or Delete time entries. It is crucial when allowing users to DO something to allow them a way to UNDO or correct something done in error.\nWhat heuristic does this violate?",
        "option_A": "Visibility of system status",
        "option_B": "User control and freedom",
        "option_C": "Recognition vs recall",
        "option_D": "Error prevention",
        "correct_anwser": "B",
        "explain": "Việc không cho phép người dùng chỉnh sửa, xóa hoặc hoàn tác (undo) các dữ liệu đã nhập vi phạm nghiêm trọng nguyên tắc 'User control and freedom' (Khai thác quyền kiểm soát và sự tự do của người dùng)."
      },
      {
        "question_id": 401,
        "question_title": "Bill Buxton claims that ________ is not just a byproduct of design, but is central to design thinking and learning.",
        "option_A": "Sketching",
        "option_B": "Beauty",
        "option_C": "Functionality",
        "option_D": "User Testing",
        "correct_anwser": "A",
        "explain": "Bill Buxton (tác giả cuốn 'Sketching User Experiences') khẳng định phác thảo (Sketching) không chỉ là phụ phẩm của thiết kế, mà là công cụ cốt lõi trong tư duy thiết kế và quá trình học hỏi/khám phá giải pháp."
      },
      {
        "question_id": 402,
        "question_title": "A basic ethical principle of research involving human subjects that states that researchers need to confirm that participants in a study know the purpose of the study, what they will be asked to do, their right to withdraw or refuse to comply with aspects of the study, and what will be done with the data is ________.",
        "option_A": "Usability",
        "option_B": "Perceived usefulness",
        "option_C": "Acquiescence",
        "option_D": "Informed Consent",
        "correct_anwser": "D",
        "explain": "Informed Consent (Sự chấp thuận dựa trên thông tin đầy đủ) là nguyên tắc đạo đức cốt lõi trong nghiên cứu với con người, đảm bảo người tham gia hiểu rõ mục đích, quyền dừng tham gia và cách xử lý dữ liệu."
      },
      {
        "question_id": 403,
        "question_title": "Why is it important to ask participants to announce when they believe they are done with a task?",
        "option_A": "Otherwise there is no way to know if they've finished",
        "option_B": "Allowing the moderator to declare a task “done” could give the participant more information than they would have if conducting the task outside the test environment",
        "option_C": "Saying “I'm done” gives the participant a sense of accomplishment",
        "option_D": "It allows the moderator to pay less attention to the current task and start to prepare for the next one",
        "correct_anwser": "B",
        "explain": "Nếu người điều phối (moderator) tự tuyên bố nhiệm vụ đã 'hoàn thành', họ có thể vô tình tiết lộ cho người dùng biết họ đã làm đúng/sai - điều không xảy ra trong môi trường thực tế. Việc để người tham gia tự xác nhận giúp đánh giá chính xác nhận thức của họ về kết quả công việc."
      },
      {
        "question_id": 404,
        "question_title": "Which of the following is the most accurate statement?",
        "option_A": "Error can be reduced by designing surveys as well as well as possible within resource constraints.",
        "option_B": "Error should be reduced to zero before launching a survey.",
        "option_C": "It's impossible to affect error one way or another.",
        "option_D": "Surveys should never be trusted because of how much error they involve.",
        "correct_anwser": "A",
        "explain": "Trong nghiên cứu khảo sát, sai số (error) không thể triệt tiêu hoàn toàn về 0, nhưng có thể giảm thiểu tối đa bằng cách thiết kế bảng hỏi chỉn chu nhất trong phạm vi nguồn lực cho phép."
      },
      {
        "question_id": 406,
        "question_title": "This is the error that is introduced because some portion of the population is refusing to answer your questions.",
        "option_A": "Coverage error",
        "option_B": "Nonresponse error",
        "option_C": "Sampling error",
        "option_D": "Measurement error",
        "correct_anwser": "B",
        "explain": "Nonresponse error (Sai số do không phản hồi) xảy ra khi một nhóm đối tượng được chọn trong mẫu từ chối hoặc không thể tham gia trả lời câu hỏi khảo sát."
      },
      {
        "question_id": 407,
        "question_title": "When is it most appropriate to conduct remote moderated testing?\nI. Redirection and discussion are required\nII. Users can complete tasks without instruction\nIII. Finding participants local to your lab is challenging\nIV. You want to see and explore user's digital contexts\nV. All of the above",
        "option_A": "I, II, III",
        "option_B": "I, IV",
        "option_C": "I, III",
        "option_D": "I, III, IV",
        "option_E": "V",
        "correct_anwser": "D",
        "explain": "Kiểm thử từ xa có người điều phối (Remote moderated testing) thích hợp nhất khi: cần thảo luận/điều hướng (I), khó tìm đối tượng tại địa phương (III), và muốn quan sát bối cảnh thiết bị số thực tế của người dùng (IV). Điều II áp dụng cho kiểm thử không có người điều phối (unmoderated)."
      },
      {
        "question_id": 408,
        "question_title": "Neilsen's set of 10 heuristics was designed to meet all of the following criteria EXCEPT:",
        "option_A": "The heuristics are exhaustive and detailed enough to tell a designer exactly what elements to include in every possible part of every possible user interface",
        "option_B": "The heuristics are applicable to a wide range of different platforms and interaction modalities (e.g., mouse-and-keyboard, touch-based mobile, speech)",
        "option_C": "The heuristics are compact enough to be taught to a non-expert within a few hours",
        "option_D": "The heuristics are backed up by systematic research showing that the set of heuristics could explain a range of usability problems observed across numerous usability tests with multiple systems",
        "correct_anwser": "A",
        "explain": "10 nguyên tắc Heuristics của Jakob Nielsen là các hướng dẫn rộng (broad rules of thumb) chứ không phải là một danh sách kiệt cùng và chi tiết (exhaustive) bắt buộc chính xác từng UI element cho mọi trường hợp."
      },
      {
        "question_id": 410,
        "question_title": "Which of the following can prototypes help designers test?",
        "option_A": "The overall design concept",
        "option_B": "Functionality of different components of the system",
        "option_C": "Screen layouts",
        "option_D": "User interactions",
        "option_E": "All of the others",
        "correct_anwser": "E",
        "explain": "Bản mẫu (Prototype) hỗ trợ nhà thiết kế kiểm thử toàn bộ các yếu tố từ ý tưởng tổng thể (concept), chức năng của các thành phần, bố cục màn hình (layout) cho tới các tương tác người dùng (user interactions)."
      },
      {
        "question_id": 411,
        "question_title": "What types of research activities are typically engaged in by 2-3 people design teams?",
        "option_A": "I",
        "option_B": "II",
        "option_C": "III",
        "option_D": "IV",
        "option_E": "II and IV",
        "correct_anwser": "B",
        "explain": "Với nhóm thiết kế nhỏ (2-3 người), nguồn lực hạn chế nên hoạt động nghiên cứu phổ biến và phù hợp nhất là Feature-driven usability testing (kiểm thử khả năng sử dụng dựa trên tính năng). Các phương pháp như A/B testing hay phân tích quy mô lớn thường đòi hỏi hạ tầng và đội ngũ nhân sự chuyên biệt hơn."
      },
      {
        "question_id": 412,
        "question_title": "What preparations should you make ahead of both remote moderated as well as unmoderated testing?",
        "option_A": "I, II, III",
        "option_B": "I, III, IV, V",
        "option_C": "II, IV, V",
        "option_D": "I, IV",
        "option_E": "VI",
        "correct_anwser": "B",
        "explain": "Trước khi tiến hành kiểm thử từ xa (cho cả có và không có người điều phối), các bước chuẩn bị cần thiết bao gồm: Xem xét các đường đi/luồng thay thế (I), Xác định chỉ số cần thu thập (III), Lấy sự chấp thuận Informed Consent (IV), và Tuyển dư người tham gia/Overrecruit để phòng rủi ro hủy lịch (V). Việc 'online trước 10-15 phút' (II) không áp dụng cho unmoderated testing."
      },
      {
        "question_id": 414,
        "question_title": "What types of research activities are typically engaged in by 2-3 people design teams?\nI. A/B Testing\nII. Feature driven usability testing\nIII. Competitive testing\nIV. Attitudinal analytics (surveys)",
        "option_A": "I",
        "option_B": "II",
        "option_C": "III",
        "option_D": "IV",
        "correct_anwser": "B",
        "explain": "Các nhóm thiết kế nhỏ (2-3 người) thường tập trung vào các hoạt động nghiên cứu nhanh, gắn liền trực tiếp với tính năng đang phát triển như kiểm thử khả dụng theo tính năng (feature driven usability testing), vì họ có nguồn lực hạn chế và cần phản hồi nhanh cho từng tính năng cụ thể, khác với các hoạt động cần quy mô lớn hơn như A/B testing hay khảo sát thái độ."
      },
      {
        "question_id": 415,
        "question_title": "Gulf of execution refers to which of the following?",
        "option_A": "The time it takes an application to execute some computationally-intensive task, such as running a statistical model.",
        "option_B": "The difference between the output the system provided and the output the user wanted.",
        "option_C": "The discrepancy between what the user is trying to do and what he/she is able to do using the system's interface.",
        "option_D": "The time between when the user gives the system a command and when the system executes that command (e.g., the delay in responding to a button press)",
        "correct_anwser": "C",
        "explain": "'Gulf of execution' (khoảng cách thực thi) là khái niệm của Donald Norman, chỉ sự chênh lệch giữa những gì người dùng muốn làm và những gì họ có thể thực hiện được thông qua giao diện của hệ thống, tức là khó khăn trong việc biết cách thao tác để đạt được mục tiêu."
      },
      {
        "question_id": 416,
        "question_title": "In user testing, we generally ask test participants to verbalize what they are thinking as they perform tasks. What is not correct answer?",
        "option_A": "Debriefing",
        "option_B": "The Think-Aloud Protocol",
        "option_C": "What You See Is What You Get",
        "option_D": "Screening",
        "correct_anwser": "C",
        "explain": "Kỹ thuật yêu cầu người tham gia nói to suy nghĩ khi thực hiện nhiệm vụ được gọi là 'The Think-Aloud Protocol' (giao thức nói to suy nghĩ). 'What You See Is What You Get' (WYSIWYG) là một khái niệm hoàn toàn khác, liên quan đến giao diện hiển thị đúng như những gì sẽ được xuất ra, không liên quan gì đến kỹ thuật kiểm thử người dùng này."
      },
      {
        "question_id": 417,
        "question_title": "Which of the following can prototypes help designers test?",
        "option_A": "The overall design concept",
        "option_B": "Functionality of different components of the system",
        "option_C": "Screen layouts",
        "option_D": "User interactions",
        "correct_anwser": "E",
        "explain": "Nguyên mẫu (prototypes) có thể được sử dụng để kiểm thử nhiều khía cạnh khác nhau của thiết kế, bao gồm: khái niệm thiết kế tổng thể, chức năng của các thành phần hệ thống, bố cục màn hình, và các tương tác của người dùng. Vì vậy đáp án đúng là 'All of the others' (E) - tất cả các lựa chọn trên đều đúng."
      },
      {
        "question_id": 420,
        "question_title": "Which new technological trend is not requiring designers to change how they prototype and test their systems?",
        "option_A": "Proliferation of screens (smart watches, embedded displays, etc.) for which designers need to design user experiences",
        "option_B": "Instrumented environments",
        "option_C": "Artificial Intelligence-based systems",
        "option_D": "Virtual and augmented reality",
        "option_E": "None of the others",
        "correct_anwser": "E",
        "explain": "Tất cả các xu hướng công nghệ được liệt kê (màn hình đa dạng, môi trường được trang bị cảm biến, hệ thống AI, thực tế ảo/tăng cường) đều đòi hỏi nhà thiết kế phải thay đổi cách họ tạo mẫu và kiểm thử. Do đó đáp án đúng là 'None of the others' (E) - không có xu hướng nào trong số này KHÔNG yêu cầu thay đổi."
      },
      {
        "question_id": 421,
        "question_title": "Is this a good scope for a user test? Scope of the evaluation includes: Report an event when someone else is being a victim of robbery; Check the map to see if a place is dangerous; Protect themselves in case they are the victim of smartphone robbery.",
        "option_A": "No, a user test needs to include testing every single task in the application to deliver valuable data",
        "option_B": "No, a user test must focus on only one task",
        "option_C": "No, a user test needs to compare...",
        "option_D": "Yes, this is a reasonable scope focused on frequently used functions",
        "correct_anwser": "D",
        "explain": "Phạm vi kiểm thử này tập trung vào các chức năng được sử dụng thường xuyên nhất của ứng dụng (báo cáo sự cố, kiểm tra bản đồ, bảo vệ bản thân) - đây là cách tiếp cận hợp lý vì một bài kiểm thử người dùng không cần và không nên bao gồm TẤT CẢ mọi tính năng, mà nên tập trung vào các luồng công việc quan trọng nhất."
      },
      {
        "question_id": 423,
        "question_title": "Which of the following is not a characteristic of sketches done for the purposes of ideation?",
        "option_A": "Quick",
        "option_B": "Disposable",
        "option_C": "Evocative",
        "option_D": "Refined",
        "option_E": "Ambiguous",
        "correct_anwser": "D",
        "explain": "Sketch dùng cho mục đích ideation (lên ý tưởng) thường nhanh, có thể bỏ đi, gợi mở và mơ hồ để khuyến khích tư duy sáng tạo, không cần chi tiết hay hoàn thiện (refined) vì mục tiêu là khám phá nhiều ý tưởng chứ không phải hoàn thiện thiết kế cuối cùng."
      },
      {
        "question_id": 424,
        "question_title": "How many personas should designers create for a design project?",
        "option_A": "Often one or two personas are all that's needed",
        "option_B": "As many personas as it takes to represent everything designers have learned in the formative work",
        "option_C": "The number of personas should match the number of classes of target users that the designers have identified in the formative work",
        "option_D": "The more personas, the better",
        "option_E": "Three to four personas are usually a sweet spot",
        "correct_anwser": "C",
        "explain": "Số lượng persona nên tương ứng với số nhóm (classes) người dùng mục tiêu khác nhau mà nhóm thiết kế đã xác định được qua nghiên cứu nền tảng (formative research), chứ không phải một con số cố định nào đó."
      },
      {
        "question_id": 425,
        "question_title": "If a user of a system is unable to determine whether an action they took helped move them closer to achieving their goal, we would say that the system fails to bridge:",
        "option_A": "The Gulf of Inspection",
        "option_B": "The Gulf of Expectation",
        "option_C": "The Gulf of Execution",
        "option_D": "The Gulf of Evaluation",
        "correct_anwser": "D",
        "explain": "Theo lý thuyết của Donald Norman, Gulf of Evaluation (khoảng cách đánh giá) là khoảng cách giữa việc người dùng nhận biết và diễn giải trạng thái hệ thống để xác định xem hành động của họ có giúp đạt được mục tiêu hay không. Khi người dùng không biết hành động có hiệu quả hay không, hệ thống đã thất bại trong việc thu hẹp khoảng cách này."
      },
      {
        "question_id": 426,
        "question_title": "By helping users form effective _____, we can help users to predict the results of actions they haven't yet performed using a system.",
        "option_A": "System images",
        "option_B": "Assumptions",
        "option_C": "Feedback",
        "option_D": "Conceptual models",
        "correct_anwser": "D",
        "explain": "Conceptual model (mô hình khái niệm) là sự hiểu biết của người dùng về cách hệ thống hoạt động. Khi mô hình này chính xác, người dùng có thể dự đoán kết quả của các hành động mà họ chưa từng thực hiện trước đó."
      },
      {
        "question_id": 427,
        "question_title": "What should you do during the think-aloud protocol?",
        "option_A": "Let the participant hear what you're thinking while you observe them.",
        "option_B": "Prompt the user to convey their thinking out loud with short questions.",
        "option_C": "Respond to the participant by telling whether what they're saying is correct or not.",
        "option_D": "Sit quietly and observe, even if the participant says nothing.",
        "correct_anwser": "B",
        "explain": "Trong think-aloud protocol, nhà nghiên cứu nên nhắc nhở người tham gia tiếp tục nói ra suy nghĩ của họ bằng những câu hỏi ngắn (như 'Bạn đang nghĩ gì?') khi họ im lặng, để duy trì dòng chảy thông tin về suy nghĩ của người dùng."
      },
      {
        "question_id": 428,
        "question_title": "Which of the following steps will you be learning about in this user needs assessment course? I. Preparing for and conducting interviews. II. Observing users using a product or service. III. Analyzing qualitative data to arrive at insights.",
        "option_A": "I and II",
        "option_B": "I and III",
        "option_C": "II and III",
        "option_D": "I, II, and III",
        "correct_anwser": "D",
        "explain": "Khóa học về đánh giá nhu cầu người dùng (user needs assessment) thường bao gồm đầy đủ các bước: chuẩn bị và tiến hành phỏng vấn, quan sát người dùng sử dụng sản phẩm/dịch vụ, và phân tích dữ liệu định tính để rút ra insight, nên đáp án đúng là cả ba (I, II, và III)."
      },
      {
        "question_id": 429,
        "question_title": "Designers often refer to the notion of the “design space.” What does this term refer to?",
        "option_A": "Physical space (like a design studio) where design activities take place",
        "option_B": "Space into which the design has to fit (e.g., the size of the screen of a mobile phone)",
        "option_C": "Properties of the space (e.g., location, shape of the room) where the design will be used",
        "option_D": "The range of alternative ways that a design solution can work",
        "correct_anwser": "D",
        "explain": "Trong thiết kế, \"Design space\" (không gian thiết kế) là thuật ngữ chỉ toàn bộ tập hợp các phương án, ý tưởng và giải pháp thiết kế khả thi mà nhà thiết kế có thể khám phá."
      }
    ]
  },
  {
    "id": "wdu203c-module-2-multi-choice",
    "title": "Module 2 - Multiple Choice",
    "description": "Tập hợp 8 câu hỏi trắc nghiệm chọn nhiều đáp án đúng (Multiple Choice).",
    "questionsCount": 8,
    "questions": [
      {
        "question_id": 1,
        "question_title": "What deliverables are typically used to tell user stories? (pick all that apply)",
        "option_A": "Personas",
        "option_B": "Scenarios",
        "correct_anwser": "A, B, D",
        "explain": "Persona, Scenario và Customer Journey Map là những loại tài liệu (deliverables) điển hình dùng để kể câu chuyện về người dùng (user stories) — mô tả nhân vật, tình huống và hành trình trải nghiệm; còn Diary Study là một phương pháp thu thập dữ liệu nghiên cứu, không phải là deliverable để kể chuyện, nên đáp án đúng là A, B, D.",
        "option_C": "Diary Study",
        "option_D": "Customer Journey Maps"
      },
      {
        "question_id": 2,
        "question_title": "What elements should a script include for a remote moderated test?",
        "option_A": "Obtain Consent",
        "option_B": "Make introductions",
        "correct_anwser": "A, B, C, E, F",
        "explain": "Kịch bản (script) cho một buổi kiểm thử từ xa có điều phối thường cần: xin sự đồng ý (consent), giới thiệu, xây dựng sự thân thiện (rapport), thiết lập kỳ vọng về thời lượng/nội dung, và vai trò của người điều phối/quan sát viên. Riêng \"hướng dẫn chính xác từng bước để hoàn thành nhiệm vụ\" lại đi ngược với nguyên tắc kiểm thử usability (không nên chỉ dẫn cụ thể cách làm vì sẽ làm sai lệch kết quả đo lường khả năng tự sử dụng của người dùng), nên 5 đáp án đúng là A, B, C, E, F.",
        "option_C": "Build rapport",
        "option_D": "Exact instructions for how to complete tasks",
        "option_E": "Set expectations for duration and content of test",
        "option_F": "Set expectations for role of moderator and observer"
      },
      {
        "question_id": 3,
        "question_title": "What alternative approaches can you use to engage people in research results? (pick all that apply)",
        "option_A": "Extensive report",
        "option_B": "Have stakeholders attend study sessions and participate in analyzing and interpreting data.",
        "correct_anwser": "B,C",
        "explain": "Để thu hút mọi người tham gia vào kết quả nghiên cứu một cách hiệu quả hơn báo cáo truyền thống, có thể mời các bên liên quan trực tiếp tham dự phiên nghiên cứu và cùng phân tích dữ liệu, hoặc tạo video ghi lại những khoảnh khắc quan trọng trong kiểm thử để tạo tác động trực quan, sinh động hơn.",
        "option_C": "Create and show videos of critical moments during tests",
        "option_D": "Emails that include bullet point findings",
        "option_E": "Brief executive summary"
      },
      {
        "question_id": 179,
        "question_title": "Select all the benefits of conducting usability testing early in the UX design process. (More than one answer may be correct).",
        "option_A": "Identify potential design flaws",
        "option_B": "Guarantees project success",
        "correct_anwser": "A, C",
        "explain": "Kiểm thử độ khả dụng sớm giúp phát hiện kịp thời các lỗi thiết kế tiềm ẩn (A) và nâng cao sự hài lòng của người dùng (C).",
        "option_C": "Improves user satisfaction",
        "option_D": "Ensures compliance with industry standards"
      },
      {
        "question_id": 198,
        "question_title": "Which of the following methods are effective for gathering user needs? (More than one answer may be correct)",
        "option_A": "User interviews",
        "option_B": "Surveys",
        "correct_anwser": "A, B",
        "explain": "Phỏng vấn người dùng (A) và Khảo sát (B) đều là những phương pháp hiệu quả để thu thập nhu cầu người dùng.",
        "option_C": "Ignoring negative feedback",
        "option_D": "Copying competitors' features"
      },
      {
        "question_id": 387,
        "question_title": "What elements should a script include for a remote moderated test? (Choose 5 answers)",
        "option_A": "Obtain Consent",
        "option_B": "Make introductions",
        "option_C": "Build rapport",
        "option_D": "Exact instructions for how to complete tasks",
        "correct_anwser": "A, B, C, E, F",
        "explain": "Một kịch bản (script) cho bài kiểm tra từ xa có điều phối viên nên bao gồm: xin sự đồng ý (A), giới thiệu (B), xây dựng sự tin tưởng (C), thiết lập kỳ vọng về thời lượng/nội dung (E), và vai trò của điều phối viên/quan sát viên (F). Không nên đưa ra 'hướng dẫn chính xác cách hoàn thành nhiệm vụ' (D) vì điều này sẽ dẫn dắt người dùng, làm sai lệch kết quả kiểm thử usability tự nhiên."
      },
      {
        "question_id": 409,
        "question_title": "Why are these good research questions for a needs-finding study?",
        "option_A": "They will help the researcher learn how users currently complete the activity that their design will try to improve",
        "option_B": "They are questions that can be answered by interviewing the target user population",
        "option_C": "They're open ended, not leading",
        "option_D": "They seek to learn about what problems there are with existing solutions",
        "correct_anwser": "A, B, C, D",
        "explain": "Các câu hỏi trong kế hoạch tìm kiếm nhu cầu (Needs Finding Plan) là những câu hỏi nghiên cứu tốt vì đáp ứng đầy đủ cả 4 tiêu chí: giúp hiểu quy trình hiện tại, trả lời được qua phỏng vấn đối tượng mục tiêu, mang tính mở/không dẫn dắt và hướng tới tìm hiểu hạn chế của giải pháp hiện tại."
      },
      {
        "question_id": 430,
        "question_title": "Imagine a new shopping website named Nomaza.com. Nomaza.com offers a wide range of products. Which of the following might be a reasonable goal for a Nomaza.com user test? (choose all that apply)",
        "option_A": "Can experienced online shoppers use Nomaza.com to find and purchase household items?",
        "option_B": "How likely are first-time users of Nomaza.com to return for a second visit?",
        "option_C": "Are novice Internet shoppers able to complete the checkout process on Nomaza.com?",
        "option_D": "Can people find stuff they want on Nomaza.com?",
        "correct_anwser": "A, C",
        "explain": "Mục tiêu kiểm thử người dùng (user test goal) phải tập trung vào khả năng thực hiện nhiệm vụ của các nhóm người dùng cụ thể. Option A và C đặt ra câu hỏi kiểm thử rõ ràng về khả năng mua sắm và thanh toán. Option B thuộc về nghiên cứu hành vi dài hạn, Option D quá chung chung."
      }
    ]
  },
  {
    "id": "wdu203c-module-3-true-false",
    "title": "Module 3 - True / False",
    "description": "Tập hợp 35 câu hỏi Đúng / Sai (True / False).",
    "questionsCount": 35,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Technical determinists believe that sometimes the properties of technologies almost necessitate certain kinds of consequences.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Đây chính là định nghĩa cốt lõi của thuyết quyết định luận công nghệ (technical determinism) — cho rằng bản thân đặc tính của công nghệ gần như tất yếu dẫn đến những hệ quả xã hội nhất định, nên đáp án A (True) đúng."
      },
      {
        "question_id": 2,
        "question_title": "Granularity of the needed information is an important consideration when designing system inputs.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Mức độ chi tiết (granularity) của thông tin cần thu thập là yếu tố quan trọng khi thiết kế input hệ thống, vì thu thập quá thô hoặc quá chi tiết đều ảnh hưởng đến trải nghiệm và hiệu quả sử dụng, nên đáp án A (True) đúng."
      },
      {
        "question_id": 3,
        "question_title": "It's possible to create a useful, functional interactive prototype with very simple tools, such as paper, post-it notes, and scotch tape.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Prototype giấy (paper prototyping) sử dụng các công cụ đơn giản như giấy, post-it, băng keo vẫn có thể tạo ra một prototype tương tác hữu ích để thử nghiệm ý tưởng thiết kế, nên đáp án A (True) đúng."
      },
      {
        "question_id": 4,
        "question_title": "Creation of many alternative solutions increases the quality of the final design.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Việc tạo ra nhiều giải pháp thay thế (parallel prototyping) giúp nhà thiết kế khám phá nhiều hướng đi khác nhau, so sánh và chọn lọc ý tưởng tốt nhất, từ đó nâng cao chất lượng thiết kế cuối cùng, nên đáp án A (True) đúng."
      },
      {
        "question_id": 5,
        "question_title": "Sketching is used both for generating and for communicating ideas.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Vẽ phác thảo (sketching) vừa giúp nhà thiết kế tự khám phá và phát triển ý tưởng (generating), vừa là công cụ để truyền đạt ý tưởng đó cho người khác (communicating), nên đáp án A (True) đúng."
      },
      {
        "question_id": 6,
        "question_title": "A single designer can usually conduct a test of a lo-fi prototype by him/herself.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Việc kiểm thử prototype độ trung thực thấp (lo-fi, ví dụ paper prototype) thường cần ít nhất vài người (người điều phối, người đóng vai \"máy tính\" lật các mảnh giấy, người ghi chú) nên một nhà thiết kế thường khó tự mình thực hiện đầy đủ, nên đáp án B (False) đúng."
      },
      {
        "question_id": 7,
        "question_title": "It is important to be good at drawing to use sketching in UX Design",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Vẽ phác thảo (sketching) trong UX Design không yêu cầu kỹ năng vẽ đẹp hay chuyên nghiệp; mục đích chính là để nhanh chóng thể hiện và truyền đạt ý tưởng, nên không cần phải giỏi vẽ, đáp án B (False) đúng."
      },
      {
        "question_id": 8,
        "question_title": "True or False: It is not the role of the UX researcher to assign severity to problems found in user testing--this should be left up to the product owner.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Nhận định này sai vì việc đánh giá mức độ nghiêm trọng của các vấn đề usability được phát hiện chính là một phần công việc của nhà nghiên cứu UX, dựa trên chuyên môn và dữ liệu thu thập được, nên đáp án B đúng."
      },
      {
        "question_id": 9,
        "question_title": "Affordances of user interface don't have much influence on how easily users learn to use the system.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Affordance là đặc tính của giao diện cho biết một đối tượng có thể được sử dụng như thế nào (ví dụ nút bấm trông giống có thể nhấn được). Đây là yếu tố then chốt giúp người dùng nhận biết cách tương tác mà không cần hướng dẫn, do đó affordance có ảnh hưởng rất lớn đến khả năng học sử dụng hệ thống, không phải là ít ảnh hưởng."
      },
      {
        "question_id": 10,
        "question_title": "In order to have a mental model of a system that enable them to use that system effectively, users need to understand the technical underpinnings of that system.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Mô hình tinh thần (mental model) của người dùng chỉ cần phản ánh cách họ nghĩ hệ thống hoạt động dựa trên trải nghiệm và tương tác, không cần hiểu cơ chế kỹ thuật bên trong. Người dùng vẫn có thể sử dụng hiệu quả mà không biết chi tiết công nghệ nền tảng."
      },
      {
        "question_id": 11,
        "question_title": "Excellent drawing skills are needed to create effective storyboards.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Storyboard trong UX chủ yếu dùng để truyền đạt ý tưởng, ngữ cảnh sử dụng và luồng tương tác, không đòi hỏi kỹ năng vẽ đẹp. Hình vẽ đơn giản, kể cả que diêm (stick figures) vẫn có thể truyền tải hiệu quả thông điệp thiết kế."
      },
      {
        "question_id": 12,
        "question_title": "It's typically obvious which design solution, among alternatives they generated, designers should pursue.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Trong thực tế thiết kế, việc lựa chọn giải pháp tốt nhất giữa nhiều phương án thường không rõ ràng ngay lập tức; đó là lý do cần đánh giá, kiểm thử với người dùng và thu thập dữ liệu để đưa ra quyết định sáng suốt."
      },
      {
        "question_id": 13,
        "question_title": "While designers have to set defaults for many design elements, these default values rarely matter since users can just change them at any time.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Giá trị mặc định rất quan trọng vì phần lớn người dùng không thay đổi cài đặt mặc định. Do đó, thiết kế mặc định hợp lý ảnh hưởng lớn đến trải nghiệm và hành vi sử dụng của đa số người dùng."
      },
      {
        "question_id": 14,
        "question_title": "When sketching to come up with different design solutions, you should stop the first time you run out of ideas.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Trong quá trình phác thảo ý tưởng thiết kế, việc dừng lại ngay khi 'hết ý tưởng' thường bỏ lỡ các giải pháp sáng tạo hơn. Nên tiếp tục cố gắng vượt qua điểm bí ý tưởng ban đầu để khám phá thêm nhiều phương án khác nhau."
      },
      {
        "question_id": 15,
        "question_title": "In UX, \"Design\" is concerned only with the aesthetic (or beauty-related) aspects of products.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Trong UX, 'Design' không chỉ liên quan đến tính thẩm mỹ mà còn bao gồm chức năng, khả năng sử dụng, cấu trúc thông tin và trải nghiệm tổng thể của người dùng với sản phẩm."
      },
      {
        "question_id": 16,
        "question_title": "The primary concern of design is to create artifacts and systems that are aesthetically pleasing.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Mối quan tâm chính của thiết kế không chỉ là tính thẩm mỹ mà quan trọng hơn là tạo ra các sản phẩm/hệ thống đáp ứng đúng nhu cầu, dễ sử dụng và mang lại giá trị thực sự cho người dùng, tính thẩm mỹ chỉ là một trong nhiều yếu tố cần cân nhắc."
      },
      {
        "question_id": 17,
        "question_title": "Scenarios help designers reflect on user needs, how technology might address those needs, and potential issues that might arise with the use of the envisioned technology.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Scenario (kịch bản) là công cụ giúp nhà thiết kế suy ngẫm về nhu cầu người dùng, cách công nghệ có thể đáp ứng nhu cầu đó, và các vấn đề tiềm ẩn có thể phát sinh khi sử dụng công nghệ được hình dung, đây là định nghĩa đúng về mục đích của scenario trong thiết kế."
      },
      {
        "question_id": 18,
        "question_title": "Formal research methods are always preferable to informal methods for doing formative research.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Phương pháp nghiên cứu chính thức không phải lúc nào cũng tốt hơn phương pháp phi chính thức; việc lựa chọn phương pháp phù hợp phụ thuộc vào mục tiêu, nguồn lực và ngữ cảnh cụ thể của dự án nghiên cứu hình thành (formative research)."
      },
      {
        "question_id": 19,
        "question_title": "Although there are different types of input, UX designers only need to focus on designing the information that users will explicitly enter into the system.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Nhận định này sai vì ngoài input chủ động (explicit) do người dùng nhập, còn có input thụ động (passive input) như vị trí, dữ liệu cảm biến... mà nhà thiết kế UX cũng cần quan tâm khi thiết kế hệ thống."
      },
      {
        "question_id": 20,
        "question_title": "True or False: If you take good notes, there is no reason to capture a screen recording of user test sessions for later review.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Nhận định này sai vì việc quay màn hình vẫn rất quan trọng để xem lại chi tiết các thao tác, phản ứng của người dùng mà ghi chú thủ công có thể bỏ sót hoặc không ghi lại đầy đủ, nên đáp án B đúng."
      },
      {
        "question_id": 21,
        "question_title": "Problem scoping is a fundamental part of the design process.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Xác định phạm vi vấn đề (problem scoping) là bước nền tảng, giúp nhà thiết kế hiểu rõ ranh giới và bản chất của vấn đề cần giải quyết trước khi tiến hành các bước thiết kế tiếp theo, nên đáp án A (True) đúng."
      },
      {
        "question_id": 22,
        "question_title": "Bill Buxton states that all design is \"compromise.\" By this he means that fundamentally no design is particularly good.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Ý của Bill Buxton là mọi thiết kế đều phải cân bằng, đánh đổi giữa nhiều yếu tố và ràng buộc khác nhau (compromise), chứ không có nghĩa là thiết kế không thể tốt. Một thiết kế tốt vẫn có thể đạt được dù phải thỏa hiệp giữa các yếu tố."
      },
      {
        "question_id": 23,
        "question_title": "Designers conduct formative research using a single, unified set of methods.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Nghiên cứu hình thành (formative research) sử dụng nhiều phương pháp khác nhau (đa dạng) tùy vào câu hỏi nghiên cứu và ngữ cảnh, chứ không phải chỉ dùng một bộ phương pháp thống nhất duy nhất."
      },
      {
        "question_id": 24,
        "question_title": "\"Pull\" output gives user high level of control of information access.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Đầu ra dạng 'pull' (người dùng chủ động yêu cầu/lấy thông tin) cho phép người dùng kiểm soát cao khi nào và thông tin gì họ muốn truy cập, khác với 'push' (hệ thống tự động đẩy thông tin đến người dùng)."
      },
      {
        "question_id": 378,
        "question_title": "In the \"generation\" phase, your goal should be to sketch many different design ideas rather than to perfect a single idea.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Giai đoạn tạo ý tưởng (generation phase) áp dụng tư duy phân kỳ (divergent thinking), mục tiêu cốt lõi là tạo ra số lượng lớn các ý tưởng đa dạng thay vì đi sâu vào hoàn thiện một ý tưởng duy nhất ngay từ đầu."
      },
      {
        "question_id": 382,
        "question_title": "True or False: Baseline statistics such as task completion rate, time spent on task, and/or error rates should be included in user test reports.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Báo cáo kiểm thử người dùng chuẩn cần chứa các chỉ số nền tảng (baseline statistics) như tỷ lệ hoàn thành, thời gian thực hiện và tỷ lệ lỗi để đo lường định lượng mức độ hiệu quả."
      },
      {
        "question_id": 389,
        "question_title": "Personas are purely fictional characters.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Personas không hoàn toàn là nhân vật hư cấu; chúng được xây dựng dựa trên dữ liệu và insight thực tế thu thập được từ nghiên cứu người dùng (formative research), đại diện cho các nhóm người dùng mục tiêu thực sự, dù được trình bày dưới dạng một 'nhân vật' tổng hợp."
      },
      {
        "question_id": 390,
        "question_title": "Wizard of Oz prototypes are most useful for prototyping screen-based applications",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Wizard of Oz prototype là kỹ thuật trong đó một người vận hành ẩn danh mô phỏng hành vi của hệ thống (thường là các hệ thống thông minh, tương tác thoại, hoặc chưa có công nghệ hoàn chỉnh) để tạo cảm giác hệ thống đang hoạt động tự động. Kỹ thuật này hữu ích hơn cho các trải nghiệm phức tạp, không chỉ giới hạn ở ứng dụng dựa trên màn hình, nên phát biểu này là sai."
      },
      {
        "question_id": 405,
        "question_title": "“Push” output can time information delivery for maximum effectiveness.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Mô hình \"Push\" (hệ thống chủ động đẩy thông tin) có thể chủ động lựa chọn thời điểm gửi thông tin (ví dụ: nhắc lịch đúng lúc) để đạt hiệu quả tối đa cho người dùng."
      },
      {
        "question_id": 413,
        "question_title": "Ideation mostly happens at the start of the design process when the designer is first coming up with possible solutions to the design problem.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Giai đoạn Tạo ý tưởng (Ideation) chủ yếu diễn ra ở đầu quy trình thiết kế, ngay sau khi vấn đề đã được định hình rõ ràng, nhằm tìm kiếm càng nhiều phương án và giải pháp khả thi càng tốt."
      },
      {
        "question_id": 418,
        "question_title": "It is important not to criticize ideas during brainstorming.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Đây là một trong những nguyên tắc cơ bản của brainstorming: không chỉ trích ý tưởng ngay khi chúng được đưa ra, vì điều này sẽ kìm hãm sự sáng tạo và khiến người tham gia ngại chia sẻ ý tưởng táo bạo. Việc đánh giá, chọn lọc ý tưởng nên diễn ra ở giai đoạn sau."
      },
      {
        "question_id": 419,
        "question_title": "Designers should aim to generate about half a dozen solutions when they ideate.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Trong giai đoạn ideate (lên ý tưởng), các nhà thiết kế nên cố gắng tạo ra CÀNG NHIỀU ý tưởng càng tốt (thường là hàng chục ý tưởng), không nên giới hạn ở khoảng nửa tá (6 ý tưởng), vì mục tiêu của ideation là khám phá không gian giải pháp rộng nhất có thể trước khi thu hẹp lại."
      },
      {
        "question_id": 422,
        "question_title": "It doesn't matter whether you initially create a low- or high-fidelity prototype. You can get the same kind of feedback on either.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Prototype độ trung thực thấp (low-fidelity) thường dùng để thu thập phản hồi về ý tưởng, luồng chức năng tổng thể, trong khi prototype độ trung thực cao (high-fidelity) cho phản hồi chi tiết hơn về giao diện, thẩm mỹ và tương tác cụ thể. Vì vậy loại phản hồi thu được là khác nhau."
      },
      {
        "question_id": 431,
        "question_title": "Is the following statement true or false?\nYou should always include a pre-test questionnaire in any user test you conduct.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Bảng hỏi trước kiểm thử (pre-test questionnaire) không bắt buộc trong mọi buổi user test. Tùy thuộc vào mục tiêu nghiên cứu và thông tin đã thu thập trước đó (ví dụ từ bước tuyển mộ), nhà nghiên cứu có thể bỏ qua bước này để tiết kiệm thời gian."
      },
      {
        "question_id": 432,
        "question_title": "“Push” output can be time information delivery for maximum effectiveness.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Mô hình \"Push\" (đẩy thông tin chủ động từ hệ thống) cho phép căn chỉnh thời điểm gửi thông tin (ví dụ: thông báo đúng thời điểm người dùng cần) để đạt được hiệu quả trải nghiệm cao nhất."
      }
    ]
  }
];
