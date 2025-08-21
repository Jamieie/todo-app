<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    // 현재 페이지 경로를 request에서 추출
    String currentPage = request.getRequestURI();
    if (currentPage == null) {
        currentPage = "";
    }
    pageContext.setAttribute("currentPage", currentPage);
%>

<aside class="sidebar">
    <h2>Todo App</h2>
    <nav class="nav-menu">
        <ul>
            <li class="nav-item">
                <a href="/dashboard" class="nav-link ${currentPage.contains('/dashboard') ? 'active' : ''}">
                    <i>🏠</i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="/today" class="nav-link ${currentPage.contains('/today') ? 'active' : ''}">
                    <i>📅</i>
                    <span>Today</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="/tasks" class="nav-link ${currentPage.contains('/tasks') ? 'active' : ''}">
                    <i>📋</i>
                    <span>Tasks</span>
                </a>
            </li>
        </ul>
    </nav>
    
    <!-- 로그아웃 버튼 -->
    <div class="logout-section">
        <form action="/auth/logout" method="post" id="logoutForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="logout-btn">
                <i>🚪</i>
                <span>로그아웃</span>
            </button>
        </form>
    </div>
</aside>