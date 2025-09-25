<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag body-content="empty" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="./css/dateRangeFilter.css" />

<%-- ==========================================
  DateRangeFilter 커스텀 태그 (고정 레이아웃)

  Props
  • submitLabel : 조회 버튼 텍스트 (기본 "조회")
  • periods     : 빠른기간 버튼 CSV  (기본 "1,3,6,12")
  • yearsFrom   : 연도 시작 (기본: 오늘-5)
  • yearsTo     : 연도 끝   (기본: 오늘)
  • startY/M/D  : 시작 기본값 (기본: 오늘)
  • endY/M/D    : 종료 기본값 (기본: 오늘)
  • namePrefix  : 필드 name prefix (기본 "drf")
  
  사용법?
  <my:dateRangeFilterBox periods="1,3,6,12" submitLabel="조회"/>     
  
=========================================== --%>

<%@ attribute name="submitLabel" required="false" %>
<%@ attribute name="periods"     required="false" %>
<%@ attribute name="yearsFrom"   required="false" %>
<%@ attribute name="yearsTo"     required="false" %>
<%@ attribute name="startY"      required="false" %>
<%@ attribute name="startM"      required="false" %>
<%@ attribute name="startD"      required="false" %>
<%@ attribute name="endY"        required="false" %>
<%@ attribute name="endM"        required="false" %>
<%@ attribute name="endD"        required="false" %>
<%@ attribute name="namePrefix"  required="false" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="__todayY"/>
<fmt:formatDate value="${now}" pattern="M"    var="__todayM"/>
<fmt:formatDate value="${now}" pattern="d"    var="__todayD"/>

<c:set var="__submit"  value="${empty submitLabel ? '조회' : submitLabel}" />
<c:set var="__periods" value="${empty periods ? '1,3,6,12' : periods}" />
<c:set var="__prefix"  value="${empty namePrefix ? 'drf' : namePrefix}" />

<c:set var="__yFrom" value="${empty yearsFrom ? __todayY - 5 : yearsFrom}" />
<c:set var="__yTo"   value="${empty yearsTo   ? __todayY      : yearsTo}" />

<c:set var="__startY" value="${empty startY ? __todayY : startY}" />
<c:set var="__startM" value="${empty startM ? __todayM : startM}" />
<c:set var="__startD" value="${empty startD ? __todayD : startD}" />
<c:set var="__endY"   value="${empty endY   ? __todayY : endY}" />
<c:set var="__endM"   value="${empty endM   ? __todayM : endM}" />
<c:set var="__endD"   value="${empty endD   ? __todayD : endD}" />

<div class="drf-wrap"><!-- 왼쪽 박스 + 오른쪽 버튼을 한 덩어리 -->
  <!-- 왼쪽 컨트롤 박스 -->
  <div class="drf-box">
    <!-- 상단: 구매기간 + 개월 버튼 -->
    <div class="drf-header">
      <div class="drf-label">구매기간</div>
      <div class="drf-periods">
        <c:forTokens items="${__periods}" delims="," var="p" varStatus="st">
          <button type="button"
                  class="drf-chip ${st.first ? 'is-active' : ''}"
                  data-months="${p}">
            ${p}개월
          </button>
        </c:forTokens>
      </div>
    </div>

    <!-- 하단: 날짜 선택 -->
    <div class="drf-dates">
      <div class="drf-date">
        <select class="drf-select" name="${__prefix}StartY" data-role="start-y">
          <c:forEach var="y" begin="${__yFrom}" end="${__yTo}">
            <option value="${y}" ${y == __startY ? 'selected' : ''}>${y}</option>
          </c:forEach>
        </select><span class="drf-suffix">년</span>

        <select class="drf-select" name="${__prefix}StartM" data-role="start-m">
          <c:forEach var="m" begin="1" end="12">
            <option value="${m}" ${m == __startM ? 'selected' : ''}>${m}</option>
          </c:forEach>
        </select><span class="drf-suffix">월</span>

        <select class="drf-select" name="${__prefix}StartD" data-role="start-d">
          <c:forEach var="d" begin="1" end="31">
            <option value="${d}" ${d == __startD ? 'selected' : ''}>${d}</option>
          </c:forEach>
        </select><span class="drf-suffix">일</span>
      </div>

      <div class="drf-tilde">~</div>

      <div class="drf-date">
        <select class="drf-select" name="${__prefix}EndY" data-role="end-y">
          <c:forEach var="y" begin="${__yFrom}" end="${__yTo}">
            <option value="${y}" ${y == __endY ? 'selected' : ''}>${y}</option>
          </c:forEach>
        </select><span class="drf-suffix">년</span>

        <select class="drf-select" name="${__prefix}EndM" data-role="end-m">
          <c:forEach var="m" begin="1" end="12">
            <option value="${m}" ${m == __endM ? 'selected' : ''}>${m}</option>
          </c:forEach>
        </select><span class="drf-suffix">월</span>

        <select class="drf-select" name="${__prefix}EndD" data-role="end-d">
          <c:forEach var="d" begin="1" end="31">
            <option value="${d}" ${d == __endD ? 'selected' : ''}>${d}</option>
          </c:forEach>
        </select><span class="drf-suffix">일</span>
      </div>
    </div>
  </div>

  <!-- 오른쪽: 같은 높이의 파란 버튼 (폭 77px 고정) -->
  <button class="drf-submit" type="submit">${__submit}</button>
