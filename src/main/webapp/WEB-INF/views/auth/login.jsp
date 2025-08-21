<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - Todo App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: #ffffff;
            color: #000000;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: #ffffff;
            border: 1px solid #e9ecef;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h1 {
            color: #000000;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #000000;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            background: #ffffff;
            color: #000000;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #000000;
        }

        .login-btn {
            width: 100%;
            padding: 0.75rem;
            background: #000000;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            background: #495057;
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .info-message {
            background: #cce7ff;
            color: #004085;
            border: 1px solid #b3d9ff;
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .signup-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .signup-link a {
            color: #000000;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>Todo App</h1>
            <p>로그인하여 할 일을 관리하세요</p>
        </div>

        <c:if test="${not empty error or not empty sessionScope.error}">
            <div class="error-message">
                ${not empty sessionScope.error ? sessionScope.error : error}
            </div>
        </c:if>
        
        <!-- 에러 메시지를 표시한 후 세션에서 제거 -->
        <c:if test="${not empty sessionScope.error}">
            <c:remove var="error" scope="session"/>
        </c:if>

        <c:if test="${not empty success}">
            <div class="success-message">
                ${success}
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="info-message">
                ${message}
            </div>
        </c:if>

        <form action="/auth/login" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required 
                       placeholder="이메일을 입력하세요" 
                       value="${param.email}">
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required 
                       placeholder="비밀번호를 입력하세요">
            </div>

            <button type="submit" class="login-btn">로그인</button>
        </form>

        <div class="signup-link">
            아직 계정이 없으신가요? <a href="/auth/signup">회원가입</a>
        </div>
    </div>
</body>
</html>
