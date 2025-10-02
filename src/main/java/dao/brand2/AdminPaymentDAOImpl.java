package dao.brand2;

import org.apache.ibatis.session.SqlSession;

import dto.AdminPayment;
import dto.brand2.AdminToss;
import util.MybatisSqlSessionFactory;

public class AdminPaymentDAOImpl implements AdminPaymentDAO {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public void updateSuccessByOrderId(AdminPayment adminPayment) {
		sqlSession.update("mapper.adminPayment.updateSuccessByOrderId", adminPayment);
		sqlSession.commit();
	}


	@Override
	public void insertAdminPayment(AdminPayment adminPayment) throws Exception {
		sqlSession.insert("mapper.adminPayment.insertAdminPayment", adminPayment);
		sqlSession.commit();
	}
}
