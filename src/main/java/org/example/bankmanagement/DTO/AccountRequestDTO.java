package org.example.bankmanagement.DTO;

import jakarta.annotation.Nonnull;
import lombok.Data;


import java.util.Date;

@Data

public class AccountRequestDTO {

    private String accType;
    private long accBalance;
    private Date accDate;

}
