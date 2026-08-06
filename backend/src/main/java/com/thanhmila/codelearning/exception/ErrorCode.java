package com.thanhmila.codelearning.exception;


import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;


@Getter
@AllArgsConstructor
public enum ErrorCode {

    UNCATEGORIZED_EXCEPTION(1000, "An unexpected system error occurred. Please try again later.", HttpStatus.INTERNAL_SERVER_ERROR),
    INVALID_REQUEST(1001, "The request is invalid. Please check your data and try again.", HttpStatus.BAD_REQUEST),
    VALIDATION_ERROR(1002, "Some input fields are invalid. Please check the errors below.", HttpStatus.BAD_REQUEST),
    RESOURCE_NOT_FOUND(1003, "The requested resource could not be found.", HttpStatus.NOT_FOUND),
    ACCESS_DENIED(1004, "You do not have permission to perform this action.", HttpStatus.FORBIDDEN),
    UNAUTHENTICATED(1005, "Please log in to continue.", HttpStatus.UNAUTHORIZED),
    INVALID_REQUEST_BODY(1006, "The request body is missing or formatted incorrectly.", HttpStatus.BAD_REQUEST),
    TOO_MANY_REQUESTS(1007, "You have exceeded the maximum number of requests allowed. Please try again later.", HttpStatus.TOO_MANY_REQUESTS),

    USERNAME_ALREADY_EXISTS(2000, "This username is already taken. Please choose another one.", HttpStatus.CONFLICT),
    EMAIL_ALREADY_EXISTS(2001, "This email address is already registered.", HttpStatus.CONFLICT),
    USER_NOT_FOUND(2002, "The specified user account could not be found.", HttpStatus.NOT_FOUND),
    INVALID_USERNAME_OR_PASSWORD(2003, "Incorrect username or password. Please try again.", HttpStatus.UNAUTHORIZED),
    ACCOUNT_LOCKED(2004, "Your account has been locked. Please contact support for assistance.", HttpStatus.FORBIDDEN),
    ACCOUNT_DISABLED(2005, "Your account is currently disabled. Please contact support.", HttpStatus.FORBIDDEN),
    USERNAME_INVALID(2006, "Username must be at least 4 characters long.", HttpStatus.BAD_REQUEST),
    PASSWORD_INVALID(2007, "Password must be at least 4 characters long.", HttpStatus.BAD_REQUEST),
    CONFIRM_PASSWORD_INVALID(2008, "Password confirmation must be at least 4 characters long.", HttpStatus.BAD_REQUEST),
    EMAIL_INVALID(2009, "Please enter a valid email address.", HttpStatus.BAD_REQUEST),
    PHONE_INVALID(2010, "Please enter a valid phone number.", HttpStatus.BAD_REQUEST),
    DISPLAY_NAME_INVALID(2011, "Display name must be at least 4 characters long.", HttpStatus.BAD_REQUEST),
    PASSWORD_NOT_MATCH(2012, "Passwords do not match. Please try again.", HttpStatus.BAD_REQUEST),
    OLD_PASSWORD_NOT_MATCH(2013, "The current password you entered is incorrect.", HttpStatus.BAD_REQUEST),
    NEW_PASSWORD_SAME_AS_OLD_PASSWORD(2014, "Your new password must be different from your current password.", HttpStatus.BAD_REQUEST),
    OLD_PASSWORD_INVALID(2015, "Current password must be at least 4 characters long.", HttpStatus.BAD_REQUEST),
    NEW_PASSWORD_INVALID(2016, "New password must be at least 4 characters long.", HttpStatus.BAD_REQUEST),
    CONFIRM_NEW_PASSWORD_INVALID(2017, "New password confirmation must be at least 4 characters long.", HttpStatus.BAD_REQUEST),
    PAGE_INVALID(2020, "Page index must be 0 or greater.", HttpStatus.BAD_REQUEST),
    PAGE_SIZE_INVALID(2021, "Page size cannot exceed 20 items.", HttpStatus.BAD_REQUEST),

    INVALID_TOKEN(2020, "Your session has expired or is invalid. Please log in again.", HttpStatus.UNAUTHORIZED),
    EXPIRED_TOKEN(2021, "Your session token has expired. Please log in again.", HttpStatus.UNAUTHORIZED),
    REFRESH_TOKEN_EXPIRED(2022, "Your session has expired. Please log in again.", HttpStatus.UNAUTHORIZED),


    COURSE_NOT_FOUND(3000, "The requested course could not be found.", HttpStatus.NOT_FOUND),
    COURSE_INACTIVE(3001, "This course is currently not active or available.", HttpStatus.BAD_REQUEST),
    COURSE_IS_NOT_FREE(3002, "This course is not free. Please enroll or purchase to continue.", HttpStatus.BAD_REQUEST),
    COURSE_TITLE_REQUIRED(3003, "Course title is required.", HttpStatus.BAD_REQUEST),
    COURSE_TITLE_TOO_LONG(3004, "Course title cannot exceed 255 characters.", HttpStatus.BAD_REQUEST),
    COURSE_PRICE_REQUIRED(3005, "Course price is required.", HttpStatus.BAD_REQUEST),
    COURSE_PRICE_INVALID(3006, "Course price must be a non-negative value.", HttpStatus.BAD_REQUEST),
    CATEGORY_NOT_FOUND(3007, "One or more selected categories could not be found.", HttpStatus.NOT_FOUND),
    CLOUDINARY_UPLOAD_FAILED(3008, "Failed to upload file. Please try again.", HttpStatus.INTERNAL_SERVER_ERROR),
    CHAPTER_NOT_FOUND(3100, "The requested chapter could not be found.", HttpStatus.NOT_FOUND),
    CHAPTER_TITLE_REQUIRED(3101, "Chapter title is required.", HttpStatus.BAD_REQUEST),
    CHAPTER_TITLE_TOO_LONG(3102, "Chapter title cannot exceed 255 characters.", HttpStatus.BAD_REQUEST),
    LESSON_NOT_FOUND(3200, "The requested lesson could not be found.", HttpStatus.NOT_FOUND),
    ACCESS_DENIED_COURSE(3300, "You do not have access to this course.", HttpStatus.CONFLICT),


