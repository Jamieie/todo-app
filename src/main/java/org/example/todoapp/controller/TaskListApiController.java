package org.example.todoapp.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.example.todoapp.domain.CreateTaskListRequestDTO;
import org.example.todoapp.domain.CustomUserDetails;
import org.example.todoapp.domain.TaskListName;
import org.example.todoapp.service.TaskListService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/task-lists")
@RequiredArgsConstructor
public class TaskListApiController {

    private final TaskListService taskListService;

    @GetMapping
    public ResponseEntity<?> getAllTaskListNames(@AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        List<TaskListName> taskListNames = taskListService.getTaskListNames(userId);
        return ResponseEntity.ok(Map.of(
                "code", "TASK_LIST_NAMES_FETCHED_SUCCESS",
                "message", "Task List 이름 목록 조회 성공",
                "taskListNames", taskListNames
        ));
    }

    @PostMapping
    public ResponseEntity<?> createTaskList(@AuthenticationPrincipal CustomUserDetails user,
                                            @RequestBody @Valid CreateTaskListRequestDTO createTaskListRequestDTO) {
        String userId = user.getUserId();
        taskListService.createTaskList(userId, createTaskListRequestDTO);
        return ResponseEntity.ok(Map.of(
                "code", "TASK_LIST_CREATION_SUCCESS",
                "message", "Task List 생성 성공"
        ));
    }
}
