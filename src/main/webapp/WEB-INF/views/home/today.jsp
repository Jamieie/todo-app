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
    <title>Today - Todo App</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <!-- 사이드바 스타일 -->
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
            min-height: 100vh;
        }
        
        .container {
            display: flex;
            min-height: 100vh;
        }
        
        /* 메인 영역 */
        .main-area {
            flex: 1;
            background: #ffffff;
            min-height: 100vh;
            padding: 30px;
        }
        
        .today-container {
            max-width: 900px;
            margin: 0 auto;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 32px;
            font-weight: 600;
            color: #000000;
            margin: 0;
        }
        
        .add-task-btn {
            width: 40px;
            height: 40px;
            border: 2px solid #000000;
            border-radius: 50%;
            background: #ffffff;
            color: #000000;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            flex-shrink: 0;
        }
        
        .add-task-btn:hover {
            background: #000000;
            color: #ffffff;
            transform: scale(1.1);
        }
        
        /* Task 카드 */
        .task-card {
            background: #ffffff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-left: 4px solid #000000;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .task-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
            border-color: #cccccc;
        }
        
        .task-card.completed {
            background: #f8f9fa;
            opacity: 0.7;
            border-left-color: #999999;
        }
        
        .task-card.completed .task-title {
            text-decoration: line-through;
            color: #666666;
        }
        
        .task-card.completed .task-meta {
            color: #999999;
        }
        
        .task-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 5px;
        }
        
        .task-title {
            font-size: 16px;
            font-weight: 500;
            color: #000000;
            flex: 1;
        }
        
        .toggle-btn {
            width: 24px;
            height: 24px;
            border: 2px solid #000000;
            border-radius: 50%;
            background: #ffffff;
            color: #000000;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            flex-shrink: 0;
        }
        
        .toggle-btn:hover {
            background: #000000;
            color: #ffffff;
            transform: scale(1.1);
        }
        
        .toggle-btn.completed {
            background: #000000;
            border-color: #000000;
            color: #ffffff;
        }
        
        .delete-btn {
            width: 24px;
            height: 24px;
            border: 2px solid #dc3545;
            border-radius: 50%;
            background: #ffffff;
            color: #dc3545;
            font-size: 12px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            flex-shrink: 0;
        }
        
        .delete-btn:hover {
            background: #dc3545;
            color: #ffffff;
            transform: scale(1.1);
        }
        
        .task-meta {
            font-size: 12px;
            color: #666666;
        }
        
        .period-group {
            margin-bottom: 40px;
        }
        
        .period-header {
            font-size: 20px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 20px;
            padding: 15px 0;
            border-bottom: 2px solid #e9ecef;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #999999;
            font-style: italic;
        }
        
        /* Task 생성 모달 스타일 */
        .create-task-modal .modal-content {
            max-width: 500px;
            text-align: left;
            margin: 5% auto;
            max-height: 90vh;
            overflow-y: auto;
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
            min-height: 80px;
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
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }
        
        .modal-title {
            font-size: 18px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 15px;
        }
        
        .modal-message {
            font-size: 14px;
            color: #666666;
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
            background: #333333;
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
            border: 1px solid #e9ecef;
        }
        
        .modal-btn-secondary:hover {
            background: #e9ecef;
        }
        
        /* 드래그 앤 드롭 스타일 */
        .task-card[draggable="true"] {
            cursor: move;
        }
        
        .task-card.dragging {
            opacity: 0.5;
            transform: rotate(3deg);
            z-index: 1000;
        }
        
        .period-group {
            transition: all 0.3s ease;
        }
        
        .period-tasks {
            min-height: 80px;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .period-tasks.drag-over {
            background-color: rgba(0, 0, 0, 0.05);
            border: 2px dashed #000000;
            transform: scale(1.02);
        }
        
        .period-tasks.drag-invalid {
            background-color: rgba(255, 0, 0, 0.05);
            border: 2px dashed #dc3545;
        }
        
        .drag-placeholder {
            height: 2px;
            background: #000000;
            margin: 5px 0;
            border-radius: 1px;
            opacity: 0;
            transition: opacity 0.2s ease;
        }
        
        .drag-placeholder.show {
            opacity: 1;
        }
        
        @media (max-width: 768px) {
            .container {
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
            
            .main-area {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="../common/sidebar.jsp" %>

        <!-- 메인 영역 -->
        <div class="main-area">
            <div class="today-container">
                <div class="section-header">
                    <h1 class="section-title">📅 오늘 할 일</h1>
                    <button class="add-task-btn" onclick="showCreateTaskModal()" title="새 Task 추가">
                        +
                    </button>
                </div>

                <!-- 오전 -->
                <div class="period-group" data-period="MORNING">
                    <div class="period-header">🌅 오전</div>
                    <div class="period-tasks dropzone" data-period="MORNING">
                        <c:set var="morningTaskFound" value="false"/>
                        <c:forEach var="task" items="${todayTasks}">
                            <c:if test="${task.periodDay == 'MORNING'}">
                                <c:set var="morningTaskFound" value="true"/>
                                <div class="task-card ${task.isCompleted ? 'completed' : ''}" 
                                     draggable="true" 
                                     data-task-id="${task.taskId}" 
                                     data-period="MORNING"
                                     onclick="openTaskDetail(${task.taskId}); return false;">
                                    <div class="task-header">
                                        <button class="toggle-btn ${task.isCompleted ? 'completed' : ''}" 
                                                onclick="event.stopPropagation(); toggleTask(${task.taskId}); return false;"
                                                title="완료 토글">
                                            ${task.isCompleted ? '✓' : '○'}
                                        </button>
                                        <div class="task-title">${task.title}</div>
                                        <button class="delete-btn" 
                                                onclick="event.stopPropagation(); deleteTaskDirectly(${task.taskId}); return false;"
                                                title="삭제">
                                            🗑️
                                        </button>
                                    </div>
                                    <div class="task-meta">
                                        📁 ${task.taskListName}
                                        <c:if test="${not empty task.estimateMin}"> • ⏱️ ${task.estimateMin}분</c:if>
                                        <c:if test="${not empty task.deadline}"> • 📅 ${fn:substring(task.deadline, 0, 10)}</c:if>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${!morningTaskFound}">
                            <div class="empty-state">오전에 할 일이 없습니다</div>
                        </c:if>
                    </div>
                </div>

                <!-- 오후 -->
                <div class="period-group" data-period="AFTERNOON">
                    <div class="period-header">🌞 오후</div>
                    <div class="period-tasks dropzone" data-period="AFTERNOON">
                        <c:set var="afternoonTaskFound" value="false"/>
                        <c:forEach var="task" items="${todayTasks}">
                            <c:if test="${task.periodDay == 'AFTERNOON'}">
                                <c:set var="afternoonTaskFound" value="true"/>
                                <div class="task-card ${task.isCompleted ? 'completed' : ''}" 
                                     draggable="true" 
                                     data-task-id="${task.taskId}" 
                                     data-period="AFTERNOON"
                                     onclick="openTaskDetail(${task.taskId}); return false;">
                                    <div class="task-header">
                                        <button class="toggle-btn ${task.isCompleted ? 'completed' : ''}" 
                                                onclick="event.stopPropagation(); toggleTask(${task.taskId}); return false;"
                                                title="완료 토글">
                                            ${task.isCompleted ? '✓' : '○'}
                                        </button>
                                        <div class="task-title">${task.title}</div>
                                        <button class="delete-btn" 
                                                onclick="event.stopPropagation(); deleteTaskDirectly(${task.taskId}); return false;"
                                                title="삭제">
                                            🗑️
                                        </button>
                                    </div>
                                    <div class="task-meta">
                                        📁 ${task.taskListName}
                                        <c:if test="${not empty task.estimateMin}"> • ⏱️ ${task.estimateMin}분</c:if>
                                        <c:if test="${not empty task.deadline}"> • 📅 ${fn:substring(task.deadline, 0, 10)}</c:if>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${!afternoonTaskFound}">
                            <div class="empty-state">오후에 할 일이 없습니다</div>
                        </c:if>
                    </div>
                </div>

                <!-- 저녁 -->
                <div class="period-group" data-period="NIGHT">
                    <div class="period-header">🌙 저녁</div>
                    <div class="period-tasks dropzone" data-period="NIGHT">
                        <c:set var="nightTaskFound" value="false"/>
                        <c:forEach var="task" items="${todayTasks}">
                            <c:if test="${task.periodDay == 'NIGHT'}">
                                <c:set var="nightTaskFound" value="true"/>
                                <div class="task-card ${task.isCompleted ? 'completed' : ''}" 
                                     draggable="true" 
                                     data-task-id="${task.taskId}" 
                                     data-period="NIGHT"
                                     onclick="openTaskDetail(${task.taskId}); return false;">
                                    <div class="task-header">
                                        <button class="toggle-btn ${task.isCompleted ? 'completed' : ''}" 
                                                onclick="event.stopPropagation(); toggleTask(${task.taskId}); return false;"
                                                title="완료 토글">
                                            ${task.isCompleted ? '✓' : '○'}
                                        </button>
                                        <div class="task-title">${task.title}</div>
                                        <button class="delete-btn" 
                                                onclick="event.stopPropagation(); deleteTaskDirectly(${task.taskId}); return false;"
                                                title="삭제">
                                            🗑️
                                        </button>
                                    </div>
                                    <div class="task-meta">
                                        📁 ${task.taskListName}
                                        <c:if test="${not empty task.estimateMin}"> • ⏱️ ${task.estimateMin}분</c:if>
                                        <c:if test="${not empty task.deadline}"> • 📅 ${fn:substring(task.deadline, 0, 10)}</c:if>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${!nightTaskFound}">
                            <div class="empty-state">저녁에 할 일이 없습니다</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="createTaskModal" class="modal create-task-modal">
        <div class="modal-content">
            <div class="modal-title">새 Task 생성</div>
            <form id="createTaskForm">
                <div class="form-group">
                    <label class="form-label" for="taskTitle">제목 *</label>
                    <input type="text" id="taskTitle" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="taskListSelect">Task List *</label>
                    <select id="taskListSelect" class="form-select" required>
                        <option value="">Task List 선택</option>
                        <c:forEach var="taskList" items="${taskListNames}">
                            <option value="${taskList.taskListId}" ${taskList.isDefault ? 'selected' : ''}>
                                ${taskList.name}${taskList.isDefault ? ' (기본)' : ''}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="taskDescription">설명</label>
                    <textarea id="taskDescription" class="form-textarea" placeholder="Task에 대한 상세 설명을 입력하세요"></textarea>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="taskDeadline">마감일</label>
                    <input type="datetime-local" id="taskDeadline" class="form-input">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="taskEstimate">예상 시간 (분)</label>
                    <input type="number" id="taskEstimate" class="form-input" min="1" placeholder="30">
                </div>
                
                <div class="form-group">
                    <div class="form-checkbox-group">
                        <input type="checkbox" id="taskIsToday" class="form-checkbox" checked>
                        <label class="form-label" for="taskIsToday" style="margin-bottom: 0;">오늘 할 일로 설정</label>
                    </div>
                </div>
                
                <div class="form-group" id="periodDayGroup">
                    <label class="form-label" for="taskPeriodDay">시간대 *</label>
                    <select id="taskPeriodDay" class="form-select" required>
                        <option value="">시간대 선택</option>
                        <option value="MORNING">🌅 오전</option>
                        <option value="AFTERNOON">🌞 오후</option>
                        <option value="NIGHT">🌙 저녁</option>
                    </select>
                </div>
            </form>
            
            <div class="modal-buttons">
                <button class="modal-btn modal-btn-primary" onclick="createTask()">생성</button>
                <button class="modal-btn modal-btn-secondary" onclick="closeCreateTaskModal()">취소</button>
            </div>
        </div>
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
        
        // Task List 데이터 (서버에서 전달받은 기본 데이터)
        let taskListData = [
            <c:forEach var="taskList" items="${taskListNames}" varStatus="status">
                {
                    taskListId: ${taskList.taskListId},
                    name: "${taskList.name}",
                    isDefault: ${taskList.isDefault}
                }${!status.last ? ',' : ''}
            </c:forEach>
        ];
        
        
        // Task List 드롭다운 업데이트 함수
        function updateTaskListDropdown(taskLists) {
            const select = document.getElementById('taskListSelect');
            const currentValue = select.value;
            
            // 기존 옵션들 제거 (첫 번째 "Task List 선택" 옵션 제외)
            while (select.children.length > 1) {
                select.removeChild(select.lastChild);
            }
            
            // 새 옵션들 추가
            taskLists.forEach(taskList => {
                const option = document.createElement('option');
                option.value = taskList.taskListId;
                option.textContent = taskList.name + (taskList.isDefault ? ' (기본)' : '');
                if (taskList.isDefault && !currentValue) {
                    option.selected = true;
                }
                select.appendChild(option);
            });
            
            // 이전 선택값이 있다면 복원
            if (currentValue) {
                select.value = currentValue;
            }
        }
        
        // API에서 최신 Task List 목록 가져오기
        async function refreshTaskLists() {
            try {
                const response = await fetch('/task-lists');
                if (response.ok) {
                    const result = await response.json();
                    if (result.taskListNames) {
                        taskListData = result.taskListNames;
                        updateTaskListDropdown(taskListData);
                    }
                }
            } catch (error) {
                console.warn('Task List 갱신 실패:', error);
                // 실패 시 기본 데이터 사용 (사용자에게는 알리지 않음)
            }
        }
        
        // Task 생성 모달 관련 함수들
        function showCreateTaskModal() {
            document.getElementById('createTaskModal').style.display = 'block';
            document.getElementById('createTaskForm').reset();
            
            // Today 페이지에서는 기본적으로 오늘 할 일로 설정하고 시간대 필수
            document.getElementById('taskIsToday').checked = true;
            document.getElementById('periodDayGroup').style.display = 'block';
            
            // 기본 데이터로 드롭다운 초기화
            updateTaskListDropdown(taskListData);
            
            // 백그라운드에서 최신 데이터 가져오기 (필요시만)
            refreshTaskLists();
        }
        
        function closeCreateTaskModal() {
            document.getElementById('createTaskModal').style.display = 'none';
        }
        
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
        
        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            const createTaskModal = document.getElementById('createTaskModal');
            if (event.target === createTaskModal) {
                closeCreateTaskModal();
            }
        }
        
        function openTaskDetail(taskId) {
            if (taskId && taskId !== 'undefined' && taskId !== '' && taskId !== 'null') {
                window.location.href = '/tasks/' + taskId;
            } else {
                console.error('Task ID가 유효하지 않습니다. 받은 값:', taskId);
            }
        }
        
        async function toggleTask(taskId) {
            if (!taskId || taskId === 'undefined' || taskId === '' || taskId === 'null') {
                console.error('Task ID가 유효하지 않습니다:', taskId);
                return;
            }
            
            try {
                const url = '/tasks/' + taskId + '/toggle';
                
                const response = await fetch(url, {
                    method: 'PUT',
                    headers: getCSRFHeaders()
                });
                
                if (response.ok) {
                    // 성공 시 페이지 새로고침
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
        
        async function deleteTaskDirectly(taskId) {
            if (!taskId || taskId === 'undefined' || taskId === '' || taskId === 'null') {
                console.error('Task ID가 유효하지 않습니다:', taskId);
                return;
            }
            
            try {
                const url = '/tasks/' + taskId;
                
                const response = await fetch(url, {
                    method: 'DELETE',
                    headers: getCSRFHeaders()
                });
                
                if (response.ok) {
                    // 성공 시 페이지 새로고침
                    location.reload();
                } else {
                    const errorData = await response.json();
                    console.error('Task 삭제에 실패했습니다:', errorData.message || '알 수 없는 오류');
                }
            } catch (error) {
                console.error('Delete error:', error);
                console.error('네트워크 오류가 발생했습니다.');
            }
        }
        
        async function createTask() {
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
                deadline: deadline ? deadline + ':00' : null, // LocalDateTime 형식으로 변환
                estimateMin: estimateMin ? parseInt(estimateMin) : null,
                isToday: isToday,
                periodDay: periodDay || null
            };
            
            try {
                const response = await fetch('/tasks', {
                    method: 'POST',
                    headers: getCSRFHeaders(),
                    body: JSON.stringify(taskData)
                });
                
                if (response.ok) {
                    const result = await response.json();
                    
                    // 성공 시 모달 닫고 페이지 새로고침
                    closeCreateTaskModal();
                    location.reload();
                } else {
                    const errorData = await response.json();
                    console.error('Task 생성에 실패했습니다:', errorData.message || '알 수 없는 오류');
                }
            } catch (error) {
                console.error('Create task error:', error);
                console.error('네트워크 오류가 발생했습니다.');
            }
        }
        
        // 드래그 앤 드롭 관련 변수
        let draggedTask = null;
        let draggedTaskId = null;
        let originalPeriod = null;
        
        // 드래그 앤 드롭 초기화
        function initializeDragAndDrop() {
            // 모든 task 카드에 드래그 이벤트 리스너 추가
            const taskCards = document.querySelectorAll('.task-card[draggable="true"]');
            taskCards.forEach(card => {
                card.addEventListener('dragstart', handleDragStart);
                card.addEventListener('dragend', handleDragEnd);
            });

            // 모든 드롭 존에 이벤트 리스너 추가
            const dropZones = document.querySelectorAll('.dropzone');
            dropZones.forEach(zone => {
                zone.addEventListener('dragover', handleDragOver);
                zone.addEventListener('dragenter', handleDragEnter);
                zone.addEventListener('dragleave', handleDragLeave);
                zone.addEventListener('drop', handleDrop);
            });
        }

        // 드래그 시작
        function handleDragStart(e) {
            draggedTask = this;
            draggedTaskId = this.dataset.taskId;
            originalPeriod = this.dataset.period;
            
            this.classList.add('dragging');
            e.dataTransfer.effectAllowed = 'move';
            e.dataTransfer.setData('text/html', this.outerHTML);
            
            // 클릭 이벤트 무시
            e.stopPropagation();
        }

        // 드래그 종료
        function handleDragEnd(e) {
            this.classList.remove('dragging');
            
            // 모든 드롭 존의 하이라이트 제거
            document.querySelectorAll('.dropzone').forEach(zone => {
                zone.classList.remove('drag-over', 'drag-invalid');
            });
            
            draggedTask = null;
            draggedTaskId = null;
            originalPeriod = null;
        }

        // 드래그 오버 (드롭 존 위에서)
        function handleDragOver(e) {
            e.preventDefault();
            e.dataTransfer.dropEffect = 'move';
        }

        // 드래그 엔터 (드롭 존 진입)
        function handleDragEnter(e) {
            e.preventDefault();
            const targetPeriod = this.dataset.period;
            
            // 같은 시간대가 아닌 경우만 드롭 허용
            if (targetPeriod !== originalPeriod) {
                this.classList.add('drag-over');
                this.classList.remove('drag-invalid');
            } else {
                this.classList.add('drag-invalid');
                this.classList.remove('drag-over');
            }
        }

        // 드래그 리브 (드롭 존 벗어남)
        function handleDragLeave(e) {
            // 자식 요소로 이동하는 경우는 무시
            const rect = this.getBoundingClientRect();
            const x = e.clientX;
            const y = e.clientY;
            
            if (x < rect.left || x > rect.right || y < rect.top || y > rect.bottom) {
                this.classList.remove('drag-over', 'drag-invalid');
            }
        }

        // 드롭 (실제 드롭 발생)
        async function handleDrop(e) {
            e.preventDefault();
            
            const targetPeriod = this.dataset.period;
            
            // 같은 시간대에는 드롭 불가
            if (targetPeriod === originalPeriod) {
                console.log('같은 시간대로는 이동할 수 없습니다.');
                this.classList.remove('drag-over', 'drag-invalid');
                return;
            }
            
            // 시각적 피드백 제거
            this.classList.remove('drag-over', 'drag-invalid');
            
            try {
                // API 호출하여 periodDay 변경
                const response = await fetch('/tasks/' + draggedTaskId + '/move-to-today', {
                    method: 'PUT',
                    headers: getCSRFHeaders(),
                    body: JSON.stringify({
                        periodDay: targetPeriod
                    })
                });
                
                if (response.ok) {
                    // 성공 시 페이지 새로고침
                    location.reload();
                } else {
                    const errorData = await response.json();
                    console.error('Task 이동에 실패했습니다:', errorData.message || '알 수 없는 오류');
                }
            } catch (error) {
                console.error('Move task error:', error);
                console.error('네트워크 오류가 발생했습니다.');
            }
        }
        
        // 페이지 로드 시 드래그 앤 드롭 초기화
        document.addEventListener('DOMContentLoaded', function() {
            initializeDragAndDrop();
        });
    </script>

    <!-- 알림 모달 -->
    <%@ include file="../common/alert-modal.jsp" %>
</body>
</html>
