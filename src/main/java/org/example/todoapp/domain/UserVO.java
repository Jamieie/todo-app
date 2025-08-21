package org.example.todoapp.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserVO {
    private String userId;
    private String email;
    private String name;
    private String password;
    private Boolean isDeleted;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}