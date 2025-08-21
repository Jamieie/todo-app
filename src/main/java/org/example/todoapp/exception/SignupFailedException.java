package org.example.todoapp.exception;

public class SignupFailedException extends RuntimeException {
    public SignupFailedException(String message) {
        super(message);
    }
}
