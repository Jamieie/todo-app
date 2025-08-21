package org.example.todoapp.controller;

import lombok.RequiredArgsConstructor;
import org.example.todoapp.domain.CustomUserDetails;
import org.example.todoapp.domain.TaskListName;
import org.example.todoapp.service.TaskListService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
