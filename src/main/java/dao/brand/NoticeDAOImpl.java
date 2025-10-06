package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand.NoticeList;
import util.MybatisSqlSessionFactory;

public class NoticeDAOImpl implements NoticeDAO {

	@Override
	public List<NoticeList> selectNoticeList(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notice.selectNoticeList", params);
		}
	}

	@Override
	public Integer selectNoticeCount() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.selectNoticeCount");
		}
	}

	@Override
	public NoticeList selectNoticeById(long noticeId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.selectNoticeById", noticeId);
		}
	}

}
