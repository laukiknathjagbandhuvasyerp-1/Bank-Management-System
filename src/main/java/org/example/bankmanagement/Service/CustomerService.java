package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Customer;

import java.util.List;

public interface CustomerService {

    List<Customer> addNewCustomer(List<Customer> customer);

    List<Customer> getCustomerList(Customer customer);

    void deleteCustomer(long custId);

    Customer updateCustomer(long custId,Customer customer);
}
