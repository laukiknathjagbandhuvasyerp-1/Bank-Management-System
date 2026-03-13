package org.example.bankmanagement.Service;

import org.example.bankmanagement.dto.AccountResponseDTO;
import org.example.bankmanagement.dto.PageResponseDTO;
import org.example.bankmanagement.mapper.PageResponseMapper;
import org.example.bankmanagement.model.Account;
import org.example.bankmanagement.model.Customer;
import org.example.bankmanagement.repo.AccountRepo;
import org.example.bankmanagement.repo.CustomerRepo;
import org.example.bankmanagement.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service

public class AccoutnServiceImpl implements  AccountService {

    private static final int PAGE_SIZE=10;

    @Autowired
    private CustomerRepo customerRepo;

    private AccountRepo accountRepo;

    public AccoutnServiceImpl(AccountRepo accountRepo){
        this.accountRepo=accountRepo;
    }

    @Override
    public Account createAccount(long custId,Account account) {
       Customer customer = customerRepo.findById(custId).orElseThrow(()-> new ResourceNotFoundException("no customer found"));
       account.setCustomer(customer);
       return accountRepo.save(account);
    }

    @Override
    public PageResponseDTO<AccountResponseDTO> getAccountByCustomerId(long custId, int page) {
        int pageIndex =page-1;
        Pageable pageable = PageRequest.of(pageIndex,PAGE_SIZE);
        Page<Account> accountPage =accountRepo.findByCustomerCustId(custId,pageable);

        return PageResponseMapper.mapPage(accountPage,a->{
            AccountResponseDTO response = new AccountResponseDTO();
            response.setAccBalance(a.getAccBalance());
            response.setAccNo(a.getAccNo());
            response.setAccType(a.getAccType());
            return response;
        });
    }

}
