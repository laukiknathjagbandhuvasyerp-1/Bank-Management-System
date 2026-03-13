package org.example.bankmanagement.Service;

import org.example.bankmanagement.dto.AuthRequestDTO;
import org.example.bankmanagement.dto.AuthResponseDTO;

public interface AuthService {

   AuthResponseDTO authenticateUserAndGenerateTokens(AuthRequestDTO authRequestDTO);

    }
