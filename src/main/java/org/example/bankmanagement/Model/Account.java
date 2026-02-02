package org.example.bankmanagement.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Data
@Table(name="account")
public class Account {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long accNo;
    private Date accOpenDate;
    private String accType;
    @Column
    private double accBalance;

    @ManyToOne
    @JoinColumn(name ="cust_id",referencedColumnName = "custId")
    @JsonIgnore
    private Customer customer;

}
