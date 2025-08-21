<style>
    /* 사이드바 */
    .sidebar {
        width: 280px;
        height: 100vh;
        background: #f8f9fa;
        border-right: 1px solid #e9ecef;
        padding: 30px 20px;
        box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        display: flex;
        flex-direction: column;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        overflow-y: auto;
    }
    
    .sidebar h2 {
        color: #000000;
        margin-bottom: 30px;
        font-size: 24px;
        text-align: center;
    }
    
    .nav-menu {
        flex: 1;
    }
    
    .nav-menu ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }
    
    .nav-item {
        margin-bottom: 15px;
    }
    
    .nav-link {
        display: flex;
        align-items: center;
        padding: 15px 20px;
        color: #000000;
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-size: 16px;
    }
    
    .nav-link:hover {
        background-color: rgba(0,0,0,0.1);
        transform: translateX(5px);
    }
    
    .nav-link.active {
        background-color: rgba(0,0,0,0.15);
    }
    
    .nav-link i {
        margin-right: 12px;
        font-size: 18px;
    }
    
    /* 로그아웃 섹션 */
    .logout-section {
        margin-top: auto;
        border-top: 1px solid #e9ecef;
        padding-top: 20px;
    }
    
    .logout-btn {
        display: flex;
        align-items: center;
        width: 100%;
        padding: 15px 20px;
        background: none;
        border: none;
        color: #dc3545;
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s ease;
        font-size: 16px;
        cursor: pointer;
    }
    
    .logout-btn:hover {
        background-color: rgba(220, 53, 69, 0.1);
        transform: translateX(5px);
    }
    
    .logout-btn i {
        margin-right: 12px;
        font-size: 18px;
    }
    
    /* 메인 콘텐츠 영역을 사이드바 만큼 밀어내기 */
    .container,
    .app-container {
        margin-left: 280px;
    }
    
    .main-area,
    .main-content {
        width: 100%;
    }
    
    /* 모바일 반응형 */
    @media (max-width: 768px) {
        .sidebar {
            width: 100%;
            height: auto;
            flex-direction: row;
            padding: 20px;
            position: relative;
            top: auto;
            left: auto;
        }
        
        .container,
        .app-container {
            margin-left: 0;
        }
        
        .nav-menu {
            display: flex;
            justify-content: space-around;
        }
        
        .nav-menu ul {
            display: flex;
            gap: 20px;
        }
        
        .nav-item {
            margin-bottom: 0;
        }
        
        .logout-section {
            margin-top: 0;
            margin-left: auto;
            border-top: none;
            border-left: 1px solid #e9ecef;
            padding-top: 0;
            padding-left: 20px;
        }
    }
</style>