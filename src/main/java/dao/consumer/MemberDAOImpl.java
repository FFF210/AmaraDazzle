package dao.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Member;
import dto.MemberSkinIssue;
import dto.consumer.MemberFilter;
import util.MybatisSqlSessionFactory;

public class MemberDAOImpl implements MemberDAO {

	private SqlSession sqlSession;

	public MemberDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	// 회원가입 (회원등록) //
	@Override
	public void insertMember(Member member) throws Exception {
		sqlSession.insert("mapper.member.insertMember", member);
		sqlSession.commit();
	}

	// 범용 회원 조회
	@Override
	public Member selectMember(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.member.selectMember", params);
	}

	// 로그인 용도
	@Override
	public Member selectByEmailAndPassword(String email, String password) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		params.put("password", password);
		return sqlSession.selectOne("mapper.member.selectByEmailAndPassword", params);
	}

	// 아이디(이메일) 찾기, 중복체크
	@Override
	public Member selectByEmail(String email) throws Exception {
		return sqlSession.selectOne("mapper.member.selectByEmail", email);
	}

	// 회원ID로 회원 조회 (마이페이지 및 주문조회 용도)
	@Override
	public Member selectById(Long memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.selectById", memberId);
	}
	
	// 회원정보 수정
	@Override
	public void updateMember(Member member) throws Exception {
		sqlSession.update("mapper.member.updateMember", member);
		sqlSession.commit();
	}

	// 이메일과 휴대폰으로 회원 ID 찾기 (비밀번호 재설정용)
	@Override
	public Long selectIdByEmailAndPhone(String email, String phone) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		params.put("phone", phone);
		return sqlSession.selectOne("mapper.member.selectIdByEmailAndPhone", params);
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

	// 등급 변경
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

	// 마이페이지용 - 회원의 기본 정보만 조회
	@Override
	public Map<String, Object> selectMemberInfo(Long memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.selectMemberInfo", memberId);
	}

	//이거...헤더인포용으로 만들어놓고 안 썼네...지워도 될 것 같은데
	@Override
	public Map<String, Object> selectHeaderInfo(Long memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.selectMemberInfo", memberId);
	}

	@Override
	public String selectEmailByNameAndPhone(String name, String phone) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("name", name);
		params.put("phone", phone);
		return sqlSession.selectOne("mapper.member.selectEmailByNameAndPhone", params);
	}

	@Override
	public void resetPassword(Long memberId, String newPassword) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("newPassword", newPassword);
		sqlSession.update("mapper.member.resetPassword", params);
		sqlSession.commit();

	}

	// =================체크아웃용 >> 그래서 OrderService에 추가...

	@Override
	public Member getMemberInfoForCheckout(Long memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.getMemberInfoForCheckout", memberId);
	}

	@Override
	public Integer getMemberPointBalance(Long memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.getMemberPointBalance", memberId);
	}

	@Override
	public int useMemberPoint(Long memberId, int usingPoint) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("usingPoint", usingPoint);

		int result = sqlSession.update("mapper.member.useMemberPoint", params);
		sqlSession.commit();
		return result;
	}

	@Override
	public boolean checkPointAvailable(Long memberId, int usingPoint) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("usingPoint", usingPoint);

		return sqlSession.selectOne("mapper.member.checkPointAvailable", params);
	}


	//피부 고민 (회원정보수정) ===========================

	@Override
	public void deleteMemberSkinIssues(Long memberId) throws Exception {
		sqlSession.delete("mapper.member.deleteMemberSkinIssues", memberId);
        sqlSession.commit();		
	}

	@Override
	public void insertMemberSkinIssue(MemberSkinIssue skinIssue) throws Exception {
		sqlSession.insert("mapper.member.insertMemberSkinIssue", skinIssue);
        sqlSession.commit();
	}

	// ================[소비자] 회원 맞춤 필터 조회 ===================
	@Override
	public MemberFilter selectMemberFilters(Long memberId) throws Exception {
		return sqlSession.selectOne("mapper.member.selectMemberFilters", memberId);
	}

	// ================[소비자] 피부 고민(다중값) 조회 ===================
	@Override
	public List<Long> selectMemberSkinIssues(Long memberId) throws Exception {
		return sqlSession.selectList("mapper.member.selectMemberSkinIssues", memberId);
		}

}
