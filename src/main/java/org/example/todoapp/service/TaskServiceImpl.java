package org.example.todoapp.service;

import lombok.RequiredArgsConstructor;
import org.example.todoapp.common.enums.PeriodDay;
import org.example.todoapp.domain.*;
import org.example.todoapp.exception.*;
import org.example.todoapp.mappers.TaskListMapper;
import org.example.todoapp.mappers.TaskMapper;
import org.example.todoapp.util.DtoVoConverter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class TaskServiceImpl implements TaskService {

    private final TaskMapper taskMapper;
    private final TaskListMapper taskListMapper;

    @Override
    public CreateTaskResponseDTO createTask(CreateTaskRequestDTO createTaskRequestDTO, String userId) {
        // taskListId와 userId로 listName 조회하여 없으면 예외 발생
        Long taskListId = createTaskRequestDTO.getTaskListId();
        String taskListName = taskListMapper.findNameByIdAndUserId(taskListId, userId).
                orElseThrow(() -> new TaskListNotFoundException("유효하지 않은 리스트입니다."));

        // TaskList 존재하면 요청 데이터 유효성 검사 후 Task 생성
        if (!validateCreateTaskRequestData(createTaskRequestDTO)) {
            throw new InvalidTaskDataException("오늘 하루 중 언제 할 일인지 지정해 주세요.");
        }
        TaskVO taskVO = DtoVoConverter.createTaskRequestDTOtoTaskVO(createTaskRequestDTO);
        int count = taskMapper.insertTask(taskVO);
        if (count == 0) {
            throw new TaskCreationFailedException("Task 생성에 실패했습니다.");  // 생성 실패 시 예외 발생
        }

        // 생성한 Task 다시 조회 후 데이터 응답으로 변환하여 반환
        TaskVO foundTask = taskMapper.selectTaskById(taskVO.getTaskId()).
                orElseThrow(() -> new TaskCreationFailedException("Task 생성 후 조회에 실패했습니다."));
        CreateTaskResponseDTO createTaskResponseDTO = DtoVoConverter.taskVOtoCreateTaskResponseDTO(foundTask);
        createTaskResponseDTO.setTaskListName(taskListName);

        return createTaskResponseDTO;
    }

    @Override
    public List<TodayTask> getTodayTasks(String userId) {
        return taskMapper.selectTodayTasksByUserId(userId);
    }

    @Override
    public List<NotTodayTask> getNotTodayTasks(String userId) {
        return taskMapper.selectNotTodayTasksByUserId(userId);
    }

    // Task List 이름과 함께 Task 상세 내용 조히
    @Override
    public TaskWithTaskListName getTaskDetail(Long taskId, String userId) {
        return taskMapper.selectTaskWithTaskListNameByIdAndUserId(taskId, userId).
                orElseThrow(() -> new TaskNotFoundException("유효하지 않은 Task입니다."));
    }

    // user의 모든 Task 목록을 Task List 이름과 함께 조회
    @Override
    public List<TaskWithTaskListName> getAllTasks(String userId) {
        return taskMapper.selectAllWithTaskListNameByUserId(userId);
    }

    // Task 수정 후 수정된 값 반환하는 메소드
    @Override
    public TaskWithTaskListName updateTask(Long taskId, String userId, UpdateTaskRequestDTO updateTaskRequestDTO) {
        TaskVO taskVO = DtoVoConverter.updateTaskRequestDTOtoTaskVO(updateTaskRequestDTO);
        taskVO.setTaskId(taskId);

        int count = taskMapper.updateTaskByUserId(taskVO, userId);
        if (count == 0) {
            throw new TaskUpdateFailedException("Task 수정에 실패했습니다.");
        }

        return taskMapper.selectTaskWithTaskListNameByIdAndUserId(taskId, userId).orElseThrow(
                () -> new TaskUpdateFailedException("Task 수정 후 조회에 실패했습니다."));
    }

    // 오늘 할 일 여부를 false로 수정하는 메소드
    @Override
    public void updateIsToday(Long taskId, String userId) {
        int count = taskMapper.updateIsTodayFalseByIdAndUserId(taskId, userId);
        if (count == 0) {
            throw new TaskUpdateFailedException("Task 오늘 할 일 지정에 실패했습니다.");
        }
    }

    // 오늘 할 일 여부를 true로 수정하는 메소드
    @Override
    public void updateIsToday(Long taskId, String userId, PeriodDay periodDay) {
        int count = taskMapper.updateIsTodayTrueByIdAndUserId(periodDay.toString(), taskId, userId);
        if (count == 0) {
            throw new TaskUpdateFailedException("Task 오늘 할 일 해제에 실패했습니다.");
        }
    }

    @Override
    public void deleteTask(Long taskId, String userId) {
        int count = taskMapper.deleteByIdAndUserId(taskId, userId);
        if (count == 0) {
            throw new TaskDeletionFailedException("유효하지 않은 Task입니다.");
        }
    }

    @Override
    public TaskToggleResult toggleIsCompleted(Long taskId, String userId) {
        int count = taskMapper.updateIsCompletedByIdAndUserId(taskId, userId);
        if (count == 0) {
            throw new TaskUpdateFailedException("Task 상태 변경에 실패했습니다.");
        }

        return taskMapper.selectTaskToggleById(taskId).orElseThrow(
                () -> new TaskUpdateFailedException("Task 상태 변경 후 조회에 실패했습니다.")
        );
    }

    private boolean validateCreateTaskRequestData(CreateTaskRequestDTO createTaskRequestDTO) {
        // isToday가 true이면 periodDay의 값이 존재해야 한다.
        if (createTaskRequestDTO.getIsToday()) {
            return createTaskRequestDTO.getPeriodDay() != null;
            // isTody가 false이면 periodDay의 값이 없어야 한다. -> 값 존재하면 무시하기
        } else {
            createTaskRequestDTO.setPeriodDay(null);
            return true;
        }
    }
}
