package org.example.bankmanagement.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bankmanagement.Service.CustomerUserDetailsService;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;

@Component
public class JWTAuthenticationFilter extends OncePerRequestFilter {

    private final CustomerUserDetailsService customerUserDetailsService;
    private final JWTUtil jwtUtil;

    public JWTAuthenticationFilter(CustomerUserDetailsService customerUserDetailsService,JWTUtil jwtUtil){
        this.customerUserDetailsService=customerUserDetailsService;
        this.jwtUtil=jwtUtil;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");

        String username = null;
        String token = null;

        if(authHeader != null && authHeader.startsWith("Bearer ")){

            token = authHeader.substring(7);

            try{
                username = jwtUtil.extractUsername(token);
            }catch(Exception e){
                System.out.println("Invalid Token");
            }
        }


//        if(request.getCookies() !=null) {
//            for (Cookie cookie : request.getCookies()) {
//                if ("jwt".equals(cookie.getName())) {
//                    token = cookie.getValue();
//                    try{
//                        username = jwtUtil.extractUsername(token);
//                    } catch (Exception e) {
//                        System.out.println("Invalid JWT Token");
//                    }
//                }
//            }
//        }

        if(username!=null && SecurityContextHolder.getContext().getAuthentication() == null){

            UserDetails userDetails = customerUserDetailsService.loadUserByUsername(username);

            if(jwtUtil.validateToken(token,userDetails.getUsername())){

                UsernamePasswordAuthenticationToken authenticationToken =
                        new UsernamePasswordAuthenticationToken(userDetails,null,userDetails.getAuthorities());

                authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            }
        }

        filterChain.doFilter(request,response);

    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {

        String path = request.getServletPath();

        return path.equals("/login") ||
                path.equals("/signup") ||
                path.equals("/") ||
                path.startsWith("/css") ||
                path.equals("/customer/view") ||
                path.equals("/customer/new") ||
                path.startsWith("/js");
    }
}
