package org.example.todoapp.domain;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class LoginRequestDTO {

    @NotNull(message = "email을 입력해 주세요.")
    @Email(message = "email 형식으로 입력해 주세요.")
    private String email;

    @NotNull(message = "password를 입력해 주세요.")
    private String password;
}
