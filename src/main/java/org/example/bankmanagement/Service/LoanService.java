package org.example.bankmanagement.Service;

import org.example.bankmanagement.model.Loan;
import org.springframework.data.domain.Page;

public interface LoanService {

    Loan createLoan(long custId,Loan loan);

   Page<Loan> getLoanDetailsofCustomerByCustomerId(long custId,int page);

   Loan getLoanByLoanId(long loanId);

   void removeLoanByLoanId(long loanId);
}
