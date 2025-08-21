package org.example.todoapp.service;

import lombok.RequiredArgsConstructor;
import org.example.todoapp.domain.CreateTaskListRequestDTO;
import org.example.todoapp.domain.TaskListName;
import org.example.todoapp.domain.TaskListVO;
import org.example.todoapp.exception.TaskListNotFoundException;
import org.example.todoapp.mappers.TaskListMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class TaskListServiceImpl implements TaskListService {

    private final TaskListMapper taskListMapper;

    // 사용자의 Task List 이름 목록 조회 메소드
    @Override
    public List<TaskListName> getTaskListNames(String userId) {
        List<TaskListName> taskListNames = taskListMapper.selectNameByUserId(userId);
        if (taskListNames.isEmpty()) {
            // 사용자는 무조건 하나 이상의 Task List를 가짐 -> 없다면 서버에서 처리 필요
            throw new TaskListNotFoundException("사용자의 Task List가 존재하지 않습니다. : " + userId);
        }
        return taskListNames;
    }

    @Override
    public void createDefaultTaskList(String userId) {
        createTaskList(userId, "My Tasks", true);
    }

    @Override
    public void createTaskList(String userId, CreateTaskListRequestDTO createTaskListRequestDTO) {
        createTaskList(userId, createTaskListRequestDTO.getName(), false);
    }


    private void createTaskList(String userId, String taskListName, Boolean isDefault) {
        TaskListVO taskListVO = new TaskListVO();
        taskListVO.setUserId(userId);
        taskListVO.setName(taskListName);
        taskListVO.setIsDefault(isDefault);
        taskListVO.setIsDeleted(false);

        int count = taskListMapper.insert(taskListVO);
        if (count == 0) {
            throw new RuntimeException("Default Task List 생성에 실패했습니다.");
        }
    }
}
