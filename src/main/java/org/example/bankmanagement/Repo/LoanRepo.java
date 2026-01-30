package org.example.bankmanagement.Repo;

import org.example.bankmanagement.Model.Loan;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LoanRepo extends JpaRepository<Loan,Long> {

}
