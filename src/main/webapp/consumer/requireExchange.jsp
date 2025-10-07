<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>교환신청</title>

  <!-- Noto Sans -->
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">

  <!-- Page CSS -->
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/requireExchange.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textArea.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/selectbox.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">

</head>
<body>
  <header class="site-header">
    <%@ include file="/consumer/header.jsp" %>
  </header>

  <main class="container">
    <h1 class="page-title">교환상품 선택</h1>

    <!-- 1) 상품정보 테이블 (샘플 데이터) -->
<section aria-labelledby="sec-product" class="section">
  <h2 id="sec-product" class="section-title">상품정보</h2>

  <div class="table-wrap" style="overflow:auto"> <!-- optional: 수평 스크롤 허용 -->
    <table class="table" role="table" aria-describedby="sec-product">
      <colgroup>
        <col style="width:60%">
        <col style="width:20%">
        <col style="width:10%">
        <col style="width:10%">
      </colgroup>

      <thead>
        <tr>
          <th scope="col">상품</th>
          <th scope="col">구매가</th>
          <th scope="col">수량</th>
          <th scope="col">구매가</th>
        </tr>
      </thead>

      <tbody>
        <!-- 반복 영역 -->
        <tr>
          <td>
            <div class="product" style="display:flex;align-items:center;gap:12px;">
              <img class="thumb" src="${ctx}/resources/img/sample.png" alt="상품 이미지" />
              <div class="meta" style="min-width:0;">
                <div class="brand">밀덩</div>
                <div class="name">밀덩 시럽관리 단백질에이믹 40g 5봉 1팩</div>
              </div>
            </div>
          </td>

          <td class="text-right">39,000원</td>
          <td>1</td>
          <td class="emph text-right">39,000원</td>
        </tr>
        <!-- /반복 -->
      </tbody>
    </table>
  </div>
