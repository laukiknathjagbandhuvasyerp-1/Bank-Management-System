package org.example.bankmanagement.Repo;

import org.example.bankmanagement.Model.Account;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountRepo extends JpaRepository<Account,Long> {

}
