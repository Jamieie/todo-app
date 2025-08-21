package org.example.todoapp.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.example.todoapp.common.enums.PeriodDay;

import java.time.LocalDateTime;

@Data
public class CreateTaskResponseDTO {

    Long taskId;
    String taskListName;
    String title;
    String description;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    LocalDateTime deadline;
    Integer estimateMin;
    Boolean isToday;
    PeriodDay periodDay;
    Integer displayOrder;
    Integer todayOrder;

}
