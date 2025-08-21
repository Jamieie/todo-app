package org.example.todoapp.util;

import org.example.todoapp.domain.*;

import java.util.UUID;

public class DtoVoConverter {

    // Signup 요청 시 SignupRequestDTO를 UserVO로 변환하는 메서드
    public static UserVO signupRequestDTOtoUserVO(SignupRequestDTO signupRequestDTO) {
        UserVO userVO = new UserVO();
        userVO.setUserId(UUID.randomUUID().toString());
        userVO.setEmail(signupRequestDTO.getEmail());
        userVO.setName(signupRequestDTO.getName());
        userVO.setIsDeleted(false);
        return userVO;
    }

    // Task 생성 요청 시 CreateTaskRequestDTO를 TaskVO로 변환하는 메서드
    public static TaskVO createTaskRequestDTOtoTaskVO(CreateTaskRequestDTO createTaskRequestDTO) {
        TaskVO taskVO = new TaskVO();
        taskVO.setTaskListId(createTaskRequestDTO.getTaskListId());
        taskVO.setTitle(createTaskRequestDTO.getTitle());
        taskVO.setDescription(createTaskRequestDTO.getDescription());
        taskVO.setDeadline(createTaskRequestDTO.getDeadline());
        taskVO.setEstimateMin(createTaskRequestDTO.getEstimateMin());
        taskVO.setIsToday(createTaskRequestDTO.getIsToday());
        taskVO.setPeriodDay(createTaskRequestDTO.getPeriodDay());
        return taskVO;
    }

    // Task 생성 응답 시 TaskVO를 CreateTaskResponseDTO로 변환하는 메서드
    public static CreateTaskResponseDTO taskVOtoCreateTaskResponseDTO(TaskVO taskVO) {
        CreateTaskResponseDTO createTaskResponseDTO = new CreateTaskResponseDTO();
        createTaskResponseDTO.setTaskId(taskVO.getTaskId());
        createTaskResponseDTO.setTitle(taskVO.getTitle());
        createTaskResponseDTO.setDescription(taskVO.getDescription());
        createTaskResponseDTO.setDeadline(taskVO.getDeadline());
        createTaskResponseDTO.setEstimateMin(taskVO.getEstimateMin());
        createTaskResponseDTO.setIsToday(taskVO.getIsToday());
        createTaskResponseDTO.setPeriodDay(taskVO.getPeriodDay());
        createTaskResponseDTO.setDisplayOrder(taskVO.getDisplayOrder());
        createTaskResponseDTO.setTodayOrder(taskVO.getTodayOrder());
        return createTaskResponseDTO;
    }

    // Task 수정 요청 시 UpdateTaskRequestDTO를 TaskVO로 변환하는 메서드
    public static TaskVO updateTaskRequestDTOtoTaskVO(UpdateTaskRequestDTO updateTaskRequestDTO) {
        TaskVO taskVO = new TaskVO();
        taskVO.setTaskListId(updateTaskRequestDTO.getTaskListId());
        taskVO.setTitle(updateTaskRequestDTO.getTitle());
        taskVO.setDescription(updateTaskRequestDTO.getDescription());
        taskVO.setDeadline(updateTaskRequestDTO.getDeadline());
        taskVO.setEstimateMin(updateTaskRequestDTO.getEstimateMin());
        taskVO.setIsToday(updateTaskRequestDTO.getIsToday());
        taskVO.setPeriodDay(updateTaskRequestDTO.getPeriodDay());
        return taskVO;
    }
}
