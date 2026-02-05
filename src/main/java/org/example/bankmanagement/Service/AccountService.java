package org.example.bankmanagement.Service;

import org.example.bankmanagement.DTO.AccountResponseDTO;
import org.example.bankmanagement.DTO.PageResponseDTO;
import org.example.bankmanagement.Model.Account;
import org.example.bankmanagement.Model.Customer;
import org.springframework.data.domain.Page;

import java.util.List;

public interface AccountService {

    Account createAccount(long custId,Account account);

    PageResponseDTO<AccountResponseDTO> getAccountByCustomerId(long accNo, int page);
}
