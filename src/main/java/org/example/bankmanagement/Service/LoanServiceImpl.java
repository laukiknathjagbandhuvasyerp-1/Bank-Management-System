package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Model.EMI;
import org.example.bankmanagement.Model.Loan;
import org.example.bankmanagement.Repo.AccountRepo;
import org.example.bankmanagement.Repo.CustomerRepo;
import org.example.bankmanagement.Repo.LoanRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service

public class LoanServiceImpl implements LoanService{

    @Autowired
    private LoanRepo loanRepo;

    @Autowired
    private AccountRepo accountRepo;

    @Autowired
    private CustomerRepo customerRepo;

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

        generateEmi(saveloan);

        return loanRepo.save(saveloan);
    }

    @Override
    public List<Loan> getLoanDetailsofCustomer(long custId) {
        Customer customer = customerRepo.findById(custId).orElseThrow(()-> new RuntimeException("customer not found"));
        return customer.getLoans();
    }

    private void generateEmi(Loan loan){

        double P =loan.getLoanAmount();
        double annualRate = loan.getLoanRate();
        int n = loan.getLoanTenure();

        double R =  annualRate/12/100;
        double emiAmount = (P*R*Math.pow(1+R,n))  /  (Math.pow(1+R,n)-1);

        List<EMI> emiList =new ArrayList<>();

        for(int i=1;i<n;i++){
            EMI emi= new EMI();
            emi.setEmiAmount(emiAmount);
            emi.setEmiDueDate(LocalDate.now().plusMonths(i));
            emi.setPaid(false);
            emi.setLoan(loan);
            emiList.add(emi);
        }

        loan.setEmi(emiList);
    }

}
