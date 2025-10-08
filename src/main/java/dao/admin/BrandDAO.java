package dao.admin;

import java.util.List;

import dto.Brand;
import dto.admin.SearchConditionDTO;

public interface BrandDAO {

	Integer brandAllCount(SearchConditionDTO sc_DTO);	//가입한 브랜드 총 개수 
	List<Brand> brandSearchList(SearchConditionDTO sc_DTO);	//브랜드 검색 리스트 
	Brand selectBrandDetail(int num); //브랜드 회원 정보 상세보기 

}
