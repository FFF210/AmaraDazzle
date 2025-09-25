<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="amount" required="true" type="java.lang.String" %>
<%@ attribute name="startDate" required="true" type="java.lang.String" %>
<%@ attribute name="endDate" required="true" type="java.lang.String" %>
<%@ attribute name="label" required="false" type="java.lang.String" %>

<div class="coupon">
  <div class="coupon-left">
    <div class="amount">${amount}</div>
    <div class="date">${startDate} ~ ${endDate}</div>
  </div>
  <div class="coupon-right">
    <span class="coupon-label">${empty label ? 'COUPON DOWN' : label}</span>
  </div>
</div>