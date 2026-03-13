package org.example.bankmanagement.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
public class Loan {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long loanId;

    private long loanAmount;
    private float loanRate;
    @Column(name = "loan_tenure")
    private Integer loanTenure;

    @ManyToOne
    @JoinColumn(name="cust_id",referencedColumnName = "custId")
    @JsonIgnore
    private Customer customer;


    @OneToMany(mappedBy = "loan" , cascade = CascadeType.ALL)
    private List<EMI> emi = new ArrayList<>();



}
