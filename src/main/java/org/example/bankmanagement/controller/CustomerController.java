package org.example.bankmanagement.controller;

import org.example.bankmanagement.DTO.CustomerRequestDTO;
import org.example.bankmanagement.DTO.CustomerResponseDTO;
import org.example.bankmanagement.DTO.PageResponseDTO;
import org.example.bankmanagement.Service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/customer")
class CustomerController {

    private final CustomerService customerService;

    public CustomerController(CustomerService customerService){
        this.customerService=customerService;
    }

    @PostMapping("/add")
    public String createNewCustomer(@ModelAttribute  CustomerRequestDTO customerRequestDTO){
        customerService.addNewCustomer(customerRequestDTO);
        return "addCustomer";
    }

    @PostMapping("/delete/{custId}")
    public void deleteCustomerById(@PathVariable long custId){
        customerService.deleteCustomer(custId);
    }

    @PostMapping("/update/{custId}")
    public CustomerResponseDTO updateCustomerDetailsById(@PathVariable  long custId ,
                                                         @RequestBody  CustomerRequestDTO customerRequestDTO){
        return customerService.updateCustomer(custId,customerRequestDTO);
    }

    @GetMapping("/view")
    public PageResponseDTO<CustomerResponseDTO> getCustomer(@RequestParam(defaultValue = "1") int page){
        return customerService.getAllCustomers(page);
    }


}
