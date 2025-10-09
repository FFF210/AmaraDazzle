package service.admin;

import java.util.List;
import java.util.Map;

import dao.admin.ConsumerDAO;
import dao.admin.ConsumerDAOImpl;
import dto.Member;
import dto.admin.SearchConditionDTO;
import util.Paging;
import util.SearchUtil;

public class ConsumerServiceImpl implements ConsumerService {

	private ConsumerDAO member_dao;

	public ConsumerServiceImpl() {
		member_dao = new ConsumerDAOImpl();
	}

	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();
	
	//가입한 일반회원 총 수
	@Override
	public Integer memberCnt(Map<String, String> cntMap) {
		SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return member_dao.memberCnt(sc_DTO);
	}

	//일반회원 검색 리스트
	@Override
	public List<Member> memberSearchList(Map<String, String> searchContent, Integer p_no) {
		Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return member_dao.memberSearchList(sc_DTO);
	}

	//일반회원 정보 상세보기
	@Override
	public Member selectMemberDetail(int num) {
		return member_dao.selectMemberDetail(num);
	}

}
