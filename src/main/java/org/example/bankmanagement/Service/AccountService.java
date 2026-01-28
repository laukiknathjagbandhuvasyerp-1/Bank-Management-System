package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Account;
import org.example.bankmanagement.Model.Customer;

import java.util.List;

public interface AccountService {

    Account createAccount(long custId,Account account);

    List<Account> getAccountByCustomerId(long accNo);
}
