package dao.consumer;

import org.apache.ibatis.session.SqlSession;

import dto.Payment;
import util.MybatisSqlSessionFactory;

public class PaymentDAOImpl implements PaymentDAO {

	@Override
	public void insertPayment(Payment payment) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.payment.insertPayment", payment);
			sqlSession.commit();
		}
	}

}
