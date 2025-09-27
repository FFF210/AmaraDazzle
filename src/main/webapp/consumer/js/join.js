// 페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    // 폼 제출 이벤트
    document.getElementById('joinForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateForm()) {
            this.submit();
        }
    });
    
    // 실시간 유효성 검사
    document.getElementById('userId').addEventListener('blur', validateUserId);
    document.getElementById('password').addEventListener('blur', validatePassword);
    document.getElementById('passwordConfirm').addEventListener('blur', validatePasswordConfirm);
    document.getElementById('phoneNumber').addEventListener('blur', validatePhoneNumber);
});

// 아이디 중복 확인
function checkUserId() {
    const userId = document.getElementById('userId').value.trim();
    const messageEl = document.getElementById('userIdMessage');
    
    if (!userId) {
        showMessage(messageEl, '아이디를 입력해주세요.', 'error');
        return;
    }
    
    if (!validateUserIdFormat(userId)) {
        showMessage(messageEl, '아이디는 영문, 숫자 조합으로 4-20자로 입력해주세요.', 'error');
        return;
    }
    
    // 서버로 중복 확인 요청
    fetch(contextPath + '/user/checkUserId', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'userId=' + encodeURIComponent(userId)
    })
    .then(response => response.json())
    .then(data => {
        if (data.available) {
            showMessage(messageEl, '사용 가능한 아이디입니다.', 'success');
        } else {
            showMessage(messageEl, '이미 사용 중인 아이디입니다.', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showMessage(messageEl, '중복 확인 중 오류가 발생했습니다.', 'error');
    });
}

// 카카오 우편번호 서비스
function findPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById('address').value = addr + extraAddr;
            
            // 상세주소 필드로 포커스를 이동한다.
            document.getElementById('detailAddress').focus();
        },
        // 팝업 크기 설정
        width: '100%',
        height: '100%'
    }).open();
}

// 아이디 유효성 검사
function validateUserId() {
    const userId = document.getElementById('userId').value.trim();
    const messageEl = document.getElementById('userIdMessage');
    
    if (!userId) {
        showMessage(messageEl, '아이디를 입력해주세요.', 'error');
        return false;
    }
    
    if (!validateUserIdFormat(userId)) {
        showMessage(messageEl, '아이디는 영문, 숫자 조합으로 4-20자로 입력해주세요.', 'error');
        return false;
    }
    
    showMessage(messageEl, '', '');
    return true;
}

// 아이디 형식 검사
function validateUserIdFormat(userId) {
    const regex = /^[a-zA-Z0-9]{4,20}$/;
    return regex.test(userId);
}

// 비밀번호 유효성 검사
function validatePassword() {
    const password = document.getElementById('password').value;
    const messageEl = document.getElementById('passwordMessage');
    
    if (!password) {
        showMessage(messageEl, '비밀번호를 입력해주세요.', 'error');
        return false;
    }
    
    if (password.length < 8 || password.length > 20) {
        showMessage(messageEl, '비밀번호는 8-20자로 입력해주세요.', 'error');
        return false;
    }
    
    const regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]/;
    if (!regex.test(password)) {
        showMessage(messageEl, '비밀번호는 영문, 숫자, 특수문자를 포함해야 합니다.', 'error');
        return false;
    }
    
    showMessage(messageEl, '사용 가능한 비밀번호입니다.', 'success');
    return true;
}

// 비밀번호 확인
function validatePasswordConfirm() {
    const password = document.getElementById('password').value;
    const passwordConfirm = document.getElementById('passwordConfirm').value;
    const messageEl = document.getElementById('passwordConfirmMessage');
    
    if (!passwordConfirm) {
        showMessage(messageEl, '비밀번호를 다시 입력해주세요.', 'error');
        return false;
    }
    
    if (password !== passwordConfirm) {
        showMessage(messageEl, '비밀번호가 일치하지 않습니다.', 'error');
        return false;
    }
    
    showMessage(messageEl, '비밀번호가 일치합니다.', 'success');
    return true;
}

// 휴대폰 번호 유효성 검사
function validatePhoneNumber() {
    const phoneNumber = document.getElementById('phoneNumber').value.trim();
    
    if (!phoneNumber) {
        return false;
    }
    
    const regex = /^01[016789]-?\d{3,4}-?\d{4}$/;
    return regex.test(phoneNumber);
}

// 전체 폼 유효성 검사
function validateForm() {
    const requiredFields = [
        { id: 'userId', message: '아이디를 입력해주세요.' },
        { id: 'password', message: '비밀번호를 입력해주세요.' },
        { id: 'passwordConfirm', message: '비밀번호 확인을 입력해주세요.' },
        { id: 'userName', message: '이름을 입력해주세요.' },
        { id: 'nickname', message: '닉네임을 입력해주세요.' },
        { id: 'phoneNumber', message: '휴대폰 번호를 입력해주세요.' },
        { id: 'postcode', message: '주소를 입력해주세요.' }
    ];
    
    // 필수 필드 검사
    for (let field of requiredFields) {
        const element = document.getElementById(field.id);
        if (!element.value.trim()) {
            alert(field.message);
            element.focus();
            return false;
        }
    }
    
    // 개별 유효성 검사
    if (!validateUserId() || !validatePassword() || !validatePasswordConfirm()) {
        return false;
    }
    
    // 휴대폰 번호 형식 검사
    if (!validatePhoneNumber()) {
        alert('올바른 휴대폰 번호를 입력해주세요.');
        document.getElementById('phoneNumber').focus();
        return false;
    }
    
    // 약관 동의 확인
    const requiredTerms = ['termsRequired', 'termsService', 'termsAge'];
    for (let termId of requiredTerms) {
        if (!document.getElementById(termId).checked) {
            alert('필수 약관에 동의해주세요.');
            return false;
        }
    }
    
    return true;
}

// 메시지 표시 함수
function showMessage(element, message, type) {
    element.textContent = message;
    element.className = 'validation-message';
    if (type) {
        element.classList.add(type);
    }
}

// 약관 보기
function showTerms(type) {
    // 실제로는 모달이나 새 창으로 약관을 보여줘야 하는데 우리는 패스할듯
    alert('약관 내용을 보여주는 페이지로 이동합니다.');
}

// 전역 변수로 컨텍스트 패스 설정
const contextPath = document.querySelector('script[src*="join.js"]')
    .getAttribute('src').replace('/resources/js/join.js', '');