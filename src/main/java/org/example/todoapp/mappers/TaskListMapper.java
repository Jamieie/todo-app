package org.example.todoapp.mappers;

import org.apache.ibatis.annotations.Param;
import org.example.todoapp.domain.TaskListName;
import org.example.todoapp.domain.TaskListVO;

import java.util.List;
import java.util.Optional;

public interface TaskListMapper {
    // taskListId와 userId로 Task List의 이름 조회
    Optional<String> findNameByIdAndUserId(@Param("taskListId") Long taskListId, @Param("userId") String userId);

    // userId로 user 소유의 전체 Task List 이름 조회
    List<TaskListName> selectNameByUserId(@Param("userId") String userId);

    int insert(TaskListVO taskListVO);
}
