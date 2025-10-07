package dao.brand;

import java.util.List;

import dto.Brand;
import dto.brand.DashboardSummary;
import dto.brand.DashboardTodo;
import dto.brand.EventAlert;
import dto.brand.TopProduct;

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

	// 브랜드 정보 조회
	Brand selectBrandInfo(long brandId) throws Exception;

	// 브랜드 정보 수정
	void updateBrandInfo(Brand brand) throws Exception;

	// 메인 대시보드 요약 정보
	DashboardSummary selectDashboardSummary(Long brandId) throws Exception;

	// 메인 대시보드 오늘 할 일
	DashboardTodo selectDashboardTodo(Long brandId) throws Exception;

	// 메인 대시보드 이벤트 정보
	List<EventAlert> selectEventAlerts(long brandId) throws Exception;

	// 메인 대시보드 이번 주 인기 상품 Top3
	List<TopProduct> selectWeeklyTop3Products(long brandId) throws Exception;
}
