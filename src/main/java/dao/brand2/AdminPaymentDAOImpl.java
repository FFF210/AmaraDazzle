package dao.brand2;

import org.apache.ibatis.session.SqlSession;

import dto.AdminPayment;
import util.MybatisSqlSessionFactory;

public class AdminPaymentDAOImpl implements AdminPaymentDAO {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public void insertAdminPayment(AdminPayment adminPayment) throws Exception {
		sqlSession.insert("mapper.adminPayment.insertAdminPay", adminPayment);
		sqlSession.commit();
	}
	
	
}
