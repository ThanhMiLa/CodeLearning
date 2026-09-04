package com.thanhmila.codelearning.service.auth;

import io.github.bucket4j.BucketConfiguration;
import io.github.bucket4j.distributed.BucketProxy;
import io.github.bucket4j.distributed.proxy.RemoteBucketBuilder;
import io.github.bucket4j.redis.lettuce.cas.LettuceBasedProxyManager;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("RateLimitService Unit Tests")
class RateLimitServiceTest {

    @Mock
    private LettuceBasedProxyManager<byte[]> proxyManager;

    @InjectMocks
    private RateLimitService rateLimitService;

    @Mock
    private RemoteBucketBuilder<byte[]> remoteBucketBuilder;

    @Mock
    private BucketProxy bucket;

    @BeforeEach
    void setUp() {
        rateLimitService.init();
    }

    @Test
    @DisplayName("tryConsumeIp: Thành công khi chưa vượt quá limit IP (100 req/min)")
    void tryConsumeIp_Success() {
        when(proxyManager.builder()).thenReturn(remoteBucketBuilder);
        when(remoteBucketBuilder.build(eq("rate_limit:ip:127.0.0.1".getBytes()), any(BucketConfiguration.class)))
                .thenReturn(bucket);
        when(bucket.tryConsume(1)).thenReturn(true);

        boolean allowed = rateLimitService.tryConsumeIp("127.0.0.1");

        assertThat(allowed).isTrue();
    }

    @Test
    @DisplayName("tryConsumeIp: Bị từ chối khi vượt quá limit IP")
    void tryConsumeIp_RateLimited() {
        when(proxyManager.builder()).thenReturn(remoteBucketBuilder);
        when(remoteBucketBuilder.build(eq("rate_limit:ip:192.168.1.1".getBytes()), any(BucketConfiguration.class)))
                .thenReturn(bucket);
        when(bucket.tryConsume(1)).thenReturn(false);

        boolean allowed = rateLimitService.tryConsumeIp("192.168.1.1");

        assertThat(allowed).isFalse();
    }

    @Test
    @DisplayName("tryConsumeUser: Thành công khi chưa vượt quá limit User (10 req/s)")
    void tryConsumeUser_Success() {
        when(proxyManager.builder()).thenReturn(remoteBucketBuilder);
        when(remoteBucketBuilder.build(eq("rate_limit:user:user-123".getBytes()), any(BucketConfiguration.class)))
                .thenReturn(bucket);
        when(bucket.tryConsume(1)).thenReturn(true);

        boolean allowed = rateLimitService.tryConsumeUser("user-123");

        assertThat(allowed).isTrue();
    }

    @Test
    @DisplayName("tryConsumeUser: Bị từ chối khi vượt quá limit User")
    void tryConsumeUser_RateLimited() {
        when(proxyManager.builder()).thenReturn(remoteBucketBuilder);
        when(remoteBucketBuilder.build(eq("rate_limit:user:user-456".getBytes()), any(BucketConfiguration.class)))
                .thenReturn(bucket);
        when(bucket.tryConsume(1)).thenReturn(false);

        boolean allowed = rateLimitService.tryConsumeUser("user-456");

        assertThat(allowed).isFalse();
    }
}
