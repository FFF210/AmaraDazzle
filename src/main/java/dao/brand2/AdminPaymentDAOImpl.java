package dao.brand2;

import org.apache.ibatis.session.SqlSession;

import dto.AdminPayment;
import dto.brand2.AdminToss;
import util.MybatisSqlSessionFactory;

public class AdminPaymentDAOImpl implements AdminPaymentDAO {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public int updateSuccessByOrderId(String orderId, String paymentKey, Integer amount, String approvedAt) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			AdminPaymentDAO mapper = sqlSession.getMapper(AdminPaymentDAO.class);
			int result = mapper.updateSuccessByOrderId(orderId, paymentKey, amount, approvedAt);
			sqlSession.commit();
			return result;
		}
	}

	@Override
	public int updateFailedByOrderId(String orderId, String paymentKey) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			AdminPaymentDAO mapper = sqlSession.getMapper(AdminPaymentDAO.class);
			int result = mapper.updateFailedByOrderId(orderId, paymentKey);
			sqlSession.commit();
			return result;
		}
	}

	@Override
	public void insertAdminPayment(AdminToss payment) throws Exception {
	}
}
