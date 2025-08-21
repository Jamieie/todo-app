package org.example.todoapp.domain;

import lombok.Data;

@Data
public class TaskListName {

    private Long taskListId;
    private String Name;
    private Boolean isDefault;

}
