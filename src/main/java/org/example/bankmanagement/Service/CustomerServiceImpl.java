package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Repo.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService{

    private final CustomerRepo customerRepo;

    public CustomerServiceImpl(CustomerRepo customerRepo){
        this.customerRepo=customerRepo;
    }

    @Override
    public List<Customer> addNewCustomer(List<Customer> customer) {
        return customerRepo.saveAll(customer);
    }

    @Override
    public List<Customer> getCustomerList(Customer customer) {
        List<Customer> customerList = customerRepo.findAll();
        return customerList;
    }

    @Override
    public void deleteCustomer(long custId) {
        customerRepo.deleteById(custId);
    }

        @Override
        public Customer updateCustomer(long custId,Customer customer) {
            Customer updatedCustomer = customerRepo.findById(custId).orElseThrow(()->
                    new RuntimeException("Customer Id not found"));
                updatedCustomer.setCustName(customer.getCustName());
                updatedCustomer.setCustAdd(customer.getCustAdd());
            return  customerRepo.save(updatedCustomer);

        }
}