</div>

<script>
(function(){
  // 태그 바로 뒤 script 기준: 이전 형제가 루트
  const wrap = document.currentScript && document.currentScript.previousElementSibling;
  if(!wrap || !wrap.classList.contains('drf-wrap')) return;

  const $  = (s,ctx=wrap)=>ctx.querySelector(s);
  const $$ = (s,ctx=wrap)=>Array.from(ctx.querySelectorAll(s));

  const sY=$('[data-role="start-y"]'), sM=$('[data-role="start-m"]'), sD=$('[data-role="start-d"]');
  const eY=$('[data-role="end-y"]'),   eM=$('[data-role="end-m"]'),   eD=$('[data-role="end-d"]');

  const clamp=(y,m,d)=>Math.min(d, new Date(y, m, 0).getDate());
  const setSel=(sel,v)=>{ const t=String(parseInt(v,10)); for(const o of sel.options){ if(String(parseInt(o.value,10))===t){ o.selected=true; break; } } };
  const getDate=(Y,M,D)=>new Date(parseInt(Y.value,10), parseInt(M.value,10)-1, parseInt(D.value,10));
  const setDate=(dt,start)=>{ const y=dt.getFullYear(), m=dt.getMonth()+1, d=dt.getDate();
    if(start){ setSel(sY,y); setSel(sM,m); setSel(sD,clamp(y,m,d)); }
    else     { setSel(eY,y); setSel(eM,m); setSel(eD,clamp(y,m,d)); }
  };
  const minusMonths=(base,months)=>{
    let y=base.getFullYear(), m=base.getMonth()+1, d=base.getDate();
    let nm=m-months; while(nm<=0){ nm+=12; y--; }
    return new Date(y, nm-1, clamp(y,nm,d));
  };

  // 개월 버튼
  $$('.drf-chip').forEach(btn=>{
    btn.addEventListener('click', ()=>{
      const months=parseInt(btn.dataset.months,10)||1;
      const end=getDate(eY,eM,eD);
      const start=minusMonths(end, months);
      setDate(start,true);

      $$('.drf-chip').forEach(b=>b.classList.remove('is-active'));
      btn.classList.add('is-active');
    });
  });

  // 종료 연/월 변경 시 day 정리
  [eY,eM].forEach(sel=> sel.addEventListener('change', ()=>{
    const end=getDate(eY,eM,eD); setDate(end,false);
    const st =getDate(sY,sM,sD); setDate(new Date(st.getFullYear(), st.getMonth(), clamp(st.getFullYear(), st.getMonth()+1, st.getDate())), true);
  }));
})();
</script>
