package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Account;
import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Repo.AccountRepo;
import org.example.bankmanagement.Repo.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
    public Page<Account> getAccountByCustomerId(long custId,int page) {
        int pageIndex =page-1;
        Pageable pageable = PageRequest.of(pageIndex,10);
        return accountRepo.findByCustomerCustId(custId,pageable);
    }

}
