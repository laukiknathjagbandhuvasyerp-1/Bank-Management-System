package org.example.bankmanagement.DTO;

import lombok.Data;

import java.util.Date;

@Data

public class AccountResponseDTO {

    private String accType;
    private double accBalance;
    private long accNo;

}