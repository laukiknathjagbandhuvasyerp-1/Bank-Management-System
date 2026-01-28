package org.example.bankmanagement.Controller;

import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Service.CustomerService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/customer")
class CustomerController {

    private final CustomerService customerService;

    public CustomerController(CustomerService customerService){
        this.customerService=customerService;
    }

    @PostMapping("/add")
    public List<Customer> createNewCustomer(@RequestBody  List<Customer> customer){
        return customerService.addNewCustomer(customer);
    }

    @PostMapping("/view")
    public List<Customer> getCustomerDetails(Customer customer){
        return customerService.getCustomerList(customer);
    }

    @PostMapping("/delete/{custId}")
    public void deleteCustomerById(@PathVariable long custId){
        customerService.deleteCustomer(custId);
    }

    @PostMapping("/update/{custId}")
    public Customer updateCustomerDetailsById(@PathVariable  long custId , @RequestBody  Customer customer){
        return customerService.updateCustomer(custId,customer);
    }

}
