package org.example.bankmanagement.controller;

import org.example.bankmanagement.DTO.EMIResponseDTO;
import org.example.bankmanagement.DTO.PageResponseDTO;
import org.example.bankmanagement.Model.Loan;
import org.example.bankmanagement.Service.EMIService;
import org.example.bankmanagement.Service.LoanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/loan")
class LoanController {

    @Autowired
    private LoanService loanService;

    @Autowired
    private EMIService emiService;

    @PostMapping("/customer/{custId}")
    public Loan createLoan(@PathVariable long custId, @RequestBody Loan loan){
        return loanService.createLoan(custId,loan);
    }

    @PostMapping("/details/{custId}")
    public Page<Loan> getLoanDetailsByCustId(@PathVariable long custId, @RequestParam int page){
        return loanService.getLoanDetailsofCustomerByCustomerId(custId,page);
    }

    @PostMapping("/loandetails/{loanId}")
    public Loan getDetailsOfLoanById(@PathVariable long loanId){
        return loanService.getLoanByLoanId(loanId);
    }

    @PostMapping("/delete/{loanId}")
    public void removeLoanById(@PathVariable long loanId){
        loanService.removeLoanByLoanId(loanId);
    }

    @GetMapping("/emi/loan/{loanId}")
    public PageResponseDTO<EMIResponseDTO> getAllEmiByLoanId(@PathVariable long loanId,
                                                             @RequestParam int page){
        return emiService.getAllEmiByLoanId(loanId,page);
    }

    @GetMapping("/emi/customer/{custId}")
    public PageResponseDTO<EMIResponseDTO> getAllEmiByCustId(@PathVariable long custId,
                                                             @RequestParam int page){
        return emiService.getAllEmiByCustId(custId,page);
    }

    @PostMapping("/emi/pay/{emiId}")
    public String payEmi(@PathVariable  long emiId){
        return emiService.payEmi(emiId);
    }



}
