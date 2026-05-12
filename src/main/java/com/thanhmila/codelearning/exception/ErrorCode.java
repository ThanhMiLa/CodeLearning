package com.thanhmila.codelearning.exception;


import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;


@Getter
@AllArgsConstructor
public enum ErrorCode {

    UNCATEGORIZED_EXCEPTION(1000, "Uncategorized error", HttpStatus.INTERNAL_SERVER_ERROR),
    INVALID_REQUEST(1001, "Invalid request", HttpStatus.BAD_REQUEST),
    VALIDATION_ERROR(1002, "Validation error", HttpStatus.BAD_REQUEST),
    RESOURCE_NOT_FOUND(1003, "Resource not found", HttpStatus.NOT_FOUND),
    ACCESS_DENIED(1004, "Access denied", HttpStatus.FORBIDDEN),
    UNAUTHENTICATED(1005, "Unauthenticated", HttpStatus.UNAUTHORIZED),
    INVALID_REQUEST_BODY(1006, "Request body is missing or invalid format", HttpStatus.BAD_REQUEST),

    USERNAME_ALREADY_EXISTS(2000, "Username already exists", HttpStatus.CONFLICT),
    EMAIL_ALREADY_EXISTS(2001, "Email already exists", HttpStatus.CONFLICT),
    USER_NOT_FOUND(2002, "User not found", HttpStatus.NOT_FOUND),
    INVALID_USERNAME_OR_PASSWORD(2003, "Invalid username or password", HttpStatus.UNAUTHORIZED),
    ACCOUNT_LOCKED(2004, "Account is locked", HttpStatus.FORBIDDEN),
    ACCOUNT_DISABLED(2005, "Account is disabled", HttpStatus.FORBIDDEN),
    USERNAME_INVALID(2006, "Username must be at least 4 chars", HttpStatus.BAD_REQUEST),
    PASSWORD_INVALID(2007, "Password must be at least 4 chars", HttpStatus.BAD_REQUEST),
    CONFIRM_PASSWORD_INVALID(2008, "Confirm password must be at least 4 chars", HttpStatus.BAD_REQUEST),
    EMAIL_INVALID(2009, "Email is invalid", HttpStatus.BAD_REQUEST),
    PHONE_INVALID(2010, "Phone number is invalid", HttpStatus.BAD_REQUEST),
    DISPLAY_NAME_INVALID(2011, "Display name is invalid", HttpStatus.BAD_REQUEST),
    PASSWORD_NOT_MATCH(2012, "Password and confirm password not match", HttpStatus.BAD_REQUEST),
    OLD_PASSWORD_NOT_MATCH(2013, "Old password not match", HttpStatus.BAD_REQUEST),
    NEW_PASSWORD_SAME_AS_OLD_PASSWORD(2014, "New password must be different from old password", HttpStatus.BAD_REQUEST),
    OLD_PASSWORD_INVALID(2015, "Old password must be at least 4 chars", HttpStatus.BAD_REQUEST),
    NEW_PASSWORD_INVALID(2016, "New password must be at least 4 chars", HttpStatus.BAD_REQUEST),
    CONFIRM_NEW_PASSWORD_INVALID(2017, "Confirm new password must be at least 4 chars", HttpStatus.BAD_REQUEST),
    PAGE_INVALID(2020, "Page cannot less than 0", HttpStatus.BAD_REQUEST),
    PAGE_SIZE_INVALID(2021, "Page size cannot greater than 20", HttpStatus.BAD_REQUEST),

    INVALID_TOKEN(2020, "Invalid token", HttpStatus.UNAUTHORIZED),
    EXPIRED_TOKEN(2021, "Token has expired", HttpStatus.UNAUTHORIZED),
    REFRESH_TOKEN_EXPIRED(2022, "Refresh token has expired", HttpStatus.UNAUTHORIZED),


    COURSE_NOT_FOUND(3000, "Course not found", HttpStatus.NOT_FOUND),
    LESSON_NOT_FOUND(3200, "Lesson not found", HttpStatus.NOT_FOUND),
    ACCESS_DENIED_COURSE(3300, "Cannot access course", HttpStatus.CONFLICT),


    ENROLLMENT_NOT_FOUND(4100, "Enrollment not found", HttpStatus.NOT_FOUND),
    ALREADY_ENROLLED(4101, "User already enrolled this course", HttpStatus.CONFLICT),
    NOT_ENROLLED(4102, "User is not enrolled in this course", HttpStatus.FORBIDDEN),
    PROGRESS_SUMMARY_NOT_FOUND(4203, "Progress summary not found", HttpStatus.NOT_FOUND),
    LESSON_ALREADY_COMPLETED(4204, "Lesson already completed", HttpStatus.CONFLICT),

    QUIZ_NOT_FOUND(5000, "Quiz not found", HttpStatus.NOT_FOUND),
    QUIZ_TITLE_INVALID(5001, "Quiz title cannot be blank", HttpStatus.BAD_REQUEST),
    QUIZ_QUESTIONS_EMPTY(5002, "Quiz must have at least one question", HttpStatus.BAD_REQUEST),
    QUIZ_ALREADY_EXISTS(5003, "Quiz already exists for this lesson", HttpStatus.CONFLICT),
    QUIZ_ATTEMPT_NOT_FOUND(5100, "Quiz attempt not found", HttpStatus.NOT_FOUND),

    QUESTION_CONTENT_INVALID(5201, "Question content cannot be blank", HttpStatus.BAD_REQUEST),
    QUESTION_ORDER_INVALID(5202, "Order index cannot be null", HttpStatus.BAD_REQUEST),
    QUESTION_OPTIONS_EMPTY(5203, "Question must have at least one option", HttpStatus.BAD_REQUEST),
    QUIZ_QUESTION_CORRECT_OPTION_INVALID(5204, "Each question must have at least one correct option", HttpStatus.BAD_REQUEST),

    OPTION_CONTENT_INVALID(5301, "Option content cannot be blank", HttpStatus.BAD_REQUEST),
    OPTION_IS_CORRECT_INVALID(5302, "Must specify if this is the correct option", HttpStatus.BAD_REQUEST),

    OJ_PROBLEM_NOT_FOUND(6000, "Online judge problem not found", HttpStatus.NOT_FOUND),
    OJ_SUBMISSION_FAILED(6304, "Online judge submission failed", HttpStatus.BAD_GATEWAY),

    FILE_ASSIGNMENT_NOT_FOUND(7000, "File assignment not found", HttpStatus.NOT_FOUND),
    FILE_SUBMISSION_NOT_FOUND(7100, "File submission not found", HttpStatus.NOT_FOUND),

    COMMENT_NOT_FOUND(8000, "Comment not found", HttpStatus.NOT_FOUND),
    COURSE_REVIEW_ALREADY_EXISTS(8101, "User already reviewed this course", HttpStatus.CONFLICT),
    INVALID_COMMENT_LESSON(8102, "Invalid comment lesson", HttpStatus.BAD_REQUEST),

    CONTEST_NOT_FOUND(9000, "Contest not found", HttpStatus.NOT_FOUND),
    CONTEST_PASSWORD_INVALID(9003, "Contest password is invalid", HttpStatus.UNAUTHORIZED),
    CONTEST_NOT_JOINED(9202, "User has not joined this contest", HttpStatus.FORBIDDEN);

    private final int code;
    private final String message;
    private final HttpStatus httpStatus;

}