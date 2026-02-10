package org.example.bankmanagement.Repo;

import org.example.bankmanagement.DTO.CustomerRequestDTO;
import org.example.bankmanagement.Model.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CustomerRepo extends JpaRepository<Customer,Long> {

//    @Query("cust_add as custAdd",nativeQuery = true)
//    List<CustomerRequestDTO> findCustomerByIdAndName();
   // void findById(long custId);

}
