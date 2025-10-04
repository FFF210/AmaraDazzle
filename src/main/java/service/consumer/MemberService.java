package service.consumer;

import java.util.Map;

import dto.Member;
import dto.consumer.MemberFilter;

public interface MemberService {

	/**
	 * 로그인 처리
	 * 
	 * @param email    이메일
	 * @param password 비밀번호
	 * @return 로그인 성공 시 회원 정보, 실패 시 null
	 * @throws Exception 로그인 실패 또는 데이터베이스 오류 시
	 */
	Member login(String email, String password) throws Exception;

	/**
	 * 회원가입 처리
	 * 
	 * @param member 가입할 회원 정보
	 * @throws Exception 데이터베이스 오류 또는 비즈니스 규칙 위반 시
	 */
	void join(Member member) throws Exception;

	/**
	 * 이메일 중복 체크
	 * 
	 * @param email 체크할 이메일
	 * @return 사용 가능하면 true, 중복이면 false
	 * @throws Exception 데이터베이스 오류 시
	 */
	boolean checkEmailAvailable(String email) throws Exception;

	/**
	 * 회원 정보 조회 (마이페이지용)
	 * 
	 * @param memberId 회원 ID
	 * @return 회원 정보
	 * @throws Exception 데이터베이스 오류 시
	 */
	Member getMemberInfo(Long memberId) throws Exception;

	/**
	 * 헤더용 회원 기본 정보 조회
	 * 
	 * @param memberId 회원 ID
	 * @return 기본 정보 (이름, 포인트 등)
	 * @throws Exception 데이터베이스 오류 시
	 */
	Map<String, Object> getHeaderInfo(Long memberId) throws Exception;

	/**
	 * 회원 정보 수정
	 * 
	 * @param member 수정할 회원 정보
	 * @throws Exception 데이터베이스 오류 또는 검증 실패 시
	 */
	void updateMemberInfo(Member member) throws Exception;

	/**
	 * 비밀번호 변경
	 * 
	 * @param memberId        회원 ID
	 * @param currentPassword 현재 비밀번호
	 * @param newPassword     새 비밀번호
	 * @throws Exception 데이터베이스 오류 또는 검증 실패 시
	 */
	void changePassword(Long memberId, String currentPassword, String newPassword) throws Exception;

	/**
	 * 포인트 적립
	 * 
	 * @param memberId 회원 ID
	 * @param points   적립할 포인트
	 * @throws Exception 데이터베이스 오류 시
	 */
	void addPoints(Long memberId, int points) throws Exception;

	/**
	 * 포인트 사용
	 * 
	 * @param memberId 회원 ID
	 * @param points   사용할 포인트
	 * @throws Exception 데이터베이스 오류 또는 포인트 부족 시
	 */
	void usePoints(Long memberId, int points) throws Exception;

	/**
	 * 아이디(이메일) 찾기 - 이름과 휴대폰 번호로 이메일 찾기
	 * 
	 * @param name  이름
	 * @param phone 휴대폰 번호
	 * @return 찾은 이메일 (마스킹 처리), 없으면 null
	 * @throws Exception 데이터베이스 오류 시
	 */
	String findEmailByNameAndPhone(String name, String phone) throws Exception;

	/**
	 * 비밀번호 재설정 권한 확인 - 이메일과 휴대폰 번호 일치 확인
	 * 
	 * @param email 이메일
	 * @param phone 휴대폰 번호
	 * @return 일치하면 회원 ID, 불일치하면 null
	 * @throws Exception 데이터베이스 오류 시
	 */
	Long verifyForPasswordReset(String email, String phone) throws Exception;

	/**
	 * 비밀번호 재설정 (인증 후)
	 * 
	 * @param memberId    회원 ID
	 * @param newPassword 새 비밀번호
	 * @throws Exception 데이터베이스 오류 시
	 */
	void resetPassword(Long memberId, String newPassword) throws Exception;

	Member kakaoLogin(String code) throws Exception;

	// ================[소비자] 소비자 맞춤 필터링 모두 조회 ===================
	MemberFilter getMemberFilters(Long memberId) throws Exception;
}
