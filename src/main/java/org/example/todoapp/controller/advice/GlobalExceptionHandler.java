package org.example.todoapp.controller.advice;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.example.todoapp.exception.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    // 인증 실패 : 로그인 페이지로 리다이렉트
    @ExceptionHandler(AuthenticationFailedException.class)
    public ModelAndView handleAuthenticationFailedException(AuthenticationFailedException e) {
        ModelAndView mav = new ModelAndView("auth/login");
        mav.setStatus(HttpStatus.UNAUTHORIZED);
        mav.addObject("error", e.getMessage());
        return mav;
    }

    // 이메일 중복 : 409 Conflict
    @ExceptionHandler(EmailAlreadyExistsException.class)
    public ModelAndView handleEmailAlreadyExistsException(EmailAlreadyExistsException e) {
        ModelAndView mav = new ModelAndView("auth/signup");
        mav.setStatus(HttpStatus.CONFLICT);
        mav.addObject("error", e.getMessage());
        return mav;
    }

    // 회원가입 실패 : 회원가입 페이지로 리다이렉트
    @ExceptionHandler(SignupFailedException.class)
    public ModelAndView handleSignupFailedException(SignupFailedException e) {
        ModelAndView mav = new ModelAndView("auth/signup");
        mav.setStatus(HttpStatus.BAD_REQUEST);
        mav.addObject("error", e.getMessage());
        return mav;
    }

    // 회원가입 유효성 검사 실패 : 회원가입 페이지로 리다이렉트
    @ExceptionHandler(SignupValidationException.class)
    public ModelAndView handleSignupValidationException(SignupValidationException e) {
        ModelAndView mav = new ModelAndView("auth/signup");
        mav.setStatus(HttpStatus.BAD_REQUEST);
        mav.addObject("error", e.getMessage());
        return mav;
    }

    // 생성 요청한 task의 데이터가 비즈니스 규칙 위반으로 유효하지 않음 : 422
    @ExceptionHandler(InvalidTaskDataException.class)
    public ResponseEntity<?> handleInvalidTaskDataException(InvalidTaskDataException e) {
        return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).
                header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).
                body(
                        Map.of("code", "INVALID_TASK_DATA",
                                "message", e.getMessage()
                        ));
    }

    // 리소스(TaskList, Task)가 존재하지 않음 : 404
    @ExceptionHandler({TaskListNotFoundException.class, TaskNotFoundException.class})
    public Object handleResourceNotFoundException(Exception e, HttpServletRequest request) {

        String accept = request.getHeader(HttpHeaders.ACCEPT);
        boolean wantsHtml = accept != null && accept.contains(MediaType.TEXT_HTML_VALUE);

        if (wantsHtml) {
            // FIXME) 404 (NOT_FOUND) 페이지 만들어서 교체하기
            ModelAndView mav = new ModelAndView("error/500");
            mav.setStatus(HttpStatus.NOT_FOUND);
            mav.addObject("status", HttpStatus.NOT_FOUND);
            mav.addObject("message", e.getMessage());
            return mav;
        }

        String code = "";
        if (e instanceof TaskNotFoundException) {
            code = "TASK_NOT_FOUND";
        }
        if (e instanceof TaskListNotFoundException) {
            code = "TASK_LIST_NOT_FOUND";
        }

        return ResponseEntity.status(HttpStatus.NOT_FOUND).
                header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).
                body(
                        Map.of("code", code,
                                "message", e.getMessage()
                        ));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleException(Exception e) {

        log.info("===================================");
        log.info("Exception: {}", e.getClass().getSimpleName());
        log.error(e.getMessage(), e);

        // FIXME) 에러 페이지 생성 후 에러 페이지 반환으로 바꾸기
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).
                header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).
                body(
                Map.of("code", "INTERNAL_SERVER_ERROR",
                        "message", e.getMessage()
        ));
    }

    // TODO) 요청 관련한 예외 세분화해서 처리하기
}
