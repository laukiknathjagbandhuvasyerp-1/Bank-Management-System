package org.example.bankmanagement.Repo;

import org.example.bankmanagement.Model.EMI;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EMIRepo extends JpaRepository<EMI,Long> {
    Page<EMI> findByLoanLoanId(Long loanId, Pageable pageable);
    Page<EMI> findByLoanCustomerCustId(long custId,Pageable pageable);

}
