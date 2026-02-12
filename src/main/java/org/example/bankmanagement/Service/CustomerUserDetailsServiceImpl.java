package org.example.bankmanagement.Service;

import org.example.bankmanagement.Repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomerUserDetailsServiceImpl implements CustomerUserDetailsService{

    @Autowired
    private UserRepo userRepo;

    @Override
    public UserDetails loadUserByUserName(String userName) throws UsernameNotFoundException {

         org.springframework.security.core.userdetails.User user = userRepo.findByUserName(userName)
                 .orElseThrow(()-> new UsernameNotFoundException("Not Found User"));




        return null;
    }
}
