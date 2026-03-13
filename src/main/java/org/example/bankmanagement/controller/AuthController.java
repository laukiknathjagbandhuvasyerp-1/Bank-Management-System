package org.example.bankmanagement.controller;

import org.example.bankmanagement.dto.AuthRequestDTO;
import org.example.bankmanagement.dto.AuthResponseDTO;
import org.example.bankmanagement.Service.AuthServiceImpl;
import org.example.bankmanagement.Service.CustomerUserDetailsService;
import org.example.bankmanagement.security.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
    @ResponseBody
    public ResponseEntity<AuthResponseDTO> loginPage(@RequestBody AuthRequestDTO authRequestDTO){
            AuthResponseDTO response = authService.authenticateUserAndGenerateTokens(authRequestDTO);
            return ResponseEntity.ok(response);
    }

}
