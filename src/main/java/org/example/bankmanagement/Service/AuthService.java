package org.example.bankmanagement.Service;

import org.example.bankmanagement.DTO.AuthRequestDTO;
import org.example.bankmanagement.DTO.AuthResponseDTO;

public interface AuthService {

   AuthResponseDTO authenticateUserAndGenerateTokens(AuthRequestDTO authRequestDTO);

    }
