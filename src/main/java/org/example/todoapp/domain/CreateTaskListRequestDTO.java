package org.example.todoapp.domain;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CreateTaskListRequestDTO {

    @NotBlank
    private String name;
}
