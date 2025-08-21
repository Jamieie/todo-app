package org.example.todoapp.domain;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.example.todoapp.common.enums.PeriodDay;

@Data
public class MoveToTodayRequestDTO {
    @NotNull
    private PeriodDay periodDay;
}
