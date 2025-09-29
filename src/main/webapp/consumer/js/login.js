// 페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    
    // 폼 요소 가져오기
    const loginForm = document.getElementById('loginForm');
    const loginIdInput = document.getElementById('loginId');
    const loginPwInput = document.getElementById('loginPw');
    const rememberCheckbox = document.querySelector('input[name="rememberId"]');
    
    // 저장된 아이디 불러오기
    const savedId = localStorage.getItem('savedLoginId');
    if (savedId) {
        loginIdInput.value = savedId;
        rememberCheckbox.checked = true;
    }
    
    // 폼 제출 시 유효성 검사
    loginForm.addEventListener('submit', function(e) {
        const loginId = loginIdInput.value.trim();
        const loginPw = loginPwInput.value.trim();
        
        // 아이디 빈 값 체크
        if (loginId === '') {
            alert('아이디를 입력해주세요.');
            loginIdInput.focus();
            e.preventDefault();
            return false;
        }
        
        // 비밀번호 빈 값 체크
        if (loginPw === '') {
            alert('비밀번호를 입력해주세요.');
            loginPwInput.focus();
            e.preventDefault();
            return false;
        }
        
        // 아이디 기억하기 처리
        if (rememberCheckbox.checked) {
            localStorage.setItem('savedLoginId', loginId);
        } else {
            localStorage.removeItem('savedLoginId');
        }
        
        // 폼 제출 진행
        return true;
    });
});

// URL 파라미터에서 에러 메시지 확인
window.addEventListener('load', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');
    
    if (error) {
        let errorMessage = '';
        
        switch(error) {
            case '1':
            case 'no_code':
                errorMessage = '카카오 인증 코드가 없습니다.';
                break;
            case '2':
            case 'process_failed':
                errorMessage = '로그인 처리 중 오류가 발생했습니다.';
                break;
            case 'kakao_auth_failed':
                errorMessage = '카카오 인증에 실패했습니다.';
                break;
            case 'invalid_code':
                errorMessage = '유효하지 않은 인증 코드입니다.';
                break;
            case 'token_error':
                errorMessage = '토큰 처리 중 오류가 발생했습니다.';
                break;
            default:
                errorMessage = '로그인에 실패했습니다.';
        }
        
        if (errorMessage) {
            alert(errorMessage);
        }
    }
});