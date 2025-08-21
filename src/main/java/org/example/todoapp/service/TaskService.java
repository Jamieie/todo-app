package org.example.todoapp.service;

import org.example.todoapp.common.enums.PeriodDay;
import org.example.todoapp.domain.*;

import java.util.List;

public interface TaskService {
    CreateTaskResponseDTO createTask(CreateTaskRequestDTO createTaskRequestDTO, String userId);

    List<TodayTask> getTodayTasks(String userId);

    List<NotTodayTask> getNotTodayTasks(String userId);

    TaskWithTaskListName getTaskDetail(Long taskId, String userId);

    List<TaskWithTaskListName> getAllTasks(String userId);

    TaskWithTaskListName updateTask(Long taskId, String userId, UpdateTaskRequestDTO updateTaskRequestDTO);

    void updateIsToday(Long taskId, String userId);

    void updateIsToday(Long taskId, String userId, PeriodDay periodDay);

    void deleteTask(Long taskId, String userId);

    TaskToggleResult toggleIsCompleted(Long taskId, String userId);
}
