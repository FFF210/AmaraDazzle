package dao.admin;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.AdminInfo;
import util.MybatisSqlSessionFactory;

public class AdminDAOImpl implements AdminDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();


	//관리자 로그인 
	@Override
	public AdminInfo adminLoginConfirm(Map<String, String> map) throws Exception {
		return ss.selectOne("mapper.adminInfo.adminLoginConfirm", map);
	}

}
