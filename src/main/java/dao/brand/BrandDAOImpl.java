package dao.brand;

import org.apache.ibatis.session.SqlSession;

import dto.Brand;
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
}
