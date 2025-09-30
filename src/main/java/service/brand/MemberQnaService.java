package service.brand;

import java.util.Map;

import dto.brand.MemberQnaList;

public interface MemberQnaService {
	// 고객 문의 조회
	public Map<String, Object> memberQnaListByPage(Map<String, Object> params) throws Exception;

	// 고객 문의 상세 조회
	public MemberQnaList memberQnaListDetail(String type, Long qnaId) throws Exception;

	// 고객 문의 답변 업데이트
	public void updateAnswer(Long qnaId, String type, String answer) throws Exception;
}
