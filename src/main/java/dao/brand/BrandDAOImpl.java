package dao.brand;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Brand;
import dto.brand.DashboardSummary;
import dto.brand.DashboardTodo;
import dto.brand.EventAlert;
import dto.brand.TopProduct;
import util.MybatisSqlSessionFactory;

public class BrandDAOImpl implements BrandDAO {

	// 회원가입
	@Override
	public void insertBrand(Brand brand) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.brand.insertBrand", brand);
			sqlSession.commit();
		}
	}

	// 브랜드 입점신청
	@Override
	public void updateBrandApply(Brand brand) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.brand.updateBrandApply", brand);
			sqlSession.commit();
		}
	}

	// 이메일 존재 여부
	@Override
	public boolean selectByEmail(String email) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.selectOne("mapper.brand.selectByEmail", email);
			return result > 0;
		}
	}

	// 사업자등록번호 존재 여부
	@Override
	public boolean selectByBrn(String brn) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.selectOne("mapper.brand.selectByBrn", brn);
			return result > 0;
		}
	}

	// 브랜드명 존재 여부
	@Override
	public boolean selectByBrandName(String selectByBrandName) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.selectOne("mapper.brand.selectByBrandName", selectByBrandName);
			return result > 0;
		}
	}

	// 로그인
	@Override
	public Brand selectBrandByPassword(String email) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.brand.selectBrandByPassword", email);
		}
	}

	// 브랜드 정보 조회
	@Override
	public Brand selectBrandInfo(long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.brand.selectBrandInfo", brandId);
		}
	}

	// 브랜드 정보 수정
	@Override
	public void updateBrandInfo(Brand brand) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.brand.updateBrandInfo", brand);
			sqlSession.commit();
		}
	}

	// 메인 대시보드 요약 정보
	@Override
	public DashboardSummary selectDashboardSummary(Long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.brand.selectDashboardSummary", brandId);
		}
	}

	// 메인 대시보드 오늘 할 일
	@Override
	public DashboardTodo selectDashboardTodo(Long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.brand.selectDashboardTodo", brandId);
		}
	}

	// 메인 대시보드 이벤트 정보
	@Override
	public List<EventAlert> selectEventAlerts(long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.brand.selectEventAlerts", brandId);
		}
	}

	// 메인 대시보드 이번 주 인기 상품 Top3
	@Override
	public List<TopProduct> selectWeeklyTop3Products(long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.brand.selectWeeklyTop3Products", brandId);
		}
	}
}
