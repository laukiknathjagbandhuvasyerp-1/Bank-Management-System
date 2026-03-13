package org.example.bankmanagement.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class EMIResponseDTO {

    private long emiId;
    private double emiAmount;
    private LocalDate emiDueDate;
    private LocalDate emiPaidDate;
    private boolean isPaid;

}
