package org.example.bankmanagement.Service;

import org.example.bankmanagement.dto.CustomerRequestDTO;
import org.example.bankmanagement.dto.CustomerResponseDTO;
import org.example.bankmanagement.dto.PageResponseDTO;

public interface CustomerService {

    CustomerResponseDTO addNewCustomer(CustomerRequestDTO customerRequestDTO);

    void deleteCustomer(long custId);

    void updateCustomer(long custId,CustomerRequestDTO customerRequestDTO);

    PageResponseDTO<CustomerResponseDTO> getAllCustomers(int page);

    CustomerResponseDTO findCustomerById(long custId);
}
