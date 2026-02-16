package org.example.bankmanagement.controller;

import org.example.bankmanagement.Service.CustomerUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private CustomerUserDetailsService customerUserDetailsService;

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


}
