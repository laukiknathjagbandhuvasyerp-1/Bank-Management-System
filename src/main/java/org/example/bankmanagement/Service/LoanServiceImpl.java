package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Model.EMI;
import org.example.bankmanagement.Model.Loan;
import org.example.bankmanagement.Repo.AccountRepo;
import org.example.bankmanagement.Repo.CustomerRepo;
import org.example.bankmanagement.Repo.LoanRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service

public class LoanServiceImpl implements LoanService{

    @Autowired
    private LoanRepo loanRepo;

    @Autowired
    private CustomerRepo customerRepo;

    @Autowired
    private EMIService emiService;

    @Override
    public void removeLoanByLoanId(long loanId) {
        loanRepo.deleteById(loanId);
    }

    @Override
    public Loan getLoanByLoanId(long loanId) {
        return loanRepo.findById(loanId).orElseThrow(()-> new RuntimeException("loan not found"));
    }

    @Override
    public Loan createLoan(long custId, Loan loan) {
        Customer customer = customerRepo.findById(custId).orElseThrow(()-> new RuntimeException("Customer not found"));

        if(customer.getAccounts()==null || customer.getAccounts().isEmpty()){
            throw new RuntimeException("Account not found for customer");
        }
        loan.setCustomer(customer);

        Loan saveloan =loanRepo.save(loan);

        emiService.genearateEmi(loan);

        return loanRepo.save(saveloan);
    }

    @Override
    public Page<Loan> getLoanDetailsofCustomerByCustomerId(long custId,int page) {
        int pageIndex = page- 1;
        Pageable pageable = PageRequest.of(pageIndex,10);
        return loanRepo.findByCustomerCustId(custId,pageable);
    }


}
