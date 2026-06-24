package com.thanhmila.codelearning.configuration;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.CustomExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class RabbitMQConfig {

    public static final String CONTEST_EXCHANGE = "contest.exchange";
    public static final String CONTEST_QUEUE = "contest.queue";
    public static final String ROUTING_KEY_RUNNING = "contest.status.running";
    public static final String ROUTING_KEY_ENDED = "contest.status.ended";

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
    public Binding bindingRunning(Queue contestQueue, CustomExchange contestExchange) {
        return BindingBuilder.bind(contestQueue).to(contestExchange).with(ROUTING_KEY_RUNNING).noargs();
    }

    @Bean
    public Binding bindingEnded(Queue contestQueue, CustomExchange contestExchange) {
        return BindingBuilder.bind(contestQueue).to(contestExchange).with(ROUTING_KEY_ENDED).noargs();
    }

    @Bean
    public MessageConverter jsonMessageConverter() {
        return new Jackson2JsonMessageConverter();
    }
}
