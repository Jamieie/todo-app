<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Task Detail - Todo App</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <%@ include file="../common/sidebar-styles.jsp" %>

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
        }
        
        .app-container {
            display: flex;
            height: 100vh;
        }
        
        /* 메인 컨텐츠 */
        .main-content {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
            background: #ffffff;
        }
        
        .container {
            max-width: 900px;
            background: #ffffff;
            border: 1px solid #e9ecef;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            margin: 0 auto;
        }
        
        .back-button {
            display: inline-block;
            padding: 8px 16px;
            background: #000000;
            color: #ffffff;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .back-button:hover {
            background: #495057;
            transform: translateY(-2px);
        }
        
        .task-header {
            background: #f8f9fa;
            color: #000000;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            position: relative;
            border: 1px solid #dee2e6;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .task-header h1 {
            font-size: 2rem;
            margin-bottom: 8px;
            font-weight: 600;
        }
        
        .task-header .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        .task-actions {
            position: absolute;
            top: 25px;
            right: 25px;
            display: flex;
            gap: 10px;
        }
        
        .action-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .edit-btn {
            background: #000000;
            color: #ffffff;
            border: 2px solid #000000;
        }
        
        .edit-btn:hover {
            background: #495057;
            transform: translateY(-2px);
        }
        
        .delete-btn {
            background: rgba(220, 53, 69, 0.8);
            color: white;
            border: 2px solid rgba(220, 53, 69, 0.3);
        }
        
        .delete-btn:hover {
            background: #dc3545;
            transform: translateY(-2px);
        }
        
        .task-body {
            padding: 20px;
        }
        
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .detail-item {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            border-left: 4px solid #000000;
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }
        
        .detail-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .label {
            font-weight: 600;
            color: #000000;
            margin-bottom: 8px;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .value {
            font-size: 1rem;
            color: #000000;
            line-height: 1.5;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .status-completed {
            background: #000000;
            color: #ffffff;
        }
        
        .status-pending {
            background: #e9ecef;
            color: #000000;
        }
        
        .toggle-btn {
            background: #000000;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .toggle-btn:hover {
            background: #495057;
            transform: translateY(-2px);
        }
        
        .period-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            background: #e9ecef;
            color: #000000;
        }
        
        .today-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .today-yes {
            background: #000000;
            color: #ffffff;
        }
        
        .today-no {
            background: #e9ecef;
            color: #6c757d;
        }
        
        .description-content {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            margin-top: 5px;
            white-space: pre-wrap;
            line-height: 1.6;
            color: #000000;
        }
        
        .empty-value {
            color: #adb5bd;
            font-style: italic;
        }
        
        @media (max-width: 768px) {
            .app-container {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
                height: auto;
                padding: 20px;
            }
            
            .nav-menu {
                display: flex;
                justify-content: space-around;
            }
            
            .nav-item {
                margin-bottom: 0;
            }
            
            .main-content {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="app-container">
        <%@ include file="../common/sidebar.jsp" %>

        <!-- 메인 컨텐츠 -->
        <main class="main-content">
            <div class="container">
                <a href="/tasks" class="back-button">← Task 목록</a>
<%--                <button onclick="history.back()" class="back-button">--%>
<%--                    <span>←</span>--%>
<%--                    <span>뒤로 가기</span>--%>
<%--                </button>--%>
                
                <div class="task-header">
                    <div class="task-actions">
                        <button class="action-btn edit-btn" onclick="editTask()">
                            ✏️ 수정
                        </button>
                        <button class="action-btn delete-btn" onclick="deleteTaskDirectly()">
                            🗑️ 삭제
                        </button>
                    </div>
                    <h1>${taskDetail.title}</h1>
                    <p class="subtitle">📁 ${taskDetail.taskListName}</p>
                </div>
                
                <div class="task-body">
                    <div class="detail-grid">
                        <div class="detail-item">
                            <div class="label">완료 상태</div>
                            <div class="value">
                                <div class="status-badge ${taskDetail.isCompleted ? 'status-completed' : 'status-pending'}">
                                    ${taskDetail.isCompleted ? '✓ 완료됨' : '○ 진행중'}
                                </div>
                                <button class="toggle-btn" onclick="toggleTaskStatus()">
                                    ${taskDetail.isCompleted ? '진행중으로 변경' : '완료로 변경'}
                                </button>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="label">마감일</div>
                            <div class="value">
                                <c:choose>
                                    <c:when test="${not empty taskDetail.deadline}">
                                        📅 ${fn:substring(taskDetail.deadline, 0, 16)}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">설정되지 않음</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="label">예상 시간</div>
                            <div class="value">
                                <c:choose>
                                    <c:when test="${not empty taskDetail.estimateMin}">
                                        ⏱️ ${taskDetail.estimateMin}분
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">설정되지 않음</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="label">시간대</div>
                            <div class="value">
                                <c:choose>
                                    <c:when test="${not empty taskDetail.periodDay}">
                                        <span class="period-badge">
                                            <c:choose>
                                                <c:when test="${taskDetail.periodDay == 'MORNING'}">🌅 오전</c:when>
                                                <c:when test="${taskDetail.periodDay == 'AFTERNOON'}">🌞 오후</c:when>
                                                <c:when test="${taskDetail.periodDay == 'NIGHT'}">🌙 저녁</c:when>
                                                <c:otherwise>${taskDetail.periodDay}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">설정되지 않음</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="label">오늘 할 일</div>
                            <div class="value">
                                <span class="today-badge ${taskDetail.isToday ? 'today-yes' : 'today-no'}">
                                    ${taskDetail.isToday ? '📅 예' : '📋 아니오'}
                                </span>
                            </div>
                        </div>
                        
                        <div class="detail-item">
                            <div class="label">완료일</div>
                            <div class="value">
                                <c:choose>
                                    <c:when test="${not empty taskDetail.completedDate}">
                                        🎉 ${fn:substring(taskDetail.completedDate, 0, 16)}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-value">완료되지 않음</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="label">설명</div>
                        <div class="value">
                            <c:choose>
                                <c:when test="${not empty taskDetail.description}">
                                    <div class="description-content">${taskDetail.description}</div>
                                </c:when>
                                <c:otherwise>
                                    <span class="empty-value">설명이 없습니다</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>


    <style>
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        
        .modal-content {
            background-color: #ffffff;
            border: 1px solid #e9ecef;
            margin: 10% auto;
            padding: 30px;
            border-radius: 12px;
            width: 90%;
            max-width: 400px;
            max-height: 80vh;
            overflow-y: auto;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        
        .modal-title {
            font-size: 18px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 15px;
        }
        
        .modal-message {
            font-size: 14px;
            color: #495057;
            margin-bottom: 25px;
            line-height: 1.5;
        }
        
        .modal-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .modal-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .modal-btn-primary {
            background: #000000;
            color: #ffffff;
        }
        
        .modal-btn-primary:hover {
            background: #495057;
        }
        
        .modal-btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .modal-btn-danger:hover {
            background: #c82333;
        }
        
        .modal-btn-secondary {
            background: #f8f9fa;
            color: #000000;
            border: 1px solid #dee2e6;
        }
        
        .modal-btn-secondary:hover {
            background: #e9ecef;
        }
    </style>

    <script>
        // CSRF 토큰 관련 함수
        function getCSRFToken() {
            return document.querySelector('meta[name="_csrf"]').getAttribute('content');
        }
        
        function getCSRFHeader() {
            return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
        }
        
        function getCSRFHeaders() {
            const headers = {
                'Content-Type': 'application/json'
            };
            headers[getCSRFHeader()] = getCSRFToken();
            return headers;
        }
        
        const taskId = ${taskDetail.taskId};
        
        
        // Task 완료 상태 토글
        async function toggleTaskStatus() {
            try {
                const response = await fetch('/tasks/' + taskId + '/toggle', {
                    method: 'PUT',
                    headers: getCSRFHeaders()
                });
                
                if (response.ok) {
                    location.reload();
                } else {
                    const errorData = await response.json();
                    console.error('완료 상태 변경에 실패했습니다:', errorData.message || '알 수 없는 오류');
                }
            } catch (error) {
                console.error('Toggle error:', error);
                console.error('네트워크 오류가 발생했습니다.');
            }
        }
        
        // Task 삭제
        async function deleteTaskDirectly() {
            try {
                const response = await fetch('/tasks/' + taskId, {
                    method: 'DELETE',
                    headers: getCSRFHeaders()
                });
                
                if (response.ok) {
                    // 삭제 후 이전 페이지 판단하여 적절한 페이지로 이동 (캐시 문제 방지)
                    const referrer = document.referrer;
                    if (referrer.includes('/dashboard')) {
                        window.location.href = '/dashboard';
                    } else if (referrer.includes('/today')) {
                        window.location.href = '/today';
                    } else {
                        window.location.href = '/tasks';
                    }
                } else {
                    const errorData = await response.json();
                    console.error('Task 삭제에 실패했습니다:', errorData.message || '알 수 없는 오류');
                }
            } catch (error) {
                console.error('Delete error:', error);
                console.error('네트워크 오류가 발생했습니다.');
            }
        }
        
        // Task 수정 페이지로 이동
        function editTask() {
            window.location.href = '/tasks/' + taskId + '/edit';
        }
        
    </script>
</body>
</html>