<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- *********************************메인부분********************************* -->
<section class="board_write">
	<div class="part_section name_part">
		<div class="part_title">
			쿠폰명 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<button type="buton" class="btn action_btn first_btn search_btn"
				id="cName_searchBtn">검색</button>
			<input type="text" name="coupon_name" placeholder="쿠폰명"
				style="cursor: default" readonly /> <input type="text"
				name="coupon_amount" placeholder="쿠폰금액" style="cursor: default"
				readonly /> &nbsp;원
		</div>
	</div>

	<div class="part_section period_part">
		<div class="part_title">
			유효기간 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<div class="period_box">
				<div class="period_body">
					<div>
						<input type="date" class="btn start_date" /> <span> - </span> <input
							type="date" class="btn end_date" />
					</div>

					<div class="p_choice">
						<input type="button" class="btn" value="1주일" /> <input
							type="button" class="btn" value="1개월" /> <input type="button"
							class="btn" value="1년" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="part_section condition_part">
		<div class="part_title">
			사용조건 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<button type="buton" class="btn action_btn first_btn search_btn">검색</button>
			<input type="text" name="coupon_condition" placeholder="사용조건"
				style="cursor: default" readonly />
			<div>
				<span>&nbsp;구매시 사용가능&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</div>
			<div class="no_condition">
				<label><input type="checkbox" /> 제한 없음</label>
			</div>
		</div>
	</div>

	<div class="part_section target_part name_part">
		<div class="part_title">
			지급대상 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<button type="buton" class="btn action_btn first_btn search_btn">검색</button>
			<input type="text" name="coupon_user" placeholder="회원아이디 or 모든회원"
				style="cursor: default" readonly /> <input type="text"
				name="coupon_user2" placeholder="회원명 or 등급" style="cursor: default"
				readonly />
		</div>
	</div>

	<div class="part_section reason_part">
		<div class="part_title">
			지급사유 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<input type="text" name="coupon_reason" placeholder="쿠폰 발행 사유를 입력하세요" />
		</div>
	</div>

	<div class="part_section amount_part condition_part">
		<div class="part_title">
			발급 수량 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<input type="text" name="coupon_quantity"
				placeholder="쿠폰 최대 발급 수량 입력" />
			<div>
				<span>&nbsp;매 한정&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</div>
			<div class="no_condition">
				<label><input type="checkbox" /> 제한 없음</label>
			</div>
		</div>
	</div>

	<div class="part_section dupl_part">
		<div class="part_title">
			중복 지급 여부 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<label><input type="checkbox" /> 중복 지급 불가</label>
		</div>
	</div>

	<div class="part_section bottom_part">
		<div class="part_title">
			작성자 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<div class="writer_part">
				<input type="text" class="text_readonly" value="로그인된 관리자 이름"
					readonly />
			</div>
			<div class="btn_part">
				<button type="button" class="btn first_btn action_btn">등록</button>
			</div>
		</div>
	</div>
</section>
<!-- *********************************메인부분 end********************************* -->