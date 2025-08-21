<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 알림 모달 -->
<div id="alertModal" class="alert-modal" style="display: none;">
    <div class="alert-modal-content">
        <div class="alert-modal-header">
            <h3 id="alertModalTitle">알림</h3>
        </div>
        <div class="alert-modal-body">
            <p id="alertModalMessage">메시지가 여기에 표시됩니다.</p>
        </div>
        <div class="alert-modal-footer">
            <button type="button" class="alert-modal-btn" onclick="closeAlertModal()">확인</button>
        </div>
    </div>
</div>

<style>
    /* 알림 모달 스타일 */
    .alert-modal {
        display: none;
        position: fixed;
        z-index: 2000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        animation: fadeIn 0.2s ease-out;
    }
    
    .alert-modal-content {
        background-color: #ffffff;
        margin: 15% auto;
        padding: 0;
        border-radius: 12px;
        width: 90%;
        max-width: 400px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        animation: slideIn 0.3s ease-out;
    }
    
    .alert-modal-header {
        padding: 20px 24px 16px 24px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .alert-modal-header h3 {
        margin: 0;
        font-size: 18px;
        font-weight: 600;
        color: #000000;
    }
    
    .alert-modal-body {
        padding: 20px 24px;
    }
    
    .alert-modal-body p {
        margin: 0;
        font-size: 14px;
        line-height: 1.5;
        color: #333333;
    }
    
    .alert-modal-footer {
        padding: 16px 24px 20px 24px;
        text-align: right;
        border-top: 1px solid #e9ecef;
    }
    
    .alert-modal-btn {
        background: #000000;
        color: #ffffff;
        border: none;
        padding: 10px 20px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 80px;
    }
    
    .alert-modal-btn:hover {
        background: #333333;
        transform: translateY(-1px);
    }
    
    .alert-modal-btn:active {
        transform: translateY(0);
    }
    
    /* 애니메이션 */
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    @keyframes slideIn {
        from { 
            opacity: 0;
            transform: translateY(-30px) scale(0.9);
        }
        to { 
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }
</style>

<script>
    function showAlertModal(title, message) {
        document.getElementById('alertModalTitle').textContent = title;
        document.getElementById('alertModalMessage').textContent = message;
        document.getElementById('alertModal').style.display = 'block';
        
        // ESC 키로 닫기
        document.addEventListener('keydown', handleAlertModalKeyPress);
    }
    
    function closeAlertModal() {
        document.getElementById('alertModal').style.display = 'none';
        document.removeEventListener('keydown', handleAlertModalKeyPress);
    }
    
    function handleAlertModalKeyPress(event) {
        if (event.key === 'Escape') {
            closeAlertModal();
        }
    }
    
    // 모달 외부 클릭 시 닫기
    document.addEventListener('click', function(event) {
        const modal = document.getElementById('alertModal');
        if (event.target === modal) {
            closeAlertModal();
        }
    });
</script>