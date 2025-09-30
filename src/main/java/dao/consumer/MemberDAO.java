package dao.consumer;

import java.util.Map;

import dto.Member;

public interface MemberDAO {
	// 회원가입 (회원등록) //
	void insertMember(Member member) throws Exception;

	/**
	 * 회원 조회 (내가 이걸 왜 만들었더라...)
	 * 
	 * @param params 조회 조건 (memberId, email, nickname, phone, kakaoId 등)
	 * @return 조회된 회원 정보, 없으면 null
	 */
	Member selectMember(Map<String, Object> params) throws Exception;

	/**
	 * 로그인 - 이메일과 비밀번호로 회원 조회
	 * 
	 * @param email 이메일, password 비밀번호
	 * @return 조회된 회원 정보, 없으면 null
	 */
	Member selectByEmailAndPassword(String email, String password) throws Exception;

	/**
	 * 이메일로 회원 조회 (중복 체크, 아이디 찾기 등)
	 * 
	 * @param email 조회할 이메일
	 * @return 조회된 회원 정보, 없으면 null
	 */
	Member selectByEmail(String email) throws Exception;

	/**
	 * 회원 ID로 회원 조회 (마이페이지, 주문 등에서 사용)
	 * @param memberId 회원 ID
	 * @return 조회된 회원 정보, 없으면 null
	 */
	Member selectById(Long memberId) throws Exception;

	/**
	 * 이메일과 휴대폰으로 회원 ID 찾기 (비밀번호 재설정용)
	 * @param email 이메일
	 * @param phone 휴대폰 번호
	 * @return 회원 ID (없으면 null)
	 */
	Long selectIdByEmailAndPhone(String email, String phone) throws Exception;

	// 회원정보 수정//
	void updateMember(Member member) throws Exception;

	/**
	 * 비밀번호 변경
	 * @param memberId 회원 ID, newPassword 새 비밀번호
	 */
	void updatePassword(Long memberId, String newPassword) throws Exception;

	/**
	 * 포인트 업데이트 (적립, 사용)
	 * @param memberId 회원 ID, pointChange 포인트 변경량 (양수: 적립, 음수: 사용)
	 */
	void updatePoints(Long memberId, int pointChange) throws Exception;

	/**
	 * 회원 등급 업데이트
	 * @param memberId 회원 ID
	 * @param grade    새 등급 (NORMAL, SILVER, GOLD, VIP)
	 */
	void updateGrade(Long memberId, String grade) throws Exception;

	/**
	 * 회원 탈퇴 (실제 삭제가 아닌 상태 변경)
	 * @param memberId 회원 ID
	 */
	void deleteMember(Long memberId) throws Exception;

	/**
	 * 카카오 ID로 회원 조회 (카카오 로그인용)
	 * @param kakaoId 카카오 고유 식별자
	 * @return 조회된 회원 정보, 없으면 null
	 */
	Member selectByKakaoId(Long kakaoId) throws Exception;

	/**
	 * 마이페이지용 - 회원의 기본 정보만 조회
	 * @param memberId 회원 ID
	 * @return 기본 정보 Map (memberId, email, name, nickname, phone, pointBalance,
	 *         grade, joinDate)
	 */
	Map<String, Object> selectMemberInfo(Long memberId) throws Exception;

	/**
	 * 헤더용 - 로그인한 회원의 기본 정보 (이름, 포인트)
	 * 
	 * @param memberId 회원 ID
	 * @return 헤더 표시용 기본 정보
	 */
	Map<String, Object> selectHeaderInfo(Long memberId) throws Exception;

	// 이름과 휴대폰으로 이메일 찾기
	public String selectEmailByNameAndPhone(String name, String phone) throws Exception;

	// 비밀번호 재설정
	public void resetPassword(Long memberId, String newPassword) throws Exception;

	// 체크아웃(주문/결제)용======================================
	/**
	 * 체크아웃 페이지용 회원 정보 조회- 이름, 전화번호, 주소, 포인트 정보만 조회
	 * 
	 * @param memberId 회원 ID
	 * @return Member 객체 (필요한 정보만)
	 */
	Member getMemberInfoForCheckout(Long memberId) throws Exception;

	/**
	 * 회원 포인트 잔액 조회 - 현재 보유 포인트만 조회
	 * 
	 * @param memberId 회원 ID
	 * @return 포인트 잔액
	 */
	Integer getMemberPointBalance(Long memberId) throws Exception;

	/**
	 * 회원 포인트 사용 (차감) - 주문 시 포인트 사용할 때
	 * 
	 * @param memberId 회원 ID, param usingPoint 사용할 포인트
	 * @return 성공 시 1, 실패 시 0 (포인트 부족 시 포함)
	 */
	int useMemberPoint(Long memberId, int usingPoint) throws Exception;

	/**
	 * 포인트 사용 가능 여부 확인 - 포인트 사용 전 잔액 확인
	 * 
	 * @param memberId 회원 ID, usingPoint 사용하려는 포인트
	 * @return true: 사용 가능, false: 잔액 부족
	 */
	boolean checkPointAvailable(Long memberId, int usingPoint) throws Exception;
}
