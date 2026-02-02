package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.EMI;
import org.example.bankmanagement.Model.Loan;

import java.util.List;

public interface EMIService {

    void genearateEmi(Loan loan);

    String payEmi(long emiId);

    List<EMI> getAllEmiByLoanId(long loanId);

    List<EMI> getAllEmiByCustId(long custId);




}
