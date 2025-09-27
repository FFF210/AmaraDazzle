<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty" %>

<%-- ================================
     MainBanner 커스텀 태그

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:mainBanner />
================================ --%>

<div class="banner">
  <!-- 슬라이드 묶음 -->
  <div class="slides">
    <!-- 슬라이드 1 -->
    <div class="slide active">
      <img src="https://placehold.co/1440x430?text=banner1" alt="배너 1">
    </div>
    <!-- 슬라이드 2 -->
    <div class="slide">
      <img src="https://placehold.co/1440x430?text=banner2" alt="배너 2">
    </div>
    <!-- 슬라이드 3 -->
    <div class="slide">
      <img src="https://placehold.co/1440x430?text=banner3" alt="배너 3">
    </div>
  </div>

  <!-- 좌우 네비게이션 버튼 -->
  <button class="prev">&#10094;</button>
  <button class="next">&#10095;</button>

  <!-- 인디케이터(슬라이드 개수만큼 dot 표시) -->
  <div class="dots">
    <span class="dot active"></span>
    <span class="dot"></span>
    <span class="dot"></span>
  </div>
</div>

<script>
  // 모든 슬라이드와 인디케이터(dot) 요소 선택
  const slides = document.querySelectorAll(".slide");
  const dots = document.querySelectorAll(".dot");

  // 현재 슬라이드 인덱스 (0부터 시작)
  let currentIndex = 0;

  // 자동 슬라이드 전환 간격 (5초)
  let slideInterval = setInterval(nextSlide, 5000);

  /**
   * 특정 인덱스의 슬라이드를 표시하는 함수
   */
  function showSlide(index) {
    slides.forEach((s, i) => {
      s.classList.toggle("active", i === index); // 해당 인덱스만 active
      dots[i].classList.toggle("active", i === index);
    });
    currentIndex = index;
  }

  /**
   * 다음 슬라이드로 이동
   */
  function nextSlide() {
    showSlide((currentIndex + 1) % slides.length);
  }

  /**
   * 이전 슬라이드로 이동
   */
  function prevSlide() {
    showSlide((currentIndex - 1 + slides.length) % slides.length);
  }

  // 버튼 클릭 이벤트
  document.querySelector(".next").addEventListener("click", () => {
    nextSlide();
    resetInterval(); // 버튼 클릭 시 자동 순환 시간 초기화
  });

  document.querySelector(".prev").addEventListener("click", () => {
    prevSlide();
    resetInterval();
  });

  // dot 클릭 이벤트 (특정 슬라이드 바로 이동)
  dots.forEach((dot, i) => {
    dot.addEventListener("click", () => {
      showSlide(i);
      resetInterval();
    });
  });

  /**
   * 자동 순환 시간 초기화 (사용자가 직접 클릭했을 때)
   */
  function resetInterval() {
    clearInterval(slideInterval);
    slideInterval = setInterval(nextSlide, 5000);
  }
</script>
