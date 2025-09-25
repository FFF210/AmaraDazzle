/*// 상태(실서비스라면 서버에서 주입)
let remainQuota = 5498;
let quotaLimit = 10000;

// 요소 캐시
const $tabs = document.querySelectorAll('.tab');
const $templateType = document.getElementById('templateType');
const $couponBox = document.getElementById('couponBox');

const $reserveRadios = document.querySelectorAll('input[name="sendType"]');
const $reserveBox = document.getElementById('reserveBox');
const $reserveDate = document.getElementById('reserveDate');
const $reserveTime = document.getElementById('reserveTime');

const $couponIssueLabel = document.getElementById('couponIssueLabel');
const $couponIssueField = document.getElementById('couponIssueField');

const $btnSend = document.getElementById('btnSend');
const $btnExample = document.getElementById('btnExample');

const $drop = document.getElementById('drop');
const $fileInput = document.getElementById('fileInput');
const $fileList = document.getElementById('fileList');

const $toast = document.getElementById('toast');
const $quotaBar = document.getElementById('quotaBar');
const $quotaText = document.getElementById('quotaText');

// 초기화
updateQuotaUI();
enableCouponUI($templateType.value);  // 문자열 그대로 전달
toggleReserveBox();

// 쿠폰 발급 여부 라디오 이벤트
document.querySelectorAll("input[name='couponIssue']").forEach(radio => {
  radio.addEventListener("change", () => {
    toggleCouponByIssue(radio.value === "Y");
  });
});

// 탭(유형) 전환
$tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    $tabs.forEach(t => { t.classList.remove('is-active'); t.setAttribute('aria-selected', 'false'); });
    tab.classList.add('is-active'); tab.setAttribute('aria-selected', 'true');

    const type = tab.dataset.template;
    $templateType.value = type;
    enableCouponUI(type);
  });
});

// --- 쿠폰 UI 제어 (안전 버전) ---
function enableCouponUI(type) {
  if (type === 'coupon') {
    // 발급 여부 행 숨김, 쿠폰 박스 강제 활성 + 필수
    showIssueRow(false);
    $couponBox.classList.remove('disabled');
    setCouponRequired(true);
  } else {
    // 발급 여부 행 보임, 선택값(Y/N)에 따라 쿠폰 박스 on/off
    showIssueRow(true);
    const checked = document.querySelector("input[name='couponIssue']:checked")?.value || "Y";
    toggleCouponByIssue(checked === "Y");
  }
}

function showIssueRow(show) {
  const display = show ? '' : 'none';
  $couponIssueLabel.style.display = display;
  $couponIssueField.style.display = display;
  document.getElementById('couponIssueHelp').style.display = display; // 안내문 토글
}


function toggleCouponByIssue(enable) {
  if (enable) {
    $couponBox.classList.remove("disabled");
    setCouponRequired(true);
  } else {
    $couponBox.classList.add("disabled");
    setCouponRequired(false);
    $couponBox.querySelectorAll("input").forEach(el => el.value = "");
  }
}

function setCouponRequired(req) {
  ['couponName','couponFrom','couponTo','couponOff'].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.required = req;
  });
}

// 예약 라디오 토글
$reserveRadios.forEach(r => r.addEventListener('change', toggleReserveBox));
function toggleReserveBox() {
  const isReserve = [...$reserveRadios].some(r => r.checked && r.value === 'reserve');
  $reserveBox.classList.toggle('is-open', isReserve);
  $reserveBox.setAttribute('aria-hidden', String(!isReserve));
  if (!isReserve) { $reserveDate.value = ''; $reserveTime.value = ''; }
}

// 드래그&드롭 업로더
['dragenter','dragover'].forEach(evt => {
  $drop.addEventListener(evt, e => { e.preventDefault(); e.stopPropagation(); $drop.classList.add('drag'); });
});
['dragleave','drop'].forEach(evt => {
  $drop.addEventListener(evt, e => { e.preventDefault(); e.stopPropagation(); $drop.classList.remove('drag'); });
});
$drop.addEventListener('click', () => $fileInput.click());
$drop.addEventListener('keydown', (e)=>{ if(e.key==='Enter' || e.key===' ') {$fileInput.click();}});
$drop.addEventListener('drop', (e)=>{
  const files = [...e.dataTransfer.files];
  addFiles(files);
});
$fileInput.addEventListener('change', ()=>{
  const files = [...$fileInput.files];
  addFiles(files);
  $fileInput.value = '';
});
function addFiles(files){
  files.forEach(f=>{
    const pill = document.createElement('div');
    pill.className = 'file-pill';
    pill.innerHTML = `<span>${f.name}</span><button type="button" class="x" aria-label="파일 제거">×</button>`;
    pill.querySelector('.x').addEventListener('click', ()=> pill.remove());
    $fileList.appendChild(pill);
  });
}

// 발송 버튼
$btnSend.addEventListener('click', ()=>{
  if(remainQuota >= quotaLimit){
    showToast('발송 쿼터가 초과되었습니다. 플랜을 업그레이드하세요.');
    return;
  }

  const isReserve = [...$reserveRadios].some(r=>r.checked && r.value==='reserve');
  if(isReserve && (!$reserveDate.value || !$reserveTime.value)){
    showToast('예약 발송일과 시간을 선택하세요.');
    return;
  }

  // 쿠폰 검증: coupon 유형 또는 (new/recommend & 발급=Y)
  const t = $templateType.value;
  const issue = document.querySelector("input[name='couponIssue']:checked")?.value || "Y";
  if (t === 'coupon' || ((t === 'new' || t === 'recommend') && issue === 'Y')) {
    const req = ['couponName','couponFrom','couponTo','couponOff'];
    for (const id of req) {
      const el = document.getElementById(id);
      if (!el.value) { showToast('쿠폰 정보를 모두 입력하세요.'); el.focus(); return; }
    }
    const from = new Date(document.getElementById('couponFrom').value);
    const to   = new Date(document.getElementById('couponTo').value);
    if (from > to) { showToast('쿠폰 기간이 올바르지 않습니다.'); return; }
  }

  // 실제 서비스에선 fetch 전송
  if(isReserve){
    showToast('메일이 정상적으로 예약되었습니다.');
  }else{
    showToast('메일이 정상적으로 발송되었습니다.');
    remainQuota += 1;
    updateQuotaUI();
  }
});

// example 버튼
$btnExample.addEventListener('click', ()=>{
  const typeLabel = {coupon:'할인쿠폰 안내', new:'신제품 출시 소식', recommend:'상품추천'}[$templateType.value];
  showToast(`"${typeLabel}" 템플릿 미리보기`);
});

// 쿼터 UI
function updateQuotaUI(){
  const ratio = Math.min(remainQuota / quotaLimit, 1);
  $quotaBar.style.width = (ratio*100).toFixed(1) + '%';
  $quotaText.textContent = `${number(remainQuota)} / ${number(quotaLimit)}`;
}
function number(n){ return n.toLocaleString(); }

// 토스트
let toastTimer=null;
function showToast(msg){
  $toast.textContent = msg;
  $toast.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(()=>{$toast.classList.remove('show')}, 2200);
}
*/