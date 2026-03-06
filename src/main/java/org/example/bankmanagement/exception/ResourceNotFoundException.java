package org.example.bankmanagement.exception;

public class ResourceNotFoundException extends RuntimeException{

    public  ResourceNotFoundException(String message){
        super(message);
    }

}
