<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>주문 상세정보</title>
  <link rel="stylesheet" href="./tagcss/reset.css" />
  <link rel="stylesheet" href="./consumer/css/header.css" />
  <link rel="stylesheet" href="./consumer/css/footer.css" />
  <link rel="stylesheet" href="./consumer/css/orderDetail.css" />
  <link rel="stylesheet" href="./tagcss/textInput.css" />    
  <link rel="stylesheet" href="./tagcss/table.css" />
  <link rel="stylesheet" href="<c:url value='/css/mypageMenu.css'/>">
  
</head>
<body>
<%-- 헤더 --%>
<%@ include file="/consumer/header.jsp" %>

<div class="page-wrap">
  <div class="page-grid">
    <%-- 좌측 마이페이지 메뉴 --%>
    <%@ include file="/consumer/mypageMenu.jsp" %>

    <main class="content">
      <%-- 주문상세정보--%>
      <section class="section">
        <h1 class="page-title">주문 상세정보</h1>        
        <div class="order-info">
          <div class="info-item">
            <span class="label">주문일자:</span>
            <span class="value">2025-09-10</span>
          </div>
          
          <div class="info-item">
            <span class="label">주문번호:</span>
            <span class="value order-number">Y2344352234</span>
          </div>
        </div>
      </section>

      <%-- ===== 배송상품 ===== --%>
      <section class="section">
        <h2 class="section-title">배송상품</h2>
        <p class="section-subtitle">총 2건</p>
        
          <div class="table-wrapper" style="overflow:auto">
            <table class="table">
              <thead>
                <tr>
                  <th>상품명</th>
                  <th>판매가</th>
                  <th>수량</th>
                  <th>구매가</th>
                  <th>진행현황</th>
                  <th>선택</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="i" begin="1" end="2">
                  <tr>
                    <td>
                      <div class="product-info">
                        <span class="brand">힙합</span><br>
                        <span class="product-name">힙합 식감관리 단백질쉐이크 40g 5통 특가</span>
                      </div>
                    </td>
                    <td>39,000원</td>
                    <td>1</td>
                    <td class="price-highlight">39,000원</td>
                    <td>배송준비중</td>
                    <td>
                      <button type="button" class="action-btn">배송조회</button>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
      </section>

      <%-- ===== 배송지 정보 ===== --%>
      <section class="section od-ship">
        <h2 class="section-title">배송지 정보</h2>

        <div class="form-rows">
          <!-- 받는분 -->
          <div class="row">
            <div class="label">받는분</div>
            <div class="input-wrapper">
              <my:textInput type="readOnly" name="name" value="심정" size="lg" />        
            </div>
          </div>

          <!-- 주소 -->
          <div class="row">
            <div class="label">주소</div>
            <div class="addr">
              <!-- 1) 우편번호: 단독 한 줄 -->
              <div class="addr-row">
                <my:textInput type="readOnly" name="postcode" value="(12345)" size="lg" />        
              </div>

              <!-- 2) 도로명 / 지번: 2열 -->
              <div class="addr-row addr-grid-2">
                <my:textInput type="readOnly" name="mainAddress" value="도로명 인천시 상현동 동로2길 52번지" size="lg" />
                <my:textInput type="readOnly" name="detailAddress" value="지 번: 인천시 상현동 상현동 동로2길" size="lg" />        
              </div>
            </div>
          </div>

          <!-- 연락처 -->
          <div class="row">
            <div class="label">연락처</div>
            <div class="input-wrapper">
              <my:textInput id="연락처" name="phoneNumber" type="readOnly" value="010-1592-9410" size="lg" />
            </div>
          </div>

          <!-- 요청사항 -->
          <div class="row">
            <div class="label">배송 요청 사항</div>
            <div class="input-wrapper">
              <my:textInput id="배송요청사항" name="request" type="readOnly" value="경비실에 맡겨주세요" size="lg" />
            </div>
          </div>
        </div>
      </section>

      <%-- ===== 결제 정보 ===== --%>
      <section class="section od-payment">
        <h2 class="section-title">결제 정보</h2>
        
        <div class="form-rows">
          <div class="row">
            <div class="label">총 주문금액</div>
            <div class="input-wrapper">
              <my:textInput type="readOnly" value="300,000원" size="lg" />
            </div>
          </div>
          
          <div class="row">
            <div class="label">총 할인금액</div>
            <div class="input-wrapper">
              <my:textInput type="readOnly" value="19,000원" size="lg" />
            </div>
          </div>
          
          <div class="row">
            <div class="label">쿠폰 할인</div>
            <div class="input-wrapper">
              <my:textInput type="readOnly" value="3,000원" size="lg" />
            </div>
          </div>
          
          <div class="row">
            <div class="label">포인트 사용</div>
            <div class="input-wrapper">
              <my:textInput type="readOnly" value="0 P" size="lg" />
            </div>
          </div>
          
          <div class="row">
            <div class="label">총 결제금액</div>
            <div class="input-wrapper">
              <my:textInput type="readOnly" value="282,000원" size="lg" />
            </div>
          </div>
          
          <div class="row">
            <div class="label">결제수단</div>
            <div class="input-wrapper">
              <my:textInput type="readOnly" value="토스 페이먼츠" size="lg" />
            </div>
          </div>
        </div>
      </section>

      <div class="page-actions">
        <a href="${pageContext.request.contextPath}/mypage/orders" class="btn-primary">취소</a>
      </div>
    </main>
  </div>
</div>

<%-- 푸터 --%>
<%@ include file="/consumer/footer.jsp" %>
</body>
</html>
