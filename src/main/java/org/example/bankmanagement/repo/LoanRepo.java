package org.example.bankmanagement.repo;

import org.example.bankmanagement.model.Loan;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LoanRepo extends JpaRepository<Loan,Long> {
    Page<Loan> findByCustomerCustId(long custId, Pageable pageable);

}
