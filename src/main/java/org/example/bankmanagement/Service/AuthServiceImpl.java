package org.example.bankmanagement.Service;

import org.example.bankmanagement.dto.AuthRequestDTO;
import org.example.bankmanagement.dto.AuthResponseDTO;
import org.example.bankmanagement.security.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService{

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JWTUtil jwtUtil;

    @Override
    public AuthResponseDTO authenticateUserAndGenerateTokens(AuthRequestDTO authRequestDTO) {
        Authentication authentication=  authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        authRequestDTO.getUsername(),
                        authRequestDTO.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String token = jwtUtil.generateToken(authRequestDTO.getUsername());

        return new AuthResponseDTO(token);
    }

}
