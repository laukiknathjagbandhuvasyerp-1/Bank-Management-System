package org.example.bankmanagement.config;

import org.example.bankmanagement.security.JWTAuthenticationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final JWTAuthenticationFilter jwtAuthenticationFilter;

    public SecurityConfig(JWTAuthenticationFilter jwtAuthenticationFilter) {
        this.jwtAuthenticationFilter = jwtAuthenticationFilter;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
                .csrf(csrf -> csrf.disable()
                )
                .sessionManagement(session ->
                        session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/", "/login", "/signup/**","/WEB-INF/**","/css/**","/js/**").permitAll()
                        .requestMatchers("/customer/view").permitAll()
                        .requestMatchers("/customer/new").permitAll()
                        .requestMatchers("/customer/profile/**").permitAll()
                        .requestMatchers("/customer/edit/**").permitAll()
                        .requestMatchers("/customer/accounts/**").permitAll()
                        .requestMatchers("/customer/loans/**").permitAll()
                        .requestMatchers("/account/new/**").permitAll()
                        .requestMatchers("/loan/new/**").permitAll()
                        .requestMatchers("/loan/emi/view/**").permitAll()

                        .requestMatchers("/customer/ajax/**").authenticated()
                        .requestMatchers("/customer/add").authenticated()
                        .requestMatchers("/customer/delete/**").authenticated()
                        .requestMatchers("/customer/update/**").authenticated()
                        .requestMatchers("/account/customer/**").authenticated()
                        .requestMatchers("/loan/customer/**").authenticated()
                        .requestMatchers("/loan/details/**").authenticated()
                        .requestMatchers("/loan/delete/**").authenticated()
                        .requestMatchers("/loan/emi/**").authenticated()

                        .anyRequest().authenticated()

                )
                .addFilterBefore(jwtAuthenticationFilter,
                        UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(
            AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }


}