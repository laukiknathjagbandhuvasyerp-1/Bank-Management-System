package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Account;
import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Model.EMI;
import org.example.bankmanagement.Model.Loan;
import org.example.bankmanagement.Repo.AccountRepo;
import org.example.bankmanagement.Repo.EMIRepo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service

public class EMIServiceImpl implements EMIService {

    private final EMIRepo eMIRepo;
    private final AccountRepo accountRepo;

    public EMIServiceImpl(EMIRepo eMIRepo, AccountRepo accountRepo) {
        this.eMIRepo = eMIRepo;
        this.accountRepo = accountRepo;
    }

    @Override
    public void generateEmi(Loan loan) {

        double P = loan.getLoanAmount();
        double annualRate = loan.getLoanRate();
        int n = loan.getLoanTenure();

        double R = annualRate/12/100;
        double emiAmount =  (P * R * Math.pow(1+R,n)) / (Math.pow(1+R,n)-1);

        List<EMI> emiList = new ArrayList<>();

        for(int i=1;i<=n;i++){
            EMI emi = new EMI();
            emi.setEmiAmount(emiAmount);
            emi.setEmiDueDate(LocalDate.now().plusMonths(i));
            emi.setPaid(false);
            emi.setLoan(loan);
            emiList.add(emi);
        }
        loan.setEmi(emiList);
    }

    @Transactional
    @Override
    public String payEmi(long emiId) {
        EMI emi =eMIRepo.findById(emiId).orElseThrow(()->new RuntimeException("EMI not found"));

        Loan loan=emi.getLoan();
        Account account = loan.getCustomer().getAccounts().get(0);

        double emiAmount=emi.getEmiAmount();
        double accBalance=account.getAccBalance();

        if(accBalance - emiAmount < 2000){
            throw new RuntimeException("Insufficient balance as account balance must be 2000");
        }

        account.setAccBalance(account.getAccBalance()-emi.getEmiAmount());

        emi.setPaid(true);
        emi.setPaidDare(LocalDate.now());

        accountRepo.save(account);
        eMIRepo.save(emi);

        return "EMI paid success";
    }

    @Override
    public List<EMI> getAllEmiByLoanId(long loanId) {
        return eMIRepo.findByLoanLoanId(loanId);
    }

    @Override
    public List<EMI> getAllEmiByCustId(long custId){
        return eMIRepo.findByLoanCustomerCustId(custId);
    }

}
