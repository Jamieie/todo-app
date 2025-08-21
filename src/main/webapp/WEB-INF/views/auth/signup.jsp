<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - Todo App</title>
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
            padding: 1rem;
        }

        .signup-container {
            background: #ffffff;
            border: 1px solid #e9ecef;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
        }

        .signup-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .signup-header h1 {
            color: #000000;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .signup-header p {
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

        .form-group input.error {
            border-color: #dc3545;
        }

        .form-group .field-error {
            color: #dc3545;
            font-size: 0.8rem;
            margin-top: 0.25rem;
        }

        .password-requirements {
            font-size: 0.8rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }

        .signup-btn {
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

        .signup-btn:hover {
            transform: translateY(-2px);
            background: #495057;
        }

        .signup-btn:active {
            transform: translateY(0);
        }

        .signup-btn:disabled {
            background: #adb5bd;
            color: #dee2e6;
            cursor: not-allowed;
            transform: none;
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

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .login-link a {
            color: #000000;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="signup-header">
            <h1>Todo App</h1>
            <p>새 계정을 만들어 시작하세요</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="success-message">
                ${success}
            </div>
        </c:if>

        <form action="/auth/signup" method="post" id="signupForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" required 
                       placeholder="이름을 입력하세요" 
                       value="${param.name}"
                       maxlength="100">
                <c:if test="${not empty fieldErrors.name}">
                    <div class="field-error">${fieldErrors.name}</div>
                </c:if>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required 
                       placeholder="이메일을 입력하세요" 
                       value="${param.email}">
                <c:if test="${not empty fieldErrors.email}">
                    <div class="field-error">${fieldErrors.email}</div>
                </c:if>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required 
                       placeholder="비밀번호를 입력하세요"
                       minlength="8">
                <div class="password-requirements">
                    8자 이상, 영문, 숫자, 특수문자 포함
                </div>
                <c:if test="${not empty fieldErrors.password}">
                    <div class="field-error">${fieldErrors.password}</div>
                </c:if>
            </div>

            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required 
                       placeholder="비밀번호를 다시 입력하세요"
                       minlength="8">
                <c:if test="${not empty fieldErrors.confirmPassword}">
                    <div class="field-error">${fieldErrors.confirmPassword}</div>
                </c:if>
            </div>

            <button type="submit" class="signup-btn">계정 만들기</button>
        </form>

        <div class="login-link">
            이미 계정이 있으신가요? <a href="/auth/login">로그인</a>
        </div>
    </div>

    <script>
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('비밀번호가 일치하지 않습니다.');
                return false;
            }
            
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
            if (!passwordRegex.test(password)) {
                e.preventDefault();
                alert('비밀번호는 8자 이상이며, 영문, 숫자, 특수문자를 포함해야 합니다.');
                return false;
            }
        });

        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password && confirmPassword && password !== confirmPassword) {
                this.classList.add('error');
            } else {
                this.classList.remove('error');
            }
        });
    </script>
</body>
</html>