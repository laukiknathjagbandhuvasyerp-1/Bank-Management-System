package org.example.bankmanagement.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Entity
@Data

public class EMI {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long emiId;

    private double emiAmount;
    private LocalDate emiDueDate;
    private boolean isPaid;

    @ManyToOne
    @JoinColumn(name="loan_id",referencedColumnName = "loanId")
    @JsonIgnore
    private Loan loan;
}
