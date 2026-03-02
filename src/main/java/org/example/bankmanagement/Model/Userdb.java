package org.example.bankmanagement.Model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "userdb")
public class Userdb {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long userId;

    @Column(unique = true,nullable = false)
    private String userName;

    @Column(nullable = false)
    private String password;

//    private String userRole;

    private boolean enabled;

}
