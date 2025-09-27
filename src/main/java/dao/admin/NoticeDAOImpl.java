package dao.admin;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Notice;
import util.MybatisSqlSessionFactory;

public class NoticeDAOImpl implements NoticeDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	//seller공지 작성 
	@Override
	public Long insertNoticeSeller(Notice notice_DTO) throws Exception {
		int result = ss.insert("mapper.notice.insertSellerNotice", notice_DTO);
		Long generatedId = null;
		
		if(result > 0) {
			ss.commit();
			generatedId = notice_DTO.getNoticeId(); //생성된 pk 
			
		} else {
			ss.rollback();
		}
		
		return generatedId;
	}

	//seller 공지 상세보기
	@Override
	public Notice noticeSellerDetail(int num) throws Exception {
		Notice notice_DTO = ss.selectOne("mapper.notice.selectSellerNoticeOne", num);
		
		return notice_DTO;
	}
	
	
	

}
