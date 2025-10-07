package service.brand;

import java.util.List;

import dto.Brand;
import dto.brand.DashboardSummary;
import dto.brand.DashboardTodo;
import dto.brand.EventAlert;
import dto.brand.LoginResult;
import dto.brand.TopProduct;

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

	// 브랜드 정보 조회
	public Brand getBrandInfo(long brandId) throws Exception;

	// 브랜드 정보 수정
	public void editBrandInfo(Brand brand) throws Exception;

	// 메인 대시보드 요약 정보
	public DashboardSummary getDashboardSummary(long brandId) throws Exception;

	// 메인 대시보드 오늘 할 일
	public DashboardTodo getDashboardTodo(long brandId) throws Exception;

	// 메인 대시보드 이벤트 정보
	public List<EventAlert> getEventAlerts(long brandId) throws Exception;

	// 메인 대시보드 이번 주 인기 상품 Top3
	public List<TopProduct> getWeeklyTop3Products(long brandId) throws Exception;
}
