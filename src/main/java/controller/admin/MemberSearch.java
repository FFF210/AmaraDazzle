package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import dto.Member;
import service.admin.ConsumerService;
import service.admin.ConsumerServiceImpl;
import util.Paging;

@WebServlet("/admin/memberSearch")
public class MemberSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private final ConsumerService member_svc = new ConsumerServiceImpl();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		PrintWriter pw = response.getWriter();

		JsonObject result = new JsonObject(); 

		try {
			String pageno = request.getParameter("page");
			int p_no = (pageno != null && !pageno.isEmpty()) ? Integer.parseInt(pageno) : 1;

			Paging m_pg = new Paging();

			String totalSearch = request.getParameter("searchCondition");
			String keyword = request.getParameter("searchKeyword");

			boolean hasCondition = (totalSearch != null && !totalSearch.trim().isEmpty())
					&& (keyword != null && !keyword.trim().isEmpty());

			List<Member> memberList = Collections.emptyList();
			Integer memberCnt = 0;
			Map<String, Object> paging = new HashMap<>();

			int postNo = m_pg.serial_no(p_no); // 게시물 일련번호 계산

			if (hasCondition) {
				Map<String, String> searchContent = new HashMap<>();
				searchContent.put("totalSearch", totalSearch);
				searchContent.put("keyword", keyword);

				memberCnt = member_svc.memberCnt(searchContent);
				if (memberCnt == null) memberCnt = 0;

				paging = m_pg.page_ea(p_no, memberCnt);
				memberList = member_svc.memberSearchList(searchContent, p_no);

				//검색결과 없을 경우 
				if (memberList == null || memberList.isEmpty()) {
					result.addProperty("status", "fail");
                    result.addProperty("title", "검색 결과 없음");
                    result.addProperty("message", "검색된 회원이 없습니다.");
					
				} else { //검색 결과 있을 경우 
					JsonArray memberArr = new JsonArray();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					
					for (Member m : memberList) {
						JsonObject obj = new JsonObject();
						
                        obj.addProperty("memberId", m.getMemberId());
                        obj.addProperty("name", m.getName());
                        obj.addProperty("email", m.getEmail());
                        obj.addProperty("grade", m.getGrade());

                        if (m.getBirthDate() != null) {
                            obj.addProperty("birth", sdf.format(m.getBirthDate()));  // ✅ 문자열로 변환
                        } else {
                            obj.addProperty("birth", ""); // 혹은 null 처리
                        }
                        
                        memberArr.add(obj);
					}
					result.addProperty("status", "ok");
                    result.addProperty("title", "검색 성공");
                    result.addProperty("message", memberList.size() + "명의 회원이 검색되었습니다.");
                    result.addProperty("memberCnt", memberCnt);
                    result.add("memberList", memberArr);
				}
			} else {
				result.addProperty("status", "fail");
                result.addProperty("title", "검색 조건 없음");
                result.addProperty("message", "검색어를 입력해주세요.");
			}

			pw.print(result.toString());
			pw.flush();

		} catch (Exception e) {
			e.printStackTrace();

            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("title", "서버 오류");
            err.addProperty("message", "요청 처리 중 오류가 발생했습니다.");
            
            pw.print(err.toString());
            pw.flush();

		} finally {
			pw.close();
		}
	}

}
