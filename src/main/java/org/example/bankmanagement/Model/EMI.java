package org.example.bankmanagement.Model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data

public class EMI {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long emiId;

    private double emiAmount;
    private int emiMonths;
    private float emiRate;

    @OneToOne
    @JoinColumn(name="loan_id",referencedColumnName = "loanId")
    private Loan loan;
}
