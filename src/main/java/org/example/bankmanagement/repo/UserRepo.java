package org.example.bankmanagement.repo;

import org.example.bankmanagement.model.Userdb;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepo extends JpaRepository<Userdb,Long> {
    Optional<Userdb> findByUserName(String userName);
}
