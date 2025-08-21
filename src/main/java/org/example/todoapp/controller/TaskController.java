package org.example.todoapp.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.todoapp.domain.CustomUserDetails;
import org.example.todoapp.domain.TaskListName;
import org.example.todoapp.domain.TaskWithTaskListName;
import org.example.todoapp.domain.UpdateTaskRequestDTO;
import org.example.todoapp.service.TaskListService;
import org.example.todoapp.service.TaskService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/tasks")
public class TaskController {

    private final TaskService taskService;
    private final TaskListService taskListService;

    // Task 전체 목록 조회
    @GetMapping
    public String getTasks(@AuthenticationPrincipal CustomUserDetails user, Model model) {

        String userId = user.getUserId();
        List<TaskWithTaskListName> allTasks = taskService.getAllTasks(userId);
        model.addAttribute("tasks", allTasks);

        List<TaskListName> taskListNames = taskListService.getTaskListNames(userId);
        model.addAttribute("taskListNames", taskListNames);

        return "tasks/list";
    }

    // Task의 상세 내용 조회
    @GetMapping(value = "/{id}", produces = "text/html")
    public String getTask(@PathVariable("id") Long id,
                          @AuthenticationPrincipal CustomUserDetails user,
                          HttpServletResponse response,
                          Model model) {

        String userId = user.getUserId();
        TaskWithTaskListName taskDetail = taskService.getTaskDetail(id, userId);
        model.addAttribute("taskDetail", taskDetail);

        // 캐시 방지 헤더 추가
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        return "tasks/detail";
    }

    // Task 수정 페이지
    @GetMapping("/{id}/edit")
    public String editTask(@PathVariable("id") Long id, @AuthenticationPrincipal CustomUserDetails user, Model model) {

        String userId = user.getUserId();
        TaskWithTaskListName taskDetail = taskService.getTaskDetail(id, userId);
        model.addAttribute("taskDetail", taskDetail);

        List<TaskListName> taskListNames = taskListService.getTaskListNames(userId);
        model.addAttribute("taskListNames", taskListNames);

        return "tasks/edit";
    }

    // Task 수정 요청
    @PutMapping(value = "/{id}", produces = "text/html")
    public String updateTask(@Valid UpdateTaskRequestDTO updateTaskRequestDTO,
                             @PathVariable("id") Long id,
                             @AuthenticationPrincipal CustomUserDetails user,
                             Model model) {

        String userId = user.getUserId();
        TaskWithTaskListName taskWithTaskListName = taskService.updateTask(id, userId, updateTaskRequestDTO);

        // Task 수정 후 Task 상제 조회 페이지로 리다이렉트
        return "redirect:/tasks/" + taskWithTaskListName.getTaskId();
    }
}