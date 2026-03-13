package org.example.bankmanagement.repo;

import org.example.bankmanagement.model.EMI;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EMIRepo extends JpaRepository<EMI,Long> {
    Page<EMI> findByLoanLoanId(Long loanId, Pageable pageable);
    Page<EMI> findByLoanCustomerCustId(long custId,Pageable pageable);

}
