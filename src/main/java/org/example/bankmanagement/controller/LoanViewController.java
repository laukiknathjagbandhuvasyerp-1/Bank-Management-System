package org.example.bankmanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/loan")
public class LoanViewController {

    @GetMapping("/new/{custId}")
    public String openAddLoan(@PathVariable long custId , Model model){
        model.addAttribute("custId",custId);
        return "addLoan";
    }

    @GetMapping("/emi/view/{loanId}")
    public String openEmiPage(@PathVariable long loanId, Model model) {
        model.addAttribute("loanId", loanId);
        return "emiList";
    }
}
