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
    <title>Task Edit - Todo App</title>
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
            max-width: 800px;
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
        
        .page-header {
            margin-bottom: 30px;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 600;
            color: #000000;
            margin-bottom: 8px;
        }
        
        .page-subtitle {
            font-size: 1.1rem;
            color: #6c757d;
        }
        
        .form-container {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #dee2e6;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: #000000;
            margin-bottom: 8px;
        }
        
        .form-input, .form-textarea, .form-select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e9ecef;
            border-radius: 6px;
            font-size: 14px;
            background: #ffffff;
            color: #000000;
            transition: border-color 0.3s ease;
        }
        
        .form-input:focus, .form-textarea:focus, .form-select:focus {
            outline: none;
            border-color: #000000;
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        .form-checkbox-group {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-checkbox {
            width: 18px;
            height: 18px;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
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
        }
        
        .btn-secondary {
            background: #e9ecef;
            color: #000000;
        }
        
        .btn-secondary:hover {
            background: #dee2e6;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
        
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
        
        .modal-btn-secondary {
            background: #f8f9fa;
            color: #000000;
            border: 1px solid #dee2e6;
        }
        
        .modal-btn-secondary:hover {
            background: #e9ecef;
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
                <button onclick="history.back()" class="back-button">
                    <span>←</span>
                    <span>뒤로 가기</span>
                </button>
                
                <div class="page-header">
                    <h1 class="page-title">✏️ Task 수정</h1>
                    <p class="page-subtitle">Task 정보를 수정하세요</p>
                </div>
                
                <div class="form-container">
                    <form id="editTaskForm">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="form-group">
                            <label class="form-label" for="taskTitle">제목 *</label>
                            <input type="text" id="taskTitle" class="form-input" value="${taskDetail.title}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="taskListSelect">Task List *</label>
                            <select id="taskListSelect" class="form-select" required>
                                <option value="">Task List 선택</option>
                                <c:forEach var="taskList" items="${taskListNames}">
                                    <option value="${taskList.taskListId}" ${taskList.taskListId == taskDetail.taskListId ? 'selected' : ''}>
                                        ${taskList.name}${taskList.isDefault ? ' (기본)' : ''}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="taskDescription">설명</label>
                            <textarea id="taskDescription" class="form-textarea" placeholder="Task에 대한 상세 설명을 입력하세요">${taskDetail.description}</textarea>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="taskDeadline">마감일</label>
                            <input type="datetime-local" id="taskDeadline" class="form-input" value="${fn:substring(taskDetail.deadline, 0, 16)}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="taskEstimate">예상 시간 (분)</label>
                            <input type="number" id="taskEstimate" class="form-input" min="1" value="${taskDetail.estimateMin}" placeholder="30">
                        </div>
                        
                        <div class="form-group">
                            <div class="form-checkbox-group">
                                <input type="checkbox" id="taskIsToday" class="form-checkbox" ${taskDetail.isToday ? 'checked' : ''}>
                                <label class="form-label" for="taskIsToday" style="margin-bottom: 0;">오늘 할 일로 설정</label>
                            </div>
                        </div>
                        
                        <div class="form-group" id="periodDayGroup" style="display: ${taskDetail.isToday ? 'block' : 'none'};">
                            <label class="form-label" for="taskPeriodDay">시간대 *</label>
                            <select id="taskPeriodDay" class="form-select">
                                <option value="">시간대 선택</option>
                                <option value="MORNING" ${taskDetail.periodDay == 'MORNING' ? 'selected' : ''}>🌅 오전</option>
                                <option value="AFTERNOON" ${taskDetail.periodDay == 'AFTERNOON' ? 'selected' : ''}>🌞 오후</option>
                                <option value="NIGHT" ${taskDetail.periodDay == 'NIGHT' ? 'selected' : ''}>🌙 저녁</option>
                            </select>
                        </div>
                    </form>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-danger" onclick="deleteTaskDirectly()">
                            🗑️ 삭제
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="history.back()">
                            취소
                        </button>
                        <button type="button" class="btn btn-primary" onclick="updateTask()">
                            💾 저장
                        </button>
                    </div>
                </div>
            </div>
        </main>
    </div>


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
        
        
        // 오늘 할 일 체크박스 변경 시 시간대 선택 표시/숨김
        document.getElementById('taskIsToday').addEventListener('change', function() {
            const periodGroup = document.getElementById('periodDayGroup');
            if (this.checked) {
                periodGroup.style.display = 'block';
            } else {
                periodGroup.style.display = 'none';
                document.getElementById('taskPeriodDay').value = '';
            }
        });
        
        // Task 수정
        async function updateTask() {
            // 폼 데이터 수집
            const title = document.getElementById('taskTitle').value.trim();
            const taskListId = document.getElementById('taskListSelect').value;
            const description = document.getElementById('taskDescription').value.trim();
            const deadline = document.getElementById('taskDeadline').value;
            const estimateMin = document.getElementById('taskEstimate').value;
            const isToday = document.getElementById('taskIsToday').checked;
            const periodDay = document.getElementById('taskPeriodDay').value;
            
            // 유효성 검사
            if (!title) {
                showAlertModal('알림', '제목을 입력해주세요.');
                return;
            }
            
            if (!taskListId) {
                showAlertModal('알림', 'Task List를 선택해주세요.');
                return;
            }
            
            if (isToday && !periodDay) {
                showAlertModal('알림', '오늘 할 일로 설정하려면 시간대를 선택해주세요.');
                return;
            }
            
            // 요청 데이터 구성
            const taskData = {
                title: title,
                taskListId: parseInt(taskListId),
                description: description || null,
                deadline: deadline ? deadline + ':00' : null,
                estimateMin: estimateMin ? parseInt(estimateMin) : null,
                isToday: isToday,
                periodDay: periodDay || null
            };
            
            try {
                const response = await fetch('/tasks/' + taskId, {
                    method: 'PUT',
                    headers: getCSRFHeaders(),
                    body: JSON.stringify(taskData)
                });
                
                if (response.ok) {
                    // 캐시를 방지하기 위해 타임스탬프 추가
                    window.location.href = '/tasks/' + taskId + '?updated=' + Date.now();
                } else {
                    const errorData = await response.json();
                    console.error('Task 수정에 실패했습니다:', errorData.message || '알 수 없는 오류');
                }
            } catch (error) {
                console.error('Update task error:', error);
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
                    window.location.href = '/tasks';
                } else {
                    const errorData = await response.json();
                    console.error('Task 삭제에 실패했습니다:', errorData.message || '알 수 없는 오류');
                }
            } catch (error) {
                console.error('Delete error:', error);
                console.error('네트워크 오류가 발생했습니다.');
            }
        }
        
    </script>

    <!-- 알림 모달 -->
    <%@ include file="../common/alert-modal.jsp" %>
</body>
</html>
