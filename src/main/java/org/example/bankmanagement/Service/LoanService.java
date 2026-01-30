package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Loan;

import java.util.List;

public interface LoanService {

    Loan createLoan(long custId,Loan loan);

   List<Loan> getLoanDetailsofCustomer(long custId);

   Loan getLoanByLoanId(long loanId);

   void removeLoanByLoanId(long loanId);
}
