package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Event;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class EventDAOImpl implements EventDAO {

	// event 게시글 총 개수
	@Override
	public Integer eventCount(SearchConditionDTO sc_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectOne("mapper.event.eventCount", sc_DTO);
		}
	}

	// event 리스트 보기
	@Override
	public List<Event> allEventList(Map<String, Object> listMap) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectList("mapper.event.allEventList", listMap);
		}
	}

	// 검색된 event 리스트
	@Override
	public List<Event> searchEventList(SearchConditionDTO sc_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectList("mapper.event.searchEventList", sc_DTO);
		}
	}

	// event 게시글 조회수
	@Override
	public void eventViewCount(int num) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.update("mapper.event.eventViewCount", num);

			if (result > 0) {
				ss.commit();

			} else {
				ss.rollback();
			}
		}
	}

	// 이벤트 등록
	@Override
	public int adminEventWrite(Event event) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.insert("mapper.event.adminEventWrite", event);
			if (result > 0) {
				ss.commit();
			} else {
				ss.rollback();
			}

			return result;
		}
	}

	@Override
	public int eventExposeChange(Long num) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.update("mapper.event.eventExposeChange", num);
			
			if (result > 0) {
				ss.commit();
			} else {
				ss.rollback();
			}

			return result;
		}
	}

}
