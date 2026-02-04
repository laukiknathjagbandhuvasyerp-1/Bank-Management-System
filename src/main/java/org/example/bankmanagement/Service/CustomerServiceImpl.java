package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Repo.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
    public Page<Customer> getAllCustomers(int page){
        int pageIndex=page-1;
        Pageable pageable = PageRequest.of(pageIndex,10, Sort.by("custId").ascending());
        return customerRepo.findAll(pageable);
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
