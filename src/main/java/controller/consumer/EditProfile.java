package controller.consumer;

import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/store/mypage/editProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditProfile() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 세션에서 로그인한 회원 ID 가져오기
		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		if (memberId == null) {
			// 로그인 안 했으면 로그인 페이지로
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		try {
			MemberService service = new MemberServiceImpl();

			// 1. 회원 정보 조회
			Member member = service.getMemberInfo(memberId);

			// 2. 피부고민 조회
			List<Long> skinIssues = service.getMemberSkinIssues(memberId);

			// 3. JSP로 전달
			request.setAttribute("member", member);
			request.setAttribute("skinIssues", skinIssues);

			request.getRequestDispatcher("/consumer/editProfile.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "회원 정보 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		if (memberId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		try {
			MemberService service = new MemberServiceImpl();

			// ⭐ 1단계: 기존 회원 정보 조회
			Member member = service.getMemberInfo(memberId);

			// ⭐ 2단계: 폼에서 받은 값으로 덮어쓰기
			// 닉네임
			String nickname = request.getParameter("nickname");
			if (nickname != null && !nickname.trim().isEmpty()) {
				member.setNickname(nickname);
			}

			// 비밀번호 (입력했을 때만)
			String password = request.getParameter("password");
			if (password != null && !password.trim().isEmpty()) {
				// 실제로는 암호화 필요!
				member.setPassword(password);
			} else {
				// 비밀번호 변경 안 할 거면 null로
				member.setPassword(null);
			}

			// 전화번호
			String phone = request.getParameter("phone");
			if (phone != null && !phone.trim().isEmpty()) {
				member.setPhone(phone);
			}

			// 우편번호
			String postcode = request.getParameter("postcode");
			if (postcode != null && !postcode.trim().isEmpty()) {
				member.setPostcode(postcode);
			}

			// 기본주소
			String line1 = request.getParameter("line1");
			if (line1 != null && !line1.trim().isEmpty()) {
				member.setLine1(line1);
			}

			// 상세주소
			String line2 = request.getParameter("line2");
			if (line2 != null && !line2.trim().isEmpty()) {
				member.setLine2(line2);
			}

			// 생년월일
			String birthDateStr = request.getParameter("birthDate");
			if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
				member.setBirthDate(Date.valueOf(birthDateStr));
			}

			// 성별
			String gender = request.getParameter("gender");
			if (gender != null && !gender.trim().isEmpty()) {
				member.setGender(gender);
			}

			// 피부타입
			String skinTypeIdStr = request.getParameter("skinTypeId");
			if (skinTypeIdStr != null && !skinTypeIdStr.trim().isEmpty()) {
				member.setSkinTypeId(Long.parseLong(skinTypeIdStr));
			}

			// 퍼스널컬러
			String personalColorIdStr = request.getParameter("personalColorId");
			if (personalColorIdStr != null && !personalColorIdStr.trim().isEmpty()) {
				member.setPersonalColorId(Long.parseLong(personalColorIdStr));
			}

			// 마케팅 수신 동의 (체크박스)
			String marketingOpt = request.getParameter("marketingOpt");
			member.setMarketingOpt(marketingOpt != null ? 1 : 0);

			// 피부고민 (여러 개 선택 가능)
			String[] skinIssueArr = request.getParameterValues("skinIssues");
			List<Long> skinIssueIds = null;
			if (skinIssueArr != null) {
				skinIssueIds = Arrays.stream(skinIssueArr).map(Long::parseLong).collect(Collectors.toList());
			}

			// ⭐ 3단계: 수정 실행
			service.updateMemberProfile(member, skinIssueIds);

			// 성공하면 마이페이지로
			response.sendRedirect(request.getContextPath() + "/store/mypage");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "회원 정보 수정 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
