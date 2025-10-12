<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송 조회</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    background: #f5f5f5;
    padding: 20px;
}

.container {
    max-width: 800px;
    margin: 0 auto;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 40px;
}

.header {
    text-align: center;
    margin-bottom: 40px;
    padding-bottom: 20px;
    border-bottom: 2px solid #f0f0f0;
}

.header h1 {
    font-size: 28px;
    color: #333;
    margin-bottom: 10px;
}

.header .carrier {
    font-size: 18px;
    color: #666;
    font-weight: 500;
}

.info-box {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 30px;
}

.info-row {
    display: flex;
    padding: 10px 0;
    border-bottom: 1px solid #e0e0e0;
}

.info-row:last-child {
    border-bottom: none;
}

.info-label {
    width: 120px;
    font-weight: 600;
    color: #555;
}

.info-value {
    flex: 1;
    color: #333;
}

.timeline {
    margin-top: 30px;
}

.timeline-title {
    font-size: 20px;
    font-weight: 600;
    color: #333;
    margin-bottom: 20px;
}

.timeline-item {
    position: relative;
    padding-left: 40px;
    padding-bottom: 30px;
    border-left: 2px solid #e0e0e0;
}

.timeline-item:last-child {
    border-left: 2px solid transparent;
    padding-bottom: 0;
}

.timeline-item.active {
    border-left-color: #007bff;
}

.timeline-dot {
    position: absolute;
    left: -9px;
    top: 0;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    background: #e0e0e0;
    border: 3px solid white;
}

.timeline-item.active .timeline-dot {
    background: #007bff;
}

.timeline-time {
    font-size: 14px;
    color: #999;
    margin-bottom: 5px;
}

.timeline-status {
    font-size: 16px;
    font-weight: 600;
    color: #333;
    margin-bottom: 5px;
}

.timeline-item.active .timeline-status {
    color: #007bff;
}

.timeline-location {
    font-size: 14px;
    color: #666;
}

.close-btn {
    display: block;
    width: 200px;
    margin: 30px auto 0;
    padding: 12px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s;
}

.close-btn:hover {
    background: #0056b3;
}
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>배송 조회</h1>
        <div class="carrier">${carrierName}</div>
    </div>

    <div class="info-box">
        <div class="info-row">
            <div class="info-label">운송장번호</div>
            <div class="info-value">${trackingNo}</div>
        </div>
        <div class="info-row">
            <div class="info-label">배송상태</div>
            <div class="info-value" style="color: #007bff; font-weight: 600;">배송중</div>
        </div>
    </div>

    <div class="timeline">
        <div class="timeline-title">배송 진행 상황</div>
        
        <div class="timeline-item active">
            <div class="timeline-dot"></div>
            <div class="timeline-time">2025-10-11 14:23</div>
            <div class="timeline-status">배송 중</div>
            <div class="timeline-location">경기 성남 분당구 배송센터</div>
        </div>

        <div class="timeline-item">
            <div class="timeline-dot"></div>
            <div class="timeline-time">2025-10-11 08:15</div>
            <div class="timeline-status">집화</div>
            <div class="timeline-location">경기 성남 분당구 집화센터</div>
        </div>

        <div class="timeline-item">
            <div class="timeline-dot"></div>
            <div class="timeline-time">2025-10-10 18:42</div>
            <div class="timeline-status">상품 인수</div>
            <div class="timeline-location">서울 강남구 물류센터</div>
        </div>

        <div class="timeline-item">
            <div class="timeline-dot"></div>
            <div class="timeline-time">2025-10-10 16:30</div>
            <div class="timeline-status">배송 준비중</div>
            <div class="timeline-location">판매자</div>
        </div>
    </div>

    <button class="close-btn" onclick="window.close()">닫기</button>
</div>
</body>
</html>