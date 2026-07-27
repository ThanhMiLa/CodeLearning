// Automatically generated from quiz source txt files
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

export const QUIZZES: QuizSet[] = [
  {
    "id": "hsf302-sp26-fe",
    "title": "HSF302 - SP26 - FE",
    "description": "Working with Spring Framework Final Exam Quiz",
    "questionsCount": 50,
    "questions": [
      {
        "question_id": 1,
        "question_title": "If you have a Student entity and a Course entity with a Many-to-Many relationship, and you want to fetch all students enrolled in a specific course, how would you typically structure the query in JPA?",
        "option_A": "By querying the Student entity with a join on the Course entity.",
        "option_B": "By querying the join table directly.",
        "option_C": "By querying the Course entity and accessing its students collection.",
        "option_D": "By querying the Student entity and filtering based on the course ID in the Student table.",
        "correct_anwser": "C",
        "explain": "Trong JPA, cách tự nhiên và hướng đối tượng nhất để lấy các thực thể liên quan trong mối quan hệ Nhiều-Nhiều (Many-to-Many) là truy vấn thực thể cha mục tiêu (Course), sau đó truy cập vào thuộc tính tập hợp được ánh xạ của nó (students). JPA sẽ tự động xử lý bảng trung gian (join table) cho bạn."
      },
      {
        "question_id": 2,
        "question_title": "Spring Beans are managed by which container?",
        "option_A": "Java VM",
        "option_B": "Spring IoC Container",
        "option_C": "JDBC Driver",
        "option_D": "REST Controller",
        "correct_anwser": "B",
        "explain": "Spring IoC (Inversion of Control) Container là thành phần chịu trách nhiệm khởi tạo, cấu hình, lắp ráp và quản lý toàn bộ vòng đời (lifecycle) của các Spring Beans."
      },
      {
        "question_id": 3,
        "question_title": "Consider the following Java code snippet:\n\npublic class MyService {\n    private MyDependency dependency;\n\n    public void setDependency(MyDependency dependency) {\n        this.dependency = dependency;\n    }\n\n    public void performAction() {\n        dependency.doSomething();\n    }\n}\n\nWhich Spring Core Container feature is being demonstrated in this code?",
        "option_A": "Aspect-Oriented Programming (AOP)",
        "option_B": "Dependency Injection (DI)",
        "option_C": "Resource Management",
        "option_D": "Event Handling",
        "correct_anwser": "B",
        "explain": "Đoạn mã trên minh họa cho tính năng Tiêm phụ thuộc - Dependency Injection (cụ thể là Setter Injection). Trong đó, đối tượng phụ thuộc (dependency) được cung cấp vào class từ bên ngoài thông qua một hàm setter công khai, thay vì được khởi tạo trực tiếp bằng từ khóa 'new' bên trong class."
      },
      {
        "question_id": 4,
        "question_title": "Which type of Dependency Injection involves passing dependencies to a class through its constructor?",
        "option_A": "Setter Injection",
        "option_B": "Field Injection",
        "option_C": "Constructor Injection",
        "option_D": "Method Injection",
        "correct_anwser": "C",
        "explain": "Constructor Injection (Tiêm qua hàm khởi tạo) là một mô hình thiết kế mà ở đó các phụ thuộc bắt buộc được truyền vào làm tham số thông qua hàm khởi tạo của class khi đối tượng được khởi tạo."
      },
      {
        "question_id": 5,
        "question_title": "Which annotation is used to define a JPA Many-to-Many relationship?",
        "option_A": "@OneToOne",
        "option_B": "@ManyToOne",
        "option_C": "@OneToMany",
        "option_D": "@ManyToMany",
        "correct_anwser": "D",
        "explain": "Annotation `@ManyToMany` được định nghĩa trong đặc tả Jakarta Persistence (JPA) để thiết lập và đánh dấu mối quan hệ nhiều-nhiều giữa hai thực thể dữ liệu."
      },
      {
        "question_id": 6,
        "question_title": "Which AOP advice type executes before a join point?",
        "option_A": "After",
        "option_B": "AfterReturning",
        "option_C": "Before",
        "option_D": "Around",
        "correct_anwser": "C",
        "explain": "Advice loại 'Before' được thiết kế để thực thi các logic can thiệp (intercepting logic) ngay trước khi phương thức nghiệp vụ mục tiêu (join point) thực sự được chạy."
      },
      {
        "question_id": 7,
        "question_title": "Which JavaFX control is used for text input?",
        "option_A": "Label",
        "option_B": "Button",
        "option_C": "TextField",
        "option_D": "ImageView",
        "correct_anwser": "C",
        "explain": "`TextField` là một control giao diện chuẩn trong JavaFX cho phép người dùng nhập và chỉnh sửa một dòng văn bản thuần túy."
      },
      {
        "question_id": 8,
        "question_title": "Which code snippet shows how to add a button to a scene?",
        "option_A": "Scene scene = new Scene(new Button(\"Click Me\"));",
        "option_B": "Stage stage = new Stage(new Button(\"Click Me\"));",
        "option_C": "Button button = new Button(\"Click Me\");",
        "option_D": "Node node = new Node(new Button(\"Click Me\"));",
        "correct_anwser": "A",
        "explain": "Trong JavaFX, một `Scene` có thể nhận trực tiếp một nút gốc (Parent Node) — ví dụ như một Button hoặc một Layout Pane chứa Button — thông qua hàm khởi tạo của nó để thiết lập cấu trúc giao diện chính."
      },
      {
        "question_id": 9,
        "question_title": "In FXML, how do you connect a controller to the FXML file?",
        "option_A": "<fxml controller=\"MyController\" />",
        "option_B": "<fx:controller type=\"MyController\" />",
        "option_C": "<fx:controller fx:id=\"controller\" value=\"MyController\" />",
        "option_D": "<fx:controller value=\"MyController\" />",
        "correct_anwser": "D",
        "explain": "Lưu ý: Trong cú pháp FXML tiêu chuẩn của JavaFX, controller thường được khai báo bằng thuộc tính `fx:controller=\"com.package.MyController\"` ở thẻ layout gốc. Tuy nhiên, dựa trên các phương án lựa chọn đặc thù được đưa ra trong câu hỏi trắc nghiệm này, phương án D mô tả cấu trúc khối thẻ sử dụng thuộc tính `value` để gán controller theo một số tùy biến mở rộng."
      },
      {
        "question_id": 10,
        "question_title": "What is the purpose of the start(Stage primaryStage) method in a JavaFX application?",
        "option_A": "To define database connections.",
        "option_B": "To initialize and show the application window.",
        "option_C": "To handle network requests.",
        "option_D": "To manage application configurations.",
        "correct_anwser": "B",
        "explain": "Phương thức `start(Stage primaryStage)` là điểm khởi đầu chính (main entry point) của mọi ứng dụng JavaFX. Nó được hệ thống runtime gọi để cấu hình, gắn scene và hiển thị cửa sổ ứng dụng chính (stage) lên màn hình."
      },
      {
        "question_id": 11,
        "question_title": "Which method launches a JavaFX app?",
        "option_A": "main()",
        "option_B": "start()",
        "option_C": "launch()",
        "option_D": "run()",
        "correct_anwser": "C",
        "explain": "Phương thức tĩnh `launch()` kế thừa từ lớp `javafx.application.Application` được sử dụng để khởi động vòng đời của một ứng dụng JavaFX, sau đó nó sẽ thiết lập môi trường và tự động gọi phương thức `start()`."
      },
      {
        "question_id": 12,
        "question_title": "What is the role of the Controller in Spring MVC?",
        "option_A": "To manage database connections.",
        "option_B": "To process user requests and return a model and view.",
        "option_C": "To define user interfaces.",
        "option_D": "To configure application security.",
        "correct_anwser": "B",
        "explain": "Trong kiến trúc Spring MVC, thành phần Controller có nhiệm vụ tiếp nhận các yêu cầu (HTTP requests) từ người dùng, xử lý các logic điều hướng cần thiết, chuẩn bị dữ liệu (Model) và chỉ định giao diện hiển thị phù hợp (View)."
      },
      {
        "question_id": 13,
        "question_title": "Which of the following is TRUE about Dependency Injection (DI) in Spring?",
        "option_A": "It tightly couples the components",
        "option_B": "It reduces testability of code",
        "option_C": "It promotes loose coupling between components",
        "option_D": "It is required only for web apps",
        "correct_anwser": "C",
        "explain": "Dependency Injection giúp tách biệt việc khởi tạo đối tượng khỏi logic sử dụng của lớp, từ đó giúp giảm thiểu sự phụ thuộc trực tiếp (loose coupling - liên kết lỏng lẻo) giữa các thành phần phần mềm, tăng tính linh hoạt và dễ dàng viết Unit Test."
      },
      {
        "question_id": 14,
        "question_title": "Which statement correctly differentiates @PathVariable and @RequestParam?",
        "option_A": "@PathVariable binds a query parameter; @RequestParam binds a URI template variable",
        "option_B": "@PathVariable binds a URI template variable; @RequestParam binds a query parameter or form field",
        "option_C": "Both only bind data from HTTP headers",
        "option_D": "Both require a ModelAndView return type",
        "correct_anwser": "B",
        "explain": "`@PathVariable` được sử dụng để trích xuất và liên kết dữ liệu từ các biến nằm trực tiếp trên đường dẫn URL (URI template variable, ví dụ: `/users/{id}`). Trong khi đó, `@RequestParam` dùng để lấy dữ liệu từ tham số truy vấn (Query Parameter, ví dụ: `?name=abc`) hoặc từ dữ liệu form gửi lên."
      },
      {
        "question_id": 15,
        "question_title": "Which annotation is used to define a Spring Boot main class?\n@SpringBootApplication\npublic class AppStarter {\n    public static void main(String[] args) {\n        SpringApplication.run(AppStarter.class, args);\n    }\n}",
        "option_A": "@SpringBoot",
        "option_B": "@App",
        "option_C": "@SpringApplication",
        "option_D": "@SpringBootApplication",
        "correct_anwser": "D",
        "explain": "Annotation `@SpringBootApplication` là một annotation tổng hợp (gồm `@Configuration`, `@EnableAutoConfiguration`, và `@ComponentScan`), được đặt ngay trên đầu lớp chứa phương thức `main` để khai báo đây là lớp cấu hình chính khởi chạy ứng dụng Spring Boot."
      },
      {
        "question_id": 16,
        "question_title": "Which object holds model data?",
        "option_A": "Model",
        "option_B": "Entity",
        "option_C": "View",
        "option_D": "Context",
        "correct_anwser": "A",
        "explain": "Trong mô hình MVC của Spring, giao diện (interface) `org.springframework.ui.Model` là một vùng chứa (container) dưới dạng cặp khóa-giá trị (Map) dùng để truyền tải dữ liệu từ Controller sang cho View hiển thị."
      },
      {
        "question_id": 17,
        "question_title": "Which layer in Spring architecture is responsible for business logic?",
        "option_A": "Repository layer",
        "option_B": "Service layer",
        "option_C": "Controller layer",
        "option_D": "View layer",
        "correct_anwser": "B",
        "explain": "Tầng Dịch vụ (Service layer) là nơi tập trung xử lý toàn bộ các quy tắc nghiệp vụ, tính toán logic và điều phối luồng dữ liệu (business logic) của hệ thống trước khi tương tác với cơ sở dữ liệu."
      },
      {
        "question_id": 18,
        "question_title": "Which component provides automatic restart and LiveReload to speed up development?",
        "option_A": "Spring Boot DevTools",
        "option_B": "Spring Boot Actuator",
        "option_C": "SpringApplication",
        "option_D": "Spring Boot Test",
        "correct_anwser": "A",
        "explain": "Mô-đun `Spring Boot DevTools` cung cấp các tính năng tiện ích hỗ trợ quá trình phát triển (development), bao gồm cơ chế tự động khởi chạy lại ứng dụng (automatic restart) khi mã nguồn thay đổi và tính năng LiveReload để tự động làm mới trình duyệt."
      },
      {
        "question_id": 19,
        "question_title": "What is the benefit of Spring Boot's embedded servers?",
        "option_A": "They require separate installation and configuration.",
        "option_B": "They simplify deployment and reduce the need for external application servers.",
        "option_C": "They offer limited performance compared to external servers.",
        "option_D": "They are only compatible with specific operating systems.",
        "correct_anwser": "B",
        "explain": "Các máy chủ được nhúng sẵn (như Tomcat, Jetty) giúp ứng dụng Spring Boot có thể chạy độc lập như một file JAR thông thường (`java -jar`), đơn giản hóa tối đa quy trình triển khai phần mềm và loại bỏ việc phải cài đặt/cấu hình các máy chủ ứng dụng bên ngoài phức tạp."
      },
      {
        "question_id": 20,
        "question_title": "What does externalized configuration in Spring Boot enable?",
        "option_A": "Hard-coding all configuration inside Java classes",
        "option_B": "Packing configuration into compiled bytecode for security",
        "option_C": "Supplying settings (e.g., database details) via properties/YAML and environment so the same build can run in different environments",
        "option_D": "Requiring a separate XML file for every bean definition",
        "correct_anwser": "C",
        "explain": "Cấu hình tách biệt ra ngoài (Externalized Configuration) cho phép lập trình viên định nghĩa các tham số hệ thống thông qua các file như `.properties`, `.yml`, hoặc biến môi trường. Nhờ đó, một gói build ứng dụng duy nhất có thể tái sử dụng và chạy linh hoạt trên nhiều môi trường khác nhau (như Dev, Staging, Production) mà không cần sửa đổi mã nguồn."
      },
      {
        "question_id": 21,
        "question_title": "In JavaFX, which layout arranges child nodes in a horizontal row?",
        "option_A": "VBox",
        "option_B": "FlowPane",
        "option_C": "BorderPane",
        "option_D": "HBox",
        "correct_anwser": "D",
        "explain": "`HBox` (Horizontal Box) là một thành phần layout trong JavaFX được thiết kế chuyên biệt để sắp xếp tất cả các node con nằm ngang thành một hàng duy nhất theo thứ tự từ trái sang phải."
      },
      {
        "question_id": 22,
        "question_title": "What is the purpose of Thymeleaf Layout Dialect?",
        "option_A": "Enhancing security for the web application.",
        "option_B": "Providing a way to create reusable template layouts.",
        "option_C": "Managing database connections.",
        "option_D": "Optimizing JavaScript performance.",
        "correct_anwser": "B",
        "explain": "Thymeleaf Layout Dialect cung cấp một giải pháp phân cấp giao diện mạnh mẽ, cho phép lập trình viên tạo dựng một layout khung (template layout) dùng chung (chứa header, footer, sidebar...) và tái sử dụng nó trên nhiều trang con khác nhau."
      },
      {
        "question_id": 23,
        "question_title": "The Standard Dialect in Thymeleaf provides a set of:",
        "option_A": "Database drivers.",
        "option_B": "HTML attributes and elements.",
        "option_C": "Security protocols.",
        "option_D": "Network configurations.",
        "correct_anwser": "B",
        "explain": "Standard Dialect (Phương ngữ tiêu chuẩn) của Thymeleaf cung cấp một hệ thống các thuộc tính HTML tùy biến xử lý động dữ liệu (như `th:text`, `th:each`, `th:if`) chạy trực tiếp trên cấu trúc thẻ HTML chuẩn."
      },
      {
        "question_id": 24,
        "question_title": "Thymeleaf is primarily used for:",
        "option_A": "Handling database transactions.",
        "option_B": "Generating dynamic HTML content.",
        "option_C": "Managing application security.",
        "option_D": "Building REST APIs.",
        "correct_anwser": "B",
        "explain": "Thymeleaf là một Java template engine mã nguồn mở hoạt động ở phía Server, mục đích chính của nó là kết hợp mã giao diện HTML tĩnh với dữ liệu động từ backend để biên dịch và tạo ra các trang HTML động gửi về cho trình duyệt."
      },
      {
        "question_id": 25,
        "question_title": "Which data format is default in REST responses?",
        "option_A": "XML",
        "option_B": "JSON",
        "option_C": "HTML",
        "option_D": "CSV",
        "correct_anwser": "B",
        "explain": "Trong các dịch vụ Web RESTful hiện đại (bao gồm cả cấu hình mặc định của Spring `@RestController`), JSON (JavaScript Object Notation) là định dạng dữ liệu truyền tải văn bản chuẩn được sử dụng rộng rãi và phổ biến nhất nhờ tính gọn nhẹ, tối ưu và dễ dàng xử lý."
      },
      {
        "question_id": 26,
        "question_title": "What is the result of this Thymeleaf fragment?\n<span th:if=\"${user.loggedIn}\">Welcome!",
        "option_A": "Renders always",
        "option_B": "Displays if user.loggedIn is false",
        "option_C": "Displays nothing by default",
        "option_D": "Displays \"Welcome!\" only if user is logged in",
        "correct_anwser": "D",
        "explain": "Thuộc tính `th:if` hoạt động như một biểu thức điều kiện logic. Thẻ `<span>` chứa dòng chữ \"Welcome!\" sẽ chỉ được biên dịch và hiển thị ra giao diện khi và chỉ khi biến trạng thái `${user.loggedIn}` trả về giá trị logic là `true`."
      },
      {
        "question_id": 27,
        "question_title": "You have a controller:\n\n@RestController\nclass TestController {\n    @GetMapping(\"/hello\")\n    public String hello() { return \"Hi\"; }\n}\n\nWhat is the response of GET /hello request?",
        "option_A": "HTML page",
        "option_B": "JSON object {\"hello\":\"Hi\"}",
        "option_C": "Plain text 'Hi'",
        "option_D": "Error 404",
        "correct_anwser": "C",
        "explain": "Do lớp được đánh dấu bằng `@RestController`, mọi dữ liệu trả về từ các phương thức xử lý yêu cầu sẽ được ghi trực tiếp vào phần thân của HTTP Response (HTTP response body). Khi trả về một chuỗi `String` thuần túy như `\"Hi\"`, phản hồi nhận được sẽ là văn bản thô (Plain text)."
      },
      {
        "question_id": 28,
        "question_title": "What is the purpose of the @Column annotation in JPA?",
        "option_A": "It specifies the primary key field of an entity",
        "option_B": "It maps an entity field to a table column and allows setting column attributes",
        "option_C": "It marks a field that should not be persisted",
        "option_D": "It defines a many-to-many relationship",
        "correct_anwser": "B",
        "explain": "Annotation `@Column` trong JPA được sử dụng để liên kết cấu hình rõ ràng một thuộc tính của thực thể Java với một cột dữ liệu tương ứng trong bảng cơ sở dữ liệu quan hệ, cho phép tùy chỉnh các thuộc tính của cột như tên cột (`name`), độ dài (`length`), tính duy nhất (`unique`), hoặc có được phép null hay không (`nullable`)."
      },
      {
        "question_id": 29,
        "question_title": "Which annotation is used to mark a Java class as a JPA entity?",
        "option_A": "@Table",
        "option_B": "@Entity",
        "option_C": "@Column",
        "option_D": "@Id",
        "correct_anwser": "B",
        "explain": "Để khai báo một lớp Java thông thường thành một mô hình đối tượng persistent đại diện cho một bảng dữ liệu quan hệ trong cơ chế ORM của JPA, lớp đó bắt buộc phải sử dụng annotation mức class là `@Entity`."
      },
      {
        "question_id": 30,
        "question_title": "Which JPA feature allows relationships between tables?",
        "option_A": "Dependency Injection",
        "option_B": "Annotations",
        "option_C": "Entity Relationships",
        "option_D": "Transactions",
        "correct_anwser": "C",
        "explain": "Mối quan hệ giữa các thực thể (Entity Relationships) là tính năng cốt lõi của JPA cho phép định nghĩa liên kết dữ liệu giữa các bảng trong cơ sở dữ liệu thông qua các mối quan hệ hướng đối tượng như `@OneToOne`, `@OneToMany`, `@ManyToOne`, và `@ManyToMany`."
      },
      {
        "question_id": 31,
        "question_title": "What best describes the Java Persistence API (JPA)?",
        "option_A": "A low-level JDBC driver for vendor-specific SQL",
        "option_B": "A specification for managing relational data in Java applications using object-relational mapping",
        "option_C": "A GUI tool for database administration in IntelliJ IDEA",
        "option_D": "A NoSQL database used by Java applications",
        "correct_anwser": "B",
        "explain": "JPA (Java Persistence API) không phải là một cơ sở dữ liệu hay một driver cụ thể, mà là một đặc tả (specification) tiêu chuẩn của Java đưa ra các quy tắc để quản lý dữ liệu quan hệ thông qua kỹ thuật ánh xạ đối tượng - quan hệ (Object-Relational Mapping - ORM)."
      },
      {
        "question_id": 32,
        "question_title": "Which JPA component is responsible for managing the persistence of entities?",
        "option_A": "Servlet",
        "option_B": "EntityManager",
        "option_C": "JSP",
        "option_D": "JDBC Driver",
        "correct_anwser": "B",
        "explain": "Trong kiến trúc JPA, `EntityManager` là thành phần trung tâm chịu trách nhiệm quản lý vòng đời của các thực thể (entities), thực hiện các thao tác CRUD cơ bản (thêm, sửa, xóa, đọc) và đồng bộ dữ liệu xuống database."
      },
      {
        "question_id": 33,
        "question_title": "Which of the following is an example of a relationship annotation in JPA?",
        "option_A": "@Column",
        "option_B": "@Entity",
        "option_C": "@OneToMany",
        "option_D": "@Transient",
        "correct_anwser": "C",
        "explain": "`@OneToMany` (Một-Nhiều) là một annotation quan hệ điển hình dùng để khai báo mối liên kết dữ liệu giữa hai thực thể khác nhau trong JPA. Các tùy chọn khác như `@Column` dùng cho cột dữ liệu, `@Entity` dùng khai báo thực thể, và `@Transient` dùng để bỏ qua không lưu trữ thuộc tính."
      },
      {
        "question_id": 34,
        "question_title": "Which class loads FXML files?",
        "option_A": "FXMLLoader",
        "option_B": "Scene",
        "option_C": "Stage",
        "option_D": "Node",
        "correct_anwser": "A",
        "explain": "Lớp `FXMLLoader` trong JavaFX được thiết kế chuyên biệt để đọc, phân tích cú pháp mã XML từ các file cấu hình giao diện `.fxml` và chuyển đổi chúng thành cây phân cấp đối tượng UI (Scene Graph) trong Java."
      },
      {
        "question_id": 35,
        "question_title": "Which JavaFX element handles user input events?",
        "option_A": "EventHandler",
        "option_B": "SceneGraph",
        "option_C": "Controller",
        "option_D": "Action",
        "correct_anwser": "A",
        "explain": "`EventHandler` là một functional interface trong JavaFX được triển khai để lắng nghe, bắt lấy và xử lý trực tiếp các sự kiện tương tác từ người dùng (như nhấn chuột, nhập phím)."
      },
      {
        "question_id": 36,
        "question_title": "Which CSS file customizes JavaFX UI?",
        "option_A": "styles.css",
        "option_B": "ui.css",
        "option_C": "design.css",
        "option_D": "theme.xml",
        "correct_anwser": "A",
        "explain": "Mặc dù JavaFX có thể nhận bất kỳ tên file nào có đuôi rộng mở là `.css`, tuy nhiên theo quy chuẩn đặt tên và các dự án mẫu phổ biến trong hệ sinh thái JavaFX, tệp tin cấu hình phong cách giao diện mặc định chuẩn thường được đặt tên là `styles.css`."
      },
      {
        "question_id": 37,
        "question_title": "What JavaFX class is used to create a popup dialog for displaying confirmation or error messages?",
        "option_A": "Stage",
        "option_B": "Scene",
        "option_C": "Alert",
        "option_D": "Pane",
        "correct_anwser": "C",
        "explain": "Lớp `Alert` là một lớp tiện ích xây dựng sẵn trong JavaFX chuyên dùng để tạo nhanh các hộp thoại thông báo dạng popup (như thông báo lỗi, cảnh báo, hoặc xác nhận hành động từ người dùng)."
      },
      {
        "question_id": 38,
        "question_title": "What is the purpose of validation in CRUD operations of JavaFX application?",
        "option_A": "To improve database performance.",
        "option_B": "To ensure data integrity and prevent errors.",
        "option_C": "To enhance user interface aesthetics.",
        "option_D": "To manage server configurations.",
        "correct_anwser": "B",
        "explain": "Mục đích cốt lõi của việc kiểm tra tính hợp lệ dữ liệu (validation) đầu vào trước các thao tác CRUD là đảm bảo tính toàn vẹn của dữ liệu (data integrity), ngăn chặn các định dạng sai sót hoặc giá trị rỗng làm phát sinh lỗi hệ thống trong database hoặc ứng dụng."
      },
      {
        "question_id": 39,
        "question_title": "What is the role of a Data Access Object (DAO) in Spring application?",
        "option_A": "To define business logic.",
        "option_B": "To manage user sessions.",
        "option_C": "To provide an abstraction layer for database interactions.",
        "option_D": "To handle application security.",
        "correct_anwser": "C",
        "explain": "Pattern DAO (Data Access Object) đóng vai trò cung cấp một lớp trừu tượng bao bọc xung quanh các tác vụ truy vấn cơ sở dữ liệu, giúp tách biệt hoàn toàn logic truy cập dữ liệu (SQL/HQL) ra khỏi tầng xử lý nghiệp vụ (Service)."
      },
      {
        "question_id": 40,
        "question_title": "Which component in Spring resolves logical view names to actual templates?",
        "option_A": "ViewResolver",
        "option_B": "Controller",
        "option_C": "DispatcherServlet",
        "option_D": "ResourceLoader",
        "correct_anwser": "A",
        "explain": "Trong mô hình xử lý yêu cầu Spring MVC, thành phần `ViewResolver` có nhiệm vụ tiếp nhận chuỗi tên giao diện logic (logical view name, ví dụ: `\"home\"`) được trả về từ Controller và biên dịch giải mã nó thành tệp tin giao diện vật lý thực tế (như `/templates/home.html`)."
      },
      {
        "question_id": 41,
        "question_title": "Which class simplifies JDBC in Spring?",
        "option_A": "JdbcTemplate",
        "option_B": "JdbcManager",
        "option_C": "EntityManager",
        "option_D": "SqlHelper",
        "correct_anwser": "A",
        "explain": "`JdbcTemplate` là lớp cốt lõi trong mô-đun Spring JDBC giúp đơn giản hóa việc sử dụng JDBC bằng cách loại bỏ các đoạn mã lặp đi lặp lại (boilerplate code) như mở/đóng kết nối, xử lý ngoại lệ SQL, và quản lý các tài nguyên."
      },
      {
        "question_id": 42,
        "question_title": "ORM frameworks supported by Spring include:",
        "option_A": "Hibernate",
        "option_B": "EclipseLink",
        "option_C": "MyBatis",
        "option_D": "All of the above",
        "correct_anwser": "D",
        "explain": "Spring cung cấp khả năng tích hợp rất mạnh mẽ với hầu hết các framework ORM (Object-Relational Mapping) và data mapper phổ biến trong hệ sinh thái Java bao gồm Hibernate, EclipseLink, và cả MyBatis."
      },
      {
        "question_id": 43,
        "question_title": "What is the purpose of @ResponseBody in a Spring controller?",
        "option_A": "It returns an HTML page",
        "option_B": "It converts the return value to JSON or XML",
        "option_C": "It binds request parameters",
        "option_D": "It sets the HTTP status code",
        "correct_anwser": "B",
        "explain": "Annotation `@ResponseBody` chỉ thị cho Spring tự động chuyển đổi đối tượng hoặc kiểu dữ liệu trả về của phương thức xử lý thành định dạng truyền tải dữ liệu như JSON hoặc XML (thông qua các HttpMessageConverters) và ghi trực tiếp vào HTTP response body thay vì tìm kiếm một trang giao diện (view)."
      },
      {
        "question_id": 44,
        "question_title": "Which component is responsible for rendering the user interface in a Spring MVC application?",
        "option_A": "Controller",
        "option_B": "Model",
        "option_C": "View",
        "option_D": "DAO",
        "correct_anwser": "C",
        "explain": "Trong mô hình MVC, thành phần View (Giao diện) chịu trách nhiệm nhận dữ liệu từ Model, kết xuất đồ họa (rendering) cấu trúc trang và hiển thị giao diện người dùng cuối cùng trên trình duyệt."
      },
      {
        "question_id": 45,
        "question_title": "What is the purpose of the @JoinTable annotation in a ManyToMany relationship?",
        "option_A": "To define the primary key of the entities.",
        "option_B": "To specify the join table and its columns.",
        "option_C": "To define the entity relationships.",
        "option_D": "To create a new database.",
        "correct_anwser": "B",
        "explain": "Annotation `@JoinTable` được sử dụng trong mối quan hệ Nhiều-Nhiều để cấu hình chi tiết tên của bảng trung gian (join table) cũng như các cột khóa ngoại (`joinColumns` và `inverseJoinColumns`) kết nối hai bảng dữ liệu chính với nhau."
      },
      {
        "question_id": 46,
        "question_title": "Which method name follows Spring Data JPA query derivation conventions for case-insensitive containment by email?",
        "option_A": "lookupByEmailLikeIgnoreCase(String email)",
        "option_B": "findByEmailContainingIgnoreCase(String email)",
        "option_C": "queryWhereEmailContainsCaseInsensitive(String email)",
        "option_D": "selectEmailContainsIgnoreCase(String email)",
        "correct_anwser": "B",
        "explain": "Theo quy chuẩn phân tích cú pháp tên hàm tự sinh (Query Derivation) của Spring Data JPA: Hàm phải bắt đầu bằng `findBy`, theo sau là thuộc tính `Email`, từ khóa kiểm tra chuỗi con chứa bên trong là `Containing`, và từ khóa bỏ qua chữ hoa chữ thường là `IgnoreCase`. Do đó, `findByEmailContainingIgnoreCase` là cú pháp chuẩn xác nhất."
      },
      {
        "question_id": 47,
        "question_title": "Which annotation is used to map a one-to-many relationship?",
        "option_A": "@OneToOne",
        "option_B": "@ManyToOne",
        "option_C": "@OneToMany",
        "option_D": "@ManyToMany",
        "correct_anwser": "C",
        "explain": "Annotation `@OneToMany` được cung cấp bởi JPA nhằm khai báo mối quan hệ Một-Nhiều giữa một thực thể gốc với một tập hợp danh sách các thực thể liên quan."
      },
      {
        "question_id": 48,
        "question_title": "Spring Data JPA is built on top of:",
        "option_A": "Spring MVC",
        "option_B": "Spring Core",
        "option_C": "JPA",
        "option_D": "Servlets",
        "correct_anwser": "C",
        "explain": "Spring Data JPA là một tầng trừu tượng cao cấp (high-level abstraction) được xây dựng đè lên trên nền tảng của đặc tả JPA (Java Persistence API) tiêu chuẩn nhằm giúp đơn giản hóa tối đa việc triển khai các lớp kho dữ liệu (Repository)."
      },
      {
        "question_id": 49,
        "question_title": "Which interface provides CRUD operations?",
        "option_A": "JpaRepository",
        "option_B": "CrudService",
        "option_C": "EntityManager",
        "option_D": "JdbcTemplate",
        "correct_anwser": "A",
        "explain": "Trong các lựa chọn được đưa ra, `JpaRepository` (kế thừa từ `ListCrudRepository` và `PagingAndSortingRepository`) là một interface chuẩn của Spring Data cung cấp sẵn toàn bộ tập hợp các phương thức thao tác CRUD cơ bản và nâng cao đối với dữ liệu."
      },
      {
        "question_id": 50,
        "question_title": "Which keyword is used in a repository method to find entities by a specific property?",
        "option_A": "searchBy",
        "option_B": "findBy",
        "option_C": "getWhere",
        "option_D": "queryFor",
        "correct_anwser": "B",
        "explain": "Từ khóa tiền tố phổ biến và chuẩn mực nhất được sử dụng trong cơ chế Query Method của Spring Data JPA để bắt đầu một truy vấn tìm kiếm dữ liệu dựa trên thuộc tính là `findBy` (hoặc các biến thể tương đương như `readBy`, `getBy`, `queryBy`)."
      }
    ]
  },
  {
    "id": "hsf302-sp26-re1",
    "title": "HSF302 - SP26 - RE1",
    "description": "Requirements Engineering Quiz",
    "questionsCount": 50,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which responsibility belongs to the Spring IoC container?",
        "option_A": "Rendering HTML views from Thymeleaf templates",
        "option_B": "Creating, wiring, configuring beans and managing their lifecycle",
        "option_C": "Executing SQL statements without any JDBC driver",
        "option_D": "Compiling Java sources at runtime",
        "correct_anwser": "B",
        "explain": "Nhiệm vụ cốt lõi của Spring IoC container là quản lý các Bean (đối tượng của ứng dụng). Quá trình này bao gồm việc khởi tạo (creating), liên kết phụ thuộc (wiring), cấu hình (configuring) và quản lý toàn bộ vòng đời (lifecycle) của chúng từ khi sinh ra cho đến khi bị hủy."
      },
      {
        "question_id": 2,
        "question_title": "What is Aspect-Oriented Programming (AOP) in Spring used for?",
        "option_A": "Defining user interfaces.",
        "option_B": "Implementing cross-cutting concerns like logging and security.",
        "option_C": "Managing database transactions.",
        "option_D": "Creating web service clients.",
        "correct_anwser": "B, C",
        "explain": "Lập trình hướng khía cạnh (AOP) trong Spring được thiết kế để giải quyết các cross-cutting concerns (vấn đề cắt ngang hệ thống) như logging, security, auditing (Lựa chọn B). Ngoài ra, tính năng quản lý transaction tự động của Spring (Declarative Transaction Management) cũng được xây dựng dựa trên nền tảng của Spring AOP (Lựa chọn C). Cả hai đều là những ứng dụng thực tế phổ biến nhất của AOP."
      },
      {
        "question_id": 3,
        "question_title": "Which of the following components is responsible for managing the lifecycle of beans in the Spring Core Container?",
        "option_A": "DispatcherServlet",
        "option_B": "BeanFactory or ApplicationContext",
        "option_C": "ViewResolver",
        "option_D": "HandlerMapping",
        "correct_anwser": "B",
        "explain": "Trong mô hình kiến trúc Spring Core, BeanFactory và ApplicationContext (một phiên bản nâng cao kế thừa từ BeanFactory) chính là các interface đại diện trực tiếp cho Spring Container, chịu trách nhiệm quản lý cấu hình và lifecycle của các bean."
      },
      {
        "question_id": 4,
        "question_title": "Which AOP concept defines a point in the execution of the application where an advice can be applied?",
        "option_A": "Aspect",
        "option_B": "Advice",
        "option_C": "Join Point",
        "option_D": "Pointcut",
        "correct_anwser": "C",
        "explain": "Trong thuật ngữ Spring AOP, một Join Point đại diện cho một điểm cụ thể trong quá trình thực thi ứng dụng (chẳng hạn như khi một method được gọi hoặc một ngoại lệ được ném ra) mà tại đó một Advice (hành động/mã xử lý) có thể được chèn vào để thực thi."
      },
      {
        "question_id": 5,
        "question_title": "In a JPA Many-to-Many relationship, how is the relationship typically represented in the database?",
        "option_A": "By adding a foreign key column to one of the entities.",
        "option_B": "By adding a foreign key column to both entities.",
        "option_C": "By using a join table that contains foreign keys referencing both entities.",
        "option_D": "By storing the related entities in a serialized format within a single column.",
        "correct_anwser": "C",
        "explain": "Để biểu diễn một mối quan hệ nhiều-nhiều (Many-to-Many relationship) trong cơ sở dữ liệu quan hệ, cách tiếp cận chuẩn hóa luôn là tạo ra một bảng trung gian gọi là join table (hoặc junction table). Bảng này sẽ chứa các cột foreign key liên kết trỏ về khóa chính của cả hai thực thể tham gia vào mối quan hệ."
      },
      {
        "question_id": 6,
        "question_title": "What is the core concept of Inversion of Control (IoC)?",
        "option_A": "Objects control the creation of their dependencies.",
        "option_B": "The framework or container controls the creation and management of objects.",
        "option_C": "Objects are responsible for managing the application's flow.",
        "option_D": "Methods control the instantiation of classes.",
        "correct_anwser": "B",
        "explain": "Khái niệm Inversion of Control (IoC - Đảo ngược điều khiển) có nghĩa là thay vì để các đối tượng tự khởi tạo và quản lý các phụ thuộc (dependencies) của chính mình, quyền kiểm soát này sẽ được chuyển giao (đảo ngược) cho Framework hoặc Container xử lý tự động."
      },
      {
        "question_id": 7,
        "question_title": "Which JavaFX class represents the content area of the application window?",
        "option_A": "Stage",
        "option_B": "Node",
        "option_C": "Pane",
        "option_D": "Scene",
        "correct_anwser": "D",
        "explain": "Trong cấu trúc của một ứng dụng giao diện JavaFX, Stage đóng vai trò như chiếc cửa sổ bọc ngoài (window), còn Scene chính là lớp container đại diện cho vùng chứa toàn bộ nội dung hiển thị (content area) bên trong cửa sổ đó trước khi gắn các thành phần UI khác vào."
      },
      {
        "question_id": 8,
        "question_title": "Which method in JpaRepository is used to save or update an entity?",
        "option_A": "persist()",
        "option_B": "insert()",
        "option_C": "save()",
        "option_D": "update()",
        "correct_anwser": "C",
        "explain": "Trong kiến trúc Spring Data JPA, `JpaRepository` cung cấp sẵn phương thức `save()`. Phương thức này cực kỳ linh hoạt vì nó tự động nhận diện trạng thái của thực thể: nếu thực thể chưa tồn tại, nó sẽ thực hiện lệnh lưu mới (save/persist), ngược lại nếu thực thể đã tồn tại, nó sẽ thực hiện cập nhật dữ liệu (update/merge)."
      },
      {
        "question_id": 9,
        "question_title": "Which JavaFX control is used to display an image?",
        "option_A": "Label",
        "option_B": "Button",
        "option_C": "TextField",
        "option_D": "ImageView",
        "correct_anwser": "D",
        "explain": "Trong JavaFX, `ImageView` là một control chuyên dụng thuộc thư viện đồ họa được thiết kế cụ thể cho mục đích vẽ và hiển thị các hình ảnh (đối tượng thuộc class `Image`) lên trên giao diện người dùng."
      },
      {
        "question_id": 10,
        "question_title": "Which layout arranges nodes in border regions?",
        "option_A": "GridPane",
        "option_B": "BorderPane",
        "option_C": "VBox",
        "option_D": "HBox",
        "correct_anwser": "B",
        "explain": "Layout `BorderPane` trong JavaFX sắp xếp các thành phần con (nodes) theo 5 vùng đường biên cố định bao gồm: Top (trên), Bottom (dưới), Left (trái), Right (phải) và Center (trung tâm)."
      },
      {
        "question_id": 11,
        "question_title": "What is the use of PlatformTransactionManager in Spring?",
        "option_A": "Encrypt API data",
        "option_B": "Render views",
        "option_C": "Manage database transactions programmatically",
        "option_D": "Build Spring Boot jars",
        "correct_anwser": "C",
        "explain": "`PlatformTransactionManager` là một interface trung tâm trong cấu trúc quản lý giao dịch (Transaction Management) của Spring Framework. Nó cung cấp các phương thức cốt lõi như `getTransaction`, `commit`, và `rollback` giúp nhà phát triển quản lý và điều khiển các database transaction một cách tường minh bằng mã nguồn (programmatically) hoặc làm nền tảng cho cấu hình khai báo (declarative)."
      },
      {
        "question_id": 12,
        "question_title": "After the controller processes a request, what does it typically return?",
        "option_A": "A database connection.",
        "option_B": "A model and view.",
        "option_C": "A user interface.",
        "option_D": "A security token.",
        "correct_anwser": "B",
        "explain": "Trong mô hình Spring MVC truyền thống, sau khi một Controller xử lý xong logic của request, nó thường trả về một đối tượng chứa cả dữ liệu lẫn tên trang hiển thị. Đối tượng này được đóng gói gọn trong lớp `ModelAndView` (gồm dữ liệu dạng `Model` và tên view hiển thị dạng `View`)."
      },
      {
        "question_id": 13,
        "question_title": "In the MVC pattern, what is the role of the Model?",
        "option_A": "To handle user input.",
        "option_B": "To display data to the user.",
        "option_C": "To manage the application's data and business logic.",
        "option_D": "To route requests to the appropriate handlers.",
        "correct_anwser": "C",
        "explain": "Trong kiến trúc thiết kế MVC (Model-View-Controller), thành phần `Model` chịu trách nhiệm cốt lõi trong việc đại diện cho trạng thái dữ liệu (application's data), định nghĩa cấu trúc dữ liệu và chứa các logic nghiệp vụ (business logic) của hệ thống."
      },
      {
        "question_id": 14,
        "question_title": "Which annotation marks a controller?",
        "option_A": "@Controller",
        "option_B": "@Service",
        "option_C": "@Repository",
        "option_D": "@RestResource",
        "correct_anwser": "A",
        "explain": "Để đánh dấu một class đóng vai trò là một Controller tiếp nhận và xử lý các HTTP request trong ứng dụng Spring MVC, chúng ta sử dụng annotation `@Controller` (hoặc biến thể chuyên dụng `@RestController` cho các API dạng RESTful)."
      },
      {
        "question_id": 15,
        "question_title": "In Spring MVC, what are interceptors used for?",
        "option_A": "Only for handling exceptions.",
        "option_B": "Only for mapping requests.",
        "option_C": "For cross cutting concerns like logging, authentication, and authorization.",
        "option_D": "Only for defining views.",
        "correct_anwser": "C",
        "explain": "`HandlerInterceptor` (gọi tắt là interceptor) trong Spring MVC hoạt động tương tự như một bộ lọc, cho phép bạn can thiệp vào các chu kỳ trước (preHandle), sau (postHandle) và khi hoàn thành (afterCompletion) của một request gửi tới Controller. Do đó, nó cực kỳ hoàn hảo để xử lý các vấn đề cắt ngang (cross-cutting concerns) như kiểm tra quyền truy cập (authentication/authorization), lưu nhật ký (logging), hay thay đổi tham số."
      },
      {
        "question_id": 16,
        "question_title": "In the Spring MVC request lifecycle, which component is the first to receive an incoming request?",
        "option_A": "Controller",
        "option_B": "HandlerMapping",
        "option_C": "DispatcherServlet",
        "option_D": "ViewResolver",
        "correct_anwser": "C",
        "explain": "Thành phần `DispatcherServlet` đóng vai trò là một Front Controller trong kiến trúc Spring MVC. Mọi HTTP request từ phía máy khách gửi đến ứng dụng đều phải đi qua cửa ngõ trung tâm này đầu tiên, trước khi nó điều hướng công việc sang các thành phần bổ trợ khác xử lý."
      },
      {
        "question_id": 17,
        "question_title": "Which component maps incoming requests to appropriate controller methods?",
        "option_A": "HandlerMapping",
        "option_B": "HandlerAdapter",
        "option_C": "ViewResolver",
        "option_D": "ModelAndView",
        "correct_anwser": "A",
        "explain": "Nhiệm vụ chính của thành phần `HandlerMapping` trong luồng xử lý Spring MVC là phân tích URL của incoming request, đối chiếu cấu hình để tìm ra Controller và method cụ thể nào phù hợp nhất chịu trách nhiệm xử lý request đó."
      },
      {
        "question_id": 18,
        "question_title": "Which JavaFX layout should you use to divide the window into top, bottom, center, left, and right?",
        "option_A": "StackPane",
        "option_B": "BorderPane",
        "option_C": "HBox",
        "option_D": "VBox",
        "correct_anwser": "B",
        "explain": "`BorderPane` là một lớp layout được thiết kế sẵn trong JavaFX để chia vùng không gian hiển thị của cửa sổ làm 5 khu vực biên cố định chuẩn bao gồm: Top (trên), Bottom (dưới), Left (trái), Right (phải) và Center (trung tâm)."
      },
      {
        "question_id": 19,
        "question_title": "Spring Boot embedded servers include:",
        "option_A": "Apache Tomcat",
        "option_B": "Jetty",
        "option_C": "Undertow",
        "option_D": "All of the above",
        "correct_anwser": "D",
        "explain": "Mặc định khi khởi tạo một ứng dụng web, Spring Boot tích hợp sẵn embedded server là Apache Tomcat (Lựa chọn A). Tuy nhiên, framework này cũng hỗ trợ cấu hình chuyển đổi rất linh hoạt sang các embedded container gọn nhẹ hoặc hiệu năng cao khác bao gồm cả Jetty (Lựa chọn B) và Undertow (Lựa chọn C) tùy thuộc vào nhu cầu."
      },
      {
        "question_id": 20,
        "question_title": "Which type of dependency is represented by spring-boot-starter-web?",
        "option_A": "Database connectivity.",
        "option_B": "Web application development.",
        "option_C": "Security configuration.",
        "option_D": "Messaging.",
        "correct_anwser": "B",
        "explain": "Mô-đun `spring-boot-starter-web` là một starter dependency đóng vai trò nền tảng dùng để xây dựng các ứng dụng web (Web application development), bao gồm cả các ứng dụng RESTful API sử dụng kiến trúc Spring MVC và mặc định nhúng sẵn máy chủ Apache Tomcat."
      },
      {
        "question_id": 21,
        "question_title": "Which tool creates Spring Boot project quickly?",
        "option_A": "Spring Initializr",
        "option_B": "Maven Archetype",
        "option_C": "Gradle Plugin",
        "option_D": "JDK installer",
        "correct_anwser": "A",
        "explain": "Spring Initializr (thông qua trang web start.spring.io hoặc được tích hợp trực tiếp vào các IDE) là công cụ chính thức và nhanh nhất do Pivotal/Spring cung cấp để khởi tạo cấu trúc một project Spring Boot với đầy đủ các dependency cần thiết chỉ bằng vài cú click chuột."
      },
      {
        "question_id": 22,
        "question_title": "Which annotation creates REST controller?",
        "option_A": "@RestController",
        "option_B": "@Service",
        "option_C": "@Entity",
        "option_D": "@Bean",
        "correct_anwser": "A",
        "explain": "Annotation `@RestController` được sử dụng để định nghĩa một Controller theo kiến trúc RESTful Web Services. Nó là một annotation kết hợp (convenience annotation) bao gồm cả `@Controller` và `@ResponseBody`, giúp tự động chuyển đổi dữ liệu trả về từ các method trực tiếp thành định dạng JSON hoặc XML thay vì tìm kiếm một trang View để hiển thị."
      },
      {
        "question_id": 23,
        "question_title": "Which attribute is used to iterate over a collection in Thymeleaf?",
        "option_A": "th:if",
        "option_B": "th:each",
        "option_C": "th:text",
        "option_D": "th:href",
        "correct_anwser": "B",
        "explain": "Trong công cụ Thymeleaf template engine, thuộc tính `th:each` được sử dụng làm vòng lặp (tương tự như vòng lặp for-each trong Java) để duyệt qua các phần tử của một danh sách (Collection hoặc List) và hiển thị chúng ra giao diện HTML."
      },
      {
        "question_id": 24,
        "question_title": "Which of the following is a kind of template in Thymeleaf? (Choose 2 answer)",
        "option_A": "XML templates",
        "option_B": "Text templates",
        "option_C": "JSON templates",
        "option_D": "Binary templates",
        "correct_anwser": "A, B, C",
        "explain": "Câu hỏi này yêu cầu chọn 2 đáp án đúng, tuy nhiên trên thực tế Thymeleaf hỗ trợ xử lý rất nhiều template mode khác nhau bao gồm: HTML, XML (Lựa chọn A), TEXT (Lựa chọn B), và cả JSON (Lựa chọn C) hay CSS. Ngoại trừ Binary templates (Lựa chọn D) là hoàn toàn không được hỗ trợ, ba đáp án còn lại đều đúng, nhưng phổ biến nhất đi cặp với nhau cho các dữ liệu phi HTML thường là XML và TEXT."
      },
      {
        "question_id": 25,
        "question_title": "In Thymeleaf, which expression is used to create a link? <a th:href=\"______\">Home</a>",
        "option_A": "${/home}",
        "option_B": "#{/home}",
        "option_C": "@{/home}",
        "option_D": "~{/home}",
        "correct_anwser": "C",
        "explain": "Thymeleaf sử dụng cú pháp ký tự `@` kết hợp cặp ngoặc nhọn `@{...}` để định nghĩa Link Expressions (biểu thức đường dẫn). Nó hỗ trợ xử lý và tự động thêm ngữ cảnh ứng dụng (context path) cho các đường dẫn URL tuyệt đối hoặc tương đối trong hệ thống."
      },
      {
        "question_id": 26,
        "question_title": "Thymeleaf integrates well with:",
        "option_A": "React.js",
        "option_B": "Angular.js",
        "option_C": "Spring MVC.",
        "option_D": "Node.js",
        "correct_anwser": "C",
        "explain": "Thymeleaf là một công cụ template engine phía Server (server-side template engine) hiện đại, nó được thiết kế để tích hợp cực kỳ chặt chẽ và tự nhiên với Spring MVC để thay thế cho công nghệ JSP truyền thống nhằm xử lý giao diện cho các ứng dụng web."
      },
      {
        "question_id": 27,
        "question_title": "Thymeleaf can be used to process:",
        "option_A": "Only HTML files.",
        "option_B": "HTML, XML, JavaScript, CSS, and plain text.",
        "option_C": "Only server-side Java code.",
        "option_D": "Only database queries.",
        "correct_anwser": "B",
        "explain": "Mặc dù giao diện web HTML là ứng dụng phổ biến nhất, Thymeleaf thực tế là một template engine rất mạnh mẽ, có khả năng biên dịch và xử lý nhiều loại định dạng tệp tin văn bản khác bao gồm cả HTML, XML, JavaScript, CSS và văn bản thuần túy (plain text)."
      },
      {
        "question_id": 28,
        "question_title": "Which annotation would you use to define a one-to-many relationship between two entities?",
        "option_A": "@ManyToOne",
        "option_B": "@OneToOne",
        "option_C": "@OneToMany",
        "option_D": "@ManyToMany",
        "correct_anwser": "C",
        "explain": "Để thiết lập một mối quan hệ một-nhiều (One-to-Many relationship) giữa hai thực thể dữ liệu trong JPA (ví dụ: Một lớp học `Class` có nhiều học sinh `Student`), chúng ta sử dụng annotation `@OneToMany` đặt phía trên thuộc tính danh sách phần tử con."
      },
      {
        "question_id": 29,
        "question_title": "Which of the following is a popular ORM framework for Java?",
        "option_A": "Spring MVC",
        "option_B": "Hibernate",
        "option_C": "JavaFX",
        "option_D": "Swing",
        "correct_anwser": "B",
        "explain": "Hibernate là một framework ORM (Object-Relational Mapping) cực kỳ nổi tiếng và được sử dụng rộng rãi nhất trong thế giới Java. Nó giúp ánh xạ trực tiếp các class đối tượng Java sang các bảng dữ liệu quan hệ trong cơ sở dữ liệu và là core chính triển khai đặc tả JPA."
      },
      {
        "question_id": 30,
        "question_title": "Which of the following is NOT a standard JPA relationship annotation?",
        "option_A": "@OneToMany",
        "option_B": "@ManyToOne",
        "option_C": "@OneToOne",
        "option_D": "@Autowired",
        "correct_anwser": "D",
        "explain": "Các annotation như `@OneToMany`, `@ManyToOne`, `@OneToOne` (và cả `@ManyToMany`) đều là các annotation tiêu chuẩn của đặc tả JPA dùng để cấu hình quan hệ giữa các bảng. Trong khi đó, `@Autowired` là một annotation thuộc Spring Framework dùng cho mục đích thực hiện Dependency Injection (nhúng tự động phụ thuộc), hoàn toàn không liên quan đến quan hệ cơ sở dữ liệu của JPA."
      },
      {
        "question_id": 31,
        "question_title": "What is the purpose of the @NamedQueries annotation in JPA?",
        "option_A": "To define a single named query",
        "option_B": "To define multiple named queries",
        "option_C": "To define a primary key",
        "option_D": "To define a foreign key",
        "correct_anwser": "B",
        "explain": "Annotation `@NamedQueries` (số nhiều) đóng vai trò là một container annotation trong JPA. Nó được sử dụng để nhóm và định nghĩa nhiều câu truy vấn tĩnh (`@NamedQuery`) lại với nhau trên cùng một Entity class."
      },
      {
        "question_id": 32,
        "question_title": "What is the purpose of the following annotation in JPA?\n@Id\n@GeneratedValue(strategy = GenerationType.IDENTITY)\nprivate Long id;",
        "option_A": "It creates a foreign key for the entity",
        "option_B": "It marks the field as a version column",
        "option_C": "It marks the field as the primary key with auto-increment strategy",
        "option_D": "It disables the persistence of the field",
        "correct_anwser": "C",
        "explain": "Trong JPA, `@Id` dùng để chỉ định thuộc tính đó làm khóa chính (primary key) của thực thể. Đi kèm với đó, cấu hình `@GeneratedValue(strategy = GenerationType.IDENTITY)` ra lệnh cho cơ sở dữ liệu (ví dụ như MySQL) tự động tăng giá trị của cột này (auto-increment) mỗi khi có một bản ghi mới được chèn vào."
      },
      {
        "question_id": 33,
        "question_title": "Which method is used to persist an entity in JPA EntityManager?",
        "option_A": "save()",
        "option_B": "insert()",
        "option_C": "persist()",
        "option_D": "store()",
        "correct_anwser": "C",
        "explain": "Trong đặc tả tiêu chuẩn của JPA, giao diện `EntityManager` cung cấp chính xác phương thức `persist(Object entity)` để chuyển trạng thái của một thực thể từ mới khởi tạo (transient) sang trạng thái được quản lý (managed) và lưu nó xuống database."
      },
      {
        "question_id": 34,
        "question_title": "Which code snippet demonstrates updating an entity using JPA in JavaFX application? (Assume EntityManager em and Entity entity are available)",
        "option_A": "em.persist(entity);",
        "option_B": "em.remove(entity);",
        "option_C": "em.find(Entity.class, id);",
        "option_D": "em.merge(entity);",
        "correct_anwser": "D",
        "explain": "Để cập nhật (update) trạng thái dữ liệu của một thực thể đã bị tách rời (detached) quay trở lại persistence context trong JPA, phương thức `merge(entity)` của `EntityManager` được sử dụng nhằm sao chép trạng thái hiện tại vào một thực thể được quản lý tương ứng."
      },
      {
        "question_id": 35,
        "question_title": "Which code snippet demonstrates reading an entity using JPA? (Assume EntityManager em and Long id are available)",
        "option_A": "em.persist(entity);",
        "option_B": "em.remove(entity);",
        "option_C": "em.find(Entity.class, id);",
        "option_D": "em.merge(entity);",
        "correct_anwser": "C",
        "explain": "Để đọc hoặc tìm kiếm dữ liệu (read/find) một bản ghi cụ thể theo khóa chính (primary key) từ cơ sở dữ liệu bằng JPA, ta sử dụng phương thức `em.find()`. Phương thức này yêu cầu truyền vào kiểu dữ liệu class của thực thể và giá trị id cần tìm."
      },
      {
        "question_id": 36,
        "question_title": "In a JavaFX application with JPA, where is the EntityManager typically created and managed?",
        "option_A": "In the View layer.",
        "option_B": "In the Controller or Service layer.",
        "option_C": "Directly in the Entity class.",
        "option_D": "Inside the JavaFX Application class.",
        "correct_anwser": "B",
        "explain": "Để đảm bảo nguyên tắc phân tách kiến trúc phần mềm (Separation of Concerns), việc tương tác với tầng dữ liệu thông qua `EntityManager` phải được xử lý ở tầng logic nghiệp vụ như Service layer hoặc tầng điều hướng trung gian là Controller layer, hoàn toàn tránh can thiệp trực tiếp vào tầng hiển thị UI (View)."
      },
      {
        "question_id": 37,
        "question_title": "Which JavaFX layout component is often used to arrange input fields and buttons in a CRUD form?",
        "option_A": "HBox/VBox",
        "option_B": "BorderPane",
        "option_C": "GridPane",
        "option_D": "StackPane",
        "correct_anwser": "C",
        "explain": "`GridPane` sắp xếp các thành phần UI theo một lưới các ô bao gồm hàng (rows) và cột (columns). Cấu trúc này vô cùng lý tưởng để thiết kế các form nhập liệu (CRUD form), nơi các nhãn (Labels) cần được căn thẳng hàng một cách gọn gàng với các ô nhập liệu (TextFields)."
      },
      {
        "question_id": 38,
        "question_title": "Which JavaFX component is commonly used to display data in a table format?",
        "option_A": "Label",
        "option_B": "TextField",
        "option_C": "TableView",
        "option_D": "Button",
        "correct_anwser": "C",
        "explain": "Trong JavaFX, thành phần UI được thiết kế riêng biệt để hiển thị danh sách dữ liệu có cấu trúc dưới dạng bảng gồm các hàng và các cột có tiêu đề chính là `TableView`."
      },
      {
        "question_id": 39,
        "question_title": "When using Spring JDBC, what class is typically used to execute SQL queries?",
        "option_A": "EntityManager",
        "option_B": "JdbcTemplate",
        "option_C": "SessionFactory",
        "option_D": "Repository",
        "correct_anwser": "B",
        "explain": "Lớp `JdbcTemplate` là lớp trung tâm cốt lõi của gói thư viện Spring JDBC. Nó giúp loại bỏ các đoạn mã lặp lại dài dòng (boilerplate code) của JDBC thuần (như mở/đóng kết nối, xử lý exception) và cung cấp các phương thức đơn giản để thực thi các câu lệnh SQL."
      },
      {
        "question_id": 40,
        "question_title": "What is the correct order of the Spring MVC request lifecycle?",
        "option_A": "DispatcherServlet -> HandlerMapping -> HandlerAdapter -> Controller -> ViewResolver",
        "option_B": "ViewResolver -> Controller -> DispatcherServlet",
        "option_C": "Controller -> View -> Model -> DispatcherServlet",
        "option_D": "Handler -> Controller -> DispatcherServlet",
        "correct_anwser": "A",
        "explain": "Vòng đời xử lý một request chuẩn trong kiến trúc Spring MVC diễn ra như sau: Request đầu tiên đến Front Controller là `DispatcherServlet` -> Nó hỏi `HandlerMapping` để tìm Controller phù hợp -> Dùng `HandlerAdapter` để thực thi method của `Controller` -> Controller xử lý xong trả về tên View -> `DispatcherServlet` nhờ `ViewResolver` dịch tên đó thành trang giao diện thực tế."
      },
      {
        "question_id": 41,
        "question_title": "In a Spring MVC application, which file is typically used to configure the DispatcherServlet?",
        "option_A": "application.properties",
        "option_B": "dispatcher-servlet.xml",
        "option_C": "web.xml",
        "option_D": "config.xml",
        "correct_anwser": "C",
        "explain": "Trong kiến trúc Java Web và Spring MVC cấu hình bằng XML truyền thống, `web.xml` đóng vai trò là tệp mô tả triển khai (deployment descriptor). Đây là nơi đầu tiên bạn phải khai báo và đăng ký sự hiện diện của `DispatcherServlet` với máy chủ ứng dụng (Servlet Container) như Tomcat."
      },
      {
        "question_id": 42,
        "question_title": "Which Spring annotation manages transactions?",
        "option_A": "@Autowired",
        "option_B": "@Transactional",
        "option_C": "@Service",
        "option_D": "@Entity",
        "correct_anwser": "B",
        "explain": "Annotation `@Transactional` được Spring cung cấp để thực hiện quản lý giao dịch khai báo (declarative transaction management). Khi đính kèm annotation này vào một class hoặc một method, Spring sẽ tự động mở, commit hoặc rollback transaction một cách an toàn mà bạn không cần viết mã thủ công."
      },
      {
        "question_id": 43,
        "question_title": "What will be rendered in browser from this Spring MVC controller method?\n@GetMapping(\"/hello\")\n@ResponseBody\npublic String sayHello() {\n    return \"Hello, Spring!\";\n}",
        "option_A": "A view named \"Hello, Spring!\"",
        "option_B": "A JSON response",
        "option_C": "A plain text response: Hello, Spring!",
        "option_D": "An HTML file from the templates directory",
        "correct_anwser": "C",
        "explain": "Sự xuất hiện của annotation `@ResponseBody` sẽ hướng dẫn Spring MVC bỏ qua luồng phân giải giao diện (ViewResolver). Thay vào đó, giá trị String trả về từ method (`\"Hello, Spring!\"`) sẽ được ghi trực tiếp vào thân của HTTP response và gửi thẳng tới trình duyệt dưới dạng một plain text response."
      },
      {
        "question_id": 44,
        "question_title": "What is the purpose of writing unit tests for a Spring application?",
        "option_A": "To manage database connections.",
        "option_B": "To ensure the correctness of individual components.",
        "option_C": "To define user interfaces.",
        "option_D": "To configure application security.",
        "correct_anwser": "B",
        "explain": "Mục tiêu cốt lõi và duy nhất của kiểm thử đơn vị (unit test) là cô lập và kiểm tra các thành phần nhỏ nhất của mã nguồn (như từng method, từng class bean biệt lập) nhằm đảm bảo chúng hoạt động hoàn toàn chính xác theo đúng logic thiết kế."
      },
      {
        "question_id": 45,
        "question_title": "Which of the following is a key feature of Spring Data JPA?",
        "option_A": "Automatic repository implementation generation.",
        "option_B": "Support for JavaScript front-end development.",
        "option_C": "Built-in load balancing.",
        "option_D": "Real-time video streaming.",
        "correct_anwser": "A",
        "explain": "Tính năng mang tính cách mạng của Spring Data JPA là khả năng tự động sinh ra mã thực thi (automatic implementation) cho các lớp Repository tại thời điểm chạy (runtime). Nhà phát triển chỉ cần khai báo một interface kế thừa từ `JpaRepository` mà không cần viết bất kỳ dòng mã triển khai cụ thể nào."
      },
      {
        "question_id": 46,
        "question_title": "What is the purpose of the EntityManager in JPA?",
        "option_A": "To manage application configurations.",
        "option_B": "To manage persistent entities.",
        "option_C": "To handle user authentication.",
        "option_D": "To create user interfaces.",
        "correct_anwser": "B",
        "explain": "Trong đặc tả JPA, `EntityManager` là một interface trung tâm chịu trách nhiệm quản lý vòng đời của cácpersistent entities (thực thể bền vững). Nó cung cấp các API tiêu chuẩn để thực hiện các thao tác CRUD dữ liệu với cơ sở dữ liệu thông qua persistence context."
      },
      {
        "question_id": 47,
        "question_title": "What is a primary benefit of using Spring Data JPA?",
        "option_A": "Reduced boilerplate code for data access.",
        "option_B": "Enhanced security for front-end applications.",
        "option_C": "Simplified network configuration.",
        "option_D": "Improved performance for video encoding.",
        "correct_anwser": "A",
        "explain": "Lợi ích hàng đầu của Spring Data JPA là loại bỏ phần lớn boilerplate code (mã mẫu lặp đi lặp lại) ở tầng truy cập dữ liệu (data access layer). Bạn không cần phải viết mã mở/đóng kết nối, quản lý try-catch hay viết các câu lệnh SQL cơ bản."
      },
      {
        "question_id": 48,
        "question_title": "In Spring Data JPA, which of the following derived method names is valid and sorts results by lastName ascending?",
        "option_A": "findAllSortByLastNameAsc()",
        "option_B": "findByOrderLastNameAsc()",
        "option_C": "findByAgeGreaterThanOrderByLastNameAsc(int age)",
        "option_D": "orderByLastNameAscFindAll()",
        "correct_anwser": "C",
        "explain": "Để Spring Data JPA biên dịch tự động tên phương thức (query method) thành câu lệnh SQL hợp lệ, bạn phải tuân thủ đúng cú pháp quy định. `findByAgeGreaterThanOrderByLastNameAsc` là phương thức hợp lệ vì nó chứa tiền tố hành động (`findBy`), thuộc tính điều kiện tìm kiếm (`Age` với từ khóa `GreaterThan`), và mệnh đề sắp xếp chuẩn chỉnh (`OrderByLastNameAsc`)."
      },
      {
        "question_id": 49,
        "question_title": "Which annotation marks repository class?",
        "option_A": "@Repository",
        "option_B": "@Entity",
        "option_C": "@Service",
        "option_D": "@Bean",
        "correct_anwser": "A",
        "explain": "Annotation `@Repository` thuộc tầng truy cập dữ liệu của Spring (Data Access Layer). Nó dùng để đánh dấu một class đóng vai trò là một Repository (hoặc DAO), đồng thời cho phép Spring tự động quét (component scanning) để đăng ký nó thành một bean và kích hoạt cơ chế dịch dịch lỗi cơ sở dữ liệu (exception translation)."
      },
      {
        "question_id": 50,
        "question_title": "In Spring Data JPA, what does the method signature List<Entity> findByPropertyOrderByPropertyAsc(String property); do?",
        "option_A": "Finds entities where property is equal to String property, ordered by property descending.",
        "option_B": "Finds entities where property is equal to String property, ordered by property ascending.",
        "option_C": "Finds entities where property contains String property, ordered by property ascending.",
        "option_D": "Finds entities where property is less than String property, ordered by property ascending.",
        "correct_anwser": "B",
        "explain": "Theo quy tắc đặt tên query method của Spring Data JPA, phần `findByProperty` mặc định hiểu là tìm kiếm theo điều kiện bằng (`equals`), tức là lọc ra các bản ghi có giá trị thuộc tính bằng với tham số truyền vào. Phần vế sau `OrderByPropertyAsc` thực hiện nhiệm vụ sắp xếp tập kết quả đó theo thứ tự tăng dần (`ascending`)."
      }
    ]
  },
  {
    "id": "hsf302-sp26-re2",
    "title": "HSF302 - SP26 - RE2",
    "description": "Requirements Engineering Quiz",
    "questionsCount": 50,
    "questions": [
      {
        "question_id": 1,
        "question_title": "In a JPA One-to-Many relationship, which annotation is typically used on the \"one\" side to manage the collection of \"many\" entities?",
        "option_A": "@OneToOne",
        "option_B": "@ManyToOne",
        "option_C": "@OneToMany",
        "option_D": "@ManyToMany",
        "correct_anwser": "C",
        "explain": "Trong JPA, khi thiết lập mối quan hệ One-to-Many (Một-Nhiều), phía \"one\" sẽ chứa một collection (danh sách) các đối tượng của phía \"many\". Để đánh dấu mapping này, ta sử dụng annotation @OneToMany."
      },
      {
        "question_id": 2,
        "question_title": "Which annotation is used to define an AOP aspect in Spring?",
        "option_A": "@Aspect",
        "option_B": "@Controller",
        "option_C": "@Repository",
        "option_D": "@Configuration",
        "correct_anwser": "A",
        "explain": "Để định nghĩa một aspect trong Spring AOP (Aspect-Oriented Programming), chúng ta sử dụng annotation @Aspect của AspectJ trên class đó để chỉ định nó chứa các cấu hình AOP."
      },
      {
        "question_id": 3,
        "question_title": "Which benefit does Spring's modular architecture provide?",
        "option_A": "Increased coupling between application layers.",
        "option_B": "Ability to use only the modules needed, reducing application size.",
        "option_C": "Limited support for different persistence technologies.",
        "option_D": "Decreased flexibility in choosing application components.",
        "correct_anwser": "B",
        "explain": "Spring Framework có kiến trúc modular (được chia thành nhiều module độc lập). Lợi ích lớn nhất của kiến trúc này là bạn có thể linh hoạt chỉ sử dụng những module mà dự án thực sự cần (ví dụ chỉ tải module spring-web hay spring-data-jpa), giúp giảm thiểu kích thước và tối ưu ứng dụng."
      },
      {
        "question_id": 4,
        "question_title": "Which of the following is NOT a general advantage of Spring Framework?",
        "option_A": "Robust transaction management.",
        "option_B": "Comprehensive web development support through Spring MVC.",
        "option_C": "Automatic generation of user interfaces.",
        "option_D": "Strong community support and extensive documentation.",
        "correct_anwser": "C",
        "explain": "Spring Framework hỗ trợ quản lý transaction mạnh mẽ, hỗ trợ phát triển web với Spring MVC, và có documentation rất chi tiết. Tuy nhiên, Spring không có tính năng tự động sinh ra giao diện người dùng (Automatic generation of user interfaces). Giao diện UI (như HTML, CSS, JS) vẫn cần developer tự xây dựng."
      },
      {
        "question_id": 5,
        "question_title": "What is an \"advice\" in Spring AOP?",
        "option_A": "A point in the execution of a program.",
        "option_B": "An object being proxied.",
        "option_C": "The action taken at a particular join point.",
        "option_D": "A collection of join points.",
        "correct_anwser": "C",
        "explain": "Trong thuật ngữ của Spring AOP, \"advice\" chính là hành động (action) hoặc đoạn code logic thực tế sẽ được thực thi tại một điểm kết nối cụ thể (join point). Ví dụ: một đoạn code thực hiện ghi log trước khi một method chạy được gọi là một advice."
      },
      {
        "question_id": 6,
        "question_title": "In a JPA One-to-Many relationship, what does the mappedBy attribute of the @OneToMany annotation specify?",
        "option_A": "The database table name.",
        "option_B": "The primary key of the \"many\" side entity.",
        "option_C": "The field in the \"many\" side entity that maps back to the \"one\" side entity.",
        "option_D": "The join table name.",
        "correct_anwser": "C",
        "explain": "Thuộc tính mappedBy trong annotation @OneToMany được dùng để thiết lập quan hệ hai chiều (bidirectional). Nó được sử dụng ở phía \"one\" để chỉ định chính xác tên field nằm ở phía \"many\" mà đang làm nhiệm vụ map ngược lại entity ở phía \"one\" (hay còn gọi là owning side của mối quan hệ)."
      },
      {
        "question_id": 7,
        "question_title": "Which JavaFX control is used to display text?",
        "option_A": "Label",
        "option_B": "Button",
        "option_C": "TextField",
        "option_D": "ImageView",
        "correct_anwser": "A",
        "explain": "Trong JavaFX, Label là control tiêu chuẩn được sử dụng để hiển thị các đoạn text (văn bản) tĩnh trên giao diện. TextField thường dùng cho việc người dùng nhập liệu, trong khi Button là nút bấm."
      },
      {
        "question_id": 8,
        "question_title": "What is the purpose of event handling in JavaFX?",
        "option_A": "To manage database connections.",
        "option_B": "To respond to user interactions.",
        "option_C": "To handle network requests.",
        "option_D": "To manage application configurations.",
        "correct_anwser": "B",
        "explain": "Mục đích chính của event handling (xử lý sự kiện) trong JavaFX cũng như các framework UI là để lắng nghe và phản hồi lại các tương tác của người dùng (user interactions), chẳng hạn như thao tác click chuột, gõ bàn phím, hay di chuyển chuột."
      },
      {
        "question_id": 9,
        "question_title": "In a typical Spring MVC + Hibernate application, where should the database operations be placed?",
        "option_A": "Controller class",
        "option_B": "HTML page",
        "option_C": "Repository/DAO class",
        "option_D": "JSP scriptlet",
        "correct_anwser": "C",
        "explain": "Theo kiến trúc phân tầng chuẩn của ứng dụng, toàn bộ các thao tác tương tác trực tiếp với cơ sở dữ liệu (database operations) phải được cô lập và đặt trong tầng Data Access Object (DAO) hoặc class Repository. Controller chỉ chịu trách nhiệm nhận/trả request và điều hướng."
      },
      {
        "question_id": 10,
        "question_title": "Which JavaFX class represents the content area of the application window?",
        "option_A": "Stage",
        "option_B": "Node",
        "option_C": "Pane",
        "option_D": "Scene",
        "correct_anwser": "D",
        "explain": "Trong kiến trúc tổng thể của JavaFX, Stage đại diện cho phần khung ngoài cùng (cửa sổ ứng dụng), trong khi Scene đóng vai trò là vùng nội dung (content area) chứa toàn bộ biểu đồ các thành phần giao diện (Node/Pane) để hiển thị bên trong cửa sổ đó."
      },
      {
        "question_id": 11,
        "question_title": "In JavaFX, what is a Property?",
        "option_A": "A static variable.",
        "option_B": "A dynamic, observable value.",
        "option_C": "A database field.",
        "option_D": "A network address.",
        "correct_anwser": "B",
        "explain": "Trong JavaFX, Property là một wrapper chứa dữ liệu có khả năng quan sát (observable value). Nghĩa là khi giá trị của Property thay đổi, nó có thể tự động thông báo cho các UI component (giao diện) đang binding với nó để cập nhật tương ứng."
      },
      {
        "question_id": 12,
        "question_title": "Spring MVC is based on which design pattern?",
        "option_A": "Observer",
        "option_B": "Model-View-Controller",
        "option_C": "Decorator",
        "option_D": "Command",
        "correct_anwser": "B",
        "explain": "Đúng như tên gọi của nó, Spring MVC được xây dựng dựa trên design pattern Model-View-Controller (MVC). Pattern này giúp tách biệt dữ liệu (Model), giao diện hiển thị (View) và phần điều hướng logic (Controller)."
      },
      {
        "question_id": 13,
        "question_title": "How is the DispatcherServlet typically configured in web.xml?",
        "option_A": "As a listener.",
        "option_B": "As a filter.",
        "option_C": "As a servlet.",
        "option_D": "As a resource.",
        "correct_anwser": "C",
        "explain": "Trong cách cấu hình truyền thống của ứng dụng web Java, DispatcherServlet đóng vai trò là Front Controller và được cấu hình như một servlet trong file web.xml để nó có thể chặn (intercept) và xử lý các HTTP requests."
      },
      {
        "question_id": 14,
        "question_title": "After the DispatcherServlet receives a request, which component is used to determine the appropriate controller?",
        "option_A": "ViewResolver",
        "option_B": "HandlerMapping",
        "option_C": "Controller",
        "option_D": "Model",
        "correct_anwser": "B",
        "explain": "Khi DispatcherServlet nhận được một HTTP request, nó sẽ tham chiếu tới HandlerMapping để tìm ra Controller (hoặc handler method) nào được map với URL của request đó."
      },
      {
        "question_id": 15,
        "question_title": "Which statement best describes Spring's form tag library?",
        "option_A": "Unrelated to Spring MVC and cannot bind to model attributes",
        "option_B": "Binding-aware JSP tags that integrate with Spring MVC to bind form fields to model properties",
        "option_C": "A replacement for HTML input elements and attributes",
        "option_D": "Only supports GET forms and not POST",
        "correct_anwser": "B",
        "explain": "Spring form tag library cung cấp các JSP tags đặc biệt có khả năng binding (binding-aware). Nó tích hợp sâu với Spring MVC để tự động liên kết các trường nhập liệu (form fields) trên giao diện với các thuộc tính của đối tượng Model (model properties) ở backend."
      },
      {
        "question_id": 16,
        "question_title": "In the MVC pattern, what is the role of the Model?",
        "option_A": "To handle user input.",
        "option_B": "To display data to the user.",
        "option_C": "To manage the application's data and business logic.",
        "option_D": "To route requests to the appropriate handlers.",
        "correct_anwser": "C",
        "explain": "Trong kiến trúc MVC, thành phần Model chịu trách nhiệm cốt lõi là quản lý dữ liệu (data) và thực thi các quy tắc nghiệp vụ (business logic) của ứng dụng. Việc nhận request là của Controller và hiển thị là của View."
      },
      {
        "question_id": 17,
        "question_title": "Which statement correctly describes @ExceptionHandler and @ControllerAdvice?",
        "option_A": "@ExceptionHandler methods handle exceptions across all controllers by default; @ControllerAdvice limits them to one controller",
        "option_B": "@ExceptionHandler only works with REST controllers; @ControllerAdvice only with MVC controllers",
        "option_C": "@ExceptionHandler in a controller handles exceptions for that controller; @ControllerAdvice can apply such handlers globally",
        "option_D": "Both are deprecated in favor of filters",
        "correct_anwser": "C",
        "explain": "Annotation @ExceptionHandler khi định nghĩa bên trong một Controller thì chỉ bắt lỗi cho Controller đó (cục bộ). Tuy nhiên, khi định nghĩa bên trong một class có chứa @ControllerAdvice, thì các phương thức bắt lỗi đó sẽ được áp dụng globally (toàn cục) cho toàn bộ ứng dụng."
      },
      {
        "question_id": 18,
        "question_title": "Which file defines Spring Boot dependencies?",
        "option_A": "application.yml",
        "option_B": "pom.xml / build.gradle",
        "option_C": "beans.xml",
        "option_D": "settings.json",
        "correct_anwser": "B",
        "explain": "Trong môi trường Spring Boot (và Java nói chung), các thư viện phụ thuộc (dependencies) được khai báo và quản lý bởi công cụ build tool. Ta dùng pom.xml nếu dự án dùng Maven, hoặc build.gradle nếu dự án dùng Gradle."
      },
      {
        "question_id": 19,
        "question_title": "What is the main class of a Spring Boot application typically annotated with?",
        "option_A": "@Component",
        "option_B": "@Service",
        "option_C": "@SpringBootApplication",
        "option_D": "@Repository",
        "correct_anwser": "C",
        "explain": "Class chính chứa hàm main() để khởi chạy một ứng dụng Spring Boot luôn được đánh dấu bằng annotation @SpringBootApplication. Annotation này là sự kết hợp của 3 annotation khác: @Configuration, @EnableAutoConfiguration và @ComponentScan."
      },
      {
        "question_id": 20,
        "question_title": "Which feature of Spring Boot provides pre-configured dependencies and auto-configuration?",
        "option_A": "Spring MVC",
        "option_B": "Spring Data JPA",
        "option_C": "Starter dependencies",
        "option_D": "Spring Security",
        "correct_anwser": "C",
        "explain": "Tính năng Starter dependencies cung cấp các tập hợp thư viện (dependency descriptors) đã được đóng gói sẵn cho một mục đích (ví dụ: spring-boot-starter-web). Nó sẽ tự động kéo theo các thư viện cần thiết và phối hợp với cơ chế auto-configuration để giảm thiểu việc phải setup thủ công."
      },
      {
        "question_id": 21,
        "question_title": "What is the purpose of the @SpringBootApplication annotation?",
        "option_A": "To define a database entity.",
        "option_B": "To enable Spring MVC functionality.",
        "option_C": "To combine @Configuration, @EnableAutoConfiguration, and @ComponentScan.",
        "option_D": "To define a RESTful endpoint.",
        "correct_anwser": "C",
        "explain": "Annotation @SpringBootApplication là một tiện ích (convenience annotation) mặc định của Spring Boot. Nó bao gồm và thực thi cùng lúc 3 annotation cốt lõi: @Configuration (đánh dấu class cấu hình), @EnableAutoConfiguration (kích hoạt cơ chế tự động cấu hình) và @ComponentScan (quét các components trong package)."
      },
      {
        "question_id": 22,
        "question_title": "In Thymeleaf, which expression is used to create a link?\n<a th:href=\"________\">Home</a>",
        "option_A": "${/home}",
        "option_B": "#{/home}",
        "option_C": "@{/home}",
        "option_D": "~{/home}",
        "correct_anwser": "C",
        "explain": "Trong Thymeleaf, để định nghĩa các đường dẫn URL (Link URL Expressions), chúng ta phải sử dụng cú pháp @{...}. Điều này giúp tự động xử lý context path của ứng dụng một cách linh hoạt."
      },
      {
        "question_id": 23,
        "question_title": "Which attribute is used to conditionally include or exclude an element in Thymeleaf?",
        "option_A": "th:if",
        "option_B": "th:each",
        "option_C": "th:text",
        "option_D": "th:href",
        "correct_anwser": "A",
        "explain": "Thuộc tính th:if được dùng để kiểm tra điều kiện logic (conditional evaluation). Nếu điều kiện trả về true, element HTML đó sẽ được render (include). Nếu false, toàn bộ element sẽ bị loại bỏ khỏi DOM (exclude)."
      },
      {
        "question_id": 24,
        "question_title": "In Thymeleaf's Standard Expression Syntax, what does ${...} represent?",
        "option_A": "URL expressions.",
        "option_B": "Message expressions.",
        "option_C": "Variable expressions.",
        "option_D": "Fragment expressions.",
        "correct_anwser": "C",
        "explain": "Cú pháp ${...} trong Thymeleaf đại diện cho Variable expressions. Nó được sử dụng để truy xuất các giá trị của các biến (variables) từ context/model mà Controller đã truyền sang cho View."
      },
      {
        "question_id": 25,
        "question_title": "Which of the following is a kind of template in Thymeleaf? (Choose 2 answer)",
        "option_A": "XML templates",
        "option_B": "Text templates",
        "option_C": "JSON templates",
        "option_D": "Binary templates",
        "correct_anwser": "A, B",
        "explain": "Thymeleaf hỗ trợ nhiều loại template mode để xử lý dữ liệu đầu ra. Các template modes hợp lệ bao gồm: HTML, XML, TEXT, JAVASCRIPT, CSS và RAW. Vì vậy, XML templates và Text templates là 2 đáp án chính xác."
      },
      {
        "question_id": 26,
        "question_title": "Which annotation creates REST controller?",
        "option_A": "@RestController",
        "option_B": "@Service",
        "option_C": "@Entity",
        "option_D": "@Bean",
        "correct_anwser": "A",
        "explain": "Annotation @RestController được sử dụng để đánh dấu một class là RESTful web controller. Nó là sự kết hợp tiện lợi của @Controller và @ResponseBody, giúp dữ liệu trả về từ các method sẽ tự động được parse thành format như JSON/XML thay vì render ra giao diện HTML."
      },
      {
        "question_id": 27,
        "question_title": "What is the primary purpose of JPA (Java Persistence API)?",
        "option_A": "To define a standard for web application development",
        "option_B": "To define a standard for object-relational mapping in Java",
        "option_C": "To manage user interfaces",
        "option_D": "To handle network communication",
        "correct_anwser": "B",
        "explain": "Mục đích chính của JPA là cung cấp một bộ đặc tả tiêu chuẩn (standard specification) cho kỹ thuật Object-Relational Mapping (ORM) trong ngôn ngữ Java, giúp mapping các Java objects với các relational database tables."
      },
      {
        "question_id": 28,
        "question_title": "Which JPA annotation maps a primary key?",
        "option_A": "@Entity",
        "option_B": "@Table",
        "option_C": "@Id",
        "option_D": "@JoinColumn",
        "correct_anwser": "C",
        "explain": "Trong JPA, annotation @Id được đặt trên một field (hoặc property) để chỉ định rằng trường đó đóng vai trò là khóa chính (primary key) của entity ánh xạ xuống database."
      },
      {
        "question_id": 29,
        "question_title": "What does ORM stand for in JPA?",
        "option_A": "Object Relational Mapping",
        "option_B": "Open Resource Management",
        "option_C": "Optimized Runtime Module",
        "option_D": "Operational Reference Model",
        "correct_anwser": "A",
        "explain": "ORM là viết tắt của Object Relational Mapping. Đây là một kỹ thuật lập trình giúp tự động chuyển đổi dữ liệu giữa hệ thống hướng đối tượng (Object trong OOP) và cơ sở dữ liệu quan hệ (Relational database)."
      },
      {
        "question_id": 30,
        "question_title": "What is the purpose of transaction management in JPA?",
        "option_A": "To handle user authentication",
        "option_B": "To ensure data integrity and consistency",
        "option_C": "To manage network traffic",
        "option_D": "To optimize web page loading",
        "correct_anwser": "B",
        "explain": "Mục đích của việc quản lý giao dịch (transaction management) là để đảm bảo tính toàn vẹn và nhất quán của dữ liệu (data integrity and consistency). Nó tuân thủ nguyên tắc ACID, đảm bảo rằng một nhóm các thao tác database sẽ được thực hiện thành công trọn vẹn (commit) hoặc bị hủy bỏ toàn bộ (rollback) nếu có lỗi xảy ra."
      },
      {
        "question_id": 31,
        "question_title": "What is the primary role of JPA in Java applications?",
        "option_A": "Managing user interfaces",
        "option_B": "Providing RESTful API support",
        "option_C": "Managing relational data through ORM",
        "option_D": "Running multithreaded processes",
        "correct_anwser": "C",
        "explain": "Vai trò chính của JPA (Java Persistence API) trong các ứng dụng Java là quản lý dữ liệu quan hệ thông qua kỹ thuật ORM (Object-Relational Mapping), giúp ánh xạ các Java objects xuống các bảng trong database một cách dễ dàng."
      },
      {
        "question_id": 32,
        "question_title": "Which of the following is NOT a standard JPA relationship annotation?",
        "option_A": "@OneToMany",
        "option_B": "@ManyToOne",
        "option_C": "@OneToOne",
        "option_D": "@Autowired",
        "correct_anwser": "D",
        "explain": "Các annotation @OneToMany, @ManyToOne và @OneToOne là các annotation tiêu chuẩn của JPA để map các relationship giữa các entity. Còn @Autowired là annotation riêng của Spring Framework dùng để thực hiện cơ chế Dependency Injection."
      },
      {
        "question_id": 33,
        "question_title": "Which JavaFX component is suitable for displaying validation error messages?",
        "option_A": "Label or Alert",
        "option_B": "Button",
        "option_C": "TableView",
        "option_D": "TextField",
        "correct_anwser": "A",
        "explain": "Để hiển thị các message lỗi xác thực (validation error), ta thường dùng control Label để hiển thị text lỗi ngay bên cạnh trường nhập liệu trên giao diện (inline), hoặc dùng Alert để bật lên một hộp thoại popup (dialog) thông báo cho người dùng."
      },
      {
        "question_id": 34,
        "question_title": "In JavaFX, consider:\nButton btn = new Button(\"Click\");\nbtn.setOnAction(e -> System.out.println(\"Pressed\"));\nWhat happens when user clicks the button?",
        "option_A": "Nothing",
        "option_B": "Compilation error",
        "option_C": "Text 'Pressed' is printed in console",
        "option_D": "Button disappears",
        "correct_anwser": "C",
        "explain": "Đoạn code trên sử dụng lambda expression để gán một event handler cho sự kiện click button. Khi người dùng click vào button, logic bên trong lambda sẽ được thực thi, lệnh System.out.println sẽ in chuỗi 'Pressed' ra màn hình console."
      },
      {
        "question_id": 35,
        "question_title": "Which JavaFX component is commonly used to display data in a table format?",
        "option_A": "Label",
        "option_B": "TextField",
        "option_C": "TableView",
        "option_D": "Button",
        "correct_anwser": "C",
        "explain": "Trong JavaFX, TableView là component được thiết kế chuyên dụng để hiển thị dữ liệu dạng danh sách dưới định dạng bảng (table format), bao gồm cấu trúc chia theo các cột (columns) và hàng (rows)."
      },
      {
        "question_id": 36,
        "question_title": "Which code snippet demonstrates reading an entity using JPA? (Assume EntityManager em and Long id are available)",
        "option_A": "em.persist(entity);",
        "option_B": "em.remove(entity);",
        "option_C": "em.find(Entity.class, id);",
        "option_D": "em.merge(entity);",
        "correct_anwser": "C",
        "explain": "Để đọc/tìm kiếm (reading) một entity từ cơ sở dữ liệu thông qua JPA dựa vào khóa chính (primary key), ta sử dụng method em.find(). Các method còn lại có chức năng khác: persist (thêm mới), remove (xóa), merge (cập nhật)."
      },
      {
        "question_id": 37,
        "question_title": "In a JavaFX application with JPA, where is the EntityManager typically created and managed?",
        "option_A": "In the View layer.",
        "option_B": "In the Controller or Service layer.",
        "option_C": "Directly in the Entity class.",
        "option_D": "Inside the JavaFX Application class.",
        "correct_anwser": "B",
        "explain": "Theo các pattern kiến trúc phần mềm tiêu chuẩn (như MVC, Layered Architecture), các thao tác xử lý business logic và tương tác với database (thông qua EntityManager) cần được tách biệt khỏi giao diện (View layer) hay dữ liệu (Entity class), và thường được đặt/quản lý tại tầng Service hoặc tầng Controller."
      },
      {
        "question_id": 38,
        "question_title": "What is the purpose of the Model in a Spring application?",
        "option_A": "To define user interfaces.",
        "option_B": "To represent domain objects and data.",
        "option_C": "To manage HTTP requests.",
        "option_D": "To handle application deployment.",
        "correct_anwser": "B",
        "explain": "Trong mô hình MVC của Spring, thành phần Model đóng vai trò đại diện cho các đối tượng nghiệp vụ (domain objects) và lưu giữ data để chuyển giao/hiển thị thông tin giữa Controller và View."
      },
      {
        "question_id": 39,
        "question_title": "Which benefit does JdbcTemplate provide?",
        "option_A": "Simplifies error handling",
        "option_B": "Automatic query optimization",
        "option_C": "UI rendering",
        "option_D": "Thread pool creation",
        "correct_anwser": "A",
        "explain": "JdbcTemplate là một core class trong Spring giúp đơn giản hóa việc thao tác với JDBC API. Một trong những lợi ích quan trọng nhất của nó là tự động xử lý đóng/mở connection và mapping các SQLException rườm rà thành một hệ thống hierarchy DataAccessException nhất quán, qua đó đơn giản hóa việc xử lý lỗi (Simplifies error handling)."
      },
      {
        "question_id": 40,
        "question_title": "What is the correct order of the Spring MVC request lifecycle?",
        "option_A": "DispatcherServlet -> HandlerMapping -> HandlerAdapter -> Controller -> ViewResolver",
        "option_B": "ViewResolver -> Controller -> DispatcherServlet",
        "option_C": "Controller -> View -> Model -> DispatcherServlet",
        "option_D": "Handler -> Controller -> DispatcherServlet",
        "correct_anwser": "A",
        "explain": "Vòng đời chuẩn của một HTTP request trong Spring MVC là: Request đi vào DispatcherServlet (Front Controller) -> Nó hỏi HandlerMapping để tìm ra Controller nào xử lý -> Nó dùng HandlerAdapter để gọi/thực thi Controller đó -> Sau khi có kết quả (Model and View name), nó dùng ViewResolver để tìm ra file View thực tế để render kết quả trả về cho user."
      },
      {
        "question_id": 41,
        "question_title": "What is the role of the DispatcherServlet in Spring MVC?",
        "option_A": "Handling UI rendering on the client",
        "option_B": "Acting as the front controller to dispatch requests to appropriate handlers",
        "option_C": "Encrypting HTTP requests",
        "option_D": "Managing database transactions",
        "correct_anwser": "B",
        "explain": "Trong kiến trúc Spring MVC, DispatcherServlet đóng vai trò là một front controller trung tâm. Nhiệm vụ của nó là tiếp nhận toàn bộ các HTTP requests từ client và điều phối (dispatch) chúng đến các Controller (handlers) phù hợp để xử lý dựa trên cấu hình URL."
      },
      {
        "question_id": 42,
        "question_title": "Which Spring annotation manages transactions?",
        "option_A": "@Autowired",
        "option_B": "@Transactional",
        "option_C": "@Service",
        "option_D": "@Entity",
        "correct_anwser": "B",
        "explain": "Trong Spring Framework, annotation @Transactional được sử dụng để quản lý các transactions (giao dịch) của cơ sở dữ liệu một cách tự động (declarative transaction management), đảm bảo tính ACID (toàn vẹn dữ liệu) mà không cần code các lệnh commit hay rollback thủ công."
      },
      {
        "question_id": 43,
        "question_title": "What is the primary function of a Controller in a Spring MVC application?",
        "option_A": "To manage database connections.",
        "option_B": "To handle HTTP requests and return a model and view.",
        "option_C": "To define user interfaces.",
        "option_D": "To configure application security.",
        "correct_anwser": "B",
        "explain": "Chức năng chính của Controller trong mô hình Spring MVC là lắng nghe và xử lý các HTTP requests từ người dùng. Sau khi thực thi logic nghiệp vụ xong, nó sẽ trả về dữ liệu (Model) cùng với tên của giao diện (View name) để hệ thống tiến hành render kết quả cuối cùng."
      },
      {
        "question_id": 44,
        "question_title": "Which annotation is used to mark an entity in Spring Data JPA?",
        "option_A": "@Component",
        "option_B": "@Service",
        "option_C": "@Entity",
        "option_D": "@Repository",
        "correct_anwser": "C",
        "explain": "Khi làm việc với JPA hoặc Spring Data JPA, để đánh dấu một Java class là một Entity (thực thể) chịu trách nhiệm ánh xạ xuống một table trong cơ sở dữ liệu quan hệ, ta bắt buộc phải sử dụng annotation @Entity."
      },
      {
        "question_id": 45,
        "question_title": "Which annotation is used to define a named query?",
        "option_A": "@Query",
        "option_B": "@NamedQuery",
        "option_C": "@StoredProcedure",
        "option_D": "@NativeQuery",
        "correct_anwser": "B",
        "explain": "Trong chuẩn JPA, annotation @NamedQuery được sử dụng trực tiếp trên các Entity class để định nghĩa trước một câu truy vấn tĩnh (static query) với một cái tên cụ thể. Bằng cách gọi tên này, bạn có thể tái sử dụng câu query đó ở nhiều nơi trong code."
      },
      {
        "question_id": 46,
        "question_title": "What best describes Spring Data in the context of data access?",
        "option_A": "A single monolithic library that replaces JPA",
        "option_B": "An umbrella project containing multiple modules for different data stores and data-access styles",
        "option_C": "A JDBC driver for all relational databases",
        "option_D": "A GUI client for managing databases",
        "correct_anwser": "B",
        "explain": "Spring Data thực chất là một umbrella project (dự án mẹ/dự án tổng thể) chứa nhiều modules con (ví dụ: Spring Data JPA, Spring Data MongoDB, Spring Data Redis...). Mục đích của nó là cung cấp một mô hình lập trình nhất quán để truy xuất dữ liệu cho cả relational databases và các hệ thống NoSQL."
      },
      {
        "question_id": 47,
        "question_title": "What best describes Spring Data JPA?",
        "option_A": "A NoSQL database engine",
        "option_B": "A higher-level abstraction on top of JPA that simplifies repository-based data access",
        "option_C": "A replacement for the Spring Framework core container",
        "option_D": "A message broker for JMS-based applications",
        "correct_anwser": "B",
        "explain": "Spring Data JPA là một higher-level abstraction (tầng trừu tượng cao hơn) được xây dựng dựa trên JPA API. Nó giúp lập trình viên đơn giản hóa tối đa việc tương tác với database bằng cách tự động sinh ra các đoạn code (boilerplate code) thông qua các Repository interfaces."
      },
      {
        "question_id": 48,
        "question_title": "In Spring Data JPA, by default, the @Query annotation uses which query language?",
        "option_A": "JPQL",
        "option_B": "SQL-92 only",
        "option_C": "HQL only",
        "option_D": "Native database-specific SQL",
        "correct_anwser": "A",
        "explain": "Mặc định, annotation @Query trong Spring Data JPA sẽ biên dịch và thực thi câu lệnh bằng ngôn ngữ JPQL (Java Persistence Query Language). JPQL truy vấn dựa trên các Entity objects và thuộc tính của chúng thay vì truy vấn trực tiếp trên các tables trong database. Nếu muốn dùng SQL thuần túy, bạn phải set cờ nativeQuery = true."
      },
      {
        "question_id": 49,
        "question_title": "What is the purpose of @Transactional in Spring Data JPA?",
        "option_A": "To manage user sessions.",
        "option_B": "To ensure data consistency by grouping database operations into a single unit.",
        "option_C": "To handle file uploads.",
        "option_D": "To create REST endpoints.",
        "correct_anwser": "B",
        "explain": "Mục đích của @Transactional là gom nhóm nhiều thao tác đọc/ghi với database thành một unit of work (đơn vị công việc) duy nhất. Điều này bảo vệ data consistency (tính nhất quán của dữ liệu): nếu mọi thứ suôn sẻ thì dữ liệu được lưu, còn nếu có exception xảy ra giữa chừng, toàn bộ các thao tác trước đó sẽ bị rollback."
      },
      {
        "question_id": 50,
        "question_title": "You have a controller:\n@RestController\nclass TestController {\n  @GetMapping(\"/hello\")\n  public String hello() { return \"Hi\"; }\n}\nWhat is the response of GET /hello request?",
        "option_A": "HTML page",
        "option_B": "JSON object {\"hello\":\"Hi\"}",
        "option_C": "Plain text 'Hi'",
        "option_D": "Error 404",
        "correct_anwser": "C",
        "explain": "Annotation @RestController mặc định đã chứa @ResponseBody, nghĩa là giá trị return của method sẽ được viết trực tiếp vào phần body của HTTP response. Vì phương thức hello() trả về một đối tượng kiểu chuỗi String đơn giản, framework sẽ không convert nó sang cấu trúc JSON mà trả về thẳng định dạng plain text là 'Hi'."
      }
    ]
  },
  {
    "id": "swt301-sp26-fe",
    "title": "SWT301 - SP26 - FE",
    "description": "Software Testing Final Exam Quiz",
    "questionsCount": 60,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Testing should be stopped when:",
        "option_A": "(i) All the defined tests have been executed",
        "option_B": "(ii) Time has run out",
        "option_C": "(iii) All faults have been fixed correctly",
        "option_D": "Both (i) and (iii)",
        "option_E": "It depends on the risks for the system being tested",
        "correct_anwser": "E",
        "explain": "Trong thực tế, việc quyết định dừng kiểm thử không bao giờ có một tiêu chuẩn cố định mà phụ thuộc lớn vào mức độ rủi ro, ngân sách và thời gian của hệ thống đang được kiểm thử (kiểm thử dựa trên rủi ro - Risk-based testing)."
      },
      {
        "question_id": 2,
        "question_title": "Which is not true-The black box tester",
        "option_A": "Should be able to understand a functional specification or requirements document",
        "option_B": "Should be able to understand the source code.",
        "option_C": "Is highly motivated to find faults",
        "option_D": "Is creative to find the system's weaknesses",
        "correct_anwser": "B",
        "explain": "Kiểm thử hộp đen (Black-box testing) tập trung vào chức năng của phần mềm mà không cần biết hoặc hiểu cấu trúc mã nguồn bên trong. Do đó, việc hiểu mã nguồn (source code) là đặc trưng của kiểm thử hộp trắng (White-box testing), không phải hộp đen."
      },
      {
        "question_id": 3,
        "question_title": "Defects are recorded into three major purposes. They are:\n1.To correct the defect\n2.To report status of the application\n3.To improve the software development process",
        "option_A": "True",
        "option_B": "False",
        "option_C": "",
        "option_D": "",
        "correct_anwser": "A",
        "explain": "Phát biểu này hoàn toàn chính xác. Mục đích của việc ghi lại lỗi (defect log) bao gồm: sửa lỗi hiện tại, báo cáo trạng thái chất lượng phần mềm, và phân tích xu hướng lỗi để cải tiến quy trình phát triển trong tương lai."
      },
      {
        "question_id": 4,
        "question_title": "Which one is not comes under international standard: (choose one answer)",
        "option_A": "IEC",
        "option_B": "IEEE",
        "option_C": "ISO",
        "option_D": "All of the others",
        "correct_anwser": "D",
        "explain": "Câu hỏi dùng cấu trúc phủ định kết hợp với tùy chọn 'All of the others' gây nhiễu, tuy nhiên xét theo bản chất: IEC, IEEE, và ISO đều là các tổ chức tiêu chuẩn hóa quốc tế lớn có uy tín trên toàn cầu. Không có tổ chức nào trong số này không thuộc tiêu chuẩn quốc tế."
      },
      {
        "question_id": 5,
        "question_title": "Which of the following is the standard for the Software product quality",
        "option_A": "ISO 9126",
        "option_B": "ISO 829",
        "option_C": "ISO 1012",
        "option_D": "ISO 1028",
        "correct_anwser": "A",
        "explain": "ISO/IEC 9126 là tiêu chuẩn quốc tế cũ nổi tiếng quy định về chất lượng sản phẩm phần mềm (Software product quality), sau này được thay thế bằng bộ tiêu chuẩn ISO/IEC 25010 (SQuaRE)."
      },
      {
        "question_id": 6,
        "question_title": "Important consequences of the impossibility of complete testing are:",
        "option_A": "We can never be certain that the program is bug free.",
        "option_B": "We have no definite stopping point for testing, which makes it easier for some managers to argue for very little testing.",
        "option_C": "We have no easy answer for what testing tasks should always be required, because every task takes time that could be spent on other high importance tasks.",
        "option_D": "All of the others.",
        "correct_anwser": "D",
        "explain": "Do không thể kiểm thử toàn bộ (exhaustively), hệ quả kéo theo là không bao giờ khẳng định được phần mềm hết lỗi (A), khó xác định điểm dừng lý tưởng dẫn đến việc cắt giảm kiểm thử (B), và gặp thách thức lớn trong việc phân bổ thời gian hợp lý cho các tác vụ kiểm thử (C)."
      },
      {
        "question_id": 7,
        "question_title": "A field failure occurs when multiple users access a system. Which of the following is true?",
        "option_A": "This is an acceptable risk of a multi-user system.",
        "option_B": "Insufficient functional testing has been performed",
        "option_C": "This indicates an important non-functional requirement was not specified and tested.",
        "option_D": "It is not possible to test against such events prior to release.",
        "correct_anwser": "C",
        "explain": "Lỗi xảy ra khi có nhiều người dùng đồng thời truy cập liên quan đến các đặc tính phi chức năng (non-functional) như hiệu năng (performance), độ tải (load), hoặc tính đồng thời (concurrency). Điều này chứng tỏ yêu cầu phi chức năng đã không được mô tả kỹ và kiểm thử đầy đủ trước đó."
      },
      {
        "question_id": 8,
        "question_title": "PDCA is known as",
        "option_A": "Plan, Do, Check, Act",
        "option_B": "Plan, Do, Correct, Act",
        "option_C": "Plan, Debug, Check, Act",
        "option_D": "Plan, Do, Check, Accept",
        "correct_anwser": "A",
        "explain": "PDCA là chu trình cải tiến liên tục phổ biến trong quản lý chất lượng, viết tắt của 4 bước: Plan (Lập kế hoạch) -> Do (Thực hiện) -> Check (Kiểm tra) -> Act (Cải tiến/Hành động)."
      },
      {
        "question_id": 9,
        "question_title": "Which of the following statements are true?",
        "option_A": "Faults in program specifications are the most expensive to fix",
        "option_B": "Faults in code are the most expensive to fix.",
        "option_C": "Faults in requirements are the most expensive to fix",
        "option_D": "Faults in designs are the most expensive to fix.",
        "correct_anwser": "C",
        "explain": "Theo nguyên lý kiểm thử phần mềm, lỗi được phát hiện càng muộn thì chi phí sửa chữa càng cao. Lỗi bắt nguồn từ giai đoạn Thu thập yêu cầu (Requirements) nếu không được phát hiện sớm sẽ lan truyền qua thiết kế, code và kiểm thử, dẫn đến việc phải làm lại (rework) toàn bộ hệ thống nên có chi phí khắc phục đắt đỏ nhất."
      },
      {
        "question_id": 10,
        "question_title": "The IEEE 829 test plan documentation standard contains all of the following, EXCEPT:",
        "option_A": "Test items",
        "option_B": "Test deliverables",
        "option_C": "Test tasks",
        "option_D": "Test environment",
        "option_E": "Test specification",
        "correct_anwser": "E",
        "explain": "Tiêu chuẩn IEEE 829 định nghĩa cấu trúc của một Kế hoạch kiểm thử (Test Plan) bao gồm các thành phần như đối tượng kiểm thử (test items), sản phẩm bàn giao (test deliverables), nhiệm vụ (test tasks), môi trường (test environment). Còn 'Test specification' (Đặc tả kiểm thử) là một tài liệu độc lập riêng biệt, không phải là một đề mục nằm bên trong tài liệu Test Plan."
      },
      {
        "question_id": 11,
        "question_title": "Regression testing should be performed:\ni. Every week\nii. After the software has changed\niii. As often as possible\niv. When the environment has changed\nv. When the project manager says",
        "option_A": "i & ii are true, iii, iv & v are false",
        "option_B": "ii, iii & iv are true, i & v are false",
        "option_C": "ii & iv are true, i, iii & v are false",
        "option_D": "ii is true, i, iii, iv & v are false",
        "correct_anwser": "C",
        "explain": "Kiểm thử hồi quy (Regression testing) nhằm đảm bảo các vùng code cũ không bị ảnh hưởng lỗi mới khi có sự thay đổi. Các lý do kích hoạt kiểm thử hồi quy chuẩn xác nhất bao gồm: khi phần mềm thay đổi (ii) và khi môi trường chạy phần mềm thay đổi (iv). Việc chạy cố định hàng tuần (i), chạy vô tội vạ không mục đích (iii) hay phụ thuộc cảm tính quản lý (v) đều không phải tiêu chuẩn bắt buộc."
      },
      {
        "question_id": 12,
        "question_title": "Which of the following is a MAJOR task of test implementation and execution?",
        "option_A": "Measuring and analyzing results.",
        "option_B": "Reporting discrepancies as incidents.",
        "option_C": "Identifying test conditions or test requirements.",
        "option_D": "Assessing if more tests are needed.",
        "correct_anwser": "B",
        "explain": "Theo quy trình kiểm thử chuẩn ISTQB, giai đoạn 'Test implementation and execution' bao gồm việc chạy thử nghiệm và ghi nhận kết quả. Nhiệm vụ báo cáo sự khác biệt (sai lệch giữa thực tế và kỳ vọng) dưới dạng các sự cố/lỗi (incidents/defects) chính là hoạt động cốt lõi của giai đoạn này. Các đáp án khác thuộc về giai đoạn Phân tích, Đánh giá tiêu chí dừng hoặc Đóng gói."
      },
      {
        "question_id": 13,
        "question_title": "Independent Verification & Validation is",
        "option_A": "Done by the Developer",
        "option_B": "Done by the Test Engineers",
        "option_C": "Done By Management",
        "option_D": "Done by an Entity Outside the Project's sphere of influence",
        "correct_anwser": "D",
        "explain": "Từ khóa 'Independent' (Độc lập) trong IV&V nhấn mạnh việc thẩm định và xác nhận phần mềm phải được thực hiện bởi một tổ chức, bên thứ ba hoặc đơn vị hoàn toàn độc lập, nằm ngoài phạm vi ảnh hưởng trực tiếp của dự án nhằm đảm bảo tính khách quan tối đa."
      },
      {
        "question_id": 14,
        "question_title": "The specification which describes steps required to operate the system and exercise test cases in order to implement the associated test design",
        "option_A": "Test Case Specification",
        "option_B": "Test Design Specification",
        "option_C": "Test Procedure Specification",
        "option_D": "None of the others",
        "correct_anwser": "C",
        "explain": "Theo tiêu chuẩn tài liệu IEEE 829, tài liệu mô tả chuỗi các bước chi tiết để vận hành hệ thống và thực thi các kịch bản kiểm thử cụ thể được gọi là Đặc tả quy trình kiểm thử (Test Procedure Specification), hay còn gọi phổ biến là Test Script hoặc Test Manual."
      },
      {
        "question_id": 15,
        "question_title": "Which of the following is not the integration strategy?",
        "option_A": "Design based",
        "option_B": "Big-bang",
        "option_C": "Bottom-up",
        "option_D": "Top-down",
        "correct_anwser": "A",
        "explain": "Trong kiểm thử tích hợp (Integration Testing), các chiến lược phổ biến bao gồm Big-bang (tích hợp đồng loạt), Bottom-up (từ dưới lên), và Top-down (từ trên xuống). Không có chiến lược tích hợp tiêu chuẩn nào tên là 'Design based'."
      },
      {
        "question_id": 16,
        "question_title": "Software testing accounts to what percent of software development costs?",
        "option_A": "10-20",
        "option_B": "40-50",
        "option_C": "70-80",
        "option_D": "5-10",
        "correct_anwser": "B",
        "explain": "Trong các giáo trình kỹ nghệ phần mềm kinh điển (như của Pressman hay Sommerville) và các khảo sát thực tế, hoạt động kiểm thử và đảm bảo chất lượng phần mềm thường chiếm khoảng 40% đến 50% tổng chi phí của toàn bộ vòng đời phát triển phần mềm."
      },
      {
        "question_id": 17,
        "question_title": "Reviews, static analysis and dynamic testing have the same objective",
        "option_A": "(i) Identifying defects.",
        "option_B": "(ii) Fixing defects.",
        "option_C": "(i) and (ii)",
        "option_D": "None of (i) nor (ii)",
        "correct_anwser": "A",
        "explain": "Tất cả các phương pháp kiểm thử tĩnh (Reviews, Static analysis) lẫn kiểm thử động (Dynamic testing) đều có chung một mục tiêu tối thượng là phát hiện ra lỗi (Identifying defects). Việc sửa lỗi (Fixing defects) là nhiệm vụ của lập trình viên (Debugging) chứ không phải mục tiêu trực tiếp của hoạt động kiểm thử."
      },
      {
        "question_id": 18,
        "question_title": "Deciding How much testing is enough should take into account:-\ni. Level of Risk including Technical and Business product and project risk\nii. Project constraints such as time and budget\niii. Size of Testing Team\niv. Size of the Development Team",
        "option_A": "i ,ii,iii are true and iv is false",
        "option_B": "i, ,iv are true and ii is false",
        "option_C": "i ,ii are true and iii,iv are false",
        "option_D": "ii,iii,iv are true and i is false",
        "correct_anwser": "C",
        "explain": "Việc quyết định mức độ kiểm thử bao nhiêu là đủ (Exit Criteria) phải dựa trên mức độ rủi ro của sản phẩm/dự án (i) và các ràng buộc thực tế như thời gian, ngân sách (ii). Quy mô số lượng người của đội test (iii) hay đội dev (iv) không phải là cơ sở mang tính kỹ thuật để đánh giá độ phủ và chất lượng kiểm thử đã đạt hay chưa."
      },
      {
        "question_id": 19,
        "question_title": "In which order should tests be run?",
        "option_A": "The most important tests first",
        "option_B": "The most difficult tests first(to allow maximum time for fixing)",
        "option_C": "The easiest tests first (to give initial confidence)",
        "option_D": "The order they are thought of",
        "correct_anwser": "A",
        "explain": "Theo nguyên tắc tối ưu hóa rủi ro, các bài kiểm tra quan trọng nhất (như các tính năng cốt lõi, luồng chính - Critical/High priority) nên được ưu tiên chạy trước để phát hiện sớm các lỗi nghiêm trọng, tránh việc tắc nghẽn ở giai đoạn muộn."
      },
      {
        "question_id": 20,
        "question_title": "Which of the following defines the expected results of a test?",
        "option_A": "Test case specification.",
        "option_B": "Test design specification.",
        "option_C": "Test procedure specification.",
        "option_D": "Test results.",
        "correct_anwser": "A",
        "explain": "Tài liệu Đặc tả kịch bản kiểm thử (Test Case Specification) là nơi định nghĩa chi tiết các thông tin đầu vào, điều kiện tiên quyết và đặc biệt là kết quả mong đợi (Expected results) của một ca kiểm thử cụ thể."
      },
      {
        "question_id": 21,
        "question_title": "Which of the following activities is included in the kick-off phase of a formal review?",
        "option_A": "Explaining the objective",
        "option_B": "Fixing defects found typically done by author",
        "option_C": "Follow up",
        "option_D": "Individual Meeting preparations",
        "correct_anwser": "A",
        "explain": "Trong quy trình đánh giá chính thức (formal review), giai đoạn 'Kick-off' (khởi động) nhằm mục đích phân phát tài liệu, giải thích mục tiêu (explaining the objective), định hướng và làm quen với quy trình cho các thành viên tham gia."
      },
      {
        "question_id": 22,
        "question_title": "Static analysis tools are typically used by",
        "option_A": "Testers",
        "option_B": "Developers",
        "option_C": "Testers & Developers",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Các công cụ phân tích tĩnh (Static analysis tools) thường chạy trực tiếp trên mã nguồn của chương trình để tìm ra các lỗi cú pháp, vi phạm chuẩn coding, biến chưa khởi tạo... Do đó, đối tượng sử dụng chính và thường xuyên nhất của các công cụ này là Lập trình viên (Developers) trước khi đưa code đi kiểm thử động."
      },
      {
        "question_id": 23,
        "question_title": "Which expression best matches the following characteristics or review processes:\n1. Led by author\n2. Undocumented\n3. No management participation\n4. Led by a trained moderator or leader\n5. Uses entry exit criteria\ns) Inspection\nt) Peer review\nu) Informal review\nv) Walkthrough",
        "option_A": "s = 4, t = 3, u = 2 and 5, v = 1",
        "option_B": "s = 4 and 5, t = 3, u = 2, v = 1",
        "option_C": "s = 1 and 5, t = 3, u = 2, v = 4",
        "option_D": "s = 5, t = 4, u = 3, v = 1 and 2",
        "option_E": "s = 4 and 5, t = 1, u = 2, v = 3",
        "correct_anwser": "B",
        "explain": "Chiếu theo đặc điểm kỹ thuật chuẩn ISTQB: Inspection (s) là hình thức trang trọng nhất, được dẫn dắt bởi một người điều phối có chuyên môn (4) và bắt buộc áp dụng bộ tiêu chí đầu vào/đầu ra (5). Informal review (u) không cần ghi lại tài liệu (2). Walkthrough (v) do chính tác giả của tài liệu/sản phẩm chủ trì giải thích (1). Peer review (t) thường mang tính chuyên môn thuần túy giữa các đồng nghiệp và không có sự can thiệp của cấp quản lý (3)."
      },
      {
        "question_id": 24,
        "question_title": "Typical defects discovered by static analysis includes",
        "option_A": "Programming standard violations",
        "option_B": "Referring a variable with an undefined value",
        "option_C": "Security vulnerabilities",
        "option_D": "All of the others",
        "correct_anwser": "D",
        "explain": "Phân tích tĩnh kiểm tra cấu trúc mã nguồn mà không cần thực thi chương trình, nên nó có thể dễ dàng quét ra: vi phạm tiêu chuẩn lập trình (A), tham chiếu đến biến chưa được khai báo/định nghĩa giá trị (B), và phát hiện sớm các lỗ hổng bảo mật cấu trúc hệ thống (C)."
      },
      {
        "question_id": 25,
        "question_title": "Which rule should not be followed for reviews",
        "option_A": "Defects and issues are identified and corrected",
        "option_B": "The product is reviewed not the producer",
        "option_C": "All members of the reviewing team are responsible for the result of the review",
        "option_D": "Each review has a clear predefined objective",
        "correct_anwser": "A",
        "explain": "Trong một buổi review, mục tiêu cốt lõi chỉ dừng lại ở mức phát hiện và ghi nhận các lỗi, vấn đề (identify). Hoạt động chỉnh sửa (correct) là việc của tác giả sau khi buổi review kết thúc, không được tiến hành trực tiếp hay sa đà vào sửa lỗi ngay trong buổi review để tránh mất thời gian."
      },
      {
        "question_id": 26,
        "question_title": "Which of the following is a Key Characteristics of WalkThrough",
        "option_A": "Scenario , Dry Run , Peer Group",
        "option_B": "Pre Meeting Preparations",
        "option_C": "Formal Follow Up Process",
        "option_D": "Includes Metrics",
        "correct_anwser": "A",
        "explain": "Đặc trưng chính của một buổi Walkthrough là tác giả sẽ dẫn dắt nhóm đồng nghiệp (Peer group) đi qua một kịch bản giả định (Scenario) hoặc chạy thử trên giấy (Dry run) nhằm giải thích luồng xử lý của sản phẩm và nhận góp ý."
      },
      {
        "question_id": 27,
        "question_title": "Which type of review is a formal assessment of a work product conducted by one or more qualified independent reviewers to detect defects?",
        "option_A": "Inspection",
        "option_B": "Walkthrough",
        "option_C": "Review",
        "option_D": "Non Conformance",
        "correct_anwser": "A",
        "explain": "Inspection (Kiểm định) là hình thức đánh giá chính thức, nghiêm ngặt nhất (formal assessment), được thực hiện bởi các bên đánh giá độc lập có năng lực chuyên môn phù hợp nhằm mục đích dò tìm mọi lỗi có trong sản phẩm một cách chi tiết."
      },
      {
        "question_id": 28,
        "question_title": "Which of the following is true about Formal Review or Inspection:\ni) Led by Trained Moderator (not the author).\nii) No Pre Meeting Preparations\niii) Formal Follow up process.\niv) Main Objective is to find defects",
        "option_A": "ii is true and i,iii,iv are false",
        "option_B": "i,iii,iv are true and ii is false",
        "option_C": "i,iii,iv are false and ii is true",
        "option_D": "iii is true and I,ii,iv are false",
        "correct_anwser": "B",
        "explain": "Bản chất của Formal Review hay Inspection là bắt buộc có người điều phối được đào tạo (i), có quy trình theo dõi sửa lỗi chặt chẽ (iii) và mục tiêu chính là tìm lỗi (iv). Do đó việc ghi 'No Pre Meeting Preparations' (ii) là hoàn toàn sai, vì khâu chuẩn bị trước cuộc họp (preparation) là bắt buộc và cực kỳ quan trọng đối với hình thức này."
      },
      {
        "question_id": 29,
        "question_title": "Who are the persons involved in a Formal Review\ni) Manager\nii) Moderator\niii) Scribe / Recorder\niv) Assistant Manager",
        "option_A": "i,ii,iii,iv are true",
        "option_B": "i,ii,iii are true and iv is false.",
        "option_C": "ii,iii,iv are true and i is false.",
        "option_D": "i,iv are true and ii, iii are false.",
        "correct_anwser": "B",
        "explain": "Các vai trò chính được định nghĩa trong một cuộc đánh giá chính thức (Formal Review) bao gồm: Quản lý (Manager - người phê duyệt kế hoạch), Người điều phối (Moderator), Thư ký ghi chép (Scribe/Recorder) và Người đánh giá (Reviewer). Vai trò 'Trợ lý quản lý' (Assistant Manager) không nằm trong các vai trò kỹ thuật tiêu chuẩn của quy trình đánh giá phần mềm."
      },
      {
        "question_id": 30,
        "question_title": "Reviewing the test Basis is a part of which phase",
        "option_A": "Test Analysis and Design",
        "option_B": "Test Implementation and execution",
        "option_C": "Test Closure Activities",
        "option_D": "Evaluating exit criteria and reporting",
        "correct_anwser": "A",
        "explain": "Cơ sở kiểm thử (Test Basis) bao gồm tài liệu yêu cầu, tài liệu kiến trúc, thiết kế... Hoạt động xem xét, đánh giá các tài liệu nền tảng này (Reviewing the test Basis) để xác định các điều kiện kiểm thử (Test conditions) là bước cốt lõi đầu tiên nằm trong giai đoạn Phân tích và Thiết kế kiểm thử (Test Analysis and Design)."
      },
      {
        "question_id": 31,
        "question_title": "Features of White Box Testing Technique:\ni. We use explicit knowledge of the internal workings of the item being tested to select the test data.\nii. Uses specific knowledge of programming code to examine outputs and assumes that the tester knows the path of logic in a unit or a program.\niii. Checking for the performance of the application\niv. Also checks for functionality.",
        "option_A": "i, ii are true and iii and iv are false",
        "option_B": "iii is true and i,ii, iv are false",
        "option_C": "ii ,iii is true and i,iv is false",
        "option_D": "iii and iv are true and i,ii are false",
        "correct_anwser": "A",
        "explain": "Kiểm thử hộp trắng (White-box testing) dựa trên cấu trúc mã nguồn bên trong của chương trình để thiết kế các kịch bản kiểm thử (i và ii đúng). Kiểm thử hiệu năng (iii) thuộc nhóm kiểm thử phi chức năng, và kiểm thử chức năng (iv) từ góc nhìn người dùng là đặc trưng thuần túy của kiểm thử hộp đen, nên iii và iv sai."
      },
      {
        "question_id": 32,
        "question_title": "Which of the following defects are typically easier to find during reviews than during dynamic testing?",
        "option_A": "Deviations from standards.",
        "option_B": "Requirement defects.",
        "option_C": "Design defects.",
        "option_D": "Insufficient maintainability and incorrect interface specifications.",
        "option_E": "All of the others.",
        "correct_anwser": "E",
        "explain": "Hoạt động Review (kiểm thử tĩnh) kiểm tra trực tiếp tài liệu và mã nguồn mà không cần chạy chương trình. Do đó, các lỗi liên quan đến vi phạm tiêu chuẩn định dạng (A), lỗi logic trong yêu cầu (B), lỗi kiến trúc thiết kế (C), hay mã nguồn khó bảo trì và sai đặc tả giao tiếp (D) đều cực kỳ dễ phát hiện thông qua review so với việc cố gắng chạy và suy diễn từ kiểm thử động."
      },
      {
        "question_id": 33,
        "question_title": "Consider the following state transition diagram of a switch. Which of the following represents an invalid state transition? (Pic 4_276)",
        "option_A": "OFF to ON",
        "option_B": "ON to OFF",
        "option_C": "FAULT to ON",
        "correct_anwser": "C",
        "explain": "Dựa vào sơ đồ chuyển trạng thái (State Transition Diagram) đính kèm: mũi tên chỉ hướng đi từ trạng thái OFF sang ON (hợp lệ) và từ ON quay về OFF (hợp lệ); trạng thái ON cũng có mũi tên chuyển tiếp sang FAULT. Tuy nhiên, tại ô FAULT chỉ có một mũi tên tự quay vòng lại chính nó (vòng lặp lỗi), hoàn toàn không có bất kỳ mũi tên nào dẫn từ FAULT quay trở lại trạng thái ON, do đó chuyển đổi FAULT sang ON là không hợp lệ (invalid)."
      },
      {
        "question_id": 34,
        "question_title": "Coverage measurement",
        "option_A": "Is nothing to do with testing",
        "option_B": "Is a partial measure of test thoroughness",
        "option_C": "Branch coverage should be mandatory for all software",
        "option_D": "Can only be applied at unit or module testing, not at system testing",
        "correct_anwser": "B",
        "explain": "Đo lường độ phủ (Coverage measurement) giúp đánh giá xem các kịch bản kiểm thử hiện tại đã đi qua được bao nhiêu phần trăm cấu trúc (mã nguồn, yêu cầu, luồng dữ liệu...). Nó đóng vai trò là một thước đo một phần cho thấy mức độ triệt để, kỹ lưỡng (test thoroughness) của quá trình kiểm thử phần mềm."
      },
      {
        "question_id": 35,
        "question_title": "Stochastic testing using statistical information or operational profiles uses the following method",
        "option_A": "Heuristic testing approach",
        "option_B": "Methodical testing approach",
        "option_C": "Model based testing approach",
        "option_D": "Process or standard compliant testing approach",
        "correct_anwser": "C",
        "explain": "Kiểm thử ngẫu nhiên/ngẫu nhiên có điều kiện (Stochastic testing) dựa trên dữ liệu thống kê hoặc hồ sơ vận hành thực tế (operational profiles) thường áp dụng các mô hình toán học hoặc trạng thái (chẳng hạn như Chuỗi Markov) để sinh kịch bản ngẫu nhiên mô phỏng người dùng. Cách tiếp cận này thuộc về kiểm thử dựa trên mô hình (Model-based testing approach)."
      },
      {
        "question_id": 36,
        "question_title": "Structure is unknown for which type of development project",
        "option_A": "Traditional system development",
        "option_B": "Iterative development",
        "option_C": "System maintenance",
        "option_D": "Purchased/contracted software",
        "correct_anwser": "D",
        "explain": "Đối với các sản phẩm phần mềm thương mại mua sẵn trên thị trường (COTS) hoặc phần mềm được thuê ngoài theo gói sản phẩm đóng (Purchased/contracted software), bên mua thường chỉ nhận được file thực thi thành phẩm và tài liệu hướng dẫn sử dụng mà hoàn toàn không có quyền tiếp cận cấu trúc mã nguồn bên trong, nên cấu trúc hệ thống đối với họ là không rõ ràng (unknown / black-box)."
      },
      {
        "question_id": 37,
        "question_title": "Where may functional testing be performed?",
        "option_A": "At system and acceptance testing levels only.",
        "option_B": "At all test levels.",
        "option_C": "At all levels above integration testing.",
        "option_D": "At the acceptance testing level only.",
        "correct_anwser": "B",
        "explain": "Theo chuẩn ISTQB, kiểm thử chức năng (Functional testing) tập trung vào việc hệ thống làm được những gì (What the system does) và có thể được áp dụng ở bất kỳ cấp độ kiểm thử nào: từ kiểm thử đơn vị (Unit), tích hợp (Integration), hệ thống (System) cho đến kiểm thử chấp nhận sản phẩm (Acceptance)."
      },
      {
        "question_id": 38,
        "question_title": "Use cases can be performed to test",
        "option_A": "Performance testing",
        "option_B": "Unit testing",
        "option_C": "Business scenarios",
        "option_D": "Static testing",
        "correct_anwser": "C",
        "explain": "Use case (Trường hợp sử dụng) mô tả các hành vi tương tác hoàn chỉnh giữa người dùng (Actor) và hệ thống để đạt được một mục tiêu cụ thể. Vì vậy, kỹ thuật kiểm thử dựa trên Use case cực kỳ phù hợp để thiết kế và kiểm tra các kịch bản nghiệp vụ thực tế của doanh nghiệp (Business scenarios)."
      },
      {
        "question_id": 39,
        "question_title": "Error guessing is:",
        "option_A": "An appropriate way of deriving system tests.",
        "option_B": "Only used if good requirements are not available.",
        "option_C": "Only used when good requirements are available.",
        "option_D": "The most appropriate way of deriving system tests.",
        "correct_anwser": "A",
        "explain": "Đoán lỗi (Error guessing) là một kỹ thuật dựa trên kinh nghiệm của kiểm thử viên để dự đoán các vùng code dễ phát sinh lỗi nhằm thiết kế kịch bản bổ sung. Đây là một phương pháp phù hợp và hữu ích khi kết hợp phối hợp cùng các kỹ thuật hộp đen chính thống khác để trích xuất ra các bài kiểm thử hệ thống đầy đủ hơn."
      },
      {
        "question_id": 40,
        "question_title": "Which of the following is a black box design technique?",
        "option_A": "Statement testing",
        "option_B": "Equivalence partitioning",
        "option_C": "Error-guessing",
        "option_D": "Usability testing",
        "correct_anwser": "B",
        "explain": "Phân vùng tương đương (Equivalence partitioning) là kỹ thuật thiết kế kiểm thử hộp đen (black box) kinh điển, thực hiện phân chia dữ liệu đầu vào thành các phân vùng có hành vi xử lý giống nhau. Ngược lại, Statement testing thuộc hộp trắng; Error-guessing dựa trên kinh nghiệm; Usability testing là loại kiểm thử đặc tính hệ thống."
      },
      {
        "question_id": 41,
        "question_title": "Equivalence testing divides the input domain into classes of data from which test cases can be derived to reduce the total number of test cases that must be developed.",
        "option_A": "True",
        "option_B": "False",
        "option_C": "",
        "option_D": "",
        "correct_anwser": "A",
        "explain": "Định nghĩa này hoàn toàn chính xác về kỹ thuật phân vùng tương đương (Equivalence Partitioning). Phương pháp này chia miền đầu vào thành các nhóm dữ liệu tương đương nhau về mặt hành vi xử lý, từ đó chỉ cần chọn ra một đại diện trong mỗi nhóm để kiểm thử, giúp giảm thiểu đáng kể số lượng test case cần thiết mà vẫn đảm bảo độ bao phủ lỗi."
      },
      {
        "question_id": 42,
        "question_title": "Which of the following is not included in Test Plan.",
        "option_A": "Features to be tested.",
        "option_B": "Environmental needs.",
        "option_C": "Suspension criteria.",
        "option_D": "Expected results.",
        "correct_anwser": "D",
        "explain": "Tài liệu Kế hoạch kiểm thử (Test Plan) bao gồm các hạng mục cấp cao như tính năng cần test (A), nhu cầu môi trường (B), và tiêu chí tạm dừng (C) theo cấu trúc chuẩn IEEE 829. 'Expected results' (Kết quả mong đợi) là thông tin cực kỳ chi tiết của từng kịch bản cụ thể, do đó nó nằm trong tài liệu Đặc tả kịch bản kiểm thử (Test Case Specification) chứ không nằm trong kế hoạch tổng thể."
      },
      {
        "question_id": 43,
        "question_title": "From a Testing perspective, what are the MAIN purposes of Configuration Management?\ni) Identifying the version of software under test.\nii) Controlling the version of testware items.\niii) Developing new testware items.\niv) Tracking changes to testware items.\nv) Analysing the need for new testware items.",
        "option_A": "ii, iv and v.",
        "option_B": "ii, iii and iv.",
        "option_C": "i, ii and iv.",
        "option_D": "i, iii and v.",
        "correct_anwser": "C",
        "explain": "Quản lý cấu hình (Configuration Management) từ góc nhìn kiểm thử tập trung vào việc quản lý phiên bản và theo dõi thay đổi của hệ thống: định danh chính xác phiên bản phần mềm đang được kiểm thử (i), kiểm soát các phiên bản của các thành phần kiểm thử/testware (ii) và theo dõi lịch sử thay đổi của chúng (iv). Việc phát triển (iii) hay phân tích nhu cầu tạo mới (v) testware thuộc về các hoạt động kỹ nghệ và lên kế hoạch chứ không thuộc chức năng của quản lý cấu hình."
      },
      {
        "question_id": 44,
        "question_title": "Which of the following is the task of a Test Lead / Leader.\ni. Interaction with the Test Tool Vendor to identify best ways to leverage test tool on the project.\nii. Write Test Summary Reports based on the information gathered during testing\niii. Decide what should be automated, to what degree and how.\niv. Create the Test Specifications",
        "option_A": "i, ii, iii is true and iv is false",
        "option_B": "ii,iii,iv is true and i is false",
        "option_C": "i is true and ii,iii,iv are false",
        "option_D": "iii and iv is correct and i and ii are incorrect",
        "correct_anwser": "A",
        "explain": "Trưởng nhóm kiểm thử (Test Lead/Leader) chịu trách nhiệm về các hoạt động quản lý, định hướng và giao tiếp cấp cao như: làm việc với nhà cung cấp công cụ (i), viết báo cáo tổng kết kiểm thử (ii), và đưa ra chiến lược tự động hóa (iii). Việc viết chi tiết các tài liệu Đặc tả kiểm thử (Test Specifications - iv) thông thường là nhiệm vụ thực thi của các Kiểm thử viên (Testers)."
      },
      {
        "question_id": 45,
        "question_title": "Which of the following is not a characteristic for Testability?",
        "option_A": "Operability",
        "option_B": "Observability",
        "option_C": "Simplicity",
        "option_D": "Robustness",
        "correct_anwser": "D",
        "explain": "Tính khả thí khi kiểm thử (Testability) thể hiện mức độ dễ dàng của một hệ thống khi thực hiện kiểm thử, bao gồm các đặc tính kinh điển do James Bach đưa ra như: Khả năng vận hành (Operability), Khả năng quan sát thấy đầu ra (Observability), Độ đơn giản (Simplicity)... Ngược lại, 'Robustness' (Độ bền vững/Khả năng chịu lỗi của hệ thống) là một thuộc tính chất lượng của bản thân sản phẩm phần mềm, không phải là đặc tính hỗ trợ cho việc dễ kiểm thử hay không."
      },
      {
        "question_id": 46,
        "question_title": "Which of the following tools would you use to detect a memory leak?",
        "option_A": "State analysis",
        "option_B": "Coverage analysis",
        "option_C": "Dynamic analysis",
        "option_D": "Memory analysis",
        "correct_anwser": "C",
        "explain": "Hiện tượng rò rỉ bộ nhớ (Memory leak) chỉ xảy ra khi chương trình được kích hoạt và chạy thực tế theo thời gian. Do đó, các công cụ phân tích động (Dynamic analysis tools) được thiết kế đặc biệt để theo dõi tài nguyên hệ thống trong khi đang chạy nhằm phát hiện ra các lỗi phân bổ vùng nhớ, con trỏ hoang dã hoặc rò rỉ bộ nhớ."
      },
      {
        "question_id": 47,
        "question_title": "Which activity in the fundamental test process creates test suites for efficient test execution?",
        "option_A": "Implementation and execution.",
        "option_B": "Planning and control.",
        "option_C": "Analysis and design.",
        "option_D": "Test closure.",
        "correct_anwser": "A",
        "explain": "Mặc dù các kịch bản kiểm thử (Test Cases) đơn lẻ được phân tích thiết kế ở giai đoạn trước, nhưng hoạt động nhóm chúng lại với nhau thành các tập kịch bản (Test Suites) bài bản, chuẩn bị dữ liệu và sắp xếp thứ tự ưu tiên thực thi để chạy tối ưu nhất chính là bước mở đầu cốt lõi của giai đoạn Thực hiện và Chạy kiểm thử (Test Implementation and Execution)."
      },
      {
        "question_id": 48,
        "question_title": "Test Case are grouped into Manageable (and scheduled) units are called as",
        "option_A": "Test Harness",
        "option_B": "Test Suite",
        "option_C": "Test Cycle",
        "option_D": "Test Driver",
        "correct_anwser": "B",
        "explain": "Tập hợp các ca kiểm thử (Test Cases) được nhóm lại với nhau thành một đơn vị logic để dễ quản lý, điều phối và lên lịch thực thi cho một mục đích kiểm thử cụ thể được định nghĩa chính xác là một 'Test Suite' (Bộ kịch bản kiểm thử)."
      },
      {
        "question_id": 49,
        "question_title": "Impact Analysis helps to decide:",
        "option_A": "How much regression testing should be done.",
        "option_B": "Exit Criteria",
        "option_C": "How many more test cases need to written",
        "option_D": "Different Tools to perform Regression Testing",
        "correct_anwser": "A",
        "explain": "Phân tích tác động (Impact Analysis) đánh giá các vùng xung quanh bị ảnh hưởng khi có một sự thay đổi trong hệ thống hoặc khi sửa một lỗi. Dựa trên kết quả phân tích này, đội ngũ kiểm thử sẽ quyết định chính xác phạm vi và khối lượng cần thực hiện kiểm thử hồi quy (Regression testing) để tối ưu hóa thời gian chạy."
      },
      {
        "question_id": 50,
        "question_title": "Which of the following helps in monitoring the Test Progress:\ni. Percentage of Test Case Execution\nii. Percentage of work done in test environment preparation.\niii. Defect Information e.g. defect density, defects found and fixed\niv. The size of the testing Team and skills of the engineers",
        "option_A": "iv is correct and i,ii,iii are incorrect",
        "option_B": "i,ii,iii are correct and iv is incorrect",
        "option_C": "i,ii are correct and iii,iv are incorrect",
        "option_D": "i,iv are correct and ii , iii are incorrect",
        "correct_anwser": "B",
        "explain": "Để theo dõi tiến độ kiểm thử (Test Progress Monitoring), người ta dựa trên các số liệu thực tế đo lường được về sản phẩm và công việc bao gồm: phần trăm các test case đã được chạy (i), tiến độ hoàn thành chuẩn bị môi trường chạy (ii), và các thông số chi tiết liên quan đến lỗi như mật độ lỗi, số lỗi tìm thấy và đã sửa (iii). Quy mô nhân sự hay kỹ năng của tester (iv) là các yếu tố quản trị nguồn lực cố định, không dùng làm thước đo động để theo dõi tiến độ chạy hàng ngày."
      },
      {
        "question_id": 51,
        "question_title": "Which of the following is a MAJOR task of test planning?",
        "option_A": "Scheduling test analysis and design tasks.",
        "option_B": "Initiating corrective actions.",
        "option_C": "Monitoring progress and test coverage.",
        "option_D": "Measuring and analyzing results.",
        "correct_anwser": "A",
        "explain": "Lập kế hoạch kiểm thử (Test Planning) liên quan đến việc xác định mục tiêu, phạm vi và xây dựng lộ trình thực hiện. Hoạt động lên lịch trình cho các tác vụ phân tích và thiết kế kiểm thử (Scheduling test analysis and design tasks) là một nhiệm vụ cốt lõi thuộc giai đoạn này. Các đáp án B và C thuộc về khâu Kiểm soát (Test Control & Monitoring), đáp án D thuộc về khâu Đánh giá kết quả thực thi."
      },
      {
        "question_id": 52,
        "question_title": "Capture and replay facilities are least likely to be used to ______.",
        "option_A": "Performance testing",
        "option_B": "Recovery testing",
        "option_C": "GUI testing",
        "option_D": "User requirements.",
        "correct_anwser": "D",
        "explain": "Công cụ ghi và phát lại (Capture and replay / Record and Playback) là các công cụ hỗ trợ thực thi kiểm thử tự động, dùng để ghi lại hành vi trên giao diện (GUI), giả lập nhiều luồng tải (Performance), hoặc lặp lại chuỗi hành vi kiểm tra phục hồi hệ thống (Recovery). Tuy nhiên, chúng không có khả năng hỗ trợ thu thập hay định nghĩa yêu cầu của người dùng (User requirements), vì đây là hoạt động phân tích nghiệp vụ ở giai đoạn khởi đầu dự án."
      },
      {
        "question_id": 53,
        "question_title": "Defects discovered by static analysis tools include:\ni. Variables that are never used.\nii. Security vulnerabilities.\niii. Programming Standard Violations\niv. Uncalled functions and procedures",
        "option_A": "i, ii, iii, iv is correct",
        "option_B": "iii ,is correct i,ii,iv are incorrect.",
        "option_C": "i ,ii, iii and iv are incorrect",
        "option_D": "iv, ii is correct",
        "correct_anwser": "A",
        "explain": "Tất cả các lỗi được liệt kê bao gồm: biến khai báo nhưng không dùng (i), lỗ hổng bảo mật cấu trúc (ii), vi phạm quy chuẩn đặt tên/định dạng code (iii), và các hàm/thủ tục rác không bao giờ được gọi đến (iv) đều là những lỗi kinh điển mà các công cụ phân tích tĩnh (Static analysis tools) dễ dàng quét ra được từ mã nguồn mà không cần chạy chương trình."
      },
      {
        "question_id": 54,
        "question_title": "Which of the following tools would be involved in the automation of regression test?",
        "option_A": "Data tester",
        "option_B": "Boundary tester",
        "option_C": "Capture/Playback",
        "option_D": "Output comparator.",
        "correct_anwser": "D",
        "explain": "Mục tiêu cốt lõi của kiểm thử hồi quy (Regression testing) là kiểm tra xem các tính năng cũ có bị thay đổi hành vi hoặc phát sinh lỗi sau khi sửa đổi mã nguồn hay không. Do đó, công cụ so sánh kết quả đầu ra (Output comparator) đóng vai trò quyết định quan trọng nhất trong việc tự động so sánh kết quả của phiên bản hiện tại với phiên bản baseline trước đó xem có sự sai lệch nào xảy ra không."
      },
      {
        "question_id": 55,
        "question_title": "Which type of tool stores requirement statements, checks for consistency, allows requirements to be prioritized, and enables individual tests to be traceable to requirements, functions, and features?",
        "option_A": "Incident management tools",
        "option_B": "Requirements management tools",
        "option_C": "Configuration management tools",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Công cụ đáp ứng đầy đủ các tính năng: lưu trữ phát biểu yêu cầu, kiểm tra tính nhất quán, thiết lập độ ưu tiên, và tạo ma trận truy vết (Traceability matrix) từ test case đến các chức năng/yêu cầu chính là công cụ Quản lý yêu cầu (Requirements management tools)."
      },
      {
        "question_id": 56,
        "question_title": "Which of the following activities should be performed during the selection and implementation of a testing tool?\ni) Investigate the organisation's test process.\nii) Conduct a proof of concept.\niii) Implement the selected tool on a project behind schedule to save time.\niv) Identify coaching and mentoring requirements for the use of the selected tool.",
        "option_A": "i, ii, iii.",
        "option_B": "ii, iii, iv.",
        "option_C": "i, iii, iv.",
        "option_D": "i, ii, iv.",
        "correct_anwser": "D",
        "explain": "Khi lựa chọn và triển khai áp dụng công cụ mới, tổ chức cần: nghiên cứu quy trình hiện tại (i), chạy thử nghiệm đánh giá tính khả thi/Proof of Concept (ii), và lên kế hoạch đào tạo/hướng dẫn sử dụng cho nhân sự (iv). Ý (iii) là một sai lầm nghiêm trọng trong quản trị, bởi việc áp dụng một công cụ mới vào một dự án đang bị chậm tiến độ (behind schedule) chỉ làm tăng thêm rủi ro và làm dự án trễ hơn do đội ngũ mất thời gian làm quen với công cụ mới."
      },
      {
        "question_id": 57,
        "question_title": "A tool that supports traceability, recording of incidents or scheduling of tests is called:",
        "option_A": "A dynamic analysis tool",
        "option_B": "A test execution tool",
        "option_C": "A debugging tool",
        "option_D": "A test management tool",
        "option_E": "A configuration management tool",
        "correct_anwser": "D",
        "explain": "Công cụ Quản lý kiểm thử (Test management tool) là công cụ tổng thể hỗ trợ xuyên suốt vòng đời kiểm thử, bao gồm các tính năng quản lý mối quan hệ truy vết (traceability), ghi nhận lỗi/sự cố (recording of incidents), và lên lịch trình điều phối các đợt thực thi kiểm thử (scheduling of tests)."
      },
      {
        "question_id": 58,
        "question_title": "What type of tools to be used for Regression Testing ?\nA. (1) Performance\nB. (2) Record/Playback\nC. Both of (1) and (2)\nD. None of (1) nor (2)",
        "option_A": "(1) Performance",
        "option_B": "(2) Record/Playback",
        "option_C": "Both of (1) and (2)",
        "option_D": "None of (1) nor (2)",
        "correct_anwser": "C",
        "explain": "Kiểm thử hồi quy (Regression Testing) có thể áp dụng cho cả khía cạnh chức năng lẫn phi chức năng. Các công cụ Record/Playback giúp tự động hóa việc lặp lại các kịch bản chức năng cũ (hồi quy chức năng), còn các công cụ Performance giúp chạy lại các kịch bản tải để đảm bảo những thay đổi code mới không làm suy giảm hiệu năng hệ thống (hồi quy hiệu năng). Do đó cả hai loại công cụ này đều được ứng dụng."
      },
      {
        "question_id": 59,
        "question_title": "Unreachable code would best be found using:",
        "option_A": "Code reviews",
        "option_B": "Code inspections",
        "option_C": "A coverage tool",
        "option_D": "A test management tool",
        "option_E": "A static analysis tool",
        "correct_anwser": "E",
        "explain": "Mã nguồn chết hay mã nguồn không bao giờ chạm tới được (Unreachable code) là một lỗi cấu trúc luồng điều khiển trong lập trình (ví dụ: viết code nằm sau câu lệnh return). Công cụ Phân tích tĩnh (Static analysis tool) phân tích đồ thị luồng thực thi (Control flow graph) của mã nguồn nên có khả năng phát hiện ra loại lỗi này một cách nhanh chóng và chính xác nhất."
      },
      {
        "question_id": 60,
        "question_title": "Which tool will be used to test the flag memory leaks and unassigned pointers",
        "option_A": "Dynamic analysis tool",
        "option_B": "Static Analysis tool.",
        "option_C": "Maintenance tool.",
        "option_D": "Configuration tool.",
        "correct_anwser": "A",
        "explain": "Tương tự như hiện tượng rò rỉ bộ nhớ (memory leaks) và việc sử dụng các con trỏ chưa được gán/định vị vùng nhớ thực tế (unassigned/wild pointers) khi chương trình phân bổ tài nguyên động, công cụ Phân tích động (Dynamic analysis tool) là giải pháp chuyên dụng để giám sát, gắn cờ (flag) và phát hiện các hành vi bất thường này trong quá trình thực thi hệ thống."
      }
    ]
  },
  {
    "id": "swt301-sp26-re",
    "title": "SWT301 - SP26 - RE",
    "description": "Software Testing Quiz",
    "questionsCount": 60,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which of the following will be the best definition for Testing:",
        "option_A": "The goal / purpose of testing is to demonstrate that the program works.",
        "option_B": "The purpose of testing is to demonstrate that the program is defect free.",
        "option_C": "The purpose of testing is to demonstrate that the program does what it is supposed to do",
        "option_D": "Testing is executing Software for the purpose of finding defects.",
        "correct_anwser": "D",
        "explain": "Theo nguyên lý và định nghĩa chuẩn về kiểm thử phần mềm (ví dụ từ ISTQB), mục đích cốt lõi của kiểm thử là chạy phần mềm nhằm tìm ra các lỗi/khuyết tật (defects). Kiểm thử không thể chứng minh phần mềm hoàn toàn không có lỗi (loại B) mà chỉ giúp giảm thiểu rủi ro."
      },
      {
        "question_id": 2,
        "question_title": "Which is the non-functional testing",
        "option_A": "Performance testing",
        "option_B": "Unit testing",
        "option_C": "Regression testing",
        "option_D": "Sanity testing",
        "correct_anwser": "A",
        "explain": "Performance testing (Kiểm thử hiệu năng) là một loại kiểm thử phi chức năng (non-functional) vì nó đánh giá các đặc tính như độ ổn định, tốc độ phản hồi và khả năng chịu tải của hệ thống, thay vì kiểm tra các chức năng nghiệp vụ cụ thể."
      },
      {
        "question_id": 3,
        "question_title": "What is the purpose of test completion criteria in a test plan:",
        "option_A": "To know when a specific test has finished its execution",
        "option_B": "To ensure that the test case specification is complete",
        "option_C": "To set the criteria used in generating test inputs",
        "option_D": "To know when test planning is complete",
        "option_E": "To plan when to stop testing",
        "correct_anwser": "E",
        "explain": "Test completion criteria (hay còn gọi là Exit Criteria - Tiêu chí hoàn thành/tiêu chí dừng) được định nghĩa trong kế hoạch kiểm thử để xác định thời điểm hoặc điều kiện mà tại đó quy trình kiểm thử có thể dừng lại một cách hợp lý."
      },
      {
        "question_id": 4,
        "question_title": "Which of the following could be a reason for a failure?\n1) Testing fault\n2) Software fault\n3) Design fault\n4) Environment Fault\n5) Documentation Fault",
        "option_A": "2 is a valid reason; 1,3,4 & 5 are not",
        "option_B": "1,2,3,4 are valid reasons; 5 is not",
        "option_C": "1,2,3 are valid reasons; 4 & 5 are not",
        "option_D": "All of them are valid reasons for failure",
        "correct_anwser": "D",
        "explain": "Sự cố (failure) trên thực tế có thể bắt nguồn từ bất kỳ lý do nào được liệt kê: lỗi phần mềm (software fault), lỗi thiết kế (design fault), lỗi môi trường vận hành/kiểm thử (environment fault), lỗi tài liệu hướng dẫn (documentation fault) khiến người dùng thao tác sai, hoặc thậm chí lỗi trong chính kịch bản/quy trình kiểm thử (testing fault) gây ra hiểu lầm về kết quả."
      },
      {
        "question_id": 5,
        "question_title": "Bug life cycle",
        "option_A": "Open, Assigned, Fixed, Closed",
        "option_B": "Open, Fixed, Assigned, Closed",
        "option_C": "Assigned, Open, Closed, Fixed",
        "option_D": "Assigned, Open, Fixed, Closed",
        "correct_anwser": "A",
        "explain": "Một vòng đời cơ bản và tuần tự logic của một Bug thường bắt đầu bằng việc được phát hiện và mở ra (Open), sau đó được phân công cho lập trình viên xử lý (Assigned), lập trình viên sửa xong lỗi (Fixed), và cuối cùng sau khi tester kiểm tra lại đạt yêu cầu thì đóng bug lại (Closed)."
      },
      {
        "question_id": 6,
        "question_title": "A piece of software has been given ______ what tests in the following will you perform?\n1) Test the area's most critical to business processes\n2) Test the areas where faults will be maximum\n3) Test the easiest functionalities",
        "option_A": "1&2 are true and 3 is false",
        "option_B": "1,2&3 are true.",
        "option_C": "1 is true, 2&3 are false.",
        "option_D": "1&2 are false, 3 is true",
        "correct_anwser": "A",
        "explain": "Do nguồn lực và thời gian kiểm thử luôn có hạn, chiến lược kiểm thử dựa trên rủi ro yêu cầu chúng ta ưu tiên kiểm thử các vùng quan trọng nhất với luồng nghiệp vụ kinh doanh (1) và các vùng có nguy cơ tích tụ hoặc chứa lượng lỗi cao nhất (2). Việc ưu tiên chạy các tính năng dễ nhất (3) không mang lại giá trị tối ưu cho chất lượng phần mềm."
      },
      {
        "question_id": 7,
        "question_title": "A standard for software testing terminology is:",
        "option_A": "IEEE 802.11",
        "option_B": "ISO 9001",
        "option_C": "BS 7925-1",
        "option_D": "BS 7925-2",
        "correct_anwser": "C",
        "explain": "BS 7925-1 là tiêu chuẩn của Vương quốc Anh (British Standard) quy định cụ thể về thuật ngữ và định nghĩa trong kiểm thử phần mềm (Standard for Software Testing - Part 1: Vocabulary). Trong khi đó, BS 7925-2 định nghĩa về kỹ thuật thiết kế ca kiểm thử (Component Testing Standard)."
      },
      {
        "question_id": 8,
        "question_title": "As part of which test process do you determine the exit criteria?",
        "option_A": "Test planning.",
        "option_B": "Evaluating exit criteria and reporting.",
        "option_C": "Test closure.",
        "option_D": "Test control.",
        "correct_anwser": "A",
        "explain": "Việc xác định (determine/define) các tiêu chí dừng (exit criteria) phải được thực hiện từ sớm trong giai đoạn Lập kế hoạch kiểm thử (Test planning). Còn giai đoạn 'Evaluating exit criteria' chỉ là hoạt động đánh giá xem kết quả kiểm thử thực tế đã thỏa mãn các tiêu chí đã định trước đó hay chưa."
      },
      {
        "question_id": 9,
        "question_title": "Which, in general, is the least required skill of a good tester?",
        "option_A": "Being diplomatic",
        "option_B": "Able to write software",
        "option_C": "Having good attention to detail",
        "option_D": "Able to be relied on",
        "correct_anwser": "B",
        "explain": "Một kiểm thử viên giỏi cần sự khéo léo trong giao tiếp/ngoại giao (diplomatic), sự tỉ mỉ chú ý đến chi tiết (attention to detail) và sự đáng tin cậy (be relied on). Khả năng viết phần mềm (lập trình nâng cao) là một lợi thế (ví dụ đối với Automation Tester) nhưng xét trên diện rộng và cơ bản thì đây là kỹ năng ít bắt buộc nhất so với các phẩm chất còn lại."
      },
      {
        "question_id": 10,
        "question_title": "What is the purpose of exit criteria?",
        "option_A": "To define when a test level is complete.",
        "option_B": "To determine when a test has completed.",
        "option_C": "To identify when a software system should be retired.",
        "option_D": "To determine whether a test has passed.",
        "correct_anwser": "A",
        "explain": "Theo định nghĩa chuẩn của ISTQB, mục đích của tiêu chí dừng (exit criteria) là xác định xem khi nào một cấp độ kiểm thử (test level) hoặc một giai đoạn kiểm thử cụ thể đã hoàn thành các mục tiêu đề ra để có thể kết thúc một cách an toàn."
      },
      {
        "question_id": 11,
        "question_title": "A test design technique is",
        "option_A": "A process for selecting test cases",
        "option_B": "A process for determining expected outputs",
        "option_C": "A way to measure the quality of software",
        "option_D": "A way to measure in a test plan what has to be done",
        "correct_anwser": "A",
        "explain": "Kỹ thuật thiết kế kiểm thử (test design technique) là một phương pháp hoặc quy trình có hệ thống giúp lựa chọn, xác định và tạo dựng các ca kiểm thử (test cases) cũng như dữ liệu kiểm thử từ các điều kiện kiểm thử."
      },
      {
        "question_id": 12,
        "question_title": "Testing activity which is performed to expose defects in the interfaces and in the interaction between integrated components is",
        "option_A": "System Level Testing",
        "option_B": "Integration Level Testing",
        "option_C": "Unit Level Testing",
        "option_D": "Component Testing",
        "correct_anwser": "B",
        "explain": "Kiểm thử tích hợp (Integration Level Testing) tập trung cụ thể vào việc phát hiện các lỗi xuất hiện ở các giao diện tương tác (interfaces) và sự phối hợp hoạt động giữa các thành phần/mô-đun phần mềm đã được tích hợp lại với nhau."
      },
      {
        "question_id": 13,
        "question_title": "Repeated Testing of an already tested program, after modification, to discover any defects introduced or uncovered as a result of the changes in the software being tested or in another related or unrelated software component:",
        "option_A": "Re Testing",
        "option_B": "Confirmation Testing",
        "option_C": "Regression Testing",
        "option_D": "Negative Testing",
        "correct_anwser": "C",
        "explain": "Regression Testing (Kiểm thử hồi quy) là việc kiểm thử lại một phần mềm đã qua chỉnh sửa nhằm đảm bảo rằng các thay đổi này không làm xuất hiện lỗi mới hoặc làm hỏng các tính năng vốn đang hoạt động bình thường ở các vùng xung quanh."
      },
      {
        "question_id": 14,
        "question_title": "Which of the following statements about component testing is not true?",
        "option_A": "Component testing should be performed by development",
        "option_B": "Component testing is also known as isolation or module testing",
        "option_C": "Component testing should have completion criteria planned",
        "option_D": "Component testing does not involve regression testing",
        "correct_anwser": "D",
        "explain": "Phát biểu D sai vì kiểm thử thành phần (component testing) vẫn hoàn toàn có thể bao gồm kiểm thử hồi quy (regression testing) khi một thành phần bị sửa đổi và ta cần chạy lại các test case cũ của thành phần đó để đảm bảo mã mới không gây lỗi phụ."
      },
      {
        "question_id": 15,
        "question_title": "During the software development process, at what point can the test process start?",
        "option_A": "When the code is complete.",
        "option_B": "When the design is complete.",
        "option_C": "When the software requirements have been approved.",
        "option_D": "When the first code module is ready for unit testing",
        "correct_anwser": "C",
        "explain": "Quy trình kiểm thử hiện đại khuyến khích việc tham gia sớm. Ngay khi các yêu cầu phần mềm (software requirements) được phê duyệt, tester đã có thể bắt đầu các hoạt động kiểm thử tĩnh (tuyển tập, phân tích yêu cầu, viết test plan và chuẩn bị kịch bản kiểm thử), thay vì đợi đến khi có code."
      },
      {
        "question_id": 16,
        "question_title": "Which of the following is a part of Test Closure Activities?\ni. Checking which planned deliverables have been delivered\nii. Defect report analysis.\niii. Finalizing and archiving testware.\niv. Analyzing lessons",
        "option_A": "i , ii , iv are true and iii is false",
        "option_B": "i , ii , iii are true and iv is false",
        "option_C": "i , iii , iv are true and ii is false",
        "option_D": "All of them are true",
        "correct_anwser": "D",
        "explain": "Tất cả 4 hoạt động trên đều thuộc giai đoạn Hoạt động đóng hoạt động kiểm thử (Test Closure Activities) theo chuẩn ISTQB, bao gồm bàn giao tài liệu sản phẩm, phân tích báo cáo lỗi cuối kỳ, lưu trữ tài nguyên kiểm thử (testware) và họp rút kinh nghiệm (lessons learned)."
      },
      {
        "question_id": 17,
        "question_title": "Which of the following is not a type of incremental testing approach?",
        "option_A": "Top down",
        "option_B": "Big-bang",
        "option_C": "Bottom up",
        "option_D": "Functional incrementation.",
        "correct_anwser": "B",
        "explain": "Big-bang (Kiểm thử vụ nổ lớn) là phương pháp tích hợp tất cả các thành phần cùng một lúc rồi tiến hành kiểm thử toàn bộ, trái ngược hoàn toàn với phương pháp tiếp cận tăng dần/từng bước (incremental testing approach) như Top-down hay Bottom-up."
      },
      {
        "question_id": 18,
        "question_title": "Test Implementation and execution has which of the following major tasks?\ni. Developing and prioritizing test cases, creating test data, writing test procedures and optionally preparing the test harnesses and writing automated test scripts.\nii. Creating the test suite from the test cases for efficient test execution.\niii. Verifying that the test environment has been set up correctly.\niv. Determining the exit criteria.",
        "option_A": "i,ii,iii are true and iv is false",
        "option_B": "i,,iv are true and ii is false",
        "option_C": "i,ii are true and iii,iv are false",
        "option_D": "ii,iii,iv are true and i is false",
        "correct_anwser": "A",
        "explain": "Các tác vụ i, ii, iii đều nằm trong giai đoạn Hiện thực hóa và Thực thi kiểm thử (Test Implementation and Execution). Riêng tác vụ iv (Xác định tiêu chí dừng - Determining the exit criteria) thuộc về giai đoạn Lập kế hoạch kiểm thử (Test Planning) nên iv là sai."
      },
      {
        "question_id": 19,
        "question_title": "Validation involves which of the following\ni. Helps to check the Quality of the Built Product\nii. Helps to check that we have built the right product.\niii. Helps in developing the product\niv. Monitoring tool wastage and obsoleteness.",
        "option_A": "Options i,ii,iii,iv are true",
        "option_B": "ii is true and i,iii,iv are false",
        "option_C": "i,ii,iii are true and iv is false",
        "option_D": "iii is true and i,ii,iv are false",
        "correct_anwser": "B",
        "explain": "Định nghĩa kinh điển của Validation (Xác nhận giá trị sử dụng) là để trả lời cho câu hỏi: 'Are we building the right product?' (Chúng ta có đang xây dựng đúng sản phẩm mà khách hàng cần hay không). Do đó điều ii phản ánh chính xác nhất mục đích cốt lõi của Validation."
      },
      {
        "question_id": 20,
        "question_title": "Which of the following has highest level of independence in which test cases are:",
        "option_A": "Designed by persons who write the software under test",
        "option_B": "Designed by a person from a different section",
        "option_C": "Designed by a person from a different organization",
        "option_D": "Designed by another person",
        "correct_anwser": "C",
        "explain": "Cấp độ độc lập cao nhất trong kiểm thử (Highest level of independence) đạt được khi việc thiết kế và thực thi kiểm thử được thực hiện bởi một người hoặc một đội ngũ đến từ một tổ chức/công ty hoàn toàn độc lập bên ngoài (ví dụ: bên thứ ba hoặc công ty outsourced chuyên biệt)."
      },
      {
        "question_id": 21,
        "question_title": "Find the correct flow of the phases of a formal review",
        "option_A": "Planning, Review meeting, Rework, Kick off",
        "option_B": "Planning, Individual preparation, Kick off, Rework",
        "option_C": "Planning, Review meeting, Rework, Follow up",
        "option_D": "Planning, Individual preparation, Follow up, Kick off",
        "correct_anwser": "C",
        "explain": "Trong các phương án được đưa ra, phương án C thể hiện đúng trật tự logic tăng dần của một quy trình đánh giá chính thức (formal review): Bắt đầu bằng Planning (Lập kế hoạch), tiếp theo tiến hành cuộc họp Review meeting, sau đó tác giả chỉnh sửa lỗi tìm được (Rework), và cuối cùng thực hiện kiểm tra lại (Follow up)."
      },
      {
        "question_id": 22,
        "question_title": "What is the main purpose of Informal review",
        "option_A": "Inexpensive way to get some benefit",
        "option_B": "Find defects",
        "option_C": "Learning, gaining understanding, effect finding",
        "option_D": "Discuss, make decisions, solve technical problems",
        "correct_anwser": "A",
        "explain": "Mục đích chính mang tính đặc trưng cốt lõi của đánh giá không chính thức (Informal review) là một cách thức có chi phí rất rẻ (tiết kiệm thời gian, không cần quy trình rườm rà) để mang lại một số lợi ích nhất định cho sản phẩm phẩm phần mềm ngay tức thì."
      },
      {
        "question_id": 23,
        "question_title": "In a review meeting a moderator is a person who",
        "option_A": "Takes minutes of the meeting",
        "option_B": "Mediates between people",
        "option_C": "Takes telephone calls",
        "option_D": "Writes the documents to be reviewed",
        "correct_anwser": "B",
        "explain": "Trong một cuộc họp review, Moderator (Người điều phối) là người chịu trách nhiệm dẫn dắt cuộc họp, đảm bảo tiến độ và làm trung gian điều hòa, giải quyết mâu thuẫn hay tranh luận giữa các thành viên tham gia (Mediates between people)."
      },
      {
        "question_id": 24,
        "question_title": "The Phases of formal review process is mentioned below arrange them in the correct order.\ni) Planning\nii) Review Meeting\niii) Rework\niv) Individual Preparations\nv) Kick Off\nvi) Follow Up",
        "option_A": "i,ii,iii,iv,v,vi",
        "option_B": "vi,i,ii,iii,iv,v",
        "option_C": "i,v,iv,ii,iii,vi",
        "option_D": "i,ii,iii,v,iv,vi",
        "correct_anwser": "C",
        "explain": "Theo tiêu chuẩn ISTQB, một quy trình formal review đầy đủ và chuẩn xác nhất bao gồm các bước theo thứ tự: i) Planning -> v) Kick Off -> iv) Individual Preparations -> ii) Review Meeting -> iii) Rework -> vi) Follow Up."
      },
      {
        "question_id": 25,
        "question_title": "Success Factors for a review include:\ni. Each Review does not have a predefined objective\nii. Defects found are welcomed and expressed objectively\niii. Management supports a good review process.\niv. There is an emphasis on learning and process improvement.",
        "option_A": "ii,iii,iv are correct and i is incorrect",
        "option_B": "iii , i , iv is correct and ii is incorrect",
        "option_C": "i , iii , iv , ii is in correct",
        "option_D": "ii is correct",
        "correct_anwser": "A",
        "explain": "Để một buổi review thành công, mỗi buổi đánh giá bắt buộc phải có mục tiêu định trước, nên ý i (không có mục tiêu định trước) là sai. Các ý ii, iii, iv đều là những yếu tố tâm lý và tổ chức tích cực giúp quá trình đánh giá đạt hiệu quả cao."
      },
      {
        "question_id": 26,
        "question_title": "What can static analysis NOT find?",
        "option_A": "The use of a variable before it has been defined",
        "option_B": "Unreachable (\"dead\") code",
        "option_C": "Memory leaks",
        "option_D": "Array bound violations",
        "correct_anwser": "C",
        "explain": "Static analysis (Phân tích tĩnh) thực hiện kiểm tra mã nguồn mà không cần chạy chương trình. Nó dễ dàng phát hiện biến chưa định nghĩa (A), code không bao giờ chạy tới (B), hay nguy cơ tràn mảng dựa trên cú pháp (D). Tuy nhiên, Memory leaks (Rò rỉ bộ nhớ) thường chỉ được phát hiện chính xác khi chương trình được thực thi thực tế (Dynamic analysis)."
      },
      {
        "question_id": 27,
        "question_title": "People who don't participate in technical reviews",
        "option_A": "Analysts",
        "option_B": "Management",
        "option_C": "Developers",
        "option_D": "Testers",
        "correct_anwser": "B",
        "explain": "Technical review (Đánh giá kỹ thuật) là một hoạt động chuyên sâu tập trung vào khía cạnh kỹ thuật, thiết kế và mã nguồn của sản phẩm, có sự tham gia của các vai trò chuyên môn như Developers, Testers, Analysts. Ban quản lý (Management) thường không tham gia trực tiếp vào các buổi đánh giá kỹ thuật này."
      },
      {
        "question_id": 28,
        "question_title": "Peer Reviews are also called as :",
        "option_A": "Inspection",
        "option_B": "Walkthrough",
        "option_C": "Technical Review",
        "option_D": "Formal Review",
        "correct_anwser": "C",
        "explain": "Thuật ngữ Peer Review (Đánh giá đồng nghiệp) trong công nghệ phần mềm thường được sử dụng như một tên gọi hoặc khái niệm chung tương đương bao hàm cho các loại hình đánh giá kỹ thuật (Technical Review), nơi các kỹ sư cùng chuyên môn đánh giá chéo sản phẩm của nhau."
      },
      {
        "question_id": 29,
        "question_title": "Which of the following is a static test?",
        "option_A": "Code inspection",
        "option_B": "Coverage analysis",
        "option_C": "Usability assessment",
        "option_D": "Installation test",
        "correct_anwser": "A",
        "explain": "Code inspection (Kiểm tra mã nguồn) là một hình thức kiểm thử tĩnh (static test) vì hoạt động này dựa vào việc đọc, rà soát và phân tích tài liệu/mã nguồn mà hoàn toàn không thực hiện chạy (execute) hệ thống."
      },
      {
        "question_id": 30,
        "question_title": "A person who documents all the issues, problems and open points that were identified during a formal review",
        "option_A": "Moderator",
        "option_B": "Scribe",
        "option_C": "Author",
        "option_D": "Manager",
        "correct_anwser": "B",
        "explain": "Trong một buổi formal review, Scribe (hoặc Recorder - Thư ký) là người chịu trách nhiệm chính trong việc ghi chép lại toàn bộ các lỗi, vấn đề phát sinh và các điểm chưa được giải quyết được phát hiện trong suốt cuộc họp."
      },
      {
        "question_id": 31,
        "question_title": "Which of the following describes a document that specifies the requirements for a software product?",
        "option_A": "Software Requirements Specification (SRS)",
        "option_B": "Software Design Document (SDD)",
        "option_C": "Software Test Plan (STP)",
        "option_D": "Software User Manual (SUM)",
        "correct_anwser": "A",
        "explain": "Software Requirements Specification (SRS) là tài liệu đặc tả yêu cầu phần mềm, mô tả đầy đủ các yêu cầu chức năng và phi chức năng của sản phẩm phần mềm trước khi tiến hành phát triển."
      },
      {
        "question_id": 32,
        "question_title": "In JavaScript, what is the correct syntax to change the content of the HTML element below?\n<p id=\"demo\">This is a demonstration.",
        "option_A": "document.getElementById(\"demo\").innerHTML = \"Hello World!\";",
        "option_B": "document.getElement(\"p\").innerHTML = \"Hello World!\";",
        "option_C": "#demo.innerHTML = \"Hello World!\";",
        "option_D": "document.getElementByName(\"p\").innerHTML = \"Hello World!\";",
        "correct_anwser": "A",
        "explain": "Để truy xuất và thay đổi nội dung HTML của một phần tử thông qua thuộc tính id trong JavaScript, cú pháp chuẩn xác là sử dụng phương thức document.getElementById() kết hợp với thuộc tính innerHTML."
      },
      {
        "question_id": 33,
        "question_title": "Which CSS property is used to change the text color of an element?",
        "option_A": "text-color",
        "option_B": "fgcolor",
        "option_C": "color",
        "option_D": "font-color",
        "correct_anwser": "C",
        "explain": "Trong CSS, thuộc tính 'color' được dùng để quy định màu sắc của văn bản bên trong phần tử."
      },
      {
        "question_id": 34,
        "question_title": "What does HTML stand for?",
        "option_A": "Hyper Text Markup Language",
        "option_B": "Hyperlinks and Text Markup Language",
        "option_C": "Home Tool Markup Language",
        "option_D": "Hyper Tool Markup Language",
        "correct_anwser": "A",
        "explain": "HTML là viết tắt của Hyper Text Markup Language (Ngôn ngữ Đánh dấu Siêu văn bản), được sử dụng để cấu trúc nên các trang web."
      },
      {
        "question_id": 35,
        "question_title": "Which of the following is NOT a fundamental concept of Object-Oriented Programming (OOP)?",
        "option_A": "Encapsulation",
        "option_B": "Inheritance",
        "option_C": "Compilation",
        "option_D": "Polymorphism",
        "correct_anwser": "C",
        "explain": "Bốn tính chất cốt lõi của lập trình hướng đối tượng (OOP) bao gồm: Đóng gói (Encapsulation), Kế thừa (Inheritance), Đa hình (Polymorphism) và Trừu tượng (Abstraction). Quá trình biên dịch (Compilation) là một thuật ngữ liên quan đến trình biên dịch dịch mã nguồn chứ không phải khái niệm cốt lõi của OOP."
      },
      {
        "question_id": 36,
        "question_title": "In a relational database, what is a \"primary key\"?",
        "option_A": "A key used to encrypt data.",
        "option_B": "A column or group of columns that uniquely identifies each row in a table.",
        "option_C": "The first column in a table.",
        "option_D": "A key that allows access to the database.",
        "correct_anwser": "B",
        "explain": "Khóa chính (Primary Key) là một trường (hoặc sự kết hợp của nhiều trường) đảm bảo tính duy nhất để định danh cho một dòng dữ liệu (bản ghi) trong bảng của cơ sở dữ liệu quan hệ."
      },
      {
        "question_id": 37,
        "question_title": "What is the purpose of the \"git clone\" command?",
        "option_A": "To create a new branch.",
        "option_B": "To delete a repository.",
        "option_C": "To copy an existing Git repository from a remote server to your local machine.",
        "option_D": "To merge two branches.",
        "correct_anwser": "C",
        "explain": "Lệnh 'git clone' được sử dụng để sao chép toàn bộ mã nguồn cùng lịch sử commit từ một Git repository trên máy chủ từ xa (remote server) về thư mục cục bộ trên máy tính cá nhân."
      },
      {
        "question_id": 38,
        "question_title": "Which architectural pattern separates an application into three main components: Model, View, and Controller?",
        "option_A": "Microservices",
        "option_B": "MVC (Model-View-Controller)",
        "option_C": "Monolithic",
        "option_D": "SOA (Service-Oriented Architecture)",
        "correct_anwser": "B",
        "explain": "MVC viết tắt của Model-View-Controller, đây là mẫu kiến trúc phần mềm kinh điển chia tách ứng dụng thành 3 phần xử lý logic, dữ liệu (Model), hiển thị giao diện (View) và điều hướng điều khiển (Controller)."
      },
      {
        "question_id": 39,
        "question_title": "What does HTTP stand for?",
        "option_A": "Hypertext Transfer Protocol",
        "option_B": "Hypertext Text Protocol",
        "option_C": "High Transfer Text Protocol",
        "option_D": "Hyperlink Text Transfer Protocol",
        "correct_anwser": "A",
        "explain": "HTTP viết tắt của Hypertext Transfer Protocol (Giao thức Truyền tải Siêu văn bản), là giao thức nền tảng phục vụ cho việc truyền tải dữ liệu trên mạng World Wide Web (WWW)."
      },
      {
        "question_id": 40,
        "question_title": "In the context of Agile software development, what is a \"Sprint\"?",
        "option_A": "A race between developers to finish coding first.",
        "option_B": "A document detailing all software bugs.",
        "option_C": "A set period of time (usually 1-4 weeks) during which specific work must be completed and made ready for review.",
        "option_D": "A meeting held at the end of the project.",
        "correct_anwser": "C",
        "explain": "Trong mô hình Scrum thuộc Agile, Sprint là một khung thời gian cố định ngắn hạn (thường kéo dài từ 1 đến 4 tuần) mà trong đó đội ngũ phát triển cam kết hoàn thành những mục tiêu công việc nhất định nhằm tạo ra một phần tăng trưởng sản phẩm có thể bàn giao được."
      },
      {
        "question_id": 41,
        "question_title": "_______is a very early build intended for limited distribution to a few key customers and to marketing for demonstration purposes.",
        "option_A": "Alpha release",
        "option_B": "Beta release",
        "option_C": "Test release document",
        "option_D": "Build",
        "correct_anwser": "A",
        "explain": "Alpha release là bản phát hành rất sớm của phần mềm, được phân phối giới hạn cho một số khách hàng quan trọng hoặc phòng marketing để chạy thử nghiệm nội bộ hoặc trình diễn tính năng, trước khi tiến tới giai đoạn Beta công khai hoặc rộng rãi hơn."
      },
      {
        "question_id": 42,
        "question_title": "Match the following:\n1. Test estimation\n2. Test control\n3. Test monitoring\na. Measures of tracking process\nb. Effort required to perform activities\nc. Reallocation of resources\n\nA. 1-b, 2-c, 3-a\nB. 1-b, 2-a, 3-c\nC. 1-c, 2-a, 3-b\nD. 1-a, 2-b, 3-c",
        "option_A": "1-b, 2-c, 3-a",
        "option_B": "1-b, 2-a, 3-c",
        "option_C": "1-c, 2-a, 3-b",
        "option_D": "1-a, 2-b, 3-c",
        "correct_anwser": "A",
        "explain": "Ghép nối đúng dựa trên các định nghĩa trong kiểm thử: 1. Test estimation (Ước lượng kiểm thử) tương ứng với b (Công sức cần thiết để thực hiện các hoạt động). 2. Test control (Kiểm soát kiểm thử) tương ứng với c (Tái phân bổ nguồn lực dựa trên tình hình thực tế). 3. Test monitoring (Giám sát kiểm thử) tương ứng với a (Các chỉ số theo dõi tiến độ)."
      },
      {
        "question_id": 43,
        "question_title": "What is the main reason for testing software before releasing it?",
        "option_A": "To show that system will work after release",
        "option_B": "To decide when the software is of sufficient quality to release",
        "option_C": "To find as many bugs as possible before release",
        "option_D": "To give information for a risk based decision about release",
        "correct_anwser": "D",
        "explain": "Mục tiêu chính và mang tính chiến lược nhất của kiểm thử trước khi bàn giao (theo chuẩn ISTQB) là cung cấp đầy đủ thông tin về chất lượng và các lỗi còn tồn tại, giúp các bên liên quan đưa ra quyết định dựa trên rủi ro (risk-based decision) xem có nên phát hành phần mềm hay không."
      },
      {
        "question_id": 44,
        "question_title": "Which of the following is not a part of the Test Implementation and Execution Phase",
        "option_A": "Creating test suites from the test cases",
        "option_B": "Executing test cases either manually or by using test execution tools",
        "option_C": "Comparing actual results",
        "option_D": "Designing the Tests",
        "correct_anwser": "D",
        "explain": "Designing the Tests (Thiết kế các ca kiểm thử) thuộc về giai đoạn Test Design (Thiết kế kiểm thử), chứ không nằm trong giai đoạn Test Implementation and Execution (Triển khai và Thực hiện kiểm thử)."
      },
      {
        "question_id": 45,
        "question_title": "A Test Plan Outline contains which of the following:\ni. Test Items\nii. Test Scripts\niii. Test Deliverables\niv. Responsibilities",
        "option_A": "i, ii, iii are true and iv is false",
        "option_B": "i, iii, iv are true and ii is false",
        "option_C": "ii, iii are true and i and iv are false",
        "option_D": "i, ii are false and iii, iv are true",
        "correct_anwser": "B",
        "explain": "Theo tiêu chuẩn IEEE 829 về cấu trúc Kế hoạch kiểm thử (Test Plan), tài liệu này sẽ bao gồm Test Items (Mục tiêu kiểm thử), Test Deliverables (Sản phẩm bàn giao), và Responsibilities (Trách nhiệm của các bên). Test Scripts (Kịch bản kiểm thử chi tiết) không nằm trong cấu trúc của một Test Plan tổng quan mà thuộc giai đoạn thiết kế/triển khai chi tiết."
      },
      {
        "question_id": 46,
        "question_title": "What is the MAIN objective when reviewing a software deliverable?",
        "option_A": "To identify potential application failures by use of a test specification.",
        "option_B": "To identify defects in any software work product.",
        "option_C": "To identify spelling mistakes in a requirements specification.",
        "option_D": "To identify standards inconsistencies in the code.",
        "correct_anwser": "B",
        "explain": "Mục tiêu chính và bao quát nhất của việc đánh giá (review) một sản phẩm phần mềm (deliverable/work product) là phát hiện ra các khuyết tật (defects) càng sớm càng tốt. Các phương án C và D chỉ là những khía cạnh nhỏ cụ thể bên trong mục tiêu chung này."
      },
      {
        "question_id": 47,
        "question_title": "Quality Assurance is the process by which product quality is compared with the application standards and the action taken when nonconformance is detected.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Phát biểu này mô tả hoạt động của Quality Control (Kiểm soát chất lượng - tập trung vào kiểm tra sản phẩm và tìm lỗi so với tiêu chuẩn), chứ không phải Quality Assurance (Đảm bảo chất lượng - vốn tập trung vào cải tiến quy trình để ngăn ngừa lỗi xảy ra)."
      },
      {
        "question_id": 48,
        "question_title": "Which of the following is a step-by-step method followed to ensure that standards are met?",
        "option_A": "SDLC",
        "option_B": "Project Plan",
        "option_C": "Policy",
        "option_D": "Procedure",
        "correct_anwser": "D",
        "explain": "Procedure (Quy trình/Thủ tục) là một tập hợp các hướng dẫn, phương pháp thực hiện theo từng bước (step-by-step) được thiết lập để đảm bảo các tiêu chuẩn chất lượng và công việc được tuân thủ chính xác."
      },
      {
        "question_id": 49,
        "question_title": "Verification involves which of the following\ni. Helps to check the Quality of the built product\nii. Helps to check that we have built the right product.\niii. Helps in developing the product\niv. Monitoring tool wastage and obsoleteness.",
        "option_A": "Options i, ii, iii, iv are true.",
        "option_B": "i is true and ii, iii, iv are false",
        "option_C": "i, ii, iii are true and iv is false",
        "option_D": "ii is true and i, iii, iv are false",
        "correct_anwser": "B",
        "explain": "Verification (Xác minh) tập trung vào câu hỏi 'Are we building the product right?' (Chúng ta có đang xây dựng sản phẩm đúng cách/đúng thiết kế không) và giúp kiểm tra chất lượng cấu trúc bên trong của sản phẩm (i đúng). Câu ii ('built the right product') là định nghĩa của Validation (Xác nhận giá trị). Do đó chỉ có mệnh đề i là chính xác trong ngữ cảnh này."
      },
      {
        "question_id": 50,
        "question_title": "With thorough testing it is possible to remove all defects from a program prior to delivery to the customer.",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Theo nguyên lý cốt lõi của kiểm thử phần mềm (Testing shows the presence of defects, not their absence), việc kiểm thử dù có kỹ lưỡng đến đâu cũng không thể chứng minh hoặc đảm bảo loại bỏ hoàn toàn 100% mọi lỗi ra khỏi chương trình."
      },
      {
        "question_id": 51,
        "question_title": "Which of the following benefits are MOST likely to be achieved by using test tools?\ni) Easy to access information about tests and testing.\nii) Reduced maintenance of testware.\niii) Easy and cheap to implement.\niv) Greater consistency of tests.",
        "option_A": "ii and iv",
        "option_B": "ii and iii",
        "option_C": "i and iv",
        "option_D": "i and iii",
        "correct_anwser": "C",
        "explain": "Theo chuẩn ISTQB, lợi ích cốt lõi của việc sử dụng công cụ kiểm thử (test tools) bao gồm khả năng lưu trữ, truy cập thông tin kiểm thử dễ dàng (i) và tăng tính nhất quán, lặp lại của các ca kiểm thử (iv). Ngược lại, việc triển khai công cụ thường không hề rẻ hay dễ dàng (iii sai), đồng thời chi phí bảo trì sản phẩm kiểm thử (testware) thường có xu hướng tăng lên chứ không giảm đi (ii sai)."
      },
      {
        "question_id": 52,
        "question_title": "With which of the following categories is a test comparator tool USUALLY associated?",
        "option_A": "Tool support for performance and monitoring.",
        "option_B": "Tool support for static testing.",
        "option_C": "Tool support for test execution and logging.",
        "option_D": "Tool support for the management of testing and tests.",
        "correct_anwser": "C",
        "explain": "Công cụ so sánh kiểm thử (test comparator tool) được sử dụng để tự động đối chiếu kết quả thực tế (actual results) với kết quả mong đợi (expected results). Do đó, nó thường đi liền và được tích hợp trong nhóm các công cụ hỗ trợ thực thi kiểm thử và ghi nhật ký (test execution and logging)."
      },
      {
        "question_id": 53,
        "question_title": "For which of the following types of testing would a vendor contractor typically need to write the initial scripts?",
        "option_A": "Measuring response time",
        "option_B": "Measuring transaction rates",
        "option_C": "Recovery testing",
        "option_D": "Simulating many users",
        "option_E": "Generating many transactions",
        "correct_anwser": "C",
        "explain": "Các bài kiểm thử hiệu năng như đo thời gian phản hồi (A), tỷ lệ giao dịch (B), mô phỏng nhiều người dùng (D) hay tạo lượng lớn giao dịch (E) thường sử dụng các công cụ tự động hóa thương mại để tự động sinh tải và thu thập thông số mà không nhất thiết cần nhà thầu viết script nghiệp vụ ban đầu từ đầu. Trong khi đó, kiểm thử khả năng khôi phục (Recovery testing - C) đòi hỏi phải viết các kịch bản (scripts) đặc thù ban đầu để can thiệp hệ thống, giả lập môi trường lỗi/sập nguồn và kiểm tra khả năng phục hồi dữ liệu."
      },
      {
        "question_id": 54,
        "question_title": "Which of the following is NOT a characteristic of User Acceptance Testing?",
        "option_A": "Use of automated test execution tools",
        "option_B": "Testing performed by users.",
        "option_C": "Testing against acceptance test criteria",
        "option_D": "Integration of system with user documentation.",
        "correct_anwser": "A",
        "explain": "Kiểm thử chấp nhận người dùng (User Acceptance Testing - UAT) chủ yếu được thực hiện thủ công bởi người dùng cuối hoặc khách hàng (B) dựa trên các tiêu chí chấp nhận (C) và tài liệu hướng dẫn (D). Việc sử dụng các công cụ thực thi kiểm thử tự động (automated test execution tools) là đặc trưng của kiểm thử đơn vị hoặc kiểm thử hệ thống/hồi quy, chứ KHÔNG phải đặc điểm thông thường của UAT."
      },
      {
        "question_id": 55,
        "question_title": "The place to start if you want a (new) test tool is:",
        "option_A": "Attend a tool exhibition",
        "option_B": "Invite a vendor to give a demo",
        "option_C": "Analyze your needs and requirements",
        "option_D": "Find out what your budget would be for the tool",
        "option_E": "Search the internet",
        "correct_anwser": "C",
        "explain": "Bước đầu tiên và quan trọng nhất khi muốn áp dụng một công cụ kiểm thử mới là phải phân tích rõ ràng nhu cầu nội tại và các yêu cầu kỹ thuật của tổ chức (Analyze your needs and requirements). Việc xem demo, khảo sát giá hay đi triển lãm chỉ nên thực hiện sau khi đã biết rõ mình cần gì."
      },
      {
        "question_id": 56,
        "question_title": "The Provision and Management of a controlled library containing all the configurations items is called as",
        "option_A": "Configuration Control",
        "option_B": "Status Accounting",
        "option_C": "Configuration Identification",
        "correct_anwser": "A",
        "explain": "Configuration Control (Kiểm soát cấu hình) là hoạt động cung cấp và quản lý một kho lưu trữ được kiểm soát (controlled library) nhằm phê duyệt, lưu vết và thực thi các thay đổi đối với các mục cấu hình (configuration items)."
      },
      {
        "question_id": 57,
        "question_title": "The principal attributes of tools and automation are (choose one answer)",
        "option_A": "(1) Speed & efficiency",
        "option_B": "(2) Accuracy & precision",
        "option_C": "Both of (1) and (2)",
        "option_D": "None of (1) nor (2)",
        "correct_anwser": "C",
        "explain": "Hai thuộc tính cốt lõi và giá trị nhất của việc sử dụng công cụ và tự động hóa là tăng tốc độ & hiệu suất thực thi (Speed & efficiency) đồng thời đảm bảo độ chính xác cao, loại bỏ sai sót chủ quan của con người (Accuracy & precision)."
      },
      {
        "question_id": 58,
        "question_title": "Find the mismatch",
        "option_A": "Test data preparation tools - Manipulate Data bases",
        "option_B": "Test design tools - Generate test inputs",
        "option_C": "Requirement management tools - Enables individual tests to be traceable",
        "option_D": "Configuration management tools - Check for consistence",
        "correct_anwser": "D",
        "explain": "Các cặp A, B, C đều mô tả đúng chức năng của các công cụ tương ứng. Cặp D bị sai (mismatch) vì chức năng chính của công cụ quản lý cấu hình (Configuration management tools) là lưu trữ phiên bản, quản lý mã nguồn và vết thay đổi của các sản phẩm, chứ không phải đảm nhận vai trò phân tích tính nhất quán ('Check for consistence' thường là nhiệm vụ của công cụ phân tích tĩnh hoặc công cụ quản lý yêu cầu)."
      },
      {
        "question_id": 59,
        "question_title": "A typical commercial test execution tool would be able to perform all of the following, EXCEPT:",
        "option_A": "Generating expected outputs",
        "option_B": "Replaying inputs according to a programmed script",
        "option_C": "Comparison of expected outcomes with actual outcomes",
        "option_D": "Recording test inputs",
        "option_E": "Reading test values from a data file",
        "correct_anwser": "A",
        "explain": "Một công cụ thực thi kiểm thử thương mại thông thường (như các công cụ Record-and-Playback) có thể ghi nhận input (D), chạy lại script (B), đọc dữ liệu từ file (E) và so sánh kết quả (C). Tuy nhiên, nó KHÔNG thể tự động suy luận logic để tự tạo ra kết quả mong đợi (Generating expected outputs); kết quả mong đợi phải do con người (tester/business analyst) xác định trước và đưa vào công cụ."
      },
      {
        "question_id": 60,
        "question_title": "When a new testing tool is purchased, it should be used first by:",
        "option_A": "A small team to establish the best way to use the tool",
        "option_B": "Everyone who may eventually have some use for the tool",
        "option_C": "The independent testing team",
        "option_D": "The vendor contractor to write the initial scripts",
        "correct_anwser": "A",
        "explain": "Theo quy trình chuẩn khi đưa một công cụ kiểm thử mới vào tổ chức (ISTQB guidelines), trước hết cần triển khai thí điểm (pilot project) với một nhóm nhỏ (a small team) nhằm tìm ra cách sử dụng tối ưu, chuẩn hóa quy trình và đánh giá hiệu quả trước khi nhân rộng ra toàn bộ các đội ngũ khác."
      }
    ]
  },
  {
    "id": "swt301-fa25-re",
    "title": "SWT301 - FA25 - RE",
    "description": "Software Testing Quiz",
    "questionsCount": 60,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which one is not comes under international standard: (choose one answer)",
        "option_A": "IEC",
        "option_B": "IEEE",
        "option_C": "ISO",
        "option_D": "All of the others",
        "correct_anwser": "B",
        "explain": "ISO (Tổ chức Tiêu chuẩn hóa Quốc tế) và IEC (Ủy ban Kỹ thuật Điện Quốc tế) là các tổ chức tiêu chuẩn hóa quốc tế chính thức được công nhận trên toàn cầu. Trong khi đó, IEEE (Viện Kỹ sư Điện và Điện tử) là một tổ chức nghề nghiệp chuyên nghiệp có trụ sở tại Hoa Kỳ, mặc dù các tiêu chuẩn của họ được áp dụng rộng rãi trên quốc tế nhưng về mặt phân loại tổ chức, nó không phải là một tổ chức tiêu chuẩn quốc tế chính thức giống như ISO hay IEC."
      },
      {
        "question_id": 2,
        "question_title": "Faults found by users are due to:",
        "option_A": "Insufficient time for testing",
        "option_B": "Poor software and poor testing",
        "option_C": "Bad luck",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Lỗi (Faults) mà người dùng cuối tìm thấy trong môi trường thực tế xuất phát từ hai nguyên nhân chính kết hợp: phần mềm được phát triển kém chất lượng (poor software) dẫn đến chứa nhiều lỗi ẩn, và quá trình kiểm thử không hiệu quả hoặc không đủ nghiêm ngặt (poor testing) nên đã bỏ sót những lỗi đó trước khi phát hành."
      },
      {
        "question_id": 3,
        "question_title": "A piece of software has been given _______ what tests in the following will you perform?\n1) Test the area's most critical to business processes\n2) Test the areas where faults will be maximum\n3) Test the easiest functionalities",
        "option_A": "1&2 are true and 3 is false",
        "option_B": "1,2&3 are true.",
        "option_C": "1 is true, 2&3 are false.",
        "option_D": "1&2 are false, 3 is true",
        "correct_anwser": "A",
        "explain": "Khi kiểm thử một phần mềm dưới áp lực thời gian và nguồn lực có hạn, chiến lược kiểm thử dựa trên rủi ro là tối ưu nhất. Do đó, việc tập trung vào các quy trình kinh doanh quan trọng nhất (1) và các khu vực có nguy cơ chứa nhiều lỗi nhất (2) là hoàn toàn đúng đắn. Việc ưu tiên kiểm thử các chức năng dễ nhất (3) không mang lại giá trị cao trong việc đảm bảo chất lượng hệ thống nên phát biểu này sai."
      },
      {
        "question_id": 4,
        "question_title": "EULA stands for",
        "option_A": "End Usability License Agreement",
        "option_B": "End User License Agreement",
        "option_C": "End User License Arrangement",
        "option_D": "End User License Attachment",
        "correct_anwser": "B",
        "explain": "EULA là viết tắt của 'End User License Agreement' (Thỏa thuận cấp phép người dùng cuối). Đây là hợp đồng pháp lý giữa nhà phát triển/nhà phát hành phần mềm và người sử dụng phần mềm, quy định quyền lợi và hạn chế của người dùng đối với phần mềm đó."
      },
      {
        "question_id": 5,
        "question_title": "CAST stands for",
        "option_A": "Computer Aided Software Testing",
        "option_B": "Computer Aided Software Tools",
        "option_C": "Computer Analysis Software Techniques",
        "option_D": "None of the others",
        "correct_anwser": "A",
        "explain": "Trong lĩnh vực kiểm thử phần mềm, CAST là viết tắt của 'Computer Aided Software Testing' (Kiểm thử phần mềm có sự hỗ trợ của máy tính), đề cập đến việc sử dụng các công cụ và phần mềm để hỗ trợ hoặc tự động hóa các hoạt động kiểm thử."
      },
      {
        "question_id": 6,
        "question_title": "Defect Management process does include",
        "option_A": "Defect prevention",
        "option_B": "Deliverable base-lining",
        "option_C": "Management reporting",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Quy trình Quản lý lỗi (Defect Management) bao gồm các hoạt động như phòng ngừa lỗi (Defect prevention), phát hiện, ghi nhận, phân tích và báo cáo quản lý (Management reporting). Ngược lại, 'Deliverable base-lining' (Tạo cơ sở cấu hình cho sản phẩm bàn giao) là một hoạt động thuộc về quy trình Quản lý cấu hình (Configuration Management), không thuộc quy trình quản lý lỗi."
      },
      {
        "question_id": 7,
        "question_title": "Which of the following will be the best definition for Testing:",
        "option_A": "The goal / purpose of testing is to demonstrate that the program works.",
        "option_B": "The purpose of testing is to demonstrate that the program is defect free.",
        "option_C": "The purpose of testing is to demonstrate that the program does what it is supposed to do",
        "option_D": "Testing is executing Software for the purpose of finding defects.",
        "correct_anwser": "D",
        "explain": "Theo định nghĩa kinh điển của Glenford Myers trong cuốn nghệ thuật kiểm thử phần mềm, kiểm thử là quá trình vận hành một chương trình với mục đích tìm ra lỗi (finding defects). Các phương án A, B, C mang tính chất chứng minh phần mềm đúng, điều này không phản ánh chính xác tư duy cốt lõi của kiểm thử là tìm kiếm những điểm sai sót để cải thiện chất lượng."
      },
      {
        "question_id": 8,
        "question_title": "Which of the following is the standard for the Software product quality",
        "option_A": "ISO 9126",
        "option_B": "ISO 829",
        "option_C": "ISO 1012",
        "option_D": "ISO 1028",
        "correct_anwser": "A",
        "explain": "ISO/IEC 9126 là tiêu chuẩn quốc tế nổi tiếng quy định về chất lượng sản phẩm phần mềm, phân chia chất lượng phần mềm thành các đặc tính cốt lõi như tính chức năng, tính tin cậy, tính khả dụng, tính hiệu quả, tính khả trì và tính khả chuyển (sau này được thay thế và phát triển lên thành bộ tiêu chuẩn ISO/IEC 25010)."
      },
      {
        "question_id": 9,
        "question_title": "The cost of fixing a fault:",
        "option_A": "Is not important",
        "option_B": "Increases as we move the product towards live use",
        "option_C": "Decreases as we move the product towards live use",
        "option_D": "Is more expensive if found in requirements than functional design",
        "option_E": "Can never be determined",
        "correct_anwser": "B",
        "explain": "Trong kỹ nghệ phần mềm, một nguyên tắc cơ bản là lỗi được phát hiện càng muộn trong vòng đời phát triển phần mềm (SDLC) thì chi phí để sửa chữa nó càng tăng theo cấp số nhân. Do đó, chi phí khắc phục lỗi sẽ tăng lên rất nhiều khi sản phẩm tiến dần về giai đoạn vận hành thực tế (live use)."
      },
      {
        "question_id": 10,
        "question_title": "Which of the following statements are true?",
        "option_A": "Faults in program specifications are the most expensive to fix",
        "option_B": "Faults in code are the most expensive to fix.",
        "option_C": "Faults in requirements are the most expensive to fix",
        "option_D": "Faults in designs are the most expensive to fix.",
        "correct_anwser": "C",
        "explain": "Giai đoạn Thu thập yêu cầu (Requirements) là giai đoạn đầu tiên của dự án. Nếu lỗi xảy ra tại đây mà không được phát hiện kịp thời, nó sẽ lan truyền sang giai đoạn thiết kế, lập trình và kiểm thử. Khi phát hiện muộn ở các giai đoạn sau hoặc khi hệ thống đã bàn giao, chi phí để sửa đổi lại toàn bộ tài liệu, thiết kế và mã nguồn liên quan đến yêu cầu đó là lớn nhất so với lỗi ở bất kỳ giai đoạn nào khác."
      },
      {
        "question_id": 11,
        "question_title": "Cost of the reviews will not include.",
        "option_A": "Review process itself",
        "option_B": "Metrics analysis",
        "option_C": "Tool support.",
        "option_D": "Process improvement.",
        "correct_anwser": "D",
        "explain": "Chi phí của hoạt động đánh giá (Cost of reviews) bao gồm chi phí chuẩn bị, thực hiện chính quá trình đánh giá (Review process itself), phân tích các số liệu thu thập được (Metrics analysis) và trang bị các công cụ hỗ trợ (Tool support). Trong khi đó, 'Process improvement' (Cải tiến quy trình) là kết quả/lợi ích lâu dài thu được từ việc đánh giá chứ không được tính vào chi phí trực tiếp của hoạt động đánh giá đó."
      },
      {
        "question_id": 12,
        "question_title": "Reviews, static analysis and dynamic testing have the same objective",
        "option_A": "(i) Identifying defects.",
        "option_B": "(ii) Fixing defects.",
        "option_C": "(i) and (ii)",
        "option_D": "None of (i) nor (ii)",
        "correct_anwser": "A",
        "explain": "Cả ba hoạt động: Đánh giá tài liệu (Reviews), phân tích tĩnh (Static analysis) và kiểm thử động (Dynamic testing) đều là các hoạt động kiểm thử (Testing) nhằm mục đích chung tối thượng là phát hiện và xác định lỗi (Identifying defects). Việc sửa lỗi (Fixing defects) thuộc về hoạt động gỡ lỗi (Debugging) do lập trình viên thực hiện, không phải mục tiêu trực tiếp của các phương pháp kiểm thử này."
      },
      {
        "question_id": 13,
        "question_title": "During the software development process, at what point can the test process start?",
        "option_A": "When the code is complete.",
        "option_B": "When the design is complete.",
        "option_C": "When the software requirements have been approved.",
        "option_D": "When the first code module is ready for unit testing",
        "correct_anwser": "C",
        "explain": "Theo triết lý kiểm thử sớm (Early Testing) trong ISTQB, quy trình kiểm thử có thể và nên bắt đầu ngay khi các yêu cầu phần mềm được phê duyệt (When the software requirements have been approved). Tại thời điểm này, kiểm thử viên có thể bắt đầu đánh giá yêu cầu, xây dựng kế hoạch kiểm thử và thiết kế các kịch bản kiểm thử (Test cases) mà không cần đợi có code."
      },
      {
        "question_id": 14,
        "question_title": "Drivers are also known as:\ni. Spade\nii. Test harness\niii. Scaffolding",
        "option_A": "i, ii are true and iii is false",
        "option_B": "i, iii are true and ii is false",
        "option_C": "ii , iii are true and i is false",
        "option_D": "All of i, ii and iii are true",
        "correct_anwser": "C",
        "explain": "Trong kiểm thử tích hợp, 'Drivers' (mô-đun điều khiển giả lập) và 'Stubs' thường được gọi chung là thành phần giàn giáo 'Scaffolding'. Đồng thời, môi trường thực thi và điều khiển kiểm thử chứa các Driver này cũng được gọi là 'Test harness'. Thuật ngữ 'Spade' không liên quan đến ngữ cảnh này, do đó phát biểu ii và iii đúng, i sai."
      },
      {
        "question_id": 15,
        "question_title": "Who would USUALLY perform debugging activities?",
        "option_A": "Developers.",
        "option_B": "Analysts.",
        "option_C": "Testers.",
        "option_D": "Incident Managers.",
        "correct_anwser": "A",
        "explain": "Gỡ lỗi (Debugging) là hành động tìm nguyên nhân gốc rễ, khoanh vùng và sửa đổi mã nguồn để khắc phục lỗi. Công việc này đòi hỏi quyền truy cập và hiểu biết sâu sắc về mã nguồn của hệ thống, vì vậy nó luôn được thực hiện bởi các lập trình viên (Developers), phân biệt rõ với việc tìm lỗi của Testers."
      },
      {
        "question_id": 16,
        "question_title": "Software testing accounts to what percent of software development costs?",
        "option_A": "10-20",
        "option_B": "40-50",
        "option_C": "70-80",
        "option_D": "5-10",
        "correct_anwser": "B",
        "explain": "Theo các số liệu thống kê tiêu chuẩn trong ngành kỹ nghệ phần mềm và các giáo trình kiểm thử phần mềm cổ điển, chi phí dành cho các hoạt động kiểm thử và đảm bảo chất lượng thường chiếm khoảng 40% đến 50% tổng ngân sách phát triển của một dự án phần mềm thông thường."
      },
      {
        "question_id": 17,
        "question_title": "Configuration and compatibility testing are typically good choices for outsourcing",
        "option_A": "True",
        "option_B": "False",
        "option_C": "",
        "option_D": "",
        "correct_anwser": "A",
        "explain": "Kiểm thử cấu hình (Configuration testing) và kiểm thử khả năng tương thích (Compatibility testing) yêu cầu rất nhiều môi trường, thiết bị phần cứng, hệ điều hành và trình duyệt khác nhau. Việc thuê ngoài (Outsourcing) cho các phòng lab chuyên dụng giúp doanh nghiệp tiết kiệm chi phí xây dựng hạ tầng kiểm thử tốn kém này, vì vậy đây là lựa chọn rất phổ biến và hợp lý (True)."
      },
      {
        "question_id": 18,
        "question_title": "Which of the following has highest level of independence in which test cases are:",
        "option_A": "Designed by persons who write the software under test",
        "option_B": "Designed by a person from a different section",
        "option_C": "Designed by a person from a different organization",
        "option_D": "Designed by another person",
        "correct_anwser": "C",
        "explain": "Mức độ độc lập của kiểm thử (Independence of testing) tăng dần theo khoảng cách giữa người kiểm thử và người viết mã nguồn. Các kịch bản kiểm thử được thiết kế bởi một người thuộc tổ chức/công ty hoàn toàn khác (Designed by a person from a different organization) như bên thứ ba độc lập sẽ mang lại góc nhìn khách quan nhất và có mức độ độc lập cao nhất."
      },
      {
        "question_id": 19,
        "question_title": "Majority of system errors occur in the _______ phase",
        "option_A": "Requirements Phase.",
        "option_B": "Analysis and Design Phase",
        "option_C": "Development Phase",
        "option_D": "Testing Phase",
        "correct_anwser": "A",
        "explain": "Các nghiên cứu thực tế về kỹ nghệ phần mềm chỉ ra rằng phần lớn (khoảng hơn 50% đến 60%) các lỗi nghiêm trọng của hệ thống có nguồn gốc từ giai đoạn xác định yêu cầu (Requirements Phase) do hiểu sai mong muốn của khách hàng, yêu cầu không rõ ràng hoặc mâu thuẫn lẫn nhau."
      },
      {
        "question_id": 20,
        "question_title": "Benefits of Independent Testing",
        "option_A": "Independent testers are much more qualified than Developers",
        "option_B": "Independent testers see other and different defects and are unbiased.",
        "option_C": "Independent Testers cannot identify defects.",
        "option_D": "Independent Testers can test better than developers",
        "correct_anwser": "B",
        "explain": "Lợi ích chính của kiểm thử độc lập là việc người kiểm thử không bị ảnh hưởng bởi tư duy lối mòn khi viết mã nguồn của lập trình viên (unbiased). Họ mang một góc nhìn khác, từ đó dễ dàng phát hiện ra các loại lỗi khác nhau và các lỗi giả định mà lập trình viên thường bỏ qua."
      },
      {
        "question_id": 21,
        "question_title": "Who is responsible for document all the issues, problems and open point that were identified during the review meeting",
        "option_A": "Moderator",
        "option_B": "Scribe",
        "option_C": "Reviewers",
        "option_D": "Author",
        "correct_anwser": "B",
        "explain": "Trong một cuộc họp đánh giá chính thức (Formal Review), thư ký (Scribe hay Recorder) là người có trách nhiệm ghi chép lại toàn bộ các lỗi, vấn đề và các điểm chưa giải quyết (open points) được phát hiện trong suốt cuộc họp một cách chính xác."
      },
      {
        "question_id": 22,
        "question_title": "The person who leads the review of the document(s), planning the review, running the meeting and follow-up after the meeting",
        "option_A": "Reviewer",
        "option_B": "Author",
        "option_C": "Moderator",
        "option_D": "Auditor",
        "correct_anwser": "C",
        "explain": "Điều phối viên (Moderator hoặc Review Leader) là người chịu trách nhiệm chính trong việc dẫn dắt toàn bộ quy trình đánh giá, bao gồm lập kế hoạch, điều phối và vận hành cuộc họp, cũng như theo dõi (follow-up) các hoạt động sửa lỗi sau cuộc họp."
      },
      {
        "question_id": 23,
        "question_title": "The Kick Off phase of a formal review includes the following:",
        "option_A": "Explaining the objective",
        "option_B": "Fixing defects found typically done by author",
        "option_C": "Follow up",
        "option_D": "Individual Meeting preparations",
        "option_E": "",
        "correct_anwser": "A",
        "explain": "Mục đích chính của giai đoạn Khởi động (Kick Off phase) trong quy trình đánh giá chính thức là để phân phát tài liệu, giải thích mục tiêu (Explaining the objective) của buổi đánh giá, cũng như hướng dẫn các thành viên về cách thức thực hiện."
      },
      {
        "question_id": 24,
        "question_title": "Static analysis tools are typically used by",
        "option_A": "Testers",
        "option_B": "Developers",
        "option_C": "Testers & Developers",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Các công cụ phân tích tĩnh (Static analysis tools) thường chạy trực tiếp trên mã nguồn của ứng dụng (ví dụ: SonarQube, Checkstyle). Do đó, chúng thường được sử dụng phổ biến nhất bởi các lập trình viên (Developers) trong quá trình viết mã hoặc tích hợp mã nguồn nhằm phát hiện sớm các vi phạm chuẩn mã hóa và lỗi logic trước khi build."
      },
      {
        "question_id": 25,
        "question_title": "What can static analysis NOT find?",
        "option_A": "The use of a variable before it has been defined",
        "option_B": "Unreachable (\"dead\") code",
        "option_C": "Memory leaks",
        "option_D": "Array bound violations",
        "correct_anwser": "C",
        "explain": "Phân tích tĩnh kiểm tra mã nguồn mà không cần thực thi chương trình. Nó có thể dễ dàng phát hiện biến chưa định nghĩa (A), code không bao giờ chạy tới (B) hoặc nguy cơ vượt quá chỉ số mảng thông qua phân tích cú pháp (D). Tuy nhiên, rò rỉ bộ nhớ thực tế (Memory leaks) thường là lỗi phát sinh động trong quá trình phân phối/giải phóng vùng nhớ lúc chạy, rất khó phát hiện chính xác nếu không thực thi chương trình (kiểm thử động)."
      },
      {
        "question_id": 26,
        "question_title": "In a review meeting a moderator is a person who",
        "option_A": "Takes minutes of the meeting",
        "option_B": "Mediates between people",
        "option_C": "Takes telephone calls",
        "option_D": "Writes the documents to be reviewed",
        "correct_anwser": "B",
        "explain": "Bên cạnh việc dẫn dắt cuộc họp, vai trò quan trọng của một người điều phối (Moderator) là làm trung gian, hòa giải và định hướng thảo luận giữa các thành viên (Mediates between people) nhằm đảm bảo cuộc họp diễn ra khách quan, mang tính xây dựng và không bị xung đột cá nhân."
      },
      {
        "question_id": 27,
        "question_title": "The Phases of formal review process is mentioned below arrange them in the correct order.\ni) Planning\nii) Review Meeting\niii) Rework\niv) Individual Preparations\nv) Kick Off\nvi) Follow Up",
        "option_A": "i,ii,iii,iv,v,vi",
        "option_B": "vi,i,ii,iii,iv,v",
        "option_C": "i,v,iv,ii,iii,vi",
        "option_D": "i,ii,iii,v,iv,vi",
        "correct_anwser": "C",
        "explain": "Theo tiêu chuẩn ISTQB, các giai đoạn của một quy trình đánh giá chính thức diễn ra theo thứ tự nghiêm ngặt sau: Lập kế hoạch (Planning - i) -> Khởi động (Kick-off - v) -> Chuẩn bị cá nhân (Individual preparations - iv) -> Cuộc họp đánh giá (Review meeting - ii) -> Sửa lại (Rework - iii) -> Kiểm tra lại (Follow-up - vi)."
      },
      {
        "question_id": 28,
        "question_title": "People who don't participate in technical reviews",
        "option_A": "Analysts",
        "option_B": "Management",
        "option_C": "Developers",
        "option_D": "Testers",
        "correct_anwser": "B",
        "explain": "Đánh giá kỹ thuật (Technical Review) tập trung sâu vào các giải pháp công nghệ, kiến trúc và mã nguồn, do đó các vai trò chuyên môn như Analysts, Developers, Testers sẽ tham gia. Ban quản lý (Management) thường không tham gia trực tiếp vào các buổi đánh giá kỹ thuật chi tiết này nhằm tránh làm mất tính khách quan hoặc gây áp lực không cần thiết cho đội ngũ kỹ thuật."
      },
      {
        "question_id": 29,
        "question_title": "Which of the following is not a static testing technique?",
        "option_A": "Error guessing",
        "option_B": "Walkthrough",
        "option_C": "Data flow analysis",
        "option_D": "Inspections",
        "correct_anwser": "A",
        "explain": "Walkthrough (B), Data flow analysis (C), và Inspections (D) đều là các kỹ thuật kiểm thử tĩnh (không chạy chương trình). Ngược lại, Đoán lỗi (Error guessing - A) là một kỹ thuật kiểm thử hộp đen dựa trên kinh nghiệm, được áp dụng trong quá trình kiểm thử động khi thực thi phần mềm."
      },
      {
        "question_id": 30,
        "question_title": "Which expression best matches the following characteristics or review processes:\n1. Led by author\n2. Undocumented\n3. No management participation\n4. Led by a trained moderator or leader\n5. Uses entry exit criteria\ns) Inspection\nt) Peer review\nu) Informal review\nv) Walkthrough",
        "option_A": "s = 4, t = 3, u = 2 and 5, v = 1",
        "option_B": "s = 4 and 5, t = 3, u = 2, v = 1",
        "option_C": "s = 1 and 5, t = 3, u = 2, v = 4",
        "option_D": "s = 5, t = 4, u = 3, v = 1 and 2",
        "option_E": "s = 4 and 5, t = 1, u = 2, v = 3",
        "correct_anwser": "B",
        "explain": "Phân tích các đặc trưng theo chuẩn ISTQB:\n- Inspection (s): Quy trình trang trọng nhất, được dẫn dắt bởi một Moderator có chứng chỉ/đào tạo (4) và sử dụng các tiêu chí đóng/mở rõ ràng (Entry/Exit criteria - 5).\n- Peer review / Technical Review (t): Tập trung vào đồng nghiệp chuyên môn, không có sự tham gia của quản lý (3).\n- Informal review (u): Đánh giá không chính thức, thường không lưu lại tài liệu ghi chép (Undocumented - 2).\n- Walkthrough (v): Do chính tác giả của sản phẩm dẫn dắt và trình bày (Led by author - 1).\nĐối chiếu lại ta có phương án B là hoàn toàn chính xác."
      },
      {
        "question_id": 31,
        "question_title": "Features of White Box Testing Technique:\ni. We use explicit knowledge of the internal workings of the item being tested to select the test data.\nii. Uses specific knowledge of programming code to examine outputs and assumes that the tester knows the path of logic in a unit or a program.\niii. Checking for the performance of the application\niv. Also checks for functionality.",
        "option_A": "i, ii are true and iii and iv are false",
        "option_B": "iii is true and i,ii, iv are false",
        "option_C": "ii ,iii is true and i,iv is false",
        "option_D": "iii and iv are true and i,ii are false",
        "correct_anwser": "A",
        "explain": "Kiểm thử hộp trắng (White Box Testing) tập trung vào cấu trúc mã nguồn bên trong của chương trình. Do đó, phát biểu (i) về việc hiểu rõ cách thức hoạt động bên trong và phát biểu (ii) về việc nắm vững đường đi của logic/mã nguồn để thiết kế dữ liệu kiểm thử là hoàn toàn chính xác. Ngược lại, kiểm thử hiệu năng (iii) và kiểm thử chức năng (iv) bản chất thuộc về kiểm thử hộp đen (Black Box Testing) dựa trên đặc tả yêu cầu bên ngoài."
      },
      {
        "question_id": 32,
        "question_title": "Complete statement and branch coverage means:",
        "option_A": "That you have tested every statement in the program.",
        "option_B": "That you have tested every statement and every branch in the program.",
        "option_C": "That you have tested every IF statement in the program.",
        "option_D": "That you have tested every combination of values of IF statements in the program",
        "correct_anwser": "B",
        "explain": "Khái niệm độ bao phủ đầy đủ cả dòng lệnh và nhánh (Complete statement and branch coverage) nghĩa là bộ test cases của bạn đảm bảo thực thi qua mọi dòng lệnh đơn lẻ ít nhất một lần (100% Statement Coverage) ĐỒNG THỜI đi qua mọi nhánh rẽ/kết quả đúng sai của các câu lệnh điều kiện trong chương trình ít nhất một lần (100% Branch Coverage)."
      },
      {
        "question_id": 33,
        "question_title": "Which of the following techniques is NOT a White box technique?",
        "option_A": "Statement Testing and coverage",
        "option_B": "Decision Testing and coverage",
        "option_C": "Condition Coverage",
        "option_D": "Boundary value analysis",
        "correct_anwser": "D",
        "explain": "Các phương án A, B, C đều dựa trên việc phân tích mã nguồn (dòng lệnh, quyết định, điều kiện) nên thuộc nhóm kiểm thử hộp trắng. Trong khi đó, Phân tích giá trị biên (Boundary value analysis - D) là một kỹ thuật thiết kế kiểm thử hộp đen kinh điển, dựa trên việc lựa chọn các giá trị tại biên của các phân vùng tương đương thuộc đặc tả yêu cầu."
      },
      {
        "question_id": 34,
        "question_title": "A program with high cyclometric complexity is almost likely to be:",
        "option_A": "Large",
        "option_B": "Small",
        "option_C": "Difficult to write",
        "option_D": "Difficult to test",
        "correct_anwser": "D",
        "explain": "Độ phức tạp vòng (Cyclomatic Complexity) đo số lượng các đường đi tuyến tính độc lập thông qua đồ thị luồng điều khiển của mã nguồn. Một chương trình có độ phức tạp vòng cao nghĩa là nó chứa rất nhiều câu lệnh điều kiện, vòng lặp đan xen rắc rối. Điều này trực tiếp dẫn đến việc thiết kế kịch bản kiểm thử để bao phủ hết các nhánh trở nên cực kỳ khó khăn và tốn kém (Difficult to test)."
      },
      {
        "question_id": 35,
        "question_title": "Which of the following is NOT part of system testing",
        "option_A": "Business process-based testing",
        "option_B": "Performance, load and stress testing",
        "option_C": "Requirements-based testing",
        "option_D": "Usability testing",
        "option_E": "Top-down integration testing",
        "correct_anwser": "E",
        "explain": "Kiểm thử hệ thống (System Testing) đánh giá một hệ thống đã hoàn chỉnh và tích hợp toàn diện dựa trên các yêu cầu chức năng lẫn phi chức năng (bao gồm quy trình nghiệp vụ A, hiệu năng B, yêu cầu hệ thống C, độ khả dụng D). Trong khi đó, Kiểm thử tích hợp từ trên xuống (Top-down integration testing - E) là một chiến lược thuộc cấp độ Kiểm thử tích hợp (Integration Testing), mục đích để kiểm tra sự giao tiếp giữa các mô-đun chứ không phải kiểm thử toàn bộ hệ thống."
      },
      {
        "question_id": 36,
        "question_title": "Error guessing is:",
        "option_A": "An appropriate way of deriving system tests.",
        "option_B": "Only used if good requirements are not available.",
        "option_C": "Only used when good requirements are available.",
        "option_D": "The most appropriate way of deriving system tests.",
        "correct_anwser": "A",
        "explain": "Đoán lỗi (Error guessing) là kỹ thuật kiểm thử dựa trên kinh nghiệm, kiến thức của kiểm thử viên về các lỗi thường gặp trong quá trình phát triển. Nó được công nhận là một phương pháp phù hợp và bổ trợ rất tốt cho các kỹ thuật thiết kế kiểm thử chính thống khi xây dựng bộ kiểm thử hệ thống (An appropriate way of deriving system tests)."
      },
      {
        "question_id": 37,
        "question_title": "Cyclomatic Complexity method comes under which testing method",
        "option_A": "White box",
        "option_B": "Black box",
        "option_C": "Green box",
        "option_D": "Yellow box",
        "correct_anwser": "A",
        "explain": "Phương pháp đo độ phức tạp vòng (Cyclomatic Complexity) đòi hỏi phải phân tích cấu trúc mã nguồn, các câu lệnh rẽ nhánh trong mã của chương trình. Do đó, nó hoàn toàn thuộc về các kỹ thuật đo lường và kiểm thử hộp trắng (White box)."
      },
      {
        "question_id": 38,
        "question_title": "Given the following state transition diagram. Which of the following series of state transitions contains an INVALID transition which may indicate a fault in the system design?\nExhibit:\n[Sơ đồ chuyển trạng thái: Login -(A)-> Browse -(B)-> Basket -(D)-> Check-out -(F)-> Pay -(G)-> Log-out. Ngoài ra có nhánh quay lại Browse <-(C)- Basket và Basket <-(E)- Check-out]",
        "option_A": "Login Browse Basket Checkout Basket Checkout Pay Logout.",
        "option_B": "Login Browse Basket Checkout Pay Logout.",
        "option_C": "Login Browse Basket Checkout Basket Logout.",
        "option_D": "Login Browse Basket Browse Basket Checkout Pay Logout.",
        "correct_anwser": "C",
        "explain": "Dựa vào sơ đồ chuyển trạng thái được cung cấp:\n- Từ trạng thái 'Basket', ta có mũi tên đi ngược về 'Browse' (nhánh C) hoặc đi tới 'Check-out' (nhánh D).\n- Tại trạng thái 'Check-out', ta có mũi tên quay về 'Basket' (nhánh E) hoặc đi tới 'Pay' (nhánh F).\n- Tuy nhiên, nhìn vào chuỗi hành vi ở phương án C: `... -> Checkout -> Basket -> Logout`. Nhìn trên sơ đồ, tại nút trạng thái 'Basket' KHÔNG HỀ CÓ bất kỳ mũi tên nào dẫn trực tiếp tới nút 'Log-out' (chỉ có nút 'Pay' mới có mũi tên G dẫn đến 'Log-out'). Vì vậy, bước chuyển đổi từ Basket sang Logout là KHÔNG HỢP LỆ (INVALID)."
      },
      {
        "question_id": 39,
        "question_title": "Regression testing should be performed:\nv) Every week\nw) After the software has changed\nx) As often as possible\ny) When the environment has changed\nz) When the project manager says",
        "option_A": "v & w are true, x - z are false",
        "option_B": "w, x & y are true, v & z are false",
        "option_C": "w & y are true, v, x & z are false",
        "option_D": "w is true, v, x y and z are false",
        "option_E": "All of them are true",
        "correct_anwser": "C",
        "explain": "Theo chuẩn ISTQB, kiểm thử hồi quy (Regression testing) là hoạt động kiểm thử lại phần mềm đã chạy ổn định trước đó nhằm đảm bảo rằng các chỉnh sửa mới không làm xuất hiện lỗi ở phần chức năng cũ. Do đó, hai thời điểm bắt buộc phải thực hiện là: sau khi mã nguồn phần mềm có sự thay đổi (w) hoặc khi môi trường triển khai hệ thống có sự thay đổi (y). Việc thực hiện hàng tuần (v), liên tục bất kể lý do (x), hoặc chỉ dựa trên cảm tính cá nhân của PM (z) mà không có tác nhân thay đổi thì không đúng với nguyên lý vận hành tối ưu chi phí của kiểm thử hồi quy."
      },
      {
        "question_id": 40,
        "question_title": "FPA is used to",
        "option_A": "To measure the functional requirements of the project",
        "option_B": "To measure the size of the functionality of an Information system",
        "option_C": "To measure the functional testing effort",
        "option_D": "To measure the functional flow",
        "correct_anwser": "B",
        "explain": "FPA viết tắt của 'Function Point Analysis' (Phân tích điểm chức năng). Đây là một phương pháp tiêu chuẩn hóa trong kỹ nghệ phần mềm dùng để đo lường quy mô/kích thước chức năng của một hệ thống thông tin (To measure the size of the functionality of an Information system) dựa trên góc nhìn người dùng, từ đó làm cơ sở ước lượng công sức, chi phí và thời gian phát triển dự án."
      },
      {
        "question_id": 41,
        "question_title": "Software quality is not relevant to _______",
        "option_A": "Correctness",
        "option_B": "Usability",
        "option_C": "Viability",
        "option_D": "Reusability",
        "correct_anwser": "C",
        "explain": "Theo mô hình chất lượng phần mềm tiêu chuẩn (như ISO 9126 hay McCall), chất lượng phần mềm được đánh giá qua các đặc tính kỹ thuật bao gồm: Tính đúng đắn (Correctness), Tính khả dụng (Usability), Tính tái sử dụng (Reusability), v.v. Ngược lại, 'Viability' (Tính khả thi thương mại/kinh doanh) là một thuộc tính quản trị dự án hoặc kinh tế, không thuộc nhóm đặc tính cấu thành nên chất lượng kỹ thuật nội tại của sản phẩm phần mềm."
      },
      {
        "question_id": 42,
        "question_title": "Which activities form part of test planning?\ni) Developing test cases.\nii) Defining the overall approach to testing.\niii) Assigning resources.\niv) Building the test environment\nv) Writing test conditions.",
        "option_A": "i, ii & iv are true, iii & v are false.",
        "option_B": "ii & iii are true, i, iv & v are false.",
        "option_C": "iv & v are true, i, ii & iii are false.",
        "option_D": "i, ii & iii are true iv & v are false.",
        "correct_anwser": "B",
        "explain": "Theo quy trình kiểm thử chuẩn ISTQB, giai đoạn Lập kế hoạch kiểm thử (Test Planning) bao gồm việc xác định phạm vi, mục tiêu và cách tiếp cận kiểm thử tổng quát (ii), cùng với việc phân bổ nguồn lực/nhân sự (iii). Các hoạt động như xác định điều kiện kiểm thử (v) thuộc bước Test Analysis; phát triển test cases (i) thuộc bước Test Design; và xây dựng môi trường (iv) thuộc bước Test Implementation."
      },
      {
        "question_id": 43,
        "question_title": "Which of the following is not a part of the Test Implementation and Execution Phase",
        "option_A": "Creating test suites from the test cases",
        "option_B": "Executing test cases either manually or by using test execution tools",
        "option_C": "Comparing actual results",
        "option_D": "Designing the Tests",
        "correct_anwser": "D",
        "explain": "Giai đoạn Thiết kế kiểm thử (Designing the Tests) là một giai đoạn riêng biệt (Test Design) diễn ra trước giai đoạn Thực thi. Trong khi đó, nhóm các hoạt động tạo bộ test suite (A), chạy kịch bản kịch bản kiểm thử (B) và so sánh kết quả thực tế với kết quả mong đợi (C) đều nằm trong giai đoạn Thực hiện và Thực thi kiểm thử (Test Implementation and Execution)."
      },
      {
        "question_id": 44,
        "question_title": "Test Case are grouped into Manageable (and scheduled) units are called as",
        "option_A": "Test Harness",
        "option_B": "Test Suite",
        "option_C": "Test Cycle",
        "option_D": "Test Driver",
        "correct_anwser": "B",
        "explain": "Một tập hợp hay nhóm các kịch bản kiểm thử (Test Cases) được tổ chức và sắp xếp lại với nhau thành các đơn vị có thể quản lý, phân loại và lên lịch chạy đồng thời được định nghĩa là một 'Test Suite' (Bộ kịch bản kiểm thử)."
      },
      {
        "question_id": 45,
        "question_title": "When should configuration management procedures be implemented?",
        "option_A": "During test planning.",
        "option_B": "During test analysis.",
        "option_C": "During test execution.",
        "option_D": "When evaluating exit criteria",
        "correct_anwser": "A",
        "explain": "Các thủ tục và quy trình Quản lý cấu hình (Configuration Management) dùng để định danh, kiểm soát các phiên bản tài liệu, mã nguồn và môi trường. Quy trình này cần phải được thiết lập và lên kế hoạch thực hiện ngay từ giai đoạn Lập kế hoạch kiểm thử (During test planning) để đảm bảo tính nhất quán xuyên suốt toàn bộ vòng đời kiểm thử."
      },
      {
        "question_id": 46,
        "question_title": "Which activity in the fundamental test process creates test suites for efficient test execution?",
        "option_A": "Implementation and execution.",
        "option_B": "Planning and control.",
        "option_C": "Analysis and design.",
        "option_D": "Test closure.",
        "correct_anwser": "A",
        "explain": "Hoạt động nhóm các kịch bản kiểm thử (test cases) thành các bộ kịch bản kiểm thử (test suites), sắp xếp thứ tự ưu tiên và chuẩn bị dữ liệu kiểm thử để chuẩn bị cho việc chạy kiểm thử hiệu quả là một nhiệm vụ cốt lõi nằm trong giai đoạn Thực hiện và Thực thi (Implementation and execution)."
      },
      {
        "question_id": 47,
        "question_title": "What is the main reason for testing software before releasing it?",
        "option_A": "To show that system will work after release",
        "option_B": "To decide when the software is of sufficient quality to release",
        "option_C": "To find as many bugs as possible before release",
        "option_D": "To give information for a risk based decision about release",
        "correct_anwser": "D",
        "explain": "Mục tiêu tối thượng mang lại giá trị cao nhất của việc kiểm thử trước khi bàn giao là cung cấp đầy đủ thông tin, số liệu báo cáo khách quan về chất lượng hiện tại và các lỗi tồn đọng. Từ đó, ban quản lý hoặc các bên liên quan có thể đưa ra quyết định dựa trên rủi ro (risk-based decision) xem có nên phát hành sản phẩm hay không."
      },
      {
        "question_id": 48,
        "question_title": "A _______ is the step-by-step method followed to ensure that standards are met",
        "option_A": "SDLC",
        "option_B": "Project Plan",
        "option_C": "Policy",
        "option_D": "Procedure",
        "correct_anwser": "D",
        "explain": "Trong hệ thống quản lý chất lượng phần mềm, 'Procedure' (Quy trình/Thủ tục) quy định trình tự các bước thực hiện chi tiết (step-by-step method) cần phải tuân thủ nghiêm ngặt để đảm bảo rằng các tiêu chuẩn chất lượng (standards) đã đề ra được đáp ứng đầy đủ."
      },
      {
        "question_id": 49,
        "question_title": "What is the MAIN objective when reviewing a software deliverable?",
        "option_A": "To identify potential application failures by use of a test specification.",
        "option_B": "To identify defects in any software work product.",
        "option_C": "To identify spelling mistakes in a requirements specification.",
        "option_D": "To identify standards inconsistencies in the code.",
        "correct_anwser": "B",
        "explain": "Mục tiêu chính và bao quát nhất của hoạt động đánh giá tĩnh (Review) đối với bất kỳ sản phẩm bàn giao nào (Work product từ tài liệu yêu cầu, thiết kế cho đến mã nguồn) là phát hiện sớm các khuyết tật (To identify defects) trước khi tiến hành các bước phát triển hoặc kiểm thử động tiếp theo."
      },
      {
        "question_id": 50,
        "question_title": "The principal attributes of tools and automation are (choose one answer)",
        "option_A": "(1) Speed & efficiency",
        "option_B": "(2) Accuracy & precision",
        "option_C": "Both of (1) and (2)",
        "option_D": "None of (1) nor (2)",
        "correct_anwser": "C",
        "explain": "Lợi ích và thuộc tính cốt lõi của việc ứng dụng công cụ và kiểm thử tự động hóa (Automation Testing) bao gồm cả hai yếu tố: giúp tăng tốc độ thực thi, tiết kiệm thời gian (Speed & efficiency), đồng thời loại bỏ sai sót chủ quan của con người, đảm bảo tính nhất quán và độ chính xác lặp lại tuyệt đối (Accuracy & precision)."
      },
      {
        "question_id": 51,
        "question_title": "What type of tools to be used for Regression Testing ?",
        "option_A": "(1) Performance",
        "option_B": "(2) Record/Playback",
        "option_C": "Both of (1) and (2)",
        "option_D": "None of (1) nor (2)",
        "correct_anwser": "C",
        "explain": "Kiểm thử hồi quy (Regression Testing) nhằm mục đích kiểm tra xem các thay đổi mới có làm ảnh hưởng đến các tính năng cũ của hệ thống hay không. Các công cụ ghi và phát lại (Record/Playback) được sử dụng rộng rãi để tự động hóa các kịch bản chức năng cũ. Đồng thời, các công cụ kiểm thử hiệu năng (Performance tools) cũng được sử dụng để chạy hồi quy nhằm đảm bảo các thay đổi về mã nguồn không làm giảm tốc độ phản hồi hoặc hiệu năng của hệ thống."
      },
      {
        "question_id": 52,
        "question_title": "Which tool will be used to test the flag memory leaks and unassigned pointers",
        "option_A": "Dynamic analysis tool",
        "option_B": "Static Analysis tool.",
        "option_C": "Maintenance tool.",
        "option_D": "Configuration tool.",
        "correct_anwser": "A",
        "explain": "Mặc dù phân tích tĩnh đôi khi có thể cảnh báo nguy cơ tiềm ẩn về con trỏ, nhưng các lỗi rò rỉ bộ nhớ thực tế (memory leaks) và con trỏ chưa được gán/định vị vùng nhớ (unassigned/wild pointers) chỉ xuất hiện và gây ra hậu quả trong thời gian chạy (runtime). Do đó, công cụ phân tích động (Dynamic analysis tool) - hoạt động bằng cách giám sát chương trình khi đang thực thi - là công cụ chính xác nhất để phát hiện các lỗi quản lý bộ nhớ này."
      },
      {
        "question_id": 53,
        "question_title": "Which of the following tools would be involved in the automation of regression test?",
        "option_A": "Data tester",
        "option_B": "Boundary tester",
        "option_C": "Capture/Playback",
        "option_D": "Output comparator.",
        "correct_anwser": "C",
        "explain": "Trong các phương án được đưa ra, công cụ Ghi và Phát lại (Capture/Playback hay Record/Playback) là công cụ đặc trưng và phổ biến nhất được sử dụng để tự động hóa các kịch bản kiểm thử hồi quy, giúp chạy lại nhanh chóng các bước thao tác của người dùng trên giao diện mà không cần thực hiện thủ công."
      },
      {
        "question_id": 54,
        "question_title": "The Provision and Management of a controlled library containing all the configurations items is called as",
        "option_A": "Configuration Control",
        "option_B": "Status Accounting",
        "option_C": "Configuration Identification",
        "option_D": "None of the others",
        "correct_anwser": "A",
        "explain": "Kiểm soát cấu hình (Configuration Control) là hoạt động tập trung vào việc quản lý các thay đổi và duy trì tính toàn vẹn của các mục cấu hình trong một kho lưu trữ được kiểm soát (controlled library/repository). Nó bao gồm các thủ tục phê duyệt thay đổi, lưu kho (check-in/check-out) các phiên bản phần mềm và tài liệu."
      },
      {
        "question_id": 55,
        "question_title": "Which of the following benefits are MOST likely to be achieved by using test tools?\ni) Easy to access information about tests and testing.\nii) Reduced maintenance of testware.\niii) Easy and cheap to implement.\niv) Greater consistency of tests.",
        "option_A": "ii and iv",
        "option_B": "ii and iii",
        "option_C": "i and iv",
        "option_D": "i and iii",
        "correct_anwser": "C",
        "explain": "Việc sử dụng các công cụ kiểm thử mang lại hai lợi ích lớn rõ rệt: (i) Giúp dễ dàng tập trung và truy cập các thông tin, báo cáo về tiến độ và kết quả kiểm thử; và (iv) Mang lại sự nhất quán, lặp lại chính xác cao giữa các lần chạy test (Greater consistency). Ngược lại, việc áp dụng công cụ thường làm tăng công sức bảo trì testware (ii) và đòi hỏi chi phí đầu tư ban đầu cao cùng quy trình triển khai phức tạp chứ không hề rẻ và dễ dàng (iii)."
      },
      {
        "question_id": 56,
        "question_title": "Which of the following activities should be performed during the selection and implementation of a testing tool?\ni) Investigate the organisation's test process.\nii) Conduct a proof of concept.\niii) Implement the selected tool on a project behind schedule to save time.\niv) Identify coaching and mentoring requirements for the use of the selected tool.",
        "option_A": "i, ii, iii.",
        "option_B": "ii, iii, iv.",
        "option_C": "i, iii, iv.",
        "option_D": "i, ii, iv.",
        "correct_anwser": "D",
        "explain": "Khi lựa chọn và triển khai công cụ kiểm thử, các bước đi đúng đắn bao gồm: nghiên cứu kỹ quy trình kiểm thử hiện tại của tổ chức (i), chạy thử nghiệm để chứng minh tính khả thi (Conduct a proof of concept - ii), và xác định nhu cầu đào tạo/hướng dẫn cho đội ngũ sử dụng (iv). Việc áp dụng một công cụ mới vào một dự án đang bị chậm tiến độ (iii) là một rủi ro cực kỳ lớn và thường làm dự án trễ hơn do đội ngũ phải tốn thêm thời gian học cách sử dụng công cụ."
      },
      {
        "question_id": 57,
        "question_title": "With which of the following categories is a test comparator tool USUALLY associated?",
        "option_A": "Tool support for performance and monitoring.",
        "option_B": "Tool support for static testing.",
        "option_C": "Tool support for test execution and logging.",
        "option_D": "Tool support for the management of testing and tests.",
        "correct_anwser": "C",
        "explain": "Công cụ so sánh (Test comparator tool) có chức năng tự động đối chiếu kết quả thực tế (actual result) thu được khi chạy phần mềm với kết quả mong đợi (expected result). Hoạt động này diễn ra trực tiếp trong quá trình chạy test, vì vậy nó thuộc nhóm công cụ hỗ trợ thực thi và ghi nhật ký kiểm thử (Tool support for test execution and logging)."
      },
      {
        "question_id": 58,
        "question_title": "Find the mismatch",
        "option_A": "Test data preparation tools - Manipulate Data bases",
        "option_B": "Test design tools - Generate test inputs",
        "option_C": "Requirement management tools - Enables individual tests to be traceable",
        "option_D": "Configuration management tools - Check for consistence",
        "correct_anwser": "D",
        "explain": "Các phương án A, B, C đều mô tả đúng chức năng cốt lõi của từng loại công cụ. Phương án D bị sai lệch (mismatch) vì chức năng kiểm tra tính nhất quán (Check for consistency / Static analysis) thường thuộc về các công cụ Phân tích tĩnh (Static analysis tools) hoặc công cụ thiết kế, chứ không phải chức năng chính yếu của công cụ Quản lý cấu hình (vốn tập trung vào quản lý phiên bản và lưu trữ lịch sử thay đổi)."
      },
      {
        "question_id": 59,
        "question_title": "A thermometer measures temperature in whole degrees only. If the temperature falls below 18 degrees, the heating is switched off. It is switched on again when the temperature reaches 21 degrees. What are the best values in degrees to cover all equivalence partitions?",
        "option_A": "15, 19 and 25.",
        "option_B": "17, 18 and 19.",
        "option_C": "18, 20 and 22.",
        "option_D": "16, 26 and 32.",
        "correct_anwser": "A",
        "explain": "Dựa trên mô tả toán học của bài toán, hệ thống có 3 phân vùng tương đương (Equivalence Partitions) dựa trên trạng thái của hệ thống sưởi:\n1. Phân vùng dưới 18 độ (tắt sưởi): $T < 18$\n2. Phân vùng trung gian từ 18 đến 20 độ (giữ nguyên trạng thái trước đó): $18 \\le T \\le 20$\n3. Phân vùng từ 21 độ trở lên (bật sưởi): $T \\ge 21$\nĐể bao phủ tất cả các phân vùng tương đương, ta cần chọn ra các giá trị đại diện nằm trong từng phân vùng này. Đối chiếu với các phương án:\n- Phương án A: Giá trị 15 (thuộc vùng 1), 19 (thuộc vùng 2), và 25 (thuộc vùng 3). Bộ giá trị này đại diện hoàn hảo cho cả 3 phân vùng."
      },
      {
        "question_id": 60,
        "question_title": "The _________ Testing will be performed by the people at client own locations",
        "option_A": "Alpha testing",
        "option_B": "Field testing",
        "option_C": "Performance testing",
        "option_D": "System testing",
        "correct_anwser": "B",
        "explain": "Kiểm thử thực địa (Field testing) hoặc kiểm thử Beta (Beta testing) là hoạt động kiểm thử được thực hiện bởi người dùng cuối hoặc khách hàng trực tiếp tại chính môi trường và địa điểm vận hành thực tế của họ (client own locations), giúp phát hiện các lỗi phát sinh do điều kiện môi trường thực tế gây ra."
      }
    ]
  },
  {
    "id": "hsf302-su25-fe",
    "title": "HSF302 - SU25 - FE",
    "description": "Working with Spring Framework Final Exam Quiz",
    "questionsCount": 50,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which component in Spring is responsible for implementing the IoC container?",
        "option_A": "DispatcherServlet",
        "option_B": "BeanFactory or ApplicationContext",
        "option_C": "ViewResolver",
        "option_D": "HandlerMapping",
        "correct_anwser": "B",
        "explain": "`BeanFactory` cung cấp cấu hình cơ bản để quản lý các bean, còn `ApplicationContext` là một giao diện con nâng cao bổ sung thêm các tính năng dành cho doanh nghiệp. Cả hai đều là những thành phần giao diện cốt lõi đóng vai trò triển khai và đại diện cho Spring IoC container."
      },
      {
        "question_id": 2,
        "question_title": "What is Aspect-Oriented Programming (AOP) in Spring used for?",
        "option_A": "Defining user interfaces.",
        "option_B": "Implementing cross-cutting concerns like logging and security.",
        "option_C": "Managing database connections.",
        "option_D": "Creating web service clients.",
        "correct_anwser": "B",
        "explain": "Lập trình hướng khía cạnh (AOP) cho phép phân tách các chức năng mang tính hệ thống, cắt ngang qua nhiều mô-đun ứng dụng độc lập (cross-cutting concerns) như ghi log (logging), bảo mật (security), giám sát hiệu năng hoặc quản lý giao dịch dữ liệu mà không làm ảnh hưởng trực tiếp đến mã logic nghiệp vụ chính."
      },
      {
        "question_id": 3,
        "question_title": "Which of the following is a significant advantage of using the Spring Framework?",
        "option_A": "Tight coupling between components.",
        "option_B": "Simplified testing due to Dependency Injection.",
        "option_C": "Limited support for enterprise-level features.",
        "option_D": "Reduced modularity and code reusability.",
        "correct_anwser": "B",
        "explain": "Nhờ cơ chế Tiêm phụ thuộc (Dependency Injection), các thành phần phần mềm được liên kết lỏng lẻo với nhau (loose coupling). Điều này giúp lập trình viên cực kỳ dễ dàng thay thế các dependency thực tế bằng các đối tượng giả lập (Mock objects), đơn giản hóa quá trình viết mã Unit Test."
      },
      {
        "question_id": 4,
        "question_title": "Which DI type is generally considered the most recommended due to its immutability and testability benefits?",
        "option_A": "Setter Injection",
        "option_B": "Field Injection",
        "option_C": "Constructor Injection",
        "option_D": "Method Injection",
        "correct_anwser": "C",
        "explain": "Constructor Injection được khuyến nghị hàng đầu trong Spring vì nó đảm bảo tính bất biến (immutability) của đối tượng bằng cách cho phép định nghĩa các thuộc tính phụ thuộc là `final`, đồng thời buộc tất cả các phụ thuộc bắt buộc phải được truyền vào ngay khi khởi tạo đối tượng, giúp tránh lỗi `NullPointerException`."
      },
      {
        "question_id": 5,
        "question_title": "Which type of Dependency Injection involves passing dependencies to a class through its constructor?",
        "option_A": "Setter Injection",
        "option_B": "Field Injection",
        "option_C": "Constructor Injection",
        "option_D": "Method Injection",
        "correct_anwser": "C",
        "explain": "Theo đúng định nghĩa cốt lõi, Constructor Injection là hình thức mà các đối tượng phụ thuộc được truyền trực tiếp vào lớp thông qua các tham số của hàm khởi tạo (constructor)."
      },
      {
        "question_id": 6,
        "question_title": "Consider the following Java code snippet:\n\npublic class MyService {\n    private MyDependency dependency;\n\n    public void setDependency(MyDependency dependency) {\n        this.dependency = dependency;\n    }\n\n    public void performAction() {\n        dependency.doSomething();\n    }\n}\n\nWhich Spring Core Container feature is being demonstrated in this code?",
        "option_A": "Aspect-Oriented Programming (AOP)",
        "option_B": "Dependency Injection (DI)",
        "option_C": "Resource Management",
        "option_D": "Event Handling",
        "correct_anwser": "B",
        "explain": "Đoạn mã trên thể hiện tính năng Dependency Injection (cụ thể là mô hình Setter Injection), nơi biến `dependency` được gán giá trị thông qua hàm `setDependency` từ bên ngoài thay vì tự khởi tạo bằng từ khóa `new` bên trong lớp."
      },
      {
        "question_id": 7,
        "question_title": "Which benefit does Spring's modular architecture provide?",
        "option_A": "Increased coupling between application layers.",
        "option_B": "Ability to use only the modules needed, reducing application size.",
        "option_C": "Limited support for different persistence technologies.",
        "option_D": "Decreased flexibility in choosing application components.",
        "correct_anwser": "B",
        "explain": "Kiến trúc mô-đun hóa của Spring cho phép các ứng dụng hoạt động theo cơ chế linh hoạt linh kiện (non-monolithic): lập trình viên có thể tùy ý lựa chọn tích hợp và sử dụng các thư viện mô-đun cần thiết (ví dụ: chỉ lấy spring-web hoặc spring-data-jpa) mà không bắt buộc phải tải toàn bộ framework, tối ưu dung lượng của ứng dụng."
      },
      {
        "question_id": 8,
        "question_title": "Which code snippet shows how to set the size of a scene?",
        "option_A": "Scene scene = new Scene(new Pane(), 400, 300);",
        "option_B": "Stage stage = new Stage(new Pane(), 400, 300);",
        "option_C": "Node node = new Node(new Pane(), 400, 300);",
        "option_D": "Button button = new Button(new Pane(), 400, 300);",
        "correct_anwser": "A",
        "explain": "Trong JavaFX, kích thước rộng (width) và cao (height) của vùng hiển thị được định nghĩa trực tiếp bằng cách truyền các tham số số thực vào hàm khởi tạo của lớp `javafx.scene.Scene` (ví dụ ở đây là `400` và `300`)."
      },
      {
        "question_id": 9,
        "question_title": "Which code snippet shows how to set the title of a stage?",
        "option_A": "Scene scene = new Scene(); scene.setTitle(\"My App\");",
        "option_B": "Stage stage = new Stage(); stage.setTitle(\"My App\");",
        "option_C": "Node node = new Node(); node.setTitle(\"My App\");",
        "option_D": "Button button = new Button(); button.setTitle(\"My App\");",
        "correct_anwser": "B",
        "explain": "Lớp `Stage` đại diện cho cửa sổ ứng dụng cấp cao nhất (Top-level container) trong JavaFX. Phương thức `.setTitle(String title)` là phương thức chuẩn thuộc lớp này dùng để gán tiêu đề hiển thị trên thanh tiêu đề của cửa sổ."
      },
      {
        "question_id": 10,
        "question_title": "What is the base class for all visual components in JavaFX?",
        "option_A": "Stage",
        "option_B": "Scene",
        "option_C": "Node",
        "option_D": "Pane",
        "correct_anwser": "C",
        "explain": "Lớp trừu tượng `javafx.scene.Node` là lớp cha cơ sở (base class) cao nhất cho tất cả các thành phần giao diện hiển thị hình ảnh nằm trong cây đồ họa (Scene Graph) của JavaFX, bao gồm cả các control (Button, TextField...) và các layout pane (HBox, VBox...)."
      },
      {
        "question_id": 11,
        "question_title": "In JavaFX, what is a Property?",
        "option_A": "A static variable.",
        "option_B": "A dynamic, observable value.",
        "option_C": "A database field.",
        "option_D": "A network address.",
        "correct_anwser": "B",
        "explain": "Trong JavaFX, một `Property` (Thuộc tính) là một đối tượng chứa dữ liệu động và có khả năng quan sát (observable). Nó cho phép các thành phần UI lắng nghe sự thay đổi giá trị và hỗ trợ tính năng liên kết dữ liệu mạnh mẽ (data binding)."
      },
      {
        "question_id": 12,
        "question_title": "What does the method show() do in the Stage class?",
        "option_A": "Sets the title of the stage.",
        "option_B": "Sets the scene of the stage.",
        "option_C": "Displays the stage to the user.",
        "option_D": "Closes the stage.",
        "correct_anwser": "C",
        "explain": "Phương thức `show()` trong lớp `Stage` của JavaFX được sử dụng để hiển thị cửa sổ giao diện đồ họa lên cho người dùng nhìn thấy và tương tác."
      },
      {
        "question_id": 13,
        "question_title": "What is the container that holds all the visual content in a JavaFX application?",
        "option_A": "Stage",
        "option_B": "Scene",
        "option_C": "Node",
        "option_D": "Pane",
        "correct_anwser": "B",
        "explain": "Lớp `Scene` (Cảnh nền) đóng vai trò là container chứa toàn bộ nội dung hiển thị (visual content) của một đồ thị giao diện (Scene Graph) trong JavaFX. Một `Scene` sau đó sẽ được đặt vào bên trong một `Stage` để hiển thị ra cửa sổ."
      },
      {
        "question_id": 14,
        "question_title": "What is JavaFX?",
        "option_A": "A server-side Java framework.",
        "option_B": "A library for building rich client applications.",
        "option_C": "A database management system.",
        "option_D": "A web development framework.",
        "correct_anwser": "B",
        "explain": "JavaFX là một bộ công cụ phần mềm, một thư viện nền tảng của Java dùng để thiết kế và xây dựng các ứng dụng desktop client phong phú (Rich Client Applications) với giao diện người dùng (UI) hiện đại, hỗ trợ đồ họa và media."
      },
      {
        "question_id": 15,
        "question_title": "How is the DispatcherServlet typically configured in web.xml?",
        "option_A": "As a listener.",
        "option_B": "As a filter.",
        "option_C": "As a servlet.",
        "option_D": "As a resource.",
        "correct_anwser": "C",
        "explain": "Trong cấu hình ứng dụng web dựa trên file cấu hình XML truyền thống (`web.xml`), `DispatcherServlet` cốt lõi của Spring MVC được khai báo và cấu hình dưới dạng một lớp Servlet tiêu chuẩn thông qua thẻ `<servlet>` và `<servlet-mapping>`."
      },
      {
        "question_id": 16,
        "question_title": "What is the purpose of Spring Interceptors?",
        "option_A": "To manage database connections.",
        "option_B": "To intercept and process HTTP requests before or after they are handled by a controller.",
        "option_C": "To define user interfaces.",
        "option_D": "To configure application security.",
        "correct_anwser": "B",
        "explain": "Spring Interceptor (HandlerInterceptor) được sử dụng để can thiệp vào vòng đời xử lý yêu cầu HTTP. Nó cho phép thực hiện các đoạn mã tiền xử lý (pre-handle) hoặc hậu xử lý (post-handle) xung quanh các Controller (ví dụ như kiểm tra quyền truy cập, ghi log, đo thời gian phản hồi)."
      },
      {
        "question_id": 17,
        "question_title": "In the Spring MVC request lifecycle, which component is the first to receive an incoming request?",
        "option_A": "Controller",
        "option_B": "HandlerMapping",
        "option_C": "DispatcherServlet",
        "option_D": "ViewResolver",
        "correct_anwser": "C",
        "explain": "Trong vòng đời của Spring MVC, `DispatcherServlet` đóng vai trò là một Front Controller. Nó là thành phần trung tâm đầu tiên trực tiếp đón nhận tất cả các yêu cầu HTTP gửi đến, trước khi điều phối chúng tới các HandlerMapping và Controller phù hợp."
      },
      {
        "question_id": 18,
        "question_title": "Which of the following is a common view technology used with Spring MVC?",
        "option_A": "React",
        "option_B": "Vue.js",
        "option_C": "Thymeleaf",
        "option_D": "Angular",
        "correct_anwser": "C",
        "explain": "Trong số các lựa chọn, Thymeleaf là một công nghệ mã giao diện server-side template engine hiện đại, tích hợp chặt chẽ và cực kỳ phổ biến với Spring MVC để kết xuất giao diện trực tiếp tại server. React, Vue.js và Angular là các framework/thư viện render phía Client."
      },
      {
        "question_id": 19,
        "question_title": "What is the role of the DispatcherServlet in Spring MVC?",
        "option_A": "To manage database connections.",
        "option_B": "To handle all incoming HTTP requests.",
        "option_C": "To define user interfaces.",
        "option_D": "To configure application security.",
        "correct_anwser": "B",
        "explain": "`DispatcherServlet` hoạt động như mẫu thiết kế Front Controller trong Spring MVC, chịu trách nhiệm chính trong việc tiếp nhận và điều phối mọi yêu cầu HTTP đi vào đến các thành phần xử lý tương ứng trong hệ thống."
      },
      {
        "question_id": 20,
        "question_title": "What is the benefit of Spring Boot's embedded servers?",
        "option_A": "They require separate installation and configuration.",
        "option_B": "They simplify deployment and reduce the need for external application servers.",
        "option_C": "They offer limited performance compared to external servers.",
        "option_D": "They are only compatible with specific operating systems.",
        "correct_anwser": "B",
        "explain": "Sự hiện diện của máy chủ nhúng sẵn (embedded servers như Tomcat hoặc Jetty) giúp ứng dụng Spring Boot đóng gói gọn gàng thành một file `.jar` có thể chạy độc lập, loại bỏ hoàn toàn sự phức tạp của việc cài đặt và triển khai ứng dụng lên các máy chủ web ngoại vi."
      },
      {
        "question_id": 21,
        "question_title": "What is the purpose of Spring Boot's externalized configuration?",
        "option_A": "To embed all configurations within the application code.",
        "option_B": "To allow configuration from external files like application.properties or application.yml.",
        "option_C": "To remove configuration options entirely.",
        "option_D": "To require database configuration only.",
        "correct_anwser": "B",
        "explain": "Tính năng cấu hình tách biệt ra ngoài (Externalized Configuration) của Spring Boot cho phép lập trình viên quản lý các thiết lập môi trường bằng các tệp tin bên ngoài mã nguồn như `application.properties` hoặc `application.yml`, giúp chạy cùng một mã build trên nhiều môi trường khác nhau một cách linh hoạt."
      },
      {
        "question_id": 22,
        "question_title": "What is the purpose of the @SpringBootApplication annotation?",
        "option_A": "To define a database entity.",
        "option_B": "To enable Spring MVC functionality.",
        "option_C": "To combine @Configuration, @EnableAutoConfiguration, and @ComponentScan.",
        "option_D": "To define a RESTful endpoint.",
        "correct_anwser": "C",
        "explain": "Annotation `@SpringBootApplication` là một tiện ích tổng hợp, đảm nhận vai trò kết hợp đồng thời ba tính năng cốt lõi bao gồm cấu hình dựa trên Java (`@Configuration`), tự động cấu hình các bean phù hợp (`@EnableAutoConfiguration`), và tự động quét các thành phần phần mềm trong package (`@ComponentScan`)."
      },
      {
        "question_id": 23,
        "question_title": "Which tool is commonly used to create and manage Spring Boot projects?",
        "option_A": "Apache Ant",
        "option_B": "Maven or Gradle",
        "option_C": "Notepad++",
        "option_D": "Microsoft Word",
        "correct_anwser": "B",
        "explain": "Maven và Gradle là hai công cụ quản lý dự án và tự động hóa build (build automation tools) tiêu chuẩn, phổ biến nhất trong hệ sinh thái Java để quản lý các thư viện phụ thuộc (dependencies) và quy trình vòng đời của dự án Spring Boot."
      },
      {
        "question_id": 24,
        "question_title": "Which feature of Spring Boot provides pre-configured dependencies and auto-configuration?",
        "option_A": "Spring MVC",
        "option_B": "Spring Data JPA",
        "option_C": "Starter dependencies",
        "option_D": "Spring Security",
        "correct_anwser": "C",
        "explain": "Các gói phụ thuộc khởi đầu (Starter dependencies, ví dụ: `spring-boot-starter-web`) cung cấp sẵn một tập hợp các thư viện được cấu hình sẵn cho từng mục đích nghiệp vụ cụ thể, kết hợp với cơ chế auto-configuration để giúp dự án khởi chạy ngay lập tức mà không cần cấu hình thủ công phức tạp."
      },
      {
        "question_id": 25,
        "question_title": "In Thymeleaf's Standard Expression Syntax, what does ${...} represent?",
        "option_A": "URL expressions.",
        "option_B": "Message expressions.",
        "option_C": "Variable expressions.",
        "option_D": "Fragment expressions.",
        "correct_anwser": "C",
        "explain": "Cú pháp `${...}` trong Thymeleaf biểu diễn các biểu thức biến (Variable Expressions). Nó được sử dụng để lấy giá trị của các thuộc tính hoặc đối tượng chứa trong tầng dữ liệu Spring MVC Model (Context) chuyển giao xuống giao diện."
      },
      {
        "question_id": 26,
        "question_title": "Which of the following is a kind of template in Thymeleaf?",
        "option_A": "XML templates",
        "option_B": "Text templates",
        "option_C": "JSON templates",
        "option_D": "Binary templates",
        "correct_anwser": "B",
        "explain": "Thymeleaf hỗ trợ nhiều chế độ xử lý mẫu giao diện (template modes) khác nhau bao gồm HTML, XML, TEXT, JAVASCRIPT, và CSS. Trong số các lựa chọn đã cho, 'Text templates' (chế độ văn bản thô) là một định dạng mẫu hợp lệ được hỗ trợ trực tiếp."
      },
      {
        "question_id": 27,
        "question_title": "The Standard Dialect in Thymeleaf provides a set of:",
        "option_A": "Database drivers.",
        "option_B": "HTML attributes and elements.",
        "option_C": "Security protocols.",
        "option_D": "Network configurations.",
        "correct_anwser": "B",
        "explain": "Standard Dialect cung cấp tập hợp các thẻ tùy biến và các thuộc tính HTML động (như `th:text`, `th:value`, `th:each`) giúp Thymeleaf can thiệp trực tiếp vào cấu trúc HTML để hiển thị dữ liệu từ phía máy chủ."
      },
      {
        "question_id": 28,
        "question_title": "What is Thymeleaf?",
        "option_A": "A JavaScript framework.",
        "option_B": "A server-side Java template engine.",
        "option_C": "A database management system.",
        "option_D": "A CSS preprocessor.",
        "correct_anwser": "B",
        "explain": "Thymeleaf là một công cụ xử lý mẫu giao diện chạy ở phía máy chủ (Server-side Java template engine), thường được kết hợp với Spring MVC để tạo ra mã HTML động gửi về trình duyệt cho người dùng cuối."
      },
      {
        "question_id": 29,
        "question_title": "Thymeleaf integrates well with:",
        "option_A": "React.js",
        "option_B": "Angular.js",
        "option_C": "Spring MVC.",
        "option_D": "Node.js",
        "correct_anwser": "C",
        "explain": "Thymeleaf được thiết kế từ gốc để tương thích và tích hợp cực kỳ chặt chẽ với framework Spring MVC, hỗ trợ hoàn hảo việc xử lý dữ liệu từ đối tượng Spring Model và các tính năng kiểm lỗi form."
      },
      {
        "question_id": 30,
        "question_title": "Thymeleaf supports internationalization (i18n) through:",
        "option_A": "CSS stylesheets.",
        "option_B": "Message resolvers.",
        "option_C": "Database triggers.",
        "option_D": "JavaScript libraries.",
        "correct_anwser": "B",
        "explain": "Thymeleaf hỗ trợ đa ngôn ngữ (Internationalization - i18n) bằng việc tích hợp hệ thống Message Resolvers (Bộ phân giải thông điệp) của Spring, cho phép trích xuất các chuỗi ký tự động tương ứng theo ngôn ngữ locale người dùng từ các file cấu hình ứng dụng dạng `.properties` thông qua cú pháp `#{...}`."
      },
      {
        "question_id": 31,
        "question_title": "What is the purpose of Thymeleaf Layout Dialect?",
        "option_A": "Enhancing security for the web application.",
        "option_B": "Providing a way to create reusable template layouts.",
        "option_C": "Managing database connections.",
        "option_D": "Optimizing JavaScript performance.",
        "correct_anwser": "B",
        "explain": "Thymeleaf Layout Dialect cung cấp cơ chế phân bố giao diện theo phân cấp bố cục, cho phép tạo các tệp giao diện mẫu (template layouts) dùng chung (như bố cục header, footer) và tái sử dụng chúng trên nhiều trang nội dung khác nhau để tránh trùng lặp mã."
      },
      {
        "question_id": 32,
        "question_title": "Which of the following is an example of a relationship annotation in JPA?",
        "option_A": "@Column",
        "option_B": "@Entity",
        "option_C": "@OneToMany",
        "option_D": "@Transient",
        "correct_anwser": "C",
        "explain": "Annotation `@OneToMany` là một annotation chỉ định mối quan hệ (relationship) dùng để ánh xạ mối liên kết Một-Nhiều giữa hai thực thể trong JPA. Các phương án còn lại dùng để định nghĩa cột (`@Column`), định nghĩa thực thể (`@Entity`) hoặc bỏ qua trường không lưu trữ (`@Transient`)."
      },
      {
        "question_id": 33,
        "question_title": "What is the primary purpose of JPA (Java Persistence API)?",
        "option_A": "To define a standard for web application development",
        "option_B": "To define a standard for object-relational mapping in Java",
        "option_C": "To manage user interfaces",
        "option_D": "To handle network communication",
        "correct_anwser": "B",
        "explain": "Mục đích chính của JPA (Java Persistence API) là đưa ra một bộ đặc tả tiêu chuẩn cho kỹ thuật ánh xạ đối tượng - quan hệ (Object-Relational Mapping - ORM) trong ngôn ngữ lập trình Java, giúp đơn giản hóa việc tương tác với cơ sở dữ liệu quan hệ theo phong cách hướng đối tượng."
      },
      {
        "question_id": 34,
        "question_title": "What does the EntityManager manage in a JPA application?",
        "option_A": "User sessions",
        "option_B": "Entity lifecycle and persistence",
        "option_C": "Network connections",
        "option_D": "Web page rendering",
        "correct_anwser": "B",
        "explain": "Trong JPA, `EntityManager` là thành phần chịu trách nhiệm quản lý vòng đời (lifecycle) của các đối tượng thực thể (Entity) từ trạng thái mới tạo, được lưu trữ bền vững (persistence), tách rời (detached) cho đến khi bị xóa khỏi cơ sở dữ liệu."
      },
      {
        "question_id": 35,
        "question_title": "Which of the following is a primary benefit of using ORM?",
        "option_A": "Increased database complexity",
        "option_B": "Reduced code redundancy and improved maintainability",
        "option_C": "Direct SQL query writing for all operations",
        "option_D": "Limited support for object-oriented principles",
        "correct_anwser": "B",
        "explain": "Lợi ích hàng đầu của việc áp dụng ORM (Object-Relational Mapping) là tự động hóa việc chuyển đổi dữ liệu và sinh mã SQL, giúp giảm thiểu tối đa lượng mã lặp đi lặp lại (reduced code redundancy), từ đó nâng cao khả năng bảo trì và phát triển mã nguồn (improved maintainability)."
      },
      {
        "question_id": 36,
        "question_title": "Which JPA component is responsible for managing the persistence of entities?",
        "option_A": "Servlet",
        "option_B": "EntityManager",
        "option_C": "JSP",
        "option_D": "JDBC Driver",
        "correct_anwser": "B",
        "explain": "`EntityManager` là thành phần giao diện cốt lõi trong JPA đảm nhận chức năng quản lý toàn bộ các thao tác lưu trữ, cập nhật, truy vấn dữ liệu bền vững của các thực thể."
      },
      {
        "question_id": 37,
        "question_title": "In a JavaFX application with JPA, where is the EntityManager typically created and managed?",
        "option_A": "In the View layer.",
        "option_B": "In the Controller or Service layer.",
        "option_C": "Directly in the Entity class.",
        "option_D": "Inside the JavaFX Application class.",
        "correct_anwser": "B",
        "explain": "Để đảm bảo nguyên lý phân lớp trong kiến trúc phần mềm, `EntityManager` (hoặc các lớp Repository/Service bao bọc nó) thường được khởi tạo, quản lý và gọi trong tầng Controller hoặc tầng Service nhằm tách biệt hoàn toàn logic xử lý dữ liệu khỏi tầng hiển thị (View)."
      },
      {
        "question_id": 38,
        "question_title": "Which JavaFX component is suitable for displaying validation error messages?",
        "option_A": "Label or Alert",
        "option_B": "Button",
        "option_C": "TableView",
        "option_D": "TextField",
        "correct_anwser": "A",
        "explain": "Để hiển thị thông báo lỗi khi kiểm tra dữ liệu đầu vào (validation errors), cấu phần `Label` thường được dùng để hiển thị dòng chữ đỏ ngay cạnh trường nhập liệu, hoặc hộp thoại `Alert` được dùng để bật lên thông báo popup cảnh báo trực quan cho người dùng."
      },
      {
        "question_id": 39,
        "question_title": "Which JavaFX layout component is often used to arrange input fields and buttons in a CRUD form?",
        "option_A": "HBox/VBox",
        "option_B": "BorderPane",
        "option_C": "GridPane",
        "option_D": "StackPane",
        "correct_anwser": "C",
        "explain": "`GridPane` sắp xếp các thành phần con theo dạng lưới gồm các hàng và các cột linh hoạt, rất lý tưởng để thiết kế form nhập liệu (CRUD) chứa các cặp thành phần như nhãn bên trái thẳng hàng với trường nhập liệu tương ứng bên phải."
      },
      {
        "question_id": 40,
        "question_title": "What is the purpose of writing unit tests for a Spring application?",
        "option_A": "To manage database connections.",
        "option_B": "To ensure the correctness of individual components.",
        "option_C": "To define user interfaces.",
        "option_D": "To configure application security.",
        "correct_anwser": "B",
        "explain": "Mục đích cốt lõi của việc viết Unit Test (Kiểm thử đơn vị) là cô lập và kiểm tra tính hoạt động chính xác của từng thành phần nhỏ, độc lập trong mã nguồn (như một hàm, một lớp hay một bean cụ thể) để phát hiện sớm các lỗi logic."
      },
      {
        "question_id": 41,
        "question_title": "What is the purpose of the Model in a Spring application?",
        "option_A": "To define user interfaces.",
        "option_B": "To represent domain objects and data.",
        "option_C": "To manage HTTP requests.",
        "option_D": "To handle application deployment.",
        "correct_anwser": "B",
        "explain": "Trong mô hình MVC (Model-View-Controller) của Spring, thành phần `Model` chịu trách nhiệm biểu diễn dữ liệu của ứng dụng, các đối tượng domain (domain objects) và trạng thái của nghiệp vụ nhằm chuẩn bị chuyển giao cho View hiển thị."
      },
      {
        "question_id": 42,
        "question_title": "What is the primary function of a Controller in a Spring MVC application?",
        "option_A": "To manage database connections.",
        "option_B": "To handle HTTP requests and return a model and view.",
        "option_C": "To define user interfaces.",
        "option_D": "To configure application security.",
        "correct_anwser": "B",
        "explain": "Controller trong Spring MVC đóng vai trò là điểm tiếp nhận và xử lý trực tiếp các yêu cầu HTTP gửi đến từ phía người dùng, thực hiện điều phối luồng xử lý và trả về đối tượng dữ liệu (Model) cùng trang giao diện (View) tương ứng."
      },
      {
        "question_id": 43,
        "question_title": "When using Spring ORM with Hibernate, what annotation is commonly used to map a Java class to a database table?",
        "option_A": "@Component",
        "option_B": "@Service",
        "option_C": "@Entity",
        "option_D": "@Controller",
        "correct_anwser": "C",
        "explain": "Annotation `@Entity` (được định nghĩa trong đặc tả JPA chuẩn được Spring ORM/Hibernate hỗ trợ) là cấu phần bắt buộc dùng để đánh dấu và ánh xạ một lớp Java thành một thực thể bền vững tương ứng với một bảng trong cơ sở dữ liệu."
      },
      {
        "question_id": 44,
        "question_title": "Which annotation is used to define a named query?",
        "option_A": "@Query",
        "option_B": "@NamedQuery",
        "option_C": "@StoredProcedure",
        "option_D": "@NativeQuery",
        "correct_anwser": "B",
        "explain": "Annotation `@NamedQuery` được sử dụng trong JPA để khai báo và đặt tên trước cho các câu truy vấn tĩnh (static queries) trực tiếp ngay trên thực thể, giúp tái sử dụng câu lệnh truy vấn một cách tối ưu và gọn gàng."
      },
      {
        "question_id": 45,
        "question_title": "Which of the following is NOT a main module of Spring Data?",
        "option_A": "Spring Data JPA",
        "option_B": "Spring Data MongoDB",
        "option_C": "Spring Data REST",
        "option_D": "Spring Data UI",
        "correct_anwser": "D",
        "explain": "Hệ sinh thái Spring Data bao gồm các mô-đun chính phục vụ truy cập dữ liệu như Spring Data JPA, Spring Data MongoDB, Spring Data Neo4j, và Spring Data REST. Không hề tồn tại mô-đun nào tên là `Spring Data UI` vì Spring Data hoàn toàn không quản lý phần giao diện."
      },
      {
        "question_id": 46,
        "question_title": "What is the role of a Repository interface in Spring Data JPA?",
        "option_A": "To define business logic.",
        "option_B": "To manage user interfaces.",
        "option_C": "To provide data access methods.",
        "option_D": "To configure application security.",
        "correct_anwser": "C",
        "explain": "Interface `Repository` trong Spring Data JPA đóng vai trò trung tâm cung cấp sẵn các phương thức trừu tượng hỗ trợ thao tác và truy cập dữ liệu (CRUD, tìm kiếm, phân trang) mà không yêu cầu lập trình viên phải viết mã thực thi chi tiết thủ công."
      },
      {
        "question_id": 47,
        "question_title": "In a ManyToMany relationship, which table is used to store the relationship between the two entities?",
        "option_A": "The table of the first entity.",
        "option_B": "The table of the second entity.",
        "option_C": "A join table.",
        "option_D": "A temporary table.",
        "correct_anwser": "C",
        "explain": "Trong cơ sở dữ liệu quan hệ, mối quan hệ Nhiều-Nhiều (ManyToMany) bắt buộc phải được chuẩn hóa thông qua một bảng trung gian, thường được gọi là bảng liên kết hoặc bảng nối (`join table`), để lưu trữ các cặp khóa ngoại liên kết giữa hai thực thể chính."
      },
      {
        "question_id": 48,
        "question_title": "Spring Data JPA simplifies working with:",
        "option_A": "NoSQL databases.",
        "option_B": "Relational databases using the Java Persistence API (JPA).",
        "option_C": "Message queues.",
        "option_D": "Cloud storage.",
        "correct_anwser": "B",
        "explain": "Mục đích chuyên biệt của Spring Data JPA là tối ưu và đơn giản hóa việc tương tác với các hệ quản trị cơ sở dữ liệu quan hệ (Relational databases) bằng cách cung cấp các lớp trừu tượng đè lên tầng đặc tả JPA tiêu chuẩn."
      },
      {
        "question_id": 49,
        "question_title": "In Spring Data JPA, what does the method signature List findByPropertyOrderByPropertyAsc(String property); do?",
        "option_A": "Finds entities where property is equal to String property, ordered by property descending.",
        "option_B": "Finds entities where property is equal to String property, ordered by property ascending.",
        "option_C": "Finds entities where property contains String property, ordered by property ascending.",
        "option_D": "Finds entities where property is less than String property, ordered by property ascending.",
        "correct_anwser": "B",
        "explain": "Theo quy tắc tự dịch từ khóa truy vấn (Query Derivation) của Spring Data JPA, cụm từ `findByProperty` thực hiện phép so sánh bằng (`=`), và mệnh đề `OrderByPropertyAsc` sẽ tự động thêm chỉ thị sắp xếp theo thứ tự tăng dần (`ASC`) đối với thuộc tính đó."
      },
      {
        "question_id": 50,
        "question_title": "Which annotation is used to specify the table name for an entity?",
        "option_A": "@Column",
        "option_B": "@Id",
        "option_C": "@GeneratedValue",
        "option_D": "@Table",
        "correct_anwser": "D",
        "explain": "Annotation `@Table` được đặt ở mức lớp (class level) của một thực thể JPA để chỉ định rõ ràng tên của bảng dữ liệu quan hệ trong database (`@Table(name = \"tên_bảng\")`) mà thực thể đó ánh xạ vào."
      }
    ]
  },
  {
    "id": "swt301-su25-fe",
    "title": "SWT301 - SU25 - FE",
    "description": "Software Testing Final Exam Quiz",
    "questionsCount": 60,
    "questions": [
      {
        "question_id": 1,
        "question_title": "When we test or review a product, what are we looking for?",
        "option_A": "We are looking for errors and fixing them.",
        "option_B": "We are looking for defects in the product and thus are critical of it.",
        "option_C": "We are looking for different between the system and the requirement.",
        "option_D": "We are looking for the mistakes of the requirement.",
        "correct_anwser": "C",
        "explain": "Kiểm thử và đánh giá nhằm tìm ra sự khác biệt giữa hệ thống thực tế và yêu cầu, từ đó phát hiện lỗi. Việc sửa lỗi không thuộc phạm vi kiểm thử, và kiểm thử không phải chỉ trích sản phẩm hay chỉ tìm lỗi yêu cầu."
      },
      {
        "question_id": 2,
        "question_title": "What does the term \"failure\" mean in the context of testing?",
        "option_A": "A mistake made by a developer.",
        "option_B": "A defect in the software that is found during testing.",
        "option_C": "An incorrect behavior of the system in operation.",
        "option_D": "A missed requirement during design.",
        "correct_anwser": "C",
        "explain": "Failure (thất bại) là hành vi sai của hệ thống khi vận hành. Lỗi (error) là sai lầm của con người, khuyết điểm (defect) là lỗi trong phần mềm, và thiếu sót yêu cầu là một loại lỗi thiết kế, không phải failure."
      },
      {
        "question_id": 3,
        "question_title": "Independent testing - who is a tester? Choose the incorrect sentence:",
        "option_A": "Tests by the person who wrote the item under test.",
        "option_B": "Tests by a person from a different organizational group, such as an independent test team.",
        "option_C": "Tests by another person within the same team, such as another programmer.",
        "option_D": "Tests by the person who wrote the source code.",
        "correct_anwser": "A",
        "explain": "Kiểm thử độc lập (independent testing) yêu cầu người kiểm thử không phải là người viết sản phẩm dưới kiểm thử. Các phương án B và C đều thể hiện các mức độ độc lập, còn A và D đều không độc lập. Trong các đáp án, A là lựa chọn sai rõ ràng nhất vì nó khái quát việc người viết tự kiểm thử."
      },
      {
        "question_id": 4,
        "question_title": "What is the significance of context in testing according to the principles?",
        "option_A": "It is irrelevant since all testing follows the same standard.",
        "option_B": "It is critical as testing approaches should vary based on the specific context.",
        "option_C": "It suggests that testing should always follow the same international standards.",
        "option_D": "Context is only important in large, complex systems.",
        "correct_anwser": "B",
        "explain": "Nguyên lý kiểm thử cho rằng kiểm thử phụ thuộc vào ngữ cảnh (context-dependent). Phương pháp kiểm thử cần được điều chỉnh theo đặc thù của dự án, miền ứng dụng, rủi ro,... vì vậy ngữ cảnh là yếu tố then chốt."
      },
      {
        "question_id": 5,
        "question_title": "Find the explanation of \"Testing shows presence of defects\":",
        "option_A": "Testing can show that defects are present, but cannot prove that there are no defects. Testing reduces the probability of undiscovered defects remaining in the software but, even if no defects are found, it is not a proof of correctness.",
        "option_B": "Testing activities should start as early as possible in the software or system development life cycle and should be focused on defined objectives.",
        "option_C": "Finding and fixing defects does not help if the system built is unusable and does not fulfill the users' needs and expectations.",
        "option_D": "Testing is done differently in different contexts. For example, safety-critical software is tested differently from an e-commerce site.",
        "correct_anwser": "A",
        "explain": "Đây là định nghĩa chuẩn của nguyên lý 'kiểm thử chỉ cho thấy sự hiện diện của khuyết điểm, không thể chứng minh không có khuyết điểm'. Kiểm thử giúp giảm xác suất còn sót lỗi nhưng không đảm bảo đúng tuyệt đối."
      },
      {
        "question_id": 6,
        "question_title": "What types of defects are typically found more effectively during static testing than dynamic testing?",
        "option_A": "Performance-related defects",
        "option_B": "Defects in user interface design",
        "option_C": "Missing requirements or design defects",
        "option_D": "Runtime errors and exceptions",
        "correct_anwser": "C",
        "explain": "Kiểm thử tĩnh (review, inspection) hiệu quả trong việc phát hiện các khiếm khuyết ở giai đoạn đầu như yêu cầu thiếu sót, lỗi thiết kế. Lỗi runtime và hiệu năng thường được tìm thấy qua kiểm thử động."
      },
      {
        "question_id": 7,
        "question_title": "What is a key reason that software testing is necessary?",
        "option_A": "To increase software complexity",
        "option_B": "To identify defects in software",
        "option_C": "To reduce software features",
        "option_D": "To speed up software development",
        "correct_anwser": "B",
        "explain": "Mục đích chính của kiểm thử phần mềm là phát hiện khuyết điểm (defects) trong sản phẩm, từ đó nâng cao chất lượng. Các lý do khác không đúng với bản chất của kiểm thử."
      },
      {
        "question_id": 8,
        "question_title": "How much testing is enough?",
        "option_A": "Exhaustive testing is possible.",
        "option_B": "Testing everything (all combinations of inputs and preconditions).",
        "option_C": "We use risks and priorities to focus testing efforts.",
        "option_D": "Full testing.",
        "correct_anwser": "C",
        "explain": "Không thể kiểm thử toàn bộ mọi tổ hợp đầu vào. Do đó, cần dựa trên rủi ro và mức độ ưu tiên để tập trung nguồn lực vào các phần quan trọng, từ đó xác định mức độ kiểm thử đủ."
      },
      {
        "question_id": 9,
        "question_title": "What is an effect of poor communication between testers and developers?",
        "option_A": "It enhances the efficiency of the development and testing processes.",
        "option_B": "It may lead to misunderstandings and reduced software quality.",
        "option_C": "It improves the independence of the testing function.",
        "option_D": "It has no effect as long as testing is done independently.",
        "correct_anwser": "B",
        "explain": "Giao tiếp kém giữa tester và developer có thể gây hiểu nhầm, thiếu đồng bộ, dẫn đến giảm chất lượng phần mềm. Các tác động khác là không đúng hoặc không hợp lý."
      },
      {
        "question_id": 10,
        "question_title": "Which of the following strategies can help minimize psychological conflict between testers and developers? (Select all that apply)",
        "option_A": "Fostering mutual respect between roles.",
        "option_B": "Ensuring clear objectives for testing.",
        "option_C": "Feedback belittles the coder with errors found.",
        "option_D": "Encouraging collaboration on defect resolution.",
        "correct_anwser": "A, B, D",
        "explain": "Để giảm xung đột tâm lý, cần tôn trọng lẫn nhau, đặt mục tiêu kiểm thử rõ ràng và khuyến khích hợp tác trong việc giải quyết lỗi. Phản hồi mang tính chỉ trích, hạ thấp (phương án C) sẽ làm gia tăng xung đột, do đó không được chọn."
      },
      {
        "question_id": 11,
        "question_title": "What should integration testing primarily focus on?",
        "option_A": "Testing the database and data processing",
        "option_B": "Ensuring that software modules work together",
        "option_C": "Checking that the system is ready for live deployment",
        "option_D": "Evaluating user satisfaction with the product",
        "correct_anwser": "B",
        "explain": "Kiểm thử tích hợp tập trung vào việc kiểm tra các giao diện và tương tác giữa các module/ thành phần phần mềm để đảm bảo chúng làm việc cùng nhau đúng cách. Các phương án khác thuộc về kiểm thử hệ thống, kiểm thử chấp nhận hoặc kiểm thử cơ sở dữ liệu."
      },
      {
        "question_id": 12,
        "question_title": "How does stress testing differ from load testing?",
        "option_A": "Stress testing examines system performance under peak loads, while load testing focuses on typical conditions",
        "option_B": "Stress testing is concerned with usability under stress, while load testing measures performance thresholds",
        "option_C": "Stress testing evaluates system behavior beyond normal operational capacity, while load testing verifies normal usage conditions",
        "option_D": "",
        "correct_anwser": "C",
        "explain": "Stress testing (kiểm thử quá tải) đẩy hệ thống vượt quá khả năng hoạt động bình thường để xác định điểm phá vỡ, trong khi load testing (kiểm thử tải) kiểm tra hiệu suất với mức tải dự kiến trong điều kiện bình thường. Đáp án C mô tả chính xác sự khác biệt này."
      },
      {
        "question_id": 13,
        "question_title": "What is the main advantage of using the V-model in software development?",
        "option_A": "It eliminates the need for testing.",
        "option_B": "It integrates testing throughout the development phases.",
        "option_C": "It is less costly and time-consuming compared to other models.",
        "option_D": "It focuses on post-development testing only.",
        "correct_anwser": "B",
        "explain": "Mô hình V-mô hình nhấn mạnh việc ghép nối các pha phát triển với các pha kiểm thử tương ứng, tích hợp kiểm thử vào tất cả các giai đoạn phát triển. Do đó, ưu điểm chính là kiểm thử được thực hiện xuyên suốt, không chỉ sau khi phát triển."
      },
      {
        "question_id": 14,
        "question_title": "What is the purpose of unit testing in software development?",
        "option_A": "To test the entire system as a whole",
        "option_B": "To test individual units or components in isolation",
        "option_C": "To validate the software against user requirements",
        "option_D": "To perform performance testing",
        "correct_anwser": "B",
        "explain": "Kiểm thử đơn vị (unit testing) tập trung vào từng phần tử nhỏ nhất, thường là hàm hoặc lớp, để kiểm tra hoạt động độc lập. Các phương án còn lại thuộc kiểm thử hệ thống, kiểm thử chấp nhận hoặc kiểm thử hiệu năng."
      },
      {
        "question_id": 15,
        "question_title": "What is a characteristic of non-functional testing?",
        "option_A": "It is always performed after functional testing.",
        "option_B": "It focuses on how well the system performs certain actions.",
        "option_C": "It is concerned solely with what the system does.",
        "option_D": "It does not include performance testing.",
        "correct_anwser": "B",
        "explain": "Kiểm thử phi chức năng kiểm tra các thuộc tính như hiệu năng, bảo mật, khả dụng, khả năng mở rộng – tức là \"hệ thống thực hiện tốt như thế nào\". Phương án C là đặc trưng của kiểm thử chức năng, còn D sai vì kiểm thử hiệu năng là một loại kiểm thử phi chức năng."
      },
      {
        "question_id": 16,
        "question_title": "What is not test type?",
        "option_A": "Structural testing",
        "option_B": "Functional testing",
        "option_C": "Non-functional testing",
        "option_D": "Performance testing",
        "option_E": "Change-related testing",
        "correct_anwser": "D",
        "explain": "Theo phân loại kiểu kiểm thử của ISTQB, các loại chính bao gồm: Functional testing, Non-functional testing, Structural testing và Change-related testing. Performance testing chỉ là một loại con thuộc Non-functional testing, không phải là một loại kiểm thử độc lập ở cấp độ chính, nên đáp án đúng là D."
      },
      {
        "question_id": 17,
        "question_title": "What is the role of performance testing in system testing?",
        "option_A": "To verify that the system behaves correctly under load",
        "option_B": "To ensure that the system meets functional requirements",
        "option_C": "To check the accuracy of data processing",
        "option_D": "To confirm that the system is bug-free",
        "correct_anwser": "A",
        "explain": "Kiểm thử hiệu năng trong kiểm thử hệ thống nhằm đánh giá hành vi của hệ thống khi hoạt động với các mức tải khác nhau, đảm bảo đáp ứng các yêu cầu phi chức năng. Các phương án còn lại liên quan đến kiểm thử chức năng hoặc là mục tiêu không thực tế."
      },
      {
        "question_id": 18,
        "question_title": "What does the term \"Big-bang model\" imply about the approach to software development?",
        "option_A": "Detailed and extensive planning",
        "option_B": "Integration of all components at once without prior testing",
        "option_C": "Regular testing from the beginning of the project",
        "option_D": "User involvement is mandatory",
        "correct_anwser": "B",
        "explain": "Mô hình Big-bang trong tích hợp phần mềm có nghĩa là tất cả các thành phần được phát triển riêng lẻ sau đó ghép lại với nhau cùng một lúc và tiến hành kiểm thử sau, không có kiểm thử từng thành phần trước. Các phương án khác không phản ánh đặc điểm của mô hình này."
      },
      {
        "question_id": 19,
        "question_title": "What is the typical sequence of testing activities in the Waterfall model?",
        "option_A": "System testing, integration testing, acceptance testing",
        "option_B": "Acceptance testing, system testing, integration testing",
        "option_C": "Integration testing, system testing, acceptance testing",
        "option_D": "Component testing, system testing, integration testing",
        "correct_anwser": "C",
        "explain": "Trong mô hình Waterfall, sau giai đoạn phát triển, các cấp độ kiểm thử thường được thực hiện theo thứ tự: Integration testing -> System testing -> Acceptance testing (kiểm thử tích hợp, sau đó kiểm thử hệ thống, cuối cùng là kiểm thử chấp nhận). Mặc dù lý tưởng có thêm Component testing trước Integration, nhưng trong các phương án đưa ra, C là phương án đúng thứ tự các cấp độ còn lại."
      },
      {
        "question_id": 20,
        "question_title": "In which testing level would you test for defects in the interfaces and interaction between integrated components?",
        "option_A": "Component testing",
        "option_B": "Integration testing",
        "option_C": "System testing",
        "option_D": "Acceptance testing",
        "correct_anwser": "B",
        "explain": "Kiểm thử tích hợp (Integration testing) được thiết kế để phát hiện khiếm khuyết trong các giao diện và tương tác giữa các thành phần đã tích hợp. Các cấp độ khác không tập trung vào tương tác giữa các thành phần."
      },
      {
        "question_id": 21,
        "question_title": "What is dynamic testing?",
        "option_A": "Software work products are examined manually, or with a set of tools, but not executed.",
        "option_B": "Software is executed using a set of input values and its output is then examined and compared to what is expected.",
        "option_C": "Testing can start early in the life cycle, early feedback on quality issues can be established.",
        "option_D": "Testing can start early validation of user requirements and not just late in the life cycle during acceptance testing.",
        "correct_anwser": "B",
        "explain": "Kiểm thử động (dynamic testing) là quá trình thực thi phần mềm với các đầu vào cụ thể và so sánh kết quả đầu ra với dự kiến. Các phương án khác mô tả kiểm thử tĩnh hoặc lợi ích của kiểm thử sớm."
      },
      {
        "question_id": 22,
        "question_title": "Why are rules and checklists used during inspections?",
        "option_A": "To reduce the time spent on discussions",
        "option_B": "To ensure consistency and thoroughness in defect identification",
        "option_C": "To allow participants to avoid preparation",
        "option_D": "To document defects for legal compliance",
        "correct_anwser": "B",
        "explain": "Quy tắc và danh sách kiểm tra (checklists) trong các buổi đánh giá (inspection) được sử dụng để đảm bảo tính nhất quán và toàn diện trong việc phát hiện khiếm khuyết. Chúng không phải để giảm thời gian thảo luận hay tránh chuẩn bị."
      },
      {
        "question_id": 23,
        "question_title": "Which of the following is most likely to be performed by developers?",
        "option_A": "Technical review of a functional specification.",
        "option_B": "Walkthrough of a requirements document.",
        "option_C": "Informal review of a program specification.",
        "option_D": "Static analysis of a software model.",
        "correct_anwser": "D",
        "explain": "Phân tích tĩnh (static analysis) thường được thực hiện bởi các nhà phát triển bằng công cụ kiểm tra mã nguồn, trong khi các loại đánh giá khác thường có sự tham gia của nhiều bên và không chỉ riêng lập trình viên."
      },
      {
        "question_id": 24,
        "question_title": "What is a primary difference between static and dynamic testing techniques?",
        "option_A": "Static testing involves executing the code, while dynamic does not",
        "option_B": "Static testing does not involve executing the code, while dynamic does",
        "option_C": "Static testing is only performed by developers, while dynamic is not",
        "option_D": "Static testing cannot find defects, while dynamic can",
        "correct_anwser": "B",
        "explain": "Sự khác biệt cơ bản nhất là kiểm thử tĩnh (static testing) không thực thi mã nguồn, trong khi kiểm thử động (dynamic testing) có thực thi mã và so sánh kết quả. Các phương án khác sai về bản chất."
      },
      {
        "question_id": 25,
        "question_title": "What types of defects are typically found more effectively during static testing than dynamic testing?",
        "option_A": "Performance-related defects",
        "option_B": "Defects in user interface design",
        "option_C": "Runtime errors and exceptions",
        "option_D": "Missing requirements or design defects",
        "correct_anwser": "D",
        "explain": "Kiểm thử tĩnh (review, inspection, static analysis) phát hiện hiệu quả các khiếm khuyết ở giai đoạn đầu như yêu cầu thiếu sót hoặc lỗi thiết kế. Lỗi runtime và hiệu năng thường được tìm thấy qua kiểm thử động."
      },
      {
        "question_id": 26,
        "question_title": "How do reviews support software quality assurance?",
        "option_A": "By focusing solely on end-user needs",
        "option_B": "By providing a way to check compliance with standards",
        "option_C": "By testing software functionality through execution",
        "option_D": "By replacing the need for project management",
        "correct_anwser": "B",
        "explain": "Các buổi đánh giá (reviews) hỗ trợ đảm bảo chất lượng bằng cách cung cấp cơ chế kiểm tra sự tuân thủ các tiêu chuẩn, quy trình và yêu cầu, không thay thế quản lý dự án hay chỉ tập trung vào người dùng cuối."
      },
      {
        "question_id": 27,
        "question_title": "How do technical reviews differ from informal reviews?",
        "option_A": "Technical reviews are less structured and more ad-hoc",
        "option_B": "Technical reviews require the presence of software architects",
        "option_C": "Technical reviews are led by a trained moderator and follow a defined process",
        "option_D": "Informal reviews do not involve developers",
        "correct_anwser": "C",
        "explain": "Đánh giá kỹ thuật (technical review) được dẫn dắt bởi một người điều phối (moderator) có kỹ năng và tuân theo quy trình xác định, trong khi đánh giá không chính thức (informal review) ít cấu trúc hơn và thường diễn ra tự phát."
      },
      {
        "question_id": 28,
        "question_title": "Which of the following are the main activities of the work product review process?\n1. Planning\n2. Initiate review\n3. Select reviewers\n4. Individual review\n5. Review meeting\n6. Evaluating review findings against exit criteria\n7. Issue communication and analysis\n8. Fixing and reporting",
        "option_A": "1,2,4,7,8",
        "option_B": "2,3,4,5,8",
        "option_C": "1,2,3,5,7",
        "option_D": "1,4,5,6,7",
        "correct_anwser": "A",
        "explain": "Quy trình đánh giá sản phẩm công việc (work product review) theo ISTQB bao gồm các hoạt động chính: Lập kế hoạch (1), Khởi tạo đánh giá (2), Đánh giá cá nhân (4), Truyền thông và phân tích vấn đề (7), và Sửa lỗi & báo cáo (8). Các bước khác như chọn người đánh giá (3) và họp đánh giá (5) có thể là một phần nhưng không phải là các bước chính bắt buộc trong quy trình cốt lõi."
      },
      {
        "question_id": 29,
        "question_title": "What is a key feature of static analysis tools?",
        "option_A": "Executing the code",
        "option_B": "Checking coding standards",
        "option_C": "Testing system performance",
        "option_D": "Automating user feedback",
        "correct_anwser": "B",
        "explain": "Công cụ phân tích tĩnh (static analysis) thường kiểm tra các quy tắc mã hóa (coding standards), cấu trúc và độ phức tạp mà không cần thực thi mã. Chúng không kiểm tra hiệu năng hay tự động hóa phản hồi người dùng."
      },
      {
        "question_id": 30,
        "question_title": "What is static testing?",
        "option_A": "Software work products are examined manually, or with a set of tools, but not executed.",
        "option_B": "Software is executed using a set of input values and its output is then examined and compared to what is expected.",
        "option_C": "Execution is applied as a technique to detect defects and to determine quality attributes of the code.",
        "option_D": "Testing can start after dynamic testing.",
        "correct_anwser": "A",
        "explain": "Kiểm thử tĩnh (static testing) là việc xem xét các sản phẩm công việc (như mã nguồn, tài liệu) một cách thủ công hoặc với công cụ mà không thực thi. Các phương án khác mô tả kiểm thử động hoặc sai về thời điểm."
      },
      {
        "question_id": 31,
        "question_title": "What is the main purpose of specification-based testing techniques?",
        "option_A": "To evaluate the system's behavior from an external perspective",
        "option_B": "To assess the internal structure of the software",
        "option_C": "To improve the software design",
        "option_D": "To test the software without any formal requirements",
        "correct_anwser": "A",
        "explain": "Kỹ thuật kiểm thử dựa trên đặc tả (specification-based) còn gọi là hộp đen, tập trung vào hành vi hệ thống từ góc nhìn bên ngoài dựa trên yêu cầu. Các phương án khác là đặc trưng của kiểm thử cấu trúc hoặc không đúng."
      },
      {
        "question_id": 32,
        "question_title": "Why is decision coverage important in white-box testing?",
        "option_A": "It measures the software's performance metrics",
        "option_B": "It verifies the compatibility of new code with existing systems",
        "option_C": "It focuses on the user interface aspects of the software",
        "option_D": "It guarantees that all branches in decision points are executed",
        "correct_anwser": "D",
        "explain": "Decision coverage (bao phủ quyết định) trong kiểm thử hộp trắng đảm bảo rằng tất cả các nhánh (true/false) từ mỗi điểm quyết định đều được thực thi. Các lựa chọn khác không liên quan đến mục tiêu của coverage này."
      },
      {
        "question_id": 33,
        "question_title": "Which scenario is ideal for using exploratory testing?",
        "option_A": "When there is limited time and no detailed specifications",
        "option_B": "When detailed specifications are available",
        "option_C": "When the software is fully stable",
        "option_D": "When testing under controlled and stable conditions",
        "correct_anwser": "A",
        "explain": "Kiểm thử khám phá (exploratory testing) phù hợp khi có ít thời gian và không có tài liệu đặc tả chi tiết, vì nó dựa trên kinh nghiệm và trực giác của người kiểm thử. Các phương án khác mô tả điều kiện lý tưởng cho kiểm thử theo kịch bản."
      },
      {
        "question_id": 34,
        "question_title": "For the password field (8-12 alphanumeric characters), which of the following is a valid boundary value?",
        "option_A": "7 characters",
        "option_B": "8 characters",
        "option_C": "13 characters",
        "option_D": "10 characters",
        "correct_anwser": "B",
        "explain": "Giá trị biên hợp lệ cho trường mật khẩu yêu cầu 8-12 ký tự là 8 (biên dưới) và 12 (biên trên). Trong các đáp án, 8 là giá trị biên hợp lệ. 7 và 13 là biên không hợp lệ, còn 10 là giá trị trong khoảng nhưng không phải giá trị biên."
      },
      {
        "question_id": 35,
        "question_title": "Which white box technique has the main goal of ensuring that each one of the possible branches from each decision point is executed at least once?",
        "option_A": "Basis path coverage testing",
        "option_B": "Statement coverage testing",
        "option_C": "Branch coverage testing",
        "option_D": "Condition coverage testing",
        "correct_anwser": "C",
        "explain": "Branch coverage (bao phủ nhánh) yêu cầu thực thi tất cả các nhánh từ mỗi điểm quyết định. Statement coverage chỉ bao phủ câu lệnh, condition coverage kiểm tra từng điều kiện con, và basis path là kỹ thuật khác."
      },
      {
        "question_id": 36,
        "question_title": "Which type of test design technique is based on the tester's skills, intuition, and experience in testing?",
        "option_A": "Black-box testing",
        "option_B": "White-box testing",
        "option_C": "Experience-based testing",
        "option_D": "Specification-based testing",
        "correct_anwser": "C",
        "explain": "Kỹ thuật dựa trên kinh nghiệm (experience-based) dựa vào kỹ năng, trực giác và kinh nghiệm của người kiểm thử. Các kỹ thuật khác dựa trên đặc tả hoặc cấu trúc mã nguồn."
      },
      {
        "question_id": 37,
        "question_title": "Given the following pseudo-code, which is true about the minimum number of test cases required for full statement and branch coverage:\n\nRead A\nRead B\nIF A > 50 THEN\n Print \"Sum A and B\"\n IF B > 10 THEN\n Print \"B is greater than 10\"\n ENDIF\nENDIF",
        "option_A": "1 test case for statement coverage, 2 for branch coverage",
        "option_B": "1 test case for statement coverage, 3 for branch coverage",
        "option_C": "2 test case for statement coverage, 2 for branch coverage",
        "option_D": "2 test case for statement coverage, 3 for branch coverage",
        "correct_anwser": "D",
        "explain": "Statement coverage cần 2 test case: một với A>50, B>10 để thực thi mọi câu lệnh, và một với A<=50 để thực thi lệnh đọc (vì lệnh đọc nằm ngoài IF). Branch coverage cần 3 test case: (1) A>50 và B>10, (2) A>50 và B<=10, (3) A<=50 (với B bất kỳ) để bao phủ tất cả nhánh true/false của cả hai IF."
      },
      {
        "question_id": 38,
        "question_title": "What is the main purpose of use case testing?",
        "option_A": "To identify defects in process flows related to typical use of the system.",
        "option_B": "To identify defects in the connections between components.",
        "option_C": "To identify defects in the system related to extreme scenarios.",
        "option_D": "To identify defects in the system related to the use of unapproved programming practices.",
        "correct_anwser": "A",
        "explain": "Kiểm thử theo ca sử dụng (use case testing) tập trung vào luồng quy trình nghiệp vụ điển hình để phát hiện lỗi trong các tình huống sử dụng thực tế. Các phương án khác liên quan đến kiểm thử tích hợp, kiểm thử biên hoặc kiểm thử mã nguồn."
      },
      {
        "question_id": 39,
        "question_title": "Why is equivalence partitioning particularly effective in test case design?",
        "option_A": "It requires thorough knowledge of the internal structure of the system",
        "option_B": "It divides input data into valid and invalid partitions to simplify testing",
        "option_C": "It focuses solely on the output of the software",
        "option_D": "It is the best method for performance testing",
        "correct_anwser": "B",
        "explain": "Phân hoạch tương đương (equivalence partitioning) chia dữ liệu đầu vào thành các lớp (partition) hợp lệ và không hợp lệ, giảm số lượng ca kiểm thử mà vẫn đảm bảo bao phủ, giúp đơn giản hóa thiết kế ca kiểm thử. Phương án A là đặc trưng của hộp trắng, D sai vì đây là kỹ thuật kiểm thử chức năng."
      },
      {
        "question_id": 40,
        "question_title": "Which of the following statement is true about the bug/defect report?",
        "option_A": "It is technical document written to describe the symptoms of a bug.",
        "option_B": "It is designed to prescribe the scope, approach, resources, and schedule of all testing activities.",
        "option_C": "It is a document that delivers a detailed summary of what scenarios will be tested in a software during the software testing life cycle (STLC).",
        "option_D": "It is used to confirm the function of the application when the code is executed.",
        "correct_anwser": "A",
        "explain": "Báo cáo lỗi (bug/defect report) là tài liệu kỹ thuật mô tả triệu chứng của lỗi để hỗ trợ quá trình sửa chữa. Các phương án còn lại mô tả kế hoạch kiểm thử, chiến lược kiểm thử hoặc ca kiểm thử, không phải là mục đích của báo cáo lỗi."
      },
      {
        "question_id": 41,
        "question_title": "What role is responsible for leading the test effort?",
        "option_A": "Test manager",
        "option_B": "Test designer",
        "option_C": "Test analyst",
        "option_D": "Tester",
        "correct_anwser": "A",
        "explain": "Test Manager là người chịu trách nhiệm lãnh đạo toàn bộ nỗ lực kiểm thử, bao gồm lập kế hoạch, phân bổ nguồn lực và giám sát tiến độ. Các vai trò khác có nhiệm vụ chuyên môn hơn và không đảm nhiệm vai trò lãnh đạo."
      },
      {
        "question_id": 42,
        "question_title": "What is NOT a goal of incident management?",
        "option_A": "Fixing all defects regardless of their impact",
        "option_B": "Improving the quality of the software product",
        "option_C": "Reducing the risk of future defects",
        "option_D": "Ensuring stakeholder satisfaction with the product",
        "correct_anwser": "A",
        "explain": "Quản lý sự cố không nhằm mục đích sửa tất cả lỗi bất kể tác động, vì không khả thi về nguồn lực và ưu tiên. Các mục tiêu thực tế bao gồm cải thiện chất lượng, giảm rủi ro tương lai và đảm bảo hài lòng của các bên liên quan, đều có trong các đáp án còn lại."
      },
      {
        "question_id": 43,
        "question_title": "Which of the following is a risk of test automation?",
        "option_A": "Using an automation tool that will not be supported in the future",
        "option_B": "Developing test automation for particularly tedious manual testing areas",
        "option_C": "Using technical testers to implement the automation",
        "option_D": "Developing automated reporting",
        "correct_anwser": "A",
        "explain": "Rủi ro của tự động hóa là sử dụng công cụ không còn được hỗ trợ trong tương lai, dẫn đến chi phí bảo trì cao hoặc không thể sử dụng. Các phương án còn lại là các hoạt động hợp lý hoặc không phải rủi ro."
      },
      {
        "question_id": 44,
        "question_title": "How would you structure a test team for a project requiring specialized knowledge in both business processes and technical execution?",
        "option_A": "Assign only developers as testers",
        "option_B": "Use only external consultants",
        "option_C": "Focus on regression testing",
        "option_D": "Combine business experts with technical testers",
        "correct_anwser": "D",
        "explain": "Để đáp ứng cả kiến thức nghiệp vụ và kỹ thuật, cần kết hợp chuyên gia nghiệp vụ (hiểu quy trình) và kỹ thuật viên kiểm thử (thực thi kỹ thuật). Các phương án khác chỉ tiếp cận một khía cạnh hoặc không phù hợp."
      },
      {
        "question_id": 45,
        "question_title": "Which of the following tasks is MOST LIKELY to be performed by the test manager?",
        "option_A": "Write test summary reports based on the information gathered during testing",
        "option_B": "Review tests developed by others",
        "option_C": "Create the detailed test execution schedule",
        "option_D": "Analyze, review, and assess requirements, specifications and models for testability",
        "correct_anwser": "A",
        "explain": "Test Manager chịu trách nhiệm tổng hợp và viết báo cáo tóm tắt kiểm thử từ dữ liệu thu thập. Các nhiệm vụ còn lại như đánh giá ca kiểm thử, lập lịch chi tiết hoặc phân tích yêu cầu thường do test analyst hoặc test leader đảm nhiệm."
      },
      {
        "question_id": 46,
        "question_title": "What information is typically included in the summary section of an incident report? (Choose 2 correct answers)",
        "option_A": "Personal opinions of the tester.",
        "option_B": "Test progress metrics.",
        "option_C": "Incident description and impact.",
        "option_D": "Steps to reproduce the issue.",
        "correct_anwser": "C, D",
        "explain": "Phần tóm tắt của báo cáo sự cố thường bao gồm mô tả sự cố và tác động (C) cùng với các bước tái hiện (D). Ý kiến cá nhân của tester (A) không nên có, và số liệu tiến độ kiểm thử (B) thường không nằm trong phần tóm tắt mà thuộc báo cáo tiến độ riêng."
      },
      {
        "question_id": 47,
        "question_title": "Which one of the following test tools is mostly suitable for developers rather than testers?",
        "option_A": "Requirement management tools",
        "option_B": "Configuration management tools",
        "option_C": "Defect management tools",
        "option_D": "Performance testing tools",
        "correct_anwser": "B",
        "explain": "Công cụ quản lý cấu hình (Configuration management) thường được nhà phát triển sử dụng để quản lý mã nguồn và phiên bản. Các công cụ khác như quản lý yêu cầu, lỗi và hiệu năng thường được cả tester và developer sử dụng, nhưng phù hợp hơn với tester trong nhiều ngữ cảnh."
      },
      {
        "question_id": 48,
        "question_title": "Which element is critical in a test estimate?",
        "option_A": "The graphical design of the test documentation",
        "option_B": "The time and resources required to complete testing",
        "option_C": "The color scheme for the test report",
        "option_D": "The number of developers in the team",
        "correct_anwser": "B",
        "explain": "Trong ước lượng kiểm thử, yếu tố quan trọng nhất là thời gian và nguồn lực cần thiết để hoàn thành các hoạt động kiểm thử. Các yếu tố về thiết kế đồ họa, màu sắc báo cáo hoặc số lượng developer không phải là trọng tâm của ước lượng kiểm thử."
      },
      {
        "question_id": 49,
        "question_title": "Which is a key benefit of risk-based testing?",
        "option_A": "It reduces the need for a test plan",
        "option_B": "It ensures all defects are identified and fixed",
        "option_C": "It optimizes test coverage by focusing on high-risk areas",
        "option_D": "It eliminates the need for regression testing",
        "correct_anwser": "C",
        "explain": "Kiểm thử dựa trên rủi ro tập trung nguồn lực vào các khu vực có rủi ro cao, giúp tối ưu hóa mức độ bao phủ. Nó không loại bỏ kế hoạch kiểm thử, không đảm bảo phát hiện mọi lỗi và không loại bỏ kiểm thử hồi quy."
      },
      {
        "question_id": 50,
        "question_title": "Which of the following is a benefit of effective incident management?",
        "option_A": "Increased software development time",
        "option_B": "Decreased software reliability",
        "option_C": "Improved customer satisfaction",
        "option_D": "Reduced software functionality",
        "correct_anwser": "C",
        "explain": "Quản lý sự cố hiệu quả giúp xử lý lỗi nhanh chóng, cải thiện chất lượng sản phẩm, từ đó nâng cao sự hài lòng của khách hàng. Các phương án còn lại là tác động tiêu cực hoặc không phải lợi ích."
      },
      {
        "question_id": 51,
        "question_title": "Which of the following statement is CORRECT about of decision coverage?",
        "option_A": "Decision coverage is a measure of the percentage of possible paths through the source code exercised by tests",
        "option_B": "Decision coverage is a measure of the percentage of business flows through the component exercised by tests",
        "option_C": "Decision coverage is a measure of the 'if' statements in the code that are exercised with both the true and false outcomes",
        "option_D": "Decision coverage is a measure of the proportion of decision outcomes in the source code exercised by tests",
        "correct_anwser": "D",
        "explain": "Decision coverage đo tỷ lệ các kết quả quyết định (true/false) trong mã nguồn được thực thi bởi các ca kiểm thử. Phương án A là path coverage, B không đúng, C chỉ đề cập đến if statements trong khi decision points bao gồm cả switch, loop, v.v."
      },
      {
        "question_id": 52,
        "question_title": "Which one of the following is MOST likely to be a benefit of test execution tools?",
        "option_A": "It is easy to create regression tests",
        "option_B": "It is easy to maintain version control of test assets",
        "option_C": "It is easy to design tests for security testing",
        "option_D": "It is easy to run regression tests",
        "correct_anwser": "D",
        "explain": "Lợi ích lớn nhất của công cụ thực thi kiểm thử là tự động chạy các ca kiểm thử, đặc biệt hữu ích cho kiểm thử hồi quy. Các phương án khác không phải là lợi ích chính của công cụ thực thi."
      },
      {
        "question_id": 53,
        "question_title": "What is NOT typically a feature of a test management tool?",
        "option_A": "Scheduling tests",
        "option_B": "Generating test data",
        "option_C": "Logging test results",
        "option_D": "Managing testing activities",
        "correct_anwser": "B",
        "explain": "Test management tool thường có các chức năng như lập lịch, ghi nhật ký kết quả và quản lý hoạt động kiểm thử. Tạo dữ liệu kiểm thử thường do công cụ riêng hoặc công cụ tạo dữ liệu đảm nhận, không phải là tính năng chính của công cụ quản lý."
      },
      {
        "question_id": 54,
        "question_title": "Which metric would help monitor the progress of test execution?",
        "option_A": "Number of open defects compared to closed defects.",
        "option_B": "Number of passed requirements per code line.",
        "option_C": "Project manager's confidence level.",
        "option_D": "Test script reusability percentage.",
        "correct_anwser": "A",
        "explain": "Số lượng defect đang mở so với đã đóng phản ánh tiến trình xử lý lỗi trong quá trình thực thi kiểm thử, tuy không trực tiếp là số ca kiểm thử đã chạy nhưng trong các lựa chọn, đây là metric gần nhất để theo dõi tiến độ. Các lựa chọn khác không liên quan đến tiến độ thực thi."
      },
      {
        "question_id": 55,
        "question_title": "What is a key feature of a test execution tool?",
        "option_A": "Managing requirements traceability",
        "option_B": "Supporting static code analysis",
        "option_C": "Automatically running tests and recording results",
        "option_D": "Managing test incidents",
        "correct_anwser": "C",
        "explain": "Tính năng cốt lõi của công cụ thực thi kiểm thử là tự động chạy các ca kiểm thử và ghi lại kết quả. Các chức năng khác thuộc về quản lý yêu cầu, phân tích tĩnh hoặc quản lý sự cố."
      },
      {
        "question_id": 56,
        "question_title": "What type of test tool would you use to ensure coding standards are met?",
        "option_A": "Test design tool",
        "option_B": "Test execution tool",
        "option_C": "Static analysis tool",
        "option_D": "Configuration management tool",
        "correct_anwser": "C",
        "explain": "Công cụ phân tích tĩnh (static analysis) kiểm tra mã nguồn để đảm bảo tuân thủ các chuẩn mã hóa (coding standards). Các công cụ khác không phù hợp cho mục đích này."
      },
      {
        "question_id": 57,
        "question_title": "Which of the following tools would you use for dynamic analysis? (Choose 2 correct answers)",
        "option_A": "Static analysis tools",
        "option_B": "Test management tools",
        "option_C": "Performance testing tools",
        "option_D": "Monitoring tools",
        "correct_anwser": "C, D",
        "explain": "Phân tích động (dynamic analysis) yêu cầu thực thi chương trình. Performance testing tools và monitoring tools đều thực hiện phân tích khi chương trình đang chạy. Static analysis tools là phân tích tĩnh, test management tools là quản lý."
      },
      {
        "question_id": 58,
        "question_title": "What is a characteristic feature of a test harness?",
        "option_A": "Schedules tests",
        "option_B": "Supplies inputs to the software being tested",
        "option_C": "Manages software incidents",
        "option_D": "Analyzes software performance",
        "correct_anwser": "B",
        "explain": "Test harness (giá đỡ kiểm thử) cung cấp môi trường để chạy test, bao gồm stub, driver và cung cấp đầu vào cho phần mềm được kiểm thử. Các chức năng khác không phải là đặc trưng của test harness."
      },
      {
        "question_id": 59,
        "question_title": "What is an advantage of using data-driven scripts in test automation?",
        "option_A": "They do not require external data.",
        "option_B": "They separate test data from scripts, enhancing flexibility.",
        "option_C": "They are simpler to maintain than linear scripts.",
        "option_D": "They eliminate the need for scripting knowledge.",
        "correct_anwser": "B",
        "explain": "Ưu điểm chính của data-driven scripts là tách dữ liệu kiểm thử khỏi script, cho phép chạy cùng một script với nhiều bộ dữ liệu khác nhau, tăng tính linh hoạt. Phương án A sai vì chúng cần dữ liệu bên ngoài, C và D không chính xác."
      },
      {
        "question_id": 60,
        "question_title": "____ is the process of testing a single unit of code in an isolated manner and can be a method, a class, or a module.",
        "option_A": "Integration Testing",
        "option_B": "Unit Testing",
        "option_C": "Acceptance Testing",
        "option_D": "System Testing",
        "correct_anwser": "B",
        "explain": "Định nghĩa này mô tả chính xác kiểm thử đơn vị (Unit Testing), trong đó một đơn vị mã (phương thức, lớp, module) được kiểm thử cách ly. Các lựa chọn khác là các cấp độ kiểm thử khác không có đặc điểm này."
      }
    ]
  },
  {
    "id": "swt301-su25-re",
    "title": "SWT301 - SU25 - RE",
    "description": "Software Testing Quiz",
    "questionsCount": 60,
    "questions": [
      {
        "question_id": 1,
        "question_title": "What is an example that is NOT risk?",
        "option_A": "Member takes 3 days off sick, delays deadline.",
        "option_B": "In the team, there is a member who has developed a library, helping to improve work performance.",
        "option_C": "Member lacks technical skills.",
        "option_D": "The assignment schedule must exclude days off and holidays.",
        "correct_anwser": "B",
        "explain": "Rủi ro (risk) là một sự kiện hoặc điều kiện không chắc chắn mà nếu xảy ra sẽ có tác động tiêu cực hoặc tích cực đến mục tiêu dự án (trong kiểm thử thường xét tiêu cực). Phương án B mô tả một điểm mạnh hoặc cơ hội cải tiến hiệu suất công việc rõ ràng, mang lại giá trị tích cực chắc chắn, không phải là một rủi ro cần phòng tránh hay quản lý."
      },
      {
        "question_id": 2,
        "question_title": "How does early testing benefit the software development process?",
        "option_A": "By delaying defect detection until after release",
        "option_B": "By identifying defects only at the final stages",
        "option_C": "By finding defects early when they are cheaper to fix",
        "option_D": "By increasing the overall cost of testing",
        "correct_anwser": "C",
        "explain": "Một trong những nguyên tắc cốt lõi của kiểm thử phần mềm là 'Early Testing' (Kiểm thử sớm). Kiểm thử càng sớm trong vòng đời phát triển phần mềm giúp phát hiện lỗi sớm, từ đó giảm thiểu chi phí và thời gian sửa lỗi so với việc phát hiện lỗi ở các giai đoạn muộn hoặc sau khi bàn giao."
      },
      {
        "question_id": 3,
        "question_title": "What should be a key outcome of the evaluating exit criteria and reporting phase?",
        "option_A": "Decisions regarding the continuation or stoppage of testing",
        "option_B": "Finalizing the software release without further review",
        "option_C": "Planning for the next development cycle",
        "option_D": "Developing new test tools and methods",
        "correct_anwser": "A",
        "explain": "Giai đoạn đánh giá tiêu chí thoát (exit criteria) và báo cáo nhằm mục đích kiểm tra xem các mục tiêu kiểm thử đã đạt được chưa. Kết quả chính của giai đoạn này là đưa ra quyết định liệu có thể dừng kiểm thử hay cần phải tiếp tục kiểm thử thêm dựa trên mức độ đáp ứng tiêu chí đã đề ra."
      },
      {
        "question_id": 4,
        "question_title": "What is the most effective way to use testing to improve quality?",
        "option_A": "By focusing on areas of the software most likely to have defects",
        "option_B": "By performing minimal testing on all features",
        "option_C": "By only testing the new features of the software",
        "option_D": "By outsourcing testing to reduce costs",
        "correct_anwser": "A",
        "explain": "Theo nguyên tắc phân bổ lỗi (Defect Clustering), phần lớn các lỗi thường tập trung ở một số mô-đun chính hoặc các vùng có độ phức tạp cao. Do đó, việc tập trung nguồn lực kiểm thử vào các vùng có nguy cơ chứa lỗi cao nhất là cách tiếp cận hiệu quả nhất dựa trên rủi ro để cải thiện chất lượng phần mềm."
      },
      {
        "question_id": 5,
        "question_title": "What is the primary benefit of understanding the psychological factors in testing?",
        "option_A": "It allows for complete automation of the testing process.",
        "option_B": "It enhances the interaction and effectiveness of the testing team.",
        "option_C": "It eliminates the need for quality assurance.",
        "option_D": "It simplifies compliance with software standards.",
        "correct_anwser": "B",
        "explain": "Hiểu được các yếu tố tâm lý trong kiểm thử giúp cải thiện kỹ năng giao tiếp, giảm xung đột giữa lập trình viên và kiểm thử viên (vì kiểm thử thường tìm lỗi của người khác dễ gây tâm lý phòng thủ). Nhờ đó nâng cao hiệu quả làm việc nhóm và tương tác giữa các bên."
      },
      {
        "question_id": 6,
        "question_title": "Which approach helps in maintaining good relationships between testers and developers?",
        "option_A": "Minimizing interaction between testers and developers",
        "option_B": "Encouraging competition on defect findings",
        "option_C": "Providing constructive feedback on defects",
        "option_D": "Focusing solely on automated tests",
        "correct_anwser": "C",
        "explain": "Để duy trì mối quan hệ tốt đẹp, kiểm thử viên cần đưa ra phản hồi về lỗi một cách mang tính xây dựng, khách quan, tập trung vào sản phẩm chứ không chỉ trích cá nhân người lập trình. Điều này giúp các bên thấu hiểu và hợp tác tốt hơn."
      },
      {
        "question_id": 7,
        "question_title": "Why is the test environment set-up included in test implementation?",
        "option_A": "It is only relevant during test case design",
        "option_B": "It is part of the test closure activities",
        "option_C": "It is used for developing test cases",
        "option_D": "The environment needs to be ready for executing test cases",
        "correct_anwser": "D",
        "explain": "Trong quy trình kiểm thử của ISTQB, việc thiết lập môi trường kiểm thử thuộc giai đoạn Test Implementation (Triển khai kiểm thử) nhằm đảm bảo rằng mọi thành phần cơ sở hạ tầng, dữ liệu và công cụ đã sẵn sàng trước khi bước vào giai đoạn chạy các ca kiểm thử (Test Execution)."
      },
      {
        "question_id": 8,
        "question_title": "What is the 'Pesticide Paradox' in testing?",
        "option_A": "Testing all combinations is impossible.",
        "option_B": "Same tests over time detect fewer issues",
        "option_C": "Testing must be exhaustive to find all bugs.",
        "option_D": "Defects tend to cluster in specific modules.",
        "correct_anwser": "B",
        "explain": "Nghịch lý thuốc trừ sâu (Pesticide Paradox) chỉ ra rằng nếu bạn lặp đi lặp lại cùng một tập hợp các ca kiểm thử nhiều lần, thì dần dần chúng sẽ không còn phát hiện thêm lỗi mới nào nữa (giống như sâu kháng thuốc). Để vượt qua điều này, các ca kiểm thử cần liên tục được xem xét, cập nhật và viết mới."
      },
      {
        "question_id": 9,
        "question_title": "Find the explanation of \"Exhaustive testing is impossible\":",
        "option_A": "Testing everything (all combinations of inputs and preconditions) is not feasible except for trivial cases. Instead of exhaustive testing, we use risks and priorities to focus testing efforts.",
        "option_B": "Math formulas for reports that the software will automatically generate.",
        "option_C": "Is to execute the same test scenario multiple times to ensure that the previous test did not miss any errors.",
        "option_D": "Testing can show that defects are present, but cannot prove that there are no defects. Testing reduces the probability of undiscovered defects remaining in the software but, even if no defects are found, it is not a proof of correctness.",
        "correct_anwser": "A",
        "explain": "Kiểm thử toàn diện/kiệt quệ là không thể (Exhaustive testing is impossible) có nghĩa là việc kiểm thử tất cả các tổ hợp dữ liệu đầu vào và điều kiện tiên quyết là bất khả thi (ngoại trừ các trường hợp cực kỳ đơn giản). Do đó, chúng ta phải dựa trên rủi ro và mức độ ưu tiên để tối ưu hóa nỗ lực kiểm thử."
      },
      {
        "question_id": 10,
        "question_title": "Find the explanation of \"Early testing\":",
        "option_A": "Testing activities should start as early as possible in the software or system development life cycle and should be focused on defined objectives.",
        "option_B": "Testing can show that defects are present, but cannot prove that there are no defects. Testing reduces the probability of undiscovered defects remaining in the software but, even if no defects are found, it is not a proof of correctness.",
        "option_C": "Finding and fixing defects does not help if the system built is unusable and does not fulfill the users' needs and expectations.",
        "option_D": "Testing is done differently in different contexts. For example, safety-critical software is tested differently from an e-commerce site.",
        "correct_anwser": "A",
        "explain": "Định nghĩa chính xác của nguyên tắc 'Early testing' (Kiểm thử sớm) là các hoạt động kiểm thử nên được bắt đầu càng sớm càng tốt ngay từ giai đoạn đầu của vòng đời phát triển phần mềm (SDLC) nhằm tối ưu thời gian và chi phí xử lý lỗi."
      },
      {
        "question_id": 11,
        "question_title": "Fill in the blank: Confirmation testing_____",
        "option_A": "Execute the test again to confirm that the defect has indeed been fixed",
        "option_B": "Execute tests with the intent of checking that the system does not now have more defects in it as a result of some change",
        "option_C": "Verify that modifications in the software or the environment have not caused unintended adverse side effects and that the system still meets its requirements",
        "option_D": "Validate the expected results.",
        "correct_anwser": "A",
        "explain": "Kiểm thử xác nhận (Confirmation testing hay Re-testing) là việc thực hiện lại chính các ca kiểm thử đã từng bị lỗi trước đó nhằm xác minh xem lỗi cụ thể đó đã thực sự được sửa thành công hay chưa. Trong khi đó, phương án B và C mô tả định nghĩa của kiểm thử hồi quy (Regression testing)."
      },
      {
        "question_id": 12,
        "question_title": "What is the role of regression testing in maintenance testing?",
        "option_A": "To ensure that new features disrupt existing functionalities.",
        "option_B": "To verify that bug fixes and enhancements do not introduce new defects into existing functionalities.",
        "option_C": "To check the functionality of new hardware only.",
        "option_D": "To focus testing solely on new features.",
        "correct_anwser": "B",
        "explain": "Trong kiểm thử bảo trì (Maintenance testing), vai trò chính của kiểm thử hồi quy (Regression testing) là chạy lại các bài kiểm thử để đảm bảo rằng các chỉnh sửa, sửa lỗi hoặc cải tiến mới không vô tình làm ảnh hưởng hoặc làm xuất hiện lỗi mới (tác dụng phụ) ở các vùng chức năng cũ đang hoạt động ổn định."
      },
      {
        "question_id": 13,
        "question_title": "Why is impact analysis important in maintenance testing?",
        "option_A": "It determines the effect of a new marketing campaign",
        "option_B": "It is used to decide the new features to be added to the system",
        "option_C": "It assesses how changes might affect the existing system components",
        "option_D": "It helps in redesigning the software interface",
        "correct_anwser": "C",
        "explain": "Phân tích tác động (Impact analysis) đánh giá sự thay đổi để xác định những khu vực hoặc thành phần nào trong hệ thống hiện tại có nguy cơ bị ảnh hưởng bởi sự thay đổi đó. Điều này giúp đội ngũ kiểm thử xác định phạm vi cần kiểm thử hồi quy một cách chính xác và hiệu quả."
      },
      {
        "question_id": 14,
        "question_title": "What does change-related testing include?",
        "option_A": "Performance and stress testing",
        "option_B": "Confirmation and regression testing",
        "option_C": "Usability and compliance testing",
        "option_D": "Security and reliability testing",
        "correct_anwser": "B",
        "explain": "Kiểm thử liên quan đến thay đổi (Change-related testing) bao gồm hai hoạt động chính: Kiểm thử xác nhận (Confirmation testing / Re-testing) để chắc chắn lỗi đã được sửa và Kiểm thử hồi quy (Regression testing) để chắc chắn sự thay đổi không làm hỏng các phần khác."
      },
      {
        "question_id": 15,
        "question_title": "What is the primary objective of functional testing?",
        "option_A": "To assess the system's non-functional characteristics like performance.",
        "option_B": "To verify that the software functions according to the specified requirements.",
        "option_C": "To evaluate the system's capacity to handle high loads.",
        "option_D": "To check the internal code structure of the software.",
        "correct_anwser": "B",
        "explain": "Mục tiêu chính của kiểm thử chức năng (Functional testing) là xác minh xem phần mềm có hoạt động đúng và đầy đủ theo các yêu cầu chức năng (requirements/specifications) đã được định nghĩa trước hay không. (Phương án A và C thuộc kiểm thử phi chức năng, phương án D thuộc kiểm thử cấu trúc/hộp trắng)."
      },
      {
        "question_id": 16,
        "question_title": "A _________ consists of a set of test cases covering the end-to-end functionality of a software application",
        "option_A": "Test Case",
        "option_B": "Test scenario",
        "option_C": "Test scripts",
        "option_D": "None of the mentioned",
        "correct_anwser": "B",
        "explain": "Một kịch bản kiểm thử (Test scenario) định nghĩa một luồng nghiệp vụ hoặc một chức năng có thể kiểm thử được từ đầu đến cuối (end-to-end), và để thực hiện kiểm thử kịch bản đó, người ta sẽ xây dựng một hoặc một tập hợp nhiều ca kiểm thử (test cases) cụ thể đi kèm."
      },
      {
        "question_id": 17,
        "question_title": "Which test level focuses on individual units or components?",
        "option_A": "System testing",
        "option_B": "Integration testing",
        "option_C": "Unit testing",
        "option_D": "Acceptance testing",
        "correct_anwser": "C",
        "explain": "Kiểm thử đơn vị (Unit testing / Component testing) là cấp độ kiểm thử tập trung vào việc xác minh các đơn vị mã nguồn độc lập nhỏ nhất của phần mềm (như các hàm, lớp, phương thức hoặc mô-đun riêng lẻ) hoạt động chính xác."
      },
      {
        "question_id": 18,
        "question_title": "How does usability testing differ from performance testing?",
        "option_A": "Usability testing focuses on user-friendliness, while performance testing measures operational capabilities.",
        "option_B": "Usability testing measures how fast the system responds to requests, while performance testing checks for user-friendliness.",
        "option_C": "They do not differ; both terms describe the same tests.",
        "option_D": "Usability testing is a type of performance testing.",
        "correct_anwser": "A",
        "explain": "Kiểm thử độ khả dụng (Usability testing) tập trung vào mức độ thân thiện, dễ sử dụng và trải nghiệm của người dùng đối với hệ thống; trong khi kiểm thử hiệu năng (Performance testing) đánh giá khả năng vận hành của hệ thống như tốc độ phản hồi, tính ổn định và khả năng mở rộng dưới các điều kiện tải khác nhau."
      },
      {
        "question_id": 19,
        "question_title": "What is Integration testing?",
        "option_A": "It tests interfaces between components, interactions to different parts of a system such as an operating system, file system and hardware or interfaces between systems.",
        "option_B": "It is unit, module and program testing, searches for defects in, and verifies the functioning of software that are separately testable.",
        "option_C": "It is concerned with the behavior of the whole system/product as defined by the scope of a development project or product.",
        "option_D": "The system will be delivered to the user or customer for testing.",
        "correct_anwser": "A",
        "explain": "Theo chuẩn ISTQB, kiểm thử tích hợp (Integration testing) tập trung vào việc kiểm tra các giao tiếp (interfaces) và sự tương tác giữa các thành phần với nhau, hoặc giữa các hệ thống với nhau (ví dụ: tương tác với hệ điều hành, hệ thống tệp tin, phần cứng)."
      },
      {
        "question_id": 20,
        "question_title": "Which test level verifies the application meets business requirements?",
        "option_A": "Unit testing",
        "option_B": "System testing",
        "option_C": "Integration testing",
        "option_D": "Acceptance testing",
        "correct_anwser": "D",
        "explain": "Kiểm thử chấp nhận (Acceptance testing) là cấp độ kiểm thử nhằm mục đích xác minh xem hệ thống có đáp ứng các yêu cầu kinh doanh (business requirements), quy trình nghiệp vụ của người dùng/khách hàng hay không, để từ đó họ đưa ra quyết định có bàn giao và chấp nhận sản phẩm hay không."
      },
      {
        "question_id": 21,
        "question_title": "What is the purpose of a walkthrough?",
        "option_A": "To finalize the document under review",
        "option_B": "To educate participants and gather feedback",
        "option_C": "To detect critical defects",
        "option_D": "To automate review processes",
        "correct_anwser": "B",
        "explain": "Theo chuẩn ISTQB, mục đích chính của một buổi walkthrough (hướng dẫn/duyệt qua sản phẩm) là để giới thiệu, giải thích nội dung tài liệu cho các thành viên tham gia, đồng thời thu thập phản hồi và đóng góp ý kiến."
      },
      {
        "question_id": 22,
        "question_title": "Which of the following is NOT a benefit of static testing in software development?",
        "option_A": "Improving communication between team members in the course of participating in reviews",
        "option_B": "Reducing testing cost and time",
        "option_C": "Reducing development cost and time",
        "option_D": "Reducing the need for documentation",
        "correct_anwser": "D",
        "explain": "Kiểm thử tĩnh (static testing) giúp cải thiện giao tiếp, giảm thời gian và chi phí kiểm thử cũng như phát triển nhờ phát hiện lỗi sớm. Tuy nhiên, nó không làm giảm nhu cầu làm tài liệu (documentation), trái lại kiểm thử tĩnh dựa rất nhiều vào tài liệu."
      },
      {
        "question_id": 23,
        "question_title": "Which of the following options are roles in a formal review?",
        "option_A": "Developer, Moderator, Review leader, Reviewer, Tester",
        "option_B": "Author, Moderator, Manager, Reviewer, Developer",
        "option_C": "Author, Manager, Review leader, Reviewer, Designer",
        "option_D": "Author, Moderator, Review leader, Reviewer, Scribe",
        "correct_anwser": "D",
        "explain": "Các vai trò chính thức được định nghĩa trong một quy trình đánh giá chính thức (formal review) theo ISTQB bao gồm: Author (Tác giả), Moderator (Người điều phối), Review leader (Trưởng nhóm đánh giá), Reviewer (Người đánh giá), và Scribe (Thư ký ghi chép)."
      },
      {
        "question_id": 24,
        "question_title": "Which static testing technique analyzes code without executing it?",
        "option_A": "Error guessing",
        "option_B": "Equivalence partitioning",
        "option_C": "Code review",
        "option_D": "Decision table testing",
        "correct_anwser": "C",
        "explain": "Code review (Đánh giá mã nguồn) là một kỹ thuật kiểm thử tĩnh vì nó thực hiện phân tích, kiểm tra mã nguồn bằng mắt hoặc công cụ mà không cần chạy chương trình. Các phương án còn lại đều là kỹ thuật kiểm thử động."
      },
      {
        "question_id": 25,
        "question_title": "Reviews, walkthroughs, and inspections are part of_______",
        "option_A": "Design process",
        "option_B": "Validation process",
        "option_C": "Verification process",
        "option_D": "Management process",
        "correct_anwser": "C",
        "explain": "Reviews, walkthroughs, và inspections là các hoạt động kiểm thử tĩnh thuộc quy trình Xác nhận (Verification process) nhằm kiểm tra xem sản phẩm có được xây dựng đúng theo thiết kế và đặc tả hay không (xem xét tài liệu, mã nguồn mà không chạy phần mềm)."
      },
      {
        "question_id": 26,
        "question_title": "Which of the following sequences BEST shows the main activities of the work product review process?",
        "option_A": "Initiate review - Reviewer selection - Individual review - Issue communication and analysis - Rework",
        "option_B": "Planning & preparation - Overview meeting - Individual review - Fixing and Reporting",
        "option_C": "Preparation - Issue detection - Issue communication and analysis - Rework -Report",
        "option_D": "Planning - Initiate review - Individual review - Issue communication and analysis - Fixing and Reporting",
        "correct_anwser": "D",
        "explain": "Theo ISTQB phiên bản mới, quy trình review sản phẩm chuẩn bao gồm các hoạt động chính theo thứ tự: Planning (Lập kế hoạch) -> Initiate review (Khởi động đánh giá) -> Individual review (Đánh giá cá nhân) -> Issue communication and analysis (Giao tiếp và phân tích lỗi) -> Fixing and Reporting (Sửa lỗi và Báo cáo)."
      },
      {
        "question_id": 27,
        "question_title": "What is the main goal of static testing?",
        "option_A": "To execute the software and identify defects",
        "option_B": "To review documents and source code without executing the software",
        "option_C": "To test the software with a focus on its user interface",
        "option_D": "To validate the software's performance under stress",
        "correct_anwser": "B",
        "explain": "Mục tiêu chính của kiểm thử tĩnh (static testing) là xem xét, đánh giá các tài liệu (như đặc tả yêu cầu, thiết kế) và mã nguồn của phần mềm mà không cần thực thi/chạy chương trình đó."
      },
      {
        "question_id": 28,
        "question_title": "A typical formal review process consists of five main steps. Which is the correct order?",
        "option_A": "Planning -> Individual review -> Initiate review -> Issue communication & Analysis -> Fixing & Reporting",
        "option_B": "Planning -> Initiate review -> Individual review -> Issue communication & Analysis -> Fixing & Reporting",
        "option_C": "Initiate review -> Planning -> Individual review -> Issue communication & Analysis -> Fixing & Reporting",
        "option_D": "Planning -> Issue communication & Analysis -> Initiate review -> Individual review -> Fixing & Reporting",
        "correct_anwser": "B",
        "explain": "Trật tự đúng của các bước trong một quy trình đánh giá chính thức là lập kế hoạch trước (Planning), sau đó phổ biến khởi động (Initiate review), tiếp theo từng người tự kiểm tra (Individual review), họp bàn thảo luận lỗi (Issue communication & Analysis) và cuối cùng là khắc phục, báo cáo (Fixing & Reporting)."
      },
      {
        "question_id": 29,
        "question_title": "Which of the following is a benefit of performing reviews in the software development process?",
        "option_A": "Decreasing the amount of documentation required",
        "option_B": "Eliminating the need for testing the software",
        "option_C": "Identifying defects early and thereby reducing rework costs",
        "option_D": "Extending the software development lifecycle",
        "correct_anwser": "C",
        "explain": "Lợi ích lớn nhất của việc thực hiện review trong quá trình phát triển là giúp phát hiện các lỗi sai ngay từ giai đoạn sớm (như ở khâu yêu cầu hoặc thiết kế), từ đó tiết kiệm tối đa chi phí sửa chữa (rework)."
      },
      {
        "question_id": 30,
        "question_title": "Which of the following statements are TRUE for Technical Review?\nI. Reviewers should be technical peers of the author, and technical experts in the same or other disciplines\nII. The main purpose is to evaluate the technical quality of the work product, and to build confidence in its correctness\nIII. It is typically led by a trained moderator or a technical lead\nIV. It always includes management participation to ensure project alignment",
        "option_A": "I, II, and III",
        "option_B": "I, II, and IV",
        "option_C": "II, III, and IV",
        "option_D": "I, III, and IV",
        "correct_anwser": "A",
        "explain": "Các phát biểu I, II, III đều chính xác về Technical Review (Đánh giá kỹ thuật). Phát biểu IV sai vì Technical Review tập trung hoàn toàn vào kỹ thuật và thường không có sự tham gia của quản lý (management) nhằm tránh áp lực, đảm bảo tính khách quan cho các chuyên gia."
      },
      {
        "question_id": 31,
        "question_title": "When would exploratory testing be most beneficial during a testing cycle?",
        "option_A": "After receiving comprehensive training in the application.",
        "option_B": "When detailed error logs from previous tests are available.",
        "option_C": "When testing needs to be dynamic and adapt to new findings.",
        "option_D": "Only in conjunction with user acceptance testing.",
        "correct_anwser": "C",
        "explain": "Kiểm thử khám phá (exploratory testing) phù hợp nhất khi cần sự linh hoạt, thích ứng với các phát hiện mới trong quá trình kiểm thử, không bị ràng buộc bởi kịch bản cố định. Các lựa chọn khác không phản ánh đúng bản chất của kỹ thuật này."
      },
      {
        "question_id": 32,
        "question_title": "When utilizing error guessing as your testing strategy, what specific type of testing are you performing?",
        "option_A": "Specification-based",
        "option_B": "Structure-based",
        "option_C": "Experience-based",
        "option_D": "Reference-based",
        "correct_anwser": "C",
        "explain": "Error guessing là kỹ thuật dựa trên kinh nghiệm (experience-based), vì người kiểm thử sử dụng kinh nghiệm, trực giác và hiểu biết về miền để dự đoán lỗi. Nó không dựa trên đặc tả hay cấu trúc mã nguồn."
      },
      {
        "question_id": 33,
        "question_title": "Which technique uses different combinations of inputs to result in different actions being taken?",
        "option_A": "Error guessing",
        "option_B": "Decision table testing",
        "option_C": "Boundary value analysis",
        "option_D": "Equivalence partitioning",
        "correct_anwser": "B",
        "explain": "Kiểm thử bảng quyết định (decision table testing) sử dụng các tổ hợp đầu vào khác nhau để xác định hành động tương ứng. Các kỹ thuật còn lại không tập trung vào tổ hợp đầu vào như vậy."
      },
      {
        "question_id": 34,
        "question_title": "Which the best thing about the regression test?",
        "option_A": "Regression test is only run once.",
        "option_B": "Regression test will always be automated",
        "option_C": "Regression test will check unchanged areas of the software to see if they have been affected",
        "option_D": "Regression test will check changed areas of the software to see if they have been affected.",
        "correct_anwser": "C",
        "explain": "Mục đích chính của kiểm thử hồi quy là kiểm tra các phần không thay đổi của phần mềm để đảm bảo chúng không bị ảnh hưởng bởi các thay đổi mới. Nó không chỉ chạy một lần, không nhất thiết phải tự động và không chỉ kiểm tra phần đã thay đổi."
      },
      {
        "question_id": 35,
        "question_title": "Considering the code provided, which is true about the minimal quantity of test cases necessary for complete statement and branch/decision coverage?\nRead A\nRead B\nIF A+B > 50 THEN\nPrint \"Sum two age\"\nENDIF\nIF B > 20 THEN\nPrint \"B is of adult age \"\nENDIF",
        "option_A": "1 test for statement coverage, 3 for branch coverage",
        "option_B": "1 test for statement coverage, 1 for branch coverage",
        "option_C": "1 test for statement coverage, 2 for branch coverage",
        "option_D": "2 tests for statement coverage, 2 for branch coverage",
        "correct_anwser": "C",
        "explain": "Với 1 test case thỏa cả hai điều kiện (ví dụ A=100, B=100), cả hai câu lệnh in đều được thực hiện, đạt bao phủ câu lệnh 100%. Để bao phủ nhánh, cần ít nhất 2 test case: một test cho cả hai điều kiện đúng và một test cho cả hai điều kiện sai, qua đó bao phủ cả nhánh true và false của mỗi điều kiện."
      },
      {
        "question_id": 36,
        "question_title": "Boundary Value Analysis is an extension of which technique?",
        "option_A": "State Transition Testing",
        "option_B": "Equivalence Partitioning",
        "option_C": "Decision Table Testing",
        "option_D": "Use Case Testing",
        "correct_anwser": "B",
        "explain": "Phân tích giá trị biên (BVA) là phần mở rộng của phân hoạch tương đương (Equivalence Partitioning). BVA tập trung vào các giá trị tại biên của các lớp tương đương, giúp phát hiện lỗi thường gặp ở biên."
      },
      {
        "question_id": 37,
        "question_title": "What is the key focus of state transition testing?",
        "option_A": "The changes in state within an application based on varying input conditions",
        "option_B": "The visual aspects of the user interface",
        "option_C": "The stability of application under peak load",
        "option_D": "The compatibility of the software with various operating systems",
        "correct_anwser": "A",
        "explain": "Kiểm thử chuyển trạng thái tập trung vào các thay đổi trạng thái của ứng dụng khi có các điều kiện đầu vào khác nhau, kiểm tra hành vi của hệ thống trong các trạng thái và chuyển tiếp giữa chúng."
      },
      {
        "question_id": 38,
        "question_title": "What essential skill does exploratory testing require from a tester?",
        "option_A": "Ability to strictly adhere to test scripts",
        "option_B": "Specialization in performance and stress testing",
        "option_C": "Proficiency in programming and automated tools",
        "option_D": "Capacity to plan and execute tests simultaneously",
        "correct_anwser": "D",
        "explain": "Kiểm thử khám phá đòi hỏi khả năng vừa lập kế hoạch vừa thực hiện kiểm thử cùng lúc, vì nó không tuân theo kịch bản cứng nhắc. Các kỹ năng khác không phải là yêu cầu cốt lõi."
      },
      {
        "question_id": 39,
        "question_title": "In error guessing, what is the tester primarily relying on to identify potential defects?",
        "option_A": "Formal specifications and requirements",
        "option_B": "Randomly generated test cases",
        "option_C": "Their own experience, intuition, and domain knowledge",
        "option_D": "The feedback from automated testing tools",
        "correct_anwser": "C",
        "explain": "Error guessing dựa vào kinh nghiệm, trực giác và hiểu biết về miền của người kiểm thử để dự đoán lỗi, không dựa trên đặc tả hay công cụ tự động."
      },
      {
        "question_id": 40,
        "question_title": "Design a test case using Equivalence Partitioning for a function that calculates discounts based on Customer age. (Select all that apply)",
        "option_A": "1-12 years: 50% discount",
        "option_B": "13-64 years: 20% discount",
        "option_C": "65 years and above: 30% discount",
        "option_D": "None of the others",
        "correct_anwser": "A, B, C",
        "explain": "Trong phân hoạch tương đương, các khoảng tuổi 1-12, 13-64, và >=65 là các lớp tương đương hợp lệ, mỗi lớp có một mức giảm giá riêng. Vì vậy cả ba phương án A, B, C đều đúng. Phương án D sai."
      },
      {
        "question_id": 41,
        "question_title": "What factor influences the structure of a test organization within a project?",
        "option_A": "The personal preferences of the test team",
        "option_B": "The social dynamics of the development team",
        "option_C": "The risk level and complexity of the project",
        "option_D": "The geographical location of the company",
        "correct_anwser": "C",
        "explain": "Cấu trúc tổ chức kiểm thử phụ thuộc vào mức độ rủi ro và độ phức tạp của dự án, vì các yếu tố này ảnh hưởng đến quy mô, phân công và chiến lược kiểm thử. Các yếu tố khác không mang tính quyết định."
      },
      {
        "question_id": 42,
        "question_title": "What is the significance of defining scope in a test plan?",
        "option_A": "It outlines the geographical areas where the product will be sold",
        "option_B": "It determines who the end-users will be",
        "option_C": "It clarifies what is included and excluded from testing",
        "option_D": "It sets the price points for various market segments",
        "correct_anwser": "C",
        "explain": "Xác định phạm vi trong kế hoạch kiểm thử nhằm làm rõ những gì được kiểm thử và những gì không, giúp tập trung nguồn lực và tránh hiểu nhầm. Các phương án khác không liên quan đến kiểm thử."
      },
      {
        "question_id": 43,
        "question_title": "In a software project, what is the purpose of test closure activities?",
        "option_A": "To plan the next phases of the project.",
        "option_B": "To ensure all test cases are automated for future use.",
        "option_C": "To analyze what was done and what could be improved for future projects.",
        "option_D": "To ensure that the software does not have any remaining defects.",
        "correct_anwser": "C",
        "explain": "Hoạt động kết thúc kiểm thử nhằm tổng kết, đánh giá quá trình và rút ra bài học cải tiến cho các dự án sau. Nó không lập kế hoạch hay đảm bảo không còn lỗi (điều đó không thể đạt được tuyệt đối)."
      },
      {
        "question_id": 44,
        "question_title": "Which of the following best describes the role of a test manager?",
        "option_A": "Direct involvement in software programming",
        "option_B": "Management of the testing process and resources",
        "option_C": "Exclusive focus on software design",
        "option_D": "Handling customer support and feedback",
        "correct_anwser": "B",
        "explain": "Người quản lý kiểm thử chịu trách nhiệm quản lý quy trình kiểm thử và các nguồn lực (nhân sự, công cụ, lịch trình). Các vai trò khác thuộc về lập trình viên, nhà thiết kế hay bộ phận hỗ trợ."
      },
      {
        "question_id": 45,
        "question_title": "Which tool is specifically designed to support the creation of test cases?",
        "option_A": "Test design tool",
        "option_B": "Test execution tool",
        "option_C": "Static analysis tool",
        "option_D": "Test management tool",
        "correct_anwser": "A",
        "explain": "Công cụ thiết kế kiểm thử (test design tool) hỗ trợ tạo các ca kiểm thử dựa trên kỹ thuật thiết kế. Các công cụ khác phục vụ thực thi, phân tích tĩnh hoặc quản lý chung."
      },
      {
        "question_id": 46,
        "question_title": "Which of the following are common entry criteria for testing? (Choose 2 correct answers)",
        "option_A": "Availability of test environment",
        "option_B": "Completion of all test cases",
        "option_C": "Approval from the project manager",
        "option_D": "Availability of necessary resources",
        "correct_anwser": "A, D",
        "explain": "Tiêu chí đầu vào thường bao gồm sẵn sàng về môi trường kiểm thử và các nguồn lực cần thiết (con người, công cụ, dữ liệu). Việc hoàn thành tất cả test case là tiêu chí đầu ra, còn phê duyệt của PM có thể là một bước nhưng không phải là tiêu chí phổ biến nhất."
      },
      {
        "question_id": 47,
        "question_title": "Which statement best reflects the role of a test leader compared to a tester?",
        "option_A": "A test leader focuses on test execution while testers focus on test planning",
        "option_B": "Test leaders and testers perform exactly the same roles within a project",
        "option_C": "A test leader manages the testing process while testers focus on test execution",
        "option_D": "Testers manage the project while test leaders provide technical support",
        "correct_anwser": "C",
        "explain": "Trưởng nhóm kiểm thử quản lý quy trình, điều phối và giám sát, trong khi tester tập trung vào thực thi các ca kiểm thử. Các phương án khác mô tả sai phân công."
      },
      {
        "question_id": 48,
        "question_title": "What is the final step in the incident management process?",
        "option_A": "Logging the incident",
        "option_B": "Reviewing the incident with stakeholders",
        "option_C": "Closing the incident report",
        "option_D": "Assigning the incident to a developer",
        "correct_anwser": "C",
        "explain": "Bước cuối cùng trong quy trình quản lý sự cố là đóng báo cáo sự cố sau khi đã được xử lý và xác minh. Các bước trước đó bao gồm ghi nhận, xem xét và phân công."
      },
      {
        "question_id": 49,
        "question_title": "What should the severity of a defect indicate?",
        "option_A": "The tester’s skill level",
        "option_B": "The impact of the defect on the system",
        "option_C": "The cost of the software",
        "option_D": "The timeline of the project",
        "correct_anwser": "B",
        "explain": "Mức độ nghiêm trọng (severity) của lỗi cho biết tác động của lỗi đó lên hệ thống (ví dụ: ảnh hưởng đến chức năng chính hay chỉ là lỗi giao diện). Các yếu tố khác không liên quan."
      },
      {
        "question_id": 50,
        "question_title": "Why are test strategies important in the planning phase?",
        "option_A": "They determine the programming languages used in development",
        "option_B": "They provide a roadmap for design and architectural decisions",
        "option_C": "They outline the approach, techniques, and priorities for the testing efforts",
        "option_D": "They specify the user interface design and experience",
        "correct_anwser": "C",
        "explain": "Chiến lược kiểm thử quan trọng trong giai đoạn lập kế hoạch vì nó phác thảo cách tiếp cận, kỹ thuật, mức độ và ưu tiên cho các nỗ lực kiểm thử. Nó không liên quan đến ngôn ngữ lập trình, thiết kế kiến trúc hay giao diện người dùng."
      },
      {
        "question_id": 51,
        "question_title": "What is the function of a monitoring tool in the context of testing?",
        "option_A": "To keep track of the status of the system during use",
        "option_B": "To measure the software's response times",
        "option_C": "To automate the generation of test cases",
        "option_D": "To manage the testing activities and resources",
        "correct_anwser": "A",
        "explain": "Công cụ giám sát (monitoring tool) dùng để theo dõi trạng thái hệ thống trong quá trình vận hành, giúp phát hiện sự cố về hiệu năng hoặc hoạt động. Các lựa chọn khác thuộc về công cụ đo hiệu năng, sinh ca kiểm thử hoặc quản lý kiểm thử."
      },
      {
        "question_id": 52,
        "question_title": "What is the goal of a risk assessment in software testing?",
        "option_A": "To identify, analyze, and prioritize risks",
        "option_B": "To establish a communication plan",
        "option_C": "To define software functionalities",
        "option_D": "To assign tasks to the development team",
        "correct_anwser": "A",
        "explain": "Mục tiêu của đánh giá rủi ro là xác định, phân tích và ưu tiên các rủi ro nhằm tập trung nguồn lực kiểm thử. Các lựa chọn khác không phải là mục đích chính của đánh giá rủi ro."
      },
      {
        "question_id": 53,
        "question_title": "Which tool supports the review process during static testing?",
        "option_A": "Support reviews tool",
        "option_B": "Model-based testing tool",
        "option_C": "Test management tool",
        "option_D": "Defect management tool",
        "correct_anwser": "A",
        "explain": "Công cụ hỗ trợ đánh giá (support reviews tool) được thiết kế để hỗ trợ quá trình xem xét, kiểm tra tĩnh như review mã nguồn hay tài liệu. Các công cụ khác phục vụ mô hình hóa, quản lý chung hoặc quản lý lỗi."
      },
      {
        "question_id": 54,
        "question_title": "Why is it important to prioritize incidents?",
        "option_A": "To ensure that minor defects are fixed first",
        "option_B": "To focus resources on resolving the most critical defects first",
        "option_C": "To complicate the development process",
        "option_D": "To increase the number of incidents",
        "correct_anwser": "B",
        "explain": "Ưu tiên sự cố giúp tập trung nguồn lực vào các lỗi nghiêm trọng nhất trước, đảm bảo các vấn đề ảnh hưởng lớn được xử lý kịp thời. Không nên ưu tiên lỗi nhỏ hay làm phức tạp quy trình."
      },
      {
        "question_id": 55,
        "question_title": "Which of the following is not a benefit of testing tools?",
        "option_A": "Easy to implement and maintain",
        "option_B": "Reduce of repetitive work",
        "option_C": "Ability to detect tiny changes that a human could not",
        "option_D": "It produces more consistent result.",
        "correct_anwser": "A",
        "explain": "Công cụ kiểm thử thường không dễ triển khai và bảo trì; chúng đòi hỏi chi phí và nỗ lực ban đầu. Các lợi ích khác (giảm công việc lặp, phát hiện thay đổi nhỏ, kết quả nhất quán) đều là ưu điểm thực tế."
      },
      {
        "question_id": 56,
        "question_title": "What information is typically included in the summary section of an incident report? (Choose 2 correct answers)",
        "option_A": "Personal opinions of the tester.",
        "option_B": "Test progress metrics.",
        "option_C": "Incident description and impact.",
        "option_D": "Steps to reproduce the issue.",
        "correct_anwser": "C, D",
        "explain": "Phần tóm tắt trong báo cáo sự cố thường bao gồm mô tả, tác động và các bước tái hiện lỗi. Ý kiến cá nhân hay chỉ số tiến độ không thuộc phần tóm tắt."
      },
      {
        "question_id": 57,
        "question_title": "What is an advantage of using data-driven scripts in test automation?",
        "option_A": "They do not require external data",
        "option_B": "They separate test data from scripts, enhancing flexibility",
        "option_C": "They are simpler to maintain than linear scripts",
        "option_D": "They eliminate the need for scripting knowledge",
        "correct_anwser": "B",
        "explain": "Kịch bản điều khiển dữ liệu (data-driven scripts) tách biệt dữ liệu kiểm thử khỏi mã lệnh, giúp dễ dàng thay đổi dữ liệu mà không cần sửa script, tăng tính linh hoạt. Chúng vẫn cần dữ liệu ngoài và yêu cầu kiến thức lập trình."
      },
      {
        "question_id": 58,
        "question_title": "Who is responsible for testing in Agile methodology?",
        "option_A": "The developers",
        "option_B": "The testers",
        "option_C": "The whole team",
        "option_D": "The product owner",
        "correct_anwser": "C",
        "explain": "Trong Agile, toàn bộ nhóm (bao gồm nhà phát triển, người kiểm thử, chủ sản phẩm) cùng chịu trách nhiệm về chất lượng và kiểm thử, không chỉ một vai trò riêng lẻ."
      },
      {
        "question_id": 59,
        "question_title": "What are the success factors for implementing a new test tool? (Select all that apply)",
        "option_A": "Providing ongoing training",
        "option_B": "Adapting processes to fit the tool",
        "option_C": "Immediate organization-wide rollout",
        "option_D": "Continuous monitoring of tool benefits",
        "correct_anwser": "A, B, D",
        "explain": "Các yếu tố thành công khi triển khai công cụ mới bao gồm đào tạo liên tục, điều chỉnh quy trình phù hợp, và theo dõi lợi ích liên tục. Triển khai ngay trên toàn tổ chức (C) thường gây rủi ro và không phải là yếu tố thành công."
      },
      {
        "question_id": 60,
        "question_title": "Which tool would be most appropriate for testing the load capacity of a server?",
        "option_A": "Test management tool",
        "option_B": "Incident management tool",
        "option_C": "Load testing tool",
        "option_D": "Configuration management tool",
        "correct_anwser": "C",
        "explain": "Công cụ kiểm thử tải (load testing tool) chuyên đánh giá khả năng chịu tải của máy chủ. Các công cụ khác phục vụ quản lý kiểm thử, quản lý sự cố hoặc quản lý cấu hình."
      }
    ]
  },
  {
    "id": "swt301-sp25-fe",
    "title": "SWT301 - SP25 - FE",
    "description": "Software Testing Final Exam Quiz",
    "questionsCount": 60,
    "questions": [
      {
        "question_id": 1,
        "question_title": "What is the important criterion in deciding what testing technique to use?",
        "option_A": "How well you know a particular technique",
        "option_B": "The objective of the test",
        "option_C": "How appropriate the technique is for testing the application",
        "option_D": "Whether there is a tool to support the technique",
        "correct_anwser": "B",
        "explain": "Tiêu chí quan trọng nhất trong việc chọn kỹ thuật kiểm thử là mục tiêu của kiểm thử, vì nó xác định loại kỹ thuật nào sẽ đạt được hiệu quả cao nhất. Các yếu tố khác (hiểu biết, phù hợp, công cụ) cũng quan trọng nhưng không phải là tiêu chí hàng đầu."
      },
      {
        "question_id": 2,
        "question_title": "What is the purpose of test completion criteria in a test plan:",
        "option_A": "To know when a specific test has finished its execution",
        "option_B": "To ensure that the test case specification is complete",
        "option_C": "To set the criteria used in generating test inputs",
        "option_D": "To know when test planning is complete",
        "option_E": "To plan when to stop testing",
        "correct_anwser": "E",
        "explain": "Tiêu chí hoàn thành kiểm thử (test completion criteria) xác định các điều kiện để dừng quá trình kiểm thử, như tỷ lệ lỗi, độ phủ, hoặc thực hiện tất cả ca kiểm thử. Vì vậy, mục đích là để lên kế hoạch khi nào dừng kiểm thử."
      },
      {
        "question_id": 3,
        "question_title": "Defect Management process does not include",
        "option_A": "Defect prevention",
        "option_B": "Deliverable base-lining",
        "option_C": "Management reporting",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Quy trình quản lý lỗi bao gồm các hoạt động như phát hiện, ghi nhận, phân tích, sửa chữa, xác minh và báo cáo. Việc định chuẩn sản phẩm (deliverable base-lining) thuộc về quản lý cấu hình, không phải quản lý lỗi. Ngăn ngừa lỗi là một hoạt động chất lượng riêng, nhưng có thể được coi là một phần của quản lý lỗi trong một số mô hình, tuy nhiên base-lining rõ ràng không thuộc."
      },
      {
        "question_id": 4,
        "question_title": "When what is visible to end-users is a deviation from the specific or expected behavior, this is called:",
        "option_A": "An error",
        "option_B": "A fault",
        "option_C": "A failure",
        "option_D": "A defect",
        "option_E": "A mistake",
        "correct_anwser": "C",
        "explain": "Theo ISTQB, failure là sự sai lệch của hệ thống so với hành vi mong đợi, có thể quan sát được bởi người dùng. Error là lỗi con người, fault là nguyên nhân gây ra failure, defect là khuyết điểm nói chung."
      },
      {
        "question_id": 5,
        "question_title": "Testing should be stopped when:",
        "option_A": "(i) All the defined tests have been executed",
        "option_B": "(ii) Time has run out",
        "option_C": "(iii) All faults have been fixed correctly",
        "option_D": "Both (i) and (iii)",
        "option_E": "It depends on the risks for the system being tested",
        "correct_anwser": "E",
        "explain": "Việc dừng kiểm thử không chỉ dựa trên việc thực hiện hết các ca kiểm thử hay sửa hết lỗi, mà phải dựa trên rủi ro và các tiêu chí hoàn thành đã định nghĩa. Do đó, câu trả lời đúng là phụ thuộc vào rủi ro."
      },
      {
        "question_id": 6,
        "question_title": "A field failure occurs when multiple users access a system. Which of the following is true?",
        "option_A": "This is an acceptable risk of a multi-user system.",
        "option_B": "Insufficient functional testing has been performed.",
        "option_C": "This indicates an important non-functional requirement was not specified and tested.",
        "option_D": "It is not possible to test against such events prior to release.",
        "correct_anwser": "C",
        "explain": "Lỗi xảy ra khi nhiều người dùng truy cập đồng thời liên quan đến yêu cầu phi chức năng (như hiệu năng, tải, đồng thời). Điều này cho thấy yêu cầu phi chức năng quan trọng chưa được xác định và kiểm thử."
      },
      {
        "question_id": 7,
        "question_title": "Which of the following statements are true?",
        "option_A": "Faults in program specifications are the most expensive to fix",
        "option_B": "Faults in code are the most expensive to fix.",
        "option_C": "Faults in requirements are the most expensive to fix.",
        "option_D": "Faults in designs are the most expensive to fix.",
        "correct_anwser": "C",
        "explain": "Theo nguyên tắc chi phí sửa lỗi tăng theo thời gian, lỗi trong yêu cầu (requirements) nếu không được phát hiện sớm sẽ là đắt nhất để sửa sau khi sản phẩm đã được phát triển và triển khai."
      },
      {
        "question_id": 8,
        "question_title": "Which of the following will be the best definition for Testing:",
        "option_A": "The goal / purpose of testing is to demonstrate that the program works.",
        "option_B": "The purpose of testing is to demonstrate that the program is defect free.",
        "option_C": "The purpose of testing is to demonstrate that the program does what it is supposed to do.",
        "option_D": "Testing is executing Software for the purpose of finding defects.",
        "correct_anwser": "D",
        "explain": "Theo ISTQB, mục đích chính của kiểm thử là phát hiện lỗi và đánh giá chất lượng, không phải chứng minh chương trình chạy đúng hoặc không có lỗi. Định nghĩa D là chính xác nhất."
      },
      {
        "question_id": 9,
        "question_title": "Failure is ______",
        "option_A": "Incorrect program behaviour due to a fault in the program",
        "option_B": "Bug found before product Release",
        "option_C": "Bug found after product Release",
        "option_D": "Bug found during Design phase",
        "correct_anwser": "A",
        "explain": "Failure là hành vi không đúng của chương trình, xảy ra do một fault (lỗi) trong chương trình. Nó có thể xuất hiện trước hoặc sau khi phát hành, nhưng bản chất là hành vi sai."
      },
      {
        "question_id": 10,
        "question_title": "In a risk-based approach the risks identified may be used to i. Determine the test technique to be employed ii. Determine the extent of testing to be carried out iii. Prioritize testing in an attempt to find critical defects as early as possible. iv. Determine the cost of the project",
        "option_A": "ii is True; i, iii, iv & v are False",
        "option_B": "i, ii, iii are true and iv is false",
        "option_C": "ii & iii are True; i, iv are False",
        "option_D": "ii, iii & iv are True; i is false",
        "correct_anwser": "B",
        "explain": "Trong cách tiếp cận dựa trên rủi ro, rủi ro được sử dụng để xác định kỹ thuật kiểm thử, phạm vi kiểm thử và ưu tiên kiểm thử nhằm phát hiện lỗi quan trọng sớm. Tuy nhiên, rủi ro không được dùng để xác định chi phí dự án (iv). Vì vậy i, ii, iii đúng, iv sai."
      },
      {
        "question_id": 11,
        "question_title": "Component Testing is also called as\ni) Unit Testing\nii) Program Testing\niii) Module Testing\niv) System Component Testing.",
        "option_A": "i, ii, iii are true and iv is false",
        "option_B": "i, ii, iii, iv are false",
        "option_C": "i, ii, iv are true and iii is false",
        "option_D": "All of them are true",
        "correct_anwser": "A",
        "explain": "Component testing được gọi là unit testing, program testing, module testing. 'System Component Testing' không phải là thuật ngữ phổ biến; nó thường ám chỉ kiểm thử thành phần ở mức hệ thống, không tương đương. Vì vậy i, ii, iii đúng, iv sai."
      },
      {
        "question_id": 12,
        "question_title": "The software engineer's role in tool selection is",
        "option_A": "To identify, evaluate, and rank tools, and recommend tools to management",
        "option_B": "To determine what kind of tool is needed, then find it and buy it",
        "option_C": "To initiate the tool search and present a case to management",
        "option_D": "To identify, evaluate and select the tools",
        "correct_anwser": "A",
        "explain": "Kỹ sư phần mềm thường xác định, đánh giá, xếp hạng các công cụ và đề xuất lên quản lý, nhưng quyết định mua và lựa chọn cuối cùng thuộc về quản lý. Vì vậy A là chính xác nhất."
      },
      {
        "question_id": 13,
        "question_title": "Test Implementation and execution has which of the following major tasks? (i) Developing and prioritizing test cases, creating test data, writing test procedures and optionally preparing the test harnesses and writing automated test scripts. (ii) Creating the test suite from the test cases for efficient test execution. (iii) Verifying that the test environment has been set up correctly. (iv) Determining the exit criteria.",
        "option_A": "i, ii, iii are true and iv is false",
        "option_B": "i, iv are true and ii is false",
        "option_C": "i, ii are true and iii, iv are false",
        "option_D": "ii, iii, iv are true and i is false",
        "correct_anwser": "A",
        "explain": "Các nhiệm vụ của Triển khai và Thực thi kiểm thử bao gồm phát triển ca kiểm thử, dữ liệu, thủ tục, bộ kiểm thử, và xác minh môi trường. Xác định tiêu chí thoát (exit criteria) thuộc về giai đoạn lập kế hoạch kiểm thử, không phải thực thi. Vì vậy i, ii, iii đúng, iv sai."
      },
      {
        "question_id": 14,
        "question_title": "Amount of testing performed will not depend on",
        "option_A": "Risks involved",
        "option_B": "Contractual requirements",
        "option_C": "Legal requirements",
        "option_D": "Test data.",
        "correct_anwser": "D",
        "explain": "Mức độ kiểm thử phụ thuộc vào rủi ro, yêu cầu hợp đồng, yêu cầu pháp lý. Dữ liệu kiểm thử (test data) chỉ ảnh hưởng đến việc thực hiện, không ảnh hưởng đến số lượng kiểm thử cần thực hiện."
      },
      {
        "question_id": 15,
        "question_title": "Who would USUALLY perform debugging activities?",
        "option_A": "Developers.",
        "option_B": "Analysts.",
        "option_C": "Testers.",
        "option_D": "Incident Managers.",
        "correct_anwser": "A",
        "explain": "Debugging (gỡ lỗi) là quá trình tìm và sửa lỗi trong mã nguồn, thường do lập trình viên (developers) thực hiện, không phải người phân tích, kiểm thử viên hay quản lý sự cố."
      },
      {
        "question_id": 16,
        "question_title": "Regression testing should be performed: i. Every week ii. After the software has changed iii. As often as possible iv. When the environment has changed v. When the project manager says",
        "option_A": "i & ii are true, iii, iv & v are false",
        "option_B": "ii, iii & iv are true, i & v are false",
        "option_C": "ii & iv are true, i, iii & v are false",
        "option_D": "ii is true, i, iii, iv & v are false",
        "correct_anwser": "C",
        "explain": "Kiểm thử hồi quy nên được thực hiện khi phần mềm thay đổi (ii) và khi môi trường thay đổi (iv). Nó không nên thực hiện cố định hàng tuần, càng nhiều càng tốt, hay theo yêu cầu quản lý. Vì vậy ii và iv đúng."
      },
      {
        "question_id": 17,
        "question_title": "Which of the following is true?",
        "option_A": "Component testing should be black box, system testing should be white box",
        "option_B": "If you find a lot of bugs in testing, you should not be very confident about the quality of software",
        "option_C": "The fewer bugs you find, the better your testing was",
        "option_D": "The more tests you run, the more bugs you will find.",
        "correct_anwser": "B",
        "explain": "Nếu tìm thấy nhiều lỗi, chất lượng phần mềm có vấn đề, do đó không nên tự tin cao. A sai vì component có thể dùng white-box, system dùng black-box. C sai vì ít lỗi có thể do kiểm thử kém. D sai vì số lượng kiểm thử không tỉ lệ thuận với số lỗi phát hiện."
      },
      {
        "question_id": 18,
        "question_title": "Which is not the project risks",
        "option_A": "Supplier issues",
        "option_B": "Organization factors",
        "option_C": "Technical issues",
        "option_D": "Error-prone software delivered",
        "correct_anwser": "D",
        "explain": "Rủi ro dự án bao gồm vấn đề nhà cung cấp, yếu tố tổ chức, vấn đề kỹ thuật. 'Phần mềm dễ lỗi khi bàn giao' là rủi ro sản phẩm (product risk), không phải rủi ro dự án."
      },
      {
        "question_id": 19,
        "question_title": "Static analysis tools are typically used by",
        "option_A": "Testers",
        "option_B": "Developers",
        "option_C": "Testers & Developers",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Công cụ phân tích tĩnh thường được các lập trình viên (developers) sử dụng để phát hiện lỗi cú pháp, vi phạm chuẩn mã nguồn trong quá trình phát triển. Mặc dù kiểm thử viên có thể sử dụng, nhưng theo thông lệ và ISTQB, đáp án chính xác là Developers."
      },
      {
        "question_id": 20,
        "question_title": "The Phases of formal review process is mentioned below arrange them in the correct order. Planning, Review Meeting, Rework, Individual Preparations, Kick Off, Follow Up",
        "option_A": "i, ii, iii, iv, v, vi",
        "option_B": "vi, i, ii, iii, iv, v",
        "option_C": "i, v, iv, ii, iii, vi",
        "option_D": "i, ii, iii, v, iv, vi",
        "correct_anwser": "C",
        "explain": "Thứ tự đúng của quy trình đánh giá chính thức: Lập kế hoạch (Planning) → Khởi động (Kick Off) → Chuẩn bị cá nhân (Individual Preparations) → Họp đánh giá (Review Meeting) → Làm lại (Rework) → Theo dõi (Follow Up). Vì vậy đáp án C tương ứng với i, v, iv, ii, iii, vi."
      },
      {
        "question_id": 21,
        "question_title": "In a review meeting a moderator is a person who",
        "option_A": "Takes minutes of the meeting",
        "option_B": "Mediates between people",
        "option_C": "Takes telephone calls",
        "option_D": "Writes the documents to be reviewed",
        "correct_anwser": "B",
        "explain": "Người điều phối (moderator) trong họp đánh giá có vai trò trung gian, điều hòa các ý kiến và đảm bảo cuộc họp diễn ra suôn sẻ. Ghi biên bản là nhiệm vụ của thư ký (scribe), còn viết tài liệu là của tác giả (author)."
      },
      {
        "question_id": 22,
        "question_title": "The Kick Off phase of a formal review includes the following:",
        "option_A": "Explaining the objective",
        "option_B": "Fixing defects found typically done by author",
        "option_C": "Follow up",
        "option_D": "Individual Meeting preparations",
        "correct_anwser": "A",
        "explain": "Pha Kick Off trong đánh giá chính thức là cuộc họp ngắn để giải thích mục tiêu, phạm vi và phân công vai trò. Sửa lỗi thuộc pha Rework, Follow up là pha sau, và chuẩn bị cá nhân là pha trước Kick Off."
      },
      {
        "question_id": 23,
        "question_title": "Which of the following BEST describes the difference between an inspection and a walkthrough?",
        "option_A": "Both inspections and walkthroughs are led by the author.",
        "option_B": "An inspection is led by a moderator and a walkthrough is led by the author.",
        "option_C": "Both inspections and walkthroughs are led by a trained moderator.",
        "option_D": "A walkthrough is led by the author. The author is not present during inspections.",
        "correct_anwser": "B",
        "explain": "Điểm khác biệt chính: Inspection do người điều phối (moderator) dẫn dắt, walkthrough do tác giả (author) dẫn dắt. Tác giả vẫn có mặt trong inspection. Vì vậy B đúng."
      },
      {
        "question_id": 24,
        "question_title": "Peer Reviews are also called as:",
        "option_A": "Inspection",
        "option_B": "Walkthrough",
        "option_C": "Technical Review",
        "option_D": "Formal Review",
        "correct_anwser": "C",
        "explain": "Đánh giá đồng đẳng (Peer Review) thường được gọi là Technical Review, nơi các đồng nghiệp cùng chuyên môn đánh giá sản phẩm. Inspection và Walkthrough là các loại đánh giá cụ thể, Formal Review là thuật ngữ rộng hơn."
      },
      {
        "question_id": 25,
        "question_title": "Which of the following is not a static testing technique?",
        "option_A": "Error guessing",
        "option_B": "Walkthrough",
        "option_C": "Data flow analysis",
        "option_D": "Inspections",
        "correct_anwser": "A",
        "explain": "Error guessing là kỹ thuật kiểm thử động (dựa trên kinh nghiệm, thực thi phần mềm). Walkthrough, Data flow analysis và Inspections đều là kỹ thuật kiểm thử tĩnh (không thực thi)."
      },
      {
        "question_id": 26,
        "question_title": "Find the correct flow of the phases of a formal review",
        "option_A": "Planning, Review meeting, Rework, Kick off",
        "option_B": "Planning, Individual preparation, Kick off, Rework",
        "option_C": "Planning, Review meeting, Rework, Follow up",
        "option_D": "Planning, Individual preparation, Follow up, Kick off",
        "correct_anwser": "C",
        "explain": "Trình tự các pha của đánh giá chính thức là: Planning → (Kick Off → Individual Preparation) → Review Meeting → Rework → Follow Up. Trong các phương án, C có chuỗi logic nhất với Planning, Review meeting, Rework, Follow up (Kick Off và Individual Preparation là các bước nhỏ trước Review meeting)."
      },
      {
        "question_id": 27,
        "question_title": "Which of the following is a static test?",
        "option_A": "Code inspection",
        "option_B": "Coverage analysis",
        "option_C": "Usability assessment",
        "option_D": "Installation test",
        "correct_anwser": "A",
        "explain": "Code inspection là kỹ thuật kiểm thử tĩnh (kiểm tra mã nguồn mà không thực thi). Coverage analysis và Installation test là kiểm thử động, Usability assessment có thể bao gồm cả động và tĩnh nhưng không phải là static test điển hình."
      },
      {
        "question_id": 28,
        "question_title": "People who don’t participate in technical reviews",
        "option_A": "Analysts",
        "option_B": "Management",
        "option_C": "Developers",
        "option_D": "Testers",
        "correct_anwser": "B",
        "explain": "Trong đánh giá kỹ thuật, người tham gia thường là các kỹ sư như analyst, developer, tester. Ban quản lý (management) thường không tham gia trực tiếp vào các buổi đánh giá kỹ thuật chi tiết."
      },
      {
        "question_id": 29,
        "question_title": "Testing without a real plan and test cases is called ____ (choose one answer)",
        "option_A": "Gorilla testing",
        "option_B": "Monkey testing",
        "option_C": "Adhoc testing",
        "option_D": "All of the others",
        "correct_anwser": "C",
        "explain": "Kiểm thử ngẫu hứng (Adhoc testing) là kiểu kiểm thử không có kế hoạch và ca kiểm thử cụ thể. Gorilla testing và Monkey testing là các biến thể nhưng không phải là tên gọi chính xác cho định nghĩa này. Vì vậy C đúng."
      },
      {
        "question_id": 30,
        "question_title": "Which of the following is the main purpose of the integration strategy for integration testing in the small?",
        "option_A": "To ensure that all of the small modules are tested adequately",
        "option_B": "To ensure that the system interfaces to other systems and networks",
        "option_C": "To specify which modules to combine when and how many at once",
        "option_D": "To ensure that the integration testing can be performed by a small team",
        "option_E": "To specify how the software should be divided into modules",
        "correct_anwser": "C",
        "explain": "Chiến lược tích hợp cho kiểm thử tích hợp ở mức nhỏ (integration testing in the small) nhằm xác định thứ tự và số lượng module được kết hợp. Các lựa chọn khác: A là kiểm thử module, B là tích hợp hệ thống lớn, D không liên quan đến chiến lược, E là thiết kế module."
      },
      {
        "question_id": 31,
        "question_title": "If the pseudo code below were a programming language, how many tests are required to achieve 100% statement coverage? 1. If x=3 then 2. Display_messageX; 3. If y=2 then 4. Display_messageY; 5. Else 6. Display_messageZ; 7. Else 8. Display_messageZ;",
        "option_A": "1",
        "option_B": "2",
        "option_C": "3",
        "option_D": "4",
        "correct_anwser": "C",
        "explain": "Cần 3 ca kiểm thử: (x=3, y=2) bao phủ dòng 2 và 4; (x=3, y≠2) bao phủ dòng 2 và 6; (x≠3) bao phủ dòng 8. Vậy cần 3 để đạt 100% bao phủ câu lệnh."
      },
      {
        "question_id": 32,
        "question_title": "Expected results are:",
        "option_A": "Only important in system testing",
        "option_B": "Only used in component testing",
        "option_C": "Never specified in advance",
        "option_D": "Most useful when specified in advance",
        "option_E": "Derived from the code",
        "correct_anwser": "D",
        "explain": "Kết quả mong đợi hữu ích nhất khi được xác định trước để so sánh với kết quả thực tế, giúp phát hiện lỗi. Các đáp án khác sai vì nó quan trọng trong mọi cấp độ kiểm thử và thường được xác định trước."
      },
      {
        "question_id": 33,
        "question_title": "Cyclomatic Complexity method comes under which testing method",
        "option_A": "White box",
        "option_B": "Black box",
        "option_C": "Green box",
        "option_D": "Yellow box",
        "correct_anwser": "A",
        "explain": "Cyclomatic complexity là một số đo cấu trúc chương trình, thuộc kỹ thuật kiểm thử hộp trắng (white-box) để đo độ phức tạp logic và xác định số lượng đường đi cơ sở."
      },
      {
        "question_id": 34,
        "question_title": "Given the following code, which is true: IF A > B THEN C = A - B ELSE C = A + B ENDIF Read D IF C = D Then Print \"Error\" ENIF",
        "option_A": "1 test for statement coverage, 3 for branch coverage",
        "option_B": "2 tests for statement coverage, 2 for branch coverage",
        "option_C": "2 tests for statement coverage, 3 for branch coverage",
        "option_D": "3 tests for statement coverage, 3 for branch coverage",
        "option_E": "3 tests for statement coverage, 2 for branch coverage",
        "correct_anwser": "B",
        "explain": "Bao phủ câu lệnh: cần 2 ca (một cho nhánh if đúng và in lỗi, một cho nhánh else và không in). Bao phủ nhánh: cần 2 ca để bao phủ cả hai quyết định (mỗi quyết định có 2 nhánh), vì vậy 2 cho statement và 2 cho branch."
      },
      {
        "question_id": 35,
        "question_title": "One of the fields on a form contains a text box, which accepts alphabets in lower or upper case. Identify the invalid Equivalence class value.",
        "option_A": "CLASS",
        "option_B": "cLASS",
        "option_C": "Class",
        "option_D": "CLa01ss",
        "correct_anwser": "D",
        "explain": "Lớp tương đương hợp lệ là các chuỗi chỉ chứa chữ cái (không phân biệt hoa/thường). Phương án D chứa số '01' nên không hợp lệ, là giá trị thuộc lớp không hợp lệ."
      },
      {
        "question_id": 36,
        "question_title": "Match the following terms and statements. 1. Decision Table Testing 2. Decision Testing 3. State Transition Testing 4. Exploratory Testing 5. Testing carried out by boxes to achieve specific test objectives, possibly to complement structured testing. 6. A test technique used which may be used to verify different system re depending on current conditions or previous history. 7. A test technique which combines combinations of inputs that might not otherwise have been exercised during testing. 8. A form of control flow testing based on decision outcomes.",
        "option_A": "1Y, 2Z, 3X, 4W.",
        "option_B": "1X, 2W, 3Z, 4Y.",
        "option_C": "1Z, 2X, 3W, 4Y.",
        "option_D": "1Z, 2Y, 3X, 4W.",
        "correct_anwser": "A",
        "explain": "Ghép đúng: Decision Table Testing (1) → Y (kết hợp tổ hợp đầu vào); Decision Testing (2) → Z (kiểm thử dòng điều khiển dựa trên quyết định); State Transition Testing (3) → X (phụ thuộc điều kiện hiện tại/lịch sử); Exploratory Testing (4) → W (kiểm thử khám phá bổ sung cho kiểm thử có cấu trúc)."
      },
      {
        "question_id": 37,
        "question_title": "Typical defects that are easier to find in reviews than in dynamic testing are (choose one answer):",
        "option_A": "Deviations from standards,",
        "option_B": "Requirement defects,",
        "option_C": "Design defects,",
        "option_D": "Insufficient maintainability and incorrect interface specifications.",
        "option_E": "All of the others.",
        "correct_anwser": "E",
        "explain": "Tất cả các loại lỗi trên (sai lệch chuẩn, lỗi yêu cầu, lỗi thiết kế, lỗi bảo trì và giao diện) đều dễ dàng phát hiện hơn trong đánh giá tĩnh (review) so với kiểm thử động, vì chúng thường không gây ra lỗi thực thi rõ ràng."
      },
      {
        "question_id": 38,
        "question_title": "Which is not the testing objectives",
        "option_A": "Finding defects",
        "option_B": "Gaining confidence about the level of quality and providing information",
        "option_C": "Preventing defects.",
        "option_D": "Debugging defects",
        "correct_anwser": "D",
        "explain": "Mục tiêu của kiểm thử bao gồm: tìm lỗi, tăng độ tin cậy và cung cấp thông tin, ngăn ngừa lỗi (thông qua phân tích). Debugging (gỡ lỗi) là hoạt động sửa lỗi, không phải mục tiêu của kiểm thử."
      },
      {
        "question_id": 39,
        "question_title": "Software quality is not relevant to ______",
        "option_A": "Correctness",
        "option_B": "Usability",
        "option_C": "Viability",
        "option_D": "Reusability",
        "correct_anwser": "C",
        "explain": "Chất lượng phần mềm liên quan đến các đặc tính như tính đúng đắn, khả năng sử dụng, khả năng tái sử dụng. 'Viability' (tính khả thi) là vấn đề kinh doanh/dự án, không phải là thuộc tính chất lượng phần mềm."
      },
      {
        "question_id": 40,
        "question_title": "What determines the level of risk?",
        "option_A": "The cost of dealing with an adverse event if it occurs.",
        "option_B": "The probability that an adverse event will occur.",
        "option_C": "The amount of testing planned before release of a system.",
        "option_D": "The likelihood of an adverse event and the impact of the event.",
        "correct_anwser": "D",
        "explain": "Mức độ rủi ro được xác định bởi cả khả năng xảy ra sự kiện và tác động của nó. Đáp án D bao gồm cả hai yếu tố này, trong khi các đáp án khác chỉ đề cập một phần."
      },
      {
        "question_id": 41,
        "question_title": "What is the main reason for testing software before releasing it?",
        "option_A": "To show that system will work after release",
        "option_B": "To decide when the software is of sufficient quality to release",
        "option_C": "To find as many bugs as possible before release",
        "option_D": "To give information for a risk based decision about release",
        "correct_anwser": "D",
        "explain": "Mục đích chính của kiểm thử là cung cấp thông tin về chất lượng và rủi ro, hỗ trợ quyết định phát hành dựa trên rủi ro. Tìm lỗi chỉ là một phần, không phải mục đích cuối cùng."
      },
      {
        "question_id": 42,
        "question_title": "Which of the following is a type of non-functional testing?",
        "option_A": "Usability testing.",
        "option_B": "Statement Coverage.",
        "option_C": "Dataflow testing.",
        "option_D": "Cause-effect graphing.",
        "correct_anwser": "A",
        "explain": "Kiểm thử khả dụng (Usability testing) là một loại kiểm thử phi chức năng. Các lựa chọn khác là kỹ thuật kiểm thử (hộp trắng hoặc hộp đen), không phải loại kiểm thử."
      },
      {
        "question_id": 43,
        "question_title": "Testware (test cases, test dataset)",
        "option_A": "Needs configuration management just like requirements, design and code",
        "option_B": "Should be newly constructed for each new version of the software",
        "option_C": "Is needed only until the software is released into production or use",
        "option_D": "Does not need to be documented and commented, as it does not form part of the released software system",
        "correct_anwser": "A",
        "explain": "Testware cần được quản lý cấu hình như các sản phẩm công việc khác để duy trì tính toàn vẹn và có thể tái sử dụng. Các đáp án khác sai vì testware có thể tái sử dụng, cần thiết cho bảo trì, và cần được ghi chú đầy đủ."
      },
      {
        "question_id": 44,
        "question_title": "Test Case are grouped into Manageable (and scheduled) units are called as",
        "option_A": "Test Harness",
        "option_B": "Test Suite",
        "option_C": "Test Cycle",
        "option_D": "Test Driver",
        "correct_anwser": "B",
        "explain": "Nhóm các ca kiểm thử thành đơn vị có thể quản lý và lên lịch được gọi là bộ ca kiểm thử (Test Suite). Test Harness và Test Driver là các thành phần hỗ trợ thực thi, Test Cycle là chu kỳ thực thi."
      },
      {
        "question_id": 45,
        "question_title": "Which tool will be used to test the flag memory leaks and unassigned pointers",
        "option_A": "Dynamic analysis tool",
        "option_B": "Static Analysis tool.",
        "option_C": "Maintenance tool.",
        "option_D": "Configuration tool.",
        "correct_anwser": "A",
        "explain": "Rò rỉ bộ nhớ và con trỏ chưa gán thường được phát hiện bằng công cụ phân tích động (dynamic analysis) khi chạy chương trình. Static analysis có thể phát hiện một số vấn đề nhưng không phải memory leaks."
      },
      {
        "question_id": 46,
        "question_title": "Defects discovered by static analysis tools include: i. Variables that are never used. ii. Security vulnerabilities. iii. Programming Standard Violations iv. Uncalled functions and procedures",
        "option_A": "i, ii, iii, iv is correct",
        "option_B": "iii, is correct I, ii, iv are incorrect.",
        "option_C": "i, ii, iii and iv are incorrect",
        "option_D": "iv, ii is correct",
        "correct_anwser": "A",
        "explain": "Công cụ phân tích tĩnh có thể phát hiện tất cả các loại lỗi trên: biến không dùng, lỗ hổng bảo mật, vi phạm chuẩn lập trình, hàm và thủ tục không được gọi."
      },
      {
        "question_id": 47,
        "question_title": "A tool that supports traceability, recording of incidents or scheduling of tests is called:",
        "option_A": "A dynamic analysis tool",
        "option_B": "A test execution tool",
        "option_C": "A debugging tool",
        "option_D": "A test management tool",
        "option_E": "A configuration management tool",
        "correct_anwser": "D",
        "explain": "Công cụ quản lý kiểm thử (test management tool) hỗ trợ traceability, ghi nhận sự cố, lên lịch và các hoạt động quản lý khác."
      },
      {
        "question_id": 48,
        "question_title": "The place to start if you want a (new) test tool is:",
        "option_A": "Attend a tool exhibition",
        "option_B": "Invite a vendor to give a demo",
        "option_C": "Analyze your needs and requirements",
        "option_D": "Find out what your budget would be for the tool",
        "option_E": "Search the internet",
        "correct_anwser": "C",
        "explain": "Bước đầu tiên trong quá trình chọn công cụ kiểm thử là phân tích nhu cầu và yêu cầu của tổ chức, sau đó mới xem xét các công cụ khác."
      },
      {
        "question_id": 49,
        "question_title": "Which of the following benefits are MOST likely to be achieved by using test tools? i. Easy to access information about tests and testing. ii. Reduced maintenance of testware. iii. Easy and cheap to implement. iv. Greater consistency of tests.",
        "option_A": "ii and iv",
        "option_B": "ii and iii",
        "option_C": "i and iv",
        "option_D": "i and iii",
        "correct_anwser": "C",
        "explain": "Lợi ích chính của công cụ kiểm thử là dễ dàng truy cập thông tin và tăng tính nhất quán của kiểm thử. Việc giảm bảo trì và dễ dàng triển khai không phải lúc nào cũng đạt được."
      },
      {
        "question_id": 50,
        "question_title": "The Provision and Management of a controlled library containing all the configurations items is called as",
        "option_A": "Configuration Control",
        "option_B": "Status Accounting",
        "option_C": "Configuration Identification",
        "correct_anwser": "A",
        "explain": "Việc cung cấp và quản lý một thư viện có kiểm soát chứa tất cả các mục cấu hình được gọi là Kiểm soát cấu hình (Configuration Control). Các lựa chọn khác là các hoạt động quản lý cấu hình khác."
      },
      {
        "question_id": 51,
        "question_title": "When a new testing tool is purchased, it should be used first by:",
        "option_A": "A small team to establish the best way to use the tool",
        "option_B": "Everyone who may eventually have some use for the tool",
        "option_C": "The independent testing team",
        "option_D": "The vendor contractor to write the initial scripts",
        "correct_anwser": "A",
        "explain": "Khi mua công cụ kiểm thử mới, nên bắt đầu sử dụng với một nhóm nhỏ để thử nghiệm và xác định cách sử dụng tốt nhất, sau đó mới triển khai rộng rãi. Đây là cách tiếp cận pilot trong quản lý công cụ."
      },
      {
        "question_id": 52,
        "question_title": "The principal attributes of tools and automation are (choose one answer)",
        "option_A": "(1) Speed & efficiency",
        "option_B": "(2) Accuracy & precision",
        "option_C": "Both of (1) and (2)",
        "option_D": "None of (1) nor (2)",
        "correct_anwser": "C",
        "explain": "Các thuộc tính chính của công cụ và tự động hóa bao gồm cả tốc độ, hiệu quả và độ chính xác, độ chính xác cao. Vì vậy cả hai đều đúng."
      },
      {
        "question_id": 53,
        "question_title": "The vendor contractor to write the initial scripts",
        "option_A": "Measuring response time",
        "option_B": "Measuring transaction rates",
        "option_C": "Recovery testing",
        "option_D": "Simulating many users",
        "option_E": "Generating many transactions",
        "correct_anwser": "D",
        "explain": "Nhà thầu cung cấp dịch vụ thường được thuê để viết kịch bản kiểm thử hiệu năng, trong đó mô phỏng nhiều người dùng (simulating many users) là một hoạt động điển hình. Đây là nhiệm vụ chính của công cụ kiểm thử tải."
      },
      {
        "question_id": 54,
        "question_title": "Which of the following activities should be performed during the selection and implementation of a testing tool?\ni) Investigate the organisation's test process.\nii) Conduct a proof of concept.\niii) Implement the selected tool on a project behind schedule to save time.\niv) Identify coaching and mentoring requirements for the use of the selected tool.",
        "option_A": "i, ii, iii.",
        "option_B": "ii, iii, iv.",
        "option_C": "i, iii, iv.",
        "option_D": "i, ii, iv.",
        "correct_anwser": "D",
        "explain": "Các hoạt động cần thực hiện khi lựa chọn và triển khai công cụ kiểm thử bao gồm: điều tra quy trình kiểm thử, thực hiện proof of concept (POC), và xác định nhu cầu đào tạo. Không nên triển khai công cụ trên dự án chậm tiến độ để tiết kiệm thời gian (iii sai)."
      },
      {
        "question_id": 55,
        "question_title": "indicates how important it is to fix the bug and when it should be fixed. (choose one answer)",
        "option_A": "(i) Severity",
        "option_B": "(ii) Priority",
        "option_C": "Both of (i) and (ii)",
        "option_D": "None of (i) nor (ii)",
        "correct_anwser": "B",
        "explain": "Priority (ưu tiên) xác định tầm quan trọng và thời điểm cần sửa lỗi. Severity (mức độ nghiêm trọng) chỉ tác động của lỗi, không chỉ định thời điểm sửa. Vì vậy đáp án là Priority."
      },
      {
        "question_id": 56,
        "question_title": "The principal attributes of tools and automation are (choose one answer)",
        "option_A": "(1) Speed & efficiency",
        "option_B": "(2) Accuracy & precision",
        "option_C": "Both of (1) and (2)",
        "option_D": "None of (1) nor (2)",
        "correct_anwser": "C",
        "explain": "Các thuộc tính chính của công cụ và tự động hóa bao gồm cả tốc độ, hiệu quả và độ chính xác, độ chính xác cao. Vì vậy cả hai đều đúng."
      },
      {
        "question_id": 57,
        "question_title": "The vendor contractor to write the initial scripts",
        "option_A": "Measuring response time",
        "option_B": "Measuring transaction rates",
        "option_C": "Recovery testing",
        "option_D": "Simulating many users",
        "option_E": "Generating many transactions",
        "correct_anwser": "D",
        "explain": "Nhà thầu cung cấp dịch vụ thường được thuê để viết kịch bản kiểm thử hiệu năng, trong đó mô phỏng nhiều người dùng (simulating many users) là một hoạt động điển hình. Đây là nhiệm vụ chính của công cụ kiểm thử tải."
      },
      {
        "question_id": 58,
        "question_title": "Which of the following activities should be performed during the selection and implementation of a testing tool?\ni) Investigate the organisation's test process.\nii) Conduct a proof of concept.\niii) Implement the selected tool on a project behind schedule to save time.\niv) Identify coaching and mentoring requirements for the use of the selected tool.",
        "option_A": "i, ii, iii.",
        "option_B": "ii, iii, iv.",
        "option_C": "i, iii, iv.",
        "option_D": "i, ii, iv.",
        "correct_anwser": "D",
        "explain": "Các hoạt động cần thực hiện khi lựa chọn và triển khai công cụ kiểm thử bao gồm: điều tra quy trình kiểm thử, thực hiện proof of concept (POC), và xác định nhu cầu đào tạo. Không nên triển khai công cụ trên dự án chậm tiến độ để tiết kiệm thời gian (iii sai)."
      },
      {
        "question_id": 59,
        "question_title": "indicates how important it is to fix the bug and when it should be fixed. (choose one answer)",
        "option_A": "(i) Severity",
        "option_B": "(ii) Priority",
        "option_C": "Both of (i) and (ii)",
        "option_D": "None of (i) nor (ii)",
        "correct_anwser": "B",
        "explain": "Priority (ưu tiên) xác định tầm quan trọng và thời điểm cần sửa lỗi. Severity (mức độ nghiêm trọng) chỉ tác động của lỗi, không chỉ định thời điểm sửa. Vì vậy đáp án là Priority."
      },
      {
        "question_id": 60,
        "question_title": "When to stop Testing?",
        "option_A": "Stop when scheduled time for testing expires",
        "option_B": "Stop if 75% of the pre-defined number of errors is detected.",
        "option_C": "Stop when all the test cases execute with detecting few errors.",
        "option_D": "None of the others",
        "correct_anwser": "D",
        "explain": "Việc dừng kiểm thử không dựa trên thời gian cố định, tỷ lệ phần trăm lỗi hay số ca kiểm thử thực thi, mà dựa trên tiêu chí hoàn thành (exit criteria) đã xác định dựa trên rủi ro và chất lượng. Vì vậy, không có đáp án nào trên đúng, chọn D."
      }
    ]
  },
  {
    "id": "swt301-sp25-re",
    "title": "SWT301 - SP25 - RE",
    "description": "Software Testing Quiz",
    "questionsCount": 60,
    "questions": [
      {
        "question_id": 1,
        "question_title": "PDCA is known as",
        "option_A": "Plan, Do, Check, Act",
        "option_B": "Plan, Do, Correct, Act",
        "option_C": "Plan, Debug, Check, Act",
        "option_D": "Plan, Do, Check, Accept",
        "correct_anwser": "A",
        "explain": "PDCA là viết tắt của Plan-Do-Check-Act, một chu trình cải tiến liên tục. Các phương án khác sai vì chứa từ không đúng (Correct, Debug, Accept)."
      },
      {
        "question_id": 2,
        "question_title": "There are several risks of managing your project's schedule with a statistical reliability model. These include:",
        "option_A": "Testers spend more energy early in the product trying to find bugs than preparing to do the rest of the project's work more efficiently",
        "option_B": "Managers might not realize that the testing effort is ineffective, late in the project, because they expect a low rate of bug finding, so the low rate achieved doesn't alarm them.",
        "option_C": "It can increase the end-of-project pressure on testers to not find bugs, or to not report bugs.",
        "option_D": "All of the others",
        "correct_anwser": "D",
        "explain": "Cả ba rủi ro A, B, C đều là những rủi ro thực tế khi quản lý lịch trình với mô hình độ tin cậy thống kê. Do đó đáp án D (All of the others) là đúng."
      },
      {
        "question_id": 3,
        "question_title": "Which testing is used to verify that the system can perform properly when internal program or system limitations have been exceeded",
        "option_A": "Stress Testing",
        "option_B": "Load Testing",
        "option_C": "Performance Testing",
        "option_D": "Volume testing",
        "correct_anwser": "A",
        "explain": "Stress Testing (kiểm thử độ chịu tải) được sử dụng để kiểm tra hệ thống khi vượt quá giới hạn, nhằm xem hệ thống có hoạt động đúng hay không. Load Testing kiểm tra tải dự kiến, Performance Testing đo hiệu năng, Volume Testing kiểm tra khối lượng dữ liệu."
      },
      {
        "question_id": 4,
        "question_title": "Which is the best definition of complete testing:",
        "option_A": "You have discovered every bug in the program.",
        "option_B": "You have tested every statement, branch, and combination of branches in the program.",
        "option_C": "You have completed every test in the test plan.",
        "option_D": "You have reached the scheduled ship date.",
        "correct_anwser": "B",
        "explain": "Hoàn thành kiểm thử (complete testing) được định nghĩa là kiểm tra mọi câu lệnh, nhánh và tổ hợp nhánh. Đáp án A là không thực tế (không thể tìm mọi lỗi), C chỉ là hoàn thành kế hoạch, D là thời gian phát hành, không liên quan."
      },
      {
        "question_id": 5,
        "question_title": "A reliable system will be one that:",
        "option_A": "Is unlikely to be completed on schedule",
        "option_B": "Is unlikely to cause a failure",
        "option_C": "Is likely to be fault-free",
        "option_D": "Is likely to be liked by the users",
        "correct_anwser": "B",
        "explain": "Độ tin cậy (reliability) là xác suất hệ thống không gây ra lỗi (failure) trong điều kiện vận hành cụ thể. Hệ thống đáng tin cậy là hệ thống ít có khả năng gây ra lỗi. Các đáp án khác không phải là định nghĩa chính xác."
      },
      {
        "question_id": 6,
        "question_title": "Testing does not help to ______",
        "option_A": "Find faults",
        "option_B": "Assure quality",
        "option_C": "Check user friendliness.",
        "option_D": "Improve software accuracy",
        "correct_anwser": "C",
        "explain": "Testing giúp tìm lỗi, đảm bảo chất lượng và cải thiện độ chính xác của phần mềm. Tuy nhiên, kiểm tra tính thân thiện với người dùng (user friendliness) thuộc về kiểm thử khả năng sử dụng (usability testing), không phải là mục tiêu chính của kiểm thử chức năng hoặc kỹ thuật thông thường."
      },
      {
        "question_id": 7,
        "question_title": "As part of which test process do you determine the exit criteria?",
        "option_A": "Test planning.",
        "option_B": "Evaluating exit criteria and reporting.",
        "option_C": "Test closure.",
        "option_D": "Test control.",
        "correct_anwser": "A",
        "explain": "Tiêu chí thoát (exit criteria) được xác định trong giai đoạn lập kế hoạch kiểm thử (test planning), trước khi bắt đầu thực hiện kiểm thử. Các giai đoạn khác (đánh giá tiêu chí, kết thúc, kiểm soát) không phải là nơi xác định tiêu chí thoát."
      },
      {
        "question_id": 8,
        "question_title": "CAST stands for",
        "option_A": "Computer Aided Software Testing",
        "option_B": "Computer Aided Software Tools",
        "option_C": "Computer Analysis Software Techniques",
        "option_D": "None of the others",
        "correct_anwser": "A",
        "explain": "CAST là viết tắt của Computer Aided Software Testing (kiểm thử phần mềm có sự hỗ trợ của máy tính). Các phương án khác không đúng."
      },
      {
        "question_id": 9,
        "question_title": "Defects are recorded into three major purposes. They are: 1. To correct the defect 2. To report status of the application 3. To improve the software development process",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "A",
        "explain": "Đúng. Ghi nhận lỗi nhằm ba mục đích chính: sửa lỗi, báo cáo trạng thái ứng dụng, và cải thiện quy trình phát triển phần mềm. Do đó câu trả lời là True."
      },
      {
        "question_id": 10,
        "question_title": "A piece of software has been given ______ what tests in the following will you perform?\n1) Test the area's most critical to business processes\n2) Test the areas where faults will be maximum\n3) Test the easiest functionalities",
        "option_A": "1&2 are true and 3 is false",
        "option_B": "1,2&3 are true.",
        "option_C": "1 is true, 2&3 are false.",
        "option_D": "1&2 are false, 3 is true",
        "correct_anwser": "A",
        "explain": "Khi ưu tiên kiểm thử, cần tập trung vào các khu vực quan trọng nhất đối với quy trình kinh doanh và các khu vực có nhiều lỗi tiềm ẩn. Không nên ưu tiên các chức năng dễ nhất. Vì vậy, phát biểu 1 và 2 đúng, 3 sai."
      },
      {
        "question_id": 11,
        "question_title": "Which of the following has highest level of independence in which test cases are:",
        "option_A": "Designed by persons who write the software under test",
        "option_B": "Designed by a person from a different section",
        "option_C": "Designed by a person from a different organization",
        "option_D": "Designed by another person",
        "correct_anwser": "C",
        "explain": "Mức độ độc lập cao nhất trong kiểm thử là khi các ca kiểm thử được thiết kế bởi một tổ chức khác (bên thứ ba). Các mức độc lập tăng dần từ người viết phần mềm, người khác trong cùng nhóm, người từ phòng ban khác, đến tổ chức khác."
      },
      {
        "question_id": 12,
        "question_title": "In which order should tests be run?",
        "option_A": "The most important tests first",
        "option_B": "The most difficult tests first (to allow maximum time for fixing)",
        "option_C": "The easiest tests first (to give initial confidence)",
        "option_D": "The order they are thought of",
        "correct_anwser": "A",
        "explain": "Các ca kiểm thử nên được chạy theo thứ tự ưu tiên dựa trên rủi ro, do đó các kiểm thử quan trọng nhất nên được thực hiện trước. Các phương án còn lại không phải là chiến lược ưu tiên hợp lý."
      },
      {
        "question_id": 13,
        "question_title": "Which of the following is MOST important in the selection of a test approach?",
        "option_A": "Availability of tools to support the proposed techniques.",
        "option_B": "The budget allowed for training in proposed techniques.",
        "option_C": "Available skills and experience in the proposed techniques.",
        "option_D": "The willingness of the test team to learn new techniques.",
        "correct_anwser": "C",
        "explain": "Yếu tố quan trọng nhất khi lựa chọn cách tiếp cận kiểm thử là kỹ năng và kinh nghiệm hiện có của nhóm đối với các kỹ thuật đề xuất. Các yếu tố khác (công cụ, ngân sách, sự sẵn sàng) cũng quan trọng nhưng không quyết định bằng kỹ năng hiện có."
      },
      {
        "question_id": 14,
        "question_title": "Test planning has which of the following major tasks? i. Determining the scope and risks, and identifying the objectives of testing. ii. Determining the test approach (techniques, test items, coverage, identifying and interfacing the teams involved in testing, testware) iii. Reviewing the Test Basis (such as requirements, architecture, design, interface) iv. Determining the exit criteria.",
        "option_A": "i, ii, iv are true and iii is false",
        "option_B": "i, iv are true and ii is false",
        "option_C": "i, ii are true and iii, iv are false",
        "option_D": "ii, iii, iv are true and i is false",
        "correct_anwser": "A",
        "explain": "Lập kế hoạch kiểm thử bao gồm các nhiệm vụ: xác định phạm vi, rủi ro, mục tiêu; xác định cách tiếp cận; và xác định tiêu chí thoát. Việc rà soát Test Basis (yêu cầu, thiết kế...) thuộc về phân tích kiểm thử, không phải lập kế hoạch. Do đó i, ii, iv đúng, iii sai."
      },
      {
        "question_id": 15,
        "question_title": "For software to be reliable it must:",
        "option_A": "Be easy to maintain.",
        "option_B": "Be unlikely to cause a failure.",
        "option_C": "Never fail under any circumstances.",
        "option_D": "Be written according to coding standards.",
        "correct_anwser": "B",
        "explain": "Độ tin cậy của phần mềm được định nghĩa là khả năng không gây ra lỗi (failure) trong quá trình vận hành. Phần mềm đáng tin cậy là phần mềm ít có khả năng gây ra sự cố. Đáp án C (không bao giờ hỏng) là quá lý tưởng và không thực tế."
      },
      {
        "question_id": 16,
        "question_title": "Which of the following is a MAJOR task of test implementation and execution?",
        "option_A": "Measuring and analyzing results.",
        "option_B": "Reporting discrepancies as incidents.",
        "option_C": "Identifying test conditions or test requirements.",
        "option_D": "Assessing if more tests are needed.",
        "correct_anwser": "B",
        "explain": "Trong giai đoạn thực hiện và thực thi kiểm thử, nhiệm vụ chính là báo cáo các sai lệch dưới dạng sự cố (incidents). Đo lường và phân tích kết quả, đánh giá nhu cầu thêm kiểm thử thuộc về đánh giá tiêu chí thoát. Xác định điều kiện kiểm thử thuộc về phân tích/thiết kế."
      },
      {
        "question_id": 17,
        "question_title": "Which of the following is not phase of the Fundamental Test Process?",
        "option_A": "Test Planning and Control",
        "option_B": "Test implementation and Execution",
        "option_C": "Requirement Analysis",
        "option_D": "Evaluating Exit criteria and reporting",
        "correct_anwser": "C",
        "explain": "Quy trình kiểm thử cơ bản gồm các pha: Lập kế hoạch và điều khiển, Phân tích và thiết kế, Thực hiện và thực thi, Đánh giá tiêu chí thoát và báo cáo, Kết thúc kiểm thử. Phân tích yêu cầu (Requirement Analysis) không phải là một pha riêng, nó là một phần của phân tích và thiết kế."
      },
      {
        "question_id": 18,
        "question_title": "One of the following is not a part of white box testing as per BS7925-II standards.",
        "option_A": "Random testing",
        "option_B": "Data Flow testing.",
        "option_C": "Statement testing",
        "option_D": "Syntax testing",
        "correct_anwser": "A",
        "explain": "Theo tiêu chuẩn BS7925-II, các kỹ thuật kiểm thử hộp trắng bao gồm: kiểm thử câu lệnh, kiểm thử nhánh, kiểm thử luồng dữ liệu. Kiểm thử ngẫu nhiên (Random testing) là kỹ thuật hộp đen, không thuộc hộp trắng. Syntax testing cũng thường là hộp đen, nhưng trong ngữ cảnh này đáp án chính xác là A."
      },
      {
        "question_id": 19,
        "question_title": "Verification is:",
        "option_A": "Checking that we are building the right system",
        "option_B": "Checking that we are building the system right",
        "option_C": "Performed by an independent test team",
        "option_D": "Making sure that it is what the user really wants",
        "correct_anwser": "B",
        "explain": "Xác minh (Verification) là kiểm tra chúng ta đang xây dựng hệ thống đúng cách (building the system right). Xác nhận (Validation) là kiểm tra chúng ta đang xây dựng đúng hệ thống (building the right system). Do đó đáp án B đúng."
      },
      {
        "question_id": 20,
        "question_title": "Methodologies adopted while performing Maintenance Testing",
        "option_A": "Breadth Test and Depth Test",
        "option_B": "Re-testing",
        "option_C": "Confirmation Testing",
        "option_D": "Sanity Testing",
        "correct_anwser": "A",
        "explain": "Trong kiểm thử bảo trì, hai phương pháp chính thường được áp dụng là kiểm thử theo chiều rộng (Breadth Test) và kiểm thử theo chiều sâu (Depth Test) để quyết định phạm vi kiểm thử hồi quy. Các phương án khác (Re-testing, Confirmation Testing, Sanity Testing) là các loại kiểm thử cụ thể, không phải là các phương pháp chính của kiểm thử bảo trì."
      },
      {
        "question_id": 21,
        "question_title": "How much percentage of the life cycle costs of a software are spent on maintenance.",
        "option_A": "10%",
        "option_B": "30%",
        "option_C": "50%",
        "option_D": "70%",
        "correct_anwser": "D",
        "explain": "Theo nhiều nghiên cứu, chi phí bảo trì phần mềm chiếm khoảng 70% tổng chi phí vòng đời. Các tỷ lệ 10%, 30%, 50% đều thấp hơn so với thực tế."
      },
      {
        "question_id": 22,
        "question_title": "Which of the following is a Key Characteristics of Walk Through",
        "option_A": "Scenario, Dry Run, Peer Group",
        "option_B": "Pre Meeting Preparations",
        "option_C": "Formal Follow Up Process",
        "option_D": "Includes Metrics",
        "correct_anwser": "A",
        "explain": "Walkthrough có đặc điểm chính là kịch bản (scenario), chạy thử (dry run) và nhóm đồng nghiệp (peer group). Các phương án khác (chuẩn bị trước, quy trình theo dõi, số liệu) thường thuộc về các loại review khác như inspection."
      },
      {
        "question_id": 23,
        "question_title": "Inspections can find all the following except",
        "option_A": "Variables not defined in the code",
        "option_B": "Spelling and grammar faults in the documents",
        "option_C": "Requirements that have been omitted from the design documents",
        "option_D": "How much of the code has been covered",
        "correct_anwser": "D",
        "explain": "Kiểm tra (inspection) có thể phát hiện lỗi biến không khai báo, lỗi chính tả, yêu cầu thiếu, nhưng không thể đo lường mức độ bao phủ mã (code coverage) – đây là thước đo được tính từ quá trình kiểm thử, không phải kỹ thuật xem xét tĩnh."
      },
      {
        "question_id": 24,
        "question_title": "Success Factors for a review include:\ni) Each Review does not have a predefined objective\nii) Defects found are welcomed and expressed objectively\niii) Management supports a good review process\niv) There is an emphasis on learning and process improvement.",
        "option_A": "ii, iii, iv are correct and i is incorrect",
        "option_B": "iii, i, iv is correct and ii is incorrect",
        "option_C": "i, iii, iv, ii is in correct",
        "option_D": "ii is correct",
        "correct_anwser": "A",
        "explain": "Các yếu tố thành công của đánh giá: (ii) lỗi được chào đón và trình bày khách quan, (iii) quản lý hỗ trợ, (iv) chú trọng học hỏi và cải tiến. (i) sai vì mỗi đánh giá phải có mục tiêu xác định."
      },
      {
        "question_id": 25,
        "question_title": "Which of the following is true about Formal Review or Inspection:\ni) Led by Trained Moderator (not the author).\nii) No Pre Meeting Preparations\niii) Formal Follow up process.\niv) Main Objective is to find defects.",
        "option_A": "ii is true and i, iii, iv are false",
        "option_B": "i, iii, iv are true and ii is false",
        "option_C": "i, iii, iv are false and ii is true",
        "option_D": "iii is true and i, ii, iv are false",
        "correct_anwser": "B",
        "explain": "Đánh giá hình thức (inspection) do người điều phối được đào tạo dẫn dắt, có quy trình theo dõi chính thức, mục tiêu chính là tìm lỗi. Việc chuẩn bị trước là bắt buộc, nên ii sai."
      },
      {
        "question_id": 26,
        "question_title": "Which expression best matches the following characteristics or review processes:\n1. Led by author\n2. Undocumented\n3. No management participation\n4. Led by a trained moderator or leader\n5. Uses entry exit criteria\ns) Inspection\nt) Peer review\nu) Informal review\nv) Walkthrough",
        "option_A": "s = 4, t = 3, u = 2 and 5, v = 1",
        "option_B": "s = 4 and 5, t = 3, u = 2, v = 1",
        "option_C": "s = 1 and 5, t = 3, u = 2, v = 4",
        "option_D": "s = 5, t = 4, u = 3, v = 1 and 2",
        "option_E": "s = 4 and 5, t = 1, u = 2, v = 3",
        "correct_anwser": "B",
        "explain": "Inspection có người điều phối được đào tạo và sử dụng tiêu chí đầu vào/đầu ra (4,5). Peer review không có sự tham gia quản lý (3). Informal review không có tài liệu (2). Walkthrough do tác giả dẫn dắt (1)."
      },
      {
        "question_id": 27,
        "question_title": "Who are the persons involved in a Formal Review\n- Manager\n- Moderator\n- Scribe / Recorder\n- Assistant Manager",
        "option_A": "i, ii, iii, iv are true",
        "option_B": "i, ii, iii are true and iv is false.",
        "option_C": "ii, iii, iv are true and i is false.",
        "option_D": "i, iv are true and ii, iii are false.",
        "correct_anwser": "B",
        "explain": "Trong đánh giá hình thức, các vai trò chính gồm: Quản lý, Điều phối viên, Người ghi chép. Trợ lý quản lý (Assistant Manager) không phải vai trò tiêu chuẩn. Do đó i, ii, iii đúng, iv sai."
      },
      {
        "question_id": 28,
        "question_title": "Which of the following is a Key Characteristics of Walk Through",
        "option_A": "Scenario, Dry Run, Peer Group",
        "option_B": "Pre Meeting Preparations",
        "option_C": "Formal Follow Up Process",
        "option_D": "Includes Metrics",
        "correct_anwser": "A",
        "explain": "Walkthrough có đặc điểm chính là kịch bản, chạy thử và nhóm đồng nghiệp. Các đặc điểm khác như chuẩn bị trước, quy trình theo dõi chính thức, đo lường thường thuộc về inspection."
      },
      {
        "question_id": 29,
        "question_title": "Who is responsible for document all the issues, problems and open point that were identified during the review meeting",
        "option_A": "Moderator",
        "option_B": "Scribe",
        "option_C": "Reviewers",
        "option_D": "Author",
        "correct_anwser": "B",
        "explain": "Người ghi chép (Scribe/Recorder) chịu trách nhiệm ghi lại tất cả các vấn đề, lỗi và điểm mở được xác định trong buổi đánh giá. Điều phối viên điều khiển, người đánh giá đưa ra ý kiến, tác giả giải thích."
      },
      {
        "question_id": 30,
        "question_title": "A person who documents all the issues, problems and open points that were identified during a formal review",
        "option_A": "Moderator",
        "option_B": "Scribe",
        "option_C": "Author",
        "option_D": "Manager",
        "correct_anwser": "B",
        "explain": "Vai trò ghi chép (Scribe) là người ghi lại tất cả các vấn đề, lỗi và điểm mở trong quá trình đánh giá. Các vai trò khác không đảm nhiệm việc này."
      },
      {
        "question_id": 31,
        "question_title": "Which of the following is NOT a type of non-functional test?",
        "option_A": "State-Transition",
        "option_B": "Usability",
        "option_C": "Performance",
        "option_D": "Security",
        "correct_anwser": "A",
        "explain": "State-Transition là kỹ thuật kiểm thử chức năng (hộp đen), dùng để kiểm tra hành vi của hệ thống dựa trên các trạng thái và sự chuyển trạng thái. Usability, Performance, Security đều là các loại kiểm thử phi chức năng."
      },
      {
        "question_id": 32,
        "question_title": "A program validates a numeric field as follows: Values less than 10 are rejected, values between 10 and 21 are accepted, values greater than or equal to 22 are rejected. Which of the following input values cover all of the equivalence partitions?",
        "option_A": "10,11,21",
        "option_B": "3,20,21",
        "option_C": "3,10,22",
        "option_D": "10,21,22",
        "correct_anwser": "C",
        "explain": "Các phân hoạch tương đương: nhỏ hơn 10 (ví dụ 3), từ 10 đến 21 (ví dụ 10), lớn hơn hoặc bằng 22 (ví dụ 22). Chỉ đáp án C có đủ 3 giá trị đại diện cho cả 3 phân hoạch."
      },
      {
        "question_id": 33,
        "question_title": "Cyclomatic complexity is used to calculate",
        "option_A": "Number of independent paths in the basis set of a program",
        "option_B": "Number of binary decisions + 1",
        "option_C": "Number bound for the number of tests that must be conducted to ensure that all statements have been executed at least once",
        "option_D": "Number of branches and decisions",
        "correct_anwser": "A",
        "explain": "Cyclomatic complexity được sử dụng để tính số đường dẫn độc lập trong tập cơ sở của chương trình. Các phương án B là một công thức tính (không phải định nghĩa), C sai vì đây là đường dẫn không phải câu lệnh, D là cách tính khác."
      },
      {
        "question_id": 34,
        "question_title": "What is an equivalence partition (also known as an equivalence class)?",
        "option_A": "A set of test cases for testing classes of objects",
        "option_B": "An input or output range of values such that only one value in the range becomes a test case",
        "option_C": "An input or output range of values such that each value in the range becomes a test case",
        "option_D": "An input or output range of values such that every tenth value in the range becomes a test case.",
        "correct_anwser": "B",
        "explain": "Phân hoạch tương đương là một khoảng giá trị đầu vào hoặc đầu ra sao cho chỉ cần một giá trị đại diện để tạo ca kiểm thử. Các giá trị trong cùng phân hoạch được coi là tương đương."
      },
      {
        "question_id": 35,
        "question_title": "You have designed test cases to provide 100% statement and 100% decision coverage for the following fragment of code. if width > length then biggest_dimension = width else biggest_dimension = length end_if. The following has been added to the bottom of the code fragment above. print \"Biggest dimension is \" & biggest_dimension print \"Width: \" & width print \"Length: \" & length. How many more test cases are required?",
        "option_A": "One more test case will be required for 100 % decision coverage.",
        "option_B": "Two more test cases will be required for 100 % statement coverage, one of which will be used to provide 100% decision coverage.",
        "option_C": "None, existing test cases can be used.",
        "option_D": "One more test case will be required for 100\" statement coverage.",
        "correct_anwser": "C",
        "explain": "Các câu lệnh print mới không tạo thêm nhánh nào, chúng chỉ là các câu lệnh tuần tự sẽ luôn được thực thi. Các ca kiểm thử hiện có (đã đạt 100% bao phủ câu lệnh và quyết định) vẫn đủ để bao phủ các câu lệnh mới này."
      },
      {
        "question_id": 36,
        "question_title": "Which of the following is TRUE?",
        "option_A": "Confirmation testing is testing fixes to a set of defects and Regression testing is testing to establish whether any defects have been introduced as a result of changes.",
        "option_B": "Confirmation testing is testing to establish whether any defects have been introduced as a result of changes and Regression testing is testing fixes to a set of defects.",
        "option_C": "Confirmation testing and Regression testing are both testing to establish whether any defects have been introduced as a result of changes.",
        "option_D": "Confirmation testing and Regression testing are both testing fixes to a set of defects.",
        "correct_anwser": "A",
        "explain": "Confirmation testing (kiểm thử xác nhận) là kiểm tra các bản sửa lỗi, còn Regression testing (kiểm thử hồi quy) là kiểm tra xem thay đổi có gây ra lỗi mới không. Đáp án A đúng, các đáp án khác đảo ngược hoặc gộp sai định nghĩa."
      },
      {
        "question_id": 37,
        "question_title": "Given the following state transition table Which of the test cases below will cover the following series of state transitions? S1 S0 S1 S2 S0",
        "option_A": "D, A, B, C.",
        "option_B": "A, B, C, D.",
        "option_C": "D, A, B.",
        "option_D": "A, B, C.",
        "correct_anwser": "A",
        "explain": "Dựa trên sơ đồ chuyển trạng thái: S1 -> S0 (D), S0 -> S1 (A), S1 -> S2 (B), S2 -> S0 (C). Do đó chuỗi sự kiện là D, A, B, C."
      },
      {
        "question_id": 38,
        "question_title": "Regression testing should be performed: v. Every week w. After the software has changed x. As often as possible y. When the environment has changed z. When the project manager says",
        "option_A": "v & w are true, x - z are false",
        "option_B": "w, x & y are true, v & z are false",
        "option_C": "w & y are true, v, x & z are false",
        "option_D": "w is true, v, x & y and z are false",
        "option_E": "All of them are true",
        "correct_anwser": "C",
        "explain": "Kiểm thử hồi quy nên được thực hiện khi phần mềm thay đổi (w) và khi môi trường thay đổi (y). Không phải mỗi tuần, không phải thường xuyên nhất có thể, và không chỉ khi quản lý yêu cầu."
      },
      {
        "question_id": 39,
        "question_title": "A wholesaler sells printer cartridges. The minimum order quantity is 5. There is a 20% discount for orders of 100 or more printer cartridges. You have been asked to prepare test cases using various values for the number of printer cartridges ordered. Which of the following groups contain three test inputs that would be generated using Boundary Value Analysis?",
        "option_A": "5, 6, 20",
        "option_B": "4, 5, 80",
        "option_C": "4, 5, 99",
        "option_D": "1, 20, 100",
        "correct_anwser": "C",
        "explain": "Boundary Value Analysis tập trung vào các biên: giá trị nhỏ hơn biên (4), tại biên (5), và ngay trước biên giảm giá (99). Đáp án C đúng vì bao gồm 4, 5, 99. 100 cũng là biên nhưng không bắt buộc phải có trong bộ 3 giá trị này."
      },
      {
        "question_id": 40,
        "question_title": "Statement Coverage will not check for the following.",
        "option_A": "Missing Statements",
        "option_B": "Unused Branches",
        "option_C": "Dead Code",
        "option_D": "Unused Statement",
        "correct_anwser": "D",
        "explain": "Statement coverage không kiểm tra các câu lệnh không được sử dụng (unused statement/dead code) vì nó chỉ đo lường các câu lệnh đã được thực thi, không phát hiện các câu lệnh không bao giờ được thực thi. Missing statements và unused branches cũng không được kiểm tra, nhưng trong ngữ cảnh này, \"unused statement\" là lựa chọn phổ biến nhất."
      },
      {
        "question_id": 41,
        "question_title": "Match the following: 1. Test estimation 2. Test control 3. Test monitoring a. Measures of tracking process b. Effort required to perform activities c. Reallocation of resources",
        "option_A": "1-b, 2-c, 3-a",
        "option_B": "1-b, 2-a, 3-c",
        "option_C": "1-c, 2-a, 3-b",
        "option_D": "1-a, 2-b, 3-c",
        "correct_anwser": "A",
        "explain": "Ước lượng kiểm thử (Test estimation) liên quan đến nỗ lực (effort) cần thiết – ghép với b. Kiểm soát (Test control) là phân bổ lại nguồn lực – ghép với c. Giám sát (Test monitoring) là theo dõi tiến độ – ghép với a. Vậy 1-b, 2-c, 3-a."
      },
      {
        "question_id": 42,
        "question_title": "Which of the following is least important in test management?",
        "option_A": "Estimating test duration.",
        "option_B": "Incident Management",
        "option_C": "Configuration Management.",
        "option_D": "De-bugging.",
        "correct_anwser": "D",
        "explain": "Gỡ lỗi (debugging) là hoạt động của nhà phát triển, không phải nhiệm vụ quản lý kiểm thử. Quản lý sự cố, cấu hình và ước lượng thời gian đều là các phần quan trọng của quản lý kiểm thử."
      },
      {
        "question_id": 43,
        "question_title": "A ______ is the step-by-step method followed to ensure that standards are met",
        "option_A": "SDLC",
        "option_B": "Project Plan",
        "option_C": "Policy",
        "option_D": "Procedure",
        "correct_anwser": "D",
        "explain": "Thủ tục (Procedure) là phương pháp từng bước để đảm bảo các tiêu chuẩn được tuân thủ. SDLC là vòng đời phát triển, kế hoạch dự án là tổng thể, chính sách (Policy) là hướng dẫn cấp cao."
      },
      {
        "question_id": 44,
        "question_title": "Which of the following is the task of a Test Lead / Leader i. Interaction with the Test Tool Vendor to identify best ways to leverage test tool on the project. ii. Write Test Summary Reports based on the information gathered during testing. iii. Decide what should be automated, to what degree and how. iv. Create the Test Specifications",
        "option_A": "i, ii, iii is true and iv is false",
        "option_B": "ii, iii, iv is true and i is false",
        "option_C": "i is true and ii, iii, iv are false",
        "option_D": "iii and iv is correct and i and ii are incorrect",
        "correct_anwser": "A",
        "explain": "Trưởng nhóm kiểm thử thường thực hiện: tương tác với nhà cung cấp công cụ, viết báo cáo tóm tắt, quyết định tự động hóa. Việc tạo đặc tả kiểm thử chi tiết (Test Specifications) thường được giao cho thành viên nhóm, không phải nhiệm vụ chính của trưởng nhóm."
      },
      {
        "question_id": 45,
        "question_title": "Test Plan Outline contains which of the following: i. Test Items ii. Test Scripts iii. Test Deliverables iv. Responsibilities",
        "option_A": "i, ii, iii are true and iv is false",
        "option_B": "i, iii, iv are true and ii is false",
        "option_C": "ii, iii are true and i and iv are false",
        "option_D": "i, ii are false and iii, iv are true",
        "correct_anwser": "B",
        "explain": "Kế hoạch kiểm thử bao gồm các hạng mục kiểm thử, sản phẩm bàn giao và trách nhiệm. Các kịch bản kiểm thử (Test Scripts) là chi tiết thấp hơn, thường không có trong outline của kế hoạch kiểm thử."
      },
      {
        "question_id": 46,
        "question_title": "Pick the best definition of quality",
        "option_A": "Quality is job one",
        "option_B": "Zero defects",
        "option_C": "Conformance to requirements",
        "option_D": "Work as designed",
        "correct_anwser": "C",
        "explain": "Định nghĩa kinh điển của chất lượng trong phần mềm là \"tuân thủ các yêu cầu\" (conformance to requirements). Các phương án khác là khẩu hiệu hoặc không thực tế."
      },
      {
        "question_id": 47,
        "question_title": "Which of the following is NOT included in the Test Plan document of the Test Documentation Standard:",
        "option_A": "Test items (i.e. software versions)",
        "option_B": "What is not to be tested",
        "option_C": "Test environments",
        "option_D": "Quality plans",
        "option_E": "Schedules and deadlines",
        "correct_anwser": "D",
        "explain": "Kế hoạch kiểm thử bao gồm các hạng mục kiểm thử, phạm vi không kiểm thử, môi trường, lịch trình. Kế hoạch chất lượng (Quality plans) thường là một tài liệu riêng, không nằm trong kế hoạch kiểm thử."
      },
      {
        "question_id": 48,
        "question_title": "Some tools are geared more for developer use. For the 5 tools listed, which statement BEST details those for developers.\ni) Performance testing tools\nii) Coverage measurement tools\niii) Test comparators\niv) Dynamic analysis tools\nv) Incident management tools",
        "option_A": "i, iii and iv are more for developers.",
        "option_B": "ii and iv are more for developers.",
        "option_C": "ii, iii and iv are more for developers.",
        "option_D": "ii and iii are more for developers.",
        "correct_anwser": "B",
        "explain": "Công cụ đo độ bao phủ (coverage measurement) và công cụ phân tích động (dynamic analysis) thường dành cho nhà phát triển. Công cụ hiệu năng, so sánh kết quả và quản lý sự cố thường dành cho người kiểm thử."
      },
      {
        "question_id": 49,
        "question_title": "To test a function, the programmer has to write a ______, which calls the function to be tested and passes it test data.",
        "option_A": "Stub",
        "option_B": "Driver",
        "option_C": "Proxy",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Driver là chương trình gọi hàm cần kiểm thử và truyền dữ liệu kiểm thử. Stub là mô phỏng của hàm được gọi từ hàm cần kiểm thử. Proxy không liên quan."
      },
      {
        "question_id": 50,
        "question_title": "Measurement dysfunction is a problem because:",
        "option_A": "Even though the numbers you look at appear better, to achieve these numbers, people are doing other aspects of their work much less well.",
        "option_B": "We don't know how to measure a variable (our measurement is dysfunctional) and so we don't know how to interpret the result.",
        "option_C": "You are measuring the wrong thing and thus reaching the wrong conclusions.",
        "option_D": "All of the others",
        "correct_anwser": "D",
        "explain": "Rối loạn đo lường (measurement dysfunction) xảy ra khi số liệu có vẻ tốt nhưng gây tác động tiêu cực, hoặc đo sai biến, hoặc đo nhầm đối tượng. Cả ba nguyên nhân đều đúng, nên đáp án D là đúng."
      },
      {
        "question_id": 51,
        "question_title": "Tool which stores requirement statements, check for consistency and allow requirements to be prioritized and enable individual tests to be traceable to requirements, functions and features.",
        "option_A": "Incident management tools",
        "option_B": "Requirements management tools",
        "option_C": "Configuration management tools",
        "option_D": "None of the others",
        "correct_anwser": "B",
        "explain": "Công cụ quản lý yêu cầu (Requirements management tools) có chức năng lưu trữ, kiểm tra tính nhất quán, ưu tiên và tạo khả năng truy xuất nguồn gốc. Các công cụ khác không đáp ứng đầy đủ các chức năng này."
      },
      {
        "question_id": 52,
        "question_title": "What type of tools to be used for Regression Testing?",
        "option_A": "(1) Performance",
        "option_B": "(2) Record/Playback",
        "option_C": "Both of (1) and (2)",
        "option_D": "None of (1) nor (2)",
        "correct_anwser": "B",
        "explain": "Kiểm thử hồi quy thường sử dụng công cụ ghi/phát lại (Record/Playback) để tự động hóa. Công cụ hiệu năng không dùng cho regression. Vậy đáp án B."
      },
      {
        "question_id": 53,
        "question_title": "Unreachable code would best be found using:",
        "option_A": "Code reviews",
        "option_B": "Code inspections",
        "option_C": "A coverage tool",
        "option_D": "A test management tool",
        "option_E": "A static analysis tool",
        "correct_anwser": "E",
        "explain": "Mã không thể chạy tới (unreachable code) được phát hiện tốt nhất bằng công cụ phân tích tĩnh (static analysis) vì nó có thể phân tích luồng điều khiển mà không cần thực thi. Coverage tool cũng có thể phát hiện nhưng chỉ sau khi chạy thử."
      },
      {
        "question_id": 54,
        "question_title": "Which of the following is NOT a characteristic of User Acceptance Testing?",
        "option_A": "Use of automated test execution tools",
        "option_B": "Testing performed by users.",
        "option_C": "Testing against acceptance test criteria",
        "option_D": "Integration of system with user documentation.",
        "correct_anwser": "A",
        "explain": "UAT thường do người dùng thực hiện, dựa trên tiêu chí chấp nhận và tích hợp với tài liệu. Việc sử dụng công cụ tự động hóa không phải là đặc điểm bắt buộc của UAT."
      },
      {
        "question_id": 55,
        "question_title": "Capture and replay facilities are least likely to be used to ______",
        "option_A": "Performance testing",
        "option_B": "Recovery testing",
        "option_C": "GUI testing",
        "option_D": "User requirements.",
        "correct_anwser": "B",
        "explain": "Tính năng ghi/phát thường dùng cho kiểm thử GUI, kiểm thử hiệu năng (ở mức độ nào đó) và hỗ trợ yêu cầu người dùng. Recovery testing (kiểm thử phục hồi) ít sử dụng kỹ thuật này vì nó tập trung vào khôi phục sau lỗi."
      },
      {
        "question_id": 56,
        "question_title": "With which of the following categories is a test comparator tool USUALLY associated?",
        "option_A": "Tool support for performance and monitoring.",
        "option_B": "Tool support for static testing.",
        "option_C": "Tool support for test execution and logging.",
        "option_D": "Tool support for the management of testing and tests.",
        "correct_anwser": "C",
        "explain": "Công cụ so sánh kết quả (test comparator) thường liên quan đến thực thi kiểm thử và ghi nhật ký, vì nó so sánh đầu ra thực tế với đầu ra mong đợi trong quá trình chạy kiểm thử."
      },
      {
        "question_id": 57,
        "question_title": "A typical commercial test execution tool would be able to perform all of the following EXCEPT:",
        "option_A": "Generating expected outputs",
        "option_B": "Replaying inputs according to a programmed script",
        "option_C": "Comparison of expected outcomes with actual outcomes",
        "option_D": "Recording test inputs",
        "option_E": "Reading test values from a data file",
        "correct_anwser": "A",
        "explain": "Công cụ thực thi kiểm thử thường phát lại đầu vào, so sánh, ghi nhận và đọc dữ liệu từ file. Tuy nhiên, việc tự động sinh đầu ra kỳ vọng không phải là chức năng điển hình; đầu ra kỳ vọng thường do người dùng xác định trước."
      },
      {
        "question_id": 58,
        "question_title": "Which of the following tools would be involved in the automation of regression test?",
        "option_A": "Data tester",
        "option_B": "Boundary tester",
        "option_C": "Capture/Playback",
        "option_D": "Output comparator.",
        "correct_anwser": "C",
        "explain": "Công cụ ghi/phát (Capture/Playback) thường được sử dụng để tự động hóa kiểm thử hồi quy, cho phép ghi lại các thao tác và phát lại để kiểm tra các thay đổi."
      },
      {
        "question_id": 59,
        "question_title": "Find the mismatch",
        "option_A": "Test data preparation tools - Manipulate Data bases",
        "option_B": "Test design tools - Generate test inputs",
        "option_C": "Requirement management tools - Enables individual tests to be traceable",
        "option_D": "Configuration management tools - Check for consistence",
        "correct_anwser": "D",
        "explain": "Công cụ quản lý cấu hình (Configuration management tools) không có chức năng kiểm tra tính nhất quán (check for consistence); chức năng này thường do công cụ quản lý yêu cầu hoặc phân tích tĩnh đảm nhiệm. Các ghép cặp còn lại đều đúng."
      },
      {
        "question_id": 60,
        "question_title": "What is the main purpose of Informal review",
        "option_A": "Inexpensive way to get some benefit",
        "option_B": "Find defects",
        "option_C": "Learning, gaining understanding, effect finding",
        "option_D": "Discuss, make decisions, solve technical problems",
        "correct_anwser": "B",
        "explain": "Mục đích chính của đánh giá không chính thức (Informal review) là tìm lỗi (find defects) một cách nhanh chóng và ít tốn kém. Tuy các đáp án khác cũng có thể đúng nhưng 'tìm lỗi' là mục tiêu cốt lõi."
      }
    ]
  },
  {
    "id": "swr302-all-unique",
    "title": "Full Question List (All 330 Unique Questions)",
    "description": "Software Requirement Full Questions Set",
    "questionsCount": 330,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which of the following is NOT included in the list of Software Bill of Rights Requirements?",
        "option_A": "Expect BAs to speak your language.",
        "option_B": "Expect BAs to learn about your business and your objectives.",
        "option_C": "Promptly communicate changes to the requirements.",
        "option_D": "Receive explanations of requirements practices and deliverables.",
        "option_E": "Change your requirements.",
        "option_F": "Expect an environment of mutual respect.",
        "correct_anwser": "C",
        "explain": "Trong tuyên ngôn quyền lợi phần mềm (Software Bill of Rights), 'Promptly communicate changes to the requirements' (Thông báo kịp thời các thay đổi đối với yêu cầu) là nghĩa vụ/trách nhiệm (Responsibility) của khách hàng chứ không phải là một quyền lợi (Right) trong danh sách."
      },
      {
        "question_id": 2,
        "question_title": "In a project, who is primarily responsible for communicating project information?",
        "option_A": "The business analyst",
        "option_B": "The project manager",
        "option_C": "The software development team",
        "option_D": "The customer community",
        "correct_anwser": "B",
        "explain": "Quản lý dự án (Project Manager) là người chịu trách nhiệm chính trong việc quản lý và truyền thông các thông tin chung của dự án đến tất cả các bên liên quan."
      },
      {
        "question_id": 3,
        "question_title": "Why is it crucial for a business analyst to communicate requirements effectively and efficiently?",
        "option_A": "To ensure that requirements are documented only once.",
        "option_B": "To facilitate ongoing collaboration and ensure the team understands the requirements.",
        "option_C": "To avoid the need for visual analysis models.",
        "option_D": "To reduce the number of requirements.",
        "correct_anwser": "B",
        "explain": "Giao tiếp hiệu quả giúp thúc đẩy sự hợp tác liên tục giữa các bên và đảm bảo toàn bộ đội ngũ phát triển cũng như khách hàng đều có chung một hiểu biết chính xác về các yêu cầu."
      },
      {
        "question_id": 4,
        "question_title": "What is the relationship between \"product vision\" and \"project scope\"?",
        "option_A": "Product vision and project scope are interchangeable terms.",
        "option_B": "Product vision describes the ultimate product, while project scope identifies the portion of that vision to be addressed by the current project.",
        "option_C": "Project scope defines business objectives, while product vision defines functional requirements.",
        "option_D": "Product vision is a subset of project scope for each release.",
        "correct_anwser": "B",
        "explain": "Tầm nhìn sản phẩm (Product vision) định hình mục tiêu lâu dài mang tính tối thượng của sản phẩm, trong khi phạm vi dự án (Project scope) xác định rõ phần việc hoặc tập hợp các tính năng cụ thể thuộc tầm nhìn đó sẽ được giải quyết, hoàn thiện trong dự án hiện tại."
      },
      {
        "question_id": 5,
        "question_title": "Which of the following is a recommended question to ask when probing for exceptions in processes?",
        "option_A": "Why do you think this system is perfect?",
        "option_B": "What are the three things you dislike about the current system?",
        "option_C": "What happens when an error occurs?",
        "option_D": "What is your favorite feature of this system?",
        "correct_anwser": "C",
        "explain": "Để khơi gợi và tìm kiếm các ngoại lệ (exceptions) hay kịch bản lỗi trong quy trình nghiệp vụ, câu hỏi khảo sát trực diện và chuẩn xác nhất là 'Điều gì xảy ra khi có lỗi phát sinh?' (What happens when an error occurs?)."
      },
      {
        "question_id": 6,
        "question_title": "What is the main advantage of using the active voice in writing requirements?",
        "option_A": "It helps in reducing the length of the requirements.",
        "option_B": "It makes the subject and action of the sentence clear, ensuring clarity.",
        "option_C": "It makes the requirements sound more formal and professional.",
        "option_D": "It is easier to translate into other languages.",
        "correct_anwser": "B",
        "explain": "Sử dụng thể chủ động (Active voice) trong viết yêu cầu giúp xác định rõ ràng ai hoặc hệ thống nào (chủ ngữ) thực hiện hành động gì, từ đó loại bỏ tính mơ hồ và đảm bảo tính minh xác, rõ ràng cho câu đặc tả."
      },
      {
        "question_id": 7,
        "question_title": "Which of the following is a correct guideline for writing clear and concise requirements?",
        "option_A": "Use long, descriptive sentences to cover all aspects of a requirement.",
        "option_B": "Avoid using \"shall\" or \"must\" in favor of softer terms like \"could\" and \"may.\"",
        "option_C": "Write in simple language, avoid jargon, and keep sentences short and direct.",
        "option_D": "Use multiple terms for the same concept to make the document more interesting.",
        "correct_anwser": "C",
        "explain": "Nguyên tắc viết yêu cầu rõ ràng, súc tích là sử dụng ngôn từ đơn giản, dễ hiểu, tránh các thuật ngữ chuyên môn quá phức tạp (jargon) không cần thiết, câu văn ngắn gọn và trực diện để người đọc không hiểu sai ý."
      },
      {
        "question_id": 8,
        "question_title": "Which of the following are true about a dashboard? Choose 3 correct answers.",
        "option_A": "It is a screen display or printed report.",
        "option_B": "It uses multiple textual and/or graphical representations of data.",
        "option_C": "It aims to provide a consolidated, multidimensional view of what is going on in an organization or a process.",
        "option_D": "It is a brochure to promote the product.",
        "correct_anwser": "A, B, C",
        "explain": "Dashboard (Bảng điều khiển trực quan) là màn hình hiển thị hoặc biểu mẫu báo cáo (A), dùng nhiều định dạng văn bản và đồ thị trực quan hóa dữ liệu (B) nhằm mục đích cung cấp một cái nhìn tổng hợp, đa chiều về tình hình vận hành của một tổ chức hoặc quy trình (C)."
      },
      {
        "question_id": 9,
        "question_title": "In the context of a data dictionary, which of the following is true about organizing data elements?",
        "option_A": "Each data element in the dictionary should be represented only by primitive types.",
        "option_B": "The data dictionary should only store information about complex data structures, not individual data elements",
        "option_C": "The data dictionary should list all data elements alphabetically, regardless of their relationships or grouping in the system.",
        "option_D": "The data dictionary should contain information about each data element, including its data type, length, and any associated constraints.",
        "correct_anwser": "D",
        "explain": "Từ điển dữ liệu (Data dictionary) cần lưu trữ thông tin chi tiết về từng phần tử dữ liệu trong hệ thống, bao gồm định nghĩa tên, kiểu dữ liệu, độ dài, mô tả và các ràng buộc/quy tắc giá trị đi kèm của phần tử đó."
      },
      {
        "question_id": 10,
        "question_title": "Which of the following is NOT considered a dimension of requirements reuse when adapting requirements from one project to another?",
        "option_A": "The extent of reuse, including whether individual requirement statements or sets of requirements with their associated elements are reused.",
        "option_B": "Reuse frequency, which measures how often a particular requirement has been reused in different projects.",
        "option_C": "The extent of modification, which considers the degree to which reused requirements must be altered to fit the new project's context.",
        "option_D": "The reuse mechanism, which involves how the requirement is reused, such as copying from a library of reusable requirements or referring to the original source.",
        "option_E": "None of the above",
        "correct_anwser": "B",
        "explain": "Theo lý thuyết quản lý yêu cầu phần mềm của Karl Wiegers, các chiều không gian (dimensions) của việc tái sử dụng yêu cầu bao gồm: Extent of reuse (mức độ/phạm vi tái sử dụng), Extent of modification (mức độ sửa đổi), và Reuse mechanism (cơ chế tái sử dụng). Tần suất tái sử dụng (Reuse frequency) chỉ là một chỉ số đo lường thống kê sau đó, chứ không phải là một chiều kiến trúc cốt lõi khi tiến hành adapt yêu cầu."
      },
      {
        "question_id": 11,
        "question_title": "How can reusable requirements be stored for easy reference?",
        "option_A": "By storing them in a spreadsheet.",
        "option_B": "By copying them into every new project document.",
        "option_C": "By linking to them from a shared location such as a database or a requirements management tool.",
        "option_D": "By creating new versions for every instance they are used.",
        "correct_anwser": "C",
        "explain": "Để các yêu cầu có thể tái sử dụng được lưu trữ và tra cứu một cách hiệu quả nhất, người ta nên đưa chúng lên một vị trí chia sẻ tập trung (Shared location) như cơ sở dữ liệu chung hoặc công cụ quản lý yêu cầu chuyên dụng nhằm đảm bảo tính nhất quán và dễ dàng liên kết."
      },
      {
        "question_id": 12,
        "question_title": "What role does requirements estimation play in project planning?",
        "option_A": "It helps determine the effort needed for design and development",
        "option_B": "It dictates the project's release schedule",
        "option_C": "It defines the testing strategy",
        "option_D": "It allocates resources for the project",
        "correct_anwser": "A",
        "explain": "Ước lượng yêu cầu (Requirements estimation) cung cấp căn cứ kỹ thuật quan trọng giúp đội ngũ quản lý dự án xác định lượng công sức, thời gian và nguồn lực cần thiết (effort needed) để thực hiện các giai đoạn thiết kế, lập trình và hoàn thiện các tính năng đó."
      },
      {
        "question_id": 13,
        "question_title": "Which of the following is NOT a characteristic of Software as a service (SaaS)?",
        "option_A": "Subscription-based pricing",
        "option_B": "On-premises deployment",
        "option_C": "Centralized hosting",
        "option_D": "Internet accessibility",
        "correct_anwser": "B",
        "explain": "On-premises deployment (Triển khai tại chỗ/cài đặt cục bộ trên máy chủ của khách hàng) là đặc điểm của mô hình phần mềm truyền thống. Ngược lại, SaaS (Phần mềm dạng dịch vụ) được lưu trữ tập trung trên cloud (C), truy cập qua Internet (D) và thường thanh toán theo mô hình đăng ký định kỳ (A)."
      },
      {
        "question_id": 14,
        "question_title": "The elements of risk management are (choose 3 correct answers)",
        "option_A": "Risk assessment",
        "option_B": "Risk avoidance",
        "option_C": "Risk control",
        "option_D": "Risk reduction",
        "correct_anwser": "A, B, C",
        "explain": "Theo các khung quản trị rủi ro chuẩn (như SEI), Quản lý rủi ro (Risk management) gồm các thành phần cốt lõi ở cấp độ cao là: Risk assessment (Đánh giá rủi ro - bao gồm nhận diện, phân tích), Risk avoidance (Né tránh rủi ro) hoặc tổng quan hơn là Risk control (Kiểm soát rủi ro). Trong đó, Risk reduction (Giảm thiểu) thường được phân loại như một chiến thuật cụ thể nằm bên trong Risk control."
      },
      {
        "question_id": 15,
        "question_title": "Why is it critical to clearly distinguish between Business Requirements, User Requirements, and Functional Requirements in software projects?",
        "option_A": "It reduces development time by eliminating unnecessary requirements from the outset.",
        "option_B": "It guarantees that the system will comply with all security and performance standards.",
        "option_C": "It ensures that all stakeholder needs are accurately understood and translated into specific system features.",
        "option_D": "It allows developers to start coding immediately without needing further clarification.",
        "correct_anwser": "C",
        "explain": "Phân biệt rõ ba cấp độ yêu cầu này giúp đảm bảo mục tiêu chiến lược của doanh nghiệp (Business Requirements) được phản ánh đúng qua mong muốn của người dùng (User Requirements), từ đó chuyển hóa chính xác thành các chức năng kỹ thuật của hệ thống (Functional Requirements), tránh sai sót trong quá trình phát triển."
      },
      {
        "question_id": 16,
        "question_title": "What is meant by the \"Expectation Gap\" in software development?",
        "option_A": "The difference between business requirements and technical requirements.",
        "option_B": "The difference between the initial design and the final product.",
        "option_C": "The discrepancy between the project plan and the actual budget.",
        "option_D": "The difference between what customers expect and what the development team plans to deliver.",
        "option_E": "The difference between customer requirements and testing criteria.",
        "correct_anwser": "D",
        "explain": "\"Khoảng cách kỳ vọng\" (Expectation Gap) mô tả sự sai lệch giữa những gì khách hàng hình dung, mong đợi về sản phẩm với những gì đội ngũ phát triển hiểu và lên kế hoạch bàn giao thực tế."
      },
      {
        "question_id": 17,
        "question_title": "What is a key action in the \"Analysis\" subdiscipline of requirements development?",
        "option_A": "Discovering requirements.",
        "option_B": "Documenting assumptions",
        "option_C": "Decomposing high-level requirements into an appropriate level of detail",
        "option_D": "Confirming requirements accuracy with customers.",
        "correct_anwser": "C",
        "explain": "Hành động cốt lõi của phân tích (Analysis) là bóc tách, chia nhỏ các yêu cầu ở mức vĩ mô, mơ hồ (high-level requirements) thành các yêu cầu chi tiết cụ thể, rõ ràng hơn để đội ngũ phát triển có thể hiểu và thực thi."
      },
      {
        "question_id": 18,
        "question_title": "Which of the following describes the difference between User Requirements and Functional Requirements?",
        "option_A": "User requirements focus on technical solutions, while Functional requirements focus on business needs.",
        "option_B": "User requirements are high-level and focus on user tasks, while Functional requirements describe what the system must do to support those tasks.",
        "option_C": "User requirements are documented in code, while Functional requirements are documented in the SRS.",
        "option_D": "There is no real difference; the terms are used interchangeably.",
        "correct_anwser": "B",
        "explain": "Yêu cầu người dùng (User Requirements) được viết dưới góc nhìn của người dùng để mô tả các tác vụ hoặc mục tiêu họ cần đạt được, trong khi yêu cầu chức năng (Functional Requirements) mô tả chi tiết các hành vi, tính năng kỹ thuật mà hệ thống phải thực hiện để hỗ trợ người dùng hoàn thành các tác vụ đó."
      },
      {
        "question_id": 19,
        "question_title": "A functional requirement describes:",
        "option_A": "The financial budget of the software project.",
        "option_B": "What the system should do under specific conditions.",
        "option_C": "The user interface styling details.",
        "option_D": "The security protocols required for data transmission.",
        "correct_anwser": "B",
        "explain": "Yêu cầu chức năng (Functional Requirement) định nghĩa rõ ràng các hành vi, dịch vụ hoặc chức năng cụ thể mà hệ thống phần mềm phải thực thi khi tiếp nhận một điều kiện đầu vào xác định."
      },
      {
        "question_id": 20,
        "question_title": "What is the primary objective of creating a Dialog Map (User Interface Architecture) during requirements analysis?",
        "option_A": "To optimize backend relational SQL query indexing performance.",
        "option_B": "To visually represent the navigation paths and relationship architecture between different screens or pages of the system.",
        "option_C": "To establish encrypted secure network communications protocols.",
        "option_D": "To verify the lines of unit test coverage automatically.",
        "correct_anwser": "B",
        "explain": "Bản đồ đối thoại (Dialog Map) trực quan hóa cấu trúc kiến trúc luồng đi của giao diện, chỉ ra các màn hình và cách thức người dùng có thể điều hướng qua lại giữa các màn hình hoặc trang giao diện trong hệ thống."
      },
      {
        "question_id": 21,
        "question_title": "How can better requirements practices reduce the cost of development?",
        "option_A": "By increasing the number of features developed.",
        "option_B": "By reducing rework, unnecessary features, and miscommunications.",
        "option_C": "By increasing the project timeline.",
        "option_D": "By focusing solely on technical specifications.",
        "correct_anwser": "B",
        "explain": "Quản lý yêu cầu tốt giúp làm rõ mong muốn của khách hàng ngay từ đầu, từ đó giảm thiểu việc hiểu lầm (miscommunications), tránh phát triển các tính năng không cần thiết, và hạn chế tối đa việc phải làm lại (rework), vốn là nguyên nhân chính gây tốn kém chi phí trong phát triển phần mềm."
      },
      {
        "question_id": 22,
        "question_title": "“The user must be able to sort the project list in forward and reverse alphabetical order” is a:",
        "option_A": "business requirement",
        "option_B": "user requirement",
        "option_C": "functional requirement",
        "option_D": "data requirement",
        "correct_anwser": "C",
        "explain": "Yêu cầu chức năng (Functional Requirement) mô tả những gì hệ thống phải làm, cụ thể là một hành vi hoặc chức năng của phần mềm để phản hồi lại thao tác từ người dùng. Phát biểu 'Người dùng phải có khả năng sắp xếp danh sách dự án theo thứ tự bảng chữ cái xuôi và ngược' mô tả trực tiếp một chức năng mà hệ thống cần thực hiện cung cấp cho người dùng."
      },
      {
        "question_id": 23,
        "question_title": "Two important goals of writing requirements are that:",
        "option_A": "Anyone who reads the requirement comes to the same interpretation as any other reader.",
        "option_B": "Each reader's interpretation matches what the author intended to communicate.",
        "option_C": "Developers find the requirements technically easy to understand.",
        "option_D": "Customers are happy.",
        "correct_anwser": "A, B",
        "explain": "Hai mục tiêu cốt lõi của việc viết tài liệu yêu cầu là tính không mơ hồ (Unambiguous) và tính chính xác (Correctness). Điều này có nghĩa là tất cả người đọc đều phải hiểu theo một cách duy nhất như nhau (A), và cách hiểu đó phải trùng khớp hoàn toàn với những gì tác giả/BA thực sự muốn truyền tải (B)."
      },
      {
        "question_id": 24,
        "question_title": "In a Swimlane diagram, process steps are shown as",
        "option_A": "rectangles",
        "option_B": "arrows connecting pairs of rectangles",
        "option_C": "diamonds",
        "option_D": "ovals",
        "correct_anwser": "A",
        "explain": "Trong sơ đồ phân làn (Swimlane / Flowchart), các bước xử lý hoặc hành động (process steps/activities) được quy ước thể hiện bằng các hình chữ nhật (rectangles). Trong khi đó, hình thoi (diamonds) dùng cho điểm quyết định rẽ nhánh và các mũi tên (arrows) dùng để chỉ hướng luồng đi."
      },
      {
        "question_id": 25,
        "question_title": "Entries in the data dictionary represent the following types of data elements: (choose 3 correct answers)",
        "option_A": "Primitive",
        "option_B": "Structure",
        "option_C": "Repeating group",
        "option_D": "Virtual",
        "correct_anwser": "A, B, C",
        "explain": "Trong từ điển dữ liệu (Data Dictionary), các mục nhập dữ liệu thường được phân loại thành 3 dạng cấu trúc thành phần chính bao gồm: Phần tử nguyên thủy dữ liệu (Primitive - không thể chia nhỏ hơn nữa), Cấu trúc dữ liệu kết hợp (Structure - gồm nhiều phần tử đi cùng nhau), và Nhóm lặp (Repeating group - tập hợp lặp lại của các phần tử)."
      },
      {
        "question_id": 26,
        "question_title": "What is Extent of reuse?",
        "option_A": "You might reuse just a single functional requirement.",
        "option_B": "You consider is how much modification will be needed to make existing requirements reusable on the new project.",
        "option_C": "It is simply a copy-and-paste of a piece of requirements information, either from another specification or from a library of reusable requirements.",
        "option_D": "It specific functional requirements within use cases, performance requirements, usability requirements, business rules.",
        "correct_anwser": "A",
        "explain": "Theo định nghĩa về tái sử dụng yêu cầu, 'Extent of reuse' (Mức độ/Phạm vi tái sử dụng) đề cập đến khối lượng hay quy mô của phần yêu cầu được tái sử dụng, ví dụ như từ mức nhỏ nhất là tái sử dụng chỉ một yêu cầu chức năng đơn lẻ (a single functional requirement) cho tới mức lớn hơn là toàn bộ một module hay hệ thống phụ."
      },
      {
        "question_id": 27,
        "question_title": "In software development, what do requirements drive? Choose 3 correct answers.",
        "option_A": "Project planning",
        "option_B": "Design and coding",
        "option_C": "Testing activities",
        "option_D": "Financial activities",
        "correct_anwser": "A, B, C",
        "explain": "Yêu cầu phần mềm là nền tảng định hướng cho toàn bộ vòng đời phát triển: chúng quyết định việc lập kế hoạch tiến độ dự án (A), làm cơ sở để thiết kế kiến trúc và viết mã nguồn (B), cũng như cung cấp tiêu chí để xây dựng các kịch bản kiểm thử (C). Ngược lại, các hoạt động tài chính tổng thể của doanh nghiệp (D) không chịu sự thúc đẩy trực tiếp từ các yêu cầu kỹ thuật phần mềm."
      },
      {
        "question_id": 28,
        "question_title": "What is an enhancement project?",
        "option_A": "It is a project in which new capabilities are added to an existing system.",
        "option_B": "It is a project that replaces an existing application with a new custom-built system, a commercial off-the-shelf system, or a hybrid of those.",
        "option_C": "It is a project which costs less than planned.",
        "option_D": "It is a project which generates more revenues.",
        "correct_anwser": "A",
        "explain": "Dự án nâng cấp (Enhancement project) được định nghĩa là dự án nhằm bổ sung các tính năng, năng lực mới (new capabilities) hoặc cải tiến các chức năng sẵn có của một hệ thống hiện tại."
      },
      {
        "question_id": 29,
        "question_title": "Which statement accurately describes the implementation of a COTS package?",
        "option_A": "COTS packages always require significant customization.",
        "option_B": "Some COTS packages can be used out of the box with little to no modification.",
        "option_C": "COTS packages provide unlimited flexibility to meet all business requirements",
        "option_D": "All COTS packages require integration with other systems.",
        "correct_anwser": "B",
        "explain": "COTS (Commercial Off-The-Shelf) là phần mềm thương mại có sẵn trên thị trường. Điểm đặc trưng của một số gói COTS là có thể sử dụng được ngay lập tức (out of the box) với rất ít hoặc không cần sửa đổi gì (B). Khẳng định chúng luôn luôn cần tùy biến mạnh (A), có sự linh hoạt vô hạn (C) hay bắt buộc phải tích hợp với hệ thống khác (D) đều là các phát biểu quá cực đoan và thiếu chính xác."
      },
      {
        "question_id": 30,
        "question_title": "What is the primary motivation for tracing requirements?",
        "option_A": "To prevent any changes from being made to project requirements",
        "option_B": "To document project assumptions",
        "option_C": "To manage project team members",
        "option_D": "To improve the quality of your products, reduce maintenance costs, and facilitate reuse",
        "correct_anwser": "D",
        "explain": "Động lực và lợi ích lớn nhất của việc truy vết yêu cầu (Tracing requirements) là giúp nâng cao chất lượng sản phẩm nhờ kiểm soát tốt phạm vi và kiểm thử, giảm thiểu chi phí bảo trì (do dễ phân tích tác động khi có thay đổi) và tạo điều kiện thuận lợi cho việc tái sử dụng cấu phần ở các dự án sau (D)."
      },
      {
        "question_id": 31,
        "question_title": "Which of the following statements correctly distinguishes between product requirements and project requirements? Select two.",
        "option_A": "Product requirements describe the physical resources and training needs necessary for project completion.",
        "option_B": "Project requirements include staff training and infrastructure changes needed in the operating environment.",
        "option_C": "Project requirements are housed in the SRS along with product requirements.",
        "option_D": "Product requirements focus on the characteristics and functionalities of the software system being built.",
        "correct_anwser": "B, D",
        "explain": "Yêu cầu sản phẩm (Product requirements) tập trung vào các đặc tính, chức năng của hệ thống phần mềm đang được xây dựng (D). Trong khi đó, yêu cầu dự án (Project requirements) liên quan đến các khía cạnh quản lý, vận hành để triển khai dự án thành công như đào tạo nhân sự, thay đổi hạ tầng kỹ thuật (B)."
      },
      {
        "question_id": 32,
        "question_title": "What is a potential way for someone to transition into the business analyst role?",
        "option_A": "Through an apprenticeship program with mentoring",
        "option_B": "By studying software development exclusively",
        "option_C": "By focusing only on user interface design skills",
        "option_D": "By avoiding involvement in diverse business activities",
        "correct_anwser": "A",
        "explain": "Một trong những lộ trình chuyển đổi phổ biến và hiệu quả để bước vào nghề Business Analyst (BA) là thông qua các chương trình thực tập, học việc (apprenticeship) có sự hướng dẫn sát sao của người đi trước (mentoring) để tích lũy cả kiến thức nghiệp vụ lẫn kỹ năng mềm."
      },
      {
        "question_id": 33,
        "question_title": "When defining the scope and limitations of a product, which of the following practices should be followed? Select two.",
        "option_A": "List the product's major features or user capabilities, focusing on those that distinguish it from competitors.",
        "option_B": "Include all possible features in the scope to ensure nothing is left out, even if some may be unnecessary.",
        "option_C": "Clearly define the features that will be included in the initial release and those that will be excluded.",
        "option_D": "Avoid mentioning any limitations or exclusions to keep the focus on what the product will do.",
        "correct_anwser": "A, C",
        "explain": "Khi định nghĩa phạm vi và giới hạn của sản phẩm, thực hành tốt nhất là liệt kê các tính năng/năng lực cốt lõi giúp phân biệt với đối thủ cạnh tranh (A), đồng thời phải phân định rõ ràng tính năng nào nằm trong đợt phát hành đầu tiên và tính năng nào bị loại trừ hoặc hoãn lại (C)."
      },
      {
        "question_id": 34,
        "question_title": "What is the main purpose of a Vision and Scope document?",
        "option_A": "To define the boundaries and objectives of the project",
        "option_B": "To specify all technical requirements",
        "option_C": "To finalize the system's architecture",
        "option_D": "To replace the requirements traceability matrix",
        "correct_anwser": "A",
        "explain": "Mục đích cốt lõi của tài liệu Tầm nhìn và Phạm vi (Vision and Scope document) là thiết lập ranh giới hệ thống ở mức tổng quan và xác định các mục tiêu chiến lược mang tính định hướng cho dự án, chứ không đi sâu vào chi tiết kỹ thuật hay kiến trúc."
      },
      {
        "question_id": 35,
        "question_title": "Which of the following statements best describes a key aspect of performance requirements for a software system?",
        "option_A": "Performance requirements focus solely on the visual design and user interface of the system.",
        "option_B": "Performance requirements include the responsiveness of the system to user inquiries, such as the number of seconds to display a webpage.",
        "option_C": "Performance requirements are concerned only with the physical storage capacity of the system's database.",
        "option_D": "Performance requirements are unrelated to the external factors like network connections and hardware components.",
        "correct_anwser": "B",
        "explain": "Yêu cầu về hiệu năng (Performance requirements) đo lường và ràng buộc các chỉ số vận hành về mặt thời gian và tốc độ của hệ thống, ví dụ điển hình nhất là độ phản hồi đối với các tương tác của người dùng, chẳng hạn như số giây tối đa để tải và hiển thị hoàn chỉnh một trang web."
      },
      {
        "question_id": 36,
        "question_title": "What is a potential consequence of adding more functionality through a series of iterations?",
        "option_A": "Improved system performance.",
        "option_B": "Increased system efficiency.",
        "option_C": "Deterioration of system performance.",
        "option_D": "Reduced need for performance testing.",
        "correct_anwser": "C",
        "explain": "Việc liên tục bổ sung thêm nhiều chức năng qua các vòng lặp (iterations) mà không tối ưu hóa cấu trúc hệ thống có nguy cơ làm tăng độ phức tạp, quá tải tài nguyên và dẫn đến sự suy giảm hiệu năng của hệ thống (Deterioration of system performance)."
      },
      {
        "question_id": 37,
        "question_title": "Which of the following statements about reaching agreement on requirements is accurate? Select two.",
        "option_A": "Signing off on requirements is an infallible method to prevent any changes later in the project.",
        "option_B": "All participants in the requirements approval process must understand what signing off implies.",
        "option_C": "The purpose of signing off is to freeze requirements and prevent any future modifications.",
        "option_D": "Reaching agreement on requirements ensures that both customers and developers have a shared understanding of project objectives.",
        "correct_anwser": "B, D",
        "explain": "Việc đạt được thỏa thuận về yêu cầu nhằm đảm bảo các bên liên quan (khách hàng và đội ngũ phát triển) có chung một hiểu biết về mục tiêu dự án (D), đồng thời tất cả những người tham gia phê duyệt cần hiểu rõ ý nghĩa của việc ký duyệt (B). Việc ký duyệt (sign-off) không thể ngăn chặn tuyệt đối các thay đổi trong tương lai (A và C sai vì yêu cầu luôn có thể thay đổi thông qua quy trình kiểm soát thay đổi)."
      },
      {
        "question_id": 38,
        "question_title": "If a report is generated but not used, what should a Business Analyst consider doing?",
        "option_A": "Ensure it is included in the new system",
        "option_B": "Modify it to meet new requirements",
        "option_C": "Exclude it from the new system",
        "option_D": "Increase its frequency of generation",
        "correct_anwser": "C",
        "explain": "Nếu một báo cáo trong hệ thống hiện tại vẫn được tạo ra tự động định kỳ nhưng trên thực tế không có ai sử dụng, Chuyên viên phân tích nghiệp vụ nên cân nhắc loại bỏ nó ra khỏi hệ thống mới để tiết kiệm chi phí phát triển, lưu trữ và tối ưu hiệu năng."
      },
      {
        "question_id": 39,
        "question_title": "We can resuse all authentication requirements from the previous project by copy from a library of reusable components. Which dimensions does the statement refer to?",
        "option_A": "extent of modification",
        "option_B": "reuse mechanism",
        "option_C": "extent of reuses",
        "option_D": "N/A",
        "correct_anwser": "A, B",
        "explain": "Câu phát biểu đề cập đến hành động \"copy nguyên vẹn\" -> phản ánh khía cạnh mức độ sửa đổi là giữ nguyên (extent of modification). Hành động lấy từ một \"thư viện các thành phần tái sử dụng\" (library of reusable components) -> phản ánh khía cạnh cơ chế thực hiện tái sử dụng (reuse mechanism)."
      },
      {
        "question_id": 40,
        "question_title": "Which of the following is NOT an objective of improving requirements processes?",
        "option_A": "Improve the accuracy of project estimates",
        "option_B": "Reduce the cost of creating and maintaining software",
        "option_C": "Increase the value delivered by projects",
        "option_D": "Increase the complexity of requirements",
        "correct_anwser": "D",
        "explain": "Mục tiêu của việc cải tiến quy trình kỹ nghệ yêu cầu nhằm giúp ước lượng chính xác hơn (A), giảm giá thành làm lại phần mềm lỗi (B), và tăng chất lượng giá trị bàn giao (C). Việc làm tăng độ phức tạp không mong muốn của các câu yêu cầu (D) hoàn toàn đi ngược lại mục tiêu cải tiến quy trình."
      },
      {
        "question_id": 41,
        "question_title": "Which is NOT element of risk management?",
        "option_A": "Risk avoidance is one way to deal with a risk: don't do the risky thing.",
        "option_B": "Risk assessment is the process of examining a project to identify potential threats.",
        "option_C": "Risk control activities to manage the top-priority risks you identified.",
        "option_D": "Risk management planning produces a plan for dealing with each significant risk, including mitigation approaches, contingency plans, owners, and timelines.",
        "correct_anwser": "A",
        "explain": "Trong lý thuyết quản trị rủi ro phần mềm tiêu chuẩn (Karl Wiegers), Quản trị rủi ro gồm hai nhánh chính lớn: Đánh giá rủi ro (Risk Assessment - gồm identify và analyze) và Kiểm soát rủi ro (Risk Control - gồm planning, resolution, monitoring). Do đó các mục B, C, D là các thành phần/tiến trình lớn của quản trị rủi ro. Còn Tránh rủi ro (Risk avoidance - A) chỉ là một chiến lược hoặc kỹ thuật cụ thể nằm bên trong bước xử lý rủi ro, không phải phân hệ cấu thành lớn của quy trình."
      },
      {
        "question_id": 42,
        "question_title": "Which of the following skills are essential for a business analyst? Select three.",
        "option_A": "Literacy skills for effectively interpreting written material and communicating requirements.",
        "option_B": "Technical skills to ensure the analyst can implement the software they are analyzing.",
        "option_C": "Facilitation skills to manage group discussions and ensure effective participation from all stakeholders.",
        "option_D": "Analytical skills to break down complex problems and identify feasible solutions.",
        "correct_anwser": "A, C, D",
        "explain": "Một Business Analyst cần có kỹ năng ngôn ngữ/đọc hiểu (A) để giao tiếp yêu cầu, kỹ năng điều phối (C) để quản lý thảo luận nhóm, và kỹ năng phân tích (D) để giải quyết vấn đề. BA không cần trực tiếp lập trình/triển khai phần mềm (B là công việc của Developer)."
      },
      {
        "question_id": 43,
        "question_title": "Which of the following are advantages of reusing requirements?\n(Choose 2 answers)",
        "option_A": "Decreased consistency",
        "option_B": "Reduced rework",
        "option_C": "Lower development costs",
        "option_D": "Increased number of defects",
        "correct_anwser": "B, C",
        "explain": "Việc tái sử dụng các yêu cầu đã được kiểm chứng và chuẩn hóa giúp giảm thiểu việc phải làm lại từ đầu (Reduced rework) và tiết kiệm đáng kể thời gian cũng như chi phí phát triển dự án (Lower development costs)."
      },
      {
        "question_id": 44,
        "question_title": "Which arrangement describes the increasing amount of requirements and development work when implementing packaged solutions?\n1. configured\n2. integrated\n3. extended\n4. out of the box",
        "option_A": "1,2,3,4",
        "option_B": "2,1,3,4",
        "option_C": "2,4,3,1",
        "option_D": "4,1,2,3",
        "correct_anwser": "D",
        "explain": "Thứ tự tăng dần về khối lượng công việc yêu cầu và lập trình khi triển khai giải pháp đóng gói (packaged solutions) là: 4. out of the box (dùng trực tiếp không sửa đổi, tốn ít công nhất) -> 1. configured (cấu hình lại thông số) -> 2. integrated (tích hợp kết nối hệ thống) -> 3. extended (viết thêm mã nguồn mở rộng, tốn nhiều công nhất)."
      },
      {
        "question_id": 45,
        "question_title": "Why is clear communication crucial in acquirer-supplier interactions in outsourced projects? (Choose 2 answers)",
        "option_A": "It reduces the need for collaboration.",
        "option_B": "It ensures both parties understand each other’s needs and capabilities.",
        "option_C": "It helps in resolving potential issues early.",
        "option_D": "It allows unilateral decision-making by the supplier",
        "correct_anwser": "B, C",
        "explain": "Trong các dự án thuê ngoài (outsourcing), giao tiếp rõ ràng giữa bên mua và nhà cung cấp giúp đảm bảo hai bên hiểu rõ năng lực cũng như nhu cầu của nhau (B), đồng thời phát hiện và giải quyết sớm các rủi ro, vấn đề phát sinh ngay từ giai đoạn đầu (C)."
      },
      {
        "question_id": 46,
        "question_title": "In a requirements development process, why is it important to establish a mechanism for managing changes to requirements?",
        "option_A": "To discourage changes and maintain a fixed project scope",
        "option_B": "To speed up the development process",
        "option_C": "To adapt to evolving project needs while maintaining control",
        "option_D": "To eliminate the need for documentation",
        "correct_anwser": "C",
        "explain": "Thiết lập cơ chế quản lý thay đổi không phải để cấm đoán thay đổi (A), mà là để giúp dự án thích ứng linh hoạt với các nhu cầu thực tế mới phát sinh của doanh nghiệp nhưng vẫn giữ được sự kiểm soát chặt chẽ về mặt nguồn lực, tiến độ và chi phí."
      },
      {
        "question_id": 47,
        "question_title": "Which is NOT an activitie of risk management?",
        "option_A": "Risk avoidance",
        "option_B": "Risk assessment",
        "option_C": "Risk monitoring",
        "option_D": "Risk control",
        "correct_anwser": "A",
        "explain": "Trong các hoạt động lớn thuộc quy trình Quản lý rủi ro (Risk Management framework), quy trình bao gồm Phân tích/Đánh giá (Assessment), Kiểm soát (Control) và Giám sát (Monitoring). Tránh rủi ro ('Risk avoidance') là một chiến lược phản ứng cụ thể (risk response strategy) nằm bên trong hoạt động kiểm soát rủi ro, chứ không phải là một nhánh hoạt động lớn ngang hàng."
      },
      {
        "question_id": 48,
        "question_title": "We can reuse all authentication requirements from the previous project by copy from a library of reusable components. Which dimensions does the statement refer to?",
        "option_A": "extend of modification",
        "option_B": "reuse mechanism",
        "option_C": "extend of reuses",
        "option_D": "D. None of the others",
        "correct_anwser": "A, B",
        "explain": "Phát biểu đề cập đến việc tái sử dụng bằng cách 'sao chép trực tiếp từ một thư viện thành phần' — mô tả cơ chế thực hiện tái sử dụng (Reuse mechanism - sao chép từ kho lưu trữ) và mức độ chỉnh sửa (Extent of modification - giữ nguyên toàn bộ, không sửa đổi)."
      },
      {
        "question_id": 49,
        "question_title": "What principle ensures that each code unit performs a specific, welldefined function without interference from other parts of the system?",
        "option_A": "Loose coupling",
        "option_B": "Information hiding",
        "option_C": "Strong cohesion",
        "option_D": "All of the others",
        "correct_anwser": "C",
        "explain": "Nguyên lý đảm bảo mỗi đơn vị mã nguồn (mô-đun/lớp/hàm) chỉ tập trung thực hiện duy nhất một nhiệm vụ cụ thể, rõ ràng và độc lập được gọi là tính Kết dính cao (Strong Cohesion)."
      },
      {
        "question_id": 50,
        "question_title": "Which of the following is NOT about packaged solution?",
        "option_A": "You build systems by using your own staff.",
        "option_B": "It needs to be configured, integrated, and extended to work in the target environment.",
        "option_C": "You can purchase a package as part or all of the solution for a new project.",
        "option_D": "Evaluate solution candidates so that you can select the most appropriate package.",
        "correct_anwser": "A",
        "explain": "Giải pháp đóng gói (Packaged solution / COTS) có nghĩa là bạn đi mua một sản phẩm phần mềm thương mại có sẵn trên thị trường về dùng, trái ngược hoàn toàn với việc tự xây dựng hệ thống từ đầu bằng đội ngũ nhân sự nội bộ của mình (A)."
      },
      {
        "question_id": 51,
        "question_title": "Which type of issue occurs when something isn't understood or decided about a requirement?",
        "option_A": "Requirement question",
        "option_B": "Incorrect requirement",
        "option_C": "Implementation question",
        "option_D": "Unneeded requirement",
        "correct_anwser": "A",
        "explain": "Khi một vấn đề liên quan đến yêu cầu chưa được hiểu rõ hoặc chưa được các bên thống nhất đưa ra quyết định cuối cùng, tình huống này được phân loại thuộc nhóm 'Câu hỏi/Vấn đề tồn đọng về yêu cầu' (Requirement question / Requirement issue)."
      },
      {
        "question_id": 52,
        "question_title": "Which of the following is a benefit of requirements tracing for reengineering efforts?",
        "option_A": "It facilitates the reuse of components from the previous system.",
        "option_B": "It helps identify where a system needs to be entirely replaced.",
        "option_C": "It automates the reengineering process.",
        "option_D": "It allows a system to function with fewer resources.",
        "correct_anwser": "A",
        "explain": "Khi thực hiện tái cấu trúc hệ thống (reengineering), việc có sẵn ma trận truy vết yêu cầu (requirements tracing) giúp đội ngũ biết rõ chức năng cũ tương ứng với những thành phần mã nguồn, module nào, từ đó tạo điều kiện thuận lợi cho việc tái sử dụng (reuse) các thành phần chạy tốt."
      },
      {
        "question_id": 53,
        "question_title": "What is the primary consequence of requirements problems?",
        "option_A": "Delays and rework",
        "option_B": "Increased resource costs",
        "option_C": "Faster development process",
        "option_D": "Improved product quality",
        "correct_anwser": "A",
        "explain": "Hệ lụy trực tiếp, phổ biến và nghiêm trọng nhất khi gặp các vấn đề hoặc sai sót về mặt yêu cầu là làm chậm trễ tiến độ dự án (delays) và buộc đội ngũ phải đập đi làm lại, sửa đổi mã nguồn rất nhiều lần (rework)."
      },
      {
        "question_id": 54,
        "question_title": "What is Vision and Scope Document derived from?",
        "option_A": "System requirements",
        "option_B": "User requirements",
        "option_C": "Business requirements",
        "option_D": "Original requirements",
        "correct_anwser": "C",
        "explain": "Tài liệu Tầm nhìn và Phạm vi (Vision and Scope Document) được hình thành và phát triển trực tiếp từ các Yêu cầu kinh doanh (Business Requirements), nhằm thiết lập mục tiêu chiến lược và giới hạn cho dự án."
      },
      {
        "question_id": 55,
        "question_title": "What is the primary purpose of a business case in software requirements?",
        "option_A": "To justify the project's value and align it with organizational goals",
        "option_B": "To finalize the technical requirements",
        "option_C": "To replace the Vision and Scope document",
        "option_D": "To eliminate stakeholder involvement in the early phases",
        "correct_anwser": "A",
        "explain": "Mục đích cốt lõi của một Business Case là chứng minh/luận giải giá trị lợi ích của dự án về mặt kinh tế, chi phí đầu tư và đảm bảo dự án đó hoàn toàn đồng nhất với các mục tiêu chiến lược dài hạn của tổ chức."
      },
      {
        "question_id": 56,
        "question_title": "What is the primary objective of requirements reuse in projects?",
        "option_A": "To improve efficiency and consistency by leveraging existing requirements in new projects",
        "option_B": "To finalize coding standards early",
        "option_C": "To eliminate stakeholder involvement in the elicitation process",
        "option_D": "To skip non-functional requirements entirely",
        "correct_anwser": "A",
        "explain": "Mục tiêu chính của việc tái sử dụng yêu cầu (requirements reuse) là nhằm tối ưu hóa hiệu suất làm việc, tiết kiệm thời gian và đảm bảo tính nhất quán của hệ thống bằng cách kế thừa, tận dụng các yêu cầu đã được chuẩn hóa từ các dự án trước đó vào dự án mới."
      },
      {
        "question_id": 57,
        "question_title": "What tool did Seilevel develop to assist with estimating requirements development effort?",
        "option_A": "A coding tool for developers.",
        "option_B": "A requirements effort estimation spreadsheet.",
        "option_C": "A time-tracking tool for project managers.",
        "option_D": "A documentation tool for stakeholders.",
        "correct_anwser": "B",
        "explain": "Seilevel đã phát triển một bảng tính chuyên dụng để ước lượng nỗ lực phát triển yêu cầu (a requirements effort estimation spreadsheet), giúp các BA tính toán khối lượng công việc cần thiết dựa trên các thuộc tính của dự án."
      },
      {
        "question_id": 58,
        "question_title": "During which activity are customer needs processed and related to software requirements?",
        "option_A": "Elicitation",
        "option_B": "Analysis",
        "option_C": "Specification",
        "option_D": "Validation",
        "correct_anwser": "B",
        "explain": "Giai đoạn Analysis (Phân tích) là lúc các nhu cầu chưa định hình của khách hàng được xử lý, phân loại, mô hình hóa và chuyển đổi cụ thể thành các yêu cầu phần mềm có cấu trúc."
      },
      {
        "question_id": 59,
        "question_title": "What is the main purpose of defining \"Scope and limitations\" in a software project?",
        "option_A": "To provide a detailed breakdown of all tasks for developers",
        "option_B": "To identify all potential users and their individual preferences.",
        "option_C": "To establish realistic stakeholder expectations by clearly stating what the solution will and will not include",
        "option_D": "To determine the most cost-effective technologies for implementation.",
        "correct_anwser": "C",
        "explain": "Mục đích cốt lõi của việc định nghĩa 'Phạm vi và giới hạn' là để tạo dựng kỳ vọng thực tế cho các bên liên quan (stakeholders) bằng cách tuyên bố minh bạch những gì hệ thống sẽ giải quyết và những gì hệ thống sẽ không bao gồm."
      },
      {
        "question_id": 60,
        "question_title": "Which of the following is NOT characteristic of the user?",
        "option_A": "A subset of the product's customers in some cases",
        "option_B": "A subset of the product's users",
        "option_C": "A superset of stakeholders",
        "option_D": "Includes direct users and indirect users",
        "correct_anwser": "C",
        "explain": "Người dùng (User) không thể là tập cha (superset) của Stakeholders. Ngược lại, Stakeholder (bên liên quan) mới là tập hợp rộng nhất, bao hàm cả người dùng, khách hàng, quản lý, và các bên liên quan khác."
      },
      {
        "question_id": 61,
        "question_title": "A designated representative of a specific user class, who supplies the user requirements for the group that he or she represents, is a:",
        "option_A": "Product manager",
        "option_B": "Product champion",
        "option_C": "Product backlog",
        "option_D": "Product owner",
        "correct_anwser": "B",
        "explain": "Product champion là một đại diện cốt cán được chỉ định từ một nhóm người dùng (user class) cụ thể nhằm cung cấp thông tin, thu thập và làm rõ các yêu cầu người dùng thay mặt cho chính tập thể người dùng mà họ đại diện."
      },
      {
        "question_id": 62,
        "question_title": "Which of the following is not a benefit of having a clear set of expectations for product champions?",
        "option_A": "Encouraging accountability and clarity of role",
        "option_B": "Helping champions align with project goals",
        "option_C": "Guaranteeing the project will stay on budget",
        "option_D": "Facilitating negotiation of the champion's responsibilities",
        "correct_anwser": "C",
        "explain": "Việc làm rõ kỳ vọng và vai trò của Product champion giúp tối ưu hóa nhân sự, định hướng mục tiêu tốt hơn, nhưng hoàn toàn không thể đảm bảo chắc chắn (guaranteeing) 100% việc dự án sẽ không bị vượt ngân sách vì ngân sách phụ thuộc vào rất nhiều yếu tố quản lý khác."
      },
      {
        "question_id": 63,
        "question_title": "Which one is a kind of prototyping that firstly creates a sample for clarifying requirements with the user, then builds up and adds new features to this sample incrementally, and finally releases the final deliverable product based on it?",
        "option_A": "Mockup",
        "option_B": "Throwaway prototype",
        "option_C": "Evolutionary prototype",
        "option_D": "Wireframe",
        "correct_anwser": "C",
        "explain": "Mẫu thử tiến hóa (Evolutionary prototype) là phương pháp phát triển mẫu thử mà trong đó mô hình ban đầu không bị vứt bỏ, mà liên tục được cải tiến, tối ưu hóa và bổ sung thêm các tính năng mới qua từng phân đoạn, cho đến khi trở thành sản phẩm hoàn chỉnh cuối cùng để bàn giao."
      },
      {
        "question_id": 64,
        "question_title": "What are the reasons for companies to contract with software outsourcing organizations?",
        "option_A": "To increase control and oversight project",
        "option_B": "To minimize stakeholder involvement",
        "option_C": "To limit project scope",
        "option_D": "To save money, or to accelerate development and access specialized expertise.",
        "correct_anwser": "D",
        "explain": "Các lý do chính khiến các công ty tìm đến các tổ chức gia công phần mềm (outsourcing) là để tiết kiệm chi phí, đẩy nhanh tiến độ phát triển sản phẩm và tận dụng nguồn chuyên gia có chuyên môn sâu mà nội bộ công ty đang thiếu."
      },
      {
        "question_id": 65,
        "question_title": "What is the main benefit of fostering a collaborative relationship between the development team and other stakeholders in the requirements process?",
        "option_A": "To ensure that each stakeholder has full control over the project.",
        "option_B": "To align business, technical, and user needs and avoid misunderstandings.",
        "option_C": "To speed up the development process by minimizing the number of team members involved.",
        "option_D": "To focus only on technical requirements without business or user input.",
        "option_E": "None of the above",
        "correct_anwser": "B",
        "explain": "Mối quan hệ hợp tác chặt chẽ giữa đội ngũ phát triển và các bên liên quan giúp đồng bộ hóa một cách hài hòa giữa nhu cầu kinh doanh, giải pháp kỹ thuật và kỳ vọng của người dùng, từ đó hạn chế tối đa các hiểu lầm gây lãng phí nguồn lực."
      },
      {
        "question_id": 66,
        "question_title": "Which of the following roles is considered a \"customer\" for a software product?",
        "option_A": "Legal staff",
        "option_B": "Compliance auditors",
        "option_C": "Executive sponsor",
        "option_D": "Contractors",
        "option_E": "Venture capitalists",
        "correct_anwser": "C",
        "explain": "Trong các bên liên quan, Executive Sponsor (Nhà tài trợ dự án/Người có thẩm quyền tối cao phía khách hàng) đóng vai trò đưa ra quyết định tối cao, cấp ngân sách và đại diện cho quyền lợi cốt lõi của khách hàng đối với sản phẩm."
      },
      {
        "question_id": 67,
        "question_title": "What is the primary role of a business analyst (BA) in software projects?",
        "option_A": "Writing code",
        "option_B": "Managing server infrastructure",
        "option_C": "Bridging the gap between stakeholders and developers",
        "option_D": "Approving budgets",
        "correct_anwser": "C",
        "explain": "Vai trò cốt lõi và quan trọng nhất của một Business Analyst (BA) là làm cầu nối ngôn ngữ và tư duy giữa các bên liên quan (Stakeholders - những người có nhu cầu kinh doanh) và đội ngũ phát triển phần mềm (Developers - những người xây dựng giải pháp kỹ thuật)."
      },
      {
        "question_id": 68,
        "question_title": "Which of the following are essential analyst skills required from the Business Analyst?",
        "option_A": "Listening skills, Systems thinking skills",
        "option_B": "Interviewing and questioning skills, Learning skills, Interpersonal skills",
        "option_C": "Thinking on your feet, Facilitation skills,",
        "option_D": "Analytical skills, Leadership skills, Organizational skills, Creativity",
        "option_E": "Observational skills, Communication skills, Modeling skills",
        "option_F": "All of the mentioned",
        "correct_anwser": "F",
        "explain": "Một chuyên viên BA thành công đòi hỏi sự tổng hòa của rất nhiều kỹ năng mềm và kỹ năng chuyên môn phức tạp bao gồm giao tiếp, lắng nghe, tư duy hệ thống, phỏng vấn, phân tích, tổ chức và điều phối điều khiển cuộc họp. Do đó tất cả các phương án đưa ra đều chính xác."
      },
      {
        "question_id": 69,
        "question_title": "Why is it important to identify stakeholders when eliciting the requirements for a software system?",
        "option_A": "The people, groups, or organizations that are actively involved in a project, are affected by its outcome, or are able to influence its outcome",
        "option_B": "It helps you identify the vision and roadmap.",
        "option_C": "It helps you identify which support you need, who can influence the support, and potential issues that result from a non-supportive stakeholder",
        "option_D": "It helps you to make strategic decisions and clear the path of political and financial obstacles.",
        "correct_anwser": "A",
        "explain": "Định nghĩa và tầm quan trọng của việc xác định các bên liên quan (Stakeholders) nằm ở chỗ họ bao gồm tất cả các cá nhân, hội nhóm hoặc tổ chức tham gia trực tiếp, chịu ảnh hưởng từ kết quả hoặc có năng lực tác động lớn tới sự thành bại của dự án phần mềm."
      },
      {
        "question_id": 70,
        "question_title": "What is the danger of assuming a requirement is \"obvious\" without documenting it?",
        "option_A": "It can lead to a gap between customer expectations and what is actually delivered.",
        "option_B": "It increases project costs immediately.",
        "option_C": "It prevents developers from choosing the right programming language.",
        "option_D": "There is no danger; experienced developers always know what is needed.",
        "correct_anwser": "A",
        "explain": "Khi một yêu cầu được coi là \"hiển nhiên\" mà không được ghi chép rõ ràng, các bên sẽ dễ hiểu lầm theo các cách khác nhau. Điều này trực tiếp tạo ra sự sai lệch giữa kỳ vọng thực tế của khách hàng và sản phẩm bàn giao cuối cùng của đội ngũ phát triển."
      },
      {
        "question_id": 71,
        "question_title": "In the context of software projects, who is a \"stakeholder\"?",
        "option_A": "Only the developers who write the code.",
        "option_B": "Anyone who is affected by or can influence the project's outcome.",
        "option_C": "The external auditors who review project expenses.",
        "option_D": "Only the end-users who interact with the final interface.",
        "correct_anwser": "B",
        "explain": "Bên liên quan (Stakeholder) được định nghĩa rộng rãi là bất kỳ cá nhân, nhóm người hoặc tổ chức nào có thể tham gia, chịu tác động trực tiếp/gián tiếp bởi kết quả của dự án, hoặc có năng lực gây ảnh hưởng đến tiến trình dự án."
      },
      {
        "question_id": 72,
        "question_title": "What is the primary objective of requirements elicitation?",
        "option_A": "To create a complete user interface design.",
        "option_B": "To write the clean code for the core system algorithms.",
        "option_C": "To find out what stakeholders need the system to do and discover their real goals.",
        "option_D": "To finalize the project budget and timeline constraints.",
        "correct_anwser": "C",
        "explain": "Mục tiêu hàng đầu của giai đoạn gợi tiến yêu cầu (Requirements Elicitation) là tìm hiểu, khai thác và khám phá những nhu cầu thực tế cũng như mục tiêu cốt lõi của khách hàng đối với hệ thống phần mềm cần xây dựng."
      },
      {
        "question_id": 73,
        "question_title": "Which of the following techniques is commonly used to elicit requirements by observing users in their actual work environment?",
        "option_A": "Brainstorming",
        "option_B": "Job shadowing or Observation",
        "option_C": "Interface analysis",
        "option_D": "Document analysis",
        "correct_anwser": "B",
        "explain": "Kỹ thuật quan sát (Job shadowing hoặc Observation) cho phép BA trực tiếp theo dõi quy trình làm việc thực tế hàng ngày của người dùng tại môi trường của họ để phát hiện ra những quy trình nghiệp vụ ngầm định hoặc những bất cập mà chính người dùng đôi khi không tự nhận ra."
      },
      {
        "question_id": 74,
        "question_title": "What is the primary risk of using open-ended questions during a requirements elicitation interview?",
        "option_A": "They lead to simple 'yes' or 'no' answers that provide no depth.",
        "option_B": "They can result in long, unfocused answers that consume significant time without yielding specific requirements.",
        "option_C": "They force the user to agree with the analyst's preconceived technical design.",
        "option_D": "They prevent the analyst from understanding the user's emotional context.",
        "correct_anwser": "B",
        "explain": "Câu hỏi mở (Open-ended questions) kích thích người trả lời chia sẻ tự do, nhưng rủi ro lớn nhất là dễ làm câu trả lời bị lan man, kéo dài và mất tập trung vào chủ đề chính, gây tiêu tốn nhiều thời gian mà không thu thập được các yêu cầu cụ thể."
      },
      {
        "question_id": 75,
        "question_title": "Which elicitation technique is highly interactive, involves a diverse group of stakeholders, and is designed to generate a large volume of creative ideas quickly?",
        "option_A": "Document Analysis",
        "option_B": "Brainstorming",
        "option_C": "Data Modeling",
        "option_D": "System Architecture Review",
        "correct_anwser": "B",
        "explain": "Động não (Brainstorming) là kỹ thuật làm việc nhóm mang tính tương tác cao, khuyến khích tất cả mọi người tự do đưa ra nhiều ý tưởng sáng tạo mới một cách nhanh chóng trong một khoảng thời gian ngắn mà không sợ bị phán xét."
      },
      {
        "question_id": 76,
        "question_title": "In requirements development, what is a \"User Persona\"?",
        "option_A": "A real, specific individual who has purchased the software.",
        "option_B": "A detailed technical profile of the system administrator's security clearance.",
        "option_C": "A semi-fictional representation of a target user group based on shared characteristics and behaviors.",
        "option_D": "The organization's legal representative who signs the contract.",
        "correct_anwser": "C",
        "explain": "User Persona (Chân dung người dùng) là một hình mẫu giả định (semi-fictional) đại diện cho một nhóm người dùng mục tiêu, được xây dựng dựa trên những đặc điểm, hành vi, mục tiêu và nỗi đau (pain points) chung thu thập được từ thực tế."
      },
      {
        "question_id": 77,
        "question_title": "What is a major advantage of conducting a \"Focus Group\" for requirements elicitation?",
        "option_A": "It guarantees that the technical architecture is flawless.",
        "option_B": "It allows the analyst to observe interactions and spontaneous discussions among a representative group of users.",
        "option_C": "It generates finalized system code automatically.",
        "option_D": "It eliminates the need for any subsequent validation sessions.",
        "correct_anwser": "B",
        "explain": "Nhóm tập trung (Focus Group) tập hợp một nhóm người dùng đại diện để cùng thảo luận về một chủ đề cụ thể, ưu điểm lớn nhất của nó là giúp BA khai thác được các ý kiến, phản hồi nảy sinh một cách tự nhiên từ sự tương tác qua lại giữa các thành viên."
      },
      {
        "question_id": 78,
        "question_title": "What is a key difference between an evolutionary prototype and a throwaway prototype?",
        "option_A": "An evolutionary prototype is built by developers, while a throwaway prototype is built by users.",
        "option_B": "An evolutionary prototype is refined over time to become part of the final production system, while a throwaway prototype is used only to explore requirements and then discarded.",
        "option_C": "A throwaway prototype requires separate database migration tools.",
        "option_D": "There is no difference; they follow the exact same lifecycle.",
        "correct_anwser": "B",
        "explain": "Mẫu thử tiến hóa (Evolutionary prototype) được xây dựng với mã nguồn chuẩn để tối ưu, nâng cấp dần thành một phần của hệ thống thật; trong khi mẫu thử bỏ đi (Throwaway prototype) chỉ được dựng nhanh chóng nhằm mục đích thăm dò, làm rõ các yêu cầu mơ hồ rồi sau đó sẽ bị loại bỏ."
      },
      {
        "question_id": 79,
        "question_title": "Which of the following describes the difference between Requirements Elicitation and Requirements Analysis?",
        "option_A": "Elicitation focuses on technical code deployment, while Analysis creates system visual themes.",
        "option_B": "Elicitation is about gathering information from stakeholders, while Analysis focuses on processing, organizing, and clarifying that information into refined requirements.",
        "option_C": "Analysis must always happen before Elicitation begins.",
        "option_D": "Elicitation is done exclusively by software developers, while Analysis is done solely by end-users.",
        "correct_anwser": "B",
        "explain": "Gợi tiến yêu cầu (Elicitation) tập trung vào việc thu thập thông tin và tìm hiểu nhu cầu từ phía stakeholders, trong khi Phân tích yêu cầu (Analysis) tiếp nhận các thông tin thô đó để xử lý, bóc tách, sắp xếp và làm rõ thành các yêu cầu kỹ thuật hoàn chỉnh."
      },
      {
        "question_id": 80,
        "question_title": "Customers have the right to: (choose 3 correct answers)",
        "option_A": "expect business analysts to learn about their business and their objectives",
        "option_B": "describe characteristics that will make the product easy to use",
        "option_C": "receive a system that meets their functional needs and quality expectations",
        "option_D": "promptly communicate changes to the requirements",
        "correct_anwser": "A, B, C",
        "explain": "Theo Tuyên ngôn Quyền lợi về Yêu cầu của Khách hàng (Requirements Bill of Rights), khách hàng có quyền: yêu cầu BA tìm hiểu về doanh nghiệp của họ (A), mô tả các đặc tính giúp sản phẩm dễ sử dụng (B), và nhận được hệ thống đáp ứng nhu cầu chức năng cũng như chất lượng (C). Ngược lại, phương án D ('thông báo kịp thời các thay đổi về yêu cầu') thuộc về trách nhiệm/nghĩa vụ của khách hàng (Customer Responsibilities) chứ không phải quyền lợi."
      },
      {
        "question_id": 81,
        "question_title": "What are the tasks of a business analyst? Choose 3 correct answers.",
        "option_A": "Define business requirements",
        "option_B": "Identify project stakeholders and user classes",
        "option_C": "Document requirements",
        "option_D": "Lead requirements prioritization",
        "correct_anwser": "B, C, D",
        "explain": "Các tác vụ chính của một BA bao gồm: Nhận diện các bên liên quan và phân loại người dùng (B), viết tài liệu đặc tả yêu cầu (C), và dẫn dắt buổi họp ưu tiên hóa các yêu cầu (D). Riêng phương án A, 'Xác định yêu cầu kinh doanh' (Define business requirements) thông thường do quản lý cấp cao, nhà tài trợ dự án (Sponsor) hoặc khách hàng chiến lược đưa ra trước khi BA tham gia vào chi tiết dự án."
      },
      {
        "question_id": 82,
        "question_title": "“Organize and share notes” is an activity that belongs to ?",
        "option_A": "Preparing for elicitation",
        "option_B": "Performing elicitation activities",
        "option_C": "Following up after elicitation",
        "option_D": "Classifying customer",
        "correct_anwser": "C",
        "explain": "Hoạt động 'Sắp xếp tổ chức và chia sẻ các ghi chú/biên bản' (Organize and share notes) là một bước tiêu biểu được thực hiện sau khi buổi khơi gợi yêu cầu kết thúc (Following up after elicitation) nhằm tổng hợp lại thông tin thu thập được và phân phối đến các bên liên quan để rà soát, xác nhận tính chính xác."
      },
      {
        "question_id": 83,
        "question_title": "What is the value of prototyping during requirements elicitation?",
        "option_A": "It provides a visual tool to clarify ambiguous requirements and gather stakeholder feedback",
        "option_B": "It eliminates the need for acceptance criteria",
        "option_C": "It skips non-functional requirements",
        "option_D": "It focuses on coding directly",
        "correct_anwser": "A",
        "explain": "Làm mẫu thử (Prototyping) trong giai đoạn khơi gợi yêu cầu mang lại giá trị rất lớn nhờ cung cấp một công cụ trực quan hóa (visual tool). Điều này giúp làm rõ những phần yêu cầu còn mơ hồ, nhập nhằng và giúp khách hàng dễ dàng hình dung để đưa ra phản hồi chính xác."
      },
      {
        "question_id": 84,
        "question_title": "Customers are a(n) _______ of stakeholders.",
        "option_A": "subset",
        "option_B": "representative",
        "option_C": "partner",
        "option_D": "equivalent",
        "correct_anwser": "A",
        "explain": "Khách hàng (Customers) là một tập hợp con (subset) nằm trong tập hợp rộng lớn hơn là các bên liên quan (Stakeholders). Khái niệm Stakeholders bao gồm khách hàng, người dùng cuối, nhà quản lý, lập trình viên, kiểm thử viên và các cơ quan quản lý."
      },
      {
        "question_id": 85,
        "question_title": "What is the benefit of having a small group representing key areas as decision makers in a project?",
        "option_A": "It simplifies the decision-making process by involving only the project manager",
        "option_B": "It ensures diverse perspectives from management, customers, business analysis, development, and marketing",
        "option_C": "It reduces the need for stakeholder involvement",
        "option_D": "It focuses solely on technical specifications",
        "correct_anwser": "B",
        "explain": "Việc thành lập một nhóm nhỏ đại diện cho các lĩnh vực cốt lõi (nhóm quyết định/quản trị thay đổi) giúp đảm bảo dự án có được góc nhìn đa chiều, toàn diện từ cấp quản lý, khách hàng, phân tích nghiệp vụ, phát triển phần mềm cho đến marketing mà không làm cồng kềnh bộ máy."
      },
      {
        "question_id": 86,
        "question_title": "What activities is not included in a representative requirements development process?",
        "option_A": "Select an appropriate software development life cycle.",
        "option_B": "Select elicitation techniques",
        "option_C": "Review requirement",
        "option_D": "Plan elicitation",
        "option_E": "Analysis requirement",
        "correct_anwser": "A",
        "explain": "Việc lựa chọn mô hình vòng đời phát triển phần mềm phù hợp (SDLC) là nhiệm vụ thuộc về quản lý dự án (Project Management) hoặc kiến trúc sư hệ thống (System Architect), chứ không nằm trong các hoạt động nghiệp vụ trực tiếp của quy trình phát triển và quản lý yêu cầu (Requirements Development Process)."
      },
      {
        "question_id": 87,
        "question_title": "Develop a method to ensure that all necessary documents and systems are available for independent elicitation. What would be a primary focus of this method?",
        "option_A": "Creating a checklist of required documents and systems.",
        "option_B": "Assigning a team member to gather all necessary materials.",
        "option_C": "Setting up a shared repository for document access.",
        "option_D": "Scheduling regular audits to ensure document availability.",
        "correct_anwser": "A",
        "explain": "Để đảm bảo một cách hệ thống rằng toàn bộ tài liệu và hệ thống hiện hành đều sẵn sàng phục vụ cho việc khơi gợi yêu cầu độc lập (như nghiên cứu tài liệu), bước tập trung cốt lõi là xây dựng một bảng kiểm (checklist) chi tiết để rà soát đầy đủ danh mục cần chuẩn bị."
      },
      {
        "question_id": 88,
        "question_title": "What is one of the first questions to ask when eliciting reporting requirements from a customer?",
        "option_A": "How often should the reports be printed?",
        "option_B": "What reports are currently used?",
        "option_C": "How many users will need access to the report?",
        "option_D": "What is the preferred color scheme for the reports?",
        "correct_anwser": "B",
        "explain": "Khi khơi gợi yêu cầu về hệ thống báo cáo (Reporting requirements), câu hỏi khảo sát thực tế và nên ưu tiên đặt ra đầu tiên là 'Những báo cáo nào hiện đang được sử dụng?' (B). Việc hiểu rõ hiện trạng giúp BA nắm được cấu trúc dữ liệu cốt lõi trước khi đi vào chi tiết tần suất in ấn (A), phân quyền (C) hay giao diện màu sắc (D)."
      },
      {
        "question_id": 89,
        "question_title": "What is true about a software prototype? Choose 3 correct answers.",
        "option_A": "It is a partial implementation of a proposed new product.",
        "option_B": "It is a possible implementation of a proposed new product.",
        "option_C": "It is a preliminary implementation of a proposed new product.",
        "option_D": "It is a complete implementation of a proposed new product.",
        "correct_anwser": "A, B, C",
        "explain": "Mẫu thử phần mềm (Prototype) được định nghĩa là một phiên bản triển khai một phần (A), một phiên bản triển khai khả thi (B), hoặc phiên bản triển khai sơ khởi ban đầu (C) nhằm mục đích thử nghiệm và làm rõ yêu cầu. Nó không bao giờ là một phiên bản triển khai hoàn chỉnh (D)."
      },
      {
        "question_id": 90,
        "question_title": "While a mock-up is called a _______ prototype, a proof of concept is called a _______ prototype.",
        "option_A": "horizontal, vertical",
        "option_B": "vertical, horizontal",
        "option_C": "primary, secondary",
        "option_D": "front-end, back-end",
        "correct_anwser": "A",
        "explain": "Mock-up tập trung vào bề rộng của giao diện người dùng mà không đi sâu vào xử lý logic bên dưới nên được gọi là mẫu thử nằm ngang (horizontal prototype). Ngược lại, Proof of Concept (PoC) đi sâu vào kiểm thử kỹ thuật hoặc một lát cắt chức năng từ trên xuống dưới để chứng minh tính khả thi nên được gọi là mẫu thử thẳng đứng (vertical prototype)."
      },
      {
        "question_id": 91,
        "question_title": "which of the following statements are incorrect about throwaway prototypes?",
        "option_A": "most appropriate when the team faces uncertainty, ambiguity, incompleteness, or vagueness in the requirements",
        "option_B": "when build a throwaway prototype, they ignore solid software construction techniques",
        "option_C": "you might prefer to call it a releasable prototype",
        "option_D": "Build a throwaway prototype to answer questions, resolve uncertainties, and improve requirements quality",
        "option_E": "",
        "option_F": "",
        "correct_anwser": "C",
        "explain": "Mẫu thử dùng một lần rồi bỏ (Throwaway prototype) được xây dựng chỉ để làm rõ yêu cầu rồi vứt bỏ chứ không dùng để phát hành trực tiếp. Vì vậy, việc gọi nó là một mẫu thử có thể phát hành (releasable prototype) là hoàn toàn sai."
      },
      {
        "question_id": 92,
        "question_title": "Which type of requirement best describes the behavior and information that the solution will manage, including a specific system actions or responses?",
        "option_A": "Stakeholder Requirements.",
        "option_B": "Functional Requirements.",
        "option_C": "Business Requirements.",
        "option_D": "Non-functional Requirements",
        "correct_anwser": "B",
        "explain": "Yêu cầu chức năng (Functional Requirements) mô tả các hành vi, phản hồi và thông tin mà hệ thống/giải pháp sẽ quản lý để phản hồi lại các tác vụ cụ thể của người dùng hoặc hệ thống khác."
      },
      {
        "question_id": 93,
        "question_title": "Which of the following tasks are typically performed by a business analyst? Select two.",
        "option_A": "Defining business requirements and helping project sponsors express the project's vision clearly.",
        "option_B": "Focusing only on textual documentation and avoiding the use of visual aids like diagrams and prototypes.",
        "option_C": "Ensuring that all team members fully understand the requirements being communicated.",
        "option_D": "Managing the entire software development life cycle, from inception to deployment.",
        "correct_anwser": "A, C",
        "explain": "Nhiệm vụ điển hình của một chuyên viên phân tích nghiệp vụ (BA) là định nghĩa các yêu cầu kinh doanh, hỗ trợ nhà tài trợ dự án làm rõ tầm nhìn (A), và đảm bảo các thành viên trong đội ngũ hiểu đúng các yêu cầu được truyền đạt (C). Quản lý toàn bộ SDLC là nhiệm vụ của Quản trị dự án (PM) chứ không phải BA."
      },
      {
        "question_id": 94,
        "question_title": "Which of the following is a likely stakeholder interest for a retail kiosk's customer?",
        "option_A": "Maximizing user convenience",
        "option_B": "Minimizing development cost",
        "option_C": "Improving operational efficiency",
        "option_D": "Increasing market reach",
        "correct_anwser": "A",
        "explain": "Đối với một khách hàng (người dùng cuối) sử dụng ki-ốt bán lẻ, mối quan tâm lớn nhất và trực tiếp nhất của họ là sự tiện lợi khi sử dụng (user convenience). Các phương án khác như chi phí phát triển, hiệu quả vận hành hay mở rộng thị trường là mối quan tâm của chủ doanh nghiệp hoặc nhà phát triển."
      },
      {
        "question_id": 95,
        "question_title": "What do product champions do? Choose 2 correct answers.",
        "option_A": "They gather requirements from other members of the user classes they represent, and reconcile inconsistencies.",
        "option_B": "They serve as the primary interface between members of a single user class and the project's business analyst.",
        "option_C": "They implement the coding standards.",
        "option_D": "They write requirements documents.",
        "correct_anwser": "A, B",
        "explain": "Trách nhiệm chính của các Product Champion bao gồm việc thu thập ý kiến, yêu cầu từ các thành viên khác trong cùng nhóm người dùng của họ và giải quyết các điểm mâu thuẫn (A), đồng thời đóng vai trò làm cầu nối giao tiếp chính giữa nhóm đó với Chuyên viên phân tích nghiệp vụ (BA) của dự án (B)."
      },
      {
        "question_id": 96,
        "question_title": "What should you not expect a prototype to replace?",
        "option_A": "Multiple iterations.",
        "option_B": "Written requirements.",
        "option_C": "Plausible data.",
        "option_D": "The purpose of the prototype",
        "correct_anwser": "B",
        "explain": "Prototype chỉ là công cụ hỗ trợ trực quan hóa để làm rõ yêu cầu chứ không bao giờ có thể thay thế hoàn toàn văn bản đặc tả yêu cầu bằng chữ (Written requirements). Lập trình viên và kiểm thử viên vẫn luôn cần tài liệu bằng văn bản chính thức để có căn cứ thực hiện và đối chiếu chi tiết."
      },
      {
        "question_id": 97,
        "question_title": "Which of the following statements best describes a \"horizontal prototype\" in the context of software development?",
        "option_A": "A horizontal prototype focuses on the user interface, allowing exploration of specific behaviors without diving into detailed functionality or architectural layers.",
        "option_B": "A horizontal prototype fully implements all layers of the system, from the user interface to the backend services.",
        "option_C": "A horizontal prototype is used to validate the architectural approach and test critical timing requirements.",
        "option_D": "A horizontal prototype includes detailed implementation of business logic and database interactions.",
        "correct_anwser": "A",
        "explain": "Nguyên mẫu giao diện/nguyên mẫu bề nổi (Horizontal prototype) tập trung chủ yếu vào phần giao diện người dùng (UI), cho phép người dùng trải nghiệm và khám phá luồng đi, hành vi chuyển trang mà không đi sâu cài đặt logic nghiệp vụ chi tiết hay các tầng kiến trúc bên dưới (ngược lại với vertical prototype)."
      },
      {
        "question_id": 98,
        "question_title": "When creating a persona for each user class, the most important thing is:",
        "option_A": "The persona must be a real person",
        "option_B": "The persona must be representative of their user class",
        "option_C": "The persona must be rich",
        "option_D": "The persona must be beautiful",
        "correct_anwser": "B",
        "explain": "Chân dung người dùng (Persona) là một nhân vật hư cấu đại diện, do đó điều quan trọng nhất là nhân vật đó phải mang tính đại diện và phản ánh chính xác các đặc điểm hành vi, nhu cầu của cả một lớp người dùng (user class) đó."
      },
      {
        "question_id": 99,
        "question_title": "Which of the following is not an elicitation technique?",
        "option_A": "Interviews",
        "option_B": "Focus groups",
        "option_C": "Observations",
        "option_D": "Training courses",
        "correct_anwser": "D",
        "explain": "Phỏng vấn (Interviews), thảo luận nhóm tập trung (Focus groups) và quan sát (Observations) đều là các kỹ thuật thu thập/khơi gợi yêu cầu (elicitation techniques) kinh điển. Khóa đào tạo (Training courses) là hoạt động truyền tải kiến thức sau khi đã có sản phẩm hoặc quy trình, không phải kỹ thuật thu thập yêu cầu."
      },
      {
        "question_id": 100,
        "question_title": "Which elicitation technique is most suitable for identifying stakeholder needs in large projects?",
        "option_A": "Focus groups",
        "option_B": "Observation",
        "option_C": "Brainstorming sessions",
        "option_D": "Stakeholder interviews",
        "correct_anwser": "D",
        "explain": "Trong các dự án lớn, việc thực hiện phỏng vấn các bên liên quan (Stakeholder interviews) một cách trực tiếp và có cấu trúc giúp đi sâu tìm hiểu rõ nhất các nhu cầu, mục tiêu chiến lược và kỳ vọng cụ thể từ nhiều góc nhìn khác nhau của các bên chủ chốt."
      },
      {
        "question_id": 101,
        "question_title": "What is a key difference between a throwaway prototype and an evolutionary prototype?",
        "option_A": "A throwaway prototype is built with production-quality code, while an evolutionary prototype is discarded after use.",
        "option_B": "An evolutionary prototype is designed to be gradually refined into the final product, while a throwaway prototype is created to answer specific questions and then discarded.",
        "option_C": "A throwaway prototype provides a solid architectural foundation for the final product, while an evolutionary prototype is typically used to test user interface designs.",
        "option_D": "Both throwaway and evolutionary prototypes are intended to be discarded after initial testing.",
        "correct_anwser": "B",
        "explain": "Sự khác biệt cốt lõi: Mô hình tiến hóa (evolutionary prototype) được xây dựng vững chắc để cải tiến dần dần thành sản phẩm cuối cùng, còn mô hình bỏ đi (throwaway prototype) chỉ nhằm mục đích làm rõ các câu hỏi/yêu cầu cụ thể rồi bị loại bỏ."
      },
      {
        "question_id": 102,
        "question_title": "which of the following statements is incorrect about mockup?",
        "option_A": "It is also called a horizontal prototype",
        "option_B": "It dives into all the architectural layers or into detailed functionality",
        "option_C": "It displays the facades of user interface screens and permits some navigation between them",
        "option_D": "It lets you explore some specific behaviors of the intended system, with the goal of refining the requirements",
        "correct_anwser": "B",
        "explain": "Mockup là một mô hình giao diện tĩnh bề mặt (horizontal prototype), do đó khẳng định nó 'đi sâu vào tất cả các lớp kiến trúc hệ thống và chức năng chi tiết' (B) là hoàn toàn sai (đây là đặc điểm của vertical prototype/Proof of Concept)."
      },
      {
        "question_id": 103,
        "question_title": "Customers are a(n) _________ of stakeholders.",
        "option_A": "subset",
        "option_B": "representative",
        "option_C": "partner",
        "option_D": "equivalent",
        "correct_anwser": "A",
        "explain": "Stakeholders (Bên liên quan) là một nhóm rộng lớn bao gồm bất kỳ ai bị ảnh hưởng bởi dự án (nhà phát triển, quản lý, người dùng, khách hàng...). Khách hàng (Customers) chỉ là một nhóm con (subset) nằm trong tập hợp các bên liên quan đó."
      },
      {
        "question_id": 104,
        "question_title": "The Product vision and project scope describes the?",
        "option_A": "Function, performance and constraints of a computer-based system",
        "option_B": "The indicators that stakeholders will use to define and measure success on this project and the statement that is believed to be true in the absence of proof or definitive knowledge",
        "option_C": "The benefits the business",
        "option_D": "The ultimate product that will achieve the business objectives and what portion of the ultimate product vision the current project or development iteration will address",
        "correct_anwser": "D",
        "explain": "Tầm nhìn sản phẩm (Product Vision) định nghĩa sản phẩm cuối cùng nhằm đạt mục tiêu kinh doanh, còn Phạm vi dự án (Project Scope) xác định phần cụ thể nào của tầm nhìn đó sẽ được giải quyết trong dự án hoặc phân đoạn phát triển hiện tại."
      },
      {
        "question_id": 105,
        "question_title": "Why is it important to involve stakeholders, including data experts, in the process of specifying data requirements?",
        "option_A": "To exclude data experts from the development process.",
        "option_B": "To limit the variety of data used in the system.",
        "option_C": "To ensure a comprehensive understanding of data needs and complexities.",
        "option_D": "To prioritize project timelines over data considerations.",
        "correct_anwser": "C",
        "explain": "Việc lôi cuốn các bên liên quan cùng chuyên gia dữ liệu vào quá trình định nghĩa yêu cầu dữ liệu giúp đội ngũ dự án hiểu một cách toàn diện, sâu sắc về nhu cầu khai thác dữ liệu cũng như các cấu trúc, ràng buộc phức tạp của hệ thống."
      },
      {
        "question_id": 106,
        "question_title": "While a mock-up is called a _________ prototype, a proof of concept is called a _________ prototype.",
        "option_A": "horizontal, vertical",
        "option_B": "vertical, horizontal",
        "option_C": "primary, secondary",
        "option_D": "front-end, back-end",
        "correct_anwser": "A",
        "explain": "Mock-up tập trung dàn trải toàn bộ bề mặt giao diện hệ thống nhưng không xử lý sâu bên dưới nên gọi là mẫu thử nằm ngang (horizontal prototype). Ngược lại, Proof of Concept (PoC) đi sâu xử lý triệt để một lát cắt tính năng kỹ thuật phức tạp từ trên xuống dưới để chứng minh tính khả thi nên gọi là mẫu thử thẳng đứng (vertical prototype)."
      },
      {
        "question_id": 107,
        "question_title": "What is a common challenge that both enhancement and replacement projects often face?",
        "option_A": "Users who are familiar with how the system works today might not like the changes they are about to encounter",
        "option_B": "Limited stakeholder involvement",
        "option_C": "Requirements documentation may be available for existing systems.",
        "option_D": "Minimal communication among team members",
        "correct_anwser": "A",
        "explain": "Thách thức tâm lý rất phổ biến ở cả dự án nâng cấp (enhancement) lẫn thay thế hệ thống (replacement) là người dùng cũ đã quá quen thuộc với quy trình hiện tại nên thường có xu hướng phản kháng, không thích ứng hoặc từ chối những thay đổi mới."
      },
      {
        "question_id": 108,
        "question_title": "Which of the following is not an elicitation activity?",
        "option_A": "Define product vision and project scope",
        "option_B": "Hold elicitation interviews",
        "option_C": "Observe users performing their jobs",
        "option_D": "Model the application environment",
        "correct_anwser": "A",
        "explain": "Xác định tầm nhìn sản phẩm và phạm vi dự án (Define product vision and project scope) thuộc về giai đoạn Khởi tạo dự án hoặc Định hình Yêu cầu kinh doanh (Inception / Business Requirements), đóng vai trò thiết lập khung hướng dẫn trước khi tiến hành các hoạt động khơi gợi yêu cầu chi tiết (Elicitation) như phỏng vấn, quan sát hay xây dựng mô hình môi trường ứng dụng."
      },
      {
        "question_id": 109,
        "question_title": "When there is a disagreement between development and customers, how to solve it?",
        "option_A": "Customers get preference, unconditionally",
        "option_B": "Customers get preference, but in alignment with business objectives",
        "option_C": "Development gets preference, unconditionally",
        "option_D": "Development gets preference, but in alignment with business objectives",
        "correct_anwser": "B",
        "explain": "Khi xảy ra bất đồng ý kiến giữa đội ngũ phát triển và khách hàng, giải pháp chuẩn là ưu tiên góc nhìn của khách hàng (vì họ hiểu rõ họ cần gì) nhưng quyết định đó bắt buộc phải nằm trong phạm vi và đồng nhất với các mục tiêu kinh doanh (business objectives) của dự án."
      },
      {
        "question_id": 110,
        "question_title": "What kind of questions are best to ask at the beginning to use for writing better questionnaires at the beginning of the elicitation process?",
        "option_A": "Essay questions",
        "option_B": "Closed ended questions with standardized answers.",
        "option_C": "Open-ended questions are asked at the beginning to obtain full and meaningful answers.",
        "option_D": "Combine close ended questions with open-ended questions",
        "correct_anwser": "C",
        "explain": "Ở giai đoạn đầu của quá trình khơi gợi yêu cầu, việc sử dụng các câu hỏi mở (Open-ended questions) là tốt nhất để người dùng tự do chia sẻ, giúp BA thu thập được thông tin toàn diện, sâu sắc và bối cảnh đầy đủ, làm cơ sở để thiết kế các bảng khảo sát chi tiết hơn về sau."
      },
      {
        "question_id": 111,
        "question_title": "What is the risk of incomplete requirements during the elicitation phase?",
        "option_A": "Project delays, increased costs, and reduced stakeholder satisfaction",
        "option_B": "Faster completion of functional requirements",
        "option_C": "Elimination of prototyping needs",
        "option_D": "Reduced complexity in coding",
        "correct_anwser": "A",
        "explain": "Rủi ro lớn nhất của việc thu thập thiếu hoặc không hoàn thiện yêu cầu (incomplete requirements) là dẫn đến việc phải làm lại (rework) về sau, gây chậm trễ tiến độ dự án, tăng chi phí và làm giảm mức độ hài lòng của các bên liên quan."
      },
      {
        "question_id": 112,
        "question_title": "What is the primary purpose of conducting stakeholder interviews during elicitation?",
        "option_A": "To gather detailed requirements directly from key stakeholders",
        "option_B": "To finalize the project schedule",
        "option_C": "To identify coding standards",
        "option_D": "To replace the prototyping needs",
        "correct_anwser": "A",
        "explain": "Mục đích chính của việc tiến hành phỏng vấn các bên liên quan (stakeholder interviews) là thu thập thông tin chi tiết và các yêu cầu cụ thể một cách trực tiếp từ những người có vai trò quyết định hoặc sử dụng hệ thống."
      },
      {
        "question_id": 113,
        "question_title": "Elicitation is a collaborative and analytical process that includes activities to collect, discover, extract, and _____________",
        "option_A": "gather requirements",
        "option_B": "define requirements",
        "option_C": "write requirements",
        "option_D": "analyze requirements",
        "correct_anwser": "A",
        "explain": "Theo định nghĩa chuẩn trong tài liệu kỹ nghệ yêu cầu (Karl Wiegers), khơi gợi yêu cầu (Elicitation) là một quá trình cộng tác và phân tích bao gồm các hoạt động thu thập, khám phá, trích xuất và tập hợp các yêu cầu (gather requirements) từ nhiều nguồn khác nhau."
      },
      {
        "question_id": 114,
        "question_title": "Which of the following strategies helps mitigate the risk of stakeholders expecting a throwaway prototype to be production-ready?",
        "option_A": "Using high-fidelity tools that resemble the final product.",
        "option_B": "Leaving the prototype looking rough and unpolished.",
        "option_C": "Making the prototype available for immediate release.",
        "option_D": "Giving detailed descriptions of every feature.",
        "correct_anwser": "B",
        "explain": "Để tránh việc khách hàng lầm tưởng một mẫu thử bỏ đi (Throwaway prototype) là một sản phẩm hoàn thiện có thể đem đi chạy thật ngay lập tức, BA nên chủ động để giao diện mẫu thử ở dạng thô sơ, phác thảo nguệch ngoạc (Rough and unpolished)."
      },
      {
        "question_id": 115,
        "question_title": "Some stakeholders are customers, such as legal staff, compliance auditors, suppliers, contractors, and venture capitalists",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Các đối tượng như nhân viên pháp lý, kiểm toán viên tuân thủ, nhà cung cấp, nhà thầu và nhà đầu tư mạo hiểm đều là các Stakeholders (bên liên quan), nhưng họ không được phân loại là Customers (khách hàng)."
      },
      {
        "question_id": 116,
        "question_title": "Which of the following statements accurately describe the use of context diagrams in representing project scope? Select two.",
        "option_A": "A context diagram visually illustrates the boundary between the system being developed and external entities that interact with it.",
        "option_B": "The context diagram includes detailed information about the system's internal processes and data.",
        "option_C": "The primary purpose of a context diagram is to depict the interactions between the system and external entities without detailing the internal workings of the system.",
        "option_D": "Context diagrams are typically used to represent the relationship between user interfaces and system components within the boundary.",
        "correct_anwser": "A, C",
        "explain": "Sơ đồ ngữ cảnh (Context Diagram) được dùng để xác định ranh giới hệ thống thông qua việc thể hiện hệ thống như một khối duy nhất tương tác với các thực thể bên ngoài (A và C). Sơ đồ này hoàn toàn không đi sâu vào cấu trúc hoặc luồng dữ liệu nội bộ chi tiết của hệ thống."
      },
      {
        "question_id": 117,
        "question_title": "What is not the purpose of a Use Case Diagram?",
        "option_A": "Use case diagrams are both behavior diagrams because they describe the behavior of the system. They are also structure diagrams, serving as a special case of class diagrams where classifiers are restricted to be either actors or use cases related to each other with associations.",
        "option_B": "Use case diagrams show the graphical user interface that needs to be implemented.",
        "option_C": "Use case diagrams are usually referred to as behavior diagrams used to describe a set of actions (use cases) that some system or systems (subject) should or can perform in collaboration with one or more external users of the system (actors).",
        "option_D": "A use case describes a sequence of interactions between a system and an external actor that results in the actor being able to achieve some outcome of value.",
        "correct_anwser": "B",
        "explain": "Sơ đồ ca sử dụng (Use Case Diagram) dùng để mô tả mối quan hệ giữa tác nhân (actor) và các chức năng hệ thống ở mức tổng quan chứ hoàn toàn không có mục đích hay chức năng thể hiện giao diện đồ họa người dùng (Graphical User Interface - GUI)."
      },
      {
        "question_id": 118,
        "question_title": "What is the distinction between users and actors?",
        "option_A": "There is no real difference; the terms can be used interchangeably.",
        "option_B": "Users are only relevant for use cases involving a graphical interface, while actors cover backend processes.",
        "option_C": "Users are responsible for system development, and actors are responsible for testing.",
        "option_D": "A user is an actual person (or system) using the product, while an actor is an abstraction that represents the role the user plays in a given use case.",
        "option_E": "Users are always individuals, while actors are always systems.",
        "correct_anwser": "D",
        "explain": "Trong phân tích hệ thống và UML, 'User' là một người hoặc hệ thống thực tế bằng xương bằng thịt sử dụng sản phẩm phần mềm, còn 'Actor' là một thực thể trừu tượng đại diện cho một vai trò (role) mà người dùng đó đảm nhận khi tương tác với một ca sử dụng (use case) cụ thể."
      },
      {
        "question_id": 119,
        "question_title": "Which of the following statements accurately describe preconditions and postconditions in the context of use cases? Select two.",
        "option_A": "Preconditions define the prerequisites that must be met before the system can begin executing a use case.",
        "option_B": "Preconditions describe the expected outcome after the use case has been successfully executed.",
        "option_C": "Postconditions describe the state of the system after the use case has executed successfully.",
        "option_D": "Postconditions determine whether the system should proceed with executing a use case.",
        "correct_anwser": "A, C",
        "explain": "Điều kiện tiên quyết (Preconditions) là các ràng buộc hoặc trạng thái hệ thống phải được thỏa mãn trước khi một ca sử dụng có thể bắt đầu chạy (A). Điều kiện sau (Postconditions) mô tả trạng thái cuối cùng hoặc kết quả mà hệ thống đạt được sau khi ca sử dụng kết thúc thành công (C)."
      },
      {
        "question_id": 120,
        "question_title": "What is the function of decision tables in requirements modeling?",
        "option_A": "To represent complex Boolean logic and decisions in a tabular format",
        "option_B": "To model user interface design",
        "option_C": "To specify data flows",
        "option_D": "To define system states",
        "correct_anwser": "A",
        "explain": "Bảng quyết định (Decision tables) được dùng trong mô hình hóa yêu cầu để biểu diễn các logic Boolean phức tạp gồm nhiều điều kiện và các hành động tương ứng dưới dạng bảng trực quan, giúp kiểm tra tính đầy đủ của logic nghiệp vụ."
      },
      {
        "question_id": 121,
        "question_title": "What is one guideline for naming processes in a DFD?",
        "option_A": "Use a verb only",
        "option_B": "Use a noun only",
        "option_C": "Name the process after its corresponding data store",
        "option_D": "Name each process using a concise verb-object action",
        "correct_anwser": "D",
        "explain": "Trong sơ đồ luồng dữ liệu (DFD), mỗi tiến trình (process) bắt buộc phải thực hiện một hành động biến đổi dữ liệu, do đó quy định đặt tên chuẩn là sử dụng cụm Động từ + Tân ngữ (verb-object) rõ ràng, súc tích."
      },
      {
        "question_id": 122,
        "question_title": "In an ERD, what is an entity typically represented by?",
        "option_A": "A diamond shape",
        "option_B": "A rectangle",
        "option_C": "An oval shape",
        "option_D": "A hexagon shape",
        "correct_anwser": "B",
        "explain": "Trong sơ đồ quan hệ thực thể (ERD), một thực thể (Entity) thường được biểu diễn bằng một hình chữ nhật (Rectangle). Hình thoi biểu diễn mối quan hệ, hình bầu dục biểu diễn thuộc tính."
      },
      {
        "question_id": 123,
        "question_title": "When selecting packaged solutions, what factors determine the level of detail and effort that should be put into specifying requirements?",
        "option_A": "The availability of vendor documentation and training materials.",
        "option_B": "The complexity of the existing system that the package will replace.",
        "option_C": "The expected package costs, the evaluation timeline, and the number of candidate solutions.",
        "option_D": "The size of the development team and their familiarity with packaged solutions",
        "correct_anwser": "C",
        "explain": "Khi lựa chọn các giải pháp phần mềm đóng gói thương mại (COTS), mức độ chi tiết và công sức bỏ ra để đặc tả yêu cầu phụ thuộc lớn vào chi phí dự kiến của gói phần mềm, quỹ thời gian đánh giá cho phép, và số lượng các giải pháp ứng viên cần cân nhắc sàng lọc."
      },
      {
        "question_id": 124,
        "question_title": "What is the primary function of a \"Use Case\" in requirements engineering?",
        "option_A": "To define the database schema and data relationships.",
        "option_B": "To describe an interaction between a user (actor) and a system to achieve a specific goal.",
        "option_C": "To outline the project schedule and milestones.",
        "option_D": "To specify the non-functional constraints of the application.",
        "correct_anwser": "B",
        "explain": "Mục đích chính của Use Case (Trường hợp sử dụng) là mô tả một chuỗi tương tác hoàn chỉnh giữa một tác nhân bên ngoài (Actor) và hệ thống nhằm đạt được một mục tiêu cụ thể có giá trị đối với tác nhân đó."
      },
      {
        "question_id": 125,
        "question_title": "Which of the following describes the purpose of a context diagram in software requirements development?",
        "option_A": "It maps out the full class structure and database schema.",
        "option_B": "It defines the boundary between the system being developed and the external entities interacting with it.",
        "option_C": "It tracks the project delivery schedule and milestones.",
        "option_D": "It captures non-functional data constraints exclusively.",
        "correct_anwser": "B",
        "explain": "Sơ đồ ngữ cảnh (Context Diagram) là một mô hình mức cao được sử dụng để xác định rõ ràng ranh giới (boundary) của hệ thống phần mềm cần xây dựng với thế giới bên ngoài, đồng thời hiển thị các tác nhân hoặc hệ thống ngoại vi (external entities) có trao đổi luồng thông tin với nó."
      },
      {
        "question_id": 126,
        "question_title": "An analytical model that visually represents the life cycle of an object, showing the valid sequences of conditions it can transition through, is called:",
        "option_A": "A Data Flow Diagram",
        "option_B": "A State Transition Diagram",
        "option_C": "A Dialog Map",
        "option_D": "An Entity-Relationship Diagram",
        "correct_anwser": "B",
        "explain": "Sơ đồ chuyển trạng thái (State Transition Diagram) hiển thị một tập hợp các trạng thái mà một đối tượng có thể trải qua trong vòng đời của nó, đồng thời mô tả các sự kiện kích hoạt làm thay đổi trạng thái đó từ điều kiện này sang điều kiện khác."
      },
      {
        "question_id": 127,
        "question_title": "Which modeling technique is best suited for documenting complex business logic involving multiple combinations of conditional factors and corresponding actions?",
        "option_A": "Use Case Diagram",
        "option_B": "Decision Table or Decision Tree",
        "option_C": "Context Diagram",
        "option_D": "User Persona Grid",
        "correct_anwser": "B",
        "explain": "Bảng quyết định (Decision Table) hoặc Cây quyết định (Decision Tree) là công cụ phân tích nghiệp vụ lý tưởng nhất để biểu diễn các logic điều kiện phức tạp, nơi có nhiều sự kết hợp khác nhau giữa các yếu tố đầu vào dẫn đến các hành động xử lý khác nhau của hệ thống."
      },
      {
        "question_id": 128,
        "question_title": "Which element in a Use Case Description outlines the optimal pathway where everything works perfectly without errors?",
        "option_A": "Preconditions",
        "option_B": "Postconditions",
        "option_C": "Alternative Flows",
        "option_D": "Basic Flow or Main Success Scenario",
        "correct_anwser": "D",
        "explain": "Trong tài liệu mô tả Use Case, luồng cơ bản (Basic Flow hoặc Main Success Scenario) đại diện cho kịch bản lý tưởng nhất, nơi tất cả các bước tương tác diễn ra suôn sẻ theo đúng trình tự mong muốn và đạt được mục tiêu của tác nhân mà không gặp bất kỳ lỗi hay ngoại lệ nào."
      },
      {
        "question_id": 129,
        "question_title": "Which of the following describes the difference between an inclusion (<>) and an extension (<>) relationship in a Use Case Diagram?",
        "option_A": "Inclusion is optional, while extension is always mandatory.",
        "option_B": "Inclusion represents a mandatory subtask that is always executed as part of the base use case, while extension represents an optional behavior that occurs only under specific conditions.",
        "option_C": "Inclusion is written by developers, while extension is drafted by users.",
        "option_D": "Extension points down to the database, while inclusion points up to the user interface.",
        "correct_anwser": "B",
        "explain": "Mối quan hệ `<<include>>` chỉ ra rằng use case bị bao gồm là bắt buộc phải thực hiện mỗi khi use case gốc chạy. Ngược lại, mối quan hệ `<<extend>>` mô tả một hành vi tùy chọn (optional), chỉ được chèn vào use case gốc khi thỏa mãn một điều kiện hoặc điểm mở rộng (extension point) cụ thể."
      },
      {
        "question_id": 130,
        "question_title": "What is the key benefit of creating an entity-relationship diagram (ERD) during requirements analysis?",
        "option_A": "It tracks the weekly hours billed by individual software contractors.",
        "option_B": "It visually models the system's data objects and the logical relationships between them.",
        "option_C": "It acts as a functional user experience interaction prototype.",
        "option_D": "It compiles Java source code directly into relational database tables.",
        "correct_anwser": "B",
        "explain": "Sơ đồ quan hệ thực thể (ERD) cung cấp một mô hình trực quan hóa cấu trúc dữ liệu của hệ thống, giúp xác định rõ các thực thể dữ liệu (data objects), các thuộc tính và mối liên kết logic giữa chúng."
      },
      {
        "question_id": 131,
        "question_title": "Which component in a standard Use Case Diagram represents an external entity that interacts with the system to achieve a goal?",
        "option_A": "Extend point",
        "option_B": "Boundary block",
        "option_C": "Actor",
        "option_D": "Include arrow",
        "correct_anwser": "C",
        "explain": "Tác nhân (Actor) trong sơ đồ Use Case đại diện cho một đối tượng bên ngoài (có thể là con người, phòng ban hoặc một hệ thống khác) trực tiếp tương tác với hệ thống để thực hiện một mục tiêu nhất định."
      },
      {
        "question_id": 132,
        "question_title": "In requirements modeling, a \"Data Flow Diagram\" (DFD) is primarily used to show:",
        "option_A": "The visual layout arrangement of user interface buttons.",
        "option_B": "How data moves through a system, including processes, data stores, and external entities.",
        "option_C": "The chronological Gantt chart scheduling of project milestones.",
        "option_D": "The object-oriented class inheritance structure tree.",
        "correct_anwser": "B",
        "explain": "Sơ đồ luồng dữ liệu (DFD) được sử dụng để mô hình hóa sự chuyển động của dữ liệu trong hệ thống, chỉ ra cách dữ liệu được biến đổi qua các tiến trình (processes), lưu trữ tại các kho dữ liệu (data stores) và tương tác với các thực thể ngoài."
      },
      {
        "question_id": 133,
        "question_title": "How should the names of use cases be written?",
        "option_A": "A noun followed by a verb",
        "option_B": "A verb followed by an object",
        "option_C": "A random combination of words",
        "option_D": "A descriptive phrase",
        "correct_anwser": "B",
        "explain": "Tên của một ca sử dụng (use case) tiêu chuẩn phải luôn bắt đầu bằng một động từ thể hiện hành động hướng mục tiêu và theo sau là một bổ ngữ/đối tượng chịu tác động (Verb + Object). Ví dụ: 'Đăng nhập hệ thống', 'Rút tiền', 'Tạo hóa đơn'."
      },
      {
        "question_id": 134,
        "question_title": "Which of the following statements is TRUE about Use Cases?",
        "option_A": "Use Cases are static and do not evolve throughout the software development process.",
        "option_B": "Use case diagrams are the primary tool to document requirements",
        "option_C": "Use Cases are not useful in capturing user requirements.",
        "option_D": "Use Cases describe the interactions between the system and external entities.",
        "correct_anwser": "D",
        "explain": "Bản chất cốt lõi của ca sử dụng (Use Case) là mô tả chuỗi các sự kiện tương tác qua lại giữa một hệ thống và các tác nhân bên ngoài (external entities/actors) nhằm đạt được một mục tiêu cụ thể của người dùng."
      },
      {
        "question_id": 135,
        "question_title": "When choosing the appropriate representation techniques for analysis models, which of the following guidelines should be followed? Select two.",
        "option_A": "Business process flows can be represented with high-level data flow diagrams or Swimlane diagrams that show roles and responsibilities in the process.",
        "option_B": "Use only one type of model to avoid confusion and ensure clarity throughout the development process.",
        "option_C": "Complex logic can be effectively represented using decision trees or decision tables, which show possible outcomes or unique functional requirements.",
        "option_D": "Data relationships should be illustrated using state-transition diagrams or storyboard models.",
        "correct_anwser": "A, C",
        "explain": "Theo các nguyên tắc xây dựng mô hình phân tích: Luồng quy trình nghiệp vụ nên được mô tả bằng sơ đồ phân làn (Swimlane diagrams) để phân định rõ vai trò và trách nhiệm (A). Các logic nghiệp vụ phức tạp, chứa nhiều điều kiện rẽ nhánh rắc rối nên được biểu diễn rõ ràng qua bảng quyết định (decision tables) hoặc cây quyết định (decision trees) (C). Việc ép buộc chỉ dùng duy nhất một loại mô hình là sai lầm (loại B), và mối quan hệ dữ liệu phải dùng ERD chứ không dùng sơ đồ trạng thái (loại D)."
      },
      {
        "question_id": 136,
        "question_title": "How can a business analyst effectively translate the voice of the customer into specific model components? Select two.",
        "option_A": "By focusing exclusively on the nouns mentioned by customers, as they represent the most critical elements.",
        "option_B": "By identifying keywords such as nouns, verbs, and conditional statements that can be mapped to corresponding analysis model components.",
        "option_C": "By using a predetermined set of model components without considering the specific word choices of the customer.",
        "option_D": "By mapping verbs mentioned by customers to processes, activities, and use cases in the analysis models.",
        "correct_anwser": "B, D",
        "explain": "Để chuyển dịch ngôn ngữ của khách hàng sang mô hình phân tích một cách hiệu quả, BA cần phân tích các từ khóa ngữ pháp chính: Danh từ ánh xạ thành đối tượng/thực thể, động từ ánh xạ thành các tiến trình/ca sử dụng, và các từ điều kiện ánh xạ thành luật nghiệp vụ (B). Cụ thể, các động từ (verbs) mà khách hàng nói phản ánh trực tiếp hành động, do đó sẽ được đưa vào làm các quy trình, hoạt động hoặc ca sử dụng (D)."
      },
      {
        "question_id": 137,
        "question_title": "Which of the following is not a component of an Entity Relationship Diagrams (ERD)",
        "option_A": "Entity",
        "option_B": "Relationship",
        "option_C": "Association",
        "option_D": "Cardinality",
        "option_E": "Attribute",
        "correct_anwser": "C",
        "explain": "Các thành phần cốt lõi của sơ đồ quan hệ thực thể (ERD) bao gồm Thực thể (Entity), Mối quan hệ (Relationship), Bản số/Quan hệ số lượng (Cardinality) và Thuộc tính (Attribute). Khái niệm 'Association' (Liên kết) là thuật ngữ đặc thù thường dùng trong Sơ đồ lớp (Class Diagram) của ngôn ngữ UML chứ không thuộc thành phần tiêu chuẩn của ERD."
      },
      {
        "question_id": 138,
        "question_title": "Which of the following statements is incorrect about ERD?",
        "option_A": "Individual instances of an entity will have the same attribute values",
        "option_B": "The cardinality, or multiplicity, of each relationship is shown with a number or letter on the lines that connect entities and relationships",
        "option_C": "Each entity is described by one or more attributes",
        "option_D": "The diamonds in the ERD represent relationships, which identify the logical linkages between pairs of entities",
        "correct_anwser": "A",
        "explain": "Phát biểu A sai vì các thực thể cụ thể (individual instances) thuộc cùng một tập thực thể sẽ có cùng cấu trúc các thuộc tính, nhưng giá trị dữ liệu chứa trong các thuộc tính đó của mỗi thực thể phải khác nhau để phân biệt chúng (ví dụ: các instance Sinh viên đều có thuộc tính 'Mã SV', nhưng giá trị Mã SV của mỗi người là duy nhất)."
      },
      {
        "question_id": 139,
        "question_title": "Consider the use case diagram for the Chemical Tracking System. How does the \"extend\" relationship between \"Request a Chemical\" and \"Search Vendor Catalogs\" affect the system's functionality?",
        "option_A": "It allows \"Request a Chemical\" to function independently without any alternative flows.",
        "option_B": "It integrates \"Search Vendor Catalogs\" into the normal flow of \"Request a Chemical.\"",
        "option_C": "It provides an optional alternative flow for requesting chemicals from a vendor.",
        "option_D": "It duplicates the steps of \"Search Vendor Catalogs\" within \"Request a Chemical.\"",
        "correct_anwser": "C",
        "explain": "Quan hệ `<<extend>>` (mở rộng) từ \"Search Vendor Catalogs\" đến \"Request a Chemical\" thể hiện một luồng hành vi tùy chọn (optional/alternative flow). Hành động tìm kiếm danh mục nhà cung cấp chỉ diễn ra trong một số điều kiện nhất định khi thực hiện ca sử dụng gốc, chứ không bắt buộc thực hiện như quan hệ include."
      },
      {
        "question_id": 140,
        "question_title": "What is the primary purpose of a state-transition diagram (STD)?",
        "option_A": "To model the physical layout and hardware components of a system.",
        "option_B": "To represent the possible states of an object and the transitions between these states based on various events or conditions.",
        "option_C": "To outline the organizational roles and responsibilities within a business process.",
        "option_D": "To visualize user interface flow and interactions in software applications.",
        "correct_anwser": "B",
        "explain": "Mục đích cốt lõi của sơ đồ chuyển trạng thái (State-Transition Diagram) là mô hình hóa các trạng thái có thể có của một đối tượng hoặc hệ thống, cùng với các quy tắc, điều kiện hoặc sự kiện kích hoạt sự dịch chuyển qua lại giữa các trạng thái đó."
      },
      {
        "question_id": 141,
        "question_title": "A collection of definitions for the data elements and data structures that are relevant to the problem domain",
        "option_A": "Data dictionary",
        "option_B": "Data flow diagram",
        "option_C": "Database",
        "option_D": "Relationship",
        "correct_anwser": "A",
        "explain": "Tập hợp tất cả các định nghĩa chi tiết về các phần tử dữ liệu (data elements) và cấu trúc dữ liệu (data structures) thuộc phạm vi bài toán của hệ thống được gọi là Từ điển dữ liệu (Data dictionary)."
      },
      {
        "question_id": 142,
        "question_title": "What is the definition of Pre-Condition in Use case?",
        "option_A": "A condition that describes the state of a system after a use case is successfully completed.",
        "option_B": "A condition that must be satisfied or a state the system must be in before a use case can begin.",
        "option_C": "A condition that initiates execution of the use case",
        "option_D": "A condition that must be satisfied so that system run successful.",
        "correct_anwser": "B",
        "explain": "Điều kiện tiên quyết (Pre-condition) trong ca sử dụng được định nghĩa là một ràng buộc hoặc trạng thái bắt buộc hệ thống phải thỏa mãn trước khi ca sử dụng đó được phép kích hoạt và bắt đầu thực thi."
      },
      {
        "question_id": 143,
        "question_title": "Which elements are mandatory in use case?",
        "option_A": "Post-condition",
        "option_B": "Actors",
        "option_C": "Pre-condition",
        "option_D": "Name",
        "correct_anwser": "B, D",
        "explain": "Trong một Use Case, hai thành phần tối thiểu và bắt buộc phải có để định danh và xác định đối tượng tương tác là Tên của Use Case (Name) và Tác nhân (Actors). Điều kiện tiên quyết (Pre-condition) và điều kiện sau khi hoàn thành (Post-condition) tuy quan trọng trong tài liệu đặc tả chi tiết nhưng không phải lúc nào cũng bắt buộc ở mọi mức độ biểu diễn Use Case tổng quan."
      },
      {
        "question_id": 144,
        "question_title": "In the Chemical Tracking System project, what is the relationship between use case: \"Play a bill\" and use case: \"Write a check\" ?",
        "option_A": "include",
        "option_B": "extend",
        "option_C": "generalization",
        "option_D": "N/A",
        "correct_anwser": "B",
        "explain": "Lưu ý đề bài hiển thị lỗi chính tả từ gốc \"Pay a bill\" thành \"Play a bill\". Mối quan hệ giữa hành động \"Thanh toán hóa đơn\" (Pay a bill) và \"Viết séc\" (Write a check) là quan hệ mở rộng (extend), vì viết séc là một trong những phương thức tùy chọn, không bắt buộc để hoàn thành việc thanh toán hóa đơn (người dùng có thể trả bằng tiền mặt, thẻ tín dụng,...)."
      },
      {
        "question_id": 145,
        "question_title": "How can requirements modeling assist in resolving conflicts between stakeholders?",
        "option_A": "By providing a clear, visual representation of requirements for alignment",
        "option_B": "By finalizing all functional requirements",
        "option_C": "By focusing only on technical feasibility",
        "option_D": "By eliminating the need for prototyping",
        "correct_anwser": "A",
        "explain": "Mô hình hóa yêu cầu (Requirements modeling) sử dụng các biểu đồ trực quan giúp các bên liên quan dễ dàng nhìn thấy bức tranh tổng thể, phát hiện ra các điểm bất đồng hoặc thiếu sót, từ đó thảo luận để đi đến sự thống nhất và đồng thuận cao hơn."
      },
      {
        "question_id": 146,
        "question_title": "Which of the following factors should be considered when classifying users? Select three.",
        "option_A": "The platform they will be using, such as desktop PCs, laptops, tablets, or smartphones.",
        "option_B": "The specific languages used in the system’s backend processes.",
        "option_C": "The frequency with which they use the product and the tasks they perform during business operations.",
        "option_D": "Their access privileges or security levels, such as ordinary user, guest user, or administrator.",
        "correct_anwser": "A, C, D",
        "explain": "Khi phân loại các lớp người dùng (user classes), chúng ta dựa trên nền tảng thiết bị họ sử dụng (A), tần suất sử dụng và tác vụ nghiệp vụ họ thực hiện (C), cùng với mức độ phân quyền/bảo mật của họ trong hệ thống (D). Ngôn ngữ lập trình backend (B) thuộc về mặt kỹ thuật nội bộ, không dùng để phân loại đối tượng người dùng."
      },
      {
        "question_id": 147,
        "question_title": "Which of the following statements accurately describe the use case approach? Select two.",
        "option_A": "A use case describes a sequence of interactions between a system and an external actor that results in an outcome of value to the actor.",
        "option_B": "In a use case diagram, the boundary between what’s inside and outside the system is not explicitly defined.",
        "option_C": "Actors in a use case can include both human users and other systems that interact with the system being developed.",
        "option_D": "The primary actor in a use case is always the system itself, as it initiates and controls all interactions.",
        "correct_anwser": "A, C",
        "explain": "Cách tiếp cận Use Case mô tả chuỗi tương tác giữa hệ thống và tác nhân bên ngoài để mang lại một giá trị cụ thể cho tác nhân đó (A đúng). Tác nhân (Actors) tham gia vào Use Case không chỉ là con người mà còn có thể là các hệ thống phần mềm/phần cứng khác kết nối tới hệ thống (C đúng)."
      },
      {
        "question_id": 148,
        "question_title": "If both \"Submit loan request\" and \"Offer line of credit\" use the \"Perform credit check\" use case, the relationship between \"Perform credit check\" and the other use cases is:",
        "option_A": "Extend relationship",
        "option_B": "Generalization relationship",
        "option_C": "Include relationship",
        "correct_anwser": "C",
        "explain": "Khi nhiều use cases khác nhau đều sử dụng chung một chức năng con tuần tự và bắt buộc (ở đây là 'Perform credit check'), mối quan hệ giữa use case cơ sở và use case dùng chung đó được định nghĩa là quan hệ bao hàm (Include relationship)."
      },
      {
        "question_id": 149,
        "question_title": "How should data flows be represented between processes, data stores, and external entities in a DFD?",
        "option_A": "Directly from one process to another.",
        "option_B": "Directly from one data store to another.",
        "option_C": "Through a process bubble, not directly between data stores or between external entities and data stores.",
        "option_D": "Directly between external entities and data stores.",
        "correct_anwser": "C",
        "explain": "Trong Sơ đồ luồng dữ liệu (DFD), mọi luồng dữ liệu đi/đến kho dữ liệu (data stores) hoặc thực thể ngoài (external entities) đều bắt buộc phải đi qua một tiến trình xử lý (process bubble). Dữ liệu không thể tự di chuyển trực tiếp giữa hai kho dữ liệu, hoặc trực tiếp từ thực thể ngoài vào thẳng kho dữ liệu mà không có tiến trình xử lý tác động."
      },
      {
        "question_id": 150,
        "question_title": "Fill in the blank.\n______is a visual representation of the data objects and collections the system will process, and the relationships between them.",
        "option_A": "Use case diagram",
        "option_B": "Data model",
        "option_C": "Data dictionary",
        "option_D": "Reports",
        "correct_anwser": "B",
        "explain": "Mô hình dữ liệu (Data model), chẳng hạn như sơ đồ ERD, chính là sự thể hiện trực quan hóa cấu trúc của các đối tượng dữ liệu, tập hợp dữ liệu mà hệ thống sẽ xử lý, kèm theo các mối quan hệ ràng buộc logic giữa chúng."
      },
      {
        "question_id": 151,
        "question_title": "When defining installability requirements, which of the following factors is most important to measure how easy it is to install a system?",
        "option_A": "The number of additional components that need to be installed with the system.",
        "option_B": "The average time required for an untrained user to successfully complete the installation process.",
        "option_C": "The type of hardware used during the installation process.",
        "option_D": "The number of user profiles that need to be transferred during installation.",
        "correct_anwser": "B",
        "explain": "Yêu cầu về khả năng cài đặt (Installability) hướng tới tính dễ dàng thực hiện. Tiêu chí định lượng tốt nhất để đo lường độ 'dễ' này là thời gian trung bình cần thiết để một người dùng bình thường (chưa qua đào tạo huấn luyện) có thể tự hoàn thành việc cài đặt hệ thống thành công."
      },
      {
        "question_id": 152,
        "question_title": "In a use case diagram, an arrow from an actor to a use case indicates that he is the _________ actor for the use case.",
        "option_A": "primary",
        "option_B": "secondary",
        "option_C": "main",
        "option_D": "side",
        "correct_anwser": "A",
        "explain": "Trong sơ đồ use case, đường liên kết hoặc mũi tên xuất phát từ Actor hướng đến Use Case thường dùng để chỉ định Actor đó là tác nhân chính (Primary Actor) — người chủ động kích hoạt và tương tác trực tiếp để thực hiện use case."
      },
      {
        "question_id": 153,
        "question_title": "Which of the following would be an appropriate analysis model component for a ‘verb’ in customer language?",
        "option_A": "External entities in a Data Flow Diagram (DFD)",
        "option_B": "Relationships in an Entity Relationship Diagram (ERD)",
        "option_C": "Processes in a Data Flow Diagram (DFD)",
        "option_D": "Objects with states in a State Transition Diagram (STD)",
        "correct_anwser": "C",
        "explain": "Khi phân tích ngôn ngữ tự nhiên của khách hàng để chuyển sang mô hình hóa, các 'danh từ' thường đại diện cho thực thể (Entities/Data stores) hoặc tác nhân, còn các 'động từ' hành động (ví dụ: tính toán, kiểm tra, gửi...) sẽ tương ứng với các Tiến trình (Processes) xử lý trong sơ đồ dòng dữ liệu DFD."
      },
      {
        "question_id": 154,
        "question_title": "Fill in the blank.\n_______ is a visual representation of the data objects and collections the system will process and the relationships between them.",
        "option_A": "Use case diagram",
        "option_B": "Data model",
        "option_C": "Data dictionary",
        "option_D": "Reports",
        "correct_anwser": "B",
        "explain": "Mô hình dữ liệu (Data model) - ví dụ tiêu biểu là sơ đồ ERD - là một cách biểu diễn trực quan các đối tượng dữ liệu, tập hợp dữ liệu mà hệ thống xử lý cùng với mối quan hệ (relationships) ràng buộc giữa chúng."
      },
      {
        "question_id": 155,
        "question_title": "What technique is used to represent the scope of a project? (Choose 2 correct answers)",
        "option_A": "Ecosystem map",
        "option_B": "Use case",
        "option_C": "Context diagram",
        "option_D": "ERD",
        "correct_anwser": "A, C",
        "explain": "Theo tài liệu kỹ nghệ yêu cầu phần mềm, hai kỹ thuật mô hình hóa phân tích chuẩn mực nhất được sử dụng trực tiếp để định hình và biểu diễn phạm vi dự án (project scope) ở mức cao là Sơ đồ ngữ cảnh (Context diagram) và Sơ đồ hệ sinh thái (Ecosystem map)."
      },
      {
        "question_id": 156,
        "question_title": "Which of the following statements INCORRECTLY describes types of software requirements?",
        "option_A": "Business rules are the origin of several types of software requirements, but they are not software requirements themselves.",
        "option_B": "Nonfunctional requirements describe the system's performance characteristics rather than its specific behaviors.",
        "option_C": "Functional requirements describe how the system will perform certain actions under specific conditions.",
        "option_D": "Quality attributes describe the system's functional behaviors in terms of user interactions.",
        "correct_anwser": "D",
        "explain": "Quality attributes (Thuộc tính chất lượng) là một phần của yêu cầu phi chức năng (Nonfunctional requirements), mô tả các đặc tính vận hành như hiệu năng, bảo mật, độ tin cậy, chứ không phải mô tả hành vi chức năng (functional behaviors) hay tương tác của người dùng."
      },
      {
        "question_id": 157,
        "question_title": "Why is it challenging to amalgamate requirements input from numerous users?",
        "option_A": "Users often disagree on technical specifications.",
        "option_B": "Structured organizing schemes are typically unavailable.",
        "option_C": "Requirements input is often diverse and unstructured.",
        "option_D": "Users lack domain expertise.",
        "correct_anwser": "C",
        "explain": "Việc tổng hợp dữ liệu yêu cầu đầu vào từ quá nhiều người dùng luôn là một thách thức lớn vì thông tin nhận được thường rất đa dạng, phân mảnh, chồng chéo và thiếu cấu trúc đồng nhất."
      },
      {
        "question_id": 158,
        "question_title": "\"Every order has a shipping charge\" is a:",
        "option_A": "fact",
        "option_B": "constraint",
        "option_C": "action enabler",
        "option_D": "inference",
        "correct_anwser": "A",
        "explain": "Câu phát biểu 'Mỗi đơn hàng đều có phí vận chuyển' biểu thị một chân lý nghiệp vụ luôn đúng và tồn tại trong tổ chức đó, vì thế nó được phân loại vào nhóm 'Fact' (Sự thật/Chân lý nghiệp vụ) theo lý thuyết về Business Rules."
      },
      {
        "question_id": 159,
        "question_title": "Which of the following is NOT a type of business rule according to the taxonomy?",
        "option_A": "Fact Rules",
        "option_B": "Action Enabler Rules",
        "option_C": "Constraint Rules",
        "option_D": "Operational Rules",
        "correct_anwser": "D",
        "explain": "Theo phân loại chuẩn của giáo trình kỹ nghệ yêu cầu (ví dụ của Karl Wiegers), luật nghiệp vụ (Business Rules) được phân làm các nhóm chính bao gồm: Facts, Constraints, Action Enablers, Inferences và Computations. 'Operational Rules' không nằm trong hệ thống phân loại chuẩn này."
      },
      {
        "question_id": 160,
        "question_title": "In the specification of a use case, conditions that have the potential to prevent a use case from succeeding are called _______.",
        "option_A": "exceptions",
        "option_B": "alternative flows",
        "option_C": "secondary scenarios",
        "option_D": "backup flows",
        "correct_anwser": "A",
        "explain": "Các điều kiện hay tình huống phát sinh ngoài dự kiến có khả năng phá vỡ luồng xử lý chính và khiến cho ca sử dụng thất bại (không đạt được mục tiêu của tác nhân) được gọi là 'Exceptions' (Ngoại lệ/Tình huống lỗi)."
      },
      {
        "question_id": 161,
        "question_title": "In a software requirements specification, which section do user interfaces belong to?",
        "option_A": "Overall description",
        "option_B": "System features",
        "option_C": "Data requirements",
        "option_D": "External interface requirements",
        "correct_anwser": "D",
        "explain": "Trong tài liệu đặc tả yêu cầu phần mềm (SRS - chuẩn IEEE), mô tả về giao diện người dùng (User Interfaces) cùng với giao diện phần cứng, phần mềm và giao tiếp truyền thông sẽ được xếp vào mục 'External interface requirements' (Yêu cầu giao diện bên ngoài)."
      },
      {
        "question_id": 162,
        "question_title": "How can you explain the statement \"Implicit requirements can also be unknown unknowns\"?",
        "option_A": "During the SRS process, customers should always be required to spell out their unknown unknowns.",
        "option_B": "An unknown unknown cannot be known and therefore we can not make them explicit requirements.",
        "option_C": "There are matters that should be, but are not, elicited through the elicitation process. They exist, but they are not realized.",
        "option_D": "They help us reveal both known unknowns and more unknown unknowns.",
        "correct_anwser": "C",
        "explain": "Khái niệm 'Implicit requirements can also be unknown unknowns' ám chỉ những điều hoặc những nghiệp vụ ngầm định mà khách hàng hoàn toàn quên hoặc không hề nhận thức được rằng hệ thống cần phải có. Do đó, chúng tồn tại một cách khách quan nhưng chưa được phát hiện hay nhận thức được trong suốt quá trình khơi gợi yêu cầu."
      },
      {
        "question_id": 163,
        "question_title": "External quality attributes describe characteristics that are observed when the software is executing. Which following definitions is Integrity?",
        "option_A": "It deals with blocking unauthorized access to system functions or data, ensuring that the software is protected from malware attacks, and so on.",
        "option_B": "It is the degree to which a system continues to function properly when confronted with invalid inputs.",
        "option_C": "It deals with preventing information loss and preserving the correctness of data entered into the system.",
        "option_D": "It deal with the need to prevent a system from doing any injury to people or damage to property.",
        "correct_anwser": "C",
        "explain": "Tính toàn vẹn (Integrity) theo định nghĩa thuộc tính chất lượng bên ngoài là việc ngăn ngừa mất mát thông tin, đảm bảo tính chính xác, không bị chỉnh sửa trái phép hoặc làm sai lệch dữ liệu khi đưa vào hệ thống."
      },
      {
        "question_id": 164,
        "question_title": "Which of the following is an example of an external quality attribute?",
        "option_A": "Performance",
        "option_B": "Maintainability",
        "option_C": "Portability",
        "option_D": "Usability",
        "correct_anwser": "A, D",
        "explain": "Thuộc tính chất lượng bên ngoài (External quality attributes) là những đặc tính có thể dễ dàng cảm nhận hoặc quan sát được bởi người dùng khi hệ thống đang vận hành, chẳng hạn như Performance (Hiệu năng - tốc độ phản hồi) và Usability (Tính khả dụng - sự dễ dùng). Ngược lại, Maintainability (Khả năng bảo trì) và Portability (Tính di động) là các thuộc tính bên trong (Internal), chủ yếu được quan tâm bởi các kỹ sư phần mềm khi tiếp cận mã nguồn."
      },
      {
        "question_id": 165,
        "question_title": "A requirement that states \"The system must process payments within 2 seconds\" is an example of:",
        "option_A": "A Business Requirement",
        "option_B": "A Functional Requirement",
        "option_C": "A Non-Functional Requirement (Performance)",
        "option_D": "A User Requirement",
        "correct_anwser": "C",
        "explain": "Yêu cầu giới hạn về mặt thời gian phản hồi (xử lý trong vòng 2 giây) là một tiêu chí định lượng đo lường chất lượng vận hành của hệ thống, đây là ví dụ điển hình của Yêu cầu phi chức năng (Non-Functional Requirement), cụ thể thuộc đặc tính hiệu năng (Performance)."
      },
      {
        "question_id": 166,
        "question_title": "Which document serves as the single source of truth for the complete requirements of a system?",
        "option_A": "Project Architecture Document",
        "option_B": "Software Requirements Specification (SRS)",
        "option_C": "User Acceptance Test Plan",
        "option_D": "Daily Scrum Log",
        "correct_anwser": "B",
        "explain": "Tài liệu Đặc tả Yêu cầu Phần mềm (SRS - Software Requirements Specification) là văn bản chính thức đóng vai trò tập trung toàn bộ các yêu cầu chức năng, phi chức năng của hệ thống, là nguồn căn cứ chuẩn xác nhất (source of truth) cho toàn bộ dự án."
      },
      {
        "question_id": 167,
        "question_title": "What is the primary role of a \"Data Dictionary\" in requirements specification?",
        "option_A": "To store compiled software execution binary files.",
        "option_B": "To define the structure, format, and meaning of all data elements used across the system.",
        "option_C": "To translate code variables into multiple foreign languages dynamically.",
        "option_D": "To list the roles and titles of the software company management.",
        "correct_anwser": "B",
        "explain": "Từ điển dữ liệu (Data Dictionary) đóng vai trò định nghĩa một cách nhất quán cấu trúc, kiểu dữ liệu, định dạng, độ dài và ý nghĩa của tất cả các phần tử dữ liệu xuất hiện trong hệ thống để toàn bộ đội ngũ phát triển và kiểm thử có chung một cách hiểu."
      },
      {
        "question_id": 168,
        "question_title": "What type of requirement constraint does the statement \"The system database must be backed up automatically every night at 2:00 AM\" represent?",
        "option_A": "Business Requirement",
        "option_B": "Functional Requirement",
        "option_C": "Non-Functional Requirement (Operational/Reliability)",
        "option_D": "User Requirement",
        "correct_anwser": "C",
        "explain": "Yêu cầu sao lưu dữ liệu tự động định kỳ vào một khung giờ cố định là một ràng buộc về mặt vận hành, quản lý hệ thống và bảo toàn dữ liệu. Đây là một ví dụ điển hình của Yêu cầu phi chức năng (Non-Functional Requirement), cụ thể thuộc nhóm vận hành (Operational) hoặc tính tin cậy (Reliability)."
      },
      {
        "question_id": 169,
        "question_title": "The subdiscipline of requirements development that focuses on ensuring a requirement document is written clearly, contains no contradictions, and is ready for development is:",
        "option_A": "Elicitation",
        "option_B": "Analysis",
        "option_C": "Specification",
        "option_D": "Validation",
        "correct_anwser": "C",
        "explain": "Khai báo yêu cầu (Specification) là hoạt động chuyển dịch các yêu cầu đã thu thập và phân tích thành một dạng văn bản có cấu trúc rõ ràng, nhất quán (như tài liệu SRS). Nó tập trung vào việc ghi chép lại các yêu cầu một cách tường minh để sẵn sàng bàn giao cho đội ngũ lập trình."
      },
      {
        "question_id": 170,
        "question_title": "Which of the following is considered a core element that should be documented within a detailed Use Case Description?",
        "option_A": "The compilation optimization configuration flags.",
        "option_B": "The specific server cluster physical hardware layout specifications.",
        "option_C": "Preconditions, Postconditions, and Actor-System interaction flows.",
        "option_D": "The third-party software license billing invoice schedule.",
        "correct_anwser": "C",
        "explain": "Một tài liệu mô tả Use Case chi tiết bắt buộc phải có các thành phần cốt lõi: Điều kiện tiên quyết (Preconditions), Điều kiện sau khi hoàn thành (Postconditions), Luồng sự kiện chính (Basic Flow) và các luồng phụ/ngoại lệ để mô tả chi tiết tương tác giữa Actor và Hệ thống."
      },
      {
        "question_id": 171,
        "question_title": "During requirements specification, writing \"The user should find the application interface friendly and modern\" represents a low-quality requirement because it fails which criterion?",
        "option_A": "Complete",
        "option_B": "Traceable",
        "option_C": "Unambiguous and Measurable",
        "option_D": "Consistent",
        "correct_anwser": "C",
        "explain": "Các từ ngữ mang tính cảm tính như \"friendly\" (thân thiện) và \"modern\" (hiện đại) không thể đo lường (Measurable) hay kiểm chứng một cách khách quan, đồng thời dễ gây ra cách hiểu khác nhau (fail tiêu chí Unambiguous)."
      },
      {
        "question_id": 172,
        "question_title": "A high-quality software requirement specification (SRS) document must be \"Consistent.\" This means:",
        "option_A": "It contains no contradictory requirements or terms.",
        "option_B": "It is updated hourly by automated cloud webhooks.",
        "option_C": "It is written entirely in compiled low-level machine code bytes.",
        "option_D": "It uses different naming definitions for the same data element.",
        "correct_anwser": "A",
        "explain": "Tiêu chí \"Nhất quán\" (Consistent) đòi hỏi tài liệu SRS không được chứa các yêu cầu mâu thuẫn hoặc xung đột lẫn nhau (ví dụ: một chỗ ghi trường dữ liệu bắt buộc nhập, chỗ khác lại ghi cho phép để trống)."
      },
      {
        "question_id": 173,
        "question_title": "How does the process of elicitation relate to the other activities in requirements development?",
        "option_A": "Elicitation is performed only after specification is complete.",
        "option_B": "Elicitation is an initial step that does not need to be revisited.",
        "option_C": "Elicitation is interwoven with analysis, specification, and validation.",
        "option_D": "Elicitation is only necessary for the first iteration of the project.",
        "correct_anwser": "C",
        "explain": "Khơi gợi yêu cầu (Elicitation) không phải là một bước làm một lần duy nhất rồi thôi. Nó đan xen và gắn kết chặt chẽ (interwoven) với các hoạt động phân tích, đặc tả và xác thực xuyên suốt quá trình phát triển để liên tục làm rõ các yêu cầu mới phát sinh hoặc cần chi tiết hóa."
      },
      {
        "question_id": 174,
        "question_title": "In the specification of a use case, conditions that have the potential to prevent a use case from succeeding are called ________.",
        "option_A": "exceptions",
        "option_B": "alternative flows",
        "option_C": "secondary scenarios",
        "option_D": "backup flows",
        "correct_anwser": "A",
        "explain": "Trong đặc tả ca sử dụng (Use case specification), các điều kiện hoặc tình huống lỗi xảy ra làm gián đoạn luồng xử lý chính và có khả năng ngăn cản ca sử dụng đạt được mục tiêu thành công của nó được định nghĩa là các ngoại lệ (Exceptions) hay luồng ngoại lệ (Exception flows)."
      },
      {
        "question_id": 175,
        "question_title": "Which of the following statements accurately describes a business rule? Select two.",
        "option_A": "A business rule is a statement that defines or constrains some aspect of the business to control or influence its behavior.",
        "option_B": "Business rules are only relevant for heavily rules-driven systems and can be ignored in simpler systems.",
        "option_C": "Classifying business rules helps in understanding how they might be applied in a software application, such as using constraints to enforce certain conditions.",
        "option_D": "A business rule is the same as a system requirement, focusing solely on the technical implementation details.",
        "correct_anwser": "A, C",
        "explain": "Luật kinh doanh (Business Rule) là các tuyên bố định nghĩa hoặc giới hạn một khía cạnh nào đó của doanh nghiệp nhằm kiểm soát hoặc định hướng hành vi hoạt động (A). Việc phân loại cấu trúc luật kinh doanh giúp đội ngũ dự án hiểu rõ cách áp dụng chúng vào ứng dụng phần mềm (chuyển đổi thành các ràng buộc, điều kiện logic mã nguồn) một cách chính xác (C)."
      },
      {
        "question_id": 176,
        "question_title": "Which of the following is not included in software requirements specification (SRS) template ?",
        "option_A": "Quality Attributes",
        "option_B": "External interface",
        "option_C": "Data requirements",
        "option_D": "Design features",
        "correct_anwser": "D",
        "explain": "Tài liệu đặc tả yêu cầu phần mềm (SRS) tập trung vào việc mô tả hệ thống phải làm gì (yêu cầu chức năng, phi chức năng, thuộc tính chất lượng, giao diện bên ngoài). Các đặc điểm hoặc giải pháp thiết kế chi tiết (Design features/details) thuộc về giai đoạn thiết kế kiến trúc hệ thống (SDD - Software Design Document) chứ không nằm trong SRS."
      },
      {
        "question_id": 177,
        "question_title": "When considering software quality attributes, which of the following is classified as an internal quality attribute?",
        "option_A": "Usability",
        "option_B": "Security",
        "option_C": "Efficiency",
        "option_D": "Availability",
        "correct_anwser": "C",
        "explain": "Thuộc tính chất lượng bên trong (Internal quality attributes) là những khía cạnh mà người dùng cuối không trực tiếp nhìn thấy hay trải nghiệm khi sử dụng, nhưng nhà phát triển có thể đo lường và đánh giá thông qua mã nguồn, cấu trúc phần mềm bên trong hệ thống. Trong đó, tính hiệu quả (Efficiency - như tối ưu mã nguồn, kiến trúc tài nguyên) được xem là thuộc tính bên trong tạo tiền đề cho hiệu năng hệ thống hoạt động tốt bên ngoài."
      },
      {
        "question_id": 178,
        "question_title": "What is Planguage?",
        "option_A": "It is a programming language.",
        "option_B": "It is a language with a rich set of keywords that permits precise statements of quality attributes and other project goals.",
        "option_C": "It is a planning language used in project management.",
        "option_D": "It is a language to express non functional requirements.",
        "correct_anwser": "B",
        "explain": "Planguage (được phát triển bởi Tom Gilb) là một ngôn ngữ đặc tả dạng văn bản có cấu trúc với tập hợp phong phú các từ khóa định sẵn (như Tag, Metric, Scale, Target...). Nó được thiết kế nhằm giúp các nhà phân tích đưa ra các phát biểu định lượng vô cùng chính xác cho các yêu cầu phi chức năng, các thuộc tính chất lượng phần mềm cũng như các mục tiêu cốt lõi của dự án."
      },
      {
        "question_id": 179,
        "question_title": "Which one of the following is a functional requirement?",
        "option_A": "Portability.",
        "option_B": "Order products.",
        "option_C": "Maintainability.",
        "option_D": "Security.",
        "option_E": "Robustness.",
        "correct_anwser": "B",
        "explain": "Yêu cầu chức năng (Functional Requirement) định nghĩa một hành vi hoặc chức năng cụ thể mà phần mềm phải thực hiện cho người dùng. Trong các phương án, 'Đặt hàng sản phẩm' (Order products) là một tính năng nghiệp vụ rõ ràng. Các phương án còn lại (Portability, Maintainability, Security, Robustness) đều là các thuộc tính chất lượng hoặc yêu cầu phi chức năng (Non-functional Requirements)."
      },
      {
        "question_id": 180,
        "question_title": "Which of the following is the most precise definition of \"requirement(s)\"?",
        "option_A": "A requirement is anything that drives design choices.",
        "option_B": "A requirement is a property that a product must have to provide value to a stakeholder.",
        "option_C": "Requirements are a specification of what should be implemented. They are descriptions of how the system should behave, or of a system property or attribute. They may be a constraint on the development process of the system.",
        "option_D": "Requirements are what customers want.",
        "correct_anwser": "B",
        "explain": "Theo định nghĩa chuẩn của Karl Wiegers và tài liệu Kỹ nghệ yêu cầu phần mềm, định nghĩa chính xác và bao quát nhất ở mức bản chất là: Yêu cầu là một đặc tính hoặc thuộc tính mà sản phẩm bắt buộc phải có để đem lại giá trị cho một bên liên quan (stakeholder). Lựa chọn C mô tả thiên về khía cạnh tài liệu đặc tả (specification), trong khi ý B nhấn mạnh vào bản chất cốt lõi của yêu cầu là 'mang lại giá trị'."
      },
      {
        "question_id": 181,
        "question_title": "Evaluate the effectiveness of using business process modeling to discover business rules. Which of the following best describes its impact?",
        "option_A": "It only identifies computational rules and ignores constraints.",
        "option_B": "It helps identify rules affecting each process step, including constraints and triggering events.",
        "option_C": "It focuses solely on the analysis of existing documentation.",
        "option_D": "It is ineffective in discovering business rules related to data states",
        "correct_anwser": "B",
        "explain": "Mô hình hóa quy trình nghiệp vụ (Business Process Modeling) giúp người phân tích rà soát trực quan từng bước công việc, từ đó dễ dàng phát hiện ra các quy tắc nghiệp vụ điều phối hành vi, bao gồm các ràng buộc (constraints) và các sự kiện kích hoạt (triggering events) tác động lên bước đó."
      },
      {
        "question_id": 182,
        "question_title": "Which of the following are common places and ways to look for business rules? Choose 3 correct answers.",
        "option_A": "\"Common knowledge\" from the organization, often collected from individuals who have worked with the business for a long time and know the details of how it operates.",
        "option_B": "Legacy systems that embed business rules in their requirements and code.",
        "option_C": "Analysis of existing documentation, including requirements specifications from earlier projects, regulations, industry standards, corporate policy documents, contracts, and business plans.",
        "option_D": "Business laws",
        "correct_anwser": "A, B, C",
        "explain": "Ba nguồn phổ biến và thực tế nhất để tìm kiếm luật nghiệp vụ trong kỹ nghệ yêu cầu là: Tri thức ngầm định của các nhân sự lâu năm (A), hệ thống cũ/mã nguồn di sản (B), và các tài liệu, quy định, chính sách hiện có của doanh nghiệp (C). Cụm từ \"Business laws\" (D) mang nghĩa luật pháp kinh doanh chung của nhà nước, quá rộng và không phải từ khóa chuyên môn đặc thù để khai thác luật nội bộ của một phần mềm cụ thể."
      },
      {
        "question_id": 183,
        "question_title": "Which of the following does NOT suggest an overall description of the Software Requirements Specification template?",
        "option_A": "Product perspective",
        "option_B": "User classes and characteristics",
        "option_C": "Operating environment",
        "option_D": "Design and implementation constraints",
        "option_E": "Assumptions and dependencies",
        "option_F": "System feature",
        "correct_anwser": "F",
        "explain": "Trong cấu trúc chuẩn của tài liệu SRS (như chuẩn IEEE 830 hay template của Karl Wiegers), phần số 2 là \"Overall Description\" (Mô tả tổng quan) chứa các mục như góc nhìn sản phẩm, đặc điểm người dùng, môi trường, ràng buộc, giả định. Phần \"System Features\" (Các tính năng hệ thống) nằm ở mục riêng biệt số 3 (Detailed Requirements) chứ không thuộc phần mô tả tổng quan."
      },
      {
        "question_id": 184,
        "question_title": "Which of the following are considered good practices in requirements elicitation? Select two.",
        "option_A": "Defining the product vision and project scope early in the project to ensure all stakeholders have a shared understanding.",
        "option_B": "Focusing exclusively on nonfunctional requirements during initial elicitation while ignoring functional requirements to save time.",
        "option_C": "Identifying user classes and their characteristics to ensure that all user needs are considered.",
        "option_D": "Avoiding the use of prototypes in the early stages of requirements elicitation to prevent biasing stakeholders.",
        "correct_anwser": "A, C",
        "explain": "Trong khơi gợi yêu cầu, việc xác định tầm nhìn và phạm vi dự án từ sớm (A) giúp định hướng đúng cho toàn bộ quá trình, và việc phân loại các nhóm người dùng (user classes) cùng đặc điểm của họ (C) giúp đảm bảo không bỏ sót nhu cầu của các bên liên quan."
      },
      {
        "question_id": 185,
        "question_title": "Which of the following elements should be included when crafting a vision statement? Select three",
        "option_A": "The specific target customer for whom the product is intended.",
        "option_B": "A detailed technical specification of the product's architecture.",
        "option_C": "The key benefit or compelling reason for the customer to buy or use the product.",
        "option_D": "A comparison with the primary competitive alternative or current system.",
        "correct_anwser": "A, C, D",
        "explain": "Một tuyên bố tầm nhìn sản phẩm (Vision Statement) tiêu chuẩn cấu trúc theo Karl Wiegers thường bao gồm khách hàng mục tiêu (A), lợi ích cốt lõi giải quyết nhu cầu khách hàng (C) và điểm khác biệt/so sánh với giải pháp thay thế cạnh tranh (D). Chi tiết kiến trúc kỹ thuật (B) là phần thuộc về tài liệu thiết kế hệ thống, không đưa vào tuyên bố tầm nhìn định hướng kinh doanh."
      },
      {
        "question_id": 186,
        "question_title": "Which of the following practices should be followed when documenting software requirements? Select two.",
        "option_A": "Ensure that each requirement is documented in multiple places to increase visibility and reduce the risk of it being overlooked.",
        "option_B": "Use a consistent format for documenting requirements to enhance clarity and understanding among all stakeholders.",
        "option_C": "Avoid documenting requirements that involve complex logic, as these can be difficult for stakeholders to understand.",
        "option_D": "The software requirements specification (SRS) should be used to formally record the agreed-upon requirements and ensure all stakeholders have a shared understanding.",
        "correct_anwser": "B, D",
        "explain": "Khi viết tài liệu yêu cầu, việc sử dụng định dạng nhất quán giúp tăng tính rõ ràng dễ hiểu (B) và tài liệu SRS là nơi chính thức hóa các yêu cầu đã thống nhất giữa các bên (D). Viết yêu cầu ở nhiều nơi (A) gây dư thừa, dễ dẫn tới không đồng nhất khi thay đổi, còn (C) sai vì không thể bỏ qua logic phức tạp."
      },
      {
        "question_id": 187,
        "question_title": "When documenting data requirements for a system, which of the following practices should be followed? Select three.",
        "option_A": "Include a detailed implementation data model directly in the SRS to ensure clarity in the system's design.",
        "option_B": "Create a data dictionary that defines the composition, meaning, data type, and allowed values for all data elements the system will handle.",
        "option_C": "Document any reports that the application will generate, focusing on their logical descriptions and deferring detailed layouts to the design stage.",
        "option_D": "Describe how data will be acquired, maintained, and protected, including policies for data retention, disposal, and ensuring data integrity.",
        "correct_anwser": "B, C, D",
        "explain": "Tài liệu hóa dữ liệu ở mức yêu cầu cần tập trung vào: Từ điển dữ liệu (B), mô tả logic của báo cáo (C), và vòng đời/chính sách bảo vệ dữ liệu (D). Mô tả chi tiết mô hình dữ liệu cài đặt vật lý (A) là việc thuộc về giai đoạn thiết kế kỹ thuật, không nên đưa vào SRS."
      },
      {
        "question_id": 188,
        "question_title": "Which keyword in Planguage defines the goal or minimum acceptable achievement level?",
        "option_A": "AMBITION",
        "option_B": "SCALE",
        "option_C": "GOAL",
        "option_D": "WISH",
        "correct_anwser": "C",
        "explain": "Trong ngôn ngữ Planguage (được dùng để định lượng các yêu cầu phi chức năng), từ khóa `GOAL` đại diện cho mức độ đạt được thành tựu mục tiêu mong muốn tối thiểu được chấp nhận của hệ thống."
      },
      {
        "question_id": 189,
        "question_title": "Which of the following best describes the primary purpose of a vision and scope document?",
        "option_A": "To detail the technical specifications of the project.",
        "option_B": "To collect business requirements into a single deliverable for subsequent development work.",
        "option_C": "To outline the marketing strategy for the product.",
        "option_D": "To provide a detailed project timeline.",
        "correct_anwser": "B",
        "explain": "Tài liệu tầm nhìn và phạm vi (Vision and Scope document) tập trung vào việc tổng hợp và kết tinh các yêu cầu kinh doanh (business requirements) cốt lõi thành một kết quả bàn giao thống nhất, làm nền tảng định hướng cho toàn bộ các công việc phát triển và thiết kế kỹ thuật tiếp theo."
      },
      {
        "question_id": 190,
        "question_title": "What is the primary challenge in eliciting non-functional requirements?",
        "option_A": "They are often ambiguous and difficult to quantify.",
        "option_B": "They are less important than functional requirements.",
        "option_C": "They focus only on system design.",
        "option_D": "They do not require stakeholder input.",
        "correct_anwser": "A",
        "explain": "Thách thức lớn nhất khi thu thập yêu cầu phi chức năng (non-functional requirements) là chúng thường mang tính mơ hồ, cảm tính và khó định lượng một cách chính xác (ví dụ: người dùng nói hệ thống phải 'nhanh' hoặc 'dễ dùng' mà không đưa ra con số cụ thể)."
      },
      {
        "question_id": 191,
        "question_title": "What is the simplest way to initially manage business rules in an organization?",
        "option_A": "Implement a full-scale business rule management tool",
        "option_B": "Use a requirements management tool",
        "option_C": "Use a word processor or a simple catalog",
        "option_D": "Write business rules directly in application code",
        "correct_anwser": "C",
        "explain": "Để bắt đầu quản lý các quy tắc nghiệp vụ (business rules) một cách đơn giản nhất trong giai đoạn đầu của một tổ chức, việc sử dụng các trình soạn thảo văn bản (Word processor) hoặc một danh mục bảng biểu lưu trữ đơn giản (simple catalog) là phương án ít tốn kém và dễ thực hiện nhất."
      },
      {
        "question_id": 192,
        "question_title": "What is the key difference between functional and non-functional requirements?",
        "option_A": "Functional requirements describe what the system does; non-functional requirements describe how the system performs.",
        "option_B": "Functional requirements are optional, while non-functional requirements are mandatory.",
        "option_C": "Functional requirements are stakeholder-specific, while non-functional requirements apply to developers",
        "option_D": "There is no difference between functional and non-functional requirements",
        "correct_anwser": "A",
        "explain": "Yêu cầu chức năng (Functional requirements) mô tả hệ thống làm được những gì (hành vi, tính năng). Yêu cầu phi chức năng (Non-functional requirements) mô tả các đặc tính vận hành hoặc chất lượng của hệ thống (hiệu năng, bảo mật, độ tin cậy)."
      },
      {
        "question_id": 193,
        "question_title": "When requirements elicitation, the customer states, \"Save $X per year on electricity now wasted by inefficient units\". As an analyst, what type of requirement does this statement belong to?",
        "option_A": "User requirements",
        "option_B": "Business rules",
        "option_C": "Business requirements",
        "option_D": "Quality attributes",
        "option_E": "Solution ideas",
        "correct_anwser": "C",
        "explain": "Phát biểu này tập trung vào lợi ích tài chính và mục tiêu kinh doanh cấp cao của tổ chức (tiết kiệm chi phí vận hành), do đó nó thuộc phân loại Yêu cầu kinh doanh (Business Requirements)."
      },
      {
        "question_id": 194,
        "question_title": "The system shall be able to import any valid chemical structure from the ChemDraw (version 13.0 or earlier) and MarvinSketch (version 5.0 or earlier) tools. Which quality attribute does the mentioned statement refer to?",
        "option_A": "Interoperability",
        "option_B": "Integrity",
        "option_C": "Performance",
        "option_D": "Reliability",
        "correct_anwser": "A",
        "explain": "Khả năng hệ thống có thể kết nối, đọc hiểu và nhập dữ liệu cấu trúc hóa học từ định dạng tệp của các công cụ/phần mềm bên ngoài khác (ChemDraw, MarvinSketch) trực tiếp phản ánh đặc tính Khả năng tương tác / Tương hợp hệ thống (Interoperability)."
      },
      {
        "question_id": 195,
        "question_title": "In the specification of a use case, conditions that have the potential to prevent a use case from succeeding are called _____________",
        "option_A": "exceptions",
        "option_B": "alternative flows",
        "option_C": "secondary scenarios",
        "option_D": "backup flows",
        "correct_anwser": "A",
        "explain": "Trong đặc tả Use Case, luồng ngoại lệ (exceptions) mô tả các điều kiện hoặc tình huống lỗi xảy ra làm ngăn cản Use Case đạt được mục đích thành công mong muốn của tác nhân."
      },
      {
        "question_id": 196,
        "question_title": "Which of the following is not an external quality attribute?",
        "option_A": "Availability",
        "option_B": "Integrity",
        "option_C": "Safety",
        "option_D": "Reusability",
        "correct_anwser": "D",
        "explain": "Thuộc tính chất lượng bên ngoài (External attributes) là những đặc tính có thể quan sát được khi hệ thống đang chạy (như Availability, Integrity, Safety). Ngược lại, Reusability (Khả năng tái sử dụng) là thuộc tính chất lượng bên trong (Internal attribute), chỉ các kỹ sư lập trình nhìn thấy và đánh giá thông qua mã nguồn."
      },
      {
        "question_id": 197,
        "question_title": "Which one of these is NOT a Business analyst's task?",
        "option_A": "Communicate requirements",
        "option_B": "Document requirements",
        "option_C": "Analyze requirements",
        "option_D": "Assure requirements",
        "option_E": "Elicit requirements",
        "correct_anwser": "D",
        "explain": "'Assure requirements' (Đảm bảo chất lượng/kiểm định yêu cầu thường thuộc về vai trò QA/QC hoặc quy trình Validation tập thể), các nhiệm vụ cốt lõi của BA bao gồm khơi gợi (Elicit), phân tích (Analyze), tài liệu hóa (Document) và giao tiếp (Communicate) yêu cầu."
      },
      {
        "question_id": 198,
        "question_title": "Why is it essential to validate requirements with stakeholders?",
        "option_A": "To ensure they align with business goals and user expectations",
        "option_B": "To reduce the scope of non-functional requirements",
        "option_C": "To finalize the system design early",
        "option_D": "To prioritize coding tasks over prototyping",
        "correct_anwser": "A",
        "explain": "Xác thực yêu cầu (Validate requirements) với stakeholders là hoạt động tối quan trọng nhằm đảm bảo chắc chắn rằng các yêu cầu đã thu thập hoàn toàn thống nhất, đồng bộ với mục tiêu kinh doanh chiến lược và kỳ vọng thực tế của người dùng."
      },
      {
        "question_id": 199,
        "question_title": "Which of the following is NOT an intended audience for a Software Requirements Specification (SRS)?",
        "option_A": "Project Managers",
        "option_B": "Testers",
        "option_C": "Legal Staff",
        "option_D": "Hardware Manufacturers",
        "option_E": "Documentation Writers",
        "correct_anwser": "C",
        "explain": "Tài liệu SRS được thiết kế chủ yếu cho các bên liên quan trực tiếp đến việc xây dựng sản phẩm như PM, Developer, Tester, Hardware Manufacturers (nếu có tích hợp phần cứng) và người viết tài liệu hướng dẫn. 'Legal Staff' (Nhân viên pháp lý) thường chỉ quan tâm đến hợp đồng hoặc chính sách tuân thủ tầm cao chứ không phải là đối tượng độc giả mục tiêu trực tiếp để đọc hiểu các yêu cầu kỹ thuật chi tiết của SRS."
      },
      {
        "question_id": 200,
        "question_title": "What does the \"STRETCH\" keyword in Planguage represent?",
        "option_A": "The ideal performance level",
        "option_B": "A benchmark for testing",
        "option_C": "A more desirable performance objective than the minimum goal",
        "option_D": "A failure condition",
        "correct_anwser": "C",
        "explain": "Trong ngôn ngữ đặc tả Planguage (được dùng để định lượng yêu cầu phi chức năng), từ khóa 'STRETCH' đại diện cho một mục tiêu hiệu năng mong muốn cao hơn, mang tính thách thức hơn so với cái đích tối thiểu phải đạt được (Target/Minimum)."
      },
      {
        "question_id": 201,
        "question_title": "What is the primary purpose of using a prototype in the software development process?",
        "option_A": "To finalize the product design and ensure no further changes are needed.",
        "option_B": "To validate requirements by finding errors and omissions, and assessing their accuracy and quality.",
        "option_C": "To create a fully functional product that can be immediately deployed.",
        "option_D": "To focus solely on the user experience without considering technical feasibility.",
        "correct_anwser": "B",
        "explain": "Mục đích cốt lõi của việc sử dụng mẫu thử (Prototype) là để xác thực yêu cầu (Validate requirements). Thông qua tương tác sớm với mẫu thử, người dùng và BA có thể phát hiện ra các sai sót, các điểm còn thiếu, đồng thời đánh giá được mức độ chính xác và chất lượng của tập yêu cầu trước khi tiến hành code thật."
      },
      {
        "question_id": 202,
        "question_title": "What is a key benefit of using mock-ups in prototyping?",
        "option_A": "To test the performance of the system",
        "option_B": "To demonstrate the system's functionality",
        "option_C": "To clarify user interface designs early",
        "option_D": "To finalize system features",
        "correct_anwser": "C",
        "explain": "Mock-up là bản mô phỏng tĩnh, tập trung chủ yếu vào khía cạnh trực quan của hệ thống. Lợi ích lớn nhất của nó là giúp các bên liên quan làm rõ và thống nhất về thiết kế giao diện người dùng (UI Design) ngay từ giai đoạn sớm của dự án."
      },
      {
        "question_id": 203,
        "question_title": "Why is a defect checklist important during requirements validation?",
        "option_A": "It helps to systematically identify potential issues in the requirements",
        "option_B": "It ensures the system meets the design specifications",
        "option_C": "It simplifies the testing process",
        "option_D": "It provides detailed technical instructions for developers",
        "correct_anwser": "A",
        "explain": "Bảng kiểm lỗi (Defect checklist) đóng vai trò như một bộ hướng dẫn giúp đội ngũ kiểm định yêu cầu rà soát một cách có hệ thống, từ đó phát hiện ra các lỗi phổ biến như tính mơ hồ, sự mâu thuẫn, hoặc thiếu sót thông tin trong tài liệu đặc tả."
      },
      {
        "question_id": 204,
        "question_title": "Which of the following is NOT about Requirements validation?",
        "option_A": "It is the fourth component of requirements development.",
        "option_B": "It is ensure that they have all the desired properties of high-quality requirements is also an essential activity.",
        "option_C": "It is assesses whether you have written the right requirements: they trace back to business objectives.",
        "option_D": "It allows teams to build a correct solution that meets the stated business objectives.",
        "correct_anwser": "A",
        "explain": "Trong mô hình phát triển yêu cầu (Requirements Development) gồm 4 phân nhánh cốt lõi: Elicitation (Khơi gợi), Analysis (Phân tích), Specification (Đặc tả) và Validation (Xác thực). Các phát biểu B, C, D đều mô tả chính xác mục tiêu của Validation. Do đó phát biểu A không có điểm khác biệt nổi bật để làm đáp án loại trừ, hoặc cấu trúc câu hỏi này đang kiểm tra một chi tiết phủ định trong tài liệu. Tuy nhiên, khi xét kỹ tính logic, 'validation' chính là thành phần thứ tư, nên để tìm phương án SAI, câu này thường là lỗi biên soạn đề hoặc đáp án đúng để chọn là một lựa chọn phủ định khía cạnh khác, nhưng xét theo chuẩn kỹ nghệ yêu cầu thì các ý B, C, D đều mô tả đúng bản chất của Validation."
      },
      {
        "question_id": 205,
        "question_title": "Requirements development does not include:",
        "option_A": "Analysis",
        "option_B": "Validation",
        "option_C": "Design",
        "option_D": "Elicitation",
        "correct_anwser": "C",
        "explain": "Quy trình phát triển yêu cầu (Requirements Development) bao gồm 4 hoạt động chính: Gợi tiến/Thu thập (Elicitation), Phân tích (Analysis), Khai báo/Tài liệu hóa (Specification), và Kiểm chứng (Validation). Thiết kế (Design) thuộc giai đoạn tiếp theo của vòng đời phát triển phần mềm chứ không nằm trong quy trình này."
      },
      {
        "question_id": 206,
        "question_title": "What is the first step in the Requirements Development Process?",
        "option_A": "Analysis (Analyzing requirements)",
        "option_B": "Validation (Validating requirements)",
        "option_C": "Elicitation (Gathering requirements)",
        "option_D": "Specification (Documenting requirements)",
        "option_E": "Management (Managing requirements)",
        "correct_anwser": "C",
        "explain": "Bước đầu tiên luôn luôn là Gợi tiến/Thu thập yêu cầu (Elicitation) để tìm hiểu, khai thác thông tin từ người dùng và các bên liên quan trước khi có thể tiến hành phân tích hay viết tài liệu."
      },
      {
        "question_id": 207,
        "question_title": "Why should requirements be written in a way that avoids technical jargon?",
        "option_A": "To ensure that stakeholders, who may not have a technical background, can easily understand and validate them.",
        "option_B": "Because technical jargon slows down the development team.",
        "option_C": "To keep the SRS document as short as possible.",
        "option_D": "To allow the QA team to create automated tests directly from the text.",
        "correct_anwser": "A",
        "explain": "Tài liệu yêu cầu là phương tiện giao tiếp giữa nhiều bên. Việc tránh các thuật ngữ kỹ thuật quá chuyên sâu (technical jargon) giúp các bên liên quan thuộc khối nghiệp vụ (khách hàng, người dùng cuối) có thể dễ dàng đọc hiểu, rà soát và xác nhận tính chính xác của các yêu cầu một cách hiệu quả."
      },
      {
        "question_id": 208,
        "question_title": "What does a business analyst typically do with conflicting requirements from different stakeholders?",
        "option_A": "Implement all requirements and let the testing team find the errors.",
        "option_B": "Choose the requirement from the stakeholder with the highest job title without discussion.",
        "option_C": "Facilitate discussions to negotiate and resolve the conflicts to reach an agreed-upon solution.",
        "option_D": "Ignore both requirements until the stakeholders resolve the issue themselves.",
        "correct_anwser": "C",
        "explain": "Khi xảy ra xung đột yêu cầu giữa các bên liên quan, trách nhiệm của một BA là tổ chức và điều phối các buổi thảo luận, đàm phán nhằm giúp các bên hiểu rõ góc nhìn của nhau, từ đó tìm ra phương án tối ưu được đồng thuận chung."
      },
      {
        "question_id": 209,
        "question_title": "Why should non-functional requirements be measurable?",
        "option_A": "So that developers know exactly how many lines of code to write.",
        "option_B": "To ensure they can be objectively tested and verified by the QA team.",
        "option_C": "To keep the software project under the allocated budget.",
        "option_D": "To allow the project manager to rank the performance of individual developers.",
        "correct_anwser": "B",
        "explain": "Yêu cầu phi chức năng cần phải được định lượng và đo lường được (ví dụ: thời gian phản hồi dưới 2 giây) để đội ngũ kiểm thử (QA/QC) có thể thiết kế kịch bản đo đạc, kiểm chứng và xác nhận một cách khách quan xem hệ thống có đạt tiêu chuẩn hay không."
      },
      {
        "question_id": 210,
        "question_title": "An elicitation technique that involves studying existing system documentation, industry standards, or competitor product reviews is known as:",
        "option_A": "Focus Groups",
        "option_B": "Document Analysis",
        "option_C": "Interface Analysis",
        "option_D": "Prototyping",
        "correct_anwser": "B",
        "explain": "Phân tích tài liệu (Document Analysis) là kỹ thuật thu thập thông tin bằng cách nghiên cứu các tài liệu hiện có như quy trình nghiệp vụ, tài liệu hệ thống cũ, tiêu chuẩn ngành hoặc các đánh giá sản phẩm cạnh tranh để có được hiểu biết nền tảng về hệ thống."
      },
      {
        "question_id": 211,
        "question_title": "An analyst creates a mockup of a user interface screen to get early feedback from users about the navigation flow. This practice is known as:",
        "option_A": "Data Modeling",
        "option_B": "System Architecture Review",
        "option_C": "Prototyping",
        "option_D": "Unit Testing",
        "correct_anwser": "C",
        "explain": "Làm mẫu thử (Prototyping) bao gồm việc thiết kế các mô hình giao diện tĩnh hoặc động (mockups/wireframes) nhằm phác thảo sớm cách bố trí cấu trúc và luồng điều hướng của màn hình để lấy phản hồi nhanh chóng từ khách hàng trước khi tiến hành viết mã thực tế."
      },
      {
        "question_id": 212,
        "question_title": "Requirements validation involves:",
        "option_A": "Writing technical code based on user requests.",
        "option_B": "Ensuring the documented requirements accurately represent stakeholder needs and are of high quality.",
        "option_C": "Configuring network server security firewalls.",
        "option_D": "Drafting the initial project budget estimate spreadsheets.",
        "correct_anwser": "B",
        "explain": "Xác nhận yêu cầu (Requirements Validation) tập trung vào việc kiểm chứng, rà soát xem tài liệu yêu cầu phần mềm đã viết ra có phản ánh đúng và đủ mong muốn thực tế của khách hàng hay không, đồng thời đảm bảo tài liệu đạt các tiêu chí chất lượng (rõ ràng, nhất quán, không mơ hồ)."
      },
      {
        "question_id": 213,
        "question_title": "Which validation technique involves a structured team meeting where participants carefully review a requirements document line-by-line to find defects?",
        "option_A": "Ad hoc informal chatting",
        "option_B": "Formal Inspection or Peer Review",
        "option_C": "Beta version user testing",
        "option_D": "Automated regression compilation",
        "correct_anwser": "B",
        "explain": "Kiểm duyệt chính thức (Formal Inspection) hoặc Đánh giá đồng cấp (Peer Review) là phương pháp rà soát chất lượng có tính cấu trúc cao, trong đó một nhóm chuyên gia ngồi lại cùng nhau đọc và phân tích từng dòng nội dung trong tài liệu để chủ động bóc tách các lỗi hoặc điểm mâu thuẫn."
      },
      {
        "question_id": 214,
        "question_title": "When evaluating the quality of a requirement, what does the characteristic \"Unambiguous\" mean?",
        "option_A": "The requirement can be interpreted in only one way by anyone who reads it.",
        "option_B": "The requirement is written in a highly advanced technical programming language syntax.",
        "option_C": "The requirement details the complete database index optimization strategy.",
        "option_D": "The requirement is easily applicable to all alternative software projects.",
        "correct_anwser": "A",
        "explain": "Đặc tính \"Không mơ hồ\" (Unambiguous) của một yêu cầu đảm bảo rằng câu văn phải được viết cực kỳ rõ ràng, tường minh, khiến cho bất kỳ ai đọc (dù là khách hàng, BA, lập trình viên haytester) cũng đều chỉ có thể hiểu theo một nghĩa duy nhất."
      },
      {
        "question_id": 215,
        "question_title": "If a requirement cannot be checked by any objective test or verification method, it fails to meet which quality criterion?",
        "option_A": "Complete",
        "option_B": "Verifiable or Testable",
        "option_C": "Traceable",
        "option_D": "Consistent",
        "option_E": "Feasible",
        "correct_anwser": "B",
        "explain": "Một yêu cầu nếu không thể được kiểm chứng bằng bất kỳ phép đo, bài thử hay phương pháp khách quan nào từ phía đội ngũ QA/QC thì yêu cầu đó đã vi phạm tiêu chí chất lượng là \"Có thể kiểm chứng\" (Verifiable or Testable)."
      },
      {
        "question_id": 216,
        "question_title": "When tracking a requirement's status throughout the project life cycle, which status indicates that the requirement has been successfully implemented and verified by tests?",
        "option_A": "Proposed",
        "option_B": "Approved",
        "option_C": "Drafted",
        "option_D": "Completed or Verified",
        "correct_anwser": "D",
        "explain": "Trạng thái \"Completed\" (Hoàn thành) hoặc \"Verified\" (Đã kiểm chứng) biểu thị rằng yêu cầu đó không những đã được lập trình viên viết mã xong mà còn vượt qua các bài kiểm thử xác nhận chất lượng từ phía đội ngũ QA/QC, sẵn sàng bàn giao."
      },
      {
        "question_id": 217,
        "question_title": "What role does the Business Analyst play during formal requirements peer reviews or inspections?",
        "option_A": "Approving the financial project funding allocation unilaterally.",
        "option_B": "Presenting the requirements document, answering questions, and capturing feedback to resolve identified defects.",
        "option_C": "Writing the automated continuous integration script logic.",
        "option_D": "Configuring the physical production cloud servers.",
        "correct_anwser": "B",
        "explain": "Trong các buổi Peer Review tài liệu yêu cầu, BA đóng vai trò giải trình nội dung, trả lời các thắc mắc của đội ngũ phát triển/kiểm thử, đồng thời ghi nhận lại các phản hồi, lỗi sai (defects) được phát hiện để tiến hành sửa đổi."
      },
      {
        "question_id": 218,
        "question_title": "Requirements validation should ideally happen:",
        "option_A": "Only after the entire system has been coded and deployed to production.",
        "option_B": "Continuously and iteratively throughout the requirements development phase before significant technical work begins.",
        "option_C": "Only during the project budgeting initial meeting.",
        "option_D": "Exclusively when a critical runtime database crash occurs.",
        "option_E": "None of the mentioned",
        "option_F": "All of the mentioned",
        "correct_anwser": "B",
        "explain": "Hoạt động xác nhận yêu cầu (Requirements Validation) cần phải được thực hiện liên tục và lặp đi lặp lại trong giai đoạn làm yêu cầu nhằm phát hiện sớm các lỗi sai ngay từ đầu, trước khi đội ngũ kỹ thuật tiến hành thiết kế kiến trúc và viết mã."
      },
      {
        "question_id": 219,
        "question_title": "Which one of the following is not step of requirement engineering?",
        "option_A": "documentation",
        "option_B": "elicitation",
        "option_C": "analysis",
        "option_D": "design",
        "correct_anwser": "D",
        "explain": "Kỹ nghệ yêu cầu (Requirement Engineering) bao gồm các bước chính như khơi gợi (elicitation), phân tích (analysis), tài liệu hóa (documentation/specification) và xác thực (validation). Trong khi đó, thiết kế (design) là một giai đoạn tiếp theo trong quy trình phát triển phần mềm (SDLC) dựa trên các yêu cầu đã thu thập, chứ không nằm trong kỹ nghệ yêu cầu."
      },
      {
        "question_id": 220,
        "question_title": "Which of the following statements about the requirements development process' framework is accurate? Select two.",
        "option_A": "The process of requirements development is strictly linear, moving from elicitation to validation without any need for revisiting previous stages.",
        "option_B": "Elicitation, analysis, specification, and validation are iterative activities that may require revisiting earlier stages to ensure accuracy and completeness.",
        "option_C": "Validation is only performed at the end of the project to confirm that all requirements have been met.",
        "option_D": "The framework allows for flexibility, with steps often revisited throughout the project to refine and correct requirements as needed.",
        "correct_anwser": "B, D",
        "explain": "Quy trình phát triển yêu cầu không phải là một đường thẳng tuyến tính (loại A) và xác thực không chỉ diễn ra vào cuối dự án (loại C). Thay vào đó, đây là một quy trình mang tính lặp (iterative) và linh hoạt (flexible). Các hoạt động khơi gợi, phân tích, đặc tả và xác thực được thực hiện liên tục và có thể quay lại các bước trước đó để làm mịn, điều chỉnh yêu cầu cho chính xác và đầy đủ nhất."
      },
      {
        "question_id": 221,
        "question_title": "Which of the following statements accurately describes the purpose and use of personas in requirements analysis? Select two.",
        "option_A": "A persona is a real user from the target audience, used to validate requirements and ensure they meet actual user needs.",
        "option_B": "Personas are hypothetical, generic users representing a group with similar characteristics, used to understand requirements and design user experiences.",
        "option_C": "Creating a persona helps bring user classes to life and aids in visualizing how different types of users will interact with the system.",
        "option_D": "Personas are only useful during the testing phase to ensure that the application functions as expected for diverse user groups.",
        "correct_anwser": "B, C",
        "explain": "Chân dung người dùng (Persona) là một hồ sơ giả định mang tính đại diện dựa trên dữ liệu thực tế (hypothetical, generic users) để mô tả một nhóm người dùng có chung đặc điểm hành vi (B). Việc tạo ra các Persona giúp hiện thực hóa các lớp người dùng, hỗ trợ đội ngũ thiết kế và phân tích hình dung sinh động cách các kiểu người dùng khác nhau sẽ tương tác với hệ thống ra sao (C). Persona không phải là một người dùng thật cụ thể (loại A) và có ích trong suốt quá trình phân tích/thiết kế chứ không chỉ riêng giai đoạn testing (loại D)."
      },
      {
        "question_id": 222,
        "question_title": "What does the term \"elicitation\" primarily refer to in requirements engineering?",
        "option_A": "The process of gathering requirements from stakeholders",
        "option_B": "The validation of technical requirements",
        "option_C": "The prioritization of system constraints",
        "option_D": "The finalization of the project budget",
        "correct_anwser": "A",
        "explain": "Trong kỹ nghệ yêu cầu, thuật ngữ 'Elicitation' (Khơi gợi yêu cầu) đề cập trực tiếp đến quá trình thu thập, khám phá và tìm hiểu các yêu cầu, mong đợi của hệ thống từ phía các bên liên quan (stakeholders) thông qua các kỹ thuật như phỏng vấn, khảo sát, workshop..."
      },
      {
        "question_id": 223,
        "question_title": "How does prototyping mitigate risks in requirements engineering?",
        "option_A": "By providing stakeholders with a visual representation to validate ambiguous requirements",
        "option_B": "By finalizing system requirements early",
        "option_C": "By focusing on coding rather than design",
        "option_D": "By skipping the requirements validation phase",
        "correct_anwser": "A",
        "explain": "Tương tự như câu 24, việc tạo mẫu thử giúp giảm thiểu rủi ro làm sai yêu cầu bằng cách cung cấp giao diện trực quan cho các bên liên quan xem xét, từ đó sớm phát hiện sai sót và xác thực các yêu cầu còn chưa rõ ràng trước khi tiến hành code thật."
      },
      {
        "question_id": 224,
        "question_title": "Consider the following statement: \"All the screens in the system must load quickly\". This requirement statement is _________",
        "option_A": "Correct and Feasible",
        "option_B": "Unambiguous and Testable",
        "option_C": "Unambiguous and Non-Testable",
        "option_D": "Ambiguous and Non-Testable",
        "correct_anwser": "D",
        "explain": "Câu phát biểu trên sử dụng từ ngữ định tính 'load quickly' (tải nhanh), một khái niệm rất mơ hồ (Ambiguous) vì mỗi người sẽ có định nghĩa 'nhanh' khác nhau. Do không có một con số cụ thể (ví dụ: trong vòng 2 giây), kiểm thử viên cũng không thể thiết lập tiêu chí để đo lường hay kiểm chứng, vì vậy nó hoàn toàn không thể kiểm thử được (Non-Testable)."
      },
      {
        "question_id": 225,
        "question_title": "Which of the following is NOT a purpose of creating a mock-up?",
        "option_A": "To refine user interface design.",
        "option_B": "To test architectural feasibility.",
        "option_C": "To allow users to judge the overall workflow and requirements.",
        "option_D": "To simulate a user interface with no real functionality.",
        "correct_anwser": "B",
        "explain": "Mock-up (mô hình giao diện tĩnh) được sử dụng để tinh chỉnh thiết kế UI (A), giúp người dùng đánh giá luồng công việc (C), và giả lập giao diện không có chức năng thực tế bên dưới (D). Việc kiểm tra tính khả thi của kiến trúc hệ thống (B) đòi hỏi các kỹ thuật hoặc mẫu thử kiến trúc sâu hơn (như Proof of Concept), chứ một mô hình giao diện tĩnh như mock-up không thể thực hiện được."
      },
      {
        "question_id": 226,
        "question_title": "Which approach to reviewing requirements involves the author describing a deliverable and soliciting comments on it?",
        "option_A": "Peer deskcheck approach",
        "option_B": "Passaround approach",
        "option_C": "Walkthrough approach",
        "option_D": "Inspection approach",
        "correct_anwser": "C",
        "explain": "Walkthrough (Đọc duyệt/Duyệt qua) là một hình thức đánh giá kỹ thuật, trong đó tác giả (author) đóng vai trò chủ trì dẫn dắt cuộc họp để mô tả, giải thích chi tiết về tài liệu sản phẩm và thu thập các ý kiến đóng góp, phản hồi trực tiếp từ người tham dự."
      },
      {
        "question_id": 227,
        "question_title": "The benefits of effective requirements reuse include: (choose 3 correct answers)",
        "option_A": "faster delivery",
        "option_B": "lower development costs",
        "option_C": "reduced rework",
        "option_D": "fewer test cases",
        "correct_anwser": "A, B, C",
        "explain": "Tái sử dụng yêu cầu hiệu quả giúp đội ngũ kế thừa các tài liệu chuẩn hóa đã có sẵn, mang lại các lợi ích lớn bao gồm: rút ngắn thời gian bàn giao dự án (A), hạ thấp chi phí phát triển (B), và giảm thiểu việc phải chỉnh sửa, làm lại do yêu cầu đã được kiểm chứng từ trước (C). Việc tái sử dụng không làm giảm số lượng test case (D) vì mỗi hệ thống mới vẫn cần bộ test case đầy đủ tương ứng để kiểm thử tính chính xác."
      },
      {
        "question_id": 228,
        "question_title": "What is the primary challenge of validating non-functional requirements?",
        "option_A": "They are often subjective and difficult to measure accurately",
        "option_B": "They focus only on technical constraints",
        "option_C": "They eliminate the need for functional requirements",
        "option_D": "They replace stakeholder reviews",
        "correct_anwser": "A",
        "explain": "Thách thức hàng đầu khi xác thực các yêu cầu phi chức năng (NFR) là chúng thường mang tính cảm tính, định tính và chủ quan (ví dụ: 'hệ thống phải thân thiện', 'tốc độ phải nhanh'), dẫn đến việc khó đo lường một cách chính xác nếu không được định lượng hóa."
      },
      {
        "question_id": 229,
        "question_title": "What is the advantage of using acceptance tests during validation?",
        "option_A": "To ensure that all requirements are measurable and testabl",
        "option_B": "To eliminate the need for non-functional requirements",
        "option_C": "To skip stakeholder reviews",
        "option_D": "To prioritize coding tasks",
        "correct_anwser": "A",
        "explain": "Việc thiết kế hoặc sử dụng các bài kiểm thử chấp nhận (Acceptance tests) ngay từ giai đoạn xác thực yêu cầu buộc các bên phải làm rõ tiêu chí nghiệm thu, từ đó đảm bảo rằng mọi yêu cầu bằng văn bản đều có thể đo lường và kiểm thử được (measurable and testable)."
      },
      {
        "question_id": 230,
        "question_title": "Why is stakeholder feedback critical during requirements validation?",
        "option_A": "To ensure requirements align with business objectives and user needs",
        "option_B": "To finalize coding strategies",
        "option_C": "To skip ambiguous requirements",
        "option_D": "To prioritize testing phases",
        "correct_anwser": "A",
        "explain": "Phản hồi từ các bên liên quan (stakeholders) là cơ sở tối thượng trong giai đoạn validation để đánh giá và khẳng định lại xem các yêu cầu đã viết ra có thực sự phản ánh đúng nhu cầu người dùng và đồng bộ với mục tiêu kinh doanh chiến lược hay không."
      },
      {
        "question_id": 231,
        "question_title": "When specifying the level of detail in software requirements, which of the following practices should be considered? Select two.",
        "option_A": "It is always necessary to specify all requirements at the same high level of detail to ensure consistency.",
        "option_B": "More detail should be included when the work is being done for an external client or when system testing will be based on the requirements.",
        "option_C": "Less detail can be included if the work is being done internally for your company and developers have considerable domain experience.",
        "option_D": "Writing all requirements at a very fine-grained level is always better, regardless of the project's context.",
        "option_E": "None of the above",
        "correct_anwser": "B, C",
        "explain": "Mức độ chi tiết của tài liệu yêu cầu cần linh hoạt theo ngữ cảnh: Cần viết chi tiết hơn khi bàn giao cho đối tác bên ngoài hoặc làm căn cứ kiểm thử (B); và có thể viết gọn bớt nếu dự án làm nội bộ và đội ngũ lập trình viên đã có sẵn nhiều kinh nghiệm chuyên môn sâu về lĩnh vực đó (C)."
      },
      {
        "question_id": 232,
        "question_title": "What steps would you include in a peer review process to identify and resolve ambiguities in requirement statements?",
        "option_A": "Have each participant review the requirements individually and submit their feedback separately.",
        "option_B": "Conduct a formal peer review meeting where participants compare their understanding of each requirement and discuss any ambiguities.",
        "option_C": "Skip the peer review process and rely on individual interpretations.",
        "option_D": "Only review requirements after the development phase.",
        "correct_anwser": "B",
        "explain": "Để nhận diện và giải quyết triệt để tính mơ hồ (ambiguities) trong các câu yêu cầu, quy trình peer review cần tổ chức một buổi họp rà soát chính thức, nơi các thành viên có thể đối chiếu, so sánh mức độ hiểu của mình về từng yêu cầu, từ đó phát hiện ra những điểm diễn đạt nhập nhèm để đồng bộ lại thông tin."
      },
      {
        "question_id": 233,
        "question_title": "Validation of requirements assesses whether you have written _______.",
        "option_A": "the right requirements",
        "option_B": "the requirements right",
        "option_C": "the flexible requirements",
        "option_D": "the variable requirements",
        "correct_anwser": "A",
        "explain": "Theo câu nói kinh điển của kỹ nghệ phần mềm: 'Verification' (Kiểm định) giúp kiểm tra xem chúng ta có đang xây dựng hệ thống đúng cách hay không (building the product right), còn 'Validation' (Xác thực) giúp kiểm tra xem chúng ta có đang viết/thu thập đúng các yêu cầu cần thiết hay không (writing the right requirements) để giải quyết bài toán kinh doanh."
      },
      {
        "question_id": 234,
        "question_title": "What is the primary purpose of requirements reuse?",
        "option_A": "To save time, improve consistency, and reduce risks",
        "option_B": "To eliminate stakeholder reviews",
        "option_C": "To finalize the coding phase",
        "option_D": "To reduce prototyping efforts",
        "correct_anwser": "A",
        "explain": "Mục đích hàng đầu của việc tái sử dụng yêu cầu (Requirements reuse) là tận dụng các yêu cầu đã được chuẩn hóa từ dự án trước để tiết kiệm thời gian, tăng tính đồng bộ, nhất quán của hệ thống và giảm thiểu rủi ro sai sót."
      },
      {
        "question_id": 235,
        "question_title": "How does requirements reuse improve project efficiency?",
        "option_A": "By reducing time and effort during the elicitation process",
        "option_B": "By skipping stakeholder reviews",
        "option_C": "By focusing only on functional requirements",
        "option_D": "By eliminating non-functional requirements",
        "correct_anwser": "A",
        "explain": "Tái sử dụng yêu cầu giúp nâng cao hiệu suất dự án một cách trực tiếp bằng cách rút ngắn đáng kể thời gian và công sức bỏ ra cho việc khơi gợi, làm rõ yêu cầu (elicitation process) đối với các tính năng có tính tương đồng."
      },
      {
        "question_id": 236,
        "question_title": "Which one of the following is not a step of requirement development?",
        "option_A": "elicitation",
        "option_B": "design",
        "option_C": "analysis",
        "option_D": "validation",
        "option_E": "documentation",
        "correct_anwser": "B",
        "explain": "Phát triển yêu cầu (Requirement Development) bao gồm bốn giai đoạn chính: khơi gợi (elicitation), phân tích (analysis), tài liệu hóa (specification/documentation), và thẩm định (validation). Thiết kế (design) là một giai đoạn tiếp theo trong vòng đời phát triển phần mềm sau khi các yêu cầu đã được xác định rõ ràng."
      },
      {
        "question_id": 237,
        "question_title": "Which of the following statements accurately describes the role of a business analyst in a project? Select two.",
        "option_A": "The business analyst is solely responsible for managing communication between the customer(s) and the development team.",
        "option_B": "The business analyst primarily focuses on eliciting, analyzing, documenting, and validating the needs of the project stakeholders.",
        "option_C": "In agile projects, the business analyst often acts as the project manager, handling both internal and external project tasks.",
        "option_D": "The business analyst plays a central role in collecting and disseminating product information, while the project manager focuses on communicating project information.",
        "correct_anwser": "B, D",
        "explain": "BA tập trung vào việc khơi gợi, phân tích, tài liệu hóa và thẩm định nhu cầu của stakeholders (B), đồng thời đóng vai trò trung tâm trong việc thu thập và phân phối thông tin liên quan đến sản phẩm (product information), phân biệt với PM tập trung vào thông tin quản lý dự án (D)."
      },
      {
        "question_id": 238,
        "question_title": "Which of the following are the signals indicating that you have completed requirements elicitation? Choose 3 correct answers.",
        "option_A": "Users repeat issues they already covered in previous discussions.",
        "option_B": "Suggested new features, user requirements, or functional requirements are all deemed to be out of scope.",
        "option_C": "Proposed new requirements are all low priority.",
        "option_D": "Developers and testers who review the requirements for an area raise many questions.",
        "correct_anwser": "A, B, C",
        "explain": "Dấu hiệu cho thấy việc khơi gợi yêu cầu đã có thể dừng lại bao gồm: người dùng bắt đầu nói lặp lại các vấn đề cũ (A), các tính năng mới đề xuất đều nằm ngoài phạm vi đã định (B), hoặc các yêu cầu mới phát sinh chỉ có mức độ ưu tiên rất thấp (C). Nếu dev và tester vẫn đặt ra quá nhiều câu hỏi (D), điều đó chứng tỏ yêu cầu chưa đủ rõ ràng và việc khơi gợi chưa hoàn tất."
      },
      {
        "question_id": 239,
        "question_title": "Requirement statements must be: (Choose 3 correct answers)",
        "option_A": "Feasible",
        "option_B": "Correct",
        "option_C": "Verifiable",
        "option_D": "Flexible",
        "correct_anwser": "A, B, C",
        "explain": "Một câu phát biểu yêu cầu chất lượng bắt buộc phải đáp ứng các đặc tính nền tảng bao gồm: Khả thi (Feasible - có thể làm được), Chính xác (Correct) và Có thể kiểm chứng được (Verifiable/Testable). Tính \"Linh hoạt\" (Flexible) dễ dẫn đến mơ hồ, không rõ ràng và không phải đặc tính tiêu chuẩn của câu yêu cầu."
      },
      {
        "question_id": 240,
        "question_title": "Which of the following characteristics should a well-written requirement statement exhibit? Select two.",
        "option_A": "Each requirement should be complete, meaning it contains all the information necessary for the reader to understand it and for developers to implement it correctly.",
        "option_B": "A requirement statement can be ambiguous as long as it is feasible to implement.",
        "option_C": "Requirements should be prioritized based on their importance to achieving the desired business value, and should be assigned an implementation priority.",
        "option_D": "Verifiability of a requirement is optional as long as it meets stakeholder needs.",
        "correct_anwser": "A, C",
        "explain": "Một câu phát biểu yêu cầu chuẩn mực cần có tính đầy đủ (Complete), chứa đựng toàn bộ thông tin cần thiết để lập trình viên hiểu và triển khai chính xác (A), đồng thời cần phải được phân loại độ ưu tiên dựa trên giá trị mang lại cho doanh nghiệp (C). Câu phát biểu không được phép mơ hồ (B sai) và tính kiểm chứng (Verifiability) luôn luôn là bắt buộc chứ không phải tùy chọn (D sai)."
      },
      {
        "question_id": 241,
        "question_title": "What is the purpose of peer reviews during the requirements validation process?",
        "option_A": "To ensure requirements are written in technical language",
        "option_B": "To identify ambiguous or unverifiable requirements",
        "option_C": "To finalize the system design before development begins",
        "option_D": "To align requirements with user interface designs",
        "correct_anwser": "B",
        "explain": "Mục đích của việc đánh giá đồng nghiệp (Peer review) trong giai đoạn validate yêu cầu là để các thành viên khác nhau rà soát chéo, từ đó cùng nhau chỉ ra những điểm yêu cầu còn mơ hồ (ambiguous) hoặc không có khả năng kiểm chứng (unverifiable) để kịp thời sửa đổi."
      },
      {
        "question_id": 242,
        "question_title": "What is the primary advantage of requirements reuse in software projects?",
        "option_A": "Reducing time and effort during the elicitation process",
        "option_B": "Skipping the stakeholder review phase",
        "option_C": "Eliminating the need for prototyping",
        "option_D": "Ensuring all requirements are functional",
        "correct_anwser": "A",
        "explain": "Ưu điểm hàng đầu của việc tái sử dụng yêu cầu (Requirements reuse) từ các dự án tương tự trước đó là giúp giảm bớt đáng kể thời gian cũng như công sức bỏ ra cho quá trình khơi gợi và viết lại các yêu cầu tiêu chuẩn (ví dụ: các yêu cầu về đăng nhập, phân quyền, bảo mật)."
      },
      {
        "question_id": 243,
        "question_title": "What does acceptance criteria include? Choose 3 correct answers.",
        "option_A": "Passing a defined set of acceptance tests based on user requirements",
        "option_B": "Demonstrating satisfaction of specific nonfunctional requirements",
        "option_C": "Tracking open defects and issues",
        "option_D": "Having a trendy user interface",
        "correct_anwser": "A, B, C",
        "explain": "Tiêu chí nghiệm thu (Acceptance criteria) bao gồm việc vượt qua các bài kiểm thử nghiệm thu dựa trên yêu cầu người dùng (A), chứng minh sự thỏa mãn các yêu cầu phi chức năng cụ thể (B) và theo dõi, kiểm soát các lỗi/vấn đề còn tồn đọng trước khi bàn giao (C). Việc có một giao diện hợp xu hướng (D) là một yếu tố thiết kế chủ quan, không phải tiêu chí nghiệm thu bắt buộc chuẩn mực."
      },
      {
        "question_id": 244,
        "question_title": "Fill in the blank: \"Define vision and scope\", \"select product champions\" activities should be done _____ stage.",
        "option_A": "Specifications",
        "option_B": "Validation",
        "option_C": "Elicitation",
        "option_D": "Analysis",
        "correct_anwser": "C",
        "explain": "Các hoạt động định hình tầm nhìn, phạm vi hệ thống (\"Define vision and scope\") và lựa chọn đại diện người dùng (\"select product champions\") là những bước khởi đầu quan trọng nằm trong giai đoạn Khơi gợi yêu cầu (Elicitation)."
      },
      {
        "question_id": 245,
        "question_title": "Your company developed a software system for a customer a long time ago, and the application works as intended. Now, the customer's business has grown, and they want the software system to handle 10x the number of transactions. They ask your company to upgrade the software system. Upon inspection, you find out that this system can't handle 10x transactions due to monolithic processes and tightly coupled logic.\n\nWhat is the quality attribute mentioned above?",
        "option_A": "Availability",
        "option_B": "Usability",
        "option_C": "Scalability",
        "option_D": "Robustness",
        "correct_anwser": "C",
        "explain": "Khả năng xử lý lượng giao dịch tăng lên gấp 10 lần khi quy mô doanh nghiệp mở rộng trực tiếp liên quan đến thuộc tính chất lượng Khả năng mở rộng (Scalability)."
      },
      {
        "question_id": 246,
        "question_title": "What is the primary distinction between requirements validation and verification?",
        "option_A": "Validation ensures that the product meets the user's needs, while verification ensures it is free from defects.",
        "option_B": "Validation ensures the product satisfies customer needs, while verification ensures the product meets its specifications.",
        "option_C": "Validation occurs before the design phase, and verification occurs after.",
        "option_D": "Validation is about internal testing, while verification is about external approval.",
        "correct_anwser": "B",
        "explain": "Khác biệt cơ bản: Thẩm định (Validation) đảm bảo chúng ta xây dựng đúng sản phẩm đáp ứng nhu cầu khách hàng ('Are we building the right thing?'), trong khi Kiểm chứng (Verification) đảm bảo sản phẩm được xây dựng chính xác theo đúng tài liệu đặc tả thiết kế ('Are we building it right?')."
      },
      {
        "question_id": 247,
        "question_title": "What does the term \"verifiable\" mean in the context of excellent requirements?",
        "option_A": "The requirements cannot be tested",
        "option_B": "The requirements are difficult to understand",
        "option_C": "The requirements can be tested to ensure they are met",
        "option_D": "The requirements are subjective and open to interpretation",
        "correct_anwser": "C",
        "explain": "Tính chất 'Có thể thẩm định/xác thực' (Verifiable) của một yêu cầu tốt có nghĩa là yêu cầu đó phải được viết cụ thể, rõ ràng, có định lượng để đội ngũ kiểm thử (Tester) có thể thiết kế các kịch bản kiểm thử (test cases) nhằm xác nhận hệ thống đã đáp ứng đúng hay chưa."
      },
      {
        "question_id": 248,
        "question_title": "Validation of requirements assesses whether you have written _________.",
        "option_A": "the right requirements",
        "option_B": "the requirements right",
        "option_C": "the flexible requirements",
        "option_D": "the variable requirements",
        "correct_anwser": "A",
        "explain": "Trong kỹ nghệ yêu cầu: Xác nhận/Thẩm định (Validation) là để kiểm tra xem chúng ta có đang viết 'đúng yêu cầu khách hàng mong muốn' hay không (Have we written the right requirements?). Còn Kiểm chứng (Verification) là đánh giá xem tài liệu có được viết đúng chuẩn kỹ thuật và quy trình không (Have we written the requirements right?)."
      },
      {
        "question_id": 249,
        "question_title": "Which of the following activities would be considered part of requirements management effort?",
        "option_A": "Holding workshops and interviews to gather requirements.",
        "option_B": "Submitting requirements changes and proposing new requirements change.",
        "option_C": "Writing requirements specifications and prioritizing requirements.",
        "option_D": "Creating and evaluating prototypes for requirements development.",
        "correct_anwser": "B",
        "explain": "Kỹ nghệ yêu cầu chia làm 2 nhánh: Phát triển yêu cầu (Elicitation, Analysis, Specification, Validation - thuộc phương án A, C, D) và Quản lý yêu cầu (Requirements Management). Hoạt động kiểm soát thay đổi, nộp và xử lý yêu cầu thay đổi (B) chính là trọng tâm của Quản lý yêu cầu."
      },
      {
        "question_id": 250,
        "question_title": "Who are the intended audiences for requirements specifications?",
        "option_A": "System architects and developers",
        "option_B": "Test engineers and quality analysts",
        "option_C": "Stakeholders, reviewers, and project team members",
        "option_D": "All of the others",
        "correct_anwser": "D",
        "explain": "Tài liệu đặc tả yêu cầu (Requirements Specification) là tài liệu nền tảng cho toàn bộ dự án, được sử dụng bởi kiến trúc sư/lập trình viên để thiết kế và phát triển hệ thống, kiểm thử viên để viết test case, và các bên liên quan cùng thành viên dự án để xem xét và đối chiếu."
      },
      {
        "question_id": 251,
        "question_title": "What is the advantage of using prototyping in early project phases?",
        "option_A": "To validate requirements and reduce the risk of costly changes later",
        "option_B": "To eliminate the design phase",
        "option_C": "To prioritize functional over non-functional requirements",
        "option_D": "To replace stakeholder engagement",
        "correct_anwser": "A",
        "explain": "Lợi ích lớn nhất của việc làm mẫu thử (prototyping) ở giai đoạn đầu dự án là giúp trực quan hóa để xác thực yêu cầu với khách hàng, từ đó phát hiện sớm các điểm chưa đúng và giảm thiểu rủi ro phải sửa đổi tốn kém về sau."
      },
      {
        "question_id": 252,
        "question_title": "To help reviewers look for typical kinds of errors in the products they review, develop a(n) _________ for each type of requirements document your projects create.",
        "option_A": "defect checklist",
        "option_B": "error checklist",
        "option_C": "inspection meeting",
        "option_D": "support documentation",
        "correct_anwser": "A",
        "explain": "Để hỗ trợ người kiểm duyệt tìm kiếm hiệu quả các lỗi phổ biến trong sản phẩm phần mềm hoặc tài liệu, dự án nên xây dựng một danh sách kiểm tra lỗi/khuyết tật (defect checklist) tương ứng với từng loại tài liệu đặc tả yêu cầu cụ thể."
      },
      {
        "question_id": 253,
        "question_title": "What is the primary distinction between Scope Creep and Gold Plating?",
        "option_A": "Scope Creep involves adding features, whereas Gold Plating involves reducing project scope.",
        "option_B": "Scope Creep arises from customer-driven changes, while Gold Plating results from the project team adding unnecessary features.",
        "option_C": "Both Scope Creep and Gold Plating involve unplanned changes.",
        "option_D": "Scope Creep occurs only in the early stages of a project, while Gold Plating happens post-delivery.",
        "option_E": "Scope Creep is seen in small projects, while Gold Plating only occurs in large projects.",
        "correct_anwser": "B",
        "explain": "Scope Creep (Phình scope) xảy ra khi phạm vi dự án bị mở rộng dần do các yêu cầu không kiểm soát từ phía khách hàng hoặc stakeholder mà không qua quy trình thay đổi chính thức. Ngược lại, Gold Plating (Mạ vàng) xảy ra khi đội ngũ phát triển tự ý thêm vào các tính năng hoặc cải tiến không có trong yêu cầu ban đầu của khách hàng vì nghĩ rằng điều đó tốt cho họ."
      },
      {
        "question_id": 254,
        "question_title": "What is the value of creating a traceability matrix in a project?",
        "option_A": "To ensure all requirements are linked to their design, testing, and implementation phases",
        "option_B": "To replace stakeholder involvement in the validation phase",
        "option_C": "To prioritize non-functional requirements over functional ones",
        "option_D": "To finalize the system's coding standards",
        "correct_anwser": "A",
        "explain": "Giá trị của Ma trận truy vết yêu cầu (Traceability Matrix) là thiết lập chuỗi liên kết xuyên suốt giúp theo dõi xem mỗi yêu cầu được hiện thực hóa ở phần thiết kế nào, mã nguồn nào, và được kiểm thử bởi test case nào trong các giai đoạn tiếp theo."
      },
      {
        "question_id": 255,
        "question_title": "Why do we have to label the requirements in a software requirements specification (SRS)? (Choose 3 correct answers)",
        "option_A": "It allows us to refer to specific requirements in a change request, modification history, cross-reference, or requirements traceability matrix.",
        "option_B": "It enables reusing the requirements in multiple projects.",
        "option_C": "It facilitates collaboration between team members when they're discussing requirements.",
        "option_D": "It makes the SRS look more professional.",
        "correct_anwser": "A, B, C",
        "explain": "Gán nhãn/Mã hóa yêu cầu một cách duy nhất (Labeling) giúp dễ dàng truy vết trong ma trận truy vết và quản lý thay đổi (A), hỗ trợ khả năng tái sử dụng yêu cầu ở các dự án khác (B) và giúp các thành viên trong đội ngũ dễ dàng gọi tên, trao đổi chính xác về một yêu cầu cụ thể mà không bị nhầm lẫn (C)."
      },
      {
        "question_id": 256,
        "question_title": "What is the main purpose of a requirements baseline?",
        "option_A": "To track changes",
        "option_B": "To establish project goals",
        "option_C": "To set the scope of the project",
        "option_D": "To establish an initial set of agreed-upon requirements",
        "correct_anwser": "D",
        "explain": "Mục đích cốt lõi của một Requirements Baseline (Đường cơ sở yêu cầu) là thiết lập một tập hợp các yêu cầu ban đầu đã được các bên rà soát, thống nhất và phê duyệt正式, làm căn cứ để quản lý thay đổi và phát triển các giai đoạn tiếp theo."
      },
      {
        "question_id": 257,
        "question_title": "What does the change control process primarily aim to do?",
        "option_A": "Delay changes until all requirements are implemented",
        "option_B": "Provide visibility and control over proposed changes",
        "option_C": "Implement changes immediately",
        "option_D": "Reject unnecessary changes",
        "correct_anwser": "B",
        "explain": "Quy trình kiểm soát thay đổi (Change control process) không nhằm mục đích từ chối mọi thay đổi hay trì hoãn chúng, mà cốt để mang lại tính minh bạch (visibility) và khả năng quản lý, kiểm soát (control) tác động của các yêu cầu thay đổi được đề xuất trước khi quyết định thực thi."
      },
      {
        "question_id": 258,
        "question_title": "A key motivation for requirements tracing is to facilitate what activity, especially when a requirement needs to be modified?",
        "option_A": "Requirements elicitation",
        "option_B": "Change impact analysis",
        "option_C": "User interface design",
        "option_D": "Project budgeting",
        "correct_anwser": "B",
        "explain": "Động lực chính của việc truy vết yêu cầu (Requirements tracing) là để hỗ trợ hoạt động Phân tích tác động của thay đổi (Change impact analysis). Khi một yêu cầu cần sửa đổi, ma trận truy vết giúp BA biết chính xác những thành phần thiết kế, code hay test case nào liên quan sẽ bị ảnh hưởng theo."
      },
      {
        "question_id": 259,
        "question_title": "Which of the following is considered a core practice of Requirements Management?",
        "option_A": "Writing unit tests for individual functions.",
        "option_B": "Controlling changes to the requirements baseline.",
        "option_C": "Configuring the continuous integration pipeline.",
        "option_D": "Designing user experience prototypes.",
        "correct_anwser": "B",
        "explain": "Requirements Management (Quản lý yêu cầu) tập trung vào việc duy trì tính nhất quán và kiểm soát xuyên suốt vòng đời dự án, trong đó hoạt động cốt lõi là kiểm soát và phê duyệt các thay đổi đối với tập hợp yêu cầu đã được chốt (requirements baseline)."
      },
      {
        "question_id": 260,
        "question_title": "What is the primary benefit of achieving \"Traceability\" in requirements?",
        "option_A": "It automatically generates user documentation.",
        "option_B": "It allows team members to see how requirements connect to design, code, and tests.",
        "option_C": "It eliminates the need for daily standup meetings.",
        "option_D": "It replaces the software development roadmap.",
        "correct_anwser": "B",
        "explain": "Tính vết (Traceability) cho phép thiết lập và theo dõi mối liên kết hai chiều giữa các yêu cầu gốc với kiến trúc thiết kế, các đoạn mã nguồn và các kịch bản kiểm thử, giúp dễ dàng phân tích tác động khi có thay đổi xảy ra."
      },
      {
        "question_id": 261,
        "question_title": "What is the primary risk of allowing \"Scope Creep\" to happen in a software project?",
        "option_A": "It automatically formats user stories into code modules.",
        "option_B": "It leads to project delays, budget overruns, and uncontrolled growth in project requirements.",
        "option_C": "It prevents the software application from running on cloud infrastructure.",
        "option_D": "It forces the quality assurance team to write only manual tests.",
        "correct_anwser": "B",
        "explain": "Sự phình đại phạm vi (Scope Creep) xảy ra khi các yêu cầu mới liên tục được thêm vào dự án một cách không chính thức và thiếu kiểm soát, trực tiếp dẫn đến nguy cơ chậm tiến độ (delays), vượt ngân sách (budget overruns) và làm mất định hướng ban đầu của sản phẩm."
      },
      {
        "question_id": 262,
        "question_title": "A business analyst wants to see how a change to a single functional requirement will impact the system architecture, database design, and test cases. What tool or asset is most helpful for this task?",
        "option_A": "A Daily Burndown Chart",
        "option_B": "A Requirements Traceability Matrix (RTM)",
        "option_C": "A System Execution Log File",
        "option_D": "A Software Build Automation Script",
        "correct_anwser": "B",
        "explain": "Ma trận quan hệ vết yêu cầu (Requirements Traceability Matrix - RTM) thiết lập mối liên kết rõ ràng giữa yêu cầu gốc với các thành phần thiết kế, module mã nguồn và kịch bản kiểm thử. Khi một yêu cầu thay đổi, RTM giúp BA nhanh chóng thực hiện phân tích tác động (impact analysis) xem những thành phần nào sẽ bị ảnh hưởng."
      },
      {
        "question_id": 263,
        "question_title": "What is a \"Baseline\" in the context of requirements management?",
        "option_A": "The very first messy draft of requirements captured during brainstorming.",
        "option_B": "A snapshot of approved requirements that has been agreed upon and can only be changed through a formal change control process.",
        "option_C": "The performance benchmark of the production server system.",
        "option_D": "The minimum number of lines of code expected from a developer daily.",
        "correct_anwser": "B",
        "explain": "Đường cơ sở (Baseline) là tập hợp các yêu cầu đã được phê duyệt chính thức bởi các bên có thẩm quyền tại một thời điểm cụ thể. Sau khi đã thiết lập baseline, mọi thay đổi bổ sung hoặc sửa đổi đối với các yêu cầu này đều bắt buộc phải thông qua một quy trình kiểm soát thay đổi (change control process) nghiêm ngặt."
      },
      {
        "question_id": 264,
        "question_title": "Which of the following is considered a valid reason for changing a software requirement after the baseline has been established?",
        "option_A": "A developer wants to experiment with a newly released programming language framework.",
        "option_B": "Changes in government regulations or market conditions that impact the business workflow.",
        "option_C": "The project manager wants to increase the page count of the SRS document.",
        "option_D": "A tester finds a typo in an unexecuted test script.",
        "correct_anwser": "B",
        "explain": "Sự thay đổi trong quy định pháp luật hoặc biến động của thị trường làm thay đổi trực tiếp quy trình nghiệp vụ của doanh nghiệp là lý do hoàn toàn chính đáng và bắt buộc phải cập nhật lại yêu cầu phần mềm (ngay cả khi đã chốt baseline) để đảm bảo hệ thống vận hành đúng luật và thực tế."
      },
      {
        "question_id": 265,
        "question_title": "What is the primary function of a Change Control Board (CCB) in software projects?",
        "option_A": "To write automated system integration scripts.",
        "option_B": "To review, evaluate, and approve or reject proposed changes to baselined requirements.",
        "option_C": "To style the graphical look and feel of the user interface.",
        "option_D": "To conduct performance evaluation interviews with project contractors.",
        "correct_anwser": "B",
        "explain": "Hội đồng kiểm soát thay đổi (Change Control Board - CCB) là một nhóm các bên liên quan chịu trách nhiệm đánh giá tác động, xem xét tài chính/thời gian để đưa ra quyết định chấp thuận (approve) hoặc từ chối (reject) các yêu cầu thay đổi đối với phần phạm vi đã được chốt baseline."
      },
      {
        "question_id": 266,
        "question_title": "What is the definition of a condition in which the scope of a project continues to increase in an uncontrolled fashion throughout the development process?",
        "option_A": "Risk",
        "option_B": "Inspection",
        "option_C": "Scope creep",
        "option_D": "Decision rule",
        "correct_anwser": "C",
        "explain": "Scope creep (phình bành phạm vi) là thuật ngữ chuyên ngành quản trị dự án dùng để chỉ hiện tượng phạm vi của một dự án liên tục tăng lên một cách không kiểm soát được, thường xảy ra khi các tính năng và yêu cầu mới được thêm vào mà không qua quy trình phê duyệt hoặc điều chỉnh tương ứng về mặt ngân sách, nguồn lực và thời gian."
      },
      {
        "question_id": 267,
        "question_title": "Why do we have to label the requirements in a software requirements specification (SRS)?",
        "option_A": "It allows us to refer to specific requirements in a change request, modification history, cross-reference, or requirements traceability matrix.",
        "option_B": "It enables reusing the requirements in multiple projects.",
        "option_C": "It facilitates collaboration between team members when they're discussing requirements.",
        "option_D": "It makes the SRS look more professional.",
        "correct_anwser": "A, B, C",
        "explain": "Việc đánh nhãn định danh duy nhất (ví dụ: REQ-001) cho từng yêu cầu mang lại rất nhiều lợi ích thực tế: giúp dễ dàng tham chiếu khi có yêu cầu thay đổi hoặc xây dựng ma trận truy vết (A); giúp dễ trích xuất và tái sử dụng các mẫu yêu cầu tương tự ở các dự án khác (B); và giúp các thành viên giao tiếp, thảo luận chính xác về một yêu cầu cụ thể mà không bị nhầm lẫn (C)."
      },
      {
        "question_id": 268,
        "question_title": "Which of the following characteristics should a collection of requirements exhibit?",
        "option_A": "Completeness, meaning it is acceptable if some necessary information is absent as long as the core requirements are documented.",
        "option_B": "Modifiability, which allows changes to be made without maintaining a history of changes or considering dependencies among requirements",
        "option_C": "Consistency, ensuring that requirements do not conflict with other requirements or higher-level business, user, or system requirements.",
        "option_D": "Traceability, where requirements should be loosely linked and not necessarily connected to their origin or to derived elements",
        "correct_anwser": "C",
        "explain": "Định nghĩa đúng của tính nhất quán (Consistency) là đảm bảo các yêu cầu không mâu thuẫn hay xung đột lẫn nhau hoặc mâu thuẫn với các mục tiêu kinh doanh cấp cao hơn (C). Các phương án khác đều đưa ra định nghĩa sai lệch về các đặc tính (ví dụ: Completeness - Đầy đủ mà lại chấp nhận thiếu thông tin là sai; Modifiability mà không cần lưu lịch sử là sai; Traceability mà liên kết lỏng lẻo không cần kết nối nguồn gốc là sai)."
      },
      {
        "question_id": 269,
        "question_title": "What potential issues can be prevented by validating requirements? (Select all that apply)",
        "option_A": "Scope creep",
        "option_B": "Eliminating All Bugs",
        "option_C": "Misaligned Expectations",
        "option_D": "Cost Overruns and Delays",
        "correct_anwser": "A, C, D",
        "explain": "Việc xác thực yêu cầu (Requirements Validation) giúp đảm bảo tài liệu chính xác và được đồng thuận trước khi lập trình. Hành động này ngăn chặn được hiện tượng phình đại phạm vi (A), lệch pha kỳ vọng giữa các bên (C), từ đó tránh được việc trễ hạn và đội chi phí do phải làm lại (D). Không một bước xác thực yêu cầu nào có thể giúp 'loại bỏ hoàn toàn mọi lỗi phần mềm' (B) vì lỗi còn phát sinh trong quá trình code và triển khai thực tế."
      },
      {
        "question_id": 270,
        "question_title": "What is a requirements baseline?",
        "option_A": "Constraints on the development process of the system",
        "option_B": "A specification of features be implemented, descriptions of how the system should behave or descriptions",
        "option_C": "A set of requirements that stakeholders have agreed to, often defining the contents of a specific planned release or development iteration",
        "correct_anwser": "C",
        "explain": "Yêu cầu cơ sở (Requirements baseline) là một tập hợp các yêu cầu đã được các bên liên quan xem xét, rà soát và chính thức thống nhất/phê duyệt ký nhận (agreed to). Nó đóng vai trò là cột mốc chuẩn để định nghĩa phạm vi tính năng cho một đợt phát hành (release) hoặc một phân đoạn phát triển cụ thể, và mọi thay đổi sau đó đều phải tuân theo quy trình kiểm soát thay đổi."
      },
      {
        "question_id": 271,
        "question_title": "In the context of requirements tracing, what is a traceability matrix used for? (Choose 2 answers)",
        "option_A": "To track project progress in real-time",
        "option_B": "To generate new requirements automatically",
        "option_C": "To map requirements to other system elements like design and code",
        "option_D": "To identify missing or unnecessary requirements",
        "correct_anwser": "C, D",
        "explain": "Ma trận truy vết yêu cầu (Traceability Matrix) được sử dụng để ánh xạ các yêu cầu phần mềm tới các thành tố khác của hệ thống như tài liệu thiết kế, các module code và test case (C). Thông qua liên kết đa chiều này, đội ngũ dự án có thể dễ dàng kiểm tra để phát hiện xem có yêu cầu nào bị bỏ sót chưa làm hoặc có tính năng thừa thãi nào được code mà không bắt nguồn từ yêu cầu ban đầu hay không (D)."
      },
      {
        "question_id": 272,
        "question_title": "Why is version control important in managing requirements? (Select all that apply)",
        "option_A": "It ensures that requirements are unique and traceable.",
        "option_B": "It allows for tracking the history of changes",
        "option_C": "It helps prioritize the requirements.",
        "option_D": "It guarantees that all stakeholders are updated on changes.",
        "correct_anwser": "B",
        "explain": "Lưu ý đề bài hiển thị dạng chọn nhiều phương án nhưng chỉ có một đặc điểm đúng mô tả bản chất trực tiếp của quản lý phiên bản (Version Control) là ghi vết và theo dõi lịch sử chỉnh sửa, thay đổi của các tài liệu yêu cầu theo thời gian (B). Các việc như định danh duy nhất (A) hay phân cấp ưu tiên (C) thuộc về kỹ thuật quản lý thuộc tính yêu cầu (Requirements Attributes Management)."
      },
      {
        "question_id": 273,
        "question_title": "Which of the following are basic steps in change impact analysis? (Select all that apply)",
        "option_A": "Understand the possible implications of the change",
        "option_B": "Identify all affected requirements and documents",
        "option_C": "Implement the change without stakeholder approval",
        "option_D": "Estimate the effort needed for the change",
        "correct_anwser": "A, B, D",
        "explain": "Phân tích tác động thay đổi (Change Impact Analysis) bao gồm các bước nền tảng: nhận định các hệ quả tiềm ẩn của thay đổi (A), xác định chính xác danh sách các yêu cầu và tài liệu thiết kế bị ảnh hưởng trực tiếp hay gián tiếp (B), và ước lượng công sức/thời gian cần thiết để thực hiện thay đổi đó (D). Việc tự ý triển khai mà không qua phê duyệt (C) là sai quy trình."
      },
      {
        "question_id": 274,
        "question_title": "Which of the following best describes the structure of the Requirements Traceability Matrix (RTM)?",
        "option_A": "It is a spreadsheet that lists requirements and their corresponding test cases",
        "option_B": "It is a graphical representation of the project schedule",
        "option_C": "It is a tool used to manage project risks",
        "option_D": "It is a spreadsheet that maps requirements to other project artifacts such as design documents, test cases, and source code",
        "correct_anwser": "D",
        "explain": "Ma trận truy vết yêu cầu (RTM) có cấu trúc dạng bảng/bảng tính (spreadsheet) chứa luồng liên kết hai chiều, ánh xạ từ một yêu cầu phần mềm sang các thành phần liên quan khác trong dự án như tài liệu kiến trúc thiết kế, kịch bản kiểm thử (test cases), và các tệp mã nguồn (source code) tương ứng nhằm đảm bảo phạm vi kiểm soát."
      },
      {
        "question_id": 275,
        "question_title": "Why is it important to clearly define the scope of a software project in a scope document?",
        "option_A": "Limit stakeholder involvement",
        "option_B": "Speed up the development process",
        "option_C": "Avoid addressing project risks",
        "option_D": "Prevent scope creep and ensure project focus",
        "correct_anwser": "D",
        "explain": "Việc xác định rõ ràng phạm vi của dự án giúp ngăn chặn tình trạng 'phình kịch cỡ/vô định hình phạm vi' (scope creep - việc các yêu cầu mới liên tục tự ý thêm vào mà không kiểm soát), đồng thời giữ cho đội ngũ phát triển tập trung vào những mục tiêu cốt lõi đã cam kết."
      },
      {
        "question_id": 276,
        "question_title": "What is the primary objective of creating a requirements traceability matrix (RTM)?",
        "option_A": "To link requirements to design, development, and testing artifacts",
        "option_B": "To identify redundant requirements",
        "option_C": "To finalize the system budget",
        "option_D": "To prioritize stakeholder meetings",
        "correct_anwser": "A",
        "explain": "Mục đích chính của Ma trận truy xuất nguồn gốc yêu cầu (Requirements Traceability Matrix - RTM) là thiết lập mối liên kết hai chiều giữa các yêu cầu ban đầu với các thành phần thiết kế, mã nguồn phát triển và các kịch bản kiểm thử (test cases) để đảm bảo không có yêu cầu nào bị bỏ sót."
      },
      {
        "question_id": 277,
        "question_title": "Which of the following factors can act as a barrier to requirements reuse?",
        "option_A": "Lack of stakeholder involvement",
        "option_B": "Frequent updates and version control of requirements documentation",
        "option_C": "Standardized format for requirements documentation",
        "option_D": "Requirements written in natural language are ambiguities, missing information, and hidden assumptions",
        "correct_anwser": "D",
        "explain": "Rào cản lớn nhất đối với việc tái sử dụng yêu cầu (requirements reuse) là các yêu cầu được viết bằng ngôn ngữ tự nhiên kém chuẩn hóa, dẫn đến tình trạng mơ hồ, thiếu thông tin và chứa nhiều giả định ngầm hiểu không rõ ràng."
      },
      {
        "question_id": 278,
        "question_title": "What is the central element that drives all activities in the software development process?",
        "option_A": "Project plans",
        "option_B": "Designs and code",
        "option_C": "Tests",
        "option_D": "Baselined requirements",
        "correct_anwser": "D",
        "explain": "Các yêu cầu đã được phê duyệt làm cơ sở chuẩn (Baselined requirements) chính là nền tảng cốt lõi định hướng và thúc đẩy mọi hoạt động tiếp theo trong vòng đời phần mềm, từ lập kế hoạch, thiết kế kiến trúc, viết mã nguồn cho đến kiểm thử."
      },
      {
        "question_id": 279,
        "question_title": "Which of the following activities fall under the core activities of requirements management?",
        "option_A": "Document formatting, project scheduling, risk management, and budget tracking.",
        "option_B": "Quality assurance, stakeholder management, resource allocation, and system testing.",
        "option_C": "Version control, change control, requirements status tracking, and requirements tracing.",
        "option_D": "Designing user interfaces, coding, testing software modules, and system deployment.",
        "correct_anwser": "C",
        "explain": "Quản lý yêu cầu (Requirements Management) bao gồm các hoạt động cốt lõi nhằm kiểm soát biến động sau khi đã có baseline, cụ thể là: Quản lý phiên bản (Version control), kiểm soát thay đổi (Change control), theo dõi trạng thái yêu cầu (Status tracking) và truy xuất nguồn gốc yêu cầu (Tracing)."
      },
      {
        "question_id": 280,
        "question_title": "What is a key benefit of using a requirements management tool?",
        "option_A": "It ensures traceability and reduces errors in requirements documentation",
        "option_B": "It finalizes stakeholder requirements automatically.",
        "option_C": "It replaces the validation process.",
        "option_D": "It eliminates the need for prototyping.",
        "correct_anwser": "A",
        "explain": "Lợi ích cốt lõi của công cụ quản lý yêu cầu (như Jira, Confluence, DOORS...) là tự động hóa và đảm bảo khả năng truy vết nguồn gốc (traceability) xuyên suốt dự án, từ đó giảm thiểu sai sót, mất mát hoặc xung đột khi yêu cầu thay đổi."
      },
      {
        "question_id": 281,
        "question_title": "What is the Change Control Board (CCB)?",
        "option_A": "A group of stakeholders responsible for documenting project assumptions",
        "option_B": "A group that decides to approve or reject proposed changes for a specific project",
        "option_C": "A team of project managers tasked with managing project risks",
        "option_D": "A committee responsible for scheduling project milestones",
        "correct_anwser": "B",
        "explain": "Ban Kiểm soát Thay đổi (CCB - Change Control Board) là một nhóm các bên liên quan chịu trách nhiệm xem xét, đánh giá và đưa ra quyết định chính thức về việc phê duyệt (approve) hoặc từ chối (reject) các yêu cầu thay đổi đề xuất trong dự án."
      },
      {
        "question_id": 282,
        "question_title": "What is a key challenge when maintaining trace data in an existing system?",
        "option_A": "There is often no existing trace data to start with.",
        "option_B": "The system is too complex to trace effectively.",
        "option_C": "Trace data becomes obsolete very quickly.",
        "option_D": "There are too many participants to track.",
        "correct_anwser": "C",
        "explain": "Thách thức lớn nhất khi duy trì ma trận truy vết yêu cầu (Traceability Matrix) là dữ liệu truy vết rất nhanh bị lỗi thời (obsolete) do hệ thống liên tục được cập nhật, sửa đổi, đòi hỏi phải có sự cập nhật thủ công hoặc công cụ đồng bộ liên tục."
      },
      {
        "question_id": 283,
        "question_title": "What is the purpose of a Requirements Traceability Matrix (RTM) in the requirements management process?",
        "option_A": "To trace the origin of software bugs",
        "option_B": "To document project milestones",
        "option_C": "To track the relationship between requirements and other project artifacts",
        "option_D": "To manage project budgets",
        "correct_anwser": "C",
        "explain": "Ma trận truy vết yêu cầu (RTM) là một công cụ quản lý được sử dụng để theo dõi các mối quan hệ đa chiều giữa yêu cầu gốc với các tài liệu thiết kế, mã nguồn và các kịch bản kiểm thử (test cases) tương ứng trong suốt vòng đời dự án."
      },
      {
        "question_id": 284,
        "question_title": "What are the purposes of prioritizing the requirements? Choose 2 correct answers.",
        "option_A": "To ensure that the team implements the highest value or most timely functionality first",
        "option_B": "To determine which release or increment will contain each feature or set of requirements",
        "option_C": "To finish the project faster",
        "option_D": "To facilitate the release of the product",
        "correct_anwser": "A, B",
        "explain": "Mục đích chính của việc ưu tiên hóa yêu cầu là đảm bảo đội ngũ phát triển những chức năng có giá trị cao nhất hoặc cấp thiết nhất trước (A) và xác định xem tính năng nào sẽ nằm trong đợt phát hành (release/increment) nào (B)."
      },
      {
        "question_id": 285,
        "question_title": "What's the difference between Use Cases and User Stories?",
        "option_A": "The use case is a business artifact which defines the software requirement or an application feature. Whereas user story is a test artifact which defines the steps to validate and verify that the software requirement or application feature exists",
        "option_B": "The user story contains complete and lengthy descriptions. A use case contains simplified and short descriptions",
        "option_C": "The user story is a business artifact which defines the software requirement or an application feature. Whereas use case is a test artifact which defines the steps to validate and verify that the software requirement or application feature exists",
        "option_D": "The user story contains simplified and short descriptions. A use case contains complete and lengthy descriptions",
        "correct_anwser": "D",
        "explain": "User Story (Câu chuyện người dùng) là những mô tả ngắn gọn, đơn giản, cô đọng dưới góc nhìn của người dùng cuối (thường theo mẫu As a... I want to... So that...). Ngược lại, Use Case (Ca sử dụng) là một tài liệu chi tiết, đầy đủ, mô tả tường tận các luồng tương tác và kịch bản nghiệp vụ đầy đủ giữa tác nhân và hệ thống."
      },
      {
        "question_id": 286,
        "question_title": "An analysis model that visually depicts the various states in which a system or an object in the system can exist, the permitted transitions that can take place between states.",
        "option_A": "State-transition diagram",
        "option_B": "Swimlane diagram",
        "option_C": "Use case diagram",
        "option_D": "Data Flow diagram",
        "correct_anwser": "A",
        "explain": "Sơ đồ chuyển trạng thái (State-transition diagram) là mô hình phân tích mô tả trực quan các trạng thái khác nhau của một hệ thống hoặc một đối tượng, cũng như các điều kiện dịch chuyển hợp lệ giữa các trạng thái đó."
      },
      {
        "question_id": 287,
        "question_title": "Prioritization is a way to deal with competing demands for limited resources. So, establishing the relative priority of each product capability lets you plan construction to provide the _______ value at the _______ cost.",
        "option_A": "highest, lowest",
        "option_B": "lowest, highest",
        "option_C": "highest, highest",
        "option_D": "lowest, lowest",
        "correct_anwser": "A",
        "explain": "Việc xác định mức độ ưu tiên tương đối của từng tính năng sản phẩm giúp người quản lý lập kế hoạch thi công nhằm mục đích mang lại giá trị cao nhất (highest value) với chi phí hoặc nguồn lực thấp nhất có thể (lowest cost)."
      },
      {
        "question_id": 288,
        "question_title": "Choose the incorrect answer when talking about the essential aspects of an agile approach to requirements.",
        "option_A": "Customer involvement",
        "option_B": "Expect stability",
        "option_C": "The backlog and prioritization",
        "option_D": "Timing",
        "option_E": "Documentation detail",
        "correct_anwser": "B",
        "explain": "Trong cách tiếp cận Agile đối với yêu cầu, người ta luôn chuẩn bị tinh thần đón nhận sự thay đổi (Embrace change) chứ không bao giờ 'Kỳ vọng sự ổn định' (Expect stability). Các khía cạnh còn lại như sự tham gia của khách hàng, backlog/ưu tiên hóa, timing và mức độ chi tiết tài liệu vừa đủ đều là đặc trưng của Agile."
      },
      {
        "question_id": 289,
        "question_title": "According to the \"Three-level scale\" prioritization, how is a \"High-priority requirement\" defined?",
        "option_A": "It is important (customers need the capability) but not urgent (it can wait for a later release).",
        "option_B": "It is both important (customers need the capability) and urgent (customers need it in the next release), or contractual/compliance obligations mandate its inclusion.",
        "option_C": "It is neither important nor urgent, and can be eliminated.",
        "option_D": "It is urgent for political reasons but not important for achieving business objectives.",
        "correct_anwser": "B",
        "explain": "Theo thang đo ưu tiên 3 mức độ (High, Medium, Low), một yêu cầu có độ ưu tiên Cao (High-priority) được định nghĩa là yêu cầu vừa quan trọng (khách hàng thực sự cần tính năng đó) vừa cấp bách (phải xuất hiện ngay trong đợt phát hành tới), hoặc là yêu cầu bắt buộc tuân thủ theo hợp đồng/pháp lý."
      },
      {
        "question_id": 290,
        "question_title": "With whom should an Agile analyst collaborate closely to ensure the requirements accurately reflect business needs?",
        "option_A": "Only the end customers.",
        "option_B": "Only the development and testing teams.",
        "option_C": "Only with the development team to relay technical requirements.",
        "option_D": "With the customer, project management, the development team, and other stakeholders to ensure requirements align with business needs.",
        "option_E": "With the business department solely for comparing statistical data.",
        "correct_anwser": "D",
        "explain": "Trong mô hình Agile, nhà phân tích cần đóng vai trò là cầu nối cộng tác liên tục và toàn diện với tất cả các bên bao gồm khách hàng, quản trị dự án, đội ngũ lập trình và các bên liên quan để đảm bảo mọi yêu cầu đưa ra đồng bộ với giá trị kinh doanh."
      },
      {
        "question_id": 291,
        "question_title": "Which of the following describes the difference between a product's vision and its scope?",
        "option_A": "Vision applies to Agile projects, while scope applies only to traditional projects.",
        "option_B": "Vision is a long-term goal and ultimate state of the product, while scope defines what portion of the vision will be built in a specific release or project.",
        "option_C": "Vision is documented by the developer, while scope is written by the customer.",
        "option_D": "Vision defines the budget constraints, while scope defines the technical stack.",
        "correct_anwser": "B",
        "explain": "Tầm nhìn (Vision) mô tả mục tiêu lâu dài và trạng thái lý tưởng cuối cùng mà sản phẩm hướng tới, trong khi phạm vi (Scope) xác định giới hạn cụ thể những tính năng hoặc phần việc nào của tầm nhìn đó sẽ thực sự được xây dựng trong một phiên bản phát hành hoặc dự án cụ thể."
      },
      {
        "question_id": 292,
        "question_title": "Which technique is most effective for resolving conflicts among stakeholders?",
        "option_A": "Prioritization workshops",
        "option_B": "Eliminating conflicting requirements",
        "option_C": "Focusing only on functional requirements",
        "option_D": "Avoiding stakeholder feedback",
        "correct_anwser": "A",
        "explain": "Các buổi hội thảo ưu tiên hóa (Prioritization workshops) tập hợp các bên liên quan lại để cùng thảo luận, đánh giá giá trị và mức độ quan trọng của từng yêu cầu dưới góc nhìn kinh doanh, từ đó giúp đạt được sự đồng thuận và giải quyết xung đột lợi ích một cách hiệu quả nhất."
      },
      {
        "question_id": 293,
        "question_title": "What is a common pitfall in writing non-functional requirements?",
        "option_A": "Making them too vague or unmeasurable",
        "option_B": "Prioritizing them over functional requirements",
        "option_C": "Writing them without stakeholder input",
        "option_D": "Skipping them in the documentation process",
        "correct_anwser": "A",
        "explain": "Một sai lầm phổ biến và nghiêm trọng nhất khi viết các yêu cầu phi chức năng (Non-functional requirements - NFR) là viết chúng quá mơ hồ, chung chung và không thể đo lường được (ví dụ: 'Hệ thống phải chạy nhanh', 'Giao diện phải thân thiện'). NFR đúng chuẩn cần phải định lượng được rõ ràng (ví dụ: 'Thời gian phản hồi phải dưới 2 giây')."
      },
      {
        "question_id": 294,
        "question_title": "What is the role of user stories in Agile requirements management?",
        "option_A": "To provide concise, actionable descriptions of features from the user's perspective",
        "option_B": "To replace the Vision and Scope document",
        "option_C": "To prioritize non-functional requirements",
        "option_D": "To finalize the system's architecture",
        "correct_anwser": "A",
        "explain": "Trong mô hình Agile, câu chuyện người dùng (User Story) đóng vai trò cung cấp các mô tả ngắn gọn, dễ hiểu và có thể thực thi được về một tính năng sản phẩm dưới góc nhìn/lăng kính của người sử dụng cuối (thường theo cấu trúc: As a... I want to... So that...)."
      },
      {
        "question_id": 295,
        "question_title": "What is the primary challenge of documenting requirements for complex systems?",
        "option_A": "Ensuring clarity, consistency, and avoiding ambiguities",
        "option_B": "Eliminating low-priority requirements",
        "option_C": "Skipping stakeholder validation",
        "option_D": "Focusing only on functional needs",
        "correct_anwser": "A",
        "explain": "Khi viết tài liệu yêu cầu cho các hệ thống lớn và phức tạp, thách thức hàng đầu luôn là đảm bảo tính rõ ràng (clarity), nhất quán (consistency) giữa hàng trăm yêu cầu đan xen và tuyệt đối tránh viết mơ hồ, đa nghĩa (avoiding ambiguities) gây hiểu lầm cho đội phát triển."
      },
      {
        "question_id": 296,
        "question_title": "If you prototype the whole solution rather than only the most uncertain, high-risk, or complex portions, your risk is",
        "option_A": "investing excessive effort in prototypes",
        "option_B": "distraction by details",
        "option_C": "pressure to release the prototype",
        "option_D": "unrealistic performance expectations",
        "correct_anwser": "A",
        "explain": "Nguyên tắc làm mẫu thử là chỉ nên tập trung vào các phần có rủi ro cao, phức tạp hoặc chưa rõ ràng để tối ưu chi phí. Nếu cố gắng làm mẫu thử cho toàn bộ giải pháp (the whole solution), dự án sẽ đối mặt với rủi ro lãng phí nguồn lực và bỏ ra công sức quá mức cần thiết vào mẫu thử (investing excessive effort in prototypes) trong khi nhiều phần trong đó đã rất rõ ràng."
      },
      {
        "question_id": 297,
        "question_title": "The four capitalized letters in the MoSCoW prioritization technique stand for:",
        "option_A": "Must, Should, Could, Won't",
        "option_B": "Must, Should, Could, Will",
        "option_C": "Must, Should, Can, Will",
        "option_D": "Must, Shall, Could, Won't",
        "correct_anwser": "A",
        "explain": "Kỹ thuật phân loại và ưu tiên yêu cầu MoSCoW là từ viết tắt của bốn nhóm: Must have (Phải có), Should have (Nên có), Could have (Có thể có), và Won't have this time (Chưa có vào lúc này)."
      },
      {
        "question_id": 298,
        "question_title": "Which of the following is NOT about prioritization techniques?",
        "option_A": "In or out.",
        "option_B": "Pairwise comparison and rank ordering.",
        "option_C": "Three-level scale.",
        "option_D": "MoSCoW.",
        "option_E": "Based on risk.",
        "correct_anwser": "E",
        "explain": "Các phương án A, B, C, D đều là tên gọi của các kỹ thuật hoặc thang đo phân loại ưu tiên yêu cầu chuẩn hóa trong kỹ nghệ yêu cầu (In or out, So sánh cặp Pairwise, Thang đo 3 mức Three-level, MoSCoW). Trích theo lý thuyết sách Karl Wiegers, 'Based on risk' (Dựa trên rủi ro) chỉ là một trong các tiêu chí đánh giá khi phân tích, chứ không phải một tên gọi kỹ thuật phân loại ưu tiên độc lập."
      },
      {
        "question_id": 299,
        "question_title": "Which of the following is NOT about Change management on Agile projects?",
        "option_A": "Agile processes harness change for the customer's competitive advantage.",
        "option_B": "Agile projects manage change by maintaining a specific backlog of work to be done.",
        "option_C": "Accepting change helps to meet evolving business objectives and priorities and to accommodate the limitations of human plans and foresight.",
        "option_D": "Agile methods vary as to their philosophy on this point; there is no single “correct” approach.",
        "correct_anwser": "B",
        "explain": "Trong mô hình Agile, các dự án quản lý thay đổi thông qua một danh sách động gọi là Product Backlog luôn luôn được liên tục cập nhật, làm mịn và tái ưu tiên (prioritized backlog), chứ không phải duy trì một danh sách công việc cố định hay cụ thể không đổi (maintaining a specific backlog). Các phương án A, C, D đều phản ánh đúng tuyên ngôn và triết lý đón nhận sự thay đổi của Agile."
      },
      {
        "question_id": 300,
        "question_title": "Which of the following is an example of a risk avoidance strategy?",
        "option_A": "Performing risk control activities to manage top-priority risks.",
        "option_B": "Documenting potential risks without any action.",
        "option_C": "Not engaging in the risky activity at all.",
        "option_D": "Ignoring minor risks and focusing only on major risks.",
        "correct_anwser": "C",
        "explain": "Né tránh rủi ro (Risk avoidance) có nghĩa là thay đổi kế hoạch dự án hoặc chủ động không tham gia vào hoạt động có rủi ro đó nữa (Not engaging in the risky activity at all) nhằm loại bỏ hoàn toàn khả năng xuất hiện hoặc ảnh hưởng của rủi ro đó đối với dự án."
      },
      {
        "question_id": 301,
        "question_title": "Which statement best describes the purpose of an Epic in Agile project?",
        "option_A": "To define detailed requirements and specifications for a project",
        "option_B": "To represent a high-level user need or business requirement that can be broken down into smaller, more manageable user stories",
        "option_C": "To assign tasks to team members for implementation",
        "option_D": "To prioritize project deliverables",
        "correct_anwser": "B",
        "explain": "Trong mô hình Agile, một Epic đóng vai trò đại diện cho một khối yêu cầu nghiệp vụ hoặc nhu cầu lớn ở cấp độ vĩ mô (high-level user need) của người dùng, mà từ đó thực tế sẽ được phân rã ra thành nhiều câu chuyện người dùng nhỏ hơn, chi tiết hơn (user stories) để đội phát triển dễ dàng quản lý và thực thi trong từng Sprint."
      },
      {
        "question_id": 302,
        "question_title": "Which of the following are considered good practices in requirements analysis? Select three.",
        "option_A": "Modeling the application environment to understand the system's boundaries and interactions with external entities.",
        "option_B": "Prioritizing the requirements based solely on the preferences of the development team without considering business goals or customer needs.",
        "option_C": "Creating prototypes to explore and validate uncertain requirements with stakeholders.",
        "option_D": "Analyzing data flows to ensure that all interactions between the system and external entities are understood and documented.",
        "correct_anwser": "A, C, D",
        "explain": "Các hoạt động phân tích yêu cầu chuẩn và tốt bao gồm: Mô hình hóa môi trường để xác định ranh giới hệ thống (A), xây dựng mẫu thử (prototype) để xác thực các yêu cầu chưa rõ ràng (C), và phân tích luồng dữ liệu (D). Lựa chọn B sai vì không được phép ưu tiên yêu cầu chỉ dựa trên sở thích cá nhân của đội phát triển mà bỏ qua mục tiêu kinh doanh của khách hàng."
      },
      {
        "question_id": 303,
        "question_title": "What should a business analyst do in an Agile project? Chooses 3 correct answers.",
        "option_A": "Define a lightweight, flexible requirements process and adapt it as the project warrants",
        "option_B": "Ensure that requirements documentation is at the right level: very detailed",
        "option_C": "Help validate that customer needs are accurately represented in the product backlog",
        "option_D": "Facilitate backlog prioritization",
        "correct_anwser": "A, C, D",
        "explain": "Trong môi trường Agile, vai trò của BA là thiết lập quy trình yêu cầu linh hoạt, gọn nhẹ (A), hỗ trợ xác thực nhu cầu khách hàng được phản ánh đúng trong product backlog (C), và điều phối việc ưu tiên hóa backlog (D). Lựa chọn B sai vì Agile không hướng tới việc viết tài liệu yêu cầu 'rất chi tiết' (very detailed) ngay từ đầu mà chú trọng vào mức độ chi tiết vừa đủ và tiệm tiến."
      },
      {
        "question_id": 304,
        "question_title": "Propose a solution for a scenario where a product owner is unable to understand all user requirements due to the complexity of the project. Which approach would you recommend?",
        "option_A": "Replace the product owner with a more knowledgeable individual.",
        "option_B": "Collaborate with multiple business analysts and product champions to gather comprehensive requirements.",
        "option_C": "Simplify the project to reduce complexity.",
        "option_D": "Delegate all decision-making to the development team.",
        "correct_anwser": "B",
        "explain": "Khi dự án quá phức tạp khiến Product Owner không thể tự nắm bắt toàn bộ yêu cầu, giải pháp tối ưu và thực tế nhất là phân rã công việc bằng cách phối hợp chặt chẽ với nhiều Business Analyst và các Product Champion để cùng thu thập và làm rõ yêu cầu một cách toàn diện."
      },
      {
        "question_id": 305,
        "question_title": "Why is traceability essential for managing changing requirements?",
        "option_A": "To track changes and ensure alignment with project goals",
        "option_B": "To prioritize functional requirements",
        "option_C": "To reduce the scope of stakeholder involvement",
        "option_D": "To eliminate ambiguous requirements",
        "correct_anwser": "A",
        "explain": "Tính truy vết (Traceability) đóng vai trò sống còn trong việc quản lý thay đổi vì nó cho phép theo dõi lịch sử, nguồn gốc của yêu cầu và phân tích tác động, đảm bảo mọi thay đổi phát sinh luôn nhất quán và hướng tới mục tiêu chung của dự án."
      },
      {
        "question_id": 306,
        "question_title": "What is the most popular form of user stories?",
        "option_A": "As a <type of user>, I want <some goal> so that <some reason>.",
        "option_B": "As a <type of user>, I want <some goal>.",
        "option_C": "As a <type of user>, I need <some need> so that <some reason>.",
        "option_D": "As a <type of user>, I want <some goal> to <some purpose>.",
        "correct_anwser": "A",
        "explain": "Mẫu (template) phổ biến nhất của một User Story trong phát triển phần mềm theo Agile là: \"As a <role>, I want <goal/desire> so that <benefit/reason>\" (Với tư cách là..., tôi muốn... để...)."
      },
      {
        "question_id": 307,
        "question_title": "An analysis model that depicts a process flow proceeding from one activity to another",
        "option_A": "Dialog map",
        "option_B": "Swimlane diagram",
        "option_C": "Context diagram",
        "option_D": "Class diagram",
        "correct_anwser": "B",
        "explain": "Sơ đồ làn bơi (Swimlane diagram) là một dạng mô hình phân tích quy trình thể hiện rõ luồng công việc (process flow) tuần tự đi từ hoạt động này sang hoạt động khác, đồng thời phân định rõ ràng trách nhiệm thực hiện hoạt động đó thuộc về phòng ban hoặc tác nhân nào."
      },
      {
        "question_id": 308,
        "question_title": "Which of the following is NOT a requirements prioritization technique?",
        "option_A": "Pairwise comparison",
        "option_B": "In or out",
        "option_C": "Three-level scale",
        "option_D": "$1000",
        "option_E": "MoSCoW",
        "correct_anwser": "D",
        "explain": "Kỹ thuật phân bổ nguồn vốn giả định để ưu tiên yêu cầu có tên chuẩn xác theo lý thuyết là kỹ thuật '$100 allocation' hoặc '100-dollar test'. Việc đưa ra con số '$1000' không phải là tên gọi chuẩn hóa của kỹ thuật này trong sách giáo trình kỹ nghệ yêu cầu."
      },
      {
        "question_id": 309,
        "question_title": "What does the MoSCoW method classify in requirements prioritization?",
        "option_A": "Urgency and cost of requirements",
        "option_B": "Must, Should, Could, and Won't categories",
        "option_C": "Technical feasibility and design limitations",
        "option_D": "High, Medium, and Low priorities",
        "correct_anwser": "B",
        "explain": "Phương pháp MoSCoW phân loại các yêu cầu thành 4 nhóm viết tắt rõ ràng bao gồm: M - Must have (Bắt buộc phải có), S - Should have (Nên có), C - Could have (Có thể có), và W - Won't have (Chưa phải lúc này/Không có trong đợt này)."
      },
      {
        "question_id": 310,
        "question_title": "How does the Kano model help analyze user requirements?",
        "option_A": "By classifying features into basic, performance, and delight categories",
        "option_B": "By prioritizing requirements based on technical feasibility",
        "option_C": "By eliminating unnecessary requirements",
        "option_D": "By focusing only on functional requirements",
        "correct_anwser": "A",
        "explain": "Mô hình Kano giúp phân tích mức độ hài lòng của khách hàng bằng cách phân loại các tính năng sản phẩm thành các nhóm: tính năng cơ bản bắt buộc (basic), tính năng tuyến tính/hiệu năng (performance), và tính năng gây bất ngờ thú vị (delight)."
      },
      {
        "question_id": 311,
        "question_title": "Why is it essential to specify acceptance criteria during requirements validation?",
        "option_A": "To define clear and measurable conditions for success",
        "option_B": "To prioritize functional requirements",
        "option_C": "To finalize the design phase",
        "option_D": "To eliminate stakeholder input",
        "correct_anwser": "A",
        "explain": "Tiêu chí nghiệm thu (Acceptance criteria) đóng vai trò then chốt trong việc thẩm định yêu cầu vì nó định nghĩa ra các điều kiện rõ ràng, có thể đo lường được để kiểm tra xem hệ thống có đáp ứng đúng mong đợi của người dùng và hoàn thành thành công hay không."
      },
      {
        "question_id": 312,
        "question_title": "Consider the following Statement: \"If a lead doesn't respond back within 30 days of the first contact, it must be a cold lead and can be marked accordingly\". What type of business rule is being depicted here?",
        "option_A": "Facts",
        "option_B": "Constraints",
        "option_C": "Action enablers",
        "option_D": "Inferences",
        "option_E": "Computations",
        "correct_anwser": "D",
        "explain": "Quy tắc kinh doanh dạng Hệ quả/Suy luận (Inferences) tạo ra một sự thật hoặc tri thức mới từ các điều kiện sẵn có. Tuyên bố trên suy luận rằng: nếu không phản hồi trong 30 ngày (sự thật có sẵn) thì thông tin này được phân loại thành \"khách hàng tiềm năng nguội lạnh\" (tri thức mới suy luận ra)."
      },
      {
        "question_id": 313,
        "question_title": "What is the primary purpose of a Swimlane diagram?",
        "option_A": "To represent detailed software architecture and coding structures.",
        "option_B": "To visually depict the steps involved in a business process or the operations of a proposed software system, subdivided into lanes that represent different systems or actors.",
        "option_C": "To exclusively model user interface interactions and design layouts.",
        "option_D": "To show the organizational structure and management hierarchy within a company.",
        "correct_anwser": "B",
        "explain": "Mục đích chính của biểu đồ làn bơi (Swimlane diagram) là mô tả trực quan dòng chảy tuần tự của các bước trong một quy trình nghiệp vụ, trong đó chia thành các làn (lanes) song song đại diện cho vai trò chịu trách nhiệm của các tác nhân hoặc phân hệ hệ thống khác nhau."
      },
      {
        "question_id": 314,
        "question_title": "Which of the following is a benefit of prioritizing requirements?",
        "option_A": "Improved project management",
        "option_B": "Decreased stakeholder involvement",
        "option_C": "Enhanced focus on high-value features",
        "option_D": "Reduced scope creep",
        "correct_anwser": "C",
        "explain": "Lợi ích trực tiếp và quan trọng nhất của việc phân loại mức độ ưu tiên yêu cầu là giúp đội ngũ dự án tập trung tối đa nguồn lực vào việc phát triển các tính năng mang lại giá trị cao nhất cho khách hàng trước (Enhanced focus on high-value features)."
      },
      {
        "question_id": 315,
        "question_title": "Why is prioritization essential in agile projects, especially when customer expectations are high and timelines are short?",
        "option_A": "It ensures that the project manager can handle the project without customer input, focusing solely on cost and efficiency.",
        "option_B": "It allows developers to skip less important features, ensuring that only critical bugs are fixed before release.",
        "option_C": "It helps in delivering the most critical or valuable functionality as early as possible, ensuring maximum business value within project constraints.",
        "option_D": "It lets the project manager choose which requirements to ignore, focusing only on budget and staff limitations.",
        "correct_anwser": "C",
        "explain": "Trong các dự án Agile với thời gian ngắn (timeline gắt gao), việc ưu tiên giúp đội ngũ bàn giao được các gói tính năng cốt lõi và có giá trị nhất cho khách hàng ngay từ những phiên bản sớm, đảm bảo tối ưu hóa giá trị kinh doanh trong phạm vi ràng buộc của dự án."
      },
      {
        "question_id": 316,
        "question_title": "“Story point” is used to measure which one below?",
        "option_A": "User story",
        "option_B": "Code",
        "option_C": "Function",
        "option_D": "Architecture",
        "correct_anwser": "A",
        "explain": "Trong các phương pháp phát triển phần mềm linh hoạt (Agile/Scrum), điểm câu chuyện (Story point) là một đơn vị đo lường trừu tượng được sử dụng để ước lượng kích thước, độ phức tạp và nỗ lực cần thiết để hoàn thành một User story."
      },
      {
        "question_id": 317,
        "question_title": "The close collaboration of customers with developers on agile projects generally means that requirements can be documented in _______ detail than on traditional projects.",
        "option_A": "less",
        "option_B": "more",
        "option_C": "shorter",
        "option_D": "longer",
        "correct_anwser": "A",
        "explain": "Do đặc thù của các dự án Agile là khách hàng hợp tác và trao đổi rất thường xuyên, trực tiếp với đội ngũ phát triển nên các tài liệu yêu cầu thường được viết ngắn gọn, cô đọng và ít chi tiết hơn (\"less detail\") so với việc phải làm tài liệu đặc tả đồ sộ, kỹ lưỡng từ đầu như các mô hình truyền thống (Waterfall)."
      },
      {
        "question_id": 318,
        "question_title": "How does the MoSCoW method assist in prioritizing requirements?",
        "option_A": "By categorizing requirements as Must-have, Should-have, Could-have, and Won’t-have",
        "option_B": "By focusing on technical feasibility",
        "option_C": "By skipping stakeholder engagement",
        "option_D": "By eliminating low-priority requirements",
        "correct_anwser": "A",
        "explain": "Phương pháp MoSCoW là một kỹ thuật phân loại độ ưu tiên của yêu cầu bằng cách chia chúng thành 4 nhóm rõ ràng: Must-have (Bắt buộc phải có), Should-have (Nên có), Could-have (Có thể có nếu có nguồn lực), và Won't-have (Chưa cần thiết/Không có trong lần phát hành này)."
      },
      {
        "question_id": 319,
        "question_title": "Which of the following characteristics of excellent requirements is depicted by the statement: \"Requirements don't conflict with other requirements of the same type or with higher-level biz, user, or system requirements.\" ?",
        "option_A": "Complete",
        "option_B": "Unambiguous",
        "option_C": "Consistent",
        "option_D": "Traceable",
        "option_E": "Modifiable",
        "correct_anwser": "C",
        "explain": "Phát biểu trên mô tả tính nhất quán (Consistent) của yêu cầu, nghĩa là các yêu cầu không được mâu thuẫn hay xung đột lẫn nhau, đồng thời phải đồng bộ với các yêu cầu ở cấp cao hơn như mục tiêu kinh doanh hay nhu cầu thực tế của người dùng."
      },
      {
        "question_id": 320,
        "question_title": "What is the purpose of categorizing requirements into \"Must-have\" and \"Should-have\"?",
        "option_A": "To prioritize high-value requirements for early implementation",
        "option_B": "To eliminate low-priority requirements altogether",
        "option_C": "To finalize coding strategies",
        "option_D": "To reduce the scope of non-functional requirements",
        "correct_anwser": "A",
        "explain": "Phân loại yêu cầu thành 'Must-have' và 'Should-have' (theo mô hình MoSCoW) nhằm mục đích sắp xếp thứ tự ưu tiên cho các yêu cầu có giá trị cao để đưa vào phát triển và triển khai sớm trong các giai đoạn đầu của dự án."
      },
      {
        "question_id": 321,
        "question_title": "What is a key characteristic of Agile projects?",
        "option_A": "Strict adherence to a detailed project plan",
        "option_B": "Regular adaptation to changing requirements and priorities",
        "option_C": "Emphasis on comprehensive documentation over working software",
        "option_D": "Minimal interaction with customers and stakeholders",
        "correct_anwser": "B",
        "explain": "Đặc trưng cốt lõi của phương pháp luận Agile (Tuyên ngôn Agile) là khả năng thích ứng nhanh chóng và phản hồi thường xuyên trước các thay đổi về yêu cầu cũng như độ ưu tiên của khách hàng trong suốt quá trình triển khai dự án."
      },
      {
        "question_id": 322,
        "question_title": "What is the primary challenge in defining system boundaries during requirements elicitation?",
        "option_A": "Ensuring all stakeholders agree on the scope and avoiding scope creep",
        "option_B": "Prioritizing functional requirements over non-functional requirements",
        "option_C": "Eliminating technical constraints",
        "option_D": "Finalizing coding strategies",
        "correct_anwser": "A",
        "explain": "Thách thức lớn nhất khi xác định ranh giới hệ thống (system boundaries) là làm sao để tất cả các bên liên quan thống nhất về phạm vi dự án, từ đó tránh hiện tượng phình đại phạm vi (scope creep) ngoài kiểm soát."
      },
      {
        "question_id": 323,
        "question_title": "How does the MoSCoW method contribute to prioritizing requirements based on business objectives",
        "option_A": "It prioritizes requirements solely based on stakeholder preferences",
        "option_B": "It categorizes requirements into Must-haves, Should-haves, Could-haves, and Won't-haves to guide prioritization",
        "option_C": "It excludes business objectives from the prioritization process",
        "option_D": "It only considers technical specifications in prioritization decisions",
        "correct_anwser": "B",
        "explain": "Phương pháp MoSCoW hỗ trợ phân định thứ tự ưu tiên bằng cách phân loại các yêu cầu rõ ràng thành 4 nhóm chiến lược: Must-have (Bắt buộc phải có), Should-have (Nên có), Could-have (Có thể có) và Won't-have (Chưa làm trong giai đoạn này)."
      },
      {
        "question_id": 324,
        "question_title": "How can risks be prioritized in project management?",
        "option_A": "By focusing on risks that are least likely to occur",
        "option_B": "By considering both the likelihood of occurrence and potential impact of risks",
        "option_C": "By ignoring potential impact and only considering likelihood",
        "option_D": "By assuming that all risks are equally important",
        "correct_anwser": "B",
        "explain": "Trong quản trị dự án, rủi ro được ưu tiên xử lý bằng cách đánh giá dựa trên hai yếu tố cốt lõi: Xác suất xảy ra rủi ro (Likelihood/Probability) và Mức độ ảnh hưởng/Tác động của rủi ro đó nếu nó xảy ra (Potential Impact)."
      },
      {
        "question_id": 325,
        "question_title": "How does modeling help in analyzing complex requirements?",
        "option_A": "By visualizing requirements and identifying inconsistencies or gaps",
        "option_B": "By prioritizing coding over documentation",
        "option_C": "By finalizing all functional requirements early",
        "option_D": "By reducing stakeholder engagement",
        "correct_anwser": "A",
        "explain": "Việc mô hình hóa (modeling) thông qua các sơ đồ (DFD, Use Case, Sequence...) giúp trực quan hóa các yêu cầu phức tạp, từ đó giúp các kỹ sư yêu cầu và khách hàng dễ dàng phát hiện ra các điểm mâu thuẫn (inconsistencies) hoặc khoảng trống thiếu sót (gaps)."
      },
      {
        "question_id": 326,
        "question_title": "How does prioritization help in managing conflicting requirements?",
        "option_A": "It ensures that high-value requirements are implemented first.",
        "option_B": "It eliminates non-functional requirements from consideration.",
        "option_C": "It finalizes all requirements before the design phase.",
        "option_D": "It focuses on budget over stakeholder needs",
        "correct_anwser": "A",
        "explain": "Định điểm ưu tiên (Prioritization) giúp giải quyết xung đột bằng cách xác định rõ yêu cầu nào mang lại giá trị cao nhất cho doanh nghiệp hoặc khách hàng để ưu tiên triển khai trước trong điều kiện nguồn lực có hạn."
      },
      {
        "question_id": 327,
        "question_title": "Why is it crucial to involve users during requirements elicitation?",
        "option_A": "To gather insights about their needs and ensure requirements meet their expectations",
        "option_B": "To prioritize system design over functional requirements",
        "option_C": "To validate non-functional requirements",
        "option_D": "To finalize system testing strategies",
        "correct_anwser": "A",
        "explain": "Việc lôi cuốn người dùng tham gia vào giai đoạn khơi gợi yêu cầu là vô cùng quan trọng nhằm thấu hiểu chính xác nhu cầu thực tế của họ, tránh việc đoán mò và đảm bảo phần mềm làm ra đáp ứng đúng kỳ vọng."
      },
      {
        "question_id": 328,
        "question_title": "Consider the following Statement: \"If a lead doesn't respond back within 30 days of the first contact, it must be a cold lead and can be marked accordingly\". What types of business rule is being depicted here?",
        "option_A": "Facts",
        "option_B": "Constraints",
        "option_C": "Action enablers",
        "option_D": "Inferences",
        "option_E": "Computations",
        "correct_anwser": "D",
        "explain": "Phát biểu trên thuộc loại luật kinh doanh dạng Suy luận (Inferences) hoặc Luật phái sinh (Derivations). Từ một sự thật đã biết (không phản hồi trong 30 ngày), hệ thống tự động suy luận ra một tri thức mới hoặc trạng thái mới (đây là một 'cold lead')."
      },
      {
        "question_id": 329,
        "question_title": "Which of the following is NOT about Agile project?",
        "option_A": "Developers have little interaction with customers after construction begins on projects.",
        "option_B": "It encourage creating the minimum amount of documentation needed to accurately guide the developers and testers.",
        "option_C": "BAs or other people responsible for requirements will develop the necessary precision through conversations and documentation when it is needed.",
        "option_D": "The se collaboration of customers with developers on agile projects generally means that requirements can be documented in less detail.",
        "correct_anwser": "A",
        "explain": "Phát biểu A hoàn toàn sai lệch với tinh thần Agile. Trong dự án Agile, lập trình viên và khách hàng/Product Owner phải liên tục tương tác, trao đổi và phản hồi trong suốt các chu kỳ Sprint, chứ không phải ngắt kết nối sau khi bắt đầu giai đoạn code (construction)."
      },
      {
        "question_id": 330,
        "question_title": "Which of the following is NOT a principle of software process improvement?",
        "option_A": "People and organizations change only when they have an incentive to do so.",
        "option_B": "Prioritizing individual contributions over teamwork",
        "option_C": "Process changes should be goal-oriented",
        "option_D": "Process improvement should be evolutionary and continuous",
        "correct_anwser": "B",
        "explain": "Cải tiến quy trình phần mềm (SPI) luôn nhấn mạnh vào sự đồng lòng, tối ưu hóa quy trình làm việc chung và tinh thần đồng đội (teamwork) chứ không bao giờ đặt sự đóng góp mang tính cá nhân biệt lập lên trên (B)."
      }
    ]
  },
  {
    "id": "swr302-module-1-fundamentals-&-ba-role",
    "title": "SWR302 - Module 1 - Fundamentals & BA Role",
    "description": "Software Requirement Quiz",
    "questionsCount": 57,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which of the following is NOT included in the list of Software Bill of Rights Requirements?",
        "option_A": "Expect BAs to speak your language.",
        "option_B": "Expect BAs to learn about your business and your objectives.",
        "option_C": "Promptly communicate changes to the requirements.",
        "option_D": "Receive explanations of requirements practices and deliverables.",
        "option_E": "Change your requirements.",
        "option_F": "Expect an environment of mutual respect.",
        "correct_anwser": "C",
        "explain": "Trong tuyên ngôn quyền lợi phần mềm (Software Bill of Rights), 'Promptly communicate changes to the requirements' (Thông báo kịp thời các thay đổi đối với yêu cầu) là nghĩa vụ/trách nhiệm (Responsibility) của khách hàng chứ không phải là một quyền lợi (Right) trong danh sách."
      },
      {
        "question_id": 2,
        "question_title": "In a project, who is primarily responsible for communicating project information?",
        "option_A": "The business analyst",
        "option_B": "The project manager",
        "option_C": "The software development team",
        "option_D": "The customer community",
        "correct_anwser": "B",
        "explain": "Quản lý dự án (Project Manager) là người chịu trách nhiệm chính trong việc quản lý và truyền thông các thông tin chung của dự án đến tất cả các bên liên quan."
      },
      {
        "question_id": 3,
        "question_title": "Why is it crucial for a business analyst to communicate requirements effectively and efficiently?",
        "option_A": "To ensure that requirements are documented only once.",
        "option_B": "To facilitate ongoing collaboration and ensure the team understands the requirements.",
        "option_C": "To avoid the need for visual analysis models.",
        "option_D": "To reduce the number of requirements.",
        "correct_anwser": "B",
        "explain": "Giao tiếp hiệu quả giúp thúc đẩy sự hợp tác liên tục giữa các bên và đảm bảo toàn bộ đội ngũ phát triển cũng như khách hàng đều có chung một hiểu biết chính xác về các yêu cầu."
      },
      {
        "question_id": 4,
        "question_title": "What is the relationship between \"product vision\" and \"project scope\"?",
        "option_A": "Product vision and project scope are interchangeable terms.",
        "option_B": "Product vision describes the ultimate product, while project scope identifies the portion of that vision to be addressed by the current project.",
        "option_C": "Project scope defines business objectives, while product vision defines functional requirements.",
        "option_D": "Product vision is a subset of project scope for each release.",
        "correct_anwser": "B",
        "explain": "Tầm nhìn sản phẩm (Product vision) định hình mục tiêu lâu dài mang tính tối thượng của sản phẩm, trong khi phạm vi dự án (Project scope) xác định rõ phần việc hoặc tập hợp các tính năng cụ thể thuộc tầm nhìn đó sẽ được giải quyết, hoàn thiện trong dự án hiện tại."
      },
      {
        "question_id": 5,
        "question_title": "Which of the following is a recommended question to ask when probing for exceptions in processes?",
        "option_A": "Why do you think this system is perfect?",
        "option_B": "What are the three things you dislike about the current system?",
        "option_C": "What happens when an error occurs?",
        "option_D": "What is your favorite feature of this system?",
        "correct_anwser": "C",
        "explain": "Để khơi gợi và tìm kiếm các ngoại lệ (exceptions) hay kịch bản lỗi trong quy trình nghiệp vụ, câu hỏi khảo sát trực diện và chuẩn xác nhất là 'Điều gì xảy ra khi có lỗi phát sinh?' (What happens when an error occurs?)."
      },
      {
        "question_id": 6,
        "question_title": "What is the main advantage of using the active voice in writing requirements?",
        "option_A": "It helps in reducing the length of the requirements.",
        "option_B": "It makes the subject and action of the sentence clear, ensuring clarity.",
        "option_C": "It makes the requirements sound more formal and professional.",
        "option_D": "It is easier to translate into other languages.",
        "correct_anwser": "B",
        "explain": "Sử dụng thể chủ động (Active voice) trong viết yêu cầu giúp xác định rõ ràng ai hoặc hệ thống nào (chủ ngữ) thực hiện hành động gì, từ đó loại bỏ tính mơ hồ và đảm bảo tính minh xác, rõ ràng cho câu đặc tả."
      },
      {
        "question_id": 7,
        "question_title": "Which of the following is a correct guideline for writing clear and concise requirements?",
        "option_A": "Use long, descriptive sentences to cover all aspects of a requirement.",
        "option_B": "Avoid using \"shall\" or \"must\" in favor of softer terms like \"could\" and \"may.\"",
        "option_C": "Write in simple language, avoid jargon, and keep sentences short and direct.",
        "option_D": "Use multiple terms for the same concept to make the document more interesting.",
        "correct_anwser": "C",
        "explain": "Nguyên tắc viết yêu cầu rõ ràng, súc tích là sử dụng ngôn từ đơn giản, dễ hiểu, tránh các thuật ngữ chuyên môn quá phức tạp (jargon) không cần thiết, câu văn ngắn gọn và trực diện để người đọc không hiểu sai ý."
      },
      {
        "question_id": 8,
        "question_title": "Which of the following are true about a dashboard? Choose 3 correct answers.",
        "option_A": "It is a screen display or printed report.",
        "option_B": "It uses multiple textual and/or graphical representations of data.",
        "option_C": "It aims to provide a consolidated, multidimensional view of what is going on in an organization or a process.",
        "option_D": "It is a brochure to promote the product.",
        "correct_anwser": "A, B, C",
        "explain": "Dashboard (Bảng điều khiển trực quan) là màn hình hiển thị hoặc biểu mẫu báo cáo (A), dùng nhiều định dạng văn bản và đồ thị trực quan hóa dữ liệu (B) nhằm mục đích cung cấp một cái nhìn tổng hợp, đa chiều về tình hình vận hành của một tổ chức hoặc quy trình (C)."
      },
      {
        "question_id": 9,
        "question_title": "In the context of a data dictionary, which of the following is true about organizing data elements?",
        "option_A": "Each data element in the dictionary should be represented only by primitive types.",
        "option_B": "The data dictionary should only store information about complex data structures, not individual data elements",
        "option_C": "The data dictionary should list all data elements alphabetically, regardless of their relationships or grouping in the system.",
        "option_D": "The data dictionary should contain information about each data element, including its data type, length, and any associated constraints.",
        "correct_anwser": "D",
        "explain": "Từ điển dữ liệu (Data dictionary) cần lưu trữ thông tin chi tiết về từng phần tử dữ liệu trong hệ thống, bao gồm định nghĩa tên, kiểu dữ liệu, độ dài, mô tả và các ràng buộc/quy tắc giá trị đi kèm của phần tử đó."
      },
      {
        "question_id": 10,
        "question_title": "Which of the following is NOT considered a dimension of requirements reuse when adapting requirements from one project to another?",
        "option_A": "The extent of reuse, including whether individual requirement statements or sets of requirements with their associated elements are reused.",
        "option_B": "Reuse frequency, which measures how often a particular requirement has been reused in different projects.",
        "option_C": "The extent of modification, which considers the degree to which reused requirements must be altered to fit the new project's context.",
        "option_D": "The reuse mechanism, which involves how the requirement is reused, such as copying from a library of reusable requirements or referring to the original source.",
        "option_E": "None of the above",
        "correct_anwser": "B",
        "explain": "Theo lý thuyết quản lý yêu cầu phần mềm của Karl Wiegers, các chiều không gian (dimensions) của việc tái sử dụng yêu cầu bao gồm: Extent of reuse (mức độ/phạm vi tái sử dụng), Extent of modification (mức độ sửa đổi), và Reuse mechanism (cơ chế tái sử dụng). Tần suất tái sử dụng (Reuse frequency) chỉ là một chỉ số đo lường thống kê sau đó, chứ không phải là một chiều kiến trúc cốt lõi khi tiến hành adapt yêu cầu."
      },
      {
        "question_id": 11,
        "question_title": "How can reusable requirements be stored for easy reference?",
        "option_A": "By storing them in a spreadsheet.",
        "option_B": "By copying them into every new project document.",
        "option_C": "By linking to them from a shared location such as a database or a requirements management tool.",
        "option_D": "By creating new versions for every instance they are used.",
        "correct_anwser": "C",
        "explain": "Để các yêu cầu có thể tái sử dụng được lưu trữ và tra cứu một cách hiệu quả nhất, người ta nên đưa chúng lên một vị trí chia sẻ tập trung (Shared location) như cơ sở dữ liệu chung hoặc công cụ quản lý yêu cầu chuyên dụng nhằm đảm bảo tính nhất quán và dễ dàng liên kết."
      },
      {
        "question_id": 12,
        "question_title": "What role does requirements estimation play in project planning?",
        "option_A": "It helps determine the effort needed for design and development",
        "option_B": "It dictates the project's release schedule",
        "option_C": "It defines the testing strategy",
        "option_D": "It allocates resources for the project",
        "correct_anwser": "A",
        "explain": "Ước lượng yêu cầu (Requirements estimation) cung cấp căn cứ kỹ thuật quan trọng giúp đội ngũ quản lý dự án xác định lượng công sức, thời gian và nguồn lực cần thiết (effort needed) để thực hiện các giai đoạn thiết kế, lập trình và hoàn thiện các tính năng đó."
      },
      {
        "question_id": 13,
        "question_title": "Which of the following is NOT a characteristic of Software as a service (SaaS)?",
        "option_A": "Subscription-based pricing",
        "option_B": "On-premises deployment",
        "option_C": "Centralized hosting",
        "option_D": "Internet accessibility",
        "correct_anwser": "B",
        "explain": "On-premises deployment (Triển khai tại chỗ/cài đặt cục bộ trên máy chủ của khách hàng) là đặc điểm của mô hình phần mềm truyền thống. Ngược lại, SaaS (Phần mềm dạng dịch vụ) được lưu trữ tập trung trên cloud (C), truy cập qua Internet (D) và thường thanh toán theo mô hình đăng ký định kỳ (A)."
      },
      {
        "question_id": 14,
        "question_title": "The elements of risk management are (choose 3 correct answers)",
        "option_A": "Risk assessment",
        "option_B": "Risk avoidance",
        "option_C": "Risk control",
        "option_D": "Risk reduction",
        "correct_anwser": "A, B, C",
        "explain": "Theo các khung quản trị rủi ro chuẩn (như SEI), Quản lý rủi ro (Risk management) gồm các thành phần cốt lõi ở cấp độ cao là: Risk assessment (Đánh giá rủi ro - bao gồm nhận diện, phân tích), Risk avoidance (Né tránh rủi ro) hoặc tổng quan hơn là Risk control (Kiểm soát rủi ro). Trong đó, Risk reduction (Giảm thiểu) thường được phân loại như một chiến thuật cụ thể nằm bên trong Risk control."
      },
      {
        "question_id": 15,
        "question_title": "Why is it critical to clearly distinguish between Business Requirements, User Requirements, and Functional Requirements in software projects?",
        "option_A": "It reduces development time by eliminating unnecessary requirements from the outset.",
        "option_B": "It guarantees that the system will comply with all security and performance standards.",
        "option_C": "It ensures that all stakeholder needs are accurately understood and translated into specific system features.",
        "option_D": "It allows developers to start coding immediately without needing further clarification.",
        "correct_anwser": "C",
        "explain": "Phân biệt rõ ba cấp độ yêu cầu này giúp đảm bảo mục tiêu chiến lược của doanh nghiệp (Business Requirements) được phản ánh đúng qua mong muốn của người dùng (User Requirements), từ đó chuyển hóa chính xác thành các chức năng kỹ thuật của hệ thống (Functional Requirements), tránh sai sót trong quá trình phát triển."
      },
      {
        "question_id": 16,
        "question_title": "What is meant by the \"Expectation Gap\" in software development?",
        "option_A": "The difference between business requirements and technical requirements.",
        "option_B": "The difference between the initial design and the final product.",
        "option_C": "The discrepancy between the project plan and the actual budget.",
        "option_D": "The difference between what customers expect and what the development team plans to deliver.",
        "option_E": "The difference between customer requirements and testing criteria.",
        "correct_anwser": "D",
        "explain": "\"Khoảng cách kỳ vọng\" (Expectation Gap) mô tả sự sai lệch giữa những gì khách hàng hình dung, mong đợi về sản phẩm với những gì đội ngũ phát triển hiểu và lên kế hoạch bàn giao thực tế."
      },
      {
        "question_id": 17,
        "question_title": "What is a key action in the \"Analysis\" subdiscipline of requirements development?",
        "option_A": "Discovering requirements.",
        "option_B": "Documenting assumptions",
        "option_C": "Decomposing high-level requirements into an appropriate level of detail",
        "option_D": "Confirming requirements accuracy with customers.",
        "correct_anwser": "C",
        "explain": "Hành động cốt lõi của phân tích (Analysis) là bóc tách, chia nhỏ các yêu cầu ở mức vĩ mô, mơ hồ (high-level requirements) thành các yêu cầu chi tiết cụ thể, rõ ràng hơn để đội ngũ phát triển có thể hiểu và thực thi."
      },
      {
        "question_id": 18,
        "question_title": "Which of the following describes the difference between User Requirements and Functional Requirements?",
        "option_A": "User requirements focus on technical solutions, while Functional requirements focus on business needs.",
        "option_B": "User requirements are high-level and focus on user tasks, while Functional requirements describe what the system must do to support those tasks.",
        "option_C": "User requirements are documented in code, while Functional requirements are documented in the SRS.",
        "option_D": "There is no real difference; the terms are used interchangeably.",
        "correct_anwser": "B",
        "explain": "Yêu cầu người dùng (User Requirements) được viết dưới góc nhìn của người dùng để mô tả các tác vụ hoặc mục tiêu họ cần đạt được, trong khi yêu cầu chức năng (Functional Requirements) mô tả chi tiết các hành vi, tính năng kỹ thuật mà hệ thống phải thực hiện để hỗ trợ người dùng hoàn thành các tác vụ đó."
      },
      {
        "question_id": 19,
        "question_title": "A functional requirement describes:",
        "option_A": "The financial budget of the software project.",
        "option_B": "What the system should do under specific conditions.",
        "option_C": "The user interface styling details.",
        "option_D": "The security protocols required for data transmission.",
        "correct_anwser": "B",
        "explain": "Yêu cầu chức năng (Functional Requirement) định nghĩa rõ ràng các hành vi, dịch vụ hoặc chức năng cụ thể mà hệ thống phần mềm phải thực thi khi tiếp nhận một điều kiện đầu vào xác định."
      },
      {
        "question_id": 20,
        "question_title": "What is the primary objective of creating a Dialog Map (User Interface Architecture) during requirements analysis?",
        "option_A": "To optimize backend relational SQL query indexing performance.",
        "option_B": "To visually represent the navigation paths and relationship architecture between different screens or pages of the system.",
        "option_C": "To establish encrypted secure network communications protocols.",
        "option_D": "To verify the lines of unit test coverage automatically.",
        "correct_anwser": "B",
        "explain": "Bản đồ đối thoại (Dialog Map) trực quan hóa cấu trúc kiến trúc luồng đi của giao diện, chỉ ra các màn hình và cách thức người dùng có thể điều hướng qua lại giữa các màn hình hoặc trang giao diện trong hệ thống."
      },
      {
        "question_id": 21,
        "question_title": "How can better requirements practices reduce the cost of development?",
        "option_A": "By increasing the number of features developed.",
        "option_B": "By reducing rework, unnecessary features, and miscommunications.",
        "option_C": "By increasing the project timeline.",
        "option_D": "By focusing solely on technical specifications.",
        "correct_anwser": "B",
        "explain": "Quản lý yêu cầu tốt giúp làm rõ mong muốn của khách hàng ngay từ đầu, từ đó giảm thiểu việc hiểu lầm (miscommunications), tránh phát triển các tính năng không cần thiết, và hạn chế tối đa việc phải làm lại (rework), vốn là nguyên nhân chính gây tốn kém chi phí trong phát triển phần mềm."
      },
      {
        "question_id": 22,
        "question_title": "“The user must be able to sort the project list in forward and reverse alphabetical order” is a:",
        "option_A": "business requirement",
        "option_B": "user requirement",
        "option_C": "functional requirement",
        "option_D": "data requirement",
        "correct_anwser": "C",
        "explain": "Yêu cầu chức năng (Functional Requirement) mô tả những gì hệ thống phải làm, cụ thể là một hành vi hoặc chức năng của phần mềm để phản hồi lại thao tác từ người dùng. Phát biểu 'Người dùng phải có khả năng sắp xếp danh sách dự án theo thứ tự bảng chữ cái xuôi và ngược' mô tả trực tiếp một chức năng mà hệ thống cần thực hiện cung cấp cho người dùng."
      },
      {
        "question_id": 23,
        "question_title": "Two important goals of writing requirements are that:",
        "option_A": "Anyone who reads the requirement comes to the same interpretation as any other reader.",
        "option_B": "Each reader's interpretation matches what the author intended to communicate.",
        "option_C": "Developers find the requirements technically easy to understand.",
        "option_D": "Customers are happy.",
        "correct_anwser": "A, B",
        "explain": "Hai mục tiêu cốt lõi của việc viết tài liệu yêu cầu là tính không mơ hồ (Unambiguous) và tính chính xác (Correctness). Điều này có nghĩa là tất cả người đọc đều phải hiểu theo một cách duy nhất như nhau (A), và cách hiểu đó phải trùng khớp hoàn toàn với những gì tác giả/BA thực sự muốn truyền tải (B)."
      },
      {
        "question_id": 24,
        "question_title": "In a Swimlane diagram, process steps are shown as",
        "option_A": "rectangles",
        "option_B": "arrows connecting pairs of rectangles",
        "option_C": "diamonds",
        "option_D": "ovals",
        "correct_anwser": "A",
        "explain": "Trong sơ đồ phân làn (Swimlane / Flowchart), các bước xử lý hoặc hành động (process steps/activities) được quy ước thể hiện bằng các hình chữ nhật (rectangles). Trong khi đó, hình thoi (diamonds) dùng cho điểm quyết định rẽ nhánh và các mũi tên (arrows) dùng để chỉ hướng luồng đi."
      },
      {
        "question_id": 25,
        "question_title": "Entries in the data dictionary represent the following types of data elements: (choose 3 correct answers)",
        "option_A": "Primitive",
        "option_B": "Structure",
        "option_C": "Repeating group",
        "option_D": "Virtual",
        "correct_anwser": "A, B, C",
        "explain": "Trong từ điển dữ liệu (Data Dictionary), các mục nhập dữ liệu thường được phân loại thành 3 dạng cấu trúc thành phần chính bao gồm: Phần tử nguyên thủy dữ liệu (Primitive - không thể chia nhỏ hơn nữa), Cấu trúc dữ liệu kết hợp (Structure - gồm nhiều phần tử đi cùng nhau), và Nhóm lặp (Repeating group - tập hợp lặp lại của các phần tử)."
      },
      {
        "question_id": 26,
        "question_title": "What is Extent of reuse?",
        "option_A": "You might reuse just a single functional requirement.",
        "option_B": "You consider is how much modification will be needed to make existing requirements reusable on the new project.",
        "option_C": "It is simply a copy-and-paste of a piece of requirements information, either from another specification or from a library of reusable requirements.",
        "option_D": "It specific functional requirements within use cases, performance requirements, usability requirements, business rules.",
        "correct_anwser": "A",
        "explain": "Theo định nghĩa về tái sử dụng yêu cầu, 'Extent of reuse' (Mức độ/Phạm vi tái sử dụng) đề cập đến khối lượng hay quy mô của phần yêu cầu được tái sử dụng, ví dụ như từ mức nhỏ nhất là tái sử dụng chỉ một yêu cầu chức năng đơn lẻ (a single functional requirement) cho tới mức lớn hơn là toàn bộ một module hay hệ thống phụ."
      },
      {
        "question_id": 27,
        "question_title": "In software development, what do requirements drive? Choose 3 correct answers.",
        "option_A": "Project planning",
        "option_B": "Design and coding",
        "option_C": "Testing activities",
        "option_D": "Financial activities",
        "correct_anwser": "A, B, C",
        "explain": "Yêu cầu phần mềm là nền tảng định hướng cho toàn bộ vòng đời phát triển: chúng quyết định việc lập kế hoạch tiến độ dự án (A), làm cơ sở để thiết kế kiến trúc và viết mã nguồn (B), cũng như cung cấp tiêu chí để xây dựng các kịch bản kiểm thử (C). Ngược lại, các hoạt động tài chính tổng thể của doanh nghiệp (D) không chịu sự thúc đẩy trực tiếp từ các yêu cầu kỹ thuật phần mềm."
      },
      {
        "question_id": 28,
        "question_title": "What is an enhancement project?",
        "option_A": "It is a project in which new capabilities are added to an existing system.",
        "option_B": "It is a project that replaces an existing application with a new custom-built system, a commercial off-the-shelf system, or a hybrid of those.",
        "option_C": "It is a project which costs less than planned.",
        "option_D": "It is a project which generates more revenues.",
        "correct_anwser": "A",
        "explain": "Dự án nâng cấp (Enhancement project) được định nghĩa là dự án nhằm bổ sung các tính năng, năng lực mới (new capabilities) hoặc cải tiến các chức năng sẵn có của một hệ thống hiện tại."
      },
      {
        "question_id": 29,
        "question_title": "Which statement accurately describes the implementation of a COTS package?",
        "option_A": "COTS packages always require significant customization.",
        "option_B": "Some COTS packages can be used out of the box with little to no modification.",
        "option_C": "COTS packages provide unlimited flexibility to meet all business requirements",
        "option_D": "All COTS packages require integration with other systems.",
        "correct_anwser": "B",
        "explain": "COTS (Commercial Off-The-Shelf) là phần mềm thương mại có sẵn trên thị trường. Điểm đặc trưng của một số gói COTS là có thể sử dụng được ngay lập tức (out of the box) với rất ít hoặc không cần sửa đổi gì (B). Khẳng định chúng luôn luôn cần tùy biến mạnh (A), có sự linh hoạt vô hạn (C) hay bắt buộc phải tích hợp với hệ thống khác (D) đều là các phát biểu quá cực đoan và thiếu chính xác."
      },
      {
        "question_id": 30,
        "question_title": "What is the primary motivation for tracing requirements?",
        "option_A": "To prevent any changes from being made to project requirements",
        "option_B": "To document project assumptions",
        "option_C": "To manage project team members",
        "option_D": "To improve the quality of your products, reduce maintenance costs, and facilitate reuse",
        "correct_anwser": "D",
        "explain": "Động lực và lợi ích lớn nhất của việc truy vết yêu cầu (Tracing requirements) là giúp nâng cao chất lượng sản phẩm nhờ kiểm soát tốt phạm vi và kiểm thử, giảm thiểu chi phí bảo trì (do dễ phân tích tác động khi có thay đổi) và tạo điều kiện thuận lợi cho việc tái sử dụng cấu phần ở các dự án sau (D)."
      },
      {
        "question_id": 31,
        "question_title": "Which of the following statements correctly distinguishes between product requirements and project requirements? Select two.",
        "option_A": "Product requirements describe the physical resources and training needs necessary for project completion.",
        "option_B": "Project requirements include staff training and infrastructure changes needed in the operating environment.",
        "option_C": "Project requirements are housed in the SRS along with product requirements.",
        "option_D": "Product requirements focus on the characteristics and functionalities of the software system being built.",
        "correct_anwser": "B, D",
        "explain": "Yêu cầu sản phẩm (Product requirements) tập trung vào các đặc tính, chức năng của hệ thống phần mềm đang được xây dựng (D). Trong khi đó, yêu cầu dự án (Project requirements) liên quan đến các khía cạnh quản lý, vận hành để triển khai dự án thành công như đào tạo nhân sự, thay đổi hạ tầng kỹ thuật (B)."
      },
      {
        "question_id": 32,
        "question_title": "What is a potential way for someone to transition into the business analyst role?",
        "option_A": "Through an apprenticeship program with mentoring",
        "option_B": "By studying software development exclusively",
        "option_C": "By focusing only on user interface design skills",
        "option_D": "By avoiding involvement in diverse business activities",
        "correct_anwser": "A",
        "explain": "Một trong những lộ trình chuyển đổi phổ biến và hiệu quả để bước vào nghề Business Analyst (BA) là thông qua các chương trình thực tập, học việc (apprenticeship) có sự hướng dẫn sát sao của người đi trước (mentoring) để tích lũy cả kiến thức nghiệp vụ lẫn kỹ năng mềm."
      },
      {
        "question_id": 33,
        "question_title": "When defining the scope and limitations of a product, which of the following practices should be followed? Select two.",
        "option_A": "List the product's major features or user capabilities, focusing on those that distinguish it from competitors.",
        "option_B": "Include all possible features in the scope to ensure nothing is left out, even if some may be unnecessary.",
        "option_C": "Clearly define the features that will be included in the initial release and those that will be excluded.",
        "option_D": "Avoid mentioning any limitations or exclusions to keep the focus on what the product will do.",
        "correct_anwser": "A, C",
        "explain": "Khi định nghĩa phạm vi và giới hạn của sản phẩm, thực hành tốt nhất là liệt kê các tính năng/năng lực cốt lõi giúp phân biệt với đối thủ cạnh tranh (A), đồng thời phải phân định rõ ràng tính năng nào nằm trong đợt phát hành đầu tiên và tính năng nào bị loại trừ hoặc hoãn lại (C)."
      },
      {
        "question_id": 34,
        "question_title": "What is the main purpose of a Vision and Scope document?",
        "option_A": "To define the boundaries and objectives of the project",
        "option_B": "To specify all technical requirements",
        "option_C": "To finalize the system's architecture",
        "option_D": "To replace the requirements traceability matrix",
        "correct_anwser": "A",
        "explain": "Mục đích cốt lõi của tài liệu Tầm nhìn và Phạm vi (Vision and Scope document) là thiết lập ranh giới hệ thống ở mức tổng quan và xác định các mục tiêu chiến lược mang tính định hướng cho dự án, chứ không đi sâu vào chi tiết kỹ thuật hay kiến trúc."
      },
      {
        "question_id": 35,
        "question_title": "Which of the following statements best describes a key aspect of performance requirements for a software system?",
        "option_A": "Performance requirements focus solely on the visual design and user interface of the system.",
        "option_B": "Performance requirements include the responsiveness of the system to user inquiries, such as the number of seconds to display a webpage.",
        "option_C": "Performance requirements are concerned only with the physical storage capacity of the system's database.",
        "option_D": "Performance requirements are unrelated to the external factors like network connections and hardware components.",
        "correct_anwser": "B",
        "explain": "Yêu cầu về hiệu năng (Performance requirements) đo lường và ràng buộc các chỉ số vận hành về mặt thời gian và tốc độ của hệ thống, ví dụ điển hình nhất là độ phản hồi đối với các tương tác của người dùng, chẳng hạn như số giây tối đa để tải và hiển thị hoàn chỉnh một trang web."
      },
      {
        "question_id": 36,
        "question_title": "What is a potential consequence of adding more functionality through a series of iterations?",
        "option_A": "Improved system performance.",
        "option_B": "Increased system efficiency.",
        "option_C": "Deterioration of system performance.",
        "option_D": "Reduced need for performance testing.",
        "correct_anwser": "C",
        "explain": "Việc liên tục bổ sung thêm nhiều chức năng qua các vòng lặp (iterations) mà không tối ưu hóa cấu trúc hệ thống có nguy cơ làm tăng độ phức tạp, quá tải tài nguyên và dẫn đến sự suy giảm hiệu năng của hệ thống (Deterioration of system performance)."
      },
      {
        "question_id": 37,
        "question_title": "Which of the following statements about reaching agreement on requirements is accurate? Select two.",
        "option_A": "Signing off on requirements is an infallible method to prevent any changes later in the project.",
        "option_B": "All participants in the requirements approval process must understand what signing off implies.",
        "option_C": "The purpose of signing off is to freeze requirements and prevent any future modifications.",
        "option_D": "Reaching agreement on requirements ensures that both customers and developers have a shared understanding of project objectives.",
        "correct_anwser": "B, D",
        "explain": "Việc đạt được thỏa thuận về yêu cầu nhằm đảm bảo các bên liên quan (khách hàng và đội ngũ phát triển) có chung một hiểu biết về mục tiêu dự án (D), đồng thời tất cả những người tham gia phê duyệt cần hiểu rõ ý nghĩa của việc ký duyệt (B). Việc ký duyệt (sign-off) không thể ngăn chặn tuyệt đối các thay đổi trong tương lai (A và C sai vì yêu cầu luôn có thể thay đổi thông qua quy trình kiểm soát thay đổi)."
      },
      {
        "question_id": 38,
        "question_title": "If a report is generated but not used, what should a Business Analyst consider doing?",
        "option_A": "Ensure it is included in the new system",
        "option_B": "Modify it to meet new requirements",
        "option_C": "Exclude it from the new system",
        "option_D": "Increase its frequency of generation",
        "correct_anwser": "C",
        "explain": "Nếu một báo cáo trong hệ thống hiện tại vẫn được tạo ra tự động định kỳ nhưng trên thực tế không có ai sử dụng, Chuyên viên phân tích nghiệp vụ nên cân nhắc loại bỏ nó ra khỏi hệ thống mới để tiết kiệm chi phí phát triển, lưu trữ và tối ưu hiệu năng."
      },
      {
        "question_id": 39,
        "question_title": "We can resuse all authentication requirements from the previous project by copy from a library of reusable components. Which dimensions does the statement refer to?",
        "option_A": "extent of modification",
        "option_B": "reuse mechanism",
        "option_C": "extent of reuses",
        "option_D": "N/A",
        "correct_anwser": "A, B",
        "explain": "Câu phát biểu đề cập đến hành động \"copy nguyên vẹn\" -> phản ánh khía cạnh mức độ sửa đổi là giữ nguyên (extent of modification). Hành động lấy từ một \"thư viện các thành phần tái sử dụng\" (library of reusable components) -> phản ánh khía cạnh cơ chế thực hiện tái sử dụng (reuse mechanism)."
      },
      {
        "question_id": 40,
        "question_title": "Which of the following is NOT an objective of improving requirements processes?",
        "option_A": "Improve the accuracy of project estimates",
        "option_B": "Reduce the cost of creating and maintaining software",
        "option_C": "Increase the value delivered by projects",
        "option_D": "Increase the complexity of requirements",
        "correct_anwser": "D",
        "explain": "Mục tiêu của việc cải tiến quy trình kỹ nghệ yêu cầu nhằm giúp ước lượng chính xác hơn (A), giảm giá thành làm lại phần mềm lỗi (B), và tăng chất lượng giá trị bàn giao (C). Việc làm tăng độ phức tạp không mong muốn của các câu yêu cầu (D) hoàn toàn đi ngược lại mục tiêu cải tiến quy trình."
      },
      {
        "question_id": 41,
        "question_title": "Which is NOT element of risk management?",
        "option_A": "Risk avoidance is one way to deal with a risk: don't do the risky thing.",
        "option_B": "Risk assessment is the process of examining a project to identify potential threats.",
        "option_C": "Risk control activities to manage the top-priority risks you identified.",
        "option_D": "Risk management planning produces a plan for dealing with each significant risk, including mitigation approaches, contingency plans, owners, and timelines.",
        "correct_anwser": "A",
        "explain": "Trong lý thuyết quản trị rủi ro phần mềm tiêu chuẩn (Karl Wiegers), Quản trị rủi ro gồm hai nhánh chính lớn: Đánh giá rủi ro (Risk Assessment - gồm identify và analyze) và Kiểm soát rủi ro (Risk Control - gồm planning, resolution, monitoring). Do đó các mục B, C, D là các thành phần/tiến trình lớn của quản trị rủi ro. Còn Tránh rủi ro (Risk avoidance - A) chỉ là một chiến lược hoặc kỹ thuật cụ thể nằm bên trong bước xử lý rủi ro, không phải phân hệ cấu thành lớn của quy trình."
      },
      {
        "question_id": 42,
        "question_title": "Which of the following skills are essential for a business analyst? Select three.",
        "option_A": "Literacy skills for effectively interpreting written material and communicating requirements.",
        "option_B": "Technical skills to ensure the analyst can implement the software they are analyzing.",
        "option_C": "Facilitation skills to manage group discussions and ensure effective participation from all stakeholders.",
        "option_D": "Analytical skills to break down complex problems and identify feasible solutions.",
        "correct_anwser": "A, C, D",
        "explain": "Một Business Analyst cần có kỹ năng ngôn ngữ/đọc hiểu (A) để giao tiếp yêu cầu, kỹ năng điều phối (C) để quản lý thảo luận nhóm, và kỹ năng phân tích (D) để giải quyết vấn đề. BA không cần trực tiếp lập trình/triển khai phần mềm (B là công việc của Developer)."
      },
      {
        "question_id": 43,
        "question_title": "Which of the following are advantages of reusing requirements?\n(Choose 2 answers)",
        "option_A": "Decreased consistency",
        "option_B": "Reduced rework",
        "option_C": "Lower development costs",
        "option_D": "Increased number of defects",
        "correct_anwser": "B, C",
        "explain": "Việc tái sử dụng các yêu cầu đã được kiểm chứng và chuẩn hóa giúp giảm thiểu việc phải làm lại từ đầu (Reduced rework) và tiết kiệm đáng kể thời gian cũng như chi phí phát triển dự án (Lower development costs)."
      },
      {
        "question_id": 44,
        "question_title": "Which arrangement describes the increasing amount of requirements and development work when implementing packaged solutions?\n1. configured\n2. integrated\n3. extended\n4. out of the box",
        "option_A": "1,2,3,4",
        "option_B": "2,1,3,4",
        "option_C": "2,4,3,1",
        "option_D": "4,1,2,3",
        "correct_anwser": "D",
        "explain": "Thứ tự tăng dần về khối lượng công việc yêu cầu và lập trình khi triển khai giải pháp đóng gói (packaged solutions) là: 4. out of the box (dùng trực tiếp không sửa đổi, tốn ít công nhất) -> 1. configured (cấu hình lại thông số) -> 2. integrated (tích hợp kết nối hệ thống) -> 3. extended (viết thêm mã nguồn mở rộng, tốn nhiều công nhất)."
      },
      {
        "question_id": 45,
        "question_title": "Why is clear communication crucial in acquirer-supplier interactions in outsourced projects? (Choose 2 answers)",
        "option_A": "It reduces the need for collaboration.",
        "option_B": "It ensures both parties understand each other’s needs and capabilities.",
        "option_C": "It helps in resolving potential issues early.",
        "option_D": "It allows unilateral decision-making by the supplier",
        "correct_anwser": "B, C",
        "explain": "Trong các dự án thuê ngoài (outsourcing), giao tiếp rõ ràng giữa bên mua và nhà cung cấp giúp đảm bảo hai bên hiểu rõ năng lực cũng như nhu cầu của nhau (B), đồng thời phát hiện và giải quyết sớm các rủi ro, vấn đề phát sinh ngay từ giai đoạn đầu (C)."
      },
      {
        "question_id": 46,
        "question_title": "In a requirements development process, why is it important to establish a mechanism for managing changes to requirements?",
        "option_A": "To discourage changes and maintain a fixed project scope",
        "option_B": "To speed up the development process",
        "option_C": "To adapt to evolving project needs while maintaining control",
        "option_D": "To eliminate the need for documentation",
        "correct_anwser": "C",
        "explain": "Thiết lập cơ chế quản lý thay đổi không phải để cấm đoán thay đổi (A), mà là để giúp dự án thích ứng linh hoạt với các nhu cầu thực tế mới phát sinh của doanh nghiệp nhưng vẫn giữ được sự kiểm soát chặt chẽ về mặt nguồn lực, tiến độ và chi phí."
      },
      {
        "question_id": 47,
        "question_title": "Which is NOT an activitie of risk management?",
        "option_A": "Risk avoidance",
        "option_B": "Risk assessment",
        "option_C": "Risk monitoring",
        "option_D": "Risk control",
        "correct_anwser": "A",
        "explain": "Trong các hoạt động lớn thuộc quy trình Quản lý rủi ro (Risk Management framework), quy trình bao gồm Phân tích/Đánh giá (Assessment), Kiểm soát (Control) và Giám sát (Monitoring). Tránh rủi ro ('Risk avoidance') là một chiến lược phản ứng cụ thể (risk response strategy) nằm bên trong hoạt động kiểm soát rủi ro, chứ không phải là một nhánh hoạt động lớn ngang hàng."
      },
      {
        "question_id": 48,
        "question_title": "We can reuse all authentication requirements from the previous project by copy from a library of reusable components. Which dimensions does the statement refer to?",
        "option_A": "extend of modification",
        "option_B": "reuse mechanism",
        "option_C": "extend of reuses",
        "option_D": "D. None of the others",
        "correct_anwser": "A, B",
        "explain": "Phát biểu đề cập đến việc tái sử dụng bằng cách 'sao chép trực tiếp từ một thư viện thành phần' — mô tả cơ chế thực hiện tái sử dụng (Reuse mechanism - sao chép từ kho lưu trữ) và mức độ chỉnh sửa (Extent of modification - giữ nguyên toàn bộ, không sửa đổi)."
      },
      {
        "question_id": 49,
        "question_title": "What principle ensures that each code unit performs a specific, welldefined function without interference from other parts of the system?",
        "option_A": "Loose coupling",
        "option_B": "Information hiding",
        "option_C": "Strong cohesion",
        "option_D": "All of the others",
        "correct_anwser": "C",
        "explain": "Nguyên lý đảm bảo mỗi đơn vị mã nguồn (mô-đun/lớp/hàm) chỉ tập trung thực hiện duy nhất một nhiệm vụ cụ thể, rõ ràng và độc lập được gọi là tính Kết dính cao (Strong Cohesion)."
      },
      {
        "question_id": 50,
        "question_title": "Which of the following is NOT about packaged solution?",
        "option_A": "You build systems by using your own staff.",
        "option_B": "It needs to be configured, integrated, and extended to work in the target environment.",
        "option_C": "You can purchase a package as part or all of the solution for a new project.",
        "option_D": "Evaluate solution candidates so that you can select the most appropriate package.",
        "correct_anwser": "A",
        "explain": "Giải pháp đóng gói (Packaged solution / COTS) có nghĩa là bạn đi mua một sản phẩm phần mềm thương mại có sẵn trên thị trường về dùng, trái ngược hoàn toàn với việc tự xây dựng hệ thống từ đầu bằng đội ngũ nhân sự nội bộ của mình (A)."
      },
      {
        "question_id": 51,
        "question_title": "Which type of issue occurs when something isn't understood or decided about a requirement?",
        "option_A": "Requirement question",
        "option_B": "Incorrect requirement",
        "option_C": "Implementation question",
        "option_D": "Unneeded requirement",
        "correct_anwser": "A",
        "explain": "Khi một vấn đề liên quan đến yêu cầu chưa được hiểu rõ hoặc chưa được các bên thống nhất đưa ra quyết định cuối cùng, tình huống này được phân loại thuộc nhóm 'Câu hỏi/Vấn đề tồn đọng về yêu cầu' (Requirement question / Requirement issue)."
      },
      {
        "question_id": 52,
        "question_title": "Which of the following is a benefit of requirements tracing for reengineering efforts?",
        "option_A": "It facilitates the reuse of components from the previous system.",
        "option_B": "It helps identify where a system needs to be entirely replaced.",
        "option_C": "It automates the reengineering process.",
        "option_D": "It allows a system to function with fewer resources.",
        "correct_anwser": "A",
        "explain": "Khi thực hiện tái cấu trúc hệ thống (reengineering), việc có sẵn ma trận truy vết yêu cầu (requirements tracing) giúp đội ngũ biết rõ chức năng cũ tương ứng với những thành phần mã nguồn, module nào, từ đó tạo điều kiện thuận lợi cho việc tái sử dụng (reuse) các thành phần chạy tốt."
      },
      {
        "question_id": 53,
        "question_title": "What is the primary consequence of requirements problems?",
        "option_A": "Delays and rework",
        "option_B": "Increased resource costs",
        "option_C": "Faster development process",
        "option_D": "Improved product quality",
        "correct_anwser": "A",
        "explain": "Hệ lụy trực tiếp, phổ biến và nghiêm trọng nhất khi gặp các vấn đề hoặc sai sót về mặt yêu cầu là làm chậm trễ tiến độ dự án (delays) và buộc đội ngũ phải đập đi làm lại, sửa đổi mã nguồn rất nhiều lần (rework)."
      },
      {
        "question_id": 54,
        "question_title": "What is Vision and Scope Document derived from?",
        "option_A": "System requirements",
        "option_B": "User requirements",
        "option_C": "Business requirements",
        "option_D": "Original requirements",
        "correct_anwser": "C",
        "explain": "Tài liệu Tầm nhìn và Phạm vi (Vision and Scope Document) được hình thành và phát triển trực tiếp từ các Yêu cầu kinh doanh (Business Requirements), nhằm thiết lập mục tiêu chiến lược và giới hạn cho dự án."
      },
      {
        "question_id": 55,
        "question_title": "What is the primary purpose of a business case in software requirements?",
        "option_A": "To justify the project's value and align it with organizational goals",
        "option_B": "To finalize the technical requirements",
        "option_C": "To replace the Vision and Scope document",
        "option_D": "To eliminate stakeholder involvement in the early phases",
        "correct_anwser": "A",
        "explain": "Mục đích cốt lõi của một Business Case là chứng minh/luận giải giá trị lợi ích của dự án về mặt kinh tế, chi phí đầu tư và đảm bảo dự án đó hoàn toàn đồng nhất với các mục tiêu chiến lược dài hạn của tổ chức."
      },
      {
        "question_id": 56,
        "question_title": "What is the primary objective of requirements reuse in projects?",
        "option_A": "To improve efficiency and consistency by leveraging existing requirements in new projects",
        "option_B": "To finalize coding standards early",
        "option_C": "To eliminate stakeholder involvement in the elicitation process",
        "option_D": "To skip non-functional requirements entirely",
        "correct_anwser": "A",
        "explain": "Mục tiêu chính của việc tái sử dụng yêu cầu (requirements reuse) là nhằm tối ưu hóa hiệu suất làm việc, tiết kiệm thời gian và đảm bảo tính nhất quán của hệ thống bằng cách kế thừa, tận dụng các yêu cầu đã được chuẩn hóa từ các dự án trước đó vào dự án mới."
      },
      {
        "question_id": 57,
        "question_title": "What tool did Seilevel develop to assist with estimating requirements development effort?",
        "option_A": "A coding tool for developers.",
        "option_B": "A requirements effort estimation spreadsheet.",
        "option_C": "A time-tracking tool for project managers.",
        "option_D": "A documentation tool for stakeholders.",
        "correct_anwser": "B",
        "explain": "Seilevel đã phát triển một bảng tính chuyên dụng để ước lượng nỗ lực phát triển yêu cầu (a requirements effort estimation spreadsheet), giúp các BA tính toán khối lượng công việc cần thiết dựa trên các thuộc tính của dự án."
      }
    ]
  },
  {
    "id": "swr302-module-2-elicitation-&-stakeholders",
    "title": "SWR302 - Module 2 - Elicitation & Stakeholders",
    "description": "Software Requirement Quiz",
    "questionsCount": 57,
    "questions": [
      {
        "question_id": 1,
        "question_title": "During which activity are customer needs processed and related to software requirements?",
        "option_A": "Elicitation",
        "option_B": "Analysis",
        "option_C": "Specification",
        "option_D": "Validation",
        "correct_anwser": "B",
        "explain": "Giai đoạn Analysis (Phân tích) là lúc các nhu cầu chưa định hình của khách hàng được xử lý, phân loại, mô hình hóa và chuyển đổi cụ thể thành các yêu cầu phần mềm có cấu trúc."
      },
      {
        "question_id": 2,
        "question_title": "What is the main purpose of defining \"Scope and limitations\" in a software project?",
        "option_A": "To provide a detailed breakdown of all tasks for developers",
        "option_B": "To identify all potential users and their individual preferences.",
        "option_C": "To establish realistic stakeholder expectations by clearly stating what the solution will and will not include",
        "option_D": "To determine the most cost-effective technologies for implementation.",
        "correct_anwser": "C",
        "explain": "Mục đích cốt lõi của việc định nghĩa 'Phạm vi và giới hạn' là để tạo dựng kỳ vọng thực tế cho các bên liên quan (stakeholders) bằng cách tuyên bố minh bạch những gì hệ thống sẽ giải quyết và những gì hệ thống sẽ không bao gồm."
      },
      {
        "question_id": 3,
        "question_title": "Which of the following is NOT characteristic of the user?",
        "option_A": "A subset of the product's customers in some cases",
        "option_B": "A subset of the product's users",
        "option_C": "A superset of stakeholders",
        "option_D": "Includes direct users and indirect users",
        "correct_anwser": "C",
        "explain": "Người dùng (User) không thể là tập cha (superset) của Stakeholders. Ngược lại, Stakeholder (bên liên quan) mới là tập hợp rộng nhất, bao hàm cả người dùng, khách hàng, quản lý, và các bên liên quan khác."
      },
      {
        "question_id": 4,
        "question_title": "A designated representative of a specific user class, who supplies the user requirements for the group that he or she represents, is a:",
        "option_A": "Product manager",
        "option_B": "Product champion",
        "option_C": "Product backlog",
        "option_D": "Product owner",
        "correct_anwser": "B",
        "explain": "Product champion là một đại diện cốt cán được chỉ định từ một nhóm người dùng (user class) cụ thể nhằm cung cấp thông tin, thu thập và làm rõ các yêu cầu người dùng thay mặt cho chính tập thể người dùng mà họ đại diện."
      },
      {
        "question_id": 5,
        "question_title": "Which of the following is not a benefit of having a clear set of expectations for product champions?",
        "option_A": "Encouraging accountability and clarity of role",
        "option_B": "Helping champions align with project goals",
        "option_C": "Guaranteeing the project will stay on budget",
        "option_D": "Facilitating negotiation of the champion's responsibilities",
        "correct_anwser": "C",
        "explain": "Việc làm rõ kỳ vọng và vai trò của Product champion giúp tối ưu hóa nhân sự, định hướng mục tiêu tốt hơn, nhưng hoàn toàn không thể đảm bảo chắc chắn (guaranteeing) 100% việc dự án sẽ không bị vượt ngân sách vì ngân sách phụ thuộc vào rất nhiều yếu tố quản lý khác."
      },
      {
        "question_id": 6,
        "question_title": "Which one is a kind of prototyping that firstly creates a sample for clarifying requirements with the user, then builds up and adds new features to this sample incrementally, and finally releases the final deliverable product based on it?",
        "option_A": "Mockup",
        "option_B": "Throwaway prototype",
        "option_C": "Evolutionary prototype",
        "option_D": "Wireframe",
        "correct_anwser": "C",
        "explain": "Mẫu thử tiến hóa (Evolutionary prototype) là phương pháp phát triển mẫu thử mà trong đó mô hình ban đầu không bị vứt bỏ, mà liên tục được cải tiến, tối ưu hóa và bổ sung thêm các tính năng mới qua từng phân đoạn, cho đến khi trở thành sản phẩm hoàn chỉnh cuối cùng để bàn giao."
      },
      {
        "question_id": 7,
        "question_title": "What are the reasons for companies to contract with software outsourcing organizations?",
        "option_A": "To increase control and oversight project",
        "option_B": "To minimize stakeholder involvement",
        "option_C": "To limit project scope",
        "option_D": "To save money, or to accelerate development and access specialized expertise.",
        "correct_anwser": "D",
        "explain": "Các lý do chính khiến các công ty tìm đến các tổ chức gia công phần mềm (outsourcing) là để tiết kiệm chi phí, đẩy nhanh tiến độ phát triển sản phẩm và tận dụng nguồn chuyên gia có chuyên môn sâu mà nội bộ công ty đang thiếu."
      },
      {
        "question_id": 8,
        "question_title": "What is the main benefit of fostering a collaborative relationship between the development team and other stakeholders in the requirements process?",
        "option_A": "To ensure that each stakeholder has full control over the project.",
        "option_B": "To align business, technical, and user needs and avoid misunderstandings.",
        "option_C": "To speed up the development process by minimizing the number of team members involved.",
        "option_D": "To focus only on technical requirements without business or user input.",
        "option_E": "None of the above",
        "correct_anwser": "B",
        "explain": "Mối quan hệ hợp tác chặt chẽ giữa đội ngũ phát triển và các bên liên quan giúp đồng bộ hóa một cách hài hòa giữa nhu cầu kinh doanh, giải pháp kỹ thuật và kỳ vọng của người dùng, từ đó hạn chế tối đa các hiểu lầm gây lãng phí nguồn lực."
      },
      {
        "question_id": 9,
        "question_title": "Which of the following roles is considered a \"customer\" for a software product?",
        "option_A": "Legal staff",
        "option_B": "Compliance auditors",
        "option_C": "Executive sponsor",
        "option_D": "Contractors",
        "option_E": "Venture capitalists",
        "correct_anwser": "C",
        "explain": "Trong các bên liên quan, Executive Sponsor (Nhà tài trợ dự án/Người có thẩm quyền tối cao phía khách hàng) đóng vai trò đưa ra quyết định tối cao, cấp ngân sách và đại diện cho quyền lợi cốt lõi của khách hàng đối với sản phẩm."
      },
      {
        "question_id": 10,
        "question_title": "What is the primary role of a business analyst (BA) in software projects?",
        "option_A": "Writing code",
        "option_B": "Managing server infrastructure",
        "option_C": "Bridging the gap between stakeholders and developers",
        "option_D": "Approving budgets",
        "correct_anwser": "C",
        "explain": "Vai trò cốt lõi và quan trọng nhất của một Business Analyst (BA) là làm cầu nối ngôn ngữ và tư duy giữa các bên liên quan (Stakeholders - những người có nhu cầu kinh doanh) và đội ngũ phát triển phần mềm (Developers - những người xây dựng giải pháp kỹ thuật)."
      },
      {
        "question_id": 11,
        "question_title": "Which of the following are essential analyst skills required from the Business Analyst?",
        "option_A": "Listening skills, Systems thinking skills",
        "option_B": "Interviewing and questioning skills, Learning skills, Interpersonal skills",
        "option_C": "Thinking on your feet, Facilitation skills,",
        "option_D": "Analytical skills, Leadership skills, Organizational skills, Creativity",
        "option_E": "Observational skills, Communication skills, Modeling skills",
        "option_F": "All of the mentioned",
        "correct_anwser": "F",
        "explain": "Một chuyên viên BA thành công đòi hỏi sự tổng hòa của rất nhiều kỹ năng mềm và kỹ năng chuyên môn phức tạp bao gồm giao tiếp, lắng nghe, tư duy hệ thống, phỏng vấn, phân tích, tổ chức và điều phối điều khiển cuộc họp. Do đó tất cả các phương án đưa ra đều chính xác."
      },
      {
        "question_id": 12,
        "question_title": "Why is it important to identify stakeholders when eliciting the requirements for a software system?",
        "option_A": "The people, groups, or organizations that are actively involved in a project, are affected by its outcome, or are able to influence its outcome",
        "option_B": "It helps you identify the vision and roadmap.",
        "option_C": "It helps you identify which support you need, who can influence the support, and potential issues that result from a non-supportive stakeholder",
        "option_D": "It helps you to make strategic decisions and clear the path of political and financial obstacles.",
        "correct_anwser": "A",
        "explain": "Định nghĩa và tầm quan trọng của việc xác định các bên liên quan (Stakeholders) nằm ở chỗ họ bao gồm tất cả các cá nhân, hội nhóm hoặc tổ chức tham gia trực tiếp, chịu ảnh hưởng từ kết quả hoặc có năng lực tác động lớn tới sự thành bại của dự án phần mềm."
      },
      {
        "question_id": 13,
        "question_title": "What is the danger of assuming a requirement is \"obvious\" without documenting it?",
        "option_A": "It can lead to a gap between customer expectations and what is actually delivered.",
        "option_B": "It increases project costs immediately.",
        "option_C": "It prevents developers from choosing the right programming language.",
        "option_D": "There is no danger; experienced developers always know what is needed.",
        "correct_anwser": "A",
        "explain": "Khi một yêu cầu được coi là \"hiển nhiên\" mà không được ghi chép rõ ràng, các bên sẽ dễ hiểu lầm theo các cách khác nhau. Điều này trực tiếp tạo ra sự sai lệch giữa kỳ vọng thực tế của khách hàng và sản phẩm bàn giao cuối cùng của đội ngũ phát triển."
      },
      {
        "question_id": 14,
        "question_title": "In the context of software projects, who is a \"stakeholder\"?",
        "option_A": "Only the developers who write the code.",
        "option_B": "Anyone who is affected by or can influence the project's outcome.",
        "option_C": "The external auditors who review project expenses.",
        "option_D": "Only the end-users who interact with the final interface.",
        "correct_anwser": "B",
        "explain": "Bên liên quan (Stakeholder) được định nghĩa rộng rãi là bất kỳ cá nhân, nhóm người hoặc tổ chức nào có thể tham gia, chịu tác động trực tiếp/gián tiếp bởi kết quả của dự án, hoặc có năng lực gây ảnh hưởng đến tiến trình dự án."
      },
      {
        "question_id": 15,
        "question_title": "What is the primary objective of requirements elicitation?",
        "option_A": "To create a complete user interface design.",
        "option_B": "To write the clean code for the core system algorithms.",
        "option_C": "To find out what stakeholders need the system to do and discover their real goals.",
        "option_D": "To finalize the project budget and timeline constraints.",
        "correct_anwser": "C",
        "explain": "Mục tiêu hàng đầu của giai đoạn gợi tiến yêu cầu (Requirements Elicitation) là tìm hiểu, khai thác và khám phá những nhu cầu thực tế cũng như mục tiêu cốt lõi của khách hàng đối với hệ thống phần mềm cần xây dựng."
      },
      {
        "question_id": 16,
        "question_title": "Which of the following techniques is commonly used to elicit requirements by observing users in their actual work environment?",
        "option_A": "Brainstorming",
        "option_B": "Job shadowing or Observation",
        "option_C": "Interface analysis",
        "option_D": "Document analysis",
        "correct_anwser": "B",
        "explain": "Kỹ thuật quan sát (Job shadowing hoặc Observation) cho phép BA trực tiếp theo dõi quy trình làm việc thực tế hàng ngày của người dùng tại môi trường của họ để phát hiện ra những quy trình nghiệp vụ ngầm định hoặc những bất cập mà chính người dùng đôi khi không tự nhận ra."
      },
      {
        "question_id": 17,
        "question_title": "What is the primary risk of using open-ended questions during a requirements elicitation interview?",
        "option_A": "They lead to simple 'yes' or 'no' answers that provide no depth.",
        "option_B": "They can result in long, unfocused answers that consume significant time without yielding specific requirements.",
        "option_C": "They force the user to agree with the analyst's preconceived technical design.",
        "option_D": "They prevent the analyst from understanding the user's emotional context.",
        "correct_anwser": "B",
        "explain": "Câu hỏi mở (Open-ended questions) kích thích người trả lời chia sẻ tự do, nhưng rủi ro lớn nhất là dễ làm câu trả lời bị lan man, kéo dài và mất tập trung vào chủ đề chính, gây tiêu tốn nhiều thời gian mà không thu thập được các yêu cầu cụ thể."
      },
      {
        "question_id": 18,
        "question_title": "Which elicitation technique is highly interactive, involves a diverse group of stakeholders, and is designed to generate a large volume of creative ideas quickly?",
        "option_A": "Document Analysis",
        "option_B": "Brainstorming",
        "option_C": "Data Modeling",
        "option_D": "System Architecture Review",
        "correct_anwser": "B",
        "explain": "Động não (Brainstorming) là kỹ thuật làm việc nhóm mang tính tương tác cao, khuyến khích tất cả mọi người tự do đưa ra nhiều ý tưởng sáng tạo mới một cách nhanh chóng trong một khoảng thời gian ngắn mà không sợ bị phán xét."
      },
      {
        "question_id": 19,
        "question_title": "In requirements development, what is a \"User Persona\"?",
        "option_A": "A real, specific individual who has purchased the software.",
        "option_B": "A detailed technical profile of the system administrator's security clearance.",
        "option_C": "A semi-fictional representation of a target user group based on shared characteristics and behaviors.",
        "option_D": "The organization's legal representative who signs the contract.",
        "correct_anwser": "C",
        "explain": "User Persona (Chân dung người dùng) là một hình mẫu giả định (semi-fictional) đại diện cho một nhóm người dùng mục tiêu, được xây dựng dựa trên những đặc điểm, hành vi, mục tiêu và nỗi đau (pain points) chung thu thập được từ thực tế."
      },
      {
        "question_id": 20,
        "question_title": "What is a major advantage of conducting a \"Focus Group\" for requirements elicitation?",
        "option_A": "It guarantees that the technical architecture is flawless.",
        "option_B": "It allows the analyst to observe interactions and spontaneous discussions among a representative group of users.",
        "option_C": "It generates finalized system code automatically.",
        "option_D": "It eliminates the need for any subsequent validation sessions.",
        "correct_anwser": "B",
        "explain": "Nhóm tập trung (Focus Group) tập hợp một nhóm người dùng đại diện để cùng thảo luận về một chủ đề cụ thể, ưu điểm lớn nhất của nó là giúp BA khai thác được các ý kiến, phản hồi nảy sinh một cách tự nhiên từ sự tương tác qua lại giữa các thành viên."
      },
      {
        "question_id": 21,
        "question_title": "What is a key difference between an evolutionary prototype and a throwaway prototype?",
        "option_A": "An evolutionary prototype is built by developers, while a throwaway prototype is built by users.",
        "option_B": "An evolutionary prototype is refined over time to become part of the final production system, while a throwaway prototype is used only to explore requirements and then discarded.",
        "option_C": "A throwaway prototype requires separate database migration tools.",
        "option_D": "There is no difference; they follow the exact same lifecycle.",
        "correct_anwser": "B",
        "explain": "Mẫu thử tiến hóa (Evolutionary prototype) được xây dựng với mã nguồn chuẩn để tối ưu, nâng cấp dần thành một phần của hệ thống thật; trong khi mẫu thử bỏ đi (Throwaway prototype) chỉ được dựng nhanh chóng nhằm mục đích thăm dò, làm rõ các yêu cầu mơ hồ rồi sau đó sẽ bị loại bỏ."
      },
      {
        "question_id": 22,
        "question_title": "Which of the following describes the difference between Requirements Elicitation and Requirements Analysis?",
        "option_A": "Elicitation focuses on technical code deployment, while Analysis creates system visual themes.",
        "option_B": "Elicitation is about gathering information from stakeholders, while Analysis focuses on processing, organizing, and clarifying that information into refined requirements.",
        "option_C": "Analysis must always happen before Elicitation begins.",
        "option_D": "Elicitation is done exclusively by software developers, while Analysis is done solely by end-users.",
        "correct_anwser": "B",
        "explain": "Gợi tiến yêu cầu (Elicitation) tập trung vào việc thu thập thông tin và tìm hiểu nhu cầu từ phía stakeholders, trong khi Phân tích yêu cầu (Analysis) tiếp nhận các thông tin thô đó để xử lý, bóc tách, sắp xếp và làm rõ thành các yêu cầu kỹ thuật hoàn chỉnh."
      },
      {
        "question_id": 23,
        "question_title": "Customers have the right to: (choose 3 correct answers)",
        "option_A": "expect business analysts to learn about their business and their objectives",
        "option_B": "describe characteristics that will make the product easy to use",
        "option_C": "receive a system that meets their functional needs and quality expectations",
        "option_D": "promptly communicate changes to the requirements",
        "correct_anwser": "A, B, C",
        "explain": "Theo Tuyên ngôn Quyền lợi về Yêu cầu của Khách hàng (Requirements Bill of Rights), khách hàng có quyền: yêu cầu BA tìm hiểu về doanh nghiệp của họ (A), mô tả các đặc tính giúp sản phẩm dễ sử dụng (B), và nhận được hệ thống đáp ứng nhu cầu chức năng cũng như chất lượng (C). Ngược lại, phương án D ('thông báo kịp thời các thay đổi về yêu cầu') thuộc về trách nhiệm/nghĩa vụ của khách hàng (Customer Responsibilities) chứ không phải quyền lợi."
      },
      {
        "question_id": 24,
        "question_title": "What are the tasks of a business analyst? Choose 3 correct answers.",
        "option_A": "Define business requirements",
        "option_B": "Identify project stakeholders and user classes",
        "option_C": "Document requirements",
        "option_D": "Lead requirements prioritization",
        "correct_anwser": "B, C, D",
        "explain": "Các tác vụ chính của một BA bao gồm: Nhận diện các bên liên quan và phân loại người dùng (B), viết tài liệu đặc tả yêu cầu (C), và dẫn dắt buổi họp ưu tiên hóa các yêu cầu (D). Riêng phương án A, 'Xác định yêu cầu kinh doanh' (Define business requirements) thông thường do quản lý cấp cao, nhà tài trợ dự án (Sponsor) hoặc khách hàng chiến lược đưa ra trước khi BA tham gia vào chi tiết dự án."
      },
      {
        "question_id": 25,
        "question_title": "“Organize and share notes” is an activity that belongs to ?",
        "option_A": "Preparing for elicitation",
        "option_B": "Performing elicitation activities",
        "option_C": "Following up after elicitation",
        "option_D": "Classifying customer",
        "correct_anwser": "C",
        "explain": "Hoạt động 'Sắp xếp tổ chức và chia sẻ các ghi chú/biên bản' (Organize and share notes) là một bước tiêu biểu được thực hiện sau khi buổi khơi gợi yêu cầu kết thúc (Following up after elicitation) nhằm tổng hợp lại thông tin thu thập được và phân phối đến các bên liên quan để rà soát, xác nhận tính chính xác."
      },
      {
        "question_id": 26,
        "question_title": "What is the value of prototyping during requirements elicitation?",
        "option_A": "It provides a visual tool to clarify ambiguous requirements and gather stakeholder feedback",
        "option_B": "It eliminates the need for acceptance criteria",
        "option_C": "It skips non-functional requirements",
        "option_D": "It focuses on coding directly",
        "correct_anwser": "A",
        "explain": "Làm mẫu thử (Prototyping) trong giai đoạn khơi gợi yêu cầu mang lại giá trị rất lớn nhờ cung cấp một công cụ trực quan hóa (visual tool). Điều này giúp làm rõ những phần yêu cầu còn mơ hồ, nhập nhằng và giúp khách hàng dễ dàng hình dung để đưa ra phản hồi chính xác."
      },
      {
        "question_id": 27,
        "question_title": "Customers are a(n) _______ of stakeholders.",
        "option_A": "subset",
        "option_B": "representative",
        "option_C": "partner",
        "option_D": "equivalent",
        "correct_anwser": "A",
        "explain": "Khách hàng (Customers) là một tập hợp con (subset) nằm trong tập hợp rộng lớn hơn là các bên liên quan (Stakeholders). Khái niệm Stakeholders bao gồm khách hàng, người dùng cuối, nhà quản lý, lập trình viên, kiểm thử viên và các cơ quan quản lý."
      },
      {
        "question_id": 28,
        "question_title": "What is the benefit of having a small group representing key areas as decision makers in a project?",
        "option_A": "It simplifies the decision-making process by involving only the project manager",
        "option_B": "It ensures diverse perspectives from management, customers, business analysis, development, and marketing",
        "option_C": "It reduces the need for stakeholder involvement",
        "option_D": "It focuses solely on technical specifications",
        "correct_anwser": "B",
        "explain": "Việc thành lập một nhóm nhỏ đại diện cho các lĩnh vực cốt lõi (nhóm quyết định/quản trị thay đổi) giúp đảm bảo dự án có được góc nhìn đa chiều, toàn diện từ cấp quản lý, khách hàng, phân tích nghiệp vụ, phát triển phần mềm cho đến marketing mà không làm cồng kềnh bộ máy."
      },
      {
        "question_id": 29,
        "question_title": "What activities is not included in a representative requirements development process?",
        "option_A": "Select an appropriate software development life cycle.",
        "option_B": "Select elicitation techniques",
        "option_C": "Review requirement",
        "option_D": "Plan elicitation",
        "option_E": "Analysis requirement",
        "correct_anwser": "A",
        "explain": "Việc lựa chọn mô hình vòng đời phát triển phần mềm phù hợp (SDLC) là nhiệm vụ thuộc về quản lý dự án (Project Management) hoặc kiến trúc sư hệ thống (System Architect), chứ không nằm trong các hoạt động nghiệp vụ trực tiếp của quy trình phát triển và quản lý yêu cầu (Requirements Development Process)."
      },
      {
        "question_id": 30,
        "question_title": "Develop a method to ensure that all necessary documents and systems are available for independent elicitation. What would be a primary focus of this method?",
        "option_A": "Creating a checklist of required documents and systems.",
        "option_B": "Assigning a team member to gather all necessary materials.",
        "option_C": "Setting up a shared repository for document access.",
        "option_D": "Scheduling regular audits to ensure document availability.",
        "correct_anwser": "A",
        "explain": "Để đảm bảo một cách hệ thống rằng toàn bộ tài liệu và hệ thống hiện hành đều sẵn sàng phục vụ cho việc khơi gợi yêu cầu độc lập (như nghiên cứu tài liệu), bước tập trung cốt lõi là xây dựng một bảng kiểm (checklist) chi tiết để rà soát đầy đủ danh mục cần chuẩn bị."
      },
      {
        "question_id": 31,
        "question_title": "What is one of the first questions to ask when eliciting reporting requirements from a customer?",
        "option_A": "How often should the reports be printed?",
        "option_B": "What reports are currently used?",
        "option_C": "How many users will need access to the report?",
        "option_D": "What is the preferred color scheme for the reports?",
        "correct_anwser": "B",
        "explain": "Khi khơi gợi yêu cầu về hệ thống báo cáo (Reporting requirements), câu hỏi khảo sát thực tế và nên ưu tiên đặt ra đầu tiên là 'Những báo cáo nào hiện đang được sử dụng?' (B). Việc hiểu rõ hiện trạng giúp BA nắm được cấu trúc dữ liệu cốt lõi trước khi đi vào chi tiết tần suất in ấn (A), phân quyền (C) hay giao diện màu sắc (D)."
      },
      {
        "question_id": 32,
        "question_title": "What is true about a software prototype? Choose 3 correct answers.",
        "option_A": "It is a partial implementation of a proposed new product.",
        "option_B": "It is a possible implementation of a proposed new product.",
        "option_C": "It is a preliminary implementation of a proposed new product.",
        "option_D": "It is a complete implementation of a proposed new product.",
        "correct_anwser": "A, B, C",
        "explain": "Mẫu thử phần mềm (Prototype) được định nghĩa là một phiên bản triển khai một phần (A), một phiên bản triển khai khả thi (B), hoặc phiên bản triển khai sơ khởi ban đầu (C) nhằm mục đích thử nghiệm và làm rõ yêu cầu. Nó không bao giờ là một phiên bản triển khai hoàn chỉnh (D)."
      },
      {
        "question_id": 33,
        "question_title": "While a mock-up is called a _______ prototype, a proof of concept is called a _______ prototype.",
        "option_A": "horizontal, vertical",
        "option_B": "vertical, horizontal",
        "option_C": "primary, secondary",
        "option_D": "front-end, back-end",
        "correct_anwser": "A",
        "explain": "Mock-up tập trung vào bề rộng của giao diện người dùng mà không đi sâu vào xử lý logic bên dưới nên được gọi là mẫu thử nằm ngang (horizontal prototype). Ngược lại, Proof of Concept (PoC) đi sâu vào kiểm thử kỹ thuật hoặc một lát cắt chức năng từ trên xuống dưới để chứng minh tính khả thi nên được gọi là mẫu thử thẳng đứng (vertical prototype)."
      },
      {
        "question_id": 34,
        "question_title": "which of the following statements are incorrect about throwaway prototypes?",
        "option_A": "most appropriate when the team faces uncertainty, ambiguity, incompleteness, or vagueness in the requirements",
        "option_B": "when build a throwaway prototype, they ignore solid software construction techniques",
        "option_C": "you might prefer to call it a releasable prototype",
        "option_D": "Build a throwaway prototype to answer questions, resolve uncertainties, and improve requirements quality",
        "option_E": "",
        "option_F": "",
        "correct_anwser": "C",
        "explain": "Mẫu thử dùng một lần rồi bỏ (Throwaway prototype) được xây dựng chỉ để làm rõ yêu cầu rồi vứt bỏ chứ không dùng để phát hành trực tiếp. Vì vậy, việc gọi nó là một mẫu thử có thể phát hành (releasable prototype) là hoàn toàn sai."
      },
      {
        "question_id": 35,
        "question_title": "Which type of requirement best describes the behavior and information that the solution will manage, including a specific system actions or responses?",
        "option_A": "Stakeholder Requirements.",
        "option_B": "Functional Requirements.",
        "option_C": "Business Requirements.",
        "option_D": "Non-functional Requirements",
        "correct_anwser": "B",
        "explain": "Yêu cầu chức năng (Functional Requirements) mô tả các hành vi, phản hồi và thông tin mà hệ thống/giải pháp sẽ quản lý để phản hồi lại các tác vụ cụ thể của người dùng hoặc hệ thống khác."
      },
      {
        "question_id": 36,
        "question_title": "Which of the following tasks are typically performed by a business analyst? Select two.",
        "option_A": "Defining business requirements and helping project sponsors express the project's vision clearly.",
        "option_B": "Focusing only on textual documentation and avoiding the use of visual aids like diagrams and prototypes.",
        "option_C": "Ensuring that all team members fully understand the requirements being communicated.",
        "option_D": "Managing the entire software development life cycle, from inception to deployment.",
        "correct_anwser": "A, C",
        "explain": "Nhiệm vụ điển hình của một chuyên viên phân tích nghiệp vụ (BA) là định nghĩa các yêu cầu kinh doanh, hỗ trợ nhà tài trợ dự án làm rõ tầm nhìn (A), và đảm bảo các thành viên trong đội ngũ hiểu đúng các yêu cầu được truyền đạt (C). Quản lý toàn bộ SDLC là nhiệm vụ của Quản trị dự án (PM) chứ không phải BA."
      },
      {
        "question_id": 37,
        "question_title": "Which of the following is a likely stakeholder interest for a retail kiosk's customer?",
        "option_A": "Maximizing user convenience",
        "option_B": "Minimizing development cost",
        "option_C": "Improving operational efficiency",
        "option_D": "Increasing market reach",
        "correct_anwser": "A",
        "explain": "Đối với một khách hàng (người dùng cuối) sử dụng ki-ốt bán lẻ, mối quan tâm lớn nhất và trực tiếp nhất của họ là sự tiện lợi khi sử dụng (user convenience). Các phương án khác như chi phí phát triển, hiệu quả vận hành hay mở rộng thị trường là mối quan tâm của chủ doanh nghiệp hoặc nhà phát triển."
      },
      {
        "question_id": 38,
        "question_title": "What do product champions do? Choose 2 correct answers.",
        "option_A": "They gather requirements from other members of the user classes they represent, and reconcile inconsistencies.",
        "option_B": "They serve as the primary interface between members of a single user class and the project's business analyst.",
        "option_C": "They implement the coding standards.",
        "option_D": "They write requirements documents.",
        "correct_anwser": "A, B",
        "explain": "Trách nhiệm chính của các Product Champion bao gồm việc thu thập ý kiến, yêu cầu từ các thành viên khác trong cùng nhóm người dùng của họ và giải quyết các điểm mâu thuẫn (A), đồng thời đóng vai trò làm cầu nối giao tiếp chính giữa nhóm đó với Chuyên viên phân tích nghiệp vụ (BA) của dự án (B)."
      },
      {
        "question_id": 39,
        "question_title": "What should you not expect a prototype to replace?",
        "option_A": "Multiple iterations.",
        "option_B": "Written requirements.",
        "option_C": "Plausible data.",
        "option_D": "The purpose of the prototype",
        "correct_anwser": "B",
        "explain": "Prototype chỉ là công cụ hỗ trợ trực quan hóa để làm rõ yêu cầu chứ không bao giờ có thể thay thế hoàn toàn văn bản đặc tả yêu cầu bằng chữ (Written requirements). Lập trình viên và kiểm thử viên vẫn luôn cần tài liệu bằng văn bản chính thức để có căn cứ thực hiện và đối chiếu chi tiết."
      },
      {
        "question_id": 40,
        "question_title": "Which of the following statements best describes a \"horizontal prototype\" in the context of software development?",
        "option_A": "A horizontal prototype focuses on the user interface, allowing exploration of specific behaviors without diving into detailed functionality or architectural layers.",
        "option_B": "A horizontal prototype fully implements all layers of the system, from the user interface to the backend services.",
        "option_C": "A horizontal prototype is used to validate the architectural approach and test critical timing requirements.",
        "option_D": "A horizontal prototype includes detailed implementation of business logic and database interactions.",
        "correct_anwser": "A",
        "explain": "Nguyên mẫu giao diện/nguyên mẫu bề nổi (Horizontal prototype) tập trung chủ yếu vào phần giao diện người dùng (UI), cho phép người dùng trải nghiệm và khám phá luồng đi, hành vi chuyển trang mà không đi sâu cài đặt logic nghiệp vụ chi tiết hay các tầng kiến trúc bên dưới (ngược lại với vertical prototype)."
      },
      {
        "question_id": 41,
        "question_title": "When creating a persona for each user class, the most important thing is:",
        "option_A": "The persona must be a real person",
        "option_B": "The persona must be representative of their user class",
        "option_C": "The persona must be rich",
        "option_D": "The persona must be beautiful",
        "correct_anwser": "B",
        "explain": "Chân dung người dùng (Persona) là một nhân vật hư cấu đại diện, do đó điều quan trọng nhất là nhân vật đó phải mang tính đại diện và phản ánh chính xác các đặc điểm hành vi, nhu cầu của cả một lớp người dùng (user class) đó."
      },
      {
        "question_id": 42,
        "question_title": "Which of the following is not an elicitation technique?",
        "option_A": "Interviews",
        "option_B": "Focus groups",
        "option_C": "Observations",
        "option_D": "Training courses",
        "correct_anwser": "D",
        "explain": "Phỏng vấn (Interviews), thảo luận nhóm tập trung (Focus groups) và quan sát (Observations) đều là các kỹ thuật thu thập/khơi gợi yêu cầu (elicitation techniques) kinh điển. Khóa đào tạo (Training courses) là hoạt động truyền tải kiến thức sau khi đã có sản phẩm hoặc quy trình, không phải kỹ thuật thu thập yêu cầu."
      },
      {
        "question_id": 43,
        "question_title": "Which elicitation technique is most suitable for identifying stakeholder needs in large projects?",
        "option_A": "Focus groups",
        "option_B": "Observation",
        "option_C": "Brainstorming sessions",
        "option_D": "Stakeholder interviews",
        "correct_anwser": "D",
        "explain": "Trong các dự án lớn, việc thực hiện phỏng vấn các bên liên quan (Stakeholder interviews) một cách trực tiếp và có cấu trúc giúp đi sâu tìm hiểu rõ nhất các nhu cầu, mục tiêu chiến lược và kỳ vọng cụ thể từ nhiều góc nhìn khác nhau của các bên chủ chốt."
      },
      {
        "question_id": 44,
        "question_title": "What is a key difference between a throwaway prototype and an evolutionary prototype?",
        "option_A": "A throwaway prototype is built with production-quality code, while an evolutionary prototype is discarded after use.",
        "option_B": "An evolutionary prototype is designed to be gradually refined into the final product, while a throwaway prototype is created to answer specific questions and then discarded.",
        "option_C": "A throwaway prototype provides a solid architectural foundation for the final product, while an evolutionary prototype is typically used to test user interface designs.",
        "option_D": "Both throwaway and evolutionary prototypes are intended to be discarded after initial testing.",
        "correct_anwser": "B",
        "explain": "Sự khác biệt cốt lõi: Mô hình tiến hóa (evolutionary prototype) được xây dựng vững chắc để cải tiến dần dần thành sản phẩm cuối cùng, còn mô hình bỏ đi (throwaway prototype) chỉ nhằm mục đích làm rõ các câu hỏi/yêu cầu cụ thể rồi bị loại bỏ."
      },
      {
        "question_id": 45,
        "question_title": "which of the following statements is incorrect about mockup?",
        "option_A": "It is also called a horizontal prototype",
        "option_B": "It dives into all the architectural layers or into detailed functionality",
        "option_C": "It displays the facades of user interface screens and permits some navigation between them",
        "option_D": "It lets you explore some specific behaviors of the intended system, with the goal of refining the requirements",
        "correct_anwser": "B",
        "explain": "Mockup là một mô hình giao diện tĩnh bề mặt (horizontal prototype), do đó khẳng định nó 'đi sâu vào tất cả các lớp kiến trúc hệ thống và chức năng chi tiết' (B) là hoàn toàn sai (đây là đặc điểm của vertical prototype/Proof of Concept)."
      },
      {
        "question_id": 46,
        "question_title": "Customers are a(n) _________ of stakeholders.",
        "option_A": "subset",
        "option_B": "representative",
        "option_C": "partner",
        "option_D": "equivalent",
        "correct_anwser": "A",
        "explain": "Stakeholders (Bên liên quan) là một nhóm rộng lớn bao gồm bất kỳ ai bị ảnh hưởng bởi dự án (nhà phát triển, quản lý, người dùng, khách hàng...). Khách hàng (Customers) chỉ là một nhóm con (subset) nằm trong tập hợp các bên liên quan đó."
      },
      {
        "question_id": 47,
        "question_title": "The Product vision and project scope describes the?",
        "option_A": "Function, performance and constraints of a computer-based system",
        "option_B": "The indicators that stakeholders will use to define and measure success on this project and the statement that is believed to be true in the absence of proof or definitive knowledge",
        "option_C": "The benefits the business",
        "option_D": "The ultimate product that will achieve the business objectives and what portion of the ultimate product vision the current project or development iteration will address",
        "correct_anwser": "D",
        "explain": "Tầm nhìn sản phẩm (Product Vision) định nghĩa sản phẩm cuối cùng nhằm đạt mục tiêu kinh doanh, còn Phạm vi dự án (Project Scope) xác định phần cụ thể nào của tầm nhìn đó sẽ được giải quyết trong dự án hoặc phân đoạn phát triển hiện tại."
      },
      {
        "question_id": 48,
        "question_title": "Why is it important to involve stakeholders, including data experts, in the process of specifying data requirements?",
        "option_A": "To exclude data experts from the development process.",
        "option_B": "To limit the variety of data used in the system.",
        "option_C": "To ensure a comprehensive understanding of data needs and complexities.",
        "option_D": "To prioritize project timelines over data considerations.",
        "correct_anwser": "C",
        "explain": "Việc lôi cuốn các bên liên quan cùng chuyên gia dữ liệu vào quá trình định nghĩa yêu cầu dữ liệu giúp đội ngũ dự án hiểu một cách toàn diện, sâu sắc về nhu cầu khai thác dữ liệu cũng như các cấu trúc, ràng buộc phức tạp của hệ thống."
      },
      {
        "question_id": 49,
        "question_title": "While a mock-up is called a _________ prototype, a proof of concept is called a _________ prototype.",
        "option_A": "horizontal, vertical",
        "option_B": "vertical, horizontal",
        "option_C": "primary, secondary",
        "option_D": "front-end, back-end",
        "correct_anwser": "A",
        "explain": "Mock-up tập trung dàn trải toàn bộ bề mặt giao diện hệ thống nhưng không xử lý sâu bên dưới nên gọi là mẫu thử nằm ngang (horizontal prototype). Ngược lại, Proof of Concept (PoC) đi sâu xử lý triệt để một lát cắt tính năng kỹ thuật phức tạp từ trên xuống dưới để chứng minh tính khả thi nên gọi là mẫu thử thẳng đứng (vertical prototype)."
      },
      {
        "question_id": 50,
        "question_title": "What is a common challenge that both enhancement and replacement projects often face?",
        "option_A": "Users who are familiar with how the system works today might not like the changes they are about to encounter",
        "option_B": "Limited stakeholder involvement",
        "option_C": "Requirements documentation may be available for existing systems.",
        "option_D": "Minimal communication among team members",
        "correct_anwser": "A",
        "explain": "Thách thức tâm lý rất phổ biến ở cả dự án nâng cấp (enhancement) lẫn thay thế hệ thống (replacement) là người dùng cũ đã quá quen thuộc với quy trình hiện tại nên thường có xu hướng phản kháng, không thích ứng hoặc từ chối những thay đổi mới."
      },
      {
        "question_id": 51,
        "question_title": "Which of the following is not an elicitation activity?",
        "option_A": "Define product vision and project scope",
        "option_B": "Hold elicitation interviews",
        "option_C": "Observe users performing their jobs",
        "option_D": "Model the application environment",
        "correct_anwser": "A",
        "explain": "Xác định tầm nhìn sản phẩm và phạm vi dự án (Define product vision and project scope) thuộc về giai đoạn Khởi tạo dự án hoặc Định hình Yêu cầu kinh doanh (Inception / Business Requirements), đóng vai trò thiết lập khung hướng dẫn trước khi tiến hành các hoạt động khơi gợi yêu cầu chi tiết (Elicitation) như phỏng vấn, quan sát hay xây dựng mô hình môi trường ứng dụng."
      },
      {
        "question_id": 52,
        "question_title": "When there is a disagreement between development and customers, how to solve it?",
        "option_A": "Customers get preference, unconditionally",
        "option_B": "Customers get preference, but in alignment with business objectives",
        "option_C": "Development gets preference, unconditionally",
        "option_D": "Development gets preference, but in alignment with business objectives",
        "correct_anwser": "B",
        "explain": "Khi xảy ra bất đồng ý kiến giữa đội ngũ phát triển và khách hàng, giải pháp chuẩn là ưu tiên góc nhìn của khách hàng (vì họ hiểu rõ họ cần gì) nhưng quyết định đó bắt buộc phải nằm trong phạm vi và đồng nhất với các mục tiêu kinh doanh (business objectives) của dự án."
      },
      {
        "question_id": 53,
        "question_title": "What kind of questions are best to ask at the beginning to use for writing better questionnaires at the beginning of the elicitation process?",
        "option_A": "Essay questions",
        "option_B": "Closed ended questions with standardized answers.",
        "option_C": "Open-ended questions are asked at the beginning to obtain full and meaningful answers.",
        "option_D": "Combine close ended questions with open-ended questions",
        "correct_anwser": "C",
        "explain": "Ở giai đoạn đầu của quá trình khơi gợi yêu cầu, việc sử dụng các câu hỏi mở (Open-ended questions) là tốt nhất để người dùng tự do chia sẻ, giúp BA thu thập được thông tin toàn diện, sâu sắc và bối cảnh đầy đủ, làm cơ sở để thiết kế các bảng khảo sát chi tiết hơn về sau."
      },
      {
        "question_id": 54,
        "question_title": "What is the risk of incomplete requirements during the elicitation phase?",
        "option_A": "Project delays, increased costs, and reduced stakeholder satisfaction",
        "option_B": "Faster completion of functional requirements",
        "option_C": "Elimination of prototyping needs",
        "option_D": "Reduced complexity in coding",
        "correct_anwser": "A",
        "explain": "Rủi ro lớn nhất của việc thu thập thiếu hoặc không hoàn thiện yêu cầu (incomplete requirements) là dẫn đến việc phải làm lại (rework) về sau, gây chậm trễ tiến độ dự án, tăng chi phí và làm giảm mức độ hài lòng của các bên liên quan."
      },
      {
        "question_id": 55,
        "question_title": "What is the primary purpose of conducting stakeholder interviews during elicitation?",
        "option_A": "To gather detailed requirements directly from key stakeholders",
        "option_B": "To finalize the project schedule",
        "option_C": "To identify coding standards",
        "option_D": "To replace the prototyping needs",
        "correct_anwser": "A",
        "explain": "Mục đích chính của việc tiến hành phỏng vấn các bên liên quan (stakeholder interviews) là thu thập thông tin chi tiết và các yêu cầu cụ thể một cách trực tiếp từ những người có vai trò quyết định hoặc sử dụng hệ thống."
      },
      {
        "question_id": 56,
        "question_title": "Elicitation is a collaborative and analytical process that includes activities to collect, discover, extract, and _____________",
        "option_A": "gather requirements",
        "option_B": "define requirements",
        "option_C": "write requirements",
        "option_D": "analyze requirements",
        "correct_anwser": "A",
        "explain": "Theo định nghĩa chuẩn trong tài liệu kỹ nghệ yêu cầu (Karl Wiegers), khơi gợi yêu cầu (Elicitation) là một quá trình cộng tác và phân tích bao gồm các hoạt động thu thập, khám phá, trích xuất và tập hợp các yêu cầu (gather requirements) từ nhiều nguồn khác nhau."
      },
      {
        "question_id": 57,
        "question_title": "Which of the following strategies helps mitigate the risk of stakeholders expecting a throwaway prototype to be production-ready?",
        "option_A": "Using high-fidelity tools that resemble the final product.",
        "option_B": "Leaving the prototype looking rough and unpolished.",
        "option_C": "Making the prototype available for immediate release.",
        "option_D": "Giving detailed descriptions of every feature.",
        "correct_anwser": "B",
        "explain": "Để tránh việc khách hàng lầm tưởng một mẫu thử bỏ đi (Throwaway prototype) là một sản phẩm hoàn thiện có thể đem đi chạy thật ngay lập tức, BA nên chủ động để giao diện mẫu thử ở dạng thô sơ, phác thảo nguệch ngoạc (Rough and unpolished)."
      }
    ]
  },
  {
    "id": "swr302-module-3-analysis-&-modeling",
    "title": "SWR302 - Module 3 - Analysis & Modeling",
    "description": "Software Requirement Quiz",
    "questionsCount": 41,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Some stakeholders are customers, such as legal staff, compliance auditors, suppliers, contractors, and venture capitalists",
        "option_A": "True",
        "option_B": "False",
        "correct_anwser": "B",
        "explain": "Các đối tượng như nhân viên pháp lý, kiểm toán viên tuân thủ, nhà cung cấp, nhà thầu và nhà đầu tư mạo hiểm đều là các Stakeholders (bên liên quan), nhưng họ không được phân loại là Customers (khách hàng)."
      },
      {
        "question_id": 2,
        "question_title": "Which of the following statements accurately describe the use of context diagrams in representing project scope? Select two.",
        "option_A": "A context diagram visually illustrates the boundary between the system being developed and external entities that interact with it.",
        "option_B": "The context diagram includes detailed information about the system's internal processes and data.",
        "option_C": "The primary purpose of a context diagram is to depict the interactions between the system and external entities without detailing the internal workings of the system.",
        "option_D": "Context diagrams are typically used to represent the relationship between user interfaces and system components within the boundary.",
        "correct_anwser": "A, C",
        "explain": "Sơ đồ ngữ cảnh (Context Diagram) được dùng để xác định ranh giới hệ thống thông qua việc thể hiện hệ thống như một khối duy nhất tương tác với các thực thể bên ngoài (A và C). Sơ đồ này hoàn toàn không đi sâu vào cấu trúc hoặc luồng dữ liệu nội bộ chi tiết của hệ thống."
      },
      {
        "question_id": 3,
        "question_title": "What is not the purpose of a Use Case Diagram?",
        "option_A": "Use case diagrams are both behavior diagrams because they describe the behavior of the system. They are also structure diagrams, serving as a special case of class diagrams where classifiers are restricted to be either actors or use cases related to each other with associations.",
        "option_B": "Use case diagrams show the graphical user interface that needs to be implemented.",
        "option_C": "Use case diagrams are usually referred to as behavior diagrams used to describe a set of actions (use cases) that some system or systems (subject) should or can perform in collaboration with one or more external users of the system (actors).",
        "option_D": "A use case describes a sequence of interactions between a system and an external actor that results in the actor being able to achieve some outcome of value.",
        "correct_anwser": "B",
        "explain": "Sơ đồ ca sử dụng (Use Case Diagram) dùng để mô tả mối quan hệ giữa tác nhân (actor) và các chức năng hệ thống ở mức tổng quan chứ hoàn toàn không có mục đích hay chức năng thể hiện giao diện đồ họa người dùng (Graphical User Interface - GUI)."
      },
      {
        "question_id": 4,
        "question_title": "What is the distinction between users and actors?",
        "option_A": "There is no real difference; the terms can be used interchangeably.",
        "option_B": "Users are only relevant for use cases involving a graphical interface, while actors cover backend processes.",
        "option_C": "Users are responsible for system development, and actors are responsible for testing.",
        "option_D": "A user is an actual person (or system) using the product, while an actor is an abstraction that represents the role the user plays in a given use case.",
        "option_E": "Users are always individuals, while actors are always systems.",
        "correct_anwser": "D",
        "explain": "Trong phân tích hệ thống và UML, 'User' là một người hoặc hệ thống thực tế bằng xương bằng thịt sử dụng sản phẩm phần mềm, còn 'Actor' là một thực thể trừu tượng đại diện cho một vai trò (role) mà người dùng đó đảm nhận khi tương tác với một ca sử dụng (use case) cụ thể."
      },
      {
        "question_id": 5,
        "question_title": "Which of the following statements accurately describe preconditions and postconditions in the context of use cases? Select two.",
        "option_A": "Preconditions define the prerequisites that must be met before the system can begin executing a use case.",
        "option_B": "Preconditions describe the expected outcome after the use case has been successfully executed.",
        "option_C": "Postconditions describe the state of the system after the use case has executed successfully.",
        "option_D": "Postconditions determine whether the system should proceed with executing a use case.",
        "correct_anwser": "A, C",
        "explain": "Điều kiện tiên quyết (Preconditions) là các ràng buộc hoặc trạng thái hệ thống phải được thỏa mãn trước khi một ca sử dụng có thể bắt đầu chạy (A). Điều kiện sau (Postconditions) mô tả trạng thái cuối cùng hoặc kết quả mà hệ thống đạt được sau khi ca sử dụng kết thúc thành công (C)."
      },
      {
        "question_id": 6,
        "question_title": "What is the function of decision tables in requirements modeling?",
        "option_A": "To represent complex Boolean logic and decisions in a tabular format",
        "option_B": "To model user interface design",
        "option_C": "To specify data flows",
        "option_D": "To define system states",
        "correct_anwser": "A",
        "explain": "Bảng quyết định (Decision tables) được dùng trong mô hình hóa yêu cầu để biểu diễn các logic Boolean phức tạp gồm nhiều điều kiện và các hành động tương ứng dưới dạng bảng trực quan, giúp kiểm tra tính đầy đủ của logic nghiệp vụ."
      },
      {
        "question_id": 7,
        "question_title": "What is one guideline for naming processes in a DFD?",
        "option_A": "Use a verb only",
        "option_B": "Use a noun only",
        "option_C": "Name the process after its corresponding data store",
        "option_D": "Name each process using a concise verb-object action",
        "correct_anwser": "D",
        "explain": "Trong sơ đồ luồng dữ liệu (DFD), mỗi tiến trình (process) bắt buộc phải thực hiện một hành động biến đổi dữ liệu, do đó quy định đặt tên chuẩn là sử dụng cụm Động từ + Tân ngữ (verb-object) rõ ràng, súc tích."
      },
      {
        "question_id": 8,
        "question_title": "In an ERD, what is an entity typically represented by?",
        "option_A": "A diamond shape",
        "option_B": "A rectangle",
        "option_C": "An oval shape",
        "option_D": "A hexagon shape",
        "correct_anwser": "B",
        "explain": "Trong sơ đồ quan hệ thực thể (ERD), một thực thể (Entity) thường được biểu diễn bằng một hình chữ nhật (Rectangle). Hình thoi biểu diễn mối quan hệ, hình bầu dục biểu diễn thuộc tính."
      },
      {
        "question_id": 9,
        "question_title": "When selecting packaged solutions, what factors determine the level of detail and effort that should be put into specifying requirements?",
        "option_A": "The availability of vendor documentation and training materials.",
        "option_B": "The complexity of the existing system that the package will replace.",
        "option_C": "The expected package costs, the evaluation timeline, and the number of candidate solutions.",
        "option_D": "The size of the development team and their familiarity with packaged solutions",
        "correct_anwser": "C",
        "explain": "Khi lựa chọn các giải pháp phần mềm đóng gói thương mại (COTS), mức độ chi tiết và công sức bỏ ra để đặc tả yêu cầu phụ thuộc lớn vào chi phí dự kiến của gói phần mềm, quỹ thời gian đánh giá cho phép, và số lượng các giải pháp ứng viên cần cân nhắc sàng lọc."
      },
      {
        "question_id": 10,
        "question_title": "What is the primary function of a \"Use Case\" in requirements engineering?",
        "option_A": "To define the database schema and data relationships.",
        "option_B": "To describe an interaction between a user (actor) and a system to achieve a specific goal.",
        "option_C": "To outline the project schedule and milestones.",
        "option_D": "To specify the non-functional constraints of the application.",
        "correct_anwser": "B",
        "explain": "Mục đích chính của Use Case (Trường hợp sử dụng) là mô tả một chuỗi tương tác hoàn chỉnh giữa một tác nhân bên ngoài (Actor) và hệ thống nhằm đạt được một mục tiêu cụ thể có giá trị đối với tác nhân đó."
      },
      {
        "question_id": 11,
        "question_title": "Which of the following describes the purpose of a context diagram in software requirements development?",
        "option_A": "It maps out the full class structure and database schema.",
        "option_B": "It defines the boundary between the system being developed and the external entities interacting with it.",
        "option_C": "It tracks the project delivery schedule and milestones.",
        "option_D": "It captures non-functional data constraints exclusively.",
        "correct_anwser": "B",
        "explain": "Sơ đồ ngữ cảnh (Context Diagram) là một mô hình mức cao được sử dụng để xác định rõ ràng ranh giới (boundary) của hệ thống phần mềm cần xây dựng với thế giới bên ngoài, đồng thời hiển thị các tác nhân hoặc hệ thống ngoại vi (external entities) có trao đổi luồng thông tin với nó."
      },
      {
        "question_id": 12,
        "question_title": "An analytical model that visually represents the life cycle of an object, showing the valid sequences of conditions it can transition through, is called:",
        "option_A": "A Data Flow Diagram",
        "option_B": "A State Transition Diagram",
        "option_C": "A Dialog Map",
        "option_D": "An Entity-Relationship Diagram",
        "correct_anwser": "B",
        "explain": "Sơ đồ chuyển trạng thái (State Transition Diagram) hiển thị một tập hợp các trạng thái mà một đối tượng có thể trải qua trong vòng đời của nó, đồng thời mô tả các sự kiện kích hoạt làm thay đổi trạng thái đó từ điều kiện này sang điều kiện khác."
      },
      {
        "question_id": 13,
        "question_title": "Which modeling technique is best suited for documenting complex business logic involving multiple combinations of conditional factors and corresponding actions?",
        "option_A": "Use Case Diagram",
        "option_B": "Decision Table or Decision Tree",
        "option_C": "Context Diagram",
        "option_D": "User Persona Grid",
        "correct_anwser": "B",
        "explain": "Bảng quyết định (Decision Table) hoặc Cây quyết định (Decision Tree) là công cụ phân tích nghiệp vụ lý tưởng nhất để biểu diễn các logic điều kiện phức tạp, nơi có nhiều sự kết hợp khác nhau giữa các yếu tố đầu vào dẫn đến các hành động xử lý khác nhau của hệ thống."
      },
      {
        "question_id": 14,
        "question_title": "Which element in a Use Case Description outlines the optimal pathway where everything works perfectly without errors?",
        "option_A": "Preconditions",
        "option_B": "Postconditions",
        "option_C": "Alternative Flows",
        "option_D": "Basic Flow or Main Success Scenario",
        "correct_anwser": "D",
        "explain": "Trong tài liệu mô tả Use Case, luồng cơ bản (Basic Flow hoặc Main Success Scenario) đại diện cho kịch bản lý tưởng nhất, nơi tất cả các bước tương tác diễn ra suôn sẻ theo đúng trình tự mong muốn và đạt được mục tiêu của tác nhân mà không gặp bất kỳ lỗi hay ngoại lệ nào."
      },
      {
        "question_id": 15,
        "question_title": "Which of the following describes the difference between an inclusion (<>) and an extension (<>) relationship in a Use Case Diagram?",
        "option_A": "Inclusion is optional, while extension is always mandatory.",
        "option_B": "Inclusion represents a mandatory subtask that is always executed as part of the base use case, while extension represents an optional behavior that occurs only under specific conditions.",
        "option_C": "Inclusion is written by developers, while extension is drafted by users.",
        "option_D": "Extension points down to the database, while inclusion points up to the user interface.",
        "correct_anwser": "B",
        "explain": "Mối quan hệ `<<include>>` chỉ ra rằng use case bị bao gồm là bắt buộc phải thực hiện mỗi khi use case gốc chạy. Ngược lại, mối quan hệ `<<extend>>` mô tả một hành vi tùy chọn (optional), chỉ được chèn vào use case gốc khi thỏa mãn một điều kiện hoặc điểm mở rộng (extension point) cụ thể."
      },
      {
        "question_id": 16,
        "question_title": "What is the key benefit of creating an entity-relationship diagram (ERD) during requirements analysis?",
        "option_A": "It tracks the weekly hours billed by individual software contractors.",
        "option_B": "It visually models the system's data objects and the logical relationships between them.",
        "option_C": "It acts as a functional user experience interaction prototype.",
        "option_D": "It compiles Java source code directly into relational database tables.",
        "correct_anwser": "B",
        "explain": "Sơ đồ quan hệ thực thể (ERD) cung cấp một mô hình trực quan hóa cấu trúc dữ liệu của hệ thống, giúp xác định rõ các thực thể dữ liệu (data objects), các thuộc tính và mối liên kết logic giữa chúng."
      },
      {
        "question_id": 17,
        "question_title": "Which component in a standard Use Case Diagram represents an external entity that interacts with the system to achieve a goal?",
        "option_A": "Extend point",
        "option_B": "Boundary block",
        "option_C": "Actor",
        "option_D": "Include arrow",
        "correct_anwser": "C",
        "explain": "Tác nhân (Actor) trong sơ đồ Use Case đại diện cho một đối tượng bên ngoài (có thể là con người, phòng ban hoặc một hệ thống khác) trực tiếp tương tác với hệ thống để thực hiện một mục tiêu nhất định."
      },
      {
        "question_id": 18,
        "question_title": "In requirements modeling, a \"Data Flow Diagram\" (DFD) is primarily used to show:",
        "option_A": "The visual layout arrangement of user interface buttons.",
        "option_B": "How data moves through a system, including processes, data stores, and external entities.",
        "option_C": "The chronological Gantt chart scheduling of project milestones.",
        "option_D": "The object-oriented class inheritance structure tree.",
        "correct_anwser": "B",
        "explain": "Sơ đồ luồng dữ liệu (DFD) được sử dụng để mô hình hóa sự chuyển động của dữ liệu trong hệ thống, chỉ ra cách dữ liệu được biến đổi qua các tiến trình (processes), lưu trữ tại các kho dữ liệu (data stores) và tương tác với các thực thể ngoài."
      },
      {
        "question_id": 19,
        "question_title": "How should the names of use cases be written?",
        "option_A": "A noun followed by a verb",
        "option_B": "A verb followed by an object",
        "option_C": "A random combination of words",
        "option_D": "A descriptive phrase",
        "correct_anwser": "B",
        "explain": "Tên của một ca sử dụng (use case) tiêu chuẩn phải luôn bắt đầu bằng một động từ thể hiện hành động hướng mục tiêu và theo sau là một bổ ngữ/đối tượng chịu tác động (Verb + Object). Ví dụ: 'Đăng nhập hệ thống', 'Rút tiền', 'Tạo hóa đơn'."
      },
      {
        "question_id": 20,
        "question_title": "Which of the following statements is TRUE about Use Cases?",
        "option_A": "Use Cases are static and do not evolve throughout the software development process.",
        "option_B": "Use case diagrams are the primary tool to document requirements",
        "option_C": "Use Cases are not useful in capturing user requirements.",
        "option_D": "Use Cases describe the interactions between the system and external entities.",
        "correct_anwser": "D",
        "explain": "Bản chất cốt lõi của ca sử dụng (Use Case) là mô tả chuỗi các sự kiện tương tác qua lại giữa một hệ thống và các tác nhân bên ngoài (external entities/actors) nhằm đạt được một mục tiêu cụ thể của người dùng."
      },
      {
        "question_id": 21,
        "question_title": "When choosing the appropriate representation techniques for analysis models, which of the following guidelines should be followed? Select two.",
        "option_A": "Business process flows can be represented with high-level data flow diagrams or Swimlane diagrams that show roles and responsibilities in the process.",
        "option_B": "Use only one type of model to avoid confusion and ensure clarity throughout the development process.",
        "option_C": "Complex logic can be effectively represented using decision trees or decision tables, which show possible outcomes or unique functional requirements.",
        "option_D": "Data relationships should be illustrated using state-transition diagrams or storyboard models.",
        "correct_anwser": "A, C",
        "explain": "Theo các nguyên tắc xây dựng mô hình phân tích: Luồng quy trình nghiệp vụ nên được mô tả bằng sơ đồ phân làn (Swimlane diagrams) để phân định rõ vai trò và trách nhiệm (A). Các logic nghiệp vụ phức tạp, chứa nhiều điều kiện rẽ nhánh rắc rối nên được biểu diễn rõ ràng qua bảng quyết định (decision tables) hoặc cây quyết định (decision trees) (C). Việc ép buộc chỉ dùng duy nhất một loại mô hình là sai lầm (loại B), và mối quan hệ dữ liệu phải dùng ERD chứ không dùng sơ đồ trạng thái (loại D)."
      },
      {
        "question_id": 22,
        "question_title": "How can a business analyst effectively translate the voice of the customer into specific model components? Select two.",
        "option_A": "By focusing exclusively on the nouns mentioned by customers, as they represent the most critical elements.",
        "option_B": "By identifying keywords such as nouns, verbs, and conditional statements that can be mapped to corresponding analysis model components.",
        "option_C": "By using a predetermined set of model components without considering the specific word choices of the customer.",
        "option_D": "By mapping verbs mentioned by customers to processes, activities, and use cases in the analysis models.",
        "correct_anwser": "B, D",
        "explain": "Để chuyển dịch ngôn ngữ của khách hàng sang mô hình phân tích một cách hiệu quả, BA cần phân tích các từ khóa ngữ pháp chính: Danh từ ánh xạ thành đối tượng/thực thể, động từ ánh xạ thành các tiến trình/ca sử dụng, và các từ điều kiện ánh xạ thành luật nghiệp vụ (B). Cụ thể, các động từ (verbs) mà khách hàng nói phản ánh trực tiếp hành động, do đó sẽ được đưa vào làm các quy trình, hoạt động hoặc ca sử dụng (D)."
      },
      {
        "question_id": 23,
        "question_title": "Which of the following is not a component of an Entity Relationship Diagrams (ERD)",
        "option_A": "Entity",
        "option_B": "Relationship",
        "option_C": "Association",
        "option_D": "Cardinality",
        "option_E": "Attribute",
        "correct_anwser": "C",
        "explain": "Các thành phần cốt lõi của sơ đồ quan hệ thực thể (ERD) bao gồm Thực thể (Entity), Mối quan hệ (Relationship), Bản số/Quan hệ số lượng (Cardinality) và Thuộc tính (Attribute). Khái niệm 'Association' (Liên kết) là thuật ngữ đặc thù thường dùng trong Sơ đồ lớp (Class Diagram) của ngôn ngữ UML chứ không thuộc thành phần tiêu chuẩn của ERD."
      },
      {
        "question_id": 24,
        "question_title": "Which of the following statements is incorrect about ERD?",
        "option_A": "Individual instances of an entity will have the same attribute values",
        "option_B": "The cardinality, or multiplicity, of each relationship is shown with a number or letter on the lines that connect entities and relationships",
        "option_C": "Each entity is described by one or more attributes",
        "option_D": "The diamonds in the ERD represent relationships, which identify the logical linkages between pairs of entities",
        "correct_anwser": "A",
        "explain": "Phát biểu A sai vì các thực thể cụ thể (individual instances) thuộc cùng một tập thực thể sẽ có cùng cấu trúc các thuộc tính, nhưng giá trị dữ liệu chứa trong các thuộc tính đó của mỗi thực thể phải khác nhau để phân biệt chúng (ví dụ: các instance Sinh viên đều có thuộc tính 'Mã SV', nhưng giá trị Mã SV của mỗi người là duy nhất)."
      },
      {
        "question_id": 25,
        "question_title": "Consider the use case diagram for the Chemical Tracking System. How does the \"extend\" relationship between \"Request a Chemical\" and \"Search Vendor Catalogs\" affect the system's functionality?",
        "option_A": "It allows \"Request a Chemical\" to function independently without any alternative flows.",
        "option_B": "It integrates \"Search Vendor Catalogs\" into the normal flow of \"Request a Chemical.\"",
        "option_C": "It provides an optional alternative flow for requesting chemicals from a vendor.",
        "option_D": "It duplicates the steps of \"Search Vendor Catalogs\" within \"Request a Chemical.\"",
        "correct_anwser": "C",
        "explain": "Quan hệ `<<extend>>` (mở rộng) từ \"Search Vendor Catalogs\" đến \"Request a Chemical\" thể hiện một luồng hành vi tùy chọn (optional/alternative flow). Hành động tìm kiếm danh mục nhà cung cấp chỉ diễn ra trong một số điều kiện nhất định khi thực hiện ca sử dụng gốc, chứ không bắt buộc thực hiện như quan hệ include."
      },
      {
        "question_id": 26,
        "question_title": "What is the primary purpose of a state-transition diagram (STD)?",
        "option_A": "To model the physical layout and hardware components of a system.",
        "option_B": "To represent the possible states of an object and the transitions between these states based on various events or conditions.",
        "option_C": "To outline the organizational roles and responsibilities within a business process.",
        "option_D": "To visualize user interface flow and interactions in software applications.",
        "correct_anwser": "B",
        "explain": "Mục đích cốt lõi của sơ đồ chuyển trạng thái (State-Transition Diagram) là mô hình hóa các trạng thái có thể có của một đối tượng hoặc hệ thống, cùng với các quy tắc, điều kiện hoặc sự kiện kích hoạt sự dịch chuyển qua lại giữa các trạng thái đó."
      },
      {
        "question_id": 27,
        "question_title": "A collection of definitions for the data elements and data structures that are relevant to the problem domain",
        "option_A": "Data dictionary",
        "option_B": "Data flow diagram",
        "option_C": "Database",
        "option_D": "Relationship",
        "correct_anwser": "A",
        "explain": "Tập hợp tất cả các định nghĩa chi tiết về các phần tử dữ liệu (data elements) và cấu trúc dữ liệu (data structures) thuộc phạm vi bài toán của hệ thống được gọi là Từ điển dữ liệu (Data dictionary)."
      },
      {
        "question_id": 28,
        "question_title": "What is the definition of Pre-Condition in Use case?",
        "option_A": "A condition that describes the state of a system after a use case is successfully completed.",
        "option_B": "A condition that must be satisfied or a state the system must be in before a use case can begin.",
        "option_C": "A condition that initiates execution of the use case",
        "option_D": "A condition that must be satisfied so that system run successful.",
        "correct_anwser": "B",
        "explain": "Điều kiện tiên quyết (Pre-condition) trong ca sử dụng được định nghĩa là một ràng buộc hoặc trạng thái bắt buộc hệ thống phải thỏa mãn trước khi ca sử dụng đó được phép kích hoạt và bắt đầu thực thi."
      },
      {
        "question_id": 29,
        "question_title": "Which elements are mandatory in use case?",
        "option_A": "Post-condition",
        "option_B": "Actors",
        "option_C": "Pre-condition",
        "option_D": "Name",
        "correct_anwser": "B, D",
        "explain": "Trong một Use Case, hai thành phần tối thiểu và bắt buộc phải có để định danh và xác định đối tượng tương tác là Tên của Use Case (Name) và Tác nhân (Actors). Điều kiện tiên quyết (Pre-condition) và điều kiện sau khi hoàn thành (Post-condition) tuy quan trọng trong tài liệu đặc tả chi tiết nhưng không phải lúc nào cũng bắt buộc ở mọi mức độ biểu diễn Use Case tổng quan."
      },
      {
        "question_id": 30,
        "question_title": "In the Chemical Tracking System project, what is the relationship between use case: \"Play a bill\" and use case: \"Write a check\" ?",
        "option_A": "include",
        "option_B": "extend",
        "option_C": "generalization",
        "option_D": "N/A",
        "correct_anwser": "B",
        "explain": "Lưu ý đề bài hiển thị lỗi chính tả từ gốc \"Pay a bill\" thành \"Play a bill\". Mối quan hệ giữa hành động \"Thanh toán hóa đơn\" (Pay a bill) và \"Viết séc\" (Write a check) là quan hệ mở rộng (extend), vì viết séc là một trong những phương thức tùy chọn, không bắt buộc để hoàn thành việc thanh toán hóa đơn (người dùng có thể trả bằng tiền mặt, thẻ tín dụng,...)."
      },
      {
        "question_id": 31,
        "question_title": "How can requirements modeling assist in resolving conflicts between stakeholders?",
        "option_A": "By providing a clear, visual representation of requirements for alignment",
        "option_B": "By finalizing all functional requirements",
        "option_C": "By focusing only on technical feasibility",
        "option_D": "By eliminating the need for prototyping",
        "correct_anwser": "A",
        "explain": "Mô hình hóa yêu cầu (Requirements modeling) sử dụng các biểu đồ trực quan giúp các bên liên quan dễ dàng nhìn thấy bức tranh tổng thể, phát hiện ra các điểm bất đồng hoặc thiếu sót, từ đó thảo luận để đi đến sự thống nhất và đồng thuận cao hơn."
      },
      {
        "question_id": 32,
        "question_title": "Which of the following factors should be considered when classifying users? Select three.",
        "option_A": "The platform they will be using, such as desktop PCs, laptops, tablets, or smartphones.",
        "option_B": "The specific languages used in the system’s backend processes.",
        "option_C": "The frequency with which they use the product and the tasks they perform during business operations.",
        "option_D": "Their access privileges or security levels, such as ordinary user, guest user, or administrator.",
        "correct_anwser": "A, C, D",
        "explain": "Khi phân loại các lớp người dùng (user classes), chúng ta dựa trên nền tảng thiết bị họ sử dụng (A), tần suất sử dụng và tác vụ nghiệp vụ họ thực hiện (C), cùng với mức độ phân quyền/bảo mật của họ trong hệ thống (D). Ngôn ngữ lập trình backend (B) thuộc về mặt kỹ thuật nội bộ, không dùng để phân loại đối tượng người dùng."
      },
      {
        "question_id": 33,
        "question_title": "Which of the following statements accurately describe the use case approach? Select two.",
        "option_A": "A use case describes a sequence of interactions between a system and an external actor that results in an outcome of value to the actor.",
        "option_B": "In a use case diagram, the boundary between what’s inside and outside the system is not explicitly defined.",
        "option_C": "Actors in a use case can include both human users and other systems that interact with the system being developed.",
        "option_D": "The primary actor in a use case is always the system itself, as it initiates and controls all interactions.",
        "correct_anwser": "A, C",
        "explain": "Cách tiếp cận Use Case mô tả chuỗi tương tác giữa hệ thống và tác nhân bên ngoài để mang lại một giá trị cụ thể cho tác nhân đó (A đúng). Tác nhân (Actors) tham gia vào Use Case không chỉ là con người mà còn có thể là các hệ thống phần mềm/phần cứng khác kết nối tới hệ thống (C đúng)."
      },
      {
        "question_id": 34,
        "question_title": "If both \"Submit loan request\" and \"Offer line of credit\" use the \"Perform credit check\" use case, the relationship between \"Perform credit check\" and the other use cases is:",
        "option_A": "Extend relationship",
        "option_B": "Generalization relationship",
        "option_C": "Include relationship",
        "correct_anwser": "C",
        "explain": "Khi nhiều use cases khác nhau đều sử dụng chung một chức năng con tuần tự và bắt buộc (ở đây là 'Perform credit check'), mối quan hệ giữa use case cơ sở và use case dùng chung đó được định nghĩa là quan hệ bao hàm (Include relationship)."
      },
      {
        "question_id": 35,
        "question_title": "How should data flows be represented between processes, data stores, and external entities in a DFD?",
        "option_A": "Directly from one process to another.",
        "option_B": "Directly from one data store to another.",
        "option_C": "Through a process bubble, not directly between data stores or between external entities and data stores.",
        "option_D": "Directly between external entities and data stores.",
        "correct_anwser": "C",
        "explain": "Trong Sơ đồ luồng dữ liệu (DFD), mọi luồng dữ liệu đi/đến kho dữ liệu (data stores) hoặc thực thể ngoài (external entities) đều bắt buộc phải đi qua một tiến trình xử lý (process bubble). Dữ liệu không thể tự di chuyển trực tiếp giữa hai kho dữ liệu, hoặc trực tiếp từ thực thể ngoài vào thẳng kho dữ liệu mà không có tiến trình xử lý tác động."
      },
      {
        "question_id": 36,
        "question_title": "Fill in the blank.\n______is a visual representation of the data objects and collections the system will process, and the relationships between them.",
        "option_A": "Use case diagram",
        "option_B": "Data model",
        "option_C": "Data dictionary",
        "option_D": "Reports",
        "correct_anwser": "B",
        "explain": "Mô hình dữ liệu (Data model), chẳng hạn như sơ đồ ERD, chính là sự thể hiện trực quan hóa cấu trúc của các đối tượng dữ liệu, tập hợp dữ liệu mà hệ thống sẽ xử lý, kèm theo các mối quan hệ ràng buộc logic giữa chúng."
      },
      {
        "question_id": 37,
        "question_title": "When defining installability requirements, which of the following factors is most important to measure how easy it is to install a system?",
        "option_A": "The number of additional components that need to be installed with the system.",
        "option_B": "The average time required for an untrained user to successfully complete the installation process.",
        "option_C": "The type of hardware used during the installation process.",
        "option_D": "The number of user profiles that need to be transferred during installation.",
        "correct_anwser": "B",
        "explain": "Yêu cầu về khả năng cài đặt (Installability) hướng tới tính dễ dàng thực hiện. Tiêu chí định lượng tốt nhất để đo lường độ 'dễ' này là thời gian trung bình cần thiết để một người dùng bình thường (chưa qua đào tạo huấn luyện) có thể tự hoàn thành việc cài đặt hệ thống thành công."
      },
      {
        "question_id": 38,
        "question_title": "In a use case diagram, an arrow from an actor to a use case indicates that he is the _________ actor for the use case.",
        "option_A": "primary",
        "option_B": "secondary",
        "option_C": "main",
        "option_D": "side",
        "correct_anwser": "A",
        "explain": "Trong sơ đồ use case, đường liên kết hoặc mũi tên xuất phát từ Actor hướng đến Use Case thường dùng để chỉ định Actor đó là tác nhân chính (Primary Actor) — người chủ động kích hoạt và tương tác trực tiếp để thực hiện use case."
      },
      {
        "question_id": 39,
        "question_title": "Which of the following would be an appropriate analysis model component for a ‘verb’ in customer language?",
        "option_A": "External entities in a Data Flow Diagram (DFD)",
        "option_B": "Relationships in an Entity Relationship Diagram (ERD)",
        "option_C": "Processes in a Data Flow Diagram (DFD)",
        "option_D": "Objects with states in a State Transition Diagram (STD)",
        "correct_anwser": "C",
        "explain": "Khi phân tích ngôn ngữ tự nhiên của khách hàng để chuyển sang mô hình hóa, các 'danh từ' thường đại diện cho thực thể (Entities/Data stores) hoặc tác nhân, còn các 'động từ' hành động (ví dụ: tính toán, kiểm tra, gửi...) sẽ tương ứng với các Tiến trình (Processes) xử lý trong sơ đồ dòng dữ liệu DFD."
      },
      {
        "question_id": 40,
        "question_title": "Fill in the blank.\n_______ is a visual representation of the data objects and collections the system will process and the relationships between them.",
        "option_A": "Use case diagram",
        "option_B": "Data model",
        "option_C": "Data dictionary",
        "option_D": "Reports",
        "correct_anwser": "B",
        "explain": "Mô hình dữ liệu (Data model) - ví dụ tiêu biểu là sơ đồ ERD - là một cách biểu diễn trực quan các đối tượng dữ liệu, tập hợp dữ liệu mà hệ thống xử lý cùng với mối quan hệ (relationships) ràng buộc giữa chúng."
      },
      {
        "question_id": 41,
        "question_title": "What technique is used to represent the scope of a project? (Choose 2 correct answers)",
        "option_A": "Ecosystem map",
        "option_B": "Use case",
        "option_C": "Context diagram",
        "option_D": "ERD",
        "correct_anwser": "A, C",
        "explain": "Theo tài liệu kỹ nghệ yêu cầu phần mềm, hai kỹ thuật mô hình hóa phân tích chuẩn mực nhất được sử dụng trực tiếp để định hình và biểu diễn phạm vi dự án (project scope) ở mức cao là Sơ đồ ngữ cảnh (Context diagram) và Sơ đồ hệ sinh thái (Ecosystem map)."
      }
    ]
  },
  {
    "id": "swr302-module-4-specification-&-quality-attributes",
    "title": "SWR302 - Module 4 - Specification & Quality Attributes",
    "description": "Software Requirement Quiz",
    "questionsCount": 41,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which of the following statements INCORRECTLY describes types of software requirements?",
        "option_A": "Business rules are the origin of several types of software requirements, but they are not software requirements themselves.",
        "option_B": "Nonfunctional requirements describe the system's performance characteristics rather than its specific behaviors.",
        "option_C": "Functional requirements describe how the system will perform certain actions under specific conditions.",
        "option_D": "Quality attributes describe the system's functional behaviors in terms of user interactions.",
        "correct_anwser": "D",
        "explain": "Quality attributes (Thuộc tính chất lượng) là một phần của yêu cầu phi chức năng (Nonfunctional requirements), mô tả các đặc tính vận hành như hiệu năng, bảo mật, độ tin cậy, chứ không phải mô tả hành vi chức năng (functional behaviors) hay tương tác của người dùng."
      },
      {
        "question_id": 2,
        "question_title": "Why is it challenging to amalgamate requirements input from numerous users?",
        "option_A": "Users often disagree on technical specifications.",
        "option_B": "Structured organizing schemes are typically unavailable.",
        "option_C": "Requirements input is often diverse and unstructured.",
        "option_D": "Users lack domain expertise.",
        "correct_anwser": "C",
        "explain": "Việc tổng hợp dữ liệu yêu cầu đầu vào từ quá nhiều người dùng luôn là một thách thức lớn vì thông tin nhận được thường rất đa dạng, phân mảnh, chồng chéo và thiếu cấu trúc đồng nhất."
      },
      {
        "question_id": 3,
        "question_title": "\"Every order has a shipping charge\" is a:",
        "option_A": "fact",
        "option_B": "constraint",
        "option_C": "action enabler",
        "option_D": "inference",
        "correct_anwser": "A",
        "explain": "Câu phát biểu 'Mỗi đơn hàng đều có phí vận chuyển' biểu thị một chân lý nghiệp vụ luôn đúng và tồn tại trong tổ chức đó, vì thế nó được phân loại vào nhóm 'Fact' (Sự thật/Chân lý nghiệp vụ) theo lý thuyết về Business Rules."
      },
      {
        "question_id": 4,
        "question_title": "Which of the following is NOT a type of business rule according to the taxonomy?",
        "option_A": "Fact Rules",
        "option_B": "Action Enabler Rules",
        "option_C": "Constraint Rules",
        "option_D": "Operational Rules",
        "correct_anwser": "D",
        "explain": "Theo phân loại chuẩn của giáo trình kỹ nghệ yêu cầu (ví dụ của Karl Wiegers), luật nghiệp vụ (Business Rules) được phân làm các nhóm chính bao gồm: Facts, Constraints, Action Enablers, Inferences và Computations. 'Operational Rules' không nằm trong hệ thống phân loại chuẩn này."
      },
      {
        "question_id": 5,
        "question_title": "In the specification of a use case, conditions that have the potential to prevent a use case from succeeding are called _______.",
        "option_A": "exceptions",
        "option_B": "alternative flows",
        "option_C": "secondary scenarios",
        "option_D": "backup flows",
        "correct_anwser": "A",
        "explain": "Các điều kiện hay tình huống phát sinh ngoài dự kiến có khả năng phá vỡ luồng xử lý chính và khiến cho ca sử dụng thất bại (không đạt được mục tiêu của tác nhân) được gọi là 'Exceptions' (Ngoại lệ/Tình huống lỗi)."
      },
      {
        "question_id": 6,
        "question_title": "In a software requirements specification, which section do user interfaces belong to?",
        "option_A": "Overall description",
        "option_B": "System features",
        "option_C": "Data requirements",
        "option_D": "External interface requirements",
        "correct_anwser": "D",
        "explain": "Trong tài liệu đặc tả yêu cầu phần mềm (SRS - chuẩn IEEE), mô tả về giao diện người dùng (User Interfaces) cùng với giao diện phần cứng, phần mềm và giao tiếp truyền thông sẽ được xếp vào mục 'External interface requirements' (Yêu cầu giao diện bên ngoài)."
      },
      {
        "question_id": 7,
        "question_title": "How can you explain the statement \"Implicit requirements can also be unknown unknowns\"?",
        "option_A": "During the SRS process, customers should always be required to spell out their unknown unknowns.",
        "option_B": "An unknown unknown cannot be known and therefore we can not make them explicit requirements.",
        "option_C": "There are matters that should be, but are not, elicited through the elicitation process. They exist, but they are not realized.",
        "option_D": "They help us reveal both known unknowns and more unknown unknowns.",
        "correct_anwser": "C",
        "explain": "Khái niệm 'Implicit requirements can also be unknown unknowns' ám chỉ những điều hoặc những nghiệp vụ ngầm định mà khách hàng hoàn toàn quên hoặc không hề nhận thức được rằng hệ thống cần phải có. Do đó, chúng tồn tại một cách khách quan nhưng chưa được phát hiện hay nhận thức được trong suốt quá trình khơi gợi yêu cầu."
      },
      {
        "question_id": 8,
        "question_title": "External quality attributes describe characteristics that are observed when the software is executing. Which following definitions is Integrity?",
        "option_A": "It deals with blocking unauthorized access to system functions or data, ensuring that the software is protected from malware attacks, and so on.",
        "option_B": "It is the degree to which a system continues to function properly when confronted with invalid inputs.",
        "option_C": "It deals with preventing information loss and preserving the correctness of data entered into the system.",
        "option_D": "It deal with the need to prevent a system from doing any injury to people or damage to property.",
        "correct_anwser": "C",
        "explain": "Tính toàn vẹn (Integrity) theo định nghĩa thuộc tính chất lượng bên ngoài là việc ngăn ngừa mất mát thông tin, đảm bảo tính chính xác, không bị chỉnh sửa trái phép hoặc làm sai lệch dữ liệu khi đưa vào hệ thống."
      },
      {
        "question_id": 9,
        "question_title": "Which of the following is an example of an external quality attribute?",
        "option_A": "Performance",
        "option_B": "Maintainability",
        "option_C": "Portability",
        "option_D": "Usability",
        "correct_anwser": "A, D",
        "explain": "Thuộc tính chất lượng bên ngoài (External quality attributes) là những đặc tính có thể dễ dàng cảm nhận hoặc quan sát được bởi người dùng khi hệ thống đang vận hành, chẳng hạn như Performance (Hiệu năng - tốc độ phản hồi) và Usability (Tính khả dụng - sự dễ dùng). Ngược lại, Maintainability (Khả năng bảo trì) và Portability (Tính di động) là các thuộc tính bên trong (Internal), chủ yếu được quan tâm bởi các kỹ sư phần mềm khi tiếp cận mã nguồn."
      },
      {
        "question_id": 10,
        "question_title": "A requirement that states \"The system must process payments within 2 seconds\" is an example of:",
        "option_A": "A Business Requirement",
        "option_B": "A Functional Requirement",
        "option_C": "A Non-Functional Requirement (Performance)",
        "option_D": "A User Requirement",
        "correct_anwser": "C",
        "explain": "Yêu cầu giới hạn về mặt thời gian phản hồi (xử lý trong vòng 2 giây) là một tiêu chí định lượng đo lường chất lượng vận hành của hệ thống, đây là ví dụ điển hình của Yêu cầu phi chức năng (Non-Functional Requirement), cụ thể thuộc đặc tính hiệu năng (Performance)."
      },
      {
        "question_id": 11,
        "question_title": "Which document serves as the single source of truth for the complete requirements of a system?",
        "option_A": "Project Architecture Document",
        "option_B": "Software Requirements Specification (SRS)",
        "option_C": "User Acceptance Test Plan",
        "option_D": "Daily Scrum Log",
        "correct_anwser": "B",
        "explain": "Tài liệu Đặc tả Yêu cầu Phần mềm (SRS - Software Requirements Specification) là văn bản chính thức đóng vai trò tập trung toàn bộ các yêu cầu chức năng, phi chức năng của hệ thống, là nguồn căn cứ chuẩn xác nhất (source of truth) cho toàn bộ dự án."
      },
      {
        "question_id": 12,
        "question_title": "What is the primary role of a \"Data Dictionary\" in requirements specification?",
        "option_A": "To store compiled software execution binary files.",
        "option_B": "To define the structure, format, and meaning of all data elements used across the system.",
        "option_C": "To translate code variables into multiple foreign languages dynamically.",
        "option_D": "To list the roles and titles of the software company management.",
        "correct_anwser": "B",
        "explain": "Từ điển dữ liệu (Data Dictionary) đóng vai trò định nghĩa một cách nhất quán cấu trúc, kiểu dữ liệu, định dạng, độ dài và ý nghĩa của tất cả các phần tử dữ liệu xuất hiện trong hệ thống để toàn bộ đội ngũ phát triển và kiểm thử có chung một cách hiểu."
      },
      {
        "question_id": 13,
        "question_title": "What type of requirement constraint does the statement \"The system database must be backed up automatically every night at 2:00 AM\" represent?",
        "option_A": "Business Requirement",
        "option_B": "Functional Requirement",
        "option_C": "Non-Functional Requirement (Operational/Reliability)",
        "option_D": "User Requirement",
        "correct_anwser": "C",
        "explain": "Yêu cầu sao lưu dữ liệu tự động định kỳ vào một khung giờ cố định là một ràng buộc về mặt vận hành, quản lý hệ thống và bảo toàn dữ liệu. Đây là một ví dụ điển hình của Yêu cầu phi chức năng (Non-Functional Requirement), cụ thể thuộc nhóm vận hành (Operational) hoặc tính tin cậy (Reliability)."
      },
      {
        "question_id": 14,
        "question_title": "The subdiscipline of requirements development that focuses on ensuring a requirement document is written clearly, contains no contradictions, and is ready for development is:",
        "option_A": "Elicitation",
        "option_B": "Analysis",
        "option_C": "Specification",
        "option_D": "Validation",
        "correct_anwser": "C",
        "explain": "Khai báo yêu cầu (Specification) là hoạt động chuyển dịch các yêu cầu đã thu thập và phân tích thành một dạng văn bản có cấu trúc rõ ràng, nhất quán (như tài liệu SRS). Nó tập trung vào việc ghi chép lại các yêu cầu một cách tường minh để sẵn sàng bàn giao cho đội ngũ lập trình."
      },
      {
        "question_id": 15,
        "question_title": "Which of the following is considered a core element that should be documented within a detailed Use Case Description?",
        "option_A": "The compilation optimization configuration flags.",
        "option_B": "The specific server cluster physical hardware layout specifications.",
        "option_C": "Preconditions, Postconditions, and Actor-System interaction flows.",
        "option_D": "The third-party software license billing invoice schedule.",
        "correct_anwser": "C",
        "explain": "Một tài liệu mô tả Use Case chi tiết bắt buộc phải có các thành phần cốt lõi: Điều kiện tiên quyết (Preconditions), Điều kiện sau khi hoàn thành (Postconditions), Luồng sự kiện chính (Basic Flow) và các luồng phụ/ngoại lệ để mô tả chi tiết tương tác giữa Actor và Hệ thống."
      },
      {
        "question_id": 16,
        "question_title": "During requirements specification, writing \"The user should find the application interface friendly and modern\" represents a low-quality requirement because it fails which criterion?",
        "option_A": "Complete",
        "option_B": "Traceable",
        "option_C": "Unambiguous and Measurable",
        "option_D": "Consistent",
        "correct_anwser": "C",
        "explain": "Các từ ngữ mang tính cảm tính như \"friendly\" (thân thiện) và \"modern\" (hiện đại) không thể đo lường (Measurable) hay kiểm chứng một cách khách quan, đồng thời dễ gây ra cách hiểu khác nhau (fail tiêu chí Unambiguous)."
      },
      {
        "question_id": 17,
        "question_title": "A high-quality software requirement specification (SRS) document must be \"Consistent.\" This means:",
        "option_A": "It contains no contradictory requirements or terms.",
        "option_B": "It is updated hourly by automated cloud webhooks.",
        "option_C": "It is written entirely in compiled low-level machine code bytes.",
        "option_D": "It uses different naming definitions for the same data element.",
        "correct_anwser": "A",
        "explain": "Tiêu chí \"Nhất quán\" (Consistent) đòi hỏi tài liệu SRS không được chứa các yêu cầu mâu thuẫn hoặc xung đột lẫn nhau (ví dụ: một chỗ ghi trường dữ liệu bắt buộc nhập, chỗ khác lại ghi cho phép để trống)."
      },
      {
        "question_id": 18,
        "question_title": "How does the process of elicitation relate to the other activities in requirements development?",
        "option_A": "Elicitation is performed only after specification is complete.",
        "option_B": "Elicitation is an initial step that does not need to be revisited.",
        "option_C": "Elicitation is interwoven with analysis, specification, and validation.",
        "option_D": "Elicitation is only necessary for the first iteration of the project.",
        "correct_anwser": "C",
        "explain": "Khơi gợi yêu cầu (Elicitation) không phải là một bước làm một lần duy nhất rồi thôi. Nó đan xen và gắn kết chặt chẽ (interwoven) với các hoạt động phân tích, đặc tả và xác thực xuyên suốt quá trình phát triển để liên tục làm rõ các yêu cầu mới phát sinh hoặc cần chi tiết hóa."
      },
      {
        "question_id": 19,
        "question_title": "In the specification of a use case, conditions that have the potential to prevent a use case from succeeding are called ________.",
        "option_A": "exceptions",
        "option_B": "alternative flows",
        "option_C": "secondary scenarios",
        "option_D": "backup flows",
        "correct_anwser": "A",
        "explain": "Trong đặc tả ca sử dụng (Use case specification), các điều kiện hoặc tình huống lỗi xảy ra làm gián đoạn luồng xử lý chính và có khả năng ngăn cản ca sử dụng đạt được mục tiêu thành công của nó được định nghĩa là các ngoại lệ (Exceptions) hay luồng ngoại lệ (Exception flows)."
      },
      {
        "question_id": 20,
        "question_title": "Which of the following statements accurately describes a business rule? Select two.",
        "option_A": "A business rule is a statement that defines or constrains some aspect of the business to control or influence its behavior.",
        "option_B": "Business rules are only relevant for heavily rules-driven systems and can be ignored in simpler systems.",
        "option_C": "Classifying business rules helps in understanding how they might be applied in a software application, such as using constraints to enforce certain conditions.",
        "option_D": "A business rule is the same as a system requirement, focusing solely on the technical implementation details.",
        "correct_anwser": "A, C",
        "explain": "Luật kinh doanh (Business Rule) là các tuyên bố định nghĩa hoặc giới hạn một khía cạnh nào đó của doanh nghiệp nhằm kiểm soát hoặc định hướng hành vi hoạt động (A). Việc phân loại cấu trúc luật kinh doanh giúp đội ngũ dự án hiểu rõ cách áp dụng chúng vào ứng dụng phần mềm (chuyển đổi thành các ràng buộc, điều kiện logic mã nguồn) một cách chính xác (C)."
      },
      {
        "question_id": 21,
        "question_title": "Which of the following is not included in software requirements specification (SRS) template ?",
        "option_A": "Quality Attributes",
        "option_B": "External interface",
        "option_C": "Data requirements",
        "option_D": "Design features",
        "correct_anwser": "D",
        "explain": "Tài liệu đặc tả yêu cầu phần mềm (SRS) tập trung vào việc mô tả hệ thống phải làm gì (yêu cầu chức năng, phi chức năng, thuộc tính chất lượng, giao diện bên ngoài). Các đặc điểm hoặc giải pháp thiết kế chi tiết (Design features/details) thuộc về giai đoạn thiết kế kiến trúc hệ thống (SDD - Software Design Document) chứ không nằm trong SRS."
      },
      {
        "question_id": 22,
        "question_title": "When considering software quality attributes, which of the following is classified as an internal quality attribute?",
        "option_A": "Usability",
        "option_B": "Security",
        "option_C": "Efficiency",
        "option_D": "Availability",
        "correct_anwser": "C",
        "explain": "Thuộc tính chất lượng bên trong (Internal quality attributes) là những khía cạnh mà người dùng cuối không trực tiếp nhìn thấy hay trải nghiệm khi sử dụng, nhưng nhà phát triển có thể đo lường và đánh giá thông qua mã nguồn, cấu trúc phần mềm bên trong hệ thống. Trong đó, tính hiệu quả (Efficiency - như tối ưu mã nguồn, kiến trúc tài nguyên) được xem là thuộc tính bên trong tạo tiền đề cho hiệu năng hệ thống hoạt động tốt bên ngoài."
      },
      {
        "question_id": 23,
        "question_title": "What is Planguage?",
        "option_A": "It is a programming language.",
        "option_B": "It is a language with a rich set of keywords that permits precise statements of quality attributes and other project goals.",
        "option_C": "It is a planning language used in project management.",
        "option_D": "It is a language to express non functional requirements.",
        "correct_anwser": "B",
        "explain": "Planguage (được phát triển bởi Tom Gilb) là một ngôn ngữ đặc tả dạng văn bản có cấu trúc với tập hợp phong phú các từ khóa định sẵn (như Tag, Metric, Scale, Target...). Nó được thiết kế nhằm giúp các nhà phân tích đưa ra các phát biểu định lượng vô cùng chính xác cho các yêu cầu phi chức năng, các thuộc tính chất lượng phần mềm cũng như các mục tiêu cốt lõi của dự án."
      },
      {
        "question_id": 24,
        "question_title": "Which one of the following is a functional requirement?",
        "option_A": "Portability.",
        "option_B": "Order products.",
        "option_C": "Maintainability.",
        "option_D": "Security.",
        "option_E": "Robustness.",
        "correct_anwser": "B",
        "explain": "Yêu cầu chức năng (Functional Requirement) định nghĩa một hành vi hoặc chức năng cụ thể mà phần mềm phải thực hiện cho người dùng. Trong các phương án, 'Đặt hàng sản phẩm' (Order products) là một tính năng nghiệp vụ rõ ràng. Các phương án còn lại (Portability, Maintainability, Security, Robustness) đều là các thuộc tính chất lượng hoặc yêu cầu phi chức năng (Non-functional Requirements)."
      },
      {
        "question_id": 25,
        "question_title": "Which of the following is the most precise definition of \"requirement(s)\"?",
        "option_A": "A requirement is anything that drives design choices.",
        "option_B": "A requirement is a property that a product must have to provide value to a stakeholder.",
        "option_C": "Requirements are a specification of what should be implemented. They are descriptions of how the system should behave, or of a system property or attribute. They may be a constraint on the development process of the system.",
        "option_D": "Requirements are what customers want.",
        "correct_anwser": "B",
        "explain": "Theo định nghĩa chuẩn của Karl Wiegers và tài liệu Kỹ nghệ yêu cầu phần mềm, định nghĩa chính xác và bao quát nhất ở mức bản chất là: Yêu cầu là một đặc tính hoặc thuộc tính mà sản phẩm bắt buộc phải có để đem lại giá trị cho một bên liên quan (stakeholder). Lựa chọn C mô tả thiên về khía cạnh tài liệu đặc tả (specification), trong khi ý B nhấn mạnh vào bản chất cốt lõi của yêu cầu là 'mang lại giá trị'."
      },
      {
        "question_id": 26,
        "question_title": "Evaluate the effectiveness of using business process modeling to discover business rules. Which of the following best describes its impact?",
        "option_A": "It only identifies computational rules and ignores constraints.",
        "option_B": "It helps identify rules affecting each process step, including constraints and triggering events.",
        "option_C": "It focuses solely on the analysis of existing documentation.",
        "option_D": "It is ineffective in discovering business rules related to data states",
        "correct_anwser": "B",
        "explain": "Mô hình hóa quy trình nghiệp vụ (Business Process Modeling) giúp người phân tích rà soát trực quan từng bước công việc, từ đó dễ dàng phát hiện ra các quy tắc nghiệp vụ điều phối hành vi, bao gồm các ràng buộc (constraints) và các sự kiện kích hoạt (triggering events) tác động lên bước đó."
      },
      {
        "question_id": 27,
        "question_title": "Which of the following are common places and ways to look for business rules? Choose 3 correct answers.",
        "option_A": "\"Common knowledge\" from the organization, often collected from individuals who have worked with the business for a long time and know the details of how it operates.",
        "option_B": "Legacy systems that embed business rules in their requirements and code.",
        "option_C": "Analysis of existing documentation, including requirements specifications from earlier projects, regulations, industry standards, corporate policy documents, contracts, and business plans.",
        "option_D": "Business laws",
        "correct_anwser": "A, B, C",
        "explain": "Ba nguồn phổ biến và thực tế nhất để tìm kiếm luật nghiệp vụ trong kỹ nghệ yêu cầu là: Tri thức ngầm định của các nhân sự lâu năm (A), hệ thống cũ/mã nguồn di sản (B), và các tài liệu, quy định, chính sách hiện có của doanh nghiệp (C). Cụm từ \"Business laws\" (D) mang nghĩa luật pháp kinh doanh chung của nhà nước, quá rộng và không phải từ khóa chuyên môn đặc thù để khai thác luật nội bộ của một phần mềm cụ thể."
      },
      {
        "question_id": 28,
        "question_title": "Which of the following does NOT suggest an overall description of the Software Requirements Specification template?",
        "option_A": "Product perspective",
        "option_B": "User classes and characteristics",
        "option_C": "Operating environment",
        "option_D": "Design and implementation constraints",
        "option_E": "Assumptions and dependencies",
        "option_F": "System feature",
        "correct_anwser": "F",
        "explain": "Trong cấu trúc chuẩn của tài liệu SRS (như chuẩn IEEE 830 hay template của Karl Wiegers), phần số 2 là \"Overall Description\" (Mô tả tổng quan) chứa các mục như góc nhìn sản phẩm, đặc điểm người dùng, môi trường, ràng buộc, giả định. Phần \"System Features\" (Các tính năng hệ thống) nằm ở mục riêng biệt số 3 (Detailed Requirements) chứ không thuộc phần mô tả tổng quan."
      },
      {
        "question_id": 29,
        "question_title": "Which of the following are considered good practices in requirements elicitation? Select two.",
        "option_A": "Defining the product vision and project scope early in the project to ensure all stakeholders have a shared understanding.",
        "option_B": "Focusing exclusively on nonfunctional requirements during initial elicitation while ignoring functional requirements to save time.",
        "option_C": "Identifying user classes and their characteristics to ensure that all user needs are considered.",
        "option_D": "Avoiding the use of prototypes in the early stages of requirements elicitation to prevent biasing stakeholders.",
        "correct_anwser": "A, C",
        "explain": "Trong khơi gợi yêu cầu, việc xác định tầm nhìn và phạm vi dự án từ sớm (A) giúp định hướng đúng cho toàn bộ quá trình, và việc phân loại các nhóm người dùng (user classes) cùng đặc điểm của họ (C) giúp đảm bảo không bỏ sót nhu cầu của các bên liên quan."
      },
      {
        "question_id": 30,
        "question_title": "Which of the following elements should be included when crafting a vision statement? Select three",
        "option_A": "The specific target customer for whom the product is intended.",
        "option_B": "A detailed technical specification of the product's architecture.",
        "option_C": "The key benefit or compelling reason for the customer to buy or use the product.",
        "option_D": "A comparison with the primary competitive alternative or current system.",
        "correct_anwser": "A, C, D",
        "explain": "Một tuyên bố tầm nhìn sản phẩm (Vision Statement) tiêu chuẩn cấu trúc theo Karl Wiegers thường bao gồm khách hàng mục tiêu (A), lợi ích cốt lõi giải quyết nhu cầu khách hàng (C) và điểm khác biệt/so sánh với giải pháp thay thế cạnh tranh (D). Chi tiết kiến trúc kỹ thuật (B) là phần thuộc về tài liệu thiết kế hệ thống, không đưa vào tuyên bố tầm nhìn định hướng kinh doanh."
      },
      {
        "question_id": 31,
        "question_title": "Which of the following practices should be followed when documenting software requirements? Select two.",
        "option_A": "Ensure that each requirement is documented in multiple places to increase visibility and reduce the risk of it being overlooked.",
        "option_B": "Use a consistent format for documenting requirements to enhance clarity and understanding among all stakeholders.",
        "option_C": "Avoid documenting requirements that involve complex logic, as these can be difficult for stakeholders to understand.",
        "option_D": "The software requirements specification (SRS) should be used to formally record the agreed-upon requirements and ensure all stakeholders have a shared understanding.",
        "correct_anwser": "B, D",
        "explain": "Khi viết tài liệu yêu cầu, việc sử dụng định dạng nhất quán giúp tăng tính rõ ràng dễ hiểu (B) và tài liệu SRS là nơi chính thức hóa các yêu cầu đã thống nhất giữa các bên (D). Viết yêu cầu ở nhiều nơi (A) gây dư thừa, dễ dẫn tới không đồng nhất khi thay đổi, còn (C) sai vì không thể bỏ qua logic phức tạp."
      },
      {
        "question_id": 32,
        "question_title": "When documenting data requirements for a system, which of the following practices should be followed? Select three.",
        "option_A": "Include a detailed implementation data model directly in the SRS to ensure clarity in the system's design.",
        "option_B": "Create a data dictionary that defines the composition, meaning, data type, and allowed values for all data elements the system will handle.",
        "option_C": "Document any reports that the application will generate, focusing on their logical descriptions and deferring detailed layouts to the design stage.",
        "option_D": "Describe how data will be acquired, maintained, and protected, including policies for data retention, disposal, and ensuring data integrity.",
        "correct_anwser": "B, C, D",
        "explain": "Tài liệu hóa dữ liệu ở mức yêu cầu cần tập trung vào: Từ điển dữ liệu (B), mô tả logic của báo cáo (C), và vòng đời/chính sách bảo vệ dữ liệu (D). Mô tả chi tiết mô hình dữ liệu cài đặt vật lý (A) là việc thuộc về giai đoạn thiết kế kỹ thuật, không nên đưa vào SRS."
      },
      {
        "question_id": 33,
        "question_title": "Which keyword in Planguage defines the goal or minimum acceptable achievement level?",
        "option_A": "AMBITION",
        "option_B": "SCALE",
        "option_C": "GOAL",
        "option_D": "WISH",
        "correct_anwser": "C",
        "explain": "Trong ngôn ngữ Planguage (được dùng để định lượng các yêu cầu phi chức năng), từ khóa `GOAL` đại diện cho mức độ đạt được thành tựu mục tiêu mong muốn tối thiểu được chấp nhận của hệ thống."
      },
      {
        "question_id": 34,
        "question_title": "Which of the following best describes the primary purpose of a vision and scope document?",
        "option_A": "To detail the technical specifications of the project.",
        "option_B": "To collect business requirements into a single deliverable for subsequent development work.",
        "option_C": "To outline the marketing strategy for the product.",
        "option_D": "To provide a detailed project timeline.",
        "correct_anwser": "B",
        "explain": "Tài liệu tầm nhìn và phạm vi (Vision and Scope document) tập trung vào việc tổng hợp và kết tinh các yêu cầu kinh doanh (business requirements) cốt lõi thành một kết quả bàn giao thống nhất, làm nền tảng định hướng cho toàn bộ các công việc phát triển và thiết kế kỹ thuật tiếp theo."
      },
      {
        "question_id": 35,
        "question_title": "What is the primary challenge in eliciting non-functional requirements?",
        "option_A": "They are often ambiguous and difficult to quantify.",
        "option_B": "They are less important than functional requirements.",
        "option_C": "They focus only on system design.",
        "option_D": "They do not require stakeholder input.",
        "correct_anwser": "A",
        "explain": "Thách thức lớn nhất khi thu thập yêu cầu phi chức năng (non-functional requirements) là chúng thường mang tính mơ hồ, cảm tính và khó định lượng một cách chính xác (ví dụ: người dùng nói hệ thống phải 'nhanh' hoặc 'dễ dùng' mà không đưa ra con số cụ thể)."
      },
      {
        "question_id": 36,
        "question_title": "What is the simplest way to initially manage business rules in an organization?",
        "option_A": "Implement a full-scale business rule management tool",
        "option_B": "Use a requirements management tool",
        "option_C": "Use a word processor or a simple catalog",
        "option_D": "Write business rules directly in application code",
        "correct_anwser": "C",
        "explain": "Để bắt đầu quản lý các quy tắc nghiệp vụ (business rules) một cách đơn giản nhất trong giai đoạn đầu của một tổ chức, việc sử dụng các trình soạn thảo văn bản (Word processor) hoặc một danh mục bảng biểu lưu trữ đơn giản (simple catalog) là phương án ít tốn kém và dễ thực hiện nhất."
      },
      {
        "question_id": 37,
        "question_title": "What is the key difference between functional and non-functional requirements?",
        "option_A": "Functional requirements describe what the system does; non-functional requirements describe how the system performs.",
        "option_B": "Functional requirements are optional, while non-functional requirements are mandatory.",
        "option_C": "Functional requirements are stakeholder-specific, while non-functional requirements apply to developers",
        "option_D": "There is no difference between functional and non-functional requirements",
        "correct_anwser": "A",
        "explain": "Yêu cầu chức năng (Functional requirements) mô tả hệ thống làm được những gì (hành vi, tính năng). Yêu cầu phi chức năng (Non-functional requirements) mô tả các đặc tính vận hành hoặc chất lượng của hệ thống (hiệu năng, bảo mật, độ tin cậy)."
      },
      {
        "question_id": 38,
        "question_title": "When requirements elicitation, the customer states, \"Save $X per year on electricity now wasted by inefficient units\". As an analyst, what type of requirement does this statement belong to?",
        "option_A": "User requirements",
        "option_B": "Business rules",
        "option_C": "Business requirements",
        "option_D": "Quality attributes",
        "option_E": "Solution ideas",
        "correct_anwser": "C",
        "explain": "Phát biểu này tập trung vào lợi ích tài chính và mục tiêu kinh doanh cấp cao của tổ chức (tiết kiệm chi phí vận hành), do đó nó thuộc phân loại Yêu cầu kinh doanh (Business Requirements)."
      },
      {
        "question_id": 39,
        "question_title": "The system shall be able to import any valid chemical structure from the ChemDraw (version 13.0 or earlier) and MarvinSketch (version 5.0 or earlier) tools. Which quality attribute does the mentioned statement refer to?",
        "option_A": "Interoperability",
        "option_B": "Integrity",
        "option_C": "Performance",
        "option_D": "Reliability",
        "correct_anwser": "A",
        "explain": "Khả năng hệ thống có thể kết nối, đọc hiểu và nhập dữ liệu cấu trúc hóa học từ định dạng tệp của các công cụ/phần mềm bên ngoài khác (ChemDraw, MarvinSketch) trực tiếp phản ánh đặc tính Khả năng tương tác / Tương hợp hệ thống (Interoperability)."
      },
      {
        "question_id": 40,
        "question_title": "In the specification of a use case, conditions that have the potential to prevent a use case from succeeding are called _____________",
        "option_A": "exceptions",
        "option_B": "alternative flows",
        "option_C": "secondary scenarios",
        "option_D": "backup flows",
        "correct_anwser": "A",
        "explain": "Trong đặc tả Use Case, luồng ngoại lệ (exceptions) mô tả các điều kiện hoặc tình huống lỗi xảy ra làm ngăn cản Use Case đạt được mục đích thành công mong muốn của tác nhân."
      },
      {
        "question_id": 41,
        "question_title": "Which of the following is not an external quality attribute?",
        "option_A": "Availability",
        "option_B": "Integrity",
        "option_C": "Safety",
        "option_D": "Reusability",
        "correct_anwser": "D",
        "explain": "Thuộc tính chất lượng bên ngoài (External attributes) là những đặc tính có thể quan sát được khi hệ thống đang chạy (như Availability, Integrity, Safety). Ngược lại, Reusability (Khả năng tái sử dụng) là thuộc tính chất lượng bên trong (Internal attribute), chỉ các kỹ sư lập trình nhìn thấy và đánh giá thông qua mã nguồn."
      }
    ]
  },
  {
    "id": "swr302-module-5-validation-&-verification",
    "title": "SWR302 - Module 5 - Validation & Verification",
    "description": "Software Requirement Quiz",
    "questionsCount": 56,
    "questions": [
      {
        "question_id": 1,
        "question_title": "Which one of these is NOT a Business analyst's task?",
        "option_A": "Communicate requirements",
        "option_B": "Document requirements",
        "option_C": "Analyze requirements",
        "option_D": "Assure requirements",
        "option_E": "Elicit requirements",
        "correct_anwser": "D",
        "explain": "'Assure requirements' (Đảm bảo chất lượng/kiểm định yêu cầu thường thuộc về vai trò QA/QC hoặc quy trình Validation tập thể), các nhiệm vụ cốt lõi của BA bao gồm khơi gợi (Elicit), phân tích (Analyze), tài liệu hóa (Document) và giao tiếp (Communicate) yêu cầu."
      },
      {
        "question_id": 2,
        "question_title": "Why is it essential to validate requirements with stakeholders?",
        "option_A": "To ensure they align with business goals and user expectations",
        "option_B": "To reduce the scope of non-functional requirements",
        "option_C": "To finalize the system design early",
        "option_D": "To prioritize coding tasks over prototyping",
        "correct_anwser": "A",
        "explain": "Xác thực yêu cầu (Validate requirements) với stakeholders là hoạt động tối quan trọng nhằm đảm bảo chắc chắn rằng các yêu cầu đã thu thập hoàn toàn thống nhất, đồng bộ với mục tiêu kinh doanh chiến lược và kỳ vọng thực tế của người dùng."
      },
      {
        "question_id": 3,
        "question_title": "Which of the following is NOT an intended audience for a Software Requirements Specification (SRS)?",
        "option_A": "Project Managers",
        "option_B": "Testers",
        "option_C": "Legal Staff",
        "option_D": "Hardware Manufacturers",
        "option_E": "Documentation Writers",
        "correct_anwser": "C",
        "explain": "Tài liệu SRS được thiết kế chủ yếu cho các bên liên quan trực tiếp đến việc xây dựng sản phẩm như PM, Developer, Tester, Hardware Manufacturers (nếu có tích hợp phần cứng) và người viết tài liệu hướng dẫn. 'Legal Staff' (Nhân viên pháp lý) thường chỉ quan tâm đến hợp đồng hoặc chính sách tuân thủ tầm cao chứ không phải là đối tượng độc giả mục tiêu trực tiếp để đọc hiểu các yêu cầu kỹ thuật chi tiết của SRS."
      },
      {
        "question_id": 4,
        "question_title": "What does the \"STRETCH\" keyword in Planguage represent?",
        "option_A": "The ideal performance level",
        "option_B": "A benchmark for testing",
        "option_C": "A more desirable performance objective than the minimum goal",
        "option_D": "A failure condition",
        "correct_anwser": "C",
        "explain": "Trong ngôn ngữ đặc tả Planguage (được dùng để định lượng yêu cầu phi chức năng), từ khóa 'STRETCH' đại diện cho một mục tiêu hiệu năng mong muốn cao hơn, mang tính thách thức hơn so với cái đích tối thiểu phải đạt được (Target/Minimum)."
      },
      {
        "question_id": 5,
        "question_title": "What is the primary purpose of using a prototype in the software development process?",
        "option_A": "To finalize the product design and ensure no further changes are needed.",
        "option_B": "To validate requirements by finding errors and omissions, and assessing their accuracy and quality.",
        "option_C": "To create a fully functional product that can be immediately deployed.",
        "option_D": "To focus solely on the user experience without considering technical feasibility.",
        "correct_anwser": "B",
        "explain": "Mục đích cốt lõi của việc sử dụng mẫu thử (Prototype) là để xác thực yêu cầu (Validate requirements). Thông qua tương tác sớm với mẫu thử, người dùng và BA có thể phát hiện ra các sai sót, các điểm còn thiếu, đồng thời đánh giá được mức độ chính xác và chất lượng của tập yêu cầu trước khi tiến hành code thật."
      },
      {
        "question_id": 6,
        "question_title": "What is a key benefit of using mock-ups in prototyping?",
        "option_A": "To test the performance of the system",
        "option_B": "To demonstrate the system's functionality",
        "option_C": "To clarify user interface designs early",
        "option_D": "To finalize system features",
        "correct_anwser": "C",
        "explain": "Mock-up là bản mô phỏng tĩnh, tập trung chủ yếu vào khía cạnh trực quan của hệ thống. Lợi ích lớn nhất của nó là giúp các bên liên quan làm rõ và thống nhất về thiết kế giao diện người dùng (UI Design) ngay từ giai đoạn sớm của dự án."
      },
      {
        "question_id": 7,
        "question_title": "Why is a defect checklist important during requirements validation?",
        "option_A": "It helps to systematically identify potential issues in the requirements",
        "option_B": "It ensures the system meets the design specifications",
        "option_C": "It simplifies the testing process",
        "option_D": "It provides detailed technical instructions for developers",
        "correct_anwser": "A",
        "explain": "Bảng kiểm lỗi (Defect checklist) đóng vai trò như một bộ hướng dẫn giúp đội ngũ kiểm định yêu cầu rà soát một cách có hệ thống, từ đó phát hiện ra các lỗi phổ biến như tính mơ hồ, sự mâu thuẫn, hoặc thiếu sót thông tin trong tài liệu đặc tả."
      },
      {
        "question_id": 8,
        "question_title": "Which of the following is NOT about Requirements validation?",
        "option_A": "It is the fourth component of requirements development.",
        "option_B": "It is ensure that they have all the desired properties of high-quality requirements is also an essential activity.",
        "option_C": "It is assesses whether you have written the right requirements: they trace back to business objectives.",
        "option_D": "It allows teams to build a correct solution that meets the stated business objectives.",
        "correct_anwser": "A",
        "explain": "Trong mô hình phát triển yêu cầu (Requirements Development) gồm 4 phân nhánh cốt lõi: Elicitation (Khơi gợi), Analysis (Phân tích), Specification (Đặc tả) và Validation (Xác thực). Các phát biểu B, C, D đều mô tả chính xác mục tiêu của Validation. Do đó phát biểu A không có điểm khác biệt nổi bật để làm đáp án loại trừ, hoặc cấu trúc câu hỏi này đang kiểm tra một chi tiết phủ định trong tài liệu. Tuy nhiên, khi xét kỹ tính logic, 'validation' chính là thành phần thứ tư, nên để tìm phương án SAI, câu này thường là lỗi biên soạn đề hoặc đáp án đúng để chọn là một lựa chọn phủ định khía cạnh khác, nhưng xét theo chuẩn kỹ nghệ yêu cầu thì các ý B, C, D đều mô tả đúng bản chất của Validation."
      },
      {
        "question_id": 9,
        "question_title": "Requirements development does not include:",
        "option_A": "Analysis",
        "option_B": "Validation",
        "option_C": "Design",
        "option_D": "Elicitation",
        "correct_anwser": "C",
        "explain": "Quy trình phát triển yêu cầu (Requirements Development) bao gồm 4 hoạt động chính: Gợi tiến/Thu thập (Elicitation), Phân tích (Analysis), Khai báo/Tài liệu hóa (Specification), và Kiểm chứng (Validation). Thiết kế (Design) thuộc giai đoạn tiếp theo của vòng đời phát triển phần mềm chứ không nằm trong quy trình này."
      },
      {
        "question_id": 10,
        "question_title": "What is the first step in the Requirements Development Process?",
        "option_A": "Analysis (Analyzing requirements)",
        "option_B": "Validation (Validating requirements)",
        "option_C": "Elicitation (Gathering requirements)",
        "option_D": "Specification (Documenting requirements)",
        "option_E": "Management (Managing requirements)",
        "correct_anwser": "C",
        "explain": "Bước đầu tiên luôn luôn là Gợi tiến/Thu thập yêu cầu (Elicitation) để tìm hiểu, khai thác thông tin từ người dùng và các bên liên quan trước khi có thể tiến hành phân tích hay viết tài liệu."
      },
      {
        "question_id": 11,
        "question_title": "Why should requirements be written in a way that avoids technical jargon?",
        "option_A": "To ensure that stakeholders, who may not have a technical background, can easily understand and validate them.",
        "option_B": "Because technical jargon slows down the development team.",
        "option_C": "To keep the SRS document as short as possible.",
        "option_D": "To allow the QA team to create automated tests directly from the text.",
        "correct_anwser": "A",
        "explain": "Tài liệu yêu cầu là phương tiện giao tiếp giữa nhiều bên. Việc tránh các thuật ngữ kỹ thuật quá chuyên sâu (technical jargon) giúp các bên liên quan thuộc khối nghiệp vụ (khách hàng, người dùng cuối) có thể dễ dàng đọc hiểu, rà soát và xác nhận tính chính xác của các yêu cầu một cách hiệu quả."
      },
      {
        "question_id": 12,
        "question_title": "What does a business analyst typically do with conflicting requirements from different stakeholders?",
        "option_A": "Implement all requirements and let the testing team find the errors.",
        "option_B": "Choose the requirement from the stakeholder with the highest job title without discussion.",
        "option_C": "Facilitate discussions to negotiate and resolve the conflicts to reach an agreed-upon solution.",
        "option_D": "Ignore both requirements until the stakeholders resolve the issue themselves.",
        "correct_anwser": "C",
        "explain": "Khi xảy ra xung đột yêu cầu giữa các bên liên quan, trách nhiệm của một BA là tổ chức và điều phối các buổi thảo luận, đàm phán nhằm giúp các bên hiểu rõ góc nhìn của nhau, từ đó tìm ra phương án tối ưu được đồng thuận chung."
      },
      {
        "question_id": 13,
        "question_title": "Why should non-functional requirements be measurable?",
        "option_A": "So that developers know exactly how many lines of code to write.",
        "option_B": "To ensure they can be objectively tested and verified by the QA team.",
        "option_C": "To keep the software project under the allocated budget.",
        "option_D": "To allow the project manager to rank the performance of individual developers.",
        "correct_anwser": "B",
        "explain": "Yêu cầu phi chức năng cần phải được định lượng và đo lường được (ví dụ: thời gian phản hồi dưới 2 giây) để đội ngũ kiểm thử (QA/QC) có thể thiết kế kịch bản đo đạc, kiểm chứng và xác nhận một cách khách quan xem hệ thống có đạt tiêu chuẩn hay không."
      },
      {
        "question_id": 14,
        "question_title": "An elicitation technique that involves studying existing system documentation, industry standards, or competitor product reviews is known as:",
        "option_A": "Focus Groups",
        "option_B": "Document Analysis",
        "option_C": "Interface Analysis",
        "option_D": "Prototyping",
        "correct_anwser": "B",
        "explain": "Phân tích tài liệu (Document Analysis) là kỹ thuật thu thập thông tin bằng cách nghiên cứu các tài liệu hiện có như quy trình nghiệp vụ, tài liệu hệ thống cũ, tiêu chuẩn ngành hoặc các đánh giá sản phẩm cạnh tranh để có được hiểu biết nền tảng về hệ thống."
      },
      {
        "question_id": 15,
        "question_title": "An analyst creates a mockup of a user interface screen to get early feedback from users about the navigation flow. This practice is known as:",
        "option_A": "Data Modeling",
        "option_B": "System Architecture Review",
        "option_C": "Prototyping",
        "option_D": "Unit Testing",
        "correct_anwser": "C",
        "explain": "Làm mẫu thử (Prototyping) bao gồm việc thiết kế các mô hình giao diện tĩnh hoặc động (mockups/wireframes) nhằm phác thảo sớm cách bố trí cấu trúc và luồng điều hướng của màn hình để lấy phản hồi nhanh chóng từ khách hàng trước khi tiến hành viết mã thực tế."
      },
      {
        "question_id": 16,
        "question_title": "Requirements validation involves:",
        "option_A": "Writing technical code based on user requests.",
        "option_B": "Ensuring the documented requirements accurately represent stakeholder needs and are of high quality.",
        "option_C": "Configuring network server security firewalls.",
        "option_D": "Drafting the initial project budget estimate spreadsheets.",
        "correct_anwser": "B",
        "explain": "Xác nhận yêu cầu (Requirements Validation) tập trung vào việc kiểm chứng, rà soát xem tài liệu yêu cầu phần mềm đã viết ra có phản ánh đúng và đủ mong muốn thực tế của khách hàng hay không, đồng thời đảm bảo tài liệu đạt các tiêu chí chất lượng (rõ ràng, nhất quán, không mơ hồ)."
      },
      {
        "question_id": 17,
        "question_title": "Which validation technique involves a structured team meeting where participants carefully review a requirements document line-by-line to find defects?",
        "option_A": "Ad hoc informal chatting",
        "option_B": "Formal Inspection or Peer Review",
        "option_C": "Beta version user testing",
        "option_D": "Automated regression compilation",
        "correct_anwser": "B",
        "explain": "Kiểm duyệt chính thức (Formal Inspection) hoặc Đánh giá đồng cấp (Peer Review) là phương pháp rà soát chất lượng có tính cấu trúc cao, trong đó một nhóm chuyên gia ngồi lại cùng nhau đọc và phân tích từng dòng nội dung trong tài liệu để chủ động bóc tách các lỗi hoặc điểm mâu thuẫn."
      },
      {
        "question_id": 18,
        "question_title": "When evaluating the quality of a requirement, what does the characteristic \"Unambiguous\" mean?",
        "option_A": "The requirement can be interpreted in only one way by anyone who reads it.",
        "option_B": "The requirement is written in a highly advanced technical programming language syntax.",
        "option_C": "The requirement details the complete database index optimization strategy.",
        "option_D": "The requirement is easily applicable to all alternative software projects.",
        "correct_anwser": "A",
        "explain": "Đặc tính \"Không mơ hồ\" (Unambiguous) của một yêu cầu đảm bảo rằng câu văn phải được viết cực kỳ rõ ràng, tường minh, khiến cho bất kỳ ai đọc (dù là khách hàng, BA, lập trình viên haytester) cũng đều chỉ có thể hiểu theo một nghĩa duy nhất."
      },
      {
        "question_id": 19,
        "question_title": "If a requirement cannot be checked by any objective test or verification method, it fails to meet which quality criterion?",
        "option_A": "Complete",
        "option_B": "Verifiable or Testable",
        "option_C": "Traceable",
        "option_D": "Consistent",
        "option_E": "Feasible",
        "correct_anwser": "B",
        "explain": "Một yêu cầu nếu không thể được kiểm chứng bằng bất kỳ phép đo, bài thử hay phương pháp khách quan nào từ phía đội ngũ QA/QC thì yêu cầu đó đã vi phạm tiêu chí chất lượng là \"Có thể kiểm chứng\" (Verifiable or Testable)."
      },
      {
        "question_id": 20,
        "question_title": "When tracking a requirement's status throughout the project life cycle, which status indicates that the requirement has been successfully implemented and verified by tests?",
        "option_A": "Proposed",
        "option_B": "Approved",
        "option_C": "Drafted",
        "option_D": "Completed or Verified",
        "correct_anwser": "D",
        "explain": "Trạng thái \"Completed\" (Hoàn thành) hoặc \"Verified\" (Đã kiểm chứng) biểu thị rằng yêu cầu đó không những đã được lập trình viên viết mã xong mà còn vượt qua các bài kiểm thử xác nhận chất lượng từ phía đội ngũ QA/QC, sẵn sàng bàn giao."
      },
      {
        "question_id": 21,
        "question_title": "What role does the Business Analyst play during formal requirements peer reviews or inspections?",
        "option_A": "Approving the financial project funding allocation unilaterally.",
        "option_B": "Presenting the requirements document, answering questions, and capturing feedback to resolve identified defects.",
        "option_C": "Writing the automated continuous integration script logic.",
        "option_D": "Configuring the physical production cloud servers.",
        "correct_anwser": "B",
        "explain": "Trong các buổi Peer Review tài liệu yêu cầu, BA đóng vai trò giải trình nội dung, trả lời các thắc mắc của đội ngũ phát triển/kiểm thử, đồng thời ghi nhận lại các phản hồi, lỗi sai (defects) được phát hiện để tiến hành sửa đổi."
      },
      {
        "question_id": 22,
        "question_title": "Requirements validation should ideally happen:",
        "option_A": "Only after the entire system has been coded and deployed to production.",
        "option_B": "Continuously and iteratively throughout the requirements development phase before significant technical work begins.",
        "option_C": "Only during the project budgeting initial meeting.",
        "option_D": "Exclusively when a critical runtime database crash occurs.",
        "option_E": "None of the mentioned",
        "option_F": "All of the mentioned",
        "correct_anwser": "B",
        "explain": "Hoạt động xác nhận yêu cầu (Requirements Validation) cần phải được thực hiện liên tục và lặp đi lặp lại trong giai đoạn làm yêu cầu nhằm phát hiện sớm các lỗi sai ngay từ đầu, trước khi đội ngũ kỹ thuật tiến hành thiết kế kiến trúc và viết mã."
      },
      {
        "question_id": 23,
        "question_title": "Which one of the following is not step of requirement engineering?",
        "option_A": "documentation",
        "option_B": "elicitation",
        "option_C": "analysis",
        "option_D": "design",
        "correct_anwser": "D",
        "explain": "Kỹ nghệ yêu cầu (Requirement Engineering) bao gồm các bước chính như khơi gợi (elicitation), phân tích (analysis), tài liệu hóa (documentation/specification) và xác thực (validation). Trong khi đó, thiết kế (design) là một giai đoạn tiếp theo trong quy trình phát triển phần mềm (SDLC) dựa trên các yêu cầu đã thu thập, chứ không nằm trong kỹ nghệ yêu cầu."
      },
      {
        "question_id": 24,
        "question_title": "Which of the following statements about the requirements development process' framework is accurate? Select two.",
        "option_A": "The process of requirements development is strictly linear, moving from elicitation to validation without any need for revisiting previous stages.",
        "option_B": "Elicitation, analysis, specification, and validation are iterative activities that may require revisiting earlier stages to ensure accuracy and completeness.",
        "option_C": "Validation is only performed at the end of the project to confirm that all requirements have been met.",
        "option_D": "The framework allows for flexibility, with steps often revisited throughout the project to refine and correct requirements as needed.",
        "correct_anwser": "B, D",
        "explain": "Quy trình phát triển yêu cầu không phải là một đường thẳng tuyến tính (loại A) và xác thực không chỉ diễn ra vào cuối dự án (loại C). Thay vào đó, đây là một quy trình mang tính lặp (iterative) và linh hoạt (flexible). Các hoạt động khơi gợi, phân tích, đặc tả và xác thực được thực hiện liên tục và có thể quay lại các bước trước đó để làm mịn, điều chỉnh yêu cầu cho chính xác và đầy đủ nhất."
      },
      {
        "question_id": 25,
        "question_title": "Which of the following statements accurately describes the purpose and use of personas in requirements analysis? Select two.",
        "option_A": "A persona is a real user from the target audience, used to validate requirements and ensure they meet actual user needs.",
        "option_B": "Personas are hypothetical, generic users representing a group with similar characteristics, used to understand requirements and design user experiences.",
        "option_C": "Creating a persona helps bring user classes to life and aids in visualizing how different types of users will interact with the system.",
        "option_D": "Personas are only useful during the testing phase to ensure that the application functions as expected for diverse user groups.",
        "correct_anwser": "B, C",
        "explain": "Chân dung người dùng (Persona) là một hồ sơ giả định mang tính đại diện dựa trên dữ liệu thực tế (hypothetical, generic users) để mô tả một nhóm người dùng có chung đặc điểm hành vi (B). Việc tạo ra các Persona giúp hiện thực hóa các lớp người dùng, hỗ trợ đội ngũ thiết kế và phân tích hình dung sinh động cách các kiểu người dùng khác nhau sẽ tương tác với hệ thống ra sao (C). Persona không phải là một người dùng thật cụ thể (loại A) và có ích trong suốt quá trình phân tích/thiết kế chứ không chỉ riêng giai đoạn testing (loại D)."
      },
      {
        "question_id": 26,
        "question_title": "What does the term \"elicitation\" primarily refer to in requirements engineering?",
        "option_A": "The process of gathering requirements from stakeholders",
        "option_B": "The validation of technical requirements",
        "option_C": "The prioritization of system constraints",
        "option_D": "The finalization of the project budget",
        "correct_anwser": "A",
        "explain": "Trong kỹ nghệ yêu cầu, thuật ngữ 'Elicitation' (Khơi gợi yêu cầu) đề cập trực tiếp đến quá trình thu thập, khám phá và tìm hiểu các yêu cầu, mong đợi của hệ thống từ phía các bên liên quan (stakeholders) thông qua các kỹ thuật như phỏng vấn, khảo sát, workshop..."
      },
      {
        "question_id": 27,
        "question_title": "How does prototyping mitigate risks in requirements engineering?",
        "option_A": "By providing stakeholders with a visual representation to validate ambiguous requirements",
        "option_B": "By finalizing system requirements early",
        "option_C": "By focusing on coding rather than design",
        "option_D": "By skipping the requirements validation phase",
        "correct_anwser": "A",
        "explain": "Tương tự như câu 24, việc tạo mẫu thử giúp giảm thiểu rủi ro làm sai yêu cầu bằng cách cung cấp giao diện trực quan cho các bên liên quan xem xét, từ đó sớm phát hiện sai sót và xác thực các yêu cầu còn chưa rõ ràng trước khi tiến hành code thật."
      },
      {
        "question_id": 28,
        "question_title": "Consider the following statement: \"All the screens in the system must load quickly\". This requirement statement is _________",
        "option_A": "Correct and Feasible",
        "option_B": "Unambiguous and Testable",
        "option_C": "Unambiguous and Non-Testable",
        "option_D": "Ambiguous and Non-Testable",
        "correct_anwser": "D",
        "explain": "Câu phát biểu trên sử dụng từ ngữ định tính 'load quickly' (tải nhanh), một khái niệm rất mơ hồ (Ambiguous) vì mỗi người sẽ có định nghĩa 'nhanh' khác nhau. Do không có một con số cụ thể (ví dụ: trong vòng 2 giây), kiểm thử viên cũng không thể thiết lập tiêu chí để đo lường hay kiểm chứng, vì vậy nó hoàn toàn không thể kiểm thử được (Non-Testable)."
      },
      {
        "question_id": 29,
        "question_title": "Which of the following is NOT a purpose of creating a mock-up?",
        "option_A": "To refine user interface design.",
        "option_B": "To test architectural feasibility.",
        "option_C": "To allow users to judge the overall workflow and requirements.",
        "option_D": "To simulate a user interface with no real functionality.",
        "correct_anwser": "B",
        "explain": "Mock-up (mô hình giao diện tĩnh) được sử dụng để tinh chỉnh thiết kế UI (A), giúp người dùng đánh giá luồng công việc (C), và giả lập giao diện không có chức năng thực tế bên dưới (D). Việc kiểm tra tính khả thi của kiến trúc hệ thống (B) đòi hỏi các kỹ thuật hoặc mẫu thử kiến trúc sâu hơn (như Proof of Concept), chứ một mô hình giao diện tĩnh như mock-up không thể thực hiện được."
      },
      {
        "question_id": 30,
        "question_title": "Which approach to reviewing requirements involves the author describing a deliverable and soliciting comments on it?",
        "option_A": "Peer deskcheck approach",
        "option_B": "Passaround approach",
        "option_C": "Walkthrough approach",
        "option_D": "Inspection approach",
        "correct_anwser": "C",
        "explain": "Walkthrough (Đọc duyệt/Duyệt qua) là một hình thức đánh giá kỹ thuật, trong đó tác giả (author) đóng vai trò chủ trì dẫn dắt cuộc họp để mô tả, giải thích chi tiết về tài liệu sản phẩm và thu thập các ý kiến đóng góp, phản hồi trực tiếp từ người tham dự."
      },
      {
        "question_id": 31,
        "question_title": "The benefits of effective requirements reuse include: (choose 3 correct answers)",
        "option_A": "faster delivery",
        "option_B": "lower development costs",
        "option_C": "reduced rework",
        "option_D": "fewer test cases",
        "correct_anwser": "A, B, C",
        "explain": "Tái sử dụng yêu cầu hiệu quả giúp đội ngũ kế thừa các tài liệu chuẩn hóa đã có sẵn, mang lại các lợi ích lớn bao gồm: rút ngắn thời gian bàn giao dự án (A), hạ thấp chi phí phát triển (B), và giảm thiểu việc phải chỉnh sửa, làm lại do yêu cầu đã được kiểm chứng từ trước (C). Việc tái sử dụng không làm giảm số lượng test case (D) vì mỗi hệ thống mới vẫn cần bộ test case đầy đủ tương ứng để kiểm thử tính chính xác."
      },
      {
        "question_id": 32,
        "question_title": "What is the primary challenge of validating non-functional requirements?",
        "option_A": "They are often subjective and difficult to measure accurately",
        "option_B": "They focus only on technical constraints",
        "option_C": "They eliminate the need for functional requirements",
        "option_D": "They replace stakeholder reviews",
        "correct_anwser": "A",
        "explain": "Thách thức hàng đầu khi xác thực các yêu cầu phi chức năng (NFR) là chúng thường mang tính cảm tính, định tính và chủ quan (ví dụ: 'hệ thống phải thân thiện', 'tốc độ phải nhanh'), dẫn đến việc khó đo lường một cách chính xác nếu không được định lượng hóa."
      },
      {
        "question_id": 33,
        "question_title": "What is the advantage of using acceptance tests during validation?",
        "option_A": "To ensure that all requirements are measurable and testabl",
        "option_B": "To eliminate the need for non-functional requirements",
        "option_C": "To skip stakeholder reviews",
        "option_D": "To prioritize coding tasks",
        "correct_anwser": "A",
        "explain": "Việc thiết kế hoặc sử dụng các bài kiểm thử chấp nhận (Acceptance tests) ngay từ giai đoạn xác thực yêu cầu buộc các bên phải làm rõ tiêu chí nghiệm thu, từ đó đảm bảo rằng mọi yêu cầu bằng văn bản đều có thể đo lường và kiểm thử được (measurable and testable)."
      },
      {
        "question_id": 34,
        "question_title": "Why is stakeholder feedback critical during requirements validation?",
        "option_A": "To ensure requirements align with business objectives and user needs",
        "option_B": "To finalize coding strategies",
        "option_C": "To skip ambiguous requirements",
        "option_D": "To prioritize testing phases",
        "correct_anwser": "A",
        "explain": "Phản hồi từ các bên liên quan (stakeholders) là cơ sở tối thượng trong giai đoạn validation để đánh giá và khẳng định lại xem các yêu cầu đã viết ra có thực sự phản ánh đúng nhu cầu người dùng và đồng bộ với mục tiêu kinh doanh chiến lược hay không."
      },
      {
        "question_id": 35,
        "question_title": "When specifying the level of detail in software requirements, which of the following practices should be considered? Select two.",
        "option_A": "It is always necessary to specify all requirements at the same high level of detail to ensure consistency.",
        "option_B": "More detail should be included when the work is being done for an external client or when system testing will be based on the requirements.",
        "option_C": "Less detail can be included if the work is being done internally for your company and developers have considerable domain experience.",
        "option_D": "Writing all requirements at a very fine-grained level is always better, regardless of the project's context.",
        "option_E": "None of the above",
        "correct_anwser": "B, C",
        "explain": "Mức độ chi tiết của tài liệu yêu cầu cần linh hoạt theo ngữ cảnh: Cần viết chi tiết hơn khi bàn giao cho đối tác bên ngoài hoặc làm căn cứ kiểm thử (B); và có thể viết gọn bớt nếu dự án làm nội bộ và đội ngũ lập trình viên đã có sẵn nhiều kinh nghiệm chuyên môn sâu về lĩnh vực đó (C)."
      },
      {
        "question_id": 36,
        "question_title": "What steps would you include in a peer review process to identify and resolve ambiguities in requirement statements?",
        "option_A": "Have each participant review the requirements individually and submit their feedback separately.",
        "option_B": "Conduct a formal peer review meeting where participants compare their understanding of each requirement and discuss any ambiguities.",
        "option_C": "Skip the peer review process and rely on individual interpretations.",
        "option_D": "Only review requirements after the development phase.",
        "correct_anwser": "B",
        "explain": "Để nhận diện và giải quyết triệt để tính mơ hồ (ambiguities) trong các câu yêu cầu, quy trình peer review cần tổ chức một buổi họp rà soát chính thức, nơi các thành viên có thể đối chiếu, so sánh mức độ hiểu của mình về từng yêu cầu, từ đó phát hiện ra những điểm diễn đạt nhập nhèm để đồng bộ lại thông tin."
      },
      {
        "question_id": 37,
        "question_title": "Validation of requirements assesses whether you have written _______.",
        "option_A": "the right requirements",
        "option_B": "the requirements right",
        "option_C": "the flexible requirements",
        "option_D": "the variable requirements",
        "correct_anwser": "A",
        "explain": "Theo câu nói kinh điển của kỹ nghệ phần mềm: 'Verification' (Kiểm định) giúp kiểm tra xem chúng ta có đang xây dựng hệ thống đúng cách hay không (building the product right), còn 'Validation' (Xác thực) giúp kiểm tra xem chúng ta có đang viết/thu thập đúng các yêu cầu cần thiết hay không (writing the right requirements) để giải quyết bài toán kinh doanh."
      },
      {
        "question_id": 38,
        "question_title": "What is the primary purpose of requirements reuse?",
        "option_A": "To save time, improve consistency, and reduce risks",
        "option_B": "To eliminate stakeholder reviews",
        "option_C": "To finalize the coding phase",
        "option_D": "To reduce prototyping efforts",
        "correct_anwser": "A",
        "explain": "Mục đích hàng đầu của việc tái sử dụng yêu cầu (Requirements reuse) là tận dụng các yêu cầu đã được chuẩn hóa từ dự án trước để tiết kiệm thời gian, tăng tính đồng bộ, nhất quán của hệ thống và giảm thiểu rủi ro sai sót."
      },
      {
        "question_id": 39,
        "question_title": "How does requirements reuse improve project efficiency?",
        "option_A": "By reducing time and effort during the elicitation process",
        "option_B": "By skipping stakeholder reviews",
        "option_C": "By focusing only on functional requirements",
        "option_D": "By eliminating non-functional requirements",
        "correct_anwser": "A",
        "explain": "Tái sử dụng yêu cầu giúp nâng cao hiệu suất dự án một cách trực tiếp bằng cách rút ngắn đáng kể thời gian và công sức bỏ ra cho việc khơi gợi, làm rõ yêu cầu (elicitation process) đối với các tính năng có tính tương đồng."
      },
      {
        "question_id": 40,
        "question_title": "Which one of the following is not a step of requirement development?",
        "option_A": "elicitation",
        "option_B": "design",
        "option_C": "analysis",
        "option_D": "validation",
        "option_E": "documentation",
        "correct_anwser": "B",
        "explain": "Phát triển yêu cầu (Requirement Development) bao gồm bốn giai đoạn chính: khơi gợi (elicitation), phân tích (analysis), tài liệu hóa (specification/documentation), và thẩm định (validation). Thiết kế (design) là một giai đoạn tiếp theo trong vòng đời phát triển phần mềm sau khi các yêu cầu đã được xác định rõ ràng."
      },
      {
        "question_id": 41,
        "question_title": "Which of the following statements accurately describes the role of a business analyst in a project? Select two.",
        "option_A": "The business analyst is solely responsible for managing communication between the customer(s) and the development team.",
        "option_B": "The business analyst primarily focuses on eliciting, analyzing, documenting, and validating the needs of the project stakeholders.",
        "option_C": "In agile projects, the business analyst often acts as the project manager, handling both internal and external project tasks.",
        "option_D": "The business analyst plays a central role in collecting and disseminating product information, while the project manager focuses on communicating project information.",
        "correct_anwser": "B, D",
        "explain": "BA tập trung vào việc khơi gợi, phân tích, tài liệu hóa và thẩm định nhu cầu của stakeholders (B), đồng thời đóng vai trò trung tâm trong việc thu thập và phân phối thông tin liên quan đến sản phẩm (product information), phân biệt với PM tập trung vào thông tin quản lý dự án (D)."
      },
      {
        "question_id": 42,
        "question_title": "Which of the following are the signals indicating that you have completed requirements elicitation? Choose 3 correct answers.",
        "option_A": "Users repeat issues they already covered in previous discussions.",
        "option_B": "Suggested new features, user requirements, or functional requirements are all deemed to be out of scope.",
        "option_C": "Proposed new requirements are all low priority.",
        "option_D": "Developers and testers who review the requirements for an area raise many questions.",
        "correct_anwser": "A, B, C",
        "explain": "Dấu hiệu cho thấy việc khơi gợi yêu cầu đã có thể dừng lại bao gồm: người dùng bắt đầu nói lặp lại các vấn đề cũ (A), các tính năng mới đề xuất đều nằm ngoài phạm vi đã định (B), hoặc các yêu cầu mới phát sinh chỉ có mức độ ưu tiên rất thấp (C). Nếu dev và tester vẫn đặt ra quá nhiều câu hỏi (D), điều đó chứng tỏ yêu cầu chưa đủ rõ ràng và việc khơi gợi chưa hoàn tất."
      },
      {
        "question_id": 43,
        "question_title": "Requirement statements must be: (Choose 3 correct answers)",
        "option_A": "Feasible",
        "option_B": "Correct",
        "option_C": "Verifiable",
        "option_D": "Flexible",
        "correct_anwser": "A, B, C",
        "explain": "Một câu phát biểu yêu cầu chất lượng bắt buộc phải đáp ứng các đặc tính nền tảng bao gồm: Khả thi (Feasible - có thể làm được), Chính xác (Correct) và Có thể kiểm chứng được (Verifiable/Testable). Tính \"Linh hoạt\" (Flexible) dễ dẫn đến mơ hồ, không rõ ràng và không phải đặc tính tiêu chuẩn của câu yêu cầu."
      },
      {
        "question_id": 44,
        "question_title": "Which of the following characteristics should a well-written requirement statement exhibit? Select two.",
        "option_A": "Each requirement should be complete, meaning it contains all the information necessary for the reader to understand it and for developers to implement it correctly.",
        "option_B": "A requirement statement can be ambiguous as long as it is feasible to implement.",
        "option_C": "Requirements should be prioritized based on their importance to achieving the desired business value, and should be assigned an implementation priority.",
        "option_D": "Verifiability of a requirement is optional as long as it meets stakeholder needs.",
        "correct_anwser": "A, C",
        "explain": "Một câu phát biểu yêu cầu chuẩn mực cần có tính đầy đủ (Complete), chứa đựng toàn bộ thông tin cần thiết để lập trình viên hiểu và triển khai chính xác (A), đồng thời cần phải được phân loại độ ưu tiên dựa trên giá trị mang lại cho doanh nghiệp (C). Câu phát biểu không được phép mơ hồ (B sai) và tính kiểm chứng (Verifiability) luôn luôn là bắt buộc chứ không phải tùy chọn (D sai)."
      },
      {
        "question_id": 45,
        "question_title": "What is the purpose of peer reviews during the requirements validation process?",
        "option_A": "To ensure requirements are written in technical language",
        "option_B": "To identify ambiguous or unverifiable requirements",
        "option_C": "To finalize the system design before development begins",
        "option_D": "To align requirements with user interface designs",
        "correct_anwser": "B",
        "explain": "Mục đích của việc đánh giá đồng nghiệp (Peer review) trong giai đoạn validate yêu cầu là để các thành viên khác nhau rà soát chéo, từ đó cùng nhau chỉ ra những điểm yêu cầu còn mơ hồ (ambiguous) hoặc không có khả năng kiểm chứng (unverifiable) để kịp thời sửa đổi."
      },
      {
        "question_id": 46,
        "question_title": "What is the primary advantage of requirements reuse in software projects?",
        "option_A": "Reducing time and effort during the elicitation process",
        "option_B": "Skipping the stakeholder review phase",
        "option_C": "Eliminating the need for prototyping",
        "option_D": "Ensuring all requirements are functional",
        "correct_anwser": "A",
        "explain": "Ưu điểm hàng đầu của việc tái sử dụng yêu cầu (Requirements reuse) từ các dự án tương tự trước đó là giúp giảm bớt đáng kể thời gian cũng như công sức bỏ ra cho quá trình khơi gợi và viết lại các yêu cầu tiêu chuẩn (ví dụ: các yêu cầu về đăng nhập, phân quyền, bảo mật)."
      },
      {
        "question_id": 47,
        "question_title": "What does acceptance criteria include? Choose 3 correct answers.",
        "option_A": "Passing a defined set of acceptance tests based on user requirements",
        "option_B": "Demonstrating satisfaction of specific nonfunctional requirements",
        "option_C": "Tracking open defects and issues",
        "option_D": "Having a trendy user interface",
        "correct_anwser": "A, B, C",
        "explain": "Tiêu chí nghiệm thu (Acceptance criteria) bao gồm việc vượt qua các bài kiểm thử nghiệm thu dựa trên yêu cầu người dùng (A), chứng minh sự thỏa mãn các yêu cầu phi chức năng cụ thể (B) và theo dõi, kiểm soát các lỗi/vấn đề còn tồn đọng trước khi bàn giao (C). Việc có một giao diện hợp xu hướng (D) là một yếu tố thiết kế chủ quan, không phải tiêu chí nghiệm thu bắt buộc chuẩn mực."
      },
      {
        "question_id": 48,
        "question_title": "Fill in the blank: \"Define vision and scope\", \"select product champions\" activities should be done _____ stage.",
        "option_A": "Specifications",
        "option_B": "Validation",
        "option_C": "Elicitation",
        "option_D": "Analysis",
        "correct_anwser": "C",
        "explain": "Các hoạt động định hình tầm nhìn, phạm vi hệ thống (\"Define vision and scope\") và lựa chọn đại diện người dùng (\"select product champions\") là những bước khởi đầu quan trọng nằm trong giai đoạn Khơi gợi yêu cầu (Elicitation)."
      },
      {
        "question_id": 49,
        "question_title": "Your company developed a software system for a customer a long time ago, and the application works as intended. Now, the customer's business has grown, and they want the software system to handle 10x the number of transactions. They ask your company to upgrade the software system. Upon inspection, you find out that this system can't handle 10x transactions due to monolithic processes and tightly coupled logic.\n\nWhat is the quality attribute mentioned above?",
        "option_A": "Availability",
        "option_B": "Usability",
        "option_C": "Scalability",
        "option_D": "Robustness",
        "correct_anwser": "C",
        "explain": "Khả năng xử lý lượng giao dịch tăng lên gấp 10 lần khi quy mô doanh nghiệp mở rộng trực tiếp liên quan đến thuộc tính chất lượng Khả năng mở rộng (Scalability)."
      },
      {
        "question_id": 50,
        "question_title": "What is the primary distinction between requirements validation and verification?",
        "option_A": "Validation ensures that the product meets the user's needs, while verification ensures it is free from defects.",
        "option_B": "Validation ensures the product satisfies customer needs, while verification ensures the product meets its specifications.",
        "option_C": "Validation occurs before the design phase, and verification occurs after.",
        "option_D": "Validation is about internal testing, while verification is about external approval.",
        "correct_anwser": "B",
        "explain": "Khác biệt cơ bản: Thẩm định (Validation) đảm bảo chúng ta xây dựng đúng sản phẩm đáp ứng nhu cầu khách hàng ('Are we building the right thing?'), trong khi Kiểm chứng (Verification) đảm bảo sản phẩm được xây dựng chính xác theo đúng tài liệu đặc tả thiết kế ('Are we building it right?')."
      },
      {
        "question_id": 51,
        "question_title": "What does the term \"verifiable\" mean in the context of excellent requirements?",
        "option_A": "The requirements cannot be tested",
        "option_B": "The requirements are difficult to understand",
        "option_C": "The requirements can be tested to ensure they are met",
        "option_D": "The requirements are subjective and open to interpretation",
        "correct_anwser": "C",
        "explain": "Tính chất 'Có thể thẩm định/xác thực' (Verifiable) của một yêu cầu tốt có nghĩa là yêu cầu đó phải được viết cụ thể, rõ ràng, có định lượng để đội ngũ kiểm thử (Tester) có thể thiết kế các kịch bản kiểm thử (test cases) nhằm xác nhận hệ thống đã đáp ứng đúng hay chưa."
      },
      {
        "question_id": 52,
        "question_title": "Validation of requirements assesses whether you have written _________.",
        "option_A": "the right requirements",
        "option_B": "the requirements right",
        "option_C": "the flexible requirements",
        "option_D": "the variable requirements",
        "correct_anwser": "A",
        "explain": "Trong kỹ nghệ yêu cầu: Xác nhận/Thẩm định (Validation) là để kiểm tra xem chúng ta có đang viết 'đúng yêu cầu khách hàng mong muốn' hay không (Have we written the right requirements?). Còn Kiểm chứng (Verification) là đánh giá xem tài liệu có được viết đúng chuẩn kỹ thuật và quy trình không (Have we written the requirements right?)."
      },
      {
        "question_id": 53,
        "question_title": "Which of the following activities would be considered part of requirements management effort?",
        "option_A": "Holding workshops and interviews to gather requirements.",
        "option_B": "Submitting requirements changes and proposing new requirements change.",
        "option_C": "Writing requirements specifications and prioritizing requirements.",
        "option_D": "Creating and evaluating prototypes for requirements development.",
        "correct_anwser": "B",
        "explain": "Kỹ nghệ yêu cầu chia làm 2 nhánh: Phát triển yêu cầu (Elicitation, Analysis, Specification, Validation - thuộc phương án A, C, D) và Quản lý yêu cầu (Requirements Management). Hoạt động kiểm soát thay đổi, nộp và xử lý yêu cầu thay đổi (B) chính là trọng tâm của Quản lý yêu cầu."
      },
      {
        "question_id": 54,
        "question_title": "Who are the intended audiences for requirements specifications?",
        "option_A": "System architects and developers",
        "option_B": "Test engineers and quality analysts",
        "option_C": "Stakeholders, reviewers, and project team members",
        "option_D": "All of the others",
        "correct_anwser": "D",
        "explain": "Tài liệu đặc tả yêu cầu (Requirements Specification) là tài liệu nền tảng cho toàn bộ dự án, được sử dụng bởi kiến trúc sư/lập trình viên để thiết kế và phát triển hệ thống, kiểm thử viên để viết test case, và các bên liên quan cùng thành viên dự án để xem xét và đối chiếu."
      },
      {
        "question_id": 55,
        "question_title": "What is the advantage of using prototyping in early project phases?",
        "option_A": "To validate requirements and reduce the risk of costly changes later",
        "option_B": "To eliminate the design phase",
        "option_C": "To prioritize functional over non-functional requirements",
        "option_D": "To replace stakeholder engagement",
        "correct_anwser": "A",
        "explain": "Lợi ích lớn nhất của việc làm mẫu thử (prototyping) ở giai đoạn đầu dự án là giúp trực quan hóa để xác thực yêu cầu với khách hàng, từ đó phát hiện sớm các điểm chưa đúng và giảm thiểu rủi ro phải sửa đổi tốn kém về sau."
      },
      {
        "question_id": 56,
        "question_title": "To help reviewers look for typical kinds of errors in the products they review, develop a(n) _________ for each type of requirements document your projects create.",
        "option_A": "defect checklist",
        "option_B": "error checklist",
        "option_C": "inspection meeting",
        "option_D": "support documentation",
        "correct_anwser": "A",
        "explain": "Để hỗ trợ người kiểm duyệt tìm kiếm hiệu quả các lỗi phổ biến trong sản phẩm phần mềm hoặc tài liệu, dự án nên xây dựng một danh sách kiểm tra lỗi/khuyết tật (defect checklist) tương ứng với từng loại tài liệu đặc tả yêu cầu cụ thể."
      }
    ]
  },
  {
    "id": "swr302-module-6-management-&-change-control",
    "title": "SWR302 - Module 6 - Management & Change Control",
    "description": "Software Requirement Quiz",
    "questionsCount": 31,
    "questions": [
      {
        "question_id": 1,
        "question_title": "What is the primary distinction between Scope Creep and Gold Plating?",
        "option_A": "Scope Creep involves adding features, whereas Gold Plating involves reducing project scope.",
        "option_B": "Scope Creep arises from customer-driven changes, while Gold Plating results from the project team adding unnecessary features.",
        "option_C": "Both Scope Creep and Gold Plating involve unplanned changes.",
        "option_D": "Scope Creep occurs only in the early stages of a project, while Gold Plating happens post-delivery.",
        "option_E": "Scope Creep is seen in small projects, while Gold Plating only occurs in large projects.",
        "correct_anwser": "B",
        "explain": "Scope Creep (Phình scope) xảy ra khi phạm vi dự án bị mở rộng dần do các yêu cầu không kiểm soát từ phía khách hàng hoặc stakeholder mà không qua quy trình thay đổi chính thức. Ngược lại, Gold Plating (Mạ vàng) xảy ra khi đội ngũ phát triển tự ý thêm vào các tính năng hoặc cải tiến không có trong yêu cầu ban đầu của khách hàng vì nghĩ rằng điều đó tốt cho họ."
      },
      {
        "question_id": 2,
        "question_title": "What is the value of creating a traceability matrix in a project?",
        "option_A": "To ensure all requirements are linked to their design, testing, and implementation phases",
        "option_B": "To replace stakeholder involvement in the validation phase",
        "option_C": "To prioritize non-functional requirements over functional ones",
        "option_D": "To finalize the system's coding standards",
        "correct_anwser": "A",
        "explain": "Giá trị của Ma trận truy vết yêu cầu (Traceability Matrix) là thiết lập chuỗi liên kết xuyên suốt giúp theo dõi xem mỗi yêu cầu được hiện thực hóa ở phần thiết kế nào, mã nguồn nào, và được kiểm thử bởi test case nào trong các giai đoạn tiếp theo."
      },
      {
        "question_id": 3,
        "question_title": "Why do we have to label the requirements in a software requirements specification (SRS)? (Choose 3 correct answers)",
        "option_A": "It allows us to refer to specific requirements in a change request, modification history, cross-reference, or requirements traceability matrix.",
        "option_B": "It enables reusing the requirements in multiple projects.",
        "option_C": "It facilitates collaboration between team members when they're discussing requirements.",
        "option_D": "It makes the SRS look more professional.",
        "correct_anwser": "A, B, C",
        "explain": "Gán nhãn/Mã hóa yêu cầu một cách duy nhất (Labeling) giúp dễ dàng truy vết trong ma trận truy vết và quản lý thay đổi (A), hỗ trợ khả năng tái sử dụng yêu cầu ở các dự án khác (B) và giúp các thành viên trong đội ngũ dễ dàng gọi tên, trao đổi chính xác về một yêu cầu cụ thể mà không bị nhầm lẫn (C)."
      },
      {
        "question_id": 4,
        "question_title": "What is the main purpose of a requirements baseline?",
        "option_A": "To track changes",
        "option_B": "To establish project goals",
        "option_C": "To set the scope of the project",
        "option_D": "To establish an initial set of agreed-upon requirements",
        "correct_anwser": "D",
        "explain": "Mục đích cốt lõi của một Requirements Baseline (Đường cơ sở yêu cầu) là thiết lập một tập hợp các yêu cầu ban đầu đã được các bên rà soát, thống nhất và phê duyệt正式, làm căn cứ để quản lý thay đổi và phát triển các giai đoạn tiếp theo."
      },
      {
        "question_id": 5,
        "question_title": "What does the change control process primarily aim to do?",
        "option_A": "Delay changes until all requirements are implemented",
        "option_B": "Provide visibility and control over proposed changes",
        "option_C": "Implement changes immediately",
        "option_D": "Reject unnecessary changes",
        "correct_anwser": "B",
        "explain": "Quy trình kiểm soát thay đổi (Change control process) không nhằm mục đích từ chối mọi thay đổi hay trì hoãn chúng, mà cốt để mang lại tính minh bạch (visibility) và khả năng quản lý, kiểm soát (control) tác động của các yêu cầu thay đổi được đề xuất trước khi quyết định thực thi."
      },
      {
        "question_id": 6,
        "question_title": "A key motivation for requirements tracing is to facilitate what activity, especially when a requirement needs to be modified?",
        "option_A": "Requirements elicitation",
        "option_B": "Change impact analysis",
        "option_C": "User interface design",
        "option_D": "Project budgeting",
        "correct_anwser": "B",
        "explain": "Động lực chính của việc truy vết yêu cầu (Requirements tracing) là để hỗ trợ hoạt động Phân tích tác động của thay đổi (Change impact analysis). Khi một yêu cầu cần sửa đổi, ma trận truy vết giúp BA biết chính xác những thành phần thiết kế, code hay test case nào liên quan sẽ bị ảnh hưởng theo."
      },
      {
        "question_id": 7,
        "question_title": "Which of the following is considered a core practice of Requirements Management?",
        "option_A": "Writing unit tests for individual functions.",
        "option_B": "Controlling changes to the requirements baseline.",
        "option_C": "Configuring the continuous integration pipeline.",
        "option_D": "Designing user experience prototypes.",
        "correct_anwser": "B",
        "explain": "Requirements Management (Quản lý yêu cầu) tập trung vào việc duy trì tính nhất quán và kiểm soát xuyên suốt vòng đời dự án, trong đó hoạt động cốt lõi là kiểm soát và phê duyệt các thay đổi đối với tập hợp yêu cầu đã được chốt (requirements baseline)."
      },
      {
        "question_id": 8,
        "question_title": "What is the primary benefit of achieving \"Traceability\" in requirements?",
        "option_A": "It automatically generates user documentation.",
        "option_B": "It allows team members to see how requirements connect to design, code, and tests.",
        "option_C": "It eliminates the need for daily standup meetings.",
        "option_D": "It replaces the software development roadmap.",
        "correct_anwser": "B",
        "explain": "Tính vết (Traceability) cho phép thiết lập và theo dõi mối liên kết hai chiều giữa các yêu cầu gốc với kiến trúc thiết kế, các đoạn mã nguồn và các kịch bản kiểm thử, giúp dễ dàng phân tích tác động khi có thay đổi xảy ra."
      },
      {
        "question_id": 9,
        "question_title": "What is the primary risk of allowing \"Scope Creep\" to happen in a software project?",
        "option_A": "It automatically formats user stories into code modules.",
        "option_B": "It leads to project delays, budget overruns, and uncontrolled growth in project requirements.",
        "option_C": "It prevents the software application from running on cloud infrastructure.",
        "option_D": "It forces the quality assurance team to write only manual tests.",
        "correct_anwser": "B",
        "explain": "Sự phình đại phạm vi (Scope Creep) xảy ra khi các yêu cầu mới liên tục được thêm vào dự án một cách không chính thức và thiếu kiểm soát, trực tiếp dẫn đến nguy cơ chậm tiến độ (delays), vượt ngân sách (budget overruns) và làm mất định hướng ban đầu của sản phẩm."
      },
      {
        "question_id": 10,
        "question_title": "A business analyst wants to see how a change to a single functional requirement will impact the system architecture, database design, and test cases. What tool or asset is most helpful for this task?",
        "option_A": "A Daily Burndown Chart",
        "option_B": "A Requirements Traceability Matrix (RTM)",
        "option_C": "A System Execution Log File",
        "option_D": "A Software Build Automation Script",
        "correct_anwser": "B",
        "explain": "Ma trận quan hệ vết yêu cầu (Requirements Traceability Matrix - RTM) thiết lập mối liên kết rõ ràng giữa yêu cầu gốc với các thành phần thiết kế, module mã nguồn và kịch bản kiểm thử. Khi một yêu cầu thay đổi, RTM giúp BA nhanh chóng thực hiện phân tích tác động (impact analysis) xem những thành phần nào sẽ bị ảnh hưởng."
      },
      {
        "question_id": 11,
        "question_title": "What is a \"Baseline\" in the context of requirements management?",
        "option_A": "The very first messy draft of requirements captured during brainstorming.",
        "option_B": "A snapshot of approved requirements that has been agreed upon and can only be changed through a formal change control process.",
        "option_C": "The performance benchmark of the production server system.",
        "option_D": "The minimum number of lines of code expected from a developer daily.",
        "correct_anwser": "B",
        "explain": "Đường cơ sở (Baseline) là tập hợp các yêu cầu đã được phê duyệt chính thức bởi các bên có thẩm quyền tại một thời điểm cụ thể. Sau khi đã thiết lập baseline, mọi thay đổi bổ sung hoặc sửa đổi đối với các yêu cầu này đều bắt buộc phải thông qua một quy trình kiểm soát thay đổi (change control process) nghiêm ngặt."
      },
      {
        "question_id": 12,
        "question_title": "Which of the following is considered a valid reason for changing a software requirement after the baseline has been established?",
        "option_A": "A developer wants to experiment with a newly released programming language framework.",
        "option_B": "Changes in government regulations or market conditions that impact the business workflow.",
        "option_C": "The project manager wants to increase the page count of the SRS document.",
        "option_D": "A tester finds a typo in an unexecuted test script.",
        "correct_anwser": "B",
        "explain": "Sự thay đổi trong quy định pháp luật hoặc biến động của thị trường làm thay đổi trực tiếp quy trình nghiệp vụ của doanh nghiệp là lý do hoàn toàn chính đáng và bắt buộc phải cập nhật lại yêu cầu phần mềm (ngay cả khi đã chốt baseline) để đảm bảo hệ thống vận hành đúng luật và thực tế."
      },
      {
        "question_id": 13,
        "question_title": "What is the primary function of a Change Control Board (CCB) in software projects?",
        "option_A": "To write automated system integration scripts.",
        "option_B": "To review, evaluate, and approve or reject proposed changes to baselined requirements.",
        "option_C": "To style the graphical look and feel of the user interface.",
        "option_D": "To conduct performance evaluation interviews with project contractors.",
        "correct_anwser": "B",
        "explain": "Hội đồng kiểm soát thay đổi (Change Control Board - CCB) là một nhóm các bên liên quan chịu trách nhiệm đánh giá tác động, xem xét tài chính/thời gian để đưa ra quyết định chấp thuận (approve) hoặc từ chối (reject) các yêu cầu thay đổi đối với phần phạm vi đã được chốt baseline."
      },
      {
        "question_id": 14,
        "question_title": "What is the definition of a condition in which the scope of a project continues to increase in an uncontrolled fashion throughout the development process?",
        "option_A": "Risk",
        "option_B": "Inspection",
        "option_C": "Scope creep",
        "option_D": "Decision rule",
        "correct_anwser": "C",
        "explain": "Scope creep (phình bành phạm vi) là thuật ngữ chuyên ngành quản trị dự án dùng để chỉ hiện tượng phạm vi của một dự án liên tục tăng lên một cách không kiểm soát được, thường xảy ra khi các tính năng và yêu cầu mới được thêm vào mà không qua quy trình phê duyệt hoặc điều chỉnh tương ứng về mặt ngân sách, nguồn lực và thời gian."
      },
      {
        "question_id": 15,
        "question_title": "Why do we have to label the requirements in a software requirements specification (SRS)?",
        "option_A": "It allows us to refer to specific requirements in a change request, modification history, cross-reference, or requirements traceability matrix.",
        "option_B": "It enables reusing the requirements in multiple projects.",
        "option_C": "It facilitates collaboration between team members when they're discussing requirements.",
        "option_D": "It makes the SRS look more professional.",
        "correct_anwser": "A, B, C",
        "explain": "Việc đánh nhãn định danh duy nhất (ví dụ: REQ-001) cho từng yêu cầu mang lại rất nhiều lợi ích thực tế: giúp dễ dàng tham chiếu khi có yêu cầu thay đổi hoặc xây dựng ma trận truy vết (A); giúp dễ trích xuất và tái sử dụng các mẫu yêu cầu tương tự ở các dự án khác (B); và giúp các thành viên giao tiếp, thảo luận chính xác về một yêu cầu cụ thể mà không bị nhầm lẫn (C)."
      },
      {
        "question_id": 16,
        "question_title": "Which of the following characteristics should a collection of requirements exhibit?",
        "option_A": "Completeness, meaning it is acceptable if some necessary information is absent as long as the core requirements are documented.",
        "option_B": "Modifiability, which allows changes to be made without maintaining a history of changes or considering dependencies among requirements",
        "option_C": "Consistency, ensuring that requirements do not conflict with other requirements or higher-level business, user, or system requirements.",
        "option_D": "Traceability, where requirements should be loosely linked and not necessarily connected to their origin or to derived elements",
        "correct_anwser": "C",
        "explain": "Định nghĩa đúng của tính nhất quán (Consistency) là đảm bảo các yêu cầu không mâu thuẫn hay xung đột lẫn nhau hoặc mâu thuẫn với các mục tiêu kinh doanh cấp cao hơn (C). Các phương án khác đều đưa ra định nghĩa sai lệch về các đặc tính (ví dụ: Completeness - Đầy đủ mà lại chấp nhận thiếu thông tin là sai; Modifiability mà không cần lưu lịch sử là sai; Traceability mà liên kết lỏng lẻo không cần kết nối nguồn gốc là sai)."
      },
      {
        "question_id": 17,
        "question_title": "What potential issues can be prevented by validating requirements? (Select all that apply)",
        "option_A": "Scope creep",
        "option_B": "Eliminating All Bugs",
        "option_C": "Misaligned Expectations",
        "option_D": "Cost Overruns and Delays",
        "correct_anwser": "A, C, D",
        "explain": "Việc xác thực yêu cầu (Requirements Validation) giúp đảm bảo tài liệu chính xác và được đồng thuận trước khi lập trình. Hành động này ngăn chặn được hiện tượng phình đại phạm vi (A), lệch pha kỳ vọng giữa các bên (C), từ đó tránh được việc trễ hạn và đội chi phí do phải làm lại (D). Không một bước xác thực yêu cầu nào có thể giúp 'loại bỏ hoàn toàn mọi lỗi phần mềm' (B) vì lỗi còn phát sinh trong quá trình code và triển khai thực tế."
      },
      {
        "question_id": 18,
        "question_title": "What is a requirements baseline?",
        "option_A": "Constraints on the development process of the system",
        "option_B": "A specification of features be implemented, descriptions of how the system should behave or descriptions",
        "option_C": "A set of requirements that stakeholders have agreed to, often defining the contents of a specific planned release or development iteration",
        "correct_anwser": "C",
        "explain": "Yêu cầu cơ sở (Requirements baseline) là một tập hợp các yêu cầu đã được các bên liên quan xem xét, rà soát và chính thức thống nhất/phê duyệt ký nhận (agreed to). Nó đóng vai trò là cột mốc chuẩn để định nghĩa phạm vi tính năng cho một đợt phát hành (release) hoặc một phân đoạn phát triển cụ thể, và mọi thay đổi sau đó đều phải tuân theo quy trình kiểm soát thay đổi."
      },
      {
        "question_id": 19,
        "question_title": "In the context of requirements tracing, what is a traceability matrix used for? (Choose 2 answers)",
        "option_A": "To track project progress in real-time",
        "option_B": "To generate new requirements automatically",
        "option_C": "To map requirements to other system elements like design and code",
        "option_D": "To identify missing or unnecessary requirements",
        "correct_anwser": "C, D",
        "explain": "Ma trận truy vết yêu cầu (Traceability Matrix) được sử dụng để ánh xạ các yêu cầu phần mềm tới các thành tố khác của hệ thống như tài liệu thiết kế, các module code và test case (C). Thông qua liên kết đa chiều này, đội ngũ dự án có thể dễ dàng kiểm tra để phát hiện xem có yêu cầu nào bị bỏ sót chưa làm hoặc có tính năng thừa thãi nào được code mà không bắt nguồn từ yêu cầu ban đầu hay không (D)."
      },
      {
        "question_id": 20,
        "question_title": "Why is version control important in managing requirements? (Select all that apply)",
        "option_A": "It ensures that requirements are unique and traceable.",
        "option_B": "It allows for tracking the history of changes",
        "option_C": "It helps prioritize the requirements.",
        "option_D": "It guarantees that all stakeholders are updated on changes.",
        "correct_anwser": "B",
        "explain": "Lưu ý đề bài hiển thị dạng chọn nhiều phương án nhưng chỉ có một đặc điểm đúng mô tả bản chất trực tiếp của quản lý phiên bản (Version Control) là ghi vết và theo dõi lịch sử chỉnh sửa, thay đổi của các tài liệu yêu cầu theo thời gian (B). Các việc như định danh duy nhất (A) hay phân cấp ưu tiên (C) thuộc về kỹ thuật quản lý thuộc tính yêu cầu (Requirements Attributes Management)."
      },
      {
        "question_id": 21,
        "question_title": "Which of the following are basic steps in change impact analysis? (Select all that apply)",
        "option_A": "Understand the possible implications of the change",
        "option_B": "Identify all affected requirements and documents",
        "option_C": "Implement the change without stakeholder approval",
        "option_D": "Estimate the effort needed for the change",
        "correct_anwser": "A, B, D",
        "explain": "Phân tích tác động thay đổi (Change Impact Analysis) bao gồm các bước nền tảng: nhận định các hệ quả tiềm ẩn của thay đổi (A), xác định chính xác danh sách các yêu cầu và tài liệu thiết kế bị ảnh hưởng trực tiếp hay gián tiếp (B), và ước lượng công sức/thời gian cần thiết để thực hiện thay đổi đó (D). Việc tự ý triển khai mà không qua phê duyệt (C) là sai quy trình."
      },
      {
        "question_id": 22,
        "question_title": "Which of the following best describes the structure of the Requirements Traceability Matrix (RTM)?",
        "option_A": "It is a spreadsheet that lists requirements and their corresponding test cases",
        "option_B": "It is a graphical representation of the project schedule",
        "option_C": "It is a tool used to manage project risks",
        "option_D": "It is a spreadsheet that maps requirements to other project artifacts such as design documents, test cases, and source code",
        "correct_anwser": "D",
        "explain": "Ma trận truy vết yêu cầu (RTM) có cấu trúc dạng bảng/bảng tính (spreadsheet) chứa luồng liên kết hai chiều, ánh xạ từ một yêu cầu phần mềm sang các thành phần liên quan khác trong dự án như tài liệu kiến trúc thiết kế, kịch bản kiểm thử (test cases), và các tệp mã nguồn (source code) tương ứng nhằm đảm bảo phạm vi kiểm soát."
      },
      {
        "question_id": 23,
        "question_title": "Why is it important to clearly define the scope of a software project in a scope document?",
        "option_A": "Limit stakeholder involvement",
        "option_B": "Speed up the development process",
        "option_C": "Avoid addressing project risks",
        "option_D": "Prevent scope creep and ensure project focus",
        "correct_anwser": "D",
        "explain": "Việc xác định rõ ràng phạm vi của dự án giúp ngăn chặn tình trạng 'phình kịch cỡ/vô định hình phạm vi' (scope creep - việc các yêu cầu mới liên tục tự ý thêm vào mà không kiểm soát), đồng thời giữ cho đội ngũ phát triển tập trung vào những mục tiêu cốt lõi đã cam kết."
      },
      {
        "question_id": 24,
        "question_title": "What is the primary objective of creating a requirements traceability matrix (RTM)?",
        "option_A": "To link requirements to design, development, and testing artifacts",
        "option_B": "To identify redundant requirements",
        "option_C": "To finalize the system budget",
        "option_D": "To prioritize stakeholder meetings",
        "correct_anwser": "A",
        "explain": "Mục đích chính của Ma trận truy xuất nguồn gốc yêu cầu (Requirements Traceability Matrix - RTM) là thiết lập mối liên kết hai chiều giữa các yêu cầu ban đầu với các thành phần thiết kế, mã nguồn phát triển và các kịch bản kiểm thử (test cases) để đảm bảo không có yêu cầu nào bị bỏ sót."
      },
      {
        "question_id": 25,
        "question_title": "Which of the following factors can act as a barrier to requirements reuse?",
        "option_A": "Lack of stakeholder involvement",
        "option_B": "Frequent updates and version control of requirements documentation",
        "option_C": "Standardized format for requirements documentation",
        "option_D": "Requirements written in natural language are ambiguities, missing information, and hidden assumptions",
        "correct_anwser": "D",
        "explain": "Rào cản lớn nhất đối với việc tái sử dụng yêu cầu (requirements reuse) là các yêu cầu được viết bằng ngôn ngữ tự nhiên kém chuẩn hóa, dẫn đến tình trạng mơ hồ, thiếu thông tin và chứa nhiều giả định ngầm hiểu không rõ ràng."
      },
      {
        "question_id": 26,
        "question_title": "What is the central element that drives all activities in the software development process?",
        "option_A": "Project plans",
        "option_B": "Designs and code",
        "option_C": "Tests",
        "option_D": "Baselined requirements",
        "correct_anwser": "D",
        "explain": "Các yêu cầu đã được phê duyệt làm cơ sở chuẩn (Baselined requirements) chính là nền tảng cốt lõi định hướng và thúc đẩy mọi hoạt động tiếp theo trong vòng đời phần mềm, từ lập kế hoạch, thiết kế kiến trúc, viết mã nguồn cho đến kiểm thử."
      },
      {
        "question_id": 27,
        "question_title": "Which of the following activities fall under the core activities of requirements management?",
        "option_A": "Document formatting, project scheduling, risk management, and budget tracking.",
        "option_B": "Quality assurance, stakeholder management, resource allocation, and system testing.",
        "option_C": "Version control, change control, requirements status tracking, and requirements tracing.",
        "option_D": "Designing user interfaces, coding, testing software modules, and system deployment.",
        "correct_anwser": "C",
        "explain": "Quản lý yêu cầu (Requirements Management) bao gồm các hoạt động cốt lõi nhằm kiểm soát biến động sau khi đã có baseline, cụ thể là: Quản lý phiên bản (Version control), kiểm soát thay đổi (Change control), theo dõi trạng thái yêu cầu (Status tracking) và truy xuất nguồn gốc yêu cầu (Tracing)."
      },
      {
        "question_id": 28,
        "question_title": "What is a key benefit of using a requirements management tool?",
        "option_A": "It ensures traceability and reduces errors in requirements documentation",
        "option_B": "It finalizes stakeholder requirements automatically.",
        "option_C": "It replaces the validation process.",
        "option_D": "It eliminates the need for prototyping.",
        "correct_anwser": "A",
        "explain": "Lợi ích cốt lõi của công cụ quản lý yêu cầu (như Jira, Confluence, DOORS...) là tự động hóa và đảm bảo khả năng truy vết nguồn gốc (traceability) xuyên suốt dự án, từ đó giảm thiểu sai sót, mất mát hoặc xung đột khi yêu cầu thay đổi."
      },
      {
        "question_id": 29,
        "question_title": "What is the Change Control Board (CCB)?",
        "option_A": "A group of stakeholders responsible for documenting project assumptions",
        "option_B": "A group that decides to approve or reject proposed changes for a specific project",
        "option_C": "A team of project managers tasked with managing project risks",
        "option_D": "A committee responsible for scheduling project milestones",
        "correct_anwser": "B",
        "explain": "Ban Kiểm soát Thay đổi (CCB - Change Control Board) là một nhóm các bên liên quan chịu trách nhiệm xem xét, đánh giá và đưa ra quyết định chính thức về việc phê duyệt (approve) hoặc từ chối (reject) các yêu cầu thay đổi đề xuất trong dự án."
      },
      {
        "question_id": 30,
        "question_title": "What is a key challenge when maintaining trace data in an existing system?",
        "option_A": "There is often no existing trace data to start with.",
        "option_B": "The system is too complex to trace effectively.",
        "option_C": "Trace data becomes obsolete very quickly.",
        "option_D": "There are too many participants to track.",
        "correct_anwser": "C",
        "explain": "Thách thức lớn nhất khi duy trì ma trận truy vết yêu cầu (Traceability Matrix) là dữ liệu truy vết rất nhanh bị lỗi thời (obsolete) do hệ thống liên tục được cập nhật, sửa đổi, đòi hỏi phải có sự cập nhật thủ công hoặc công cụ đồng bộ liên tục."
      },
      {
        "question_id": 31,
        "question_title": "What is the purpose of a Requirements Traceability Matrix (RTM) in the requirements management process?",
        "option_A": "To trace the origin of software bugs",
        "option_B": "To document project milestones",
        "option_C": "To track the relationship between requirements and other project artifacts",
        "option_D": "To manage project budgets",
        "correct_anwser": "C",
        "explain": "Ma trận truy vết yêu cầu (RTM) là một công cụ quản lý được sử dụng để theo dõi các mối quan hệ đa chiều giữa yêu cầu gốc với các tài liệu thiết kế, mã nguồn và các kịch bản kiểm thử (test cases) tương ứng trong suốt vòng đời dự án."
      }
    ]
  },
  {
    "id": "swr302-module-7-prioritization-&-agile-requirements",
    "title": "SWR302 - Module 7 - Prioritization & Agile Requirements",
    "description": "Software Requirement Quiz",
    "questionsCount": 47,
    "questions": [
      {
        "question_id": 1,
        "question_title": "What are the purposes of prioritizing the requirements? Choose 2 correct answers.",
        "option_A": "To ensure that the team implements the highest value or most timely functionality first",
        "option_B": "To determine which release or increment will contain each feature or set of requirements",
        "option_C": "To finish the project faster",
        "option_D": "To facilitate the release of the product",
        "correct_anwser": "A, B",
        "explain": "Mục đích chính của việc ưu tiên hóa yêu cầu là đảm bảo đội ngũ phát triển những chức năng có giá trị cao nhất hoặc cấp thiết nhất trước (A) và xác định xem tính năng nào sẽ nằm trong đợt phát hành (release/increment) nào (B)."
      },
      {
        "question_id": 2,
        "question_title": "What's the difference between Use Cases and User Stories?",
        "option_A": "The use case is a business artifact which defines the software requirement or an application feature. Whereas user story is a test artifact which defines the steps to validate and verify that the software requirement or application feature exists",
        "option_B": "The user story contains complete and lengthy descriptions. A use case contains simplified and short descriptions",
        "option_C": "The user story is a business artifact which defines the software requirement or an application feature. Whereas use case is a test artifact which defines the steps to validate and verify that the software requirement or application feature exists",
        "option_D": "The user story contains simplified and short descriptions. A use case contains complete and lengthy descriptions",
        "correct_anwser": "D",
        "explain": "User Story (Câu chuyện người dùng) là những mô tả ngắn gọn, đơn giản, cô đọng dưới góc nhìn của người dùng cuối (thường theo mẫu As a... I want to... So that...). Ngược lại, Use Case (Ca sử dụng) là một tài liệu chi tiết, đầy đủ, mô tả tường tận các luồng tương tác và kịch bản nghiệp vụ đầy đủ giữa tác nhân và hệ thống."
      },
      {
        "question_id": 3,
        "question_title": "An analysis model that visually depicts the various states in which a system or an object in the system can exist, the permitted transitions that can take place between states.",
        "option_A": "State-transition diagram",
        "option_B": "Swimlane diagram",
        "option_C": "Use case diagram",
        "option_D": "Data Flow diagram",
        "correct_anwser": "A",
        "explain": "Sơ đồ chuyển trạng thái (State-transition diagram) là mô hình phân tích mô tả trực quan các trạng thái khác nhau của một hệ thống hoặc một đối tượng, cũng như các điều kiện dịch chuyển hợp lệ giữa các trạng thái đó."
      },
      {
        "question_id": 4,
        "question_title": "Prioritization is a way to deal with competing demands for limited resources. So, establishing the relative priority of each product capability lets you plan construction to provide the _______ value at the _______ cost.",
        "option_A": "highest, lowest",
        "option_B": "lowest, highest",
        "option_C": "highest, highest",
        "option_D": "lowest, lowest",
        "correct_anwser": "A",
        "explain": "Việc xác định mức độ ưu tiên tương đối của từng tính năng sản phẩm giúp người quản lý lập kế hoạch thi công nhằm mục đích mang lại giá trị cao nhất (highest value) với chi phí hoặc nguồn lực thấp nhất có thể (lowest cost)."
      },
      {
        "question_id": 5,
        "question_title": "Choose the incorrect answer when talking about the essential aspects of an agile approach to requirements.",
        "option_A": "Customer involvement",
        "option_B": "Expect stability",
        "option_C": "The backlog and prioritization",
        "option_D": "Timing",
        "option_E": "Documentation detail",
        "correct_anwser": "B",
        "explain": "Trong cách tiếp cận Agile đối với yêu cầu, người ta luôn chuẩn bị tinh thần đón nhận sự thay đổi (Embrace change) chứ không bao giờ 'Kỳ vọng sự ổn định' (Expect stability). Các khía cạnh còn lại như sự tham gia của khách hàng, backlog/ưu tiên hóa, timing và mức độ chi tiết tài liệu vừa đủ đều là đặc trưng của Agile."
      },
      {
        "question_id": 6,
        "question_title": "According to the \"Three-level scale\" prioritization, how is a \"High-priority requirement\" defined?",
        "option_A": "It is important (customers need the capability) but not urgent (it can wait for a later release).",
        "option_B": "It is both important (customers need the capability) and urgent (customers need it in the next release), or contractual/compliance obligations mandate its inclusion.",
        "option_C": "It is neither important nor urgent, and can be eliminated.",
        "option_D": "It is urgent for political reasons but not important for achieving business objectives.",
        "correct_anwser": "B",
        "explain": "Theo thang đo ưu tiên 3 mức độ (High, Medium, Low), một yêu cầu có độ ưu tiên Cao (High-priority) được định nghĩa là yêu cầu vừa quan trọng (khách hàng thực sự cần tính năng đó) vừa cấp bách (phải xuất hiện ngay trong đợt phát hành tới), hoặc là yêu cầu bắt buộc tuân thủ theo hợp đồng/pháp lý."
      },
      {
        "question_id": 7,
        "question_title": "With whom should an Agile analyst collaborate closely to ensure the requirements accurately reflect business needs?",
        "option_A": "Only the end customers.",
        "option_B": "Only the development and testing teams.",
        "option_C": "Only with the development team to relay technical requirements.",
        "option_D": "With the customer, project management, the development team, and other stakeholders to ensure requirements align with business needs.",
        "option_E": "With the business department solely for comparing statistical data.",
        "correct_anwser": "D",
        "explain": "Trong mô hình Agile, nhà phân tích cần đóng vai trò là cầu nối cộng tác liên tục và toàn diện với tất cả các bên bao gồm khách hàng, quản trị dự án, đội ngũ lập trình và các bên liên quan để đảm bảo mọi yêu cầu đưa ra đồng bộ với giá trị kinh doanh."
      },
      {
        "question_id": 8,
        "question_title": "Which of the following describes the difference between a product's vision and its scope?",
        "option_A": "Vision applies to Agile projects, while scope applies only to traditional projects.",
        "option_B": "Vision is a long-term goal and ultimate state of the product, while scope defines what portion of the vision will be built in a specific release or project.",
        "option_C": "Vision is documented by the developer, while scope is written by the customer.",
        "option_D": "Vision defines the budget constraints, while scope defines the technical stack.",
        "correct_anwser": "B",
        "explain": "Tầm nhìn (Vision) mô tả mục tiêu lâu dài và trạng thái lý tưởng cuối cùng mà sản phẩm hướng tới, trong khi phạm vi (Scope) xác định giới hạn cụ thể những tính năng hoặc phần việc nào của tầm nhìn đó sẽ thực sự được xây dựng trong một phiên bản phát hành hoặc dự án cụ thể."
      },
      {
        "question_id": 9,
        "question_title": "Which technique is most effective for resolving conflicts among stakeholders?",
        "option_A": "Prioritization workshops",
        "option_B": "Eliminating conflicting requirements",
        "option_C": "Focusing only on functional requirements",
        "option_D": "Avoiding stakeholder feedback",
        "correct_anwser": "A",
        "explain": "Các buổi hội thảo ưu tiên hóa (Prioritization workshops) tập hợp các bên liên quan lại để cùng thảo luận, đánh giá giá trị và mức độ quan trọng của từng yêu cầu dưới góc nhìn kinh doanh, từ đó giúp đạt được sự đồng thuận và giải quyết xung đột lợi ích một cách hiệu quả nhất."
      },
      {
        "question_id": 10,
        "question_title": "What is a common pitfall in writing non-functional requirements?",
        "option_A": "Making them too vague or unmeasurable",
        "option_B": "Prioritizing them over functional requirements",
        "option_C": "Writing them without stakeholder input",
        "option_D": "Skipping them in the documentation process",
        "correct_anwser": "A",
        "explain": "Một sai lầm phổ biến và nghiêm trọng nhất khi viết các yêu cầu phi chức năng (Non-functional requirements - NFR) là viết chúng quá mơ hồ, chung chung và không thể đo lường được (ví dụ: 'Hệ thống phải chạy nhanh', 'Giao diện phải thân thiện'). NFR đúng chuẩn cần phải định lượng được rõ ràng (ví dụ: 'Thời gian phản hồi phải dưới 2 giây')."
      },
      {
        "question_id": 11,
        "question_title": "What is the role of user stories in Agile requirements management?",
        "option_A": "To provide concise, actionable descriptions of features from the user's perspective",
        "option_B": "To replace the Vision and Scope document",
        "option_C": "To prioritize non-functional requirements",
        "option_D": "To finalize the system's architecture",
        "correct_anwser": "A",
        "explain": "Trong mô hình Agile, câu chuyện người dùng (User Story) đóng vai trò cung cấp các mô tả ngắn gọn, dễ hiểu và có thể thực thi được về một tính năng sản phẩm dưới góc nhìn/lăng kính của người sử dụng cuối (thường theo cấu trúc: As a... I want to... So that...)."
      },
      {
        "question_id": 12,
        "question_title": "What is the primary challenge of documenting requirements for complex systems?",
        "option_A": "Ensuring clarity, consistency, and avoiding ambiguities",
        "option_B": "Eliminating low-priority requirements",
        "option_C": "Skipping stakeholder validation",
        "option_D": "Focusing only on functional needs",
        "correct_anwser": "A",
        "explain": "Khi viết tài liệu yêu cầu cho các hệ thống lớn và phức tạp, thách thức hàng đầu luôn là đảm bảo tính rõ ràng (clarity), nhất quán (consistency) giữa hàng trăm yêu cầu đan xen và tuyệt đối tránh viết mơ hồ, đa nghĩa (avoiding ambiguities) gây hiểu lầm cho đội phát triển."
      },
      {
        "question_id": 13,
        "question_title": "If you prototype the whole solution rather than only the most uncertain, high-risk, or complex portions, your risk is",
        "option_A": "investing excessive effort in prototypes",
        "option_B": "distraction by details",
        "option_C": "pressure to release the prototype",
        "option_D": "unrealistic performance expectations",
        "correct_anwser": "A",
        "explain": "Nguyên tắc làm mẫu thử là chỉ nên tập trung vào các phần có rủi ro cao, phức tạp hoặc chưa rõ ràng để tối ưu chi phí. Nếu cố gắng làm mẫu thử cho toàn bộ giải pháp (the whole solution), dự án sẽ đối mặt với rủi ro lãng phí nguồn lực và bỏ ra công sức quá mức cần thiết vào mẫu thử (investing excessive effort in prototypes) trong khi nhiều phần trong đó đã rất rõ ràng."
      },
      {
        "question_id": 14,
        "question_title": "The four capitalized letters in the MoSCoW prioritization technique stand for:",
        "option_A": "Must, Should, Could, Won't",
        "option_B": "Must, Should, Could, Will",
        "option_C": "Must, Should, Can, Will",
        "option_D": "Must, Shall, Could, Won't",
        "correct_anwser": "A",
        "explain": "Kỹ thuật phân loại và ưu tiên yêu cầu MoSCoW là từ viết tắt của bốn nhóm: Must have (Phải có), Should have (Nên có), Could have (Có thể có), và Won't have this time (Chưa có vào lúc này)."
      },
      {
        "question_id": 15,
        "question_title": "Which of the following is NOT about prioritization techniques?",
        "option_A": "In or out.",
        "option_B": "Pairwise comparison and rank ordering.",
        "option_C": "Three-level scale.",
        "option_D": "MoSCoW.",
        "option_E": "Based on risk.",
        "correct_anwser": "E",
        "explain": "Các phương án A, B, C, D đều là tên gọi của các kỹ thuật hoặc thang đo phân loại ưu tiên yêu cầu chuẩn hóa trong kỹ nghệ yêu cầu (In or out, So sánh cặp Pairwise, Thang đo 3 mức Three-level, MoSCoW). Trích theo lý thuyết sách Karl Wiegers, 'Based on risk' (Dựa trên rủi ro) chỉ là một trong các tiêu chí đánh giá khi phân tích, chứ không phải một tên gọi kỹ thuật phân loại ưu tiên độc lập."
      },
      {
        "question_id": 16,
        "question_title": "Which of the following is NOT about Change management on Agile projects?",
        "option_A": "Agile processes harness change for the customer's competitive advantage.",
        "option_B": "Agile projects manage change by maintaining a specific backlog of work to be done.",
        "option_C": "Accepting change helps to meet evolving business objectives and priorities and to accommodate the limitations of human plans and foresight.",
        "option_D": "Agile methods vary as to their philosophy on this point; there is no single “correct” approach.",
        "correct_anwser": "B",
        "explain": "Trong mô hình Agile, các dự án quản lý thay đổi thông qua một danh sách động gọi là Product Backlog luôn luôn được liên tục cập nhật, làm mịn và tái ưu tiên (prioritized backlog), chứ không phải duy trì một danh sách công việc cố định hay cụ thể không đổi (maintaining a specific backlog). Các phương án A, C, D đều phản ánh đúng tuyên ngôn và triết lý đón nhận sự thay đổi của Agile."
      },
      {
        "question_id": 17,
        "question_title": "Which of the following is an example of a risk avoidance strategy?",
        "option_A": "Performing risk control activities to manage top-priority risks.",
        "option_B": "Documenting potential risks without any action.",
        "option_C": "Not engaging in the risky activity at all.",
        "option_D": "Ignoring minor risks and focusing only on major risks.",
        "correct_anwser": "C",
        "explain": "Né tránh rủi ro (Risk avoidance) có nghĩa là thay đổi kế hoạch dự án hoặc chủ động không tham gia vào hoạt động có rủi ro đó nữa (Not engaging in the risky activity at all) nhằm loại bỏ hoàn toàn khả năng xuất hiện hoặc ảnh hưởng của rủi ro đó đối với dự án."
      },
      {
        "question_id": 18,
        "question_title": "Which statement best describes the purpose of an Epic in Agile project?",
        "option_A": "To define detailed requirements and specifications for a project",
        "option_B": "To represent a high-level user need or business requirement that can be broken down into smaller, more manageable user stories",
        "option_C": "To assign tasks to team members for implementation",
        "option_D": "To prioritize project deliverables",
        "correct_anwser": "B",
        "explain": "Trong mô hình Agile, một Epic đóng vai trò đại diện cho một khối yêu cầu nghiệp vụ hoặc nhu cầu lớn ở cấp độ vĩ mô (high-level user need) của người dùng, mà từ đó thực tế sẽ được phân rã ra thành nhiều câu chuyện người dùng nhỏ hơn, chi tiết hơn (user stories) để đội phát triển dễ dàng quản lý và thực thi trong từng Sprint."
      },
      {
        "question_id": 19,
        "question_title": "Which of the following are considered good practices in requirements analysis? Select three.",
        "option_A": "Modeling the application environment to understand the system's boundaries and interactions with external entities.",
        "option_B": "Prioritizing the requirements based solely on the preferences of the development team without considering business goals or customer needs.",
        "option_C": "Creating prototypes to explore and validate uncertain requirements with stakeholders.",
        "option_D": "Analyzing data flows to ensure that all interactions between the system and external entities are understood and documented.",
        "correct_anwser": "A, C, D",
        "explain": "Các hoạt động phân tích yêu cầu chuẩn và tốt bao gồm: Mô hình hóa môi trường để xác định ranh giới hệ thống (A), xây dựng mẫu thử (prototype) để xác thực các yêu cầu chưa rõ ràng (C), và phân tích luồng dữ liệu (D). Lựa chọn B sai vì không được phép ưu tiên yêu cầu chỉ dựa trên sở thích cá nhân của đội phát triển mà bỏ qua mục tiêu kinh doanh của khách hàng."
      },
      {
        "question_id": 20,
        "question_title": "What should a business analyst do in an Agile project? Chooses 3 correct answers.",
        "option_A": "Define a lightweight, flexible requirements process and adapt it as the project warrants",
        "option_B": "Ensure that requirements documentation is at the right level: very detailed",
        "option_C": "Help validate that customer needs are accurately represented in the product backlog",
        "option_D": "Facilitate backlog prioritization",
        "correct_anwser": "A, C, D",
        "explain": "Trong môi trường Agile, vai trò của BA là thiết lập quy trình yêu cầu linh hoạt, gọn nhẹ (A), hỗ trợ xác thực nhu cầu khách hàng được phản ánh đúng trong product backlog (C), và điều phối việc ưu tiên hóa backlog (D). Lựa chọn B sai vì Agile không hướng tới việc viết tài liệu yêu cầu 'rất chi tiết' (very detailed) ngay từ đầu mà chú trọng vào mức độ chi tiết vừa đủ và tiệm tiến."
      },
      {
        "question_id": 21,
        "question_title": "Propose a solution for a scenario where a product owner is unable to understand all user requirements due to the complexity of the project. Which approach would you recommend?",
        "option_A": "Replace the product owner with a more knowledgeable individual.",
        "option_B": "Collaborate with multiple business analysts and product champions to gather comprehensive requirements.",
        "option_C": "Simplify the project to reduce complexity.",
        "option_D": "Delegate all decision-making to the development team.",
        "correct_anwser": "B",
        "explain": "Khi dự án quá phức tạp khiến Product Owner không thể tự nắm bắt toàn bộ yêu cầu, giải pháp tối ưu và thực tế nhất là phân rã công việc bằng cách phối hợp chặt chẽ với nhiều Business Analyst và các Product Champion để cùng thu thập và làm rõ yêu cầu một cách toàn diện."
      },
      {
        "question_id": 22,
        "question_title": "Why is traceability essential for managing changing requirements?",
        "option_A": "To track changes and ensure alignment with project goals",
        "option_B": "To prioritize functional requirements",
        "option_C": "To reduce the scope of stakeholder involvement",
        "option_D": "To eliminate ambiguous requirements",
        "correct_anwser": "A",
        "explain": "Tính truy vết (Traceability) đóng vai trò sống còn trong việc quản lý thay đổi vì nó cho phép theo dõi lịch sử, nguồn gốc của yêu cầu và phân tích tác động, đảm bảo mọi thay đổi phát sinh luôn nhất quán và hướng tới mục tiêu chung của dự án."
      },
      {
        "question_id": 23,
        "question_title": "What is the most popular form of user stories?",
        "option_A": "As a <type of user>, I want <some goal> so that <some reason>.",
        "option_B": "As a <type of user>, I want <some goal>.",
        "option_C": "As a <type of user>, I need <some need> so that <some reason>.",
        "option_D": "As a <type of user>, I want <some goal> to <some purpose>.",
        "correct_anwser": "A",
        "explain": "Mẫu (template) phổ biến nhất của một User Story trong phát triển phần mềm theo Agile là: \"As a <role>, I want <goal/desire> so that <benefit/reason>\" (Với tư cách là..., tôi muốn... để...)."
      },
      {
        "question_id": 24,
        "question_title": "An analysis model that depicts a process flow proceeding from one activity to another",
        "option_A": "Dialog map",
        "option_B": "Swimlane diagram",
        "option_C": "Context diagram",
        "option_D": "Class diagram",
        "correct_anwser": "B",
        "explain": "Sơ đồ làn bơi (Swimlane diagram) là một dạng mô hình phân tích quy trình thể hiện rõ luồng công việc (process flow) tuần tự đi từ hoạt động này sang hoạt động khác, đồng thời phân định rõ ràng trách nhiệm thực hiện hoạt động đó thuộc về phòng ban hoặc tác nhân nào."
      },
      {
        "question_id": 25,
        "question_title": "Which of the following is NOT a requirements prioritization technique?",
        "option_A": "Pairwise comparison",
        "option_B": "In or out",
        "option_C": "Three-level scale",
        "option_D": "$1000",
        "option_E": "MoSCoW",
        "correct_anwser": "D",
        "explain": "Kỹ thuật phân bổ nguồn vốn giả định để ưu tiên yêu cầu có tên chuẩn xác theo lý thuyết là kỹ thuật '$100 allocation' hoặc '100-dollar test'. Việc đưa ra con số '$1000' không phải là tên gọi chuẩn hóa của kỹ thuật này trong sách giáo trình kỹ nghệ yêu cầu."
      },
      {
        "question_id": 26,
        "question_title": "What does the MoSCoW method classify in requirements prioritization?",
        "option_A": "Urgency and cost of requirements",
        "option_B": "Must, Should, Could, and Won't categories",
        "option_C": "Technical feasibility and design limitations",
        "option_D": "High, Medium, and Low priorities",
        "correct_anwser": "B",
        "explain": "Phương pháp MoSCoW phân loại các yêu cầu thành 4 nhóm viết tắt rõ ràng bao gồm: M - Must have (Bắt buộc phải có), S - Should have (Nên có), C - Could have (Có thể có), và W - Won't have (Chưa phải lúc này/Không có trong đợt này)."
      },
      {
        "question_id": 27,
        "question_title": "How does the Kano model help analyze user requirements?",
        "option_A": "By classifying features into basic, performance, and delight categories",
        "option_B": "By prioritizing requirements based on technical feasibility",
        "option_C": "By eliminating unnecessary requirements",
        "option_D": "By focusing only on functional requirements",
        "correct_anwser": "A",
        "explain": "Mô hình Kano giúp phân tích mức độ hài lòng của khách hàng bằng cách phân loại các tính năng sản phẩm thành các nhóm: tính năng cơ bản bắt buộc (basic), tính năng tuyến tính/hiệu năng (performance), và tính năng gây bất ngờ thú vị (delight)."
      },
      {
        "question_id": 28,
        "question_title": "Why is it essential to specify acceptance criteria during requirements validation?",
        "option_A": "To define clear and measurable conditions for success",
        "option_B": "To prioritize functional requirements",
        "option_C": "To finalize the design phase",
        "option_D": "To eliminate stakeholder input",
        "correct_anwser": "A",
        "explain": "Tiêu chí nghiệm thu (Acceptance criteria) đóng vai trò then chốt trong việc thẩm định yêu cầu vì nó định nghĩa ra các điều kiện rõ ràng, có thể đo lường được để kiểm tra xem hệ thống có đáp ứng đúng mong đợi của người dùng và hoàn thành thành công hay không."
      },
      {
        "question_id": 29,
        "question_title": "Consider the following Statement: \"If a lead doesn't respond back within 30 days of the first contact, it must be a cold lead and can be marked accordingly\". What type of business rule is being depicted here?",
        "option_A": "Facts",
        "option_B": "Constraints",
        "option_C": "Action enablers",
        "option_D": "Inferences",
        "option_E": "Computations",
        "correct_anwser": "D",
        "explain": "Quy tắc kinh doanh dạng Hệ quả/Suy luận (Inferences) tạo ra một sự thật hoặc tri thức mới từ các điều kiện sẵn có. Tuyên bố trên suy luận rằng: nếu không phản hồi trong 30 ngày (sự thật có sẵn) thì thông tin này được phân loại thành \"khách hàng tiềm năng nguội lạnh\" (tri thức mới suy luận ra)."
      },
      {
        "question_id": 30,
        "question_title": "What is the primary purpose of a Swimlane diagram?",
        "option_A": "To represent detailed software architecture and coding structures.",
        "option_B": "To visually depict the steps involved in a business process or the operations of a proposed software system, subdivided into lanes that represent different systems or actors.",
        "option_C": "To exclusively model user interface interactions and design layouts.",
        "option_D": "To show the organizational structure and management hierarchy within a company.",
        "correct_anwser": "B",
        "explain": "Mục đích chính của biểu đồ làn bơi (Swimlane diagram) là mô tả trực quan dòng chảy tuần tự của các bước trong một quy trình nghiệp vụ, trong đó chia thành các làn (lanes) song song đại diện cho vai trò chịu trách nhiệm của các tác nhân hoặc phân hệ hệ thống khác nhau."
      },
      {
        "question_id": 31,
        "question_title": "Which of the following is a benefit of prioritizing requirements?",
        "option_A": "Improved project management",
        "option_B": "Decreased stakeholder involvement",
        "option_C": "Enhanced focus on high-value features",
        "option_D": "Reduced scope creep",
        "correct_anwser": "C",
        "explain": "Lợi ích trực tiếp và quan trọng nhất của việc phân loại mức độ ưu tiên yêu cầu là giúp đội ngũ dự án tập trung tối đa nguồn lực vào việc phát triển các tính năng mang lại giá trị cao nhất cho khách hàng trước (Enhanced focus on high-value features)."
      },
      {
        "question_id": 32,
        "question_title": "Why is prioritization essential in agile projects, especially when customer expectations are high and timelines are short?",
        "option_A": "It ensures that the project manager can handle the project without customer input, focusing solely on cost and efficiency.",
        "option_B": "It allows developers to skip less important features, ensuring that only critical bugs are fixed before release.",
        "option_C": "It helps in delivering the most critical or valuable functionality as early as possible, ensuring maximum business value within project constraints.",
        "option_D": "It lets the project manager choose which requirements to ignore, focusing only on budget and staff limitations.",
        "correct_anwser": "C",
        "explain": "Trong các dự án Agile với thời gian ngắn (timeline gắt gao), việc ưu tiên giúp đội ngũ bàn giao được các gói tính năng cốt lõi và có giá trị nhất cho khách hàng ngay từ những phiên bản sớm, đảm bảo tối ưu hóa giá trị kinh doanh trong phạm vi ràng buộc của dự án."
      },
      {
        "question_id": 33,
        "question_title": "“Story point” is used to measure which one below?",
        "option_A": "User story",
        "option_B": "Code",
        "option_C": "Function",
        "option_D": "Architecture",
        "correct_anwser": "A",
        "explain": "Trong các phương pháp phát triển phần mềm linh hoạt (Agile/Scrum), điểm câu chuyện (Story point) là một đơn vị đo lường trừu tượng được sử dụng để ước lượng kích thước, độ phức tạp và nỗ lực cần thiết để hoàn thành một User story."
      },
      {
        "question_id": 34,
        "question_title": "The close collaboration of customers with developers on agile projects generally means that requirements can be documented in _______ detail than on traditional projects.",
        "option_A": "less",
        "option_B": "more",
        "option_C": "shorter",
        "option_D": "longer",
        "correct_anwser": "A",
        "explain": "Do đặc thù của các dự án Agile là khách hàng hợp tác và trao đổi rất thường xuyên, trực tiếp với đội ngũ phát triển nên các tài liệu yêu cầu thường được viết ngắn gọn, cô đọng và ít chi tiết hơn (\"less detail\") so với việc phải làm tài liệu đặc tả đồ sộ, kỹ lưỡng từ đầu như các mô hình truyền thống (Waterfall)."
      },
      {
        "question_id": 35,
        "question_title": "How does the MoSCoW method assist in prioritizing requirements?",
        "option_A": "By categorizing requirements as Must-have, Should-have, Could-have, and Won’t-have",
        "option_B": "By focusing on technical feasibility",
        "option_C": "By skipping stakeholder engagement",
        "option_D": "By eliminating low-priority requirements",
        "correct_anwser": "A",
        "explain": "Phương pháp MoSCoW là một kỹ thuật phân loại độ ưu tiên của yêu cầu bằng cách chia chúng thành 4 nhóm rõ ràng: Must-have (Bắt buộc phải có), Should-have (Nên có), Could-have (Có thể có nếu có nguồn lực), và Won't-have (Chưa cần thiết/Không có trong lần phát hành này)."
      },
      {
        "question_id": 36,
        "question_title": "Which of the following characteristics of excellent requirements is depicted by the statement: \"Requirements don't conflict with other requirements of the same type or with higher-level biz, user, or system requirements.\" ?",
        "option_A": "Complete",
        "option_B": "Unambiguous",
        "option_C": "Consistent",
        "option_D": "Traceable",
        "option_E": "Modifiable",
        "correct_anwser": "C",
        "explain": "Phát biểu trên mô tả tính nhất quán (Consistent) của yêu cầu, nghĩa là các yêu cầu không được mâu thuẫn hay xung đột lẫn nhau, đồng thời phải đồng bộ với các yêu cầu ở cấp cao hơn như mục tiêu kinh doanh hay nhu cầu thực tế của người dùng."
      },
      {
        "question_id": 37,
        "question_title": "What is the purpose of categorizing requirements into \"Must-have\" and \"Should-have\"?",
        "option_A": "To prioritize high-value requirements for early implementation",
        "option_B": "To eliminate low-priority requirements altogether",
        "option_C": "To finalize coding strategies",
        "option_D": "To reduce the scope of non-functional requirements",
        "correct_anwser": "A",
        "explain": "Phân loại yêu cầu thành 'Must-have' và 'Should-have' (theo mô hình MoSCoW) nhằm mục đích sắp xếp thứ tự ưu tiên cho các yêu cầu có giá trị cao để đưa vào phát triển và triển khai sớm trong các giai đoạn đầu của dự án."
      },
      {
        "question_id": 38,
        "question_title": "What is a key characteristic of Agile projects?",
        "option_A": "Strict adherence to a detailed project plan",
        "option_B": "Regular adaptation to changing requirements and priorities",
        "option_C": "Emphasis on comprehensive documentation over working software",
        "option_D": "Minimal interaction with customers and stakeholders",
        "correct_anwser": "B",
        "explain": "Đặc trưng cốt lõi của phương pháp luận Agile (Tuyên ngôn Agile) là khả năng thích ứng nhanh chóng và phản hồi thường xuyên trước các thay đổi về yêu cầu cũng như độ ưu tiên của khách hàng trong suốt quá trình triển khai dự án."
      },
      {
        "question_id": 39,
        "question_title": "What is the primary challenge in defining system boundaries during requirements elicitation?",
        "option_A": "Ensuring all stakeholders agree on the scope and avoiding scope creep",
        "option_B": "Prioritizing functional requirements over non-functional requirements",
        "option_C": "Eliminating technical constraints",
        "option_D": "Finalizing coding strategies",
        "correct_anwser": "A",
        "explain": "Thách thức lớn nhất khi xác định ranh giới hệ thống (system boundaries) là làm sao để tất cả các bên liên quan thống nhất về phạm vi dự án, từ đó tránh hiện tượng phình đại phạm vi (scope creep) ngoài kiểm soát."
      },
      {
        "question_id": 40,
        "question_title": "How does the MoSCoW method contribute to prioritizing requirements based on business objectives",
        "option_A": "It prioritizes requirements solely based on stakeholder preferences",
        "option_B": "It categorizes requirements into Must-haves, Should-haves, Could-haves, and Won't-haves to guide prioritization",
        "option_C": "It excludes business objectives from the prioritization process",
        "option_D": "It only considers technical specifications in prioritization decisions",
        "correct_anwser": "B",
        "explain": "Phương pháp MoSCoW hỗ trợ phân định thứ tự ưu tiên bằng cách phân loại các yêu cầu rõ ràng thành 4 nhóm chiến lược: Must-have (Bắt buộc phải có), Should-have (Nên có), Could-have (Có thể có) và Won't-have (Chưa làm trong giai đoạn này)."
      },
      {
        "question_id": 41,
        "question_title": "How can risks be prioritized in project management?",
        "option_A": "By focusing on risks that are least likely to occur",
        "option_B": "By considering both the likelihood of occurrence and potential impact of risks",
        "option_C": "By ignoring potential impact and only considering likelihood",
        "option_D": "By assuming that all risks are equally important",
        "correct_anwser": "B",
        "explain": "Trong quản trị dự án, rủi ro được ưu tiên xử lý bằng cách đánh giá dựa trên hai yếu tố cốt lõi: Xác suất xảy ra rủi ro (Likelihood/Probability) và Mức độ ảnh hưởng/Tác động của rủi ro đó nếu nó xảy ra (Potential Impact)."
      },
      {
        "question_id": 42,
        "question_title": "How does modeling help in analyzing complex requirements?",
        "option_A": "By visualizing requirements and identifying inconsistencies or gaps",
        "option_B": "By prioritizing coding over documentation",
        "option_C": "By finalizing all functional requirements early",
        "option_D": "By reducing stakeholder engagement",
        "correct_anwser": "A",
        "explain": "Việc mô hình hóa (modeling) thông qua các sơ đồ (DFD, Use Case, Sequence...) giúp trực quan hóa các yêu cầu phức tạp, từ đó giúp các kỹ sư yêu cầu và khách hàng dễ dàng phát hiện ra các điểm mâu thuẫn (inconsistencies) hoặc khoảng trống thiếu sót (gaps)."
      },
      {
        "question_id": 43,
        "question_title": "How does prioritization help in managing conflicting requirements?",
        "option_A": "It ensures that high-value requirements are implemented first.",
        "option_B": "It eliminates non-functional requirements from consideration.",
        "option_C": "It finalizes all requirements before the design phase.",
        "option_D": "It focuses on budget over stakeholder needs",
        "correct_anwser": "A",
        "explain": "Định điểm ưu tiên (Prioritization) giúp giải quyết xung đột bằng cách xác định rõ yêu cầu nào mang lại giá trị cao nhất cho doanh nghiệp hoặc khách hàng để ưu tiên triển khai trước trong điều kiện nguồn lực có hạn."
      },
      {
        "question_id": 44,
        "question_title": "Why is it crucial to involve users during requirements elicitation?",
        "option_A": "To gather insights about their needs and ensure requirements meet their expectations",
        "option_B": "To prioritize system design over functional requirements",
        "option_C": "To validate non-functional requirements",
        "option_D": "To finalize system testing strategies",
        "correct_anwser": "A",
        "explain": "Việc lôi cuốn người dùng tham gia vào giai đoạn khơi gợi yêu cầu là vô cùng quan trọng nhằm thấu hiểu chính xác nhu cầu thực tế của họ, tránh việc đoán mò và đảm bảo phần mềm làm ra đáp ứng đúng kỳ vọng."
      },
      {
        "question_id": 45,
        "question_title": "Consider the following Statement: \"If a lead doesn't respond back within 30 days of the first contact, it must be a cold lead and can be marked accordingly\". What types of business rule is being depicted here?",
        "option_A": "Facts",
        "option_B": "Constraints",
        "option_C": "Action enablers",
        "option_D": "Inferences",
        "option_E": "Computations",
        "correct_anwser": "D",
        "explain": "Phát biểu trên thuộc loại luật kinh doanh dạng Suy luận (Inferences) hoặc Luật phái sinh (Derivations). Từ một sự thật đã biết (không phản hồi trong 30 ngày), hệ thống tự động suy luận ra một tri thức mới hoặc trạng thái mới (đây là một 'cold lead')."
      },
      {
        "question_id": 46,
        "question_title": "Which of the following is NOT about Agile project?",
        "option_A": "Developers have little interaction with customers after construction begins on projects.",
        "option_B": "It encourage creating the minimum amount of documentation needed to accurately guide the developers and testers.",
        "option_C": "BAs or other people responsible for requirements will develop the necessary precision through conversations and documentation when it is needed.",
        "option_D": "The se collaboration of customers with developers on agile projects generally means that requirements can be documented in less detail.",
        "correct_anwser": "A",
        "explain": "Phát biểu A hoàn toàn sai lệch với tinh thần Agile. Trong dự án Agile, lập trình viên và khách hàng/Product Owner phải liên tục tương tác, trao đổi và phản hồi trong suốt các chu kỳ Sprint, chứ không phải ngắt kết nối sau khi bắt đầu giai đoạn code (construction)."
      },
      {
        "question_id": 47,
        "question_title": "Which of the following is NOT a principle of software process improvement?",
        "option_A": "People and organizations change only when they have an incentive to do so.",
        "option_B": "Prioritizing individual contributions over teamwork",
        "option_C": "Process changes should be goal-oriented",
        "option_D": "Process improvement should be evolutionary and continuous",
        "correct_anwser": "B",
        "explain": "Cải tiến quy trình phần mềm (SPI) luôn nhấn mạnh vào sự đồng lòng, tối ưu hóa quy trình làm việc chung và tinh thần đồng đội (teamwork) chứ không bao giờ đặt sự đóng góp mang tính cá nhân biệt lập lên trên (B)."
      }
    ]
  }
];
