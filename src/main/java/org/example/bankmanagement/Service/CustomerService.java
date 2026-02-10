package org.example.bankmanagement.Service;

import org.example.bankmanagement.DTO.CustomerRequestDTO;
import org.example.bankmanagement.DTO.CustomerResponseDTO;
import org.example.bankmanagement.DTO.PageResponseDTO;
import org.example.bankmanagement.Model.Customer;
import org.springframework.data.domain.Page;

import java.util.List;

public interface CustomerService {

    CustomerResponseDTO addNewCustomer(CustomerRequestDTO customerRequestDTO);

    void deleteCustomer(long custId);

    void updateCustomer(long custId,CustomerRequestDTO customerRequestDTO);

    PageResponseDTO<CustomerResponseDTO> getAllCustomers(int page);

    CustomerResponseDTO findCustomerById(long custId);
}
