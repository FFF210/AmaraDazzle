package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Notice;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class NoticeDAOImpl implements NoticeDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	//seller 공지 작성 
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

	//seller 공지 총 게시글 수 
	@Override
	public Integer noticeCount(SearchConditionDTO sc_DTO) {
		return ss.selectOne("mapper.notice.SellerNoticeCnt", sc_DTO);
	}

	//seller 공지 리스트 
	@Override
	public List<Notice> sellerNoticeList(Map<String, Object> listMap) {
		return ss.selectList("mapper.notice.selectAllSellerNotice",listMap);
	}

	//검색된 seller 공지 리스트 
	@Override
	public List<Notice> search_nlist(SearchConditionDTO sc_DTO ) {
		return ss.selectList("mapper.notice.selectSearchSellerNotice",sc_DTO);
	}

	//공지 게시글 조회수
	@Override
	public void viewCount(int num) {
		int result = ss.update("mapper.notice.notice_viewcnt",num);

		if(result > 0) {
			ss.commit();
			
		} else {
			ss.rollback();
		}
	}
	
	
	

}
