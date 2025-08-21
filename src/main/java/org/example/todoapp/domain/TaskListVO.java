package org.example.todoapp.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class TaskListVO {
    private Long taskListId;
    private String userId;
    private String name;
    private Boolean isDefault;
    private Boolean isDeleted;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
