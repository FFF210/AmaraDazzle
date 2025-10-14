package dao.brand2;

import org.apache.ibatis.session.SqlSession;

import dto.AdminPayment;
import util.MybatisSqlSessionFactory;

public class AdminPaymentDAOImpl implements AdminPaymentDAO {

	@Override
	public void updateSuccessByOrderId(AdminPayment adminPayment) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.adminPayment.updateSuccessByOrderId", adminPayment);
			sqlSession.commit();
		}
	}

	@Override
	public void insertAdminPayment(AdminPayment adminPayment) throws Exception {
		System.out.println(adminPayment);

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.adminPayment.insertAdminPayment", adminPayment);
			sqlSession.commit();
		}
	}

	// 배너, 상세보기 - 결제대기/결제완료용
	@Override
	public int existsByBannerId(long bannerId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.adminPayment.existsByBannerId", bannerId);
		}
	}

	// 배너 ID로 결제 내역 조회 (취소 시 사용)
	@Override
	public AdminPayment selectPaymentByBannerId(Long bannerId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.adminPayment.selectPaymentByBannerId", bannerId);
		}
	}

}
