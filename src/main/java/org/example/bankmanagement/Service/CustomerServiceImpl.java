package org.example.bankmanagement.Service;

import org.example.bankmanagement.DTO.CustomerRequestDTO;
import org.example.bankmanagement.DTO.CustomerResponseDTO;
import org.example.bankmanagement.DTO.PageResponseDTO;
import org.example.bankmanagement.Mapper.PageResponseMapper;
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

    private static final int pageSize=10;

    public CustomerServiceImpl(CustomerRepo customerRepo){
        this.customerRepo=customerRepo;
    }

    @Override
    public List<CustomerResponseDTO> addNewCustomer(List<CustomerRequestDTO> customerRequestDTO) {

        List<Customer> customers = customerRequestDTO.stream().map(dto -> {
            Customer c =new Customer();
            c.setCustName(dto.getCustName());
            c.setCustAdd(dto.getCustAdd());
            return c;
        }).toList();

        List<Customer> savedCustomer = customerRepo.saveAll(customers);

        return savedCustomer.stream().map(customer -> {
            CustomerResponseDTO responseDTO = new CustomerResponseDTO();
            responseDTO.setCustId(customer.getCustId());
            responseDTO.setCustName(customer.getCustName());
            responseDTO.setCustAdd(customer.getCustAdd());
            return responseDTO;
        }).toList();
    }

    @Override
    public PageResponseDTO<CustomerResponseDTO> getAllCustomers(int page){
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
        Customer customer = customerRepo.findById(custId).orElseThrow(()-> new RuntimeException("Id not found"));
        customerRepo.delete(customer);
    }

        @Override
        public CustomerResponseDTO updateCustomer(long custId,CustomerRequestDTO customerRequestDTO) {
            Customer customer = customerRepo.findById(custId).orElseThrow(()->
                    new RuntimeException("Customer Id not found"));

            customer.setCustName(customerRequestDTO.getCustName());
            customer.setCustAdd(customerRequestDTO.getCustAdd());

            Customer updatedCustomer =  customerRepo.save(customer);

            CustomerResponseDTO customerResponse = new CustomerResponseDTO();
            customerResponse.setCustId(updatedCustomer.getCustId());
            customerResponse.setCustName(updatedCustomer.getCustName());
            customerResponse.setCustAdd(updatedCustomer.getCustAdd());

            return customerResponse;
        }
}
