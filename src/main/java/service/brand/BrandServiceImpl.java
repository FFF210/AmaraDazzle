package service.brand;

import java.util.List;
import java.util.Objects;

import dao.brand.BrandDAO;
import dao.brand.BrandDAOImpl;
import dto.Brand;
import dto.brand.DashboardSummary;
import dto.brand.DashboardTodo;
import dto.brand.EventAlert;
import dto.brand.LoginResult;
import dto.brand.TopProduct;

public class BrandServiceImpl implements BrandService {

	private BrandDAO brandDAO;

	public BrandServiceImpl() {
		brandDAO = new BrandDAOImpl();
	}

	// 회원가입
	@Override
	public void registerBrand(Brand brand) throws Exception {
		brandDAO.insertBrand(brand);
	}

	// 브랜드 입점신청
	@Override
	public void applyForBrand(Brand brand) throws Exception {
		brandDAO.updateBrandApply(brand);
	}

	// 이메일 중복 확인
	@Override
	public boolean existsByEmail(String email) throws Exception {
		return brandDAO.selectByEmail(email);
	}

	// 사업자등록번호 중복 확인
	@Override
	public boolean existsByBrn(String brn) throws Exception {
		return brandDAO.selectByBrn(brn);
	}

	// 브랜드명 중복 확인
	@Override
	public boolean existsByBrandName(String brandName) throws Exception {
		return brandDAO.selectByBrandName(brandName);
	}

	// 로그인
	@Override
	public LoginResult loginBrand(String email, String password) throws Exception {
		LoginResult result = new LoginResult();

		Brand brand = brandDAO.selectBrandByPassword(email);

		if (brand == null) {
			result.setSuccess(false);
			result.setErrorField("email");
			result.setErrorMessage("아이디가 존재하지 않습니다.");
			return result;
		}

		if (!Objects.equals(brand.getPassword(), password)) {
			result.setSuccess(false);
			result.setErrorField("password");
			result.setErrorMessage("비밀번호가 올바르지 않습니다.");
			return result;
		}

		// 성공
		result.setSuccess(true);
		result.setBrand(brand);
		return result;
	}

	// 메인 대시보드 요약 정보
	@Override
	public DashboardSummary getDashboardSummary(long brandId) throws Exception {
		return brandDAO.selectDashboardSummary(brandId);
	}

	// 메인 대시보드 오늘 할 일
	@Override
	public DashboardTodo getDashboardTodo(long brandId) throws Exception {
		return brandDAO.selectDashboardTodo(brandId);
	}

	// 메인 대시보드 이벤트 정보
	@Override
	public List<EventAlert> getEventAlerts(long brandId) throws Exception {
		return brandDAO.selectEventAlerts(brandId);
	}

	// 메인 대시보드 이번 주 인기 상품 Top3
	@Override
	public List<TopProduct> getWeeklyTop3Products(long brandId) throws Exception {
		return brandDAO.selectWeeklyTop3Products(brandId);
	}

}
