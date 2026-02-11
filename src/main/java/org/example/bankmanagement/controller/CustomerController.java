package org.example.bankmanagement.controller;

import org.example.bankmanagement.DTO.CustomerRequestDTO;
import org.example.bankmanagement.DTO.CustomerResponseDTO;
import org.example.bankmanagement.DTO.PageResponseDTO;
import org.example.bankmanagement.Service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customer")
class CustomerController {

    private final CustomerService customerService;

    public CustomerController(CustomerService customerService){
        this.customerService=customerService;
    }

    @PostMapping("/add")
    public String createNewCustomer(@ModelAttribute  CustomerRequestDTO customerRequestDTO){
        CustomerResponseDTO customerResponseDTO = customerService.addNewCustomer(customerRequestDTO);
        long id=customerResponseDTO.getCustId();
        return "redirect:/customer/profile/"+id;
    }

    @PostMapping("/delete/{custId}")
    public String deleteCustomerById(@PathVariable long custId){
        customerService.deleteCustomer(custId);
        return "redirect:/";
    }

    @PostMapping("/update/{custId}")
    public String updateCustomerDetailsById(@PathVariable long custId,@ModelAttribute  CustomerRequestDTO customerRequestDTO){
          customerService.updateCustomer(custId,customerRequestDTO);
         return "redirect:/customer/profile/"+custId;
    }

    @GetMapping("/view")
    public String getCustomer(@RequestParam(defaultValue = "1") int page, Model model){
        PageResponseDTO<CustomerResponseDTO> response = customerService.getAllCustomers(page);

        List<CustomerResponseDTO> customerResponseDTOList = response.getContent();
        model.addAttribute("customerList",customerResponseDTOList);
        model.addAttribute("currentPage",response.getPage());
        model.addAttribute("totalPages",response.getTotalPages());
        model.addAttribute("size",response.getSize());

        return "customerList";
    }

    @GetMapping("/ajax/view")
    @ResponseBody
    public Map<String,Object> viewCustomerAjax(@RequestParam(defaultValue = "1") int page){
        PageResponseDTO<CustomerResponseDTO> response = customerService.getAllCustomers(page);

        Map<String,Object> objectMap = new HashMap<>();
        objectMap.put("customers",response.getContent());
        objectMap.put("currentPage",page);
        objectMap.put("totalPages",response.getTotalPages());

        return objectMap;
    }

    @GetMapping("/profile/{custId}")
    public String getCustomerProfile(Model model,@PathVariable long custId){
        CustomerResponseDTO customer = customerService.findCustomerById(custId);
        model.addAttribute("customer",customer);
        return "customerProfile";
    }

    @GetMapping("/new")
    public String openNewCustomer(){
        return "addCustomer";
    }

    @GetMapping("/edit/{custId}")
    public String openUpdatePage(@PathVariable long custId ,Model model){
        CustomerResponseDTO customerResponseDTO = customerService.findCustomerById(custId);
        model.addAttribute("customer",customerResponseDTO);
        return "updateCustomer";
    }




}
