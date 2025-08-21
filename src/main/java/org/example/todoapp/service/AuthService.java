package org.example.todoapp.service;

import org.example.todoapp.domain.SignupRequestDTO;

public interface AuthService {
    void signup(SignupRequestDTO signupRequestDTO);
}