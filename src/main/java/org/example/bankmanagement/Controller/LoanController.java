package org.example.bankmanagement.Controller;

import org.example.bankmanagement.Model.EMI;
import org.example.bankmanagement.Model.Loan;
import org.example.bankmanagement.Service.EMIService;
import org.example.bankmanagement.Service.LoanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    public List<Loan> getLoanDetailsByCustId(@PathVariable long custId){
        return loanService.getLoanDetailsofCustomer(custId);
    }

    @PostMapping("/loandetails/{loanId}")
    public Loan getDetailsOfLoanById(@PathVariable long loanId){
        return loanService.getLoanByLoanId(loanId);
    }

    @PostMapping("/delete/{loanId}")
    public void removeLoanById(@PathVariable long loanId){
        loanService.removeLoanByLoanId(loanId);
    }

    @PostMapping("/emi/loanid/{loanId}")
    public List<EMI> getAllEmiByLoanId(@PathVariable long loanId){
        return emiService.getAllEmiByLoanId(loanId);
    }

    @PostMapping("/emi/custmoerid/{custId}")
    public List<EMI> getAllEmiByCustId(@PathVariable long custId){
        return emiService.getAllEmiByCustId(custId);
    }

    @PostMapping("/emi/pay/{emiId}")
    public String payEmi(@PathVariable  long emiId){
        return emiService.payEmi(emiId);
    }



}
