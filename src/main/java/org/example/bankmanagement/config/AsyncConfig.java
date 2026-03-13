package org.example.bankmanagement.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;
import java.util.concurrent.ThreadPoolExecutor;

@Configuration
public class AsyncConfig {

    @Bean("asyncTaskExecutor")
    public Executor asyncTaskExecutor() {
        ThreadPoolTaskExecutor poolExecutor = new ThreadPoolTaskExecutor();
        poolExecutor.setCorePoolSize(4);
        poolExecutor.setQueueCapacity(150);
        poolExecutor.setMaxPoolSize(4);
        poolExecutor.setThreadNamePrefix("Async Thread - ");
        poolExecutor.initialize();

        return poolExecutor;

    }
}
