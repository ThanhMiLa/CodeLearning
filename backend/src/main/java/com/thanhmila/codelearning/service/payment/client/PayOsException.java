package com.thanhmila.codelearning.service.payment.client;

import lombok.Getter;

@Getter
public class PayOsException extends RuntimeException {

    private final PayOsErrorType errorType;
    private final String errorCode;

    public PayOsException(PayOsErrorType errorType, String message) {
        super(message);
        this.errorType = errorType;
        this.errorCode = null;
    }

    public PayOsException(PayOsErrorType errorType, String errorCode, String message) {
        super(message);
        this.errorType = errorType;
        this.errorCode = errorCode;
    }

    public PayOsException(PayOsErrorType errorType, String message, Throwable cause) {
        super(message, cause);
        this.errorType = errorType;
        this.errorCode = null;
    }

    public PayOsException(PayOsErrorType errorType, String errorCode, String message, Throwable cause) {
        super(message, cause);
        this.errorType = errorType;
        this.errorCode = errorCode;
    }
}
