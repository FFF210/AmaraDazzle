<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- *********************************메인부분********************************* -->
<section class="board_detailview">
	<div class="brand_info">
		<!--  style="display: none" -->
		<div class="part_section brand_part">
			<div class="part_title">브랜드명</div>
			<div class="part_content">
				<input type="text" class="text_readonly" value="브랜드명" readonly />
			</div>
		</div>

		<div class="part_section manager_part">
			<div class="part_title">신청담당자명</div>
			<div class="part_content">
				<input type="text" name="manager_name" class="text_readonly"
					value="신청담당자명" readonly /> <input type="text" name="manager_phone"
					class="text_readonly" value="연락처" readonly />
			</div>
		</div>

		<div class="part_section message_part">
			<div class="part_title">전달사항</div>
			<div class="part_content">
				<div></div>
			</div>
		</div>

		<div class="part_section pay_part">
			<div class="part_title">결제금액</div>
			<div class="part_content">
				<input type="text" name="pay_amount" class="text_readonly"
					value="900,000" readonly /> &nbsp;원
			</div>
		</div>

		<hr />
	</div>
	<div class="part_section title_part">
		<div class="part_title">제목</div>
		<div class="part_content">
			<input type="text" class="text_readonly" readonly />
		</div>
	</div>

	<div class="part_section period_part">
		<div class="part_title">진행기간</div>
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

	<div class="part_section pCate_part">
		<div class="part_title">상품 카테고리</div>
		<div class="part_content">
			<div></div>
		</div>
	</div>

	<div class="part_section thumb_part">
		<div class="part_title">배너이미지</div>
		<div class="part_content">
			<div>
				<img src="" />
			</div>
		</div>
	</div>

	<div class="part_section content_part">
		<div class="part_title">미리보기</div>
		<div class="part_content">
			<div></div>
		</div>
	</div>

	<div class="part_section bottom_part">
		<div class="part_title">작성자</div>
		<div class="part_content">
			<div class="writer_part" style="width: 60%">
				<input type="text" name="adm_name" class="text_readonly"
					value="로그인된 관리자 이름" readonly />
			</div>
			<div class="btn_part">
				<!-- <button type="button" class="btn second_btn action_btn">미리보기</button> -->
				<button type="button" class="btn first_btn action_btn">게시</button>
			</div>
		</div>
	</div>
</section>
<!-- *********************************메인부분 end********************************* -->