package org.example.bankmanagement.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Loan {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long loanId;

    private long loanAmount;
    private float loanRate;

    @ManyToOne
    @JoinColumn(name="cust_id",referencedColumnName = "custId")
    @JsonIgnore
    private Customer customer;

    @OneToOne(mappedBy = "loan" , cascade = CascadeType.ALL)
    private EMI emi;



}
