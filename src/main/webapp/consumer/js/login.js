// 카카오 SDK 초기화 (실제 앱 키로)
Kakao.init('3bf3d351d8918cfb697025b177345dba'); // 실제 카카오 개발자센터에서 받은 키로 변경

// 페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    // 저장된 아이디 불러오기
    loadRememberedUserId();
    
    // 로그인 폼 제출 이벤트
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();
        submitLogin();
    });
    
    // 엔터키로 로그인
    document.getElementById('password').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            submitLogin();
        }
    });
});

// 비밀번호 보기/숨기기 토글
function togglePassword() {
    const passwordInput = document.getElementById('password');
    const toggleIcon = document.querySelector('.toggle-icon');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleIcon.textContent = '🙈';
    } else {
        passwordInput.type = 'password';
        toggleIcon.textContent = '👁';
    }
}

// 일반 로그인 처리
function submitLogin() {
    const userId = document.getElementById('userId').value.trim();
    const password = document.getElementById('password').value.trim();
    const rememberMe = document.getElementById('rememberMe').checked;
    
    // 유효성 검사
    if (!userId) {
        alert('아이디를 입력해주세요.');
        document.getElementById('userId').focus();
        return;
    }
    
    if (!password) {
        alert('비밀번호를 입력해주세요.');
        document.getElementById('password').focus();
        return;
    }
    
    // 아이디 기억하기 처리
    if (rememberMe) {
        localStorage.setItem('rememberedUserId', userId);
    } else {
        localStorage.removeItem('rememberedUserId');
    }
    
    // 폼 제출
    document.getElementById('loginForm').submit();
}

// 저장된 아이디 불러오기
function loadRememberedUserId() {
    const rememberedUserId = localStorage.getItem('rememberedUserId');
    if (rememberedUserId) {
        document.getElementById('userId').value = rememberedUserId;
        document.getElementById('rememberMe').checked = true;
        document.getElementById('password').focus();
    } else {
        document.getElementById('userId').focus();
    }
}

// 카카오 로그인
function loginWithKakao() {
    Kakao.Auth.login({
        success: function(response) {
            console.log('카카오 로그인 성공:', response);
            
            // 사용자 정보 가져오기
            Kakao.API.request({
                url: '/v2/user/me',
                success: function(response) {
                    console.log('사용자 정보:', response);
                    
                    // 서버로 카카오 로그인 정보 전송
                    const kakaoData = {
                        id: response.id,
                        email: response.kakao_account?.email,
                        nickname: response.properties?.nickname,
                        profile_image: response.properties?.profile_image
                    };
                    
                    // 서버로 카카오 로그인 데이터 전송
                    sendKakaoDataToServer(kakaoData);
                },
                fail: function(error) {
                    console.error('사용자 정보 가져오기 실패:', error);
                    alert('카카오 로그인 중 오류가 발생했습니다.');
                }
            });
        },
        fail: function(error) {
            console.error('카카오 로그인 실패:', error);
            alert('카카오 로그인에 실패했습니다.');
        }
    });
}

// 서버로 카카오 로그인 데이터 전송
function sendKakaoDataToServer(kakaoData) {
    // 서버의 카카오 로그인 처리 URL로 데이터 전송
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = contextPath + '/user/kakaoLogin';
    
    // 카카오 데이터를 hidden input으로 추가
    Object.keys(kakaoData).forEach(key => {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = key;
        input.value = kakaoData[key] || '';
        form.appendChild(input);
    });
    
    document.body.appendChild(form);
    form.submit();
}

// 전역 변수로 컨텍스트 패스 설정 (JSP에서 설정해야 함)
const contextPath = '${pageContext.request.contextPath}';