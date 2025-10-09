package dao.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Member;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class ConsumerDAOImpl implements ConsumerDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	//가입한 일반회원 총 수
	@Override
	public Integer memberCnt(SearchConditionDTO sc_DTO) {
		return ss.selectOne("mapper.member.memberCnt", sc_DTO);
	}

	//일반회원 검색 리스트
	@Override
	public List<Member> memberSearchList(SearchConditionDTO sc_DTO) {
		return ss.selectList("mapper.member.memberSearchList",sc_DTO);
	}

	//일반회원 정보 상세보기
	@Override
	public Member selectMemberDetail(int num) {
		return ss.selectOne("mapper.member.selectMemberDetail",num);
	}

}
