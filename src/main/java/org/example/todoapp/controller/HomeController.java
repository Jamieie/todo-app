package org.example.todoapp.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.todoapp.domain.CustomUserDetails;
import org.example.todoapp.domain.NotTodayTask;
import org.example.todoapp.domain.TaskListName;
import org.example.todoapp.domain.TodayTask;
import org.example.todoapp.service.TaskListService;
import org.example.todoapp.service.TaskService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
public class HomeController {

    private final TaskService taskService;
    private final TaskListService taskListService;

    @GetMapping("/")
    public String root() {
        return "redirect:/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(@AuthenticationPrincipal CustomUserDetails user, Model model) {
        
        // SecurityContextHolder에서 직접 가져오기
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        CustomUserDetails user = (CustomUserDetails) auth.getPrincipal();
        
        log.info("User: {}", user);

        String userId = user.getUserId();
        List<TodayTask> todayTasks = taskService.getTodayTasks(userId);
        model.addAttribute("todayTasks", todayTasks);

        List<NotTodayTask> notTodayTasks = taskService.getNotTodayTasks(userId);
        model.addAttribute("notTodayTasks", notTodayTasks);

        List<TaskListName> taskListNames = taskListService.getTaskListNames(userId);
        model.addAttribute("taskListNames", taskListNames);

        return "/home/dashboard";
    }

    @GetMapping("/today")
    public String today(@AuthenticationPrincipal CustomUserDetails user, Model model) {

        String userId = user.getUserId();
        List<TodayTask> todayTasks = taskService.getTodayTasks(userId);
        model.addAttribute("todayTasks", todayTasks);

        List<TaskListName> taskListNames = taskListService.getTaskListNames(userId);
        model.addAttribute("taskListNames", taskListNames);

        return "/home/today";
    }
}
