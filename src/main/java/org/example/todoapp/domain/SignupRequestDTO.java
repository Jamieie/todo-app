package org.example.todoapp.domain;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import lombok.Data;

import java.util.Objects;

@Data
public class SignupRequestDTO {

    @NotBlank(message = "email은 필수 입력값입니다.")
    @Email(message = "email 형식에 맞춰 입력해 주세요.")
    private String email;

    @NotBlank(message = "비밀번호는 필수 입력값입니다.")
    @Pattern(
            regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[~!@#$%^&*()_+\\-={}\\[\\]|\\\\:;\"'<>,.?/]).{8,64}$",
            message = "비밀번호는 영문자, 숫자, 특수문자를 포함한 8~64자여야 합니다."
    )
    private String password;

    @NotBlank
    private String confirmPassword;

    @NotBlank(message = "이름을 입력해 주세요.")
    private String name;

    public boolean equalsPasswords() {
        return Objects.equals(password, confirmPassword);
    }
}
