package org.example.todoapp.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.todoapp.domain.*;
import org.example.todoapp.service.TaskService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/tasks")
@RequiredArgsConstructor
public class TaskApiController {

    private final TaskService taskService;

    // Task 생성 요청 api
    @PostMapping
    public ResponseEntity<?> createTask(@Valid @RequestBody CreateTaskRequestDTO createTaskRequestDTO,
                                        @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        CreateTaskResponseDTO task = taskService.createTask(createTaskRequestDTO, userId);

        return ResponseEntity.status(HttpStatus.CREATED).body(Map.of(
                "code", "TASK_CREATED_SUCCESS",
                "message", "Task 생성 성공",
                "task", task));
    }

    // Task 수정 요청 api
    @PutMapping("/{id}")
    public ResponseEntity<?> updateTask(@Valid @RequestBody UpdateTaskRequestDTO updateTaskRequestDTO,
                                        @PathVariable("id") Long id,
                                        @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        TaskWithTaskListName taskWithTaskListName = taskService.updateTask(id, userId, updateTaskRequestDTO);

        return ResponseEntity.status(HttpStatus.OK).body(Map.of(
                "code", "TASK_UPDATED_SUCCESS",
                "message", "Task 수정 성공",
                "task", taskWithTaskListName
        ));
    }

    // Task 삭제 요청 api
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTask(@PathVariable("id") Long id, @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        taskService.deleteTask(id, userId);

        return ResponseEntity.status(HttpStatus.OK).body(Map.of(
                "code", "TASK_DELETED_SUCCESS",
                "message", "Task 삭제 성공"
        ));
    }

    // Task 완료 상태 토글 요청 api
    @PutMapping("/{id}/toggle")
    public ResponseEntity<?> toggleTaskStatus(@PathVariable("id") Long id, @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        TaskToggleResult taskToggleResult = taskService.toggleIsCompleted(id, userId);

        return ResponseEntity.status(HttpStatus.OK).body(Map.of(
                "code", "TASK_TOGGLE_SUCCESS",
                "message", "Task 완료 상태 토글 성공",
                "task", taskToggleResult
        ));
    }

    // Task를 오늘 할 일로 옮기는 요청 api
    @PutMapping("/{id}/move-to-today")
    public ResponseEntity<?> moveTaskToToday(@PathVariable("id") Long id,
                                             @RequestBody MoveToTodayRequestDTO moveToTodayRequestDTO,
                                             @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        taskService.updateIsToday(id, userId, moveToTodayRequestDTO.getPeriodDay());

        return ResponseEntity.status(HttpStatus.OK).body(Map.of(
                "code", "TASK_TO_TODAY_SUCCESS",
                "message", "Task 오늘 할 일로 지정 성공"
        ));
    }

    // Task를 기타 할 일(not today)로 옮기는 요청 api
    @PutMapping("/{id}/move-to-other")
    public ResponseEntity<?> moveTaskToOtherTask(@PathVariable("id") Long id, @AuthenticationPrincipal CustomUserDetails user) {

        String userId = user.getUserId();
        taskService.updateIsToday(id, userId);

        return ResponseEntity.status(HttpStatus.OK).body(Map.of(
                "code", "TASK_TO_OTHER_SUCCESS",
                "message", "Task 기타 할 일로 지정 성공"
        ));
    }

//    @PutMapping("/{id}/reorder")
//    public ResponseEntity<?> reorderTask() {
//        return ResponseEntity.status(HttpStatus.OK).body(Map.of(
//                "message", "Task reordered"
//        ));
//    }
}