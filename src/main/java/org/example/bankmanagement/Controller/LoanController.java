package org.example.bankmanagement.Controller;

import org.example.bankmanagement.Model.Loan;
import org.example.bankmanagement.Service.LoanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/loan")
class LoanController {

    @Autowired
    private LoanService loanService;

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

}
