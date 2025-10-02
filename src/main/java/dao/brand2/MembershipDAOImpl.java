package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.MembershipPlan;
import dto.brand2.MembershipList;
import util.MybatisSqlSessionFactory;

public class MembershipDAOImpl implements MembershipDAO {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	// 멤버십 결제 목록 조회
	@Override
	public List<MembershipList> selectMembershipList(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.membership.selectMembershipList", params);
	}

	@Override
	public Integer selectMembershipCount(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.membership.selectMembershipCount", params);
	}

	@Override
	public List<MembershipPlan> selectMembershipPlans() {
		// TODO Auto-generated method stub
		return null;
	}

	
}
