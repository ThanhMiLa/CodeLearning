package com.thanhmila.codelearning.service.payment.client;

public interface PayOsClient {

    PayOsCreatePaymentResponse createPaymentLink(PayOsCreatePaymentRequest request);

    PayOsPaymentInfo getPaymentInformation(String transactionCode);

    PayOsPaymentInfo cancelPaymentLink(String transactionCode, String cancellationReason);
}
