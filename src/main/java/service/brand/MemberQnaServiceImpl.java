package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.MemberQnaDAO;
import dao.brand.MemberQnaDAOImpl;
import dto.brand.MemberQnaList;

public class MemberQnaServiceImpl implements MemberQnaService {

	private MemberQnaDAO memberQnaDAO;

	public MemberQnaServiceImpl() {
		memberQnaDAO = new MemberQnaDAOImpl();
	}

	// 고개 문의 조회
	@Override
	public Map<String, Object> memberQnaListByPage(Map<String, Object> params) throws Exception {
		List<MemberQnaList> list = memberQnaDAO.selectMemberQnaListForBrand(params); // 목록
		int totalCount = memberQnaDAO.selectMemberQnaCountForBrand(params); // 개수

		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("qnaList", list);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);
		result.put("currentPage", params.get("page"));
		return result;
	}

	// 고객 문의 상세 조회
	@Override
	public MemberQnaList memberQnaListDetail(String type, Long qnaId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("type", type); // "QNA" or "TICKET"
		param.put("id", qnaId);

		return memberQnaDAO.selectMemberQnaDetail(param);
	}

	// 고객 문의 답변 업데이트
	@Override
	public void updateAnswer(Long qnaId, String type, String answer) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("type", type); // "QNA" or "TICKET"
		param.put("qnaId", qnaId);
		param.put("answer", answer);

		memberQnaDAO.updateMemberQnaAnswer(param);

	}

}
