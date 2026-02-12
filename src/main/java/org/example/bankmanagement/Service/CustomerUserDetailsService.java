package org.example.bankmanagement.Service;

import org.springframework.security.core.userdetails.UserDetails;

public interface CustomerUserDetailsService {
    UserDetails loadUserByUserName(String userName);
}
