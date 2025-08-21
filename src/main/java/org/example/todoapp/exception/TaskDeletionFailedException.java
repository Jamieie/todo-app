package org.example.todoapp.exception;

public class TaskDeletionFailedException extends RuntimeException {
    public TaskDeletionFailedException(String message) {
        super(message);
    }
}