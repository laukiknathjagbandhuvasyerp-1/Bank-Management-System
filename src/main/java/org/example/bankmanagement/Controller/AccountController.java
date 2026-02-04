package org.example.bankmanagement.Controller;

import org.example.bankmanagement.Model.Account;
import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Service.AccountService;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/account")
class AccountController {

    private final AccountService accountService;

    public AccountController(AccountService accountService){
        this.accountService=accountService;
    }

    @PostMapping("/customer/{custId}")
    public Account createCustomerAccount(@PathVariable long custId,@RequestBody Account account){
        return accountService.createAccount(custId,account);
    }

    @PostMapping("/customer/view/{custId}")
    public Page<Account> getAccountsDetailByCustomerId(@PathVariable long custId, @RequestParam int page){
        return accountService.getAccountByCustomerId(custId,page);
    }




}
