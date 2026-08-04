package com.thanhmila.codelearning.service;

import io.github.bucket4j.BucketConfiguration;
import io.github.bucket4j.redis.lettuce.cas.LettuceBasedProxyManager;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
@RequiredArgsConstructor
public class RateLimitService {

    private final LettuceBasedProxyManager<byte[]> proxyManager;

    private BucketConfiguration ipConfiguration;
    private BucketConfiguration userConfiguration;

    @PostConstruct
    public void init() {
        // IP limit: 100 requests per 1 minute
        ipConfiguration = BucketConfiguration.builder()
                .addLimit(limit -> limit.capacity(100).refillGreedy(100, Duration.ofMinutes(1)))
                .build();

        // User limit: 10 requests per 1 second
        userConfiguration = BucketConfiguration.builder()
                .addLimit(limit -> limit.capacity(10).refillGreedy(10, Duration.ofSeconds(1)))
                .build();
    }

    public boolean tryConsumeIp(String ip) {
        String key = "rate_limit:ip:" + ip;
        return proxyManager.builder().build(key.getBytes(), ipConfiguration).tryConsume(1);
    }

    public boolean tryConsumeUser(String userId) {
        String key = "rate_limit:user:" + userId;
        return proxyManager.builder().build(key.getBytes(), userConfiguration).tryConsume(1);
    }
}
