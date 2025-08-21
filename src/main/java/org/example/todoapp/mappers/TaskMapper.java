package org.example.todoapp.mappers;

import org.apache.ibatis.annotations.Param;
import org.example.todoapp.domain.*;

import java.util.List;
import java.util.Optional;

public interface TaskMapper {

    Optional<TaskVO> selectTaskById(Long id);

    int insertTask(TaskVO taskVO);

    // user id 맞는지 확인 후 task 수정
    int updateTaskByUserId(@Param("task") TaskVO taskVO, @Param("userId") String userId);

    // task id로 task 삭제
    int deleteTaskById(Long id);

    // user id 맞는지 확인 후 task id로 task 삭제
    int deleteByIdAndUserId(@Param("taskId") Long taskId, @Param("userId") String userId);

    // user id 맞는지 확인 후 is_completed 업데이트
    int updateIsCompletedByIdAndUserId(@Param("taskId") Long taskId, @Param("userId") String userId);

    // task id로 is_completed 토글 후 결과 조회
    Optional<TaskToggleResult> selectTaskToggleById(Long id);

    // user id 맞는지 확인 후 Task List 이름 포함한 task 정보 조회
    Optional<TaskWithTaskListName> selectTaskWithTaskListNameByIdAndUserId(@Param("taskId") Long taskId, @Param("userId") String userId);

    // user 소유의 모든 task를 Task List 이름과 함께 조회
    List<TaskWithTaskListName> selectAllWithTaskListNameByUserId(@Param("userId") String userId);

    // user 소유의 is_today = false인 task 모두 조회
    List<NotTodayTask> selectNotTodayTasksByUserId(@Param("userId") String userId);

    // user 소유의 is_today = true task 모두 조회
    List<TodayTask> selectTodayTasksByUserId(@Param("userId") String userId);

    // user id 맞는지 확인 후 task의 is_today(= true)와 period_day 업데이트
    int updateIsTodayTrueByIdAndUserId(@Param("periodDay") String periodDay, @Param("taskId") Long taskId, @Param("userId") String userId);

    // user id 맞는지 확인 후 task의 is_today(= false) 업데이트
    int updateIsTodayFalseByIdAndUserId(@Param("taskId") Long taskId, @Param("userId") String userId);
}
