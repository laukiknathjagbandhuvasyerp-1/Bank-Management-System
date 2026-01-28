package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Account;
import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Repo.AccountRepo;
import org.example.bankmanagement.Repo.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service

public class AccoutnServiceImpl implements  AccountService {

    @Autowired
    private CustomerRepo customerRepo;

    private AccountRepo accountRepo;

    public AccoutnServiceImpl(AccountRepo accountRepo){
        this.accountRepo=accountRepo;
    }

    @Override
    public Account createAccount(long custId,Account account) {
       Customer customer = customerRepo.findById(custId).orElseThrow(()-> new RuntimeException("no customer found"));
       account.setCustomer(customer);
       return accountRepo.save(account);
    }

    @Override
    public List<Account> getAccountByCustomerId(long custId) {
        Customer customer= customerRepo.findById(custId).orElseThrow(()->new RuntimeException("not found"));
        return customer.getAccounts();
    }

}
