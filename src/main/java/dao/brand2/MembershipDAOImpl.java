package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.AdminPayment;
import dto.Membership;
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

	// 멤버십 개수 조회
	@Override
	public Integer selectMembershipCount(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.membership.selectMembershipCount", params);
	}

	// 멤버십 플랜 종류
	@Override
	public List<MembershipPlan> selectMembershipPlans() {
		return sqlSession.selectList("mapper.membershipPlan.selectMembershipPlans");
	}

	// 신규 멤버십 가입
	@Override
	public Long insertMembership(Membership membership) {
		sqlSession.insert("mapper.membership.insertMembership", membership);
		sqlSession.commit();
		return membership.getMembershipId(); // auto_increment 값
	}

	@Override
	public void insertAdminPayment(AdminPayment payment) {
		sqlSession.insert("mapper.membership.insertAdminPayment", payment);
		sqlSession.commit();
	}

	// 멤버십 취소 (start_date > NOW() 인 경우만 가능)
	@Override
	public int cancelMembership(Long membershipId) {
		int result = sqlSession.update("mapper.membership.cancelReservedMembership", membershipId);
		sqlSession.commit();
		return result;
	}

	// 브랜드별 현재 이용중 멤버십
	@Override
	public Membership selectCurrentMembership(Long brandId) {
		return sqlSession.selectOne("mapper.membership.selectCurrentMembership", brandId);
	}

	// 브랜드별 예약된 멤버십
	@Override
	public Membership selectReservedMembership(Long brandId) {
		return sqlSession.selectOne("mapper.membership.selectReservedMembership", brandId);
	}

}