</section>

    <!-- 폼 시작 -->
    <form id="exchangeForm" class="exchange-form" method="post" action="${ctx}/exchange/submit" enctype="multipart/form-data" novalidate>

      <!-- 2) 교환사유 -->
      <section aria-labelledby="sec-reason" class="section">
        <h2 id="sec-reason" class="section-title">교환사유 선택</h2>

        <div class="form-row">
          <div class="label">사유</div>
          <div class="input-area">
            <div class="row-gap">
              <div class="field">
                <label for="reason" class="sr-only">사유 선택</label>
                <select id="reason" name="reason" class="select-input" required>
                  <option value="">사유를 선택해주세요</option>
                  <option value="wrong-item">상품 불량</option>
                  <option value="broken-item">상품 파손</option>
                  <option value="wrong-delievery">오배송</option>
                  <option value="skin trouble">피부 트러블</option>
                </select>
              </div>
              <div class="field">
                <label for="reasonText" class="sr-only">사유 상세</label>
                <my:textArea 
                  id="reasonText" 
                  name="reasonText" 
                  placeholder="내용을 입력하세요.&#10;사유를 확인할 수 있는 이미지도 첨부해주세요." 
                  maxLength="500" 
                  showCount="true" />
              </div>
            </div>

            <div class="upload-wrap" data-max="3">
              <!-- 업로드 3칸 -->
              <label class="upload-tile">
                <input type="file" name="reasonFiles" accept="image/*" class="file-input" hidden>
                <span class="plus">+</span>
                <img alt="" class="preview" hidden>
              </label>
              <label class="upload-tile">
                <input type="file" name="reasonFiles" accept="image/*" class="file-input" hidden>
                <span class="plus">+</span>
                <img alt="" class="preview" hidden>
              </label>
              <label class="upload-tile">
                <input type="file" name="reasonFiles" accept="image/*" class="file-input" hidden>
                <span class="plus">+</span>
                <img alt="" class="preview" hidden>
              </label>
            </div>
          </div>
        </div>
      </section>

      <!-- 3) 회수지 정보 -->
      <section aria-labelledby="sec-pickup" class="section">
        <h2 id="sec-pickup" class="section-title">회수지 정보</h2>

        <div class="form-row">
          <div class="label">배송지 선택</div>
          <div class="input-area">
            <select name="pickupAddressSelect" class="select-input">
              <option value="">배송지명을 선택하세요</option>
              <option value="home">집</option>
              <option value="office">회사</option>
            </select>
          </div>
        </div>

        <div class="form-row">
          <div class="label">보내는분 <span class="required">*</span></div>
          <div class="input-area">
            <my:textInput 
              id="senderName" 
              name="senderName" 
              placeholder="이름을 입력하세요" 
              size="lg" />
          </div>
        </div>

        <div class="form-row">
          <div class="label">연락처 <span class="required">*</span></div>
          <div class="input-area phone-group">
          <my:textInput 
              name="senderSubPhone1" 
              placeholder="010" 
              size="sm" />
            <span class="dash">-</span>
            <my:textInput 
              name="senderPhone2" 
              placeholder="0000" 
              size="sm" />
            <span class="dash">-</span>
            <my:textInput 
              name="senderPhone3" 
              placeholder="0000" 
              size="sm" />
          </div>
        </div>

        <div class="form-row">
          <div class="label">연락처2</div>
          <div class="input-area phone-group">
          <my:textInput 
              name="senderSubPhone1" 
              placeholder="010" 
              size="sm" />
            <span class="dash">-</span>
            <my:textInput 
              name="senderSubPhone2" 
              placeholder="0000" 
              size="sm" />
            <span class="dash">-</span>
            <my:textInput 
              name="senderSubPhone3" 
              placeholder="0000" 
              size="sm" />
          </div>
        </div>

        <div class="form-row address-row">
          <div class="label">주소 <span class="required">*</span></div>
          <div class="input-area">
            <div class="address-line">
            <my:textInput 
                name="senderZip" 
                placeholder="12345" 
                type="readOnly" 
                size="sm" />
              <button type="button" class="btn btn-outline" id="btnFindZipSender">우편번호 찾기</button>
            </div>
             <my:textInput 
              name="senderAddr1" 
              placeholder="기본 주소" 
              size="lg" />
              <my:textInput 
              name="senderAddr2" 
              placeholder="상세 주소를 입력해주세요" 
              size="lg" />
          </div>
        </div>
      </section>

      <!-- 4) 배송지 정보 -->
      <section aria-labelledby="sec-dest" class="section">
        <h2 id="sec-dest" class="section-title">배송지 정보</h2>

        <div class="form-row receiver-row">
          <div class="label">받는분 <span class="required">*</span></div>
          <div class="input-area row-center">
            <input type="text" name="receiverName" class="text-input w-320" placeholder="text" required>
            <label class="checkbox-option"><input type="checkbox" id="sameAsSender"> 회수지와 동일</label>
          </div>
        </div>

        <div class="form-row">
          <div class="label">배송지명</div>
          <div class="input-area">
            <input type="text" name="destLabel" class="text-input w-320" placeholder="text">
          </div>
        </div>

        <div class="form-row">
          <div class="label">연락처 <span class="required">*</span></div>
          <div class="input-area phone-group">
            <select name="receiverPhone1" class="select-input w-90"><option>010</option><option>011</option><option>016</option></select>
            <span class="dash">-</span>
            <input type="text" name="receiverPhone2" class="text-input w-110" maxlength="4" inputmode="numeric" pattern="[0-9]*" required>
            <span class="dash">-</span>
            <input type="text" name="receiverPhone3" class="text-input w-110" maxlength="4" inputmode="numeric" pattern="[0-9]*" required>
          </div>
        </div>

        <div class="form-row">
          <div class="label">연락처2</div>
          <div class="input-area phone-group">
            <select name="receiverSubPhone1" class="select-input w-90"><option>010</option><option>011</option><option>016</option></select>
            <span class="dash">-</span>
            <input type="text" name="receiverSubPhone2" class="text-input w-110" maxlength="4" inputmode="numeric" pattern="[0-9]*">
            <span class="dash">-</span>
            <input type="text" name="receiverSubPhone3" class="text-input w-110" maxlength="4" inputmode="numeric" pattern="[0-9]*">
          </div>
        </div>

        <div class="form-row address-row">
          <div class="label">주소 <span class="required">*</span></div>
          <div class="input-area">
            <div class="address-line">
              <input type="text" name="receiverZip" class="text-input w-120" placeholder="12345" readonly>
              <button type="button" class="btn btn-outline" id="btnFindZipReceiver">우편번호 찾기</button>
            </div>
            <input type="text" name="receiverAddr1" class="text-input w-450" placeholder="text" required>
            <input type="text" name="receiverAddr2" class="text-input w-450" placeholder="상세 주소를 입력해주세요">
            <input type="text" name="receiverMemo" class="text-input w-450" placeholder="택배 배송 메시지">
          </div>
        </div>
      </section>

      <!-- 5) 버튼 -->
      <div class="form-actions">
        <a href="${ctx}/mypage/orders" class="btn btn-ghost">이전</a>
        <button type="submit" class="btn btn-primary" id="btnSubmit">교환 신청하기</button>
      </div>
    </form>
  </main>

  <footer class="site-footer">
    <%@ include file="/consumer/footer.jsp" %>
  </footer>

  <!-- Page JS -->
<script src="<c:url value='/js/header.js'/>"></script>
<script src="<c:url value='/js/requireExchange.js'/>"></script></body>
</html>
