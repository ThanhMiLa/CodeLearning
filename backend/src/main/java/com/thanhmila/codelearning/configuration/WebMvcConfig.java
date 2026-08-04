package com.thanhmila.codelearning.configuration;

import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@RequiredArgsConstructor
public class WebMvcConfig implements WebMvcConfigurer {

    private final UserRateLimitInterceptor userRateLimitInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(userRateLimitInterceptor)
                .addPathPatterns("/**") 
                .excludePathPatterns("/auth/**", "/public/**"); 
    }
}
