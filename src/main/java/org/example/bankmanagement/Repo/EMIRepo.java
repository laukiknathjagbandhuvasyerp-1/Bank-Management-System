package org.example.bankmanagement.Repo;

import org.example.bankmanagement.Model.EMI;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EMIRepo extends JpaRepository<EMI,Long> {
    List<EMI> findByLoanLoanId(Long loanId);
}
