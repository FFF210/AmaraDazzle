package dao.brand;

import java.util.List;
import java.util.Map;

import dto.brand.MemberQnaList;

public interface MemberQnaDAO {
	// 고개 문의 목록 조회
	List<MemberQnaList> selectMemberQnaListForBrand(Map<String, Object> params) throws Exception;

	// 고개 문의 개수 조회
	Integer selectMemberQnaCountForBrand(Map<String, Object> params) throws Exception;

	// 고객 문의 상세 조회
	MemberQnaList selectMemberQnaDetail(Map<String, Object> params) throws Exception;

	// 고객 문의 업데이트
	void updateMemberQnaAnswer(Map<String, Object> params) throws Exception;
}
