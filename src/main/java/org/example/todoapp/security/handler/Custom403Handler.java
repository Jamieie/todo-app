package org.example.todoapp.security.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import java.io.IOException;

@Log4j2
public class Custom403Handler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        log.info("===================Custom 403 Handler=====================");
        log.info("Access denied: {}", accessDeniedException.getMessage());
        
        // 403 상태 코드 설정
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        
        // JSP 페이지로 포워드
        request.getRequestDispatcher("/WEB-INF/views/error/403.jsp").forward(request, response);
    }
}
