package org.example.todoapp.domain;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.example.todoapp.common.enums.PeriodDay;

import java.time.LocalDateTime;

@Data
public class UpdateTaskRequestDTO {

    @NotNull
    String title;
    @NotNull
    Long taskListId;

    String description;
    LocalDateTime deadline;
    Integer estimateMin;
    Boolean isToday;
    PeriodDay periodDay;
}
