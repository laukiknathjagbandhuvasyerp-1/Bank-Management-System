package org.example.bankmanagement.DTO;

import jakarta.annotation.Nonnull;
import lombok.Data;
import org.hibernate.annotations.processing.Pattern;

import java.util.Date;

@Data

public class AccountRequestDTO {

    private String accType;
    private long accBalance;
    private Date accDate;

}
