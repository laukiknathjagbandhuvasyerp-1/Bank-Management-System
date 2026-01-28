package org.example.bankmanagement.Repo;

import org.example.bankmanagement.Model.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepo extends JpaRepository<Customer,Long> {

}
