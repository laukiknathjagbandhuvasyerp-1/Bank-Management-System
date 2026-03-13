package org.example.bankmanagement.dto;

import lombok.Data;

@Data

public class AccountResponseDTO {

    private String accType;
    private double accBalance;
    private long accNo;

}