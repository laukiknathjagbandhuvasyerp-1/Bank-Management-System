package org.example.bankmanagement.Service;

import org.example.bankmanagement.Model.Userdb;
import org.example.bankmanagement.Repo.UserRepo;
import org.example.bankmanagement.config.SecurityConfig;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class  CustomerUserDetailsServiceImpl implements CustomerUserDetailsService,UserDetailsService {

    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;

    // Constructor injection - no @Autowired needed
    public CustomerUserDetailsServiceImpl(UserRepo userRepo, PasswordEncoder passwordEncoder) {
        this.userRepo = userRepo;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

       Userdb userdb = userRepo.findByUserName(userName).orElseThrow(()-> new UsernameNotFoundException("User Not Found"));

        return org.springframework.security.core.userdetails.User
                .withUsername(userdb.getUserName())
                .password(userdb.getPassword())
//                .roles(userdb.getUserRole().replace("ROLE_",""))
                .disabled(!userdb.isEnabled())
                .build();
    }

    @Override
    public void registerUser(String username, String password) {

        if(userRepo.findByUserName(username).isPresent()){
            throw new RuntimeException("User already exists");
        }

        Userdb userdb =new Userdb();

        userdb.setUserName(username);
        userdb.setPassword(passwordEncoder.encode(password));

//        userdb.setUserRole("ROLE_USER");
        userdb.setEnabled(true);

        userRepo.save(userdb);

    }
}
