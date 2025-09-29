package service.brand;

import dto.Brand;
import dto.brand.LoginResult;

public interface BrandService {
	// 회원가입
	public void registerBrand(Brand brand) throws Exception;

	// 브랜드 입점신청
	public void applyForBrand(Brand brand) throws Exception;

	// 이메일 중복 확인
	public boolean existsByEmail(String email) throws Exception;

	// 사업자등록번호 중복 확인
	public boolean existsByBrn(String brn) throws Exception;

	// 브랜드명 중복 확인
	public boolean existsByBrandName(String brandName) throws Exception;

	// 로그인
	public LoginResult loginBrand(String email, String password) throws Exception;
}
