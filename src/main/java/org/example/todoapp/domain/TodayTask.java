package org.example.todoapp.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.example.todoapp.common.enums.PeriodDay;

import java.time.LocalDateTime;

@Data
public class TodayTask {
    private Long taskId;
    private String title;
    private String taskListName;
    private PeriodDay periodDay;
    private Integer estimateMin;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime deadline;
    private Integer todayOrder;
    private Boolean isCompleted;
}
