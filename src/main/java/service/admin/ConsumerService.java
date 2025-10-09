package service.admin;

import java.util.List;
import java.util.Map;

import dto.Member;

public interface ConsumerService {

	Integer memberCnt(Map<String, String> searchContent);	//가입한 일반회원 총 수
	List<Member> memberSearchList(Map<String, String> searchContent, Integer p_no);	//일반회원 검색 리스트 
	Member selectMemberDetail(int num); //일반회원 정보 상세보기
	
}
