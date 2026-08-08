package com.thanhmila.codelearning.configuration;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.CustomExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.beans.factory.annotation.Qualifier;
import java.util.HashMap;
import java.util.Map;

@Configuration
public class RabbitMQConfig {

    public static final String CONTEST_EXCHANGE = "contest.exchange";
    public static final String CONTEST_QUEUE = "contest.queue";
    public static final String ROUTING_KEY_RUNNING = "contest.status.running";
    public static final String ROUTING_KEY_ENDED = "contest.status.ended";

    public static final String EMAIL_EXCHANGE = "email.exchange";
    public static final String BULK_EMAIL_QUEUE = "bulk.email.queue";
    public static final String EMAIL_DLQ_QUEUE = "email.dlq.queue";
    public static final String ROUTING_KEY_BULK_EMAIL = "email.bulk";
    public static final String ROUTING_KEY_EMAIL_DLQ = "email.dlq";

    @Bean
    public CustomExchange contestExchange() {
        Map<String, Object> args = new HashMap<>();
        args.put("x-delayed-type", "direct");
        return new CustomExchange(CONTEST_EXCHANGE, "x-delayed-message", true, false, args);
    }

    @Bean
    public Queue contestQueue() {
        return new Queue(CONTEST_QUEUE, true);
    }

    @Bean
    public Binding bindingRunning(@Qualifier("contestQueue") Queue contestQueue, @Qualifier("contestExchange") CustomExchange contestExchange) {
        return BindingBuilder.bind(contestQueue).to(contestExchange).with(ROUTING_KEY_RUNNING).noargs();
    }

    @Bean
    public Binding bindingEnded(@Qualifier("contestQueue") Queue contestQueue, @Qualifier("contestExchange") CustomExchange contestExchange) {
        return BindingBuilder.bind(contestQueue).to(contestExchange).with(ROUTING_KEY_ENDED).noargs();
    }

    @Bean
    public CustomExchange emailExchange() {
        Map<String, Object> args = new HashMap<>();
        args.put("x-delayed-type", "direct");
        return new CustomExchange(EMAIL_EXCHANGE, "x-delayed-message", true, false, args);
    }

    @Bean
    public Queue bulkEmailQueue() {
        return new Queue(BULK_EMAIL_QUEUE, true);
    }

    @Bean
    public Queue emailDlq() {
        return new Queue(EMAIL_DLQ_QUEUE, true);
    }

    @Bean
    public Binding bindingBulkEmail(@Qualifier("bulkEmailQueue") Queue bulkEmailQueue, @Qualifier("emailExchange") CustomExchange emailExchange) {
        return BindingBuilder.bind(bulkEmailQueue).to(emailExchange).with(ROUTING_KEY_BULK_EMAIL).noargs();
    }

    @Bean
    public Binding bindingEmailDlq(@Qualifier("emailDlq") Queue emailDlq, @Qualifier("emailExchange") CustomExchange emailExchange) {
        return BindingBuilder.bind(emailDlq).to(emailExchange).with(ROUTING_KEY_EMAIL_DLQ).noargs();
    }

    @Bean
    public MessageConverter jsonMessageConverter() {
        return new Jackson2JsonMessageConverter();
    }
}