    ENROLLMENT_NOT_FOUND(4100, "Enrollment record could not be found.", HttpStatus.NOT_FOUND),
    ALREADY_ENROLLED(4101, "You are already enrolled in this course.", HttpStatus.CONFLICT),
    NOT_ENROLLED(4102, "You must enroll in this course to access this content.", HttpStatus.FORBIDDEN),
    PROGRESS_SUMMARY_NOT_FOUND(4203, "Learning progress history could not be found.", HttpStatus.NOT_FOUND),
    LESSON_ALREADY_COMPLETED(4204, "This lesson has already been marked as completed.", HttpStatus.CONFLICT),

    QUIZ_NOT_FOUND(5000, "The requested quiz could not be found.", HttpStatus.NOT_FOUND),
    QUIZ_TITLE_INVALID(5001, "Quiz title cannot be blank.", HttpStatus.BAD_REQUEST),
    QUIZ_QUESTIONS_EMPTY(5002, "A quiz must contain at least one question.", HttpStatus.BAD_REQUEST),
    QUIZ_ALREADY_EXISTS(5003, "A quiz already exists for this lesson.", HttpStatus.CONFLICT),
    QUIZ_ATTEMPT_NOT_FOUND(5100, "Quiz attempt record could not be found.", HttpStatus.NOT_FOUND),

    QUESTION_CONTENT_INVALID(5201, "Question content cannot be blank.", HttpStatus.BAD_REQUEST),
    QUESTION_ORDER_INVALID(5202, "Question order index is required.", HttpStatus.BAD_REQUEST),
    QUESTION_OPTIONS_EMPTY(5203, "A question must have at least one option.", HttpStatus.BAD_REQUEST),
    QUIZ_QUESTION_CORRECT_OPTION_INVALID(5204, "Each question must have at least one correct option.", HttpStatus.BAD_REQUEST),

    OPTION_CONTENT_INVALID(5301, "Option content cannot be blank.", HttpStatus.BAD_REQUEST),
    OPTION_IS_CORRECT_INVALID(5302, "You must specify if this option is correct.", HttpStatus.BAD_REQUEST),

    OJ_PROBLEM_NOT_FOUND(6000, "The requested programming problem could not be found.", HttpStatus.NOT_FOUND),
    TESTCASE_NOT_FOUND(6001, "The requested testcase could not be found.", HttpStatus.NOT_FOUND),
    SUBMISSION_NOT_FOUND(6002, "The submission record could not be found.", HttpStatus.NOT_FOUND),
    OJ_SUBMISSION_FAILED(6304, "Failed to submit code to Online Judge sandbox. Please try again.", HttpStatus.BAD_GATEWAY),
    JUDGE0_SUBMISSION_FAILED(6308, "Failed to connect to the compilation sandbox. Please try again.", HttpStatus.BAD_GATEWAY),
    OJ_PROBLEM_ID_REQUIRED(6305, "Problem ID is required.", HttpStatus.BAD_REQUEST),
    OJ_LANGUAGE_ID_REQUIRED(6306, "Programming language ID is required.", HttpStatus.BAD_REQUEST),
    OJ_SOURCE_CODE_EMPTY(6307, "Source code cannot be empty.", HttpStatus.BAD_REQUEST),

    FILE_ASSIGNMENT_NOT_FOUND(7000, "The requested assignment could not be found.", HttpStatus.NOT_FOUND),
    FILE_SUBMISSION_NOT_FOUND(7100, "The assignment submission record could not be found.", HttpStatus.NOT_FOUND),

    COMMENT_NOT_FOUND(8000, "The requested comment could not be found.", HttpStatus.NOT_FOUND),
    COURSE_REVIEW_ALREADY_EXISTS(8101, "You have already reviewed this course.", HttpStatus.CONFLICT),
    INVALID_COMMENT_LESSON(8102, "The comment is not associated with a valid lesson.", HttpStatus.BAD_REQUEST),

    CONTEST_NOT_FOUND(9000, "The requested contest could not be found.", HttpStatus.NOT_FOUND),
    CONTEST_PASSWORD_INVALID(9003, "The contest password you entered is incorrect.", HttpStatus.UNAUTHORIZED),
    CONTEST_NOT_JOINED(9202, "You must join this contest before participating.", HttpStatus.FORBIDDEN),
    CONTEST_ALREADY_STARTED(9004, "This contest has already started or ended.", HttpStatus.BAD_REQUEST),
    CONTEST_NOT_RUNNING(9005, "This contest is not currently running.", HttpStatus.BAD_REQUEST),

    INSUFFICIENT_BALANCE(10001, "Insufficient wallet balance. Please top up and try again.", HttpStatus.BAD_REQUEST),
    COURSE_ALREADY_IN_CART(10002, "This course is already in your cart.", HttpStatus.CONFLICT);

    private final int code;
    private final String message;
    private final HttpStatus httpStatus;

}