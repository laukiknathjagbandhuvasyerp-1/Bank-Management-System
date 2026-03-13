package org.example.bankmanagement.Service;

import org.example.bankmanagement.dto.AccountResponseDTO;
import org.example.bankmanagement.dto.PageResponseDTO;
import org.example.bankmanagement.model.Account;

public interface AccountService {

    Account createAccount(long custId,Account account);

    PageResponseDTO<AccountResponseDTO> getAccountByCustomerId(long accNo, int page);
}
