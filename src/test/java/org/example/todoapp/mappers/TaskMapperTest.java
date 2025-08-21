package org.example.todoapp.mappers;

import lombok.extern.slf4j.Slf4j;
import org.example.todoapp.common.enums.PeriodDay;
import org.example.todoapp.domain.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static java.util.Calendar.AUGUST;
import static org.junit.jupiter.api.Assertions.*;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration("classpath:spring/test-root-context.xml")
class TaskMapperTest {

    String userId = "test-user-uuid";

    @Autowired(required = false)
    private TaskMapper taskMapper;

    @BeforeEach
    void setUp() {
        // TODO) TEST USER insert
        // TODO) TEST TASKLIST insert
    }

    private TaskVO createTaskVO() {
        TaskVO taskVO = new TaskVO();
        taskVO.setTaskListId(1L);
        taskVO.setTitle("Test Title");
        taskVO.setEstimateMin(30);
        taskVO.setDescription("Test Description");
        taskVO.setPeriodDay(PeriodDay.MORNING);
        taskVO.setIsToday(true);
        taskVO.setIsCompleted(false);

        return taskVO;
    }

    @Test
    void insertTest() {
        TaskVO taskVO = createTaskVO();
        taskVO.setIsToday(false);

        int count = taskMapper.insertTask(taskVO);
        assertEquals(1, count);
    }

    @Test
    void selectTest() {
        TaskVO taskVO = createTaskVO();
        assertEquals(1, taskMapper.insertTask(taskVO));

        Long taskId = taskVO.getTaskId();
        TaskVO selectedTask = taskMapper.selectTaskById(taskId).get();
        System.out.println("taskId: " + taskId + ", selectedTask: " + selectedTask);
        assertEquals(taskId, selectedTask.getTaskId());
        assertEquals(taskVO.getTitle(), selectedTask.getTitle());
    }

    @Test
    void deleteTest() {
        TaskVO taskVO = createTaskVO();
        assertEquals(1, taskMapper.insertTask(taskVO));

        Long taskId = taskVO.getTaskId();
        int count = taskMapper.deleteTaskById(taskId);
        assertEquals(1, count);
        assertEquals(Optional.empty(), taskMapper.selectTaskById(taskId));
    }

    @Test
    void toggleTest_falseToTrue() {
        TaskVO taskVO = createTaskVO();
        assertEquals(1, taskMapper.insertTask(taskVO));
        Long taskId = taskVO.getTaskId();
        String userId = "test-user-uuid";

        assertEquals(1, taskMapper.updateIsCompletedByIdAndUserId(taskId, userId));

        TaskVO taskSelected = taskMapper.selectTaskById(taskId).orElseThrow();
        log.info("============================================");
        log.info("task: " + taskSelected);
    }

    @Test
    void toggleTest_trueToFalse() {
        TaskVO taskVO = createTaskVO();
        assertEquals(1, taskMapper.insertTask(taskVO));
        Long taskId = taskVO.getTaskId();
        String userId = "test-user-uuid";

        assertEquals(1, taskMapper.updateIsCompletedByIdAndUserId(taskId, userId));
        assertEquals(1, taskMapper.updateIsCompletedByIdAndUserId(taskId, userId));

        TaskVO taskSelected = taskMapper.selectTaskById(taskId).orElseThrow();
        log.info("============================================");
        log.info("task: " + taskSelected);
    }

    @Test
    void selectIsCompletedTest() {
        TaskVO taskVO = createTaskVO();
        assertEquals(1, taskMapper.insertTask(taskVO));
        Long taskId = taskVO.getTaskId();
        String userId = "test-user-uuid";

        TaskToggleResult taskToggleResult = taskMapper.selectTaskToggleById(taskId).orElseThrow();
        assertEquals(taskId, taskToggleResult.getTaskId());
        log.info("============================================");
        log.info("isCompleted: " + taskToggleResult.getIsCompleted() + ", completedDate: " + taskToggleResult.getCompletedDate());

        assertEquals(1, taskMapper.updateIsCompletedByIdAndUserId(taskId, userId));
        TaskToggleResult taskToggleResult2 = taskMapper.selectTaskToggleById(taskId).orElseThrow();
        assertEquals(taskId, taskToggleResult2.getTaskId());
        log.info("============================================");
        log.info("isCompleted: " + taskToggleResult2.getIsCompleted() + ", completedDate: " + taskToggleResult2.getCompletedDate());
    }

    @Test
    void selectTaskWithTaskListNameByIdAndUserIdTest() {
        TaskVO taskVO = createTaskVO();
        assertEquals(1, taskMapper.insertTask(taskVO));
        Long taskId = taskVO.getTaskId();

        TaskWithTaskListName taskWithTaskListName = taskMapper.selectTaskWithTaskListNameByIdAndUserId(taskId, userId).orElseThrow();
        log.info("============================================");
        log.info("taskListName: " + taskWithTaskListName.getTaskListName());

        String taskListName = "MyTasks";
        assertEquals(taskListName, taskWithTaskListName.getTaskListName());
    }

    @Test
    void selectNotTodayTasksTest() {
        List<NotTodayTask> notTodayTasks = taskMapper.selectNotTodayTasksByUserId(userId);
        if (!notTodayTasks.isEmpty()) {
            for (NotTodayTask notTodayTask : notTodayTasks) {
                Long taskId = notTodayTask.getTaskId();
                TaskVO taskVO = taskMapper.selectTaskById(taskId).orElseThrow();
                assertEquals(false, taskVO.getIsToday());
                assertEquals(false, taskVO.getIsCompleted());
            }
        }
    }

    @Test
    void selectTodayTasksTest() {
        List<TodayTask> todayTasks = taskMapper.selectTodayTasksByUserId(userId);
        log.info("============================================");
        log.info("TodayTasks: " + todayTasks);

        if (!todayTasks.isEmpty()) {
            for (TodayTask todayTask : todayTasks) {
                Long taskId = todayTask.getTaskId();
                TaskVO taskVO = taskMapper.selectTaskById(taskId).orElseThrow();
                assertEquals(true, taskVO.getIsToday());
                if (taskVO.getIsCompleted()) {
                    LocalDate now = LocalDate.now();
                    assertEquals(now.getYear(), taskVO.getCompletedDate().getYear());
                    assertEquals(now.getMonth(), taskVO.getCompletedDate().getMonth());
                    assertEquals(now.getDayOfMonth(), taskVO.getCompletedDate().getDayOfMonth());
                }
            }
        }
    }

    @Test
    void updateTaskByUserIdTest() {
        TaskVO taskVO = createTaskVO();
        assertEquals(1, taskMapper.insertTask(taskVO));
        Long taskId = taskVO.getTaskId();

        assertEquals(1, taskMapper.updateTaskByUserId(taskVO, userId));
    }
}