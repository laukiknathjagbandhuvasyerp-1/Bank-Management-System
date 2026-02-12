package org.example.bankmanagement.Repo;

import org.example.bankmanagement.Model.Userdb;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepo extends JpaRepository<Userdb,Long> {
    Optional<Userdb> findByUserName(String userName);
}
