package org.example.bankmanagement.Service;

import org.example.bankmanagement.DTO.EMIResponseDTO;
import org.example.bankmanagement.DTO.PageResponseDTO;
import org.example.bankmanagement.Model.EMI;
import org.example.bankmanagement.Model.Loan;

import java.util.List;

public interface EMIService {

    void generateEmi(Loan loan);

    String payEmi(long emiId);

    PageResponseDTO<EMIResponseDTO> getAllEmiByLoanId(long loanId,int page);

    PageResponseDTO<EMIResponseDTO> getAllEmiByCustId(long custId,int page);

}
