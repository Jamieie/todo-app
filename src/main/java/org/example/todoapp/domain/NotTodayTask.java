package org.example.todoapp.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class NotTodayTask {
    private Long taskId;
    private String taskListName;
    private String title;
    private Integer estimateMin;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime deadline;
    private Integer displayOrder;
}
