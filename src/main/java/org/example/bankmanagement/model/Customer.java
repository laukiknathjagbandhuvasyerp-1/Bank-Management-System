package org.example.bankmanagement.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
@Table(name="customer")
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long custId;
    private String custName;
    private String custAdd;

    @OneToMany(mappedBy = "customer" , cascade = CascadeType.ALL)
    private List<Account> accounts;


    @OneToMany(mappedBy = "customer",cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Loan> loans;


}
