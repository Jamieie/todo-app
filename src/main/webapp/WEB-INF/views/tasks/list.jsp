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
    <title>All Tasks - Todo App</title>
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
        
        .tasks-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .tasklist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .header-controls {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .toggle-completed {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #000000;
        }
        
        .toggle-switch {
            position: relative;
            width: 50px;
            height: 24px;
            background: #e9ecef;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        .toggle-switch.active {
            background: #000000;
        }
        
        .toggle-slider {
            position: absolute;
            top: 2px;
            left: 2px;
            width: 20px;
            height: 20px;
            background: #ffffff;
            border-radius: 50%;
            transition: transform 0.3s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .toggle-switch.active .toggle-slider {
            transform: translateX(26px);
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
        
        /* TaskList 그룹 */
        .tasklist-group {
            background: #ffffff;
            border: 1px solid #e9ecef;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            height: fit-content;
        }
        
        .tasklist-header {
            font-size: 20px;
            font-weight: 600;
            color: #000000;
            margin-bottom: 20px;
            padding: 15px 0;
            border-bottom: 2px solid #e9ecef;
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
            background: #f8f9fa;
        }
        
        .task-card.completed {
            background: #f8f9fa;
            opacity: 0.7;
            border-left-color: #adb5bd;
        }
        
        .task-card.completed .task-title {
            text-decoration: line-through;
            color: #6c757d;
        }
        
        .task-card.completed .task-meta {
            color: #adb5bd;
        }
        
        .task-card.today {
            border-left-color: #000000;
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
        
        .today-badge {
            background: #000000;
            color: #ffffff;
            font-size: 10px;
            padding: 2px 8px;
            border-radius: 12px;
            font-weight: 500;
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
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .period-badge {
            background: #e9ecef;
            color: #000000;
            font-size: 10px;
            padding: 2px 6px;
            border-radius: 8px;
            font-weight: 500;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #adb5bd;
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
            
            .tasklist-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="../common/sidebar.jsp" %>

        <!-- 메인 영역 -->
        <div class="main-area">
            <div class="tasks-container">
                <div class="section-header">
                    <h1 class="section-title">📋 모든 할 일</h1>
                    <div class="header-controls">
                        <div class="toggle-completed">
                            <span>완료된 할 일 표시</span>
                            <div class="toggle-switch" id="showCompletedToggle" onclick="toggleShowCompleted()">
                                <div class="toggle-slider"></div>
                            </div>
                        </div>
                        <button class="add-task-btn" onclick="showCreateTaskModal()" title="새 Task 추가">
                            +
                        </button>
                    </div>
                </div>

                <!-- 전체 빈 상태 -->
                <c:if test="${empty tasks}">
                    <div class="empty-state">아직 생성된 할 일이 없습니다. 새 Task를 추가해보세요!</div>
                </c:if>

                <!-- TaskList별 Task 그룹을 그리드로 표시 -->
                <c:if test="${not empty tasks}">
                    <div class="tasklist-grid">
                        <!-- TaskList별로 그룹핑하여 표시 -->
                        <c:set var="processedTaskLists" value=""/>
                        <c:forEach var="taskListName" items="${fn:split('', '')}">
                            <c:set var="currentTaskListName" value=""/>
                            <c:forEach var="task" items="${tasks}">
                                <c:if test="${empty currentTaskListName or currentTaskListName != task.taskListName}">
                                    <c:set var="currentTaskListName" value="${task.taskListName}"/>
                                    <c:if test="${not fn:contains(processedTaskLists, task.taskListName)}">
                                        <c:set var="processedTaskLists" value="${processedTaskLists},${task.taskListName}"/>
                                        
                                        <!-- TaskList 그룹 시작 -->
                                        <div class="tasklist-group">
                                            <div class="tasklist-header">📁 ${task.taskListName}</div>
                                            
                                            <!-- 해당 TaskList의 모든 Task들 -->
                                            <c:set var="hasTasksInList" value="false"/>
                                            <c:forEach var="taskInList" items="${tasks}">
                                                <c:if test="${taskInList.taskListName == task.taskListName}">
                                                    <c:set var="hasTasksInList" value="true"/>
                                                    <div class="task-card ${taskInList.isCompleted ? 'completed' : ''} ${taskInList.isToday ? 'today' : ''}" onclick="openTaskDetail(${taskInList.taskId}); return false;" data-completed="${taskInList.isCompleted}">
                                                        <div class="task-header">
                                                            <button class="toggle-btn ${taskInList.isCompleted ? 'completed' : ''}" 
                                                                    onclick="event.stopPropagation(); toggleTask(${taskInList.taskId}); return false;"
                                                                    title="완료 토글">
                                                                ${taskInList.isCompleted ? '✓' : '○'}
                                                            </button>
                                                            <div class="task-title">${taskInList.title}</div>
                                                            <c:if test="${taskInList.isToday}">
                                                                <span class="today-badge">오늘</span>
                                                            </c:if>
                                                            <button class="delete-btn" 
                                                                    onclick="event.stopPropagation(); deleteTaskDirectly(${taskInList.taskId}); return false;"
                                                                    title="삭제">
                                                                🗑️
                                                            </button>
                                                        </div>
                                                        <div class="task-meta">
                                                            <c:if test="${not empty taskInList.estimateMin}">⏱️ ${taskInList.estimateMin}분</c:if>
                                                            <c:if test="${not empty taskInList.deadline}"> • 📅 ${fn:substring(taskInList.deadline, 0, 10)}</c:if>
                                                            <c:if test="${taskInList.isToday and not empty taskInList.periodDay}">
                                                                <span class="period-badge">
                                                                    <c:choose>
                                                                        <c:when test="${taskInList.periodDay == 'MORNING'}">🌅 오전</c:when>
                                                                        <c:when test="${taskInList.periodDay == 'AFTERNOON'}">🌞 오후</c:when>
                                                                        <c:when test="${taskInList.periodDay == 'NIGHT'}">🌙 저녁</c:when>
                                                                    </c:choose>
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            
                                            <!-- TaskList에 Task가 없을 때 -->
                                            <c:if test="${not hasTasksInList}">
                                                <div class="empty-state">할 일이 없습니다</div>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </c:if>
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
                        <input type="checkbox" id="taskIsToday" class="form-checkbox">
                        <label class="form-label" for="taskIsToday" style="margin-bottom: 0;">오늘 할 일로 설정</label>
                    </div>
                </div>
                
                <div class="form-group" id="periodDayGroup" style="display: none;">
                    <label class="form-label" for="taskPeriodDay">시간대 *</label>
                    <select id="taskPeriodDay" class="form-select">
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
        
        // 완료된 할 일 표시 토글
        let showCompleted = true; // 기본적으로 완료된 할 일도 표시
        
        function toggleShowCompleted() {
            showCompleted = !showCompleted;
            const toggle = document.getElementById('showCompletedToggle');
            
            if (showCompleted) {
                toggle.classList.add('active');
            } else {
                toggle.classList.remove('active');
            }
            
            // 완료된 Task 카드들 표시/숨김
            const completedTasks = document.querySelectorAll('.task-card[data-completed="true"]');
            completedTasks.forEach(taskCard => {
                if (showCompleted) {
                    taskCard.style.display = 'block';
                } else {
                    taskCard.style.display = 'none';
                }
            });
            
            // 각 TaskList 그룹에서 빈 상태 확인
            checkEmptyTaskLists();
        }
        
        function checkEmptyTaskLists() {
            const tasklistGroups = document.querySelectorAll('.tasklist-group');
            tasklistGroups.forEach(group => {
                const visibleTasks = group.querySelectorAll('.task-card:not([style*="display: none"])');
                const emptyState = group.querySelector('.empty-state');
                
                if (visibleTasks.length === 0) {
                    if (!emptyState) {
                        const emptyDiv = document.createElement('div');
                        emptyDiv.className = 'empty-state';
                        emptyDiv.textContent = showCompleted ? '할 일이 없습니다' : '미완료 할 일이 없습니다';
                        group.appendChild(emptyDiv);
                    } else {
                        emptyState.textContent = showCompleted ? '할 일이 없습니다' : '미완료 할 일이 없습니다';
                        emptyState.style.display = 'block';
                    }
                } else {
                    if (emptyState) {
                        emptyState.style.display = 'none';
                    }
                }
            });
        }
        
        // 페이지 로드 시 토글 상태 초기화
        document.addEventListener('DOMContentLoaded', function() {
            const toggle = document.getElementById('showCompletedToggle');
            if (showCompleted) {
                toggle.classList.add('active');
            }
        });
    </script>

    <!-- 알림 모달 -->
    <%@ include file="../common/alert-modal.jsp" %>
</body>
</html>