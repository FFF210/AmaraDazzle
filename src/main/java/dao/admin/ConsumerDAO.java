package dao.admin;

import java.util.List;

import dto.Member;
import dto.admin.SearchConditionDTO;

public interface ConsumerDAO {

	Integer memberCnt(SearchConditionDTO sc_DTO);	//가입한 일반회원 총 수
	List<Member> memberSearchList(SearchConditionDTO sc_DTO);	//일반회원 검색 리스트
	Member selectMemberDetail(int num);	//일반회원 정보 상세보기

}
