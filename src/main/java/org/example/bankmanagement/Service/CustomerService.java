package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Customer;
import org.springframework.data.domain.Page;

import java.util.List;

public interface CustomerService {

    List<Customer> addNewCustomer(List<Customer> customer);

    void deleteCustomer(long custId);

    Customer updateCustomer(long custId,Customer customer);

    Page<Customer> getAllCustomers(int page);
}
