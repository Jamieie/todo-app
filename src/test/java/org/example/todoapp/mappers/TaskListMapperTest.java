package org.example.todoapp.mappers;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.math.BigInteger;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("classpath:spring/test-root-context.xml")
class TaskListMapperTest {

    @Autowired(required = false)
    private TaskListMapper taskListMapper;

    @BeforeEach
    void setUp() {
        // TODO) TEST USER insert
        // TODO) TEST TASKLIST insert
    }

    @Test
    void testFindNameByIdAndUserId() {
        String userId = "test-user-uuid";
        Long taskListId = 1L;

        boolean present = taskListMapper.findNameByIdAndUserId(taskListId, userId).isPresent();
        assertTrue(present);
    }
}