package org.example.bankmanagement.repo;

import org.example.bankmanagement.model.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepo extends JpaRepository<Customer,Long> {

//    @Query("cust_add as custAdd",nativeQuery = true)
//    List<CustomerRequestDTO> findCustomerByIdAndName();
   // void findById(long custId);

}
