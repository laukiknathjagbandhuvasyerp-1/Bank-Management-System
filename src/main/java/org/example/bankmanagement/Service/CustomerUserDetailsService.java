package org.example.bankmanagement.Service;

import org.springframework.security.core.userdetails.UserDetails;

public interface CustomerUserDetailsService {

    UserDetails loadUserByUsername(String userName);

    void registerUser(String username,String password);
}
