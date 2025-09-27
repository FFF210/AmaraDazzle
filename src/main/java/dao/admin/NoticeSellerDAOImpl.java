package dao.admin;

import org.apache.ibatis.session.SqlSession;

import dto.Notice;
import util.MybatisSqlSessionFactory;

public class NoticeSellerDAOImpl implements NoticeSellerDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public int insertNoticeSeller(Notice notice_DTO) throws Exception {
		int result = ss.insert("mapper.notice.insertSellerNotice", notice_DTO);
		
		if(result > 0) {
			ss.commit();
		} else {
			ss.rollback();
		}
		
		return result;
	}
	
	
	

}
