package org.example.bankmanagement.Service;

import org.example.bankmanagement.dto.EMIResponseDTO;
import org.example.bankmanagement.dto.PageResponseDTO;
import org.example.bankmanagement.model.Loan;

public interface EMIService {

    void generateEmi(Loan loan);

    String payEmi(long emiId);

    PageResponseDTO<EMIResponseDTO> getAllEmiByLoanId(long loanId,int page);

    PageResponseDTO<EMIResponseDTO> getAllEmiByCustId(long custId,int page);

}
