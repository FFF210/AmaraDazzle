<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%> --%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>검색창</title>
<link rel="stylesheet" href="./css/common/componant.css?v=3" />
<link rel="stylesheet" href="./css/componant/search_box.css" />

</head>
<body>
	<form>
		<div class="search_container">
			<div class="filter">
				<div class="period_box">
					<div class="filtering_title">
						<span class="searchbox_title">기간 : </span>
					</div>
					<div class="period_body">
						<div>
							<input type="date" class="btn start_date" /> <span> - </span> <input
								type="date" class="btn end_date" />
						</div>

						<div class="p_choice">
							<input type="button" class="btn" value="오늘" /> <input
								type="button" class="btn" value="어제" /> <input type="button"
								class="btn" value="최근7일" /> <input type="button" class="btn"
								value="최근30일" />
						</div>
					</div>
				</div>

				<div class="answer_box">
					<div class="filtering_title">
						<span class="searchbox_title">답변상태 : </span>
					</div>
					<div class="answer_body">
						<div class="choice ch">
							<input type="button" value="전체" />
						</div>
						<div class="choice ch">
							<input type="button" value="미답변" />
						</div>
						<div class="choice">
							<input type="button" value="답변" />
						</div>
					</div>
				</div>

				<div class="questionType_box">
					<div class="filtering_title">
						<span class="searchbox_title">문의유형 : </span>
					</div>
					<div>
						<select class="">
							<option>문의유형1</option>
							<option>문의유형2</option>
							<option>문의유형3</option>
							<option>문의유형4</option>
						</select>
					</div>
				</div>

				<div class="category_box">
					<div class="filtering_title">
						<span class="searchbox_title">카테고리 : </span>
					</div>
					<div>
						<select class="">
							<option>대분류</option>
							<option>대분류</option>
							<option>대분류</option>
							<option>대분류</option>
						</select> <select class="">
							<option>중분류</option>
							<option>중분류</option>
							<option>중분류</option>
							<option>중분류</option>
						</select> <select class="">
							<option>소분류</option>
							<option>소분류</option>
							<option>소분류</option>
							<option>소분류</option>
						</select>
					</div>
				</div>

				<div class="check_box">
					<div class="filtering_title">
						<span class="searchbox_title">필터링타이틀 : </span>
					</div>
					<div>
						<label> <input type="checkbox" class="" value="" /> 문항1
						</label> <label> <input type="checkbox" class="" value="" /> 문항2
						</label> <label> <input type="checkbox" class="" value="" /> 문항3
						</label> <label> <input type="checkbox" class="" value="" /> 문항4
						</label> <label> <input type="checkbox" class="" value="" /> 문항5
						</label> <label> <input type="checkbox" class="" value="" /> 문항6
						</label> <label> <input type="checkbox" class="" value="" /> 문항7
						</label> <label> <input type="checkbox" class="" value="" /> 문항8
						</label>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>검색유형</option>
							<option>검색유형</option>
							<option>검색유형</option>
							<option>검색유형</option>
						</select>
					</div>
					<div class="searchKeyword">
						<i class="bi bi-search"></i><input type="text"
							placeholder="Search" />
					</div>
				</div>
			</div>

			<div class="btn_box">
				<input type="submit" class="btn first_btn" value="검색" /> <input
					type="reset" class="btn second_btn" value="초기화" />
			</div>
		</div>
	</form>

	<script src="./js/componant/select_box.js"></script>


</body>
</html>
