package org.example.bankmanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/account")
public class AccountViewController {

    @GetMapping("/new/{custId}")
    public String openAddAccount(@PathVariable long custId, Model model){
        model.addAttribute("custId" , custId);
        return "addAccount";
    }

}
