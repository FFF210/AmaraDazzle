package dao.consumer;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Member;
import util.MybatisSqlSessionFactory;

public class MemberDAOImpl implements MemberDAO {

	private SqlSession sqlSession;

	public MemberDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	@Override
	public void insertMember(Member member) throws Exception {
		sqlSession.insert("mapper.member.insertMember", member);
		sqlSession.commit();
	}

	@Override
	public Member selectMember(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.member.selectMember", params);
	}

	@Override
	public Member selectByEmailAndPassword(String email, String password) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		params.put("password", password);
		return sqlSession.selectOne("mapper.member.selectByEmailAndPassword", params);
	}

	@Override
	public Member selectByEmail(String email) throws Exception {
		return sqlSession.selectOne("mapper.member.selectByEmail", email);
	}

	@Override
	public Member selectById(Long memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.selectById", memberId);
	}

	@Override
	public int countByEmail(String email) throws Exception {
		Integer result = sqlSession.selectOne("mapper.member.countByEmail", email);
		return result != null ? result : 0;
	}

	@Override
	public void updateMember(Member member) throws Exception {
		sqlSession.update("mapper.member.updateMember", member);
		sqlSession.commit();
	}

	@Override
	public void updatePassword(Long memberId, String newPassword) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("newPassword", newPassword);
		sqlSession.update("mapper.member.updatePassword", params);
		sqlSession.commit();
	}

	@Override
	public void updatePoints(Long memberId, int pointChange) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("pointChange", pointChange);
		sqlSession.update("mapper.member.updatePoints", params);
		sqlSession.commit();
	}

	@Override
	public void updateGrade(Long memberId, String grade) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("grade", grade);
		sqlSession.update("mapper.member.updateGrade", params);
		sqlSession.commit();

	}

	@Override
	public void deleteMember(Long memberId) throws Exception {
		sqlSession.update("mapper.member.deleteMember", memberId);
		sqlSession.commit();

	}

	@Override
	public Member selectByKakaoId(Long kakaoId) throws Exception {
		return sqlSession.selectOne("mapper.member.selectByKakaoId", kakaoId);
	}

	@Override
	public Map<String, Object> selectBasicInfo(Long memberId) throws Exception {
		   return sqlSession.selectOne("mapper.member.selectBasicInfo", memberId);
	}

	@Override
	public Map<String, Object> selectHeaderInfo(Long memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.selectBasicInfo", memberId);
	}

	@Override
	public String selectEmailByNameAndPhone(String name, String phone) throws Exception {
		Map<String, Object> params = new HashMap<>();
	    params.put("name", name);
	    params.put("phone", phone);
	    return sqlSession.selectOne("mapper.member.selectEmailByNameAndPhone", params);
	}

	@Override
	public Long selectIdByEmailAndPhone(String email, String phone) throws Exception {
		Map<String, Object> params = new HashMap<>();
	    params.put("email", email);
	    params.put("phone", phone);
	    return sqlSession.selectOne("mapper.member.selectIdByEmailAndPhone", params);
	}

	@Override
	public void resetPassword(Long memberId, String newPassword) throws Exception {
		 Map<String, Object> params = new HashMap<>();
		    params.put("memberId", memberId);
		    params.put("newPassword", newPassword);
		    sqlSession.update("mapper.member.resetPassword", params);
		    sqlSession.commit();
		
	}

}
