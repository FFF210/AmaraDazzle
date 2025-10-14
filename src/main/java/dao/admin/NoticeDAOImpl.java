package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Notice;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class NoticeDAOImpl implements NoticeDAO {

	// seller 공지 작성
	@Override
	public Long insertNoticeSeller(Notice notice_DTO) throws Exception {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.insert("mapper.notice.insertSellerNotice", notice_DTO);
			Long generatedId = null;

			if (result > 0) {
				ss.commit();
				generatedId = notice_DTO.getNoticeId(); // 생성된 pk

			} else {
				ss.rollback();
			}

			return generatedId;
		}
	}

	// seller 공지 상세보기
	@Override
	public Notice noticeSellerDetail(int num) throws Exception {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Notice notice_DTO = ss.selectOne("mapper.notice.selectSellerNoticeOne", num);

			return notice_DTO;
		}
	}

	// seller 공지 총 게시글 수
	@Override
	public Integer noticeCount(SearchConditionDTO sc_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectOne("mapper.notice.SellerNoticeCnt", sc_DTO);
		}
	}

	// seller 공지 리스트
	@Override
	public List<Notice> sellerNoticeList(Map<String, Object> listMap) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectList("mapper.notice.selectAllSellerNotice", listMap);
		}
	}

	// 검색된 seller 공지 리스트
	@Override
	public List<Notice> search_nlist(SearchConditionDTO sc_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectList("mapper.notice.selectSearchSellerNotice", sc_DTO);
		}
	}

	// 공지 게시글 조회수
	@Override
	public void viewCount(int num) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.update("mapper.notice.notice_viewcnt", num);

			if (result > 0) {
				ss.commit();

			} else {
				ss.rollback();
			}
		}
	}

	@Override
	public int noticeSellerEdit(Notice notice_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.update("mapper.notice.updateSellerNotice", notice_DTO);

			if (result > 0) {
				ss.commit();

			} else {
				ss.rollback();
			}

			return result;
		}
	}

	// seller 공지 삭제
	@Override
	public int noticeSellerDelete(Long num) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.delete("mapper.notice.noticeSellerDelete", num);

			if (result > 0) {
				ss.commit();

			} else {
				ss.rollback();
			}

			return result;
		}
	}

	// 게시상태 변경
	@Override
	public int noticeExposeChange(Map<String, Object> map) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.delete("mapper.notice.noticeExposeChange", map);

			if (result > 0) {
				ss.commit();

			} else {
				ss.rollback();
			}

			return result;
		}
	}

}
