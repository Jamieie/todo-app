<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오류 - Todo App</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "Noto Sans KR", sans-serif;
            background: #ffffff;
            color: #000000;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .error-container {
            text-align: center;
            background: #ffffff;
            border: 1px solid #e9ecef;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            max-width: 600px;
            width: 90%;
        }
        
        .error-icon {
            font-size: 80px;
            margin-bottom: 20px;
            color: #000000;
        }
        
        .error-title {
            font-size: 36px;
            color: #000000;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .error-message {
            font-size: 18px;
            color: #6c757d;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .error-details {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            border-left: 4px solid #000000;
            text-align: left;
            border: 1px solid #dee2e6;
        }
        
        .error-code {
            font-size: 14px;
            color: #000000;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .error-description {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 10px;
        }
        
        .error-timestamp {
            font-size: 12px;
            color: #adb5bd;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: #000000;
            color: #ffffff;
        }
        
        .btn-primary:hover {
            background: #495057;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        
        .btn-secondary {
            background: #e9ecef;
            color: #000000;
        }
        
        .btn-secondary:hover {
            background: #dee2e6;
            color: #000000;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(222, 226, 230, 0.5);
        }
        
        .error-footer {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
            font-size: 12px;
            color: #adb5bd;
        }
        
        @media (max-width: 768px) {
            .error-container {
                padding: 30px 20px;
            }
            
            .error-title {
                font-size: 28px;
            }
            
            .error-message {
                font-size: 16px;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">😵</div>
        
        <h1 class="error-title">앗, 오류가 발생했습니다!</h1>
        
        <p class="error-message">
            요청을 처리하는 중에 문제가 발생했습니다.<br>
            잠시 후 다시 시도해주시거나 홈페이지로 돌아가세요.
        </p>
        
        <div class="error-details">
            <div class="error-code">
                오류 코드: ${status != null ? status : 'INTERNAL_SERVER_ERROR'}
            </div>
            <div class="error-description">
                요청 URL: ${pageContext.errorData.requestURI != null ? pageContext.errorData.requestURI : 'Unknown'}
            </div>
            <div class="error-description">
                오류 설명: ${message != null ? message : 'Unknown'}
            </div>
            <div class="error-timestamp">
                발생 시간: <%= new java.util.Date() %>
            </div>
        </div>
        
        <div class="action-buttons">
            <a href="/dashboard" class="btn btn-primary">
                <span>🏠</span>
                <span>홈으로 돌아가기</span>
            </a>
            <button onclick="history.back()" class="btn btn-secondary">
                <span>←</span>
                <span>이전 페이지</span>
            </button>
            <button onclick="location.reload()" class="btn btn-secondary">
                <span>🔄</span>
                <span>새로고침</span>
            </button>
        </div>
        
        <div class="error-footer">
            문제가 지속될 경우 관리자에게 문의해주세요.
        </div>
    </div>
</body>
</html>