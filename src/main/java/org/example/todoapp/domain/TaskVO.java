package org.example.todoapp.domain;

import lombok.Data;
import org.example.todoapp.common.enums.PeriodDay;

import java.time.LocalDateTime;

@Data
public class TaskVO {
    Long taskId;
    Long taskListId;
    String title;
    LocalDateTime deadline;
    Integer estimateMin;
    String description;
    PeriodDay periodDay;
    Boolean isToday = false;
    Boolean isCompleted = false;
    LocalDateTime completedDate;
    Integer displayOrder = 0;
    Integer todayOrder = 0;
}
