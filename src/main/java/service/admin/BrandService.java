package service.admin;

import java.util.List;
import java.util.Map;

import dto.Brand;

public interface BrandService {

	Integer brandAllCnt(Map<String, String> searchContent);	//가입한 브랜드 총 개수 
	List<Brand> brandSearchList(Map<String, String> searchContent, Integer p_no);	//브랜드 검색 리스트 

}
