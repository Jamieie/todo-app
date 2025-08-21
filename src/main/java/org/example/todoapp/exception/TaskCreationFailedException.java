package org.example.todoapp.exception;

public class TaskCreationFailedException extends RuntimeException {
    public TaskCreationFailedException(String message) {
        super(message);
    }
}