package org.example.bankmanagement.Service;

import org.example.bankmanagement.DTO.CustomerRequestDTO;
import org.example.bankmanagement.DTO.CustomerResponseDTO;
import org.example.bankmanagement.DTO.PageResponseDTO;
import org.example.bankmanagement.Mapper.PageResponseMapper;
import org.example.bankmanagement.Model.Customer;
import org.example.bankmanagement.Repo.CustomerRepo;
import org.example.bankmanagement.exception.ResourceNotFoundException;
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

    private static final int pageSize=10;

    public CustomerServiceImpl(CustomerRepo customerRepo){
        this.customerRepo=customerRepo;
    }

    @Override
    public CustomerResponseDTO addNewCustomer(CustomerRequestDTO customerRequestDTO) {

            Customer c =new Customer();
            c.setCustName(customerRequestDTO.getCustName());
            c.setCustAdd(customerRequestDTO.getCustAdd());

            Customer savedCustomer = customerRepo.save(c);

            CustomerResponseDTO responseDTO = new CustomerResponseDTO();
            responseDTO.setCustId(savedCustomer.getCustId());
            responseDTO.setCustName(savedCustomer.getCustName());
            responseDTO.setCustAdd(savedCustomer.getCustAdd());
            return responseDTO;

    }

    @Override
    public PageResponseDTO<CustomerResponseDTO> getAllCustomers(int page){
        if(page<1){
            page=1;
        }
        int pageIndex=page-1;
        Pageable pageable = PageRequest.of(pageIndex,pageSize, Sort.by("custId").ascending());

        Page<Customer> customerPage= customerRepo.findAll(pageable);

            return PageResponseMapper.mapPage(customerPage,c ->{
                 CustomerResponseDTO dto = new CustomerResponseDTO();
                 dto.setCustId(c.getCustId());
                 dto.setCustName(c.getCustName());
                 dto.setCustAdd(c.getCustAdd());
                 return dto;
                }
            );
    }

    @Override
    public void deleteCustomer(long custId) {
        Customer customer = customerRepo.findById(custId).orElseThrow(()-> new ResourceNotFoundException("Id not found"));
        customerRepo.delete(customer);
    }

    @Override
    public void updateCustomer(long custId,CustomerRequestDTO customerRequestDTO) {

        Customer customer = customerRepo.findById(custId).orElseThrow(()->
        new ResourceNotFoundException("Customer Id not found"));

        customer.setCustName(customerRequestDTO.getCustName());
        customer.setCustAdd(customerRequestDTO.getCustAdd());

        customerRepo.save(customer);
    }

    @Override
    public CustomerResponseDTO findCustomerById(long custId) {
        Customer customer = customerRepo.findById(custId).orElseThrow(()-> new ResourceNotFoundException("not found"));

        CustomerResponseDTO customerResponseDTO= new CustomerResponseDTO();
        customerResponseDTO.setCustId(customer.getCustId());
        customerResponseDTO.setCustName(customer.getCustName());
        customerResponseDTO.setCustAdd(customer.getCustAdd());

        return customerResponseDTO;
    }
}
