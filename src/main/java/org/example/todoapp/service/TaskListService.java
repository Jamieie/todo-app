package org.example.todoapp.service;

import org.example.todoapp.domain.TaskListName;

import java.util.List;

public interface TaskListService {
    List<TaskListName> getTaskListNames(String userId);

    void createDefaultTaskList(String userId);
}
