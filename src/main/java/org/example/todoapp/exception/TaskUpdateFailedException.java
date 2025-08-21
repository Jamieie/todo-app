package org.example.todoapp.exception;

public class TaskUpdateFailedException extends RuntimeException {
    public TaskUpdateFailedException(String message) {
        super(message);
    }
}
