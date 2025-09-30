package dao.brand;

import dto.Brand;

public interface BrandDAO {
	// 회원가입
	void insertBrand(Brand brand) throws Exception;

	// 브랜드 입점신청
	void updateBrandApply(Brand brand) throws Exception;

	// 이메일 존재 여부
	boolean selectByEmail(String email) throws Exception;

	// 사업자등록번호 존재 여부
	boolean selectByBrn(String brn) throws Exception;

	// 브랜드명 존재 여부
	boolean selectByBrandName(String brandName) throws Exception;

	// 로그인
	Brand selectBrandByPassword(String email) throws Exception;
}
