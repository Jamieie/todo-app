package org.example.todoapp.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.example.todoapp.common.enums.PeriodDay;

import java.time.LocalDateTime;

@Data
public class TaskWithTaskListName {
    Long taskId;
    String title;
    Long taskListId;
    String taskListName;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    LocalDateTime deadline;
    Integer estimateMin;
    String description;
    PeriodDay periodDay;
    Boolean isToday;
    Boolean isCompleted;
    LocalDateTime completedDate;
}
