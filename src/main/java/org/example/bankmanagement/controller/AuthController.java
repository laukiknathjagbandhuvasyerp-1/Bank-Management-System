package org.example.bankmanagement.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.bankmanagement.DTO.AuthRequestDTO;
import org.example.bankmanagement.DTO.AuthResponseDTO;
import org.example.bankmanagement.Service.AuthServiceImpl;
import org.example.bankmanagement.Service.CustomerUserDetailsService;
import org.example.bankmanagement.security.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private CustomerUserDetailsService customerUserDetailsService;

    @Autowired
    private AuthServiceImpl authService;

    @Autowired
    private JWTUtil jwtUtil;

    @GetMapping("/login")
    public String loginPage(){
       return "login";
    }

    @GetMapping("/signup")
    public String signupPage(){
        return "signup";
    }

    @PostMapping("/signup")
    public String register(@RequestParam String userName , @RequestParam String password){
        customerUserDetailsService.registerUser(userName,password);
        return "redirect:/login";
    }

    @PostMapping("/login")
    public String loginPage(AuthRequestDTO authRequestDTO,@RequestParam(required = false) String redirect, HttpServletResponse httpServletResponse){
        try{
            AuthResponseDTO authResponseDTO = authService.authenticateUserAndGenerateTokens(authRequestDTO);

            Cookie jwtCookie = new Cookie("jwt",authResponseDTO.getToken());
            jwtCookie.setHttpOnly(true);
            jwtCookie.setPath("/");
            jwtCookie.setMaxAge(60*60);

            httpServletResponse.addCookie(jwtCookie);


            if(redirect!= null && !redirect.isEmpty()){
                return "redirect:" +redirect;
            }

            return "redirect:/customer/view";

        } catch (Exception e) {
            return "redirect:/login?error=true";
        }

    }


}
