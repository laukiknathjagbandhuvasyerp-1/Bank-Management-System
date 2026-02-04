package org.example.bankmanagement.Repo;

import org.example.bankmanagement.Model.Loan;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LoanRepo extends JpaRepository<Loan,Long> {
    Page<Loan> findByCustomerCustId(long custId, Pageable pageable);

}
