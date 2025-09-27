package service.consumer;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import dao.consumer.MemberDAO;
import dao.consumer.MemberDAOImpl;
import dto.Member;

public class MemberServiceImpl implements MemberService {

	private MemberDAO memberDAO;

	public MemberServiceImpl() {
		this.memberDAO = new MemberDAOImpl();
	}

	@Override
	public Member login(String email, String password) throws Exception {
		// 입력값 검증
		if (email == null || email.trim().isEmpty()) {
			throw new Exception("이메일을 입력해주세요.");
		}
		if (password == null || password.trim().isEmpty()) {
			throw new Exception("비밀번호를 입력해주세요.");
		}

		// 로그인 시도
		Member member = memberDAO.selectByEmailAndPassword(email.trim(), password);

		if (member == null) {
			throw new Exception("이메일 또는 비밀번호가 올바르지 않습니다.");
		}

		// 계정 상태 확인
		if (!"ACTIVE".equals(member.getStatus())) {
			throw new Exception("비활성화된 계정입니다. 고객센터에 문의하세요.");
		}

		return member;
	}

	@Override
	public void join(Member member) throws Exception {

		// 중복 체크
		if (memberDAO.countByEmail(member.getEmail()) > 0) {
			throw new Exception("이미 사용 중인 이메일입니다.");
		}

		// 기본값 설정
		member.setStatus("ACTIVE");
		member.setPointBalance(0);
		member.setGrade("NORMAL");
		member.setLoginType("EMAIL");
		member.setMarketingOpt(0);

		// 회원 등록
		memberDAO.insertMember(member);
	}

	@Override
	public boolean checkEmailAvailable(String email) throws Exception {
		if (email == null || email.trim().isEmpty()) {
			return false;
		}
		return memberDAO.countByEmail(email.trim()) == 0;
	}

	@Override
	public Member getMemberInfo(Long memberId) throws Exception {
		if (memberId == null) {
			throw new Exception("회원 ID가 필요합니다.");
		}

		Member member = memberDAO.selectById(memberId);
		if (member == null) {
			throw new Exception("존재하지 않는 회원입니다.");
		}

		return member;
	}

	@Override
	public Map<String, Object> getHeaderInfo(Long memberId) throws Exception {
		if (memberId == null) {
			return null;
		}

		return memberDAO.selectHeaderInfo(memberId);
	}

	@Override
	public void updateMemberInfo(Member member) throws Exception {
		if (member == null || member.getMemberId() == null) {
			throw new Exception("회원 정보가 올바르지 않습니다.");
		}

		// 기존 회원 존재 확인
		Member existingMember = memberDAO.selectById(member.getMemberId());
		if (existingMember == null) {
			throw new Exception("존재하지 않는 회원입니다.");
		}
		memberDAO.updateMember(member);
	}

	@Override
	public void changePassword(Long memberId, String currentPassword, String newPassword) throws Exception {
		// 입력값 검증
		if (memberId == null) {
			throw new Exception("회원 ID가 필요합니다.");
		}
		if (currentPassword == null || currentPassword.trim().isEmpty()) {
			throw new Exception("현재 비밀번호를 입력해주세요.");
		}
		if (newPassword == null || newPassword.trim().isEmpty()) {
			throw new Exception("새 비밀번호를 입력해주세요.");
		}

		// 현재 비밀번호 확인
		Member member = memberDAO.selectById(memberId);
		if (member == null) {
			throw new Exception("존재하지 않는 회원입니다.");
		}

		if (!currentPassword.equals(member.getPassword())) {
			throw new Exception("현재 비밀번호가 올바르지 않습니다.");
		}

		// 비밀번호 변경
		memberDAO.updatePassword(memberId, newPassword);
	}

	@Override
	public void addPoints(Long memberId, int points) throws Exception {
		if (memberId == null) {
			throw new Exception("회원 ID가 필요합니다.");
		}
		if (points <= 0) {
			throw new Exception("적립할 포인트는 0보다 커야 합니다.");
		}

		memberDAO.updatePoints(memberId, points);

	}

	@Override
	public void usePoints(Long memberId, int points) throws Exception {
		if (memberId == null) {
			throw new Exception("회원 ID가 필요합니다.");
		}
		if (points <= 0) {
			throw new Exception("사용할 포인트는 0보다 커야 합니다.");
		}

		// 현재 포인트 확인
		Member member = memberDAO.selectById(memberId);
		if (member == null) {
			throw new Exception("존재하지 않는 회원입니다.");
		}

		if (member.getPointBalance() < points) {
			throw new Exception("보유 포인트가 부족합니다. (보유: " + member.getPointBalance() + "P)");
		}

		memberDAO.updatePoints(memberId, -points);
	}

	@Override
	public String findEmailByNameAndPhone(String name, String phone) throws Exception {
		// 입력값 검증
		if (name == null || name.trim().isEmpty()) {
			throw new Exception("이름을 입력해주세요.");
		}
		if (phone == null || phone.trim().isEmpty()) {
			throw new Exception("휴대폰 번호를 입력해주세요.");
		}

		// 이메일 조회
		String email = memberDAO.selectEmailByNameAndPhone(name.trim(), phone.trim());

		if (email == null) {
			throw new Exception("입력하신 정보와 일치하는 계정을 찾을 수 없습니다.");
		}

		// 이메일 마스킹 처리 (예: abc***@gmail.com)
		return email;
	}

	@Override
	public Long verifyForPasswordReset(String email, String phone) throws Exception {
		if (email == null || email.trim().isEmpty()) {
			throw new Exception("이메일을 입력해주세요.");
		}
		if (phone == null || phone.trim().isEmpty()) {
			throw new Exception("휴대폰 번호를 입력해주세요.");
		}

		// 회원 ID 조회 (이메일과 휴대폰 번호 일치 확인)
		Long memberId = memberDAO.selectIdByEmailAndPhone(email.trim(), phone.trim());

		if (memberId == null) {
			throw new Exception("입력하신 정보와 일치하는 계정을 찾을 수 없습니다.");
		}

		return memberId;
	}

	@Override
	public void resetPassword(Long memberId, String newPassword) throws Exception {
		// 입력값 검증
		if (memberId == null) {
			throw new Exception("회원 정보가 올바르지 않습니다.");
		}
		if (newPassword == null || newPassword.trim().isEmpty()) {
			throw new Exception("새 비밀번호를 입력해주세요.");
		}

		// 비밀번호 재설정
		memberDAO.resetPassword(memberId, newPassword);
	}

	@Override
	public Member kakaoLogin(String code) throws Exception {
		String token = getKaKaoToken(code);
		System.out.println(token);

		Member member = getKakaoUserInfo(token);

		// ✅ 수정: Map으로 파라미터 전달
		Map<String, Object> params = new HashMap<>();
		params.put("kakaoId", member.getKakaoId());
		Member existingMember = memberDAO.selectMember(params);

		if (existingMember != null) {
			// 기존 회원이 있으면 정보 업데이트
			existingMember.setNickname(member.getNickname());
			memberDAO.updateMember(existingMember);
			return existingMember;
		} else {
			// 신규 회원이면 추가 정보 설정 후 등록
			member.setStatus("ACTIVE");
			member.setPointBalance(0);
			member.setGrade("NORMAL");
			member.setLoginType("KAKAO");
			member.setMarketingOpt(0);
			memberDAO.insertMember(member);
			return member;
		}
	}
	
	 private String getKaKaoToken(String code) throws Exception {
	        String tokenUrl = "https://kauth.kakao.com/oauth/token";
	        URL url = new URL(tokenUrl);
	        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
	        conn.setDoOutput(true);
	        
	        StringBuilder param = new StringBuilder();
	        param.append("grant_type=authorization_code");
	        param.append("&client_id=44080c9c34460d38b051817cfe95bd57");
	        param.append("&redirect_uri=http://localhost:8080/social/kakao");
	        param.append("&code=" + code);
	        
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        bw.write(param.toString());
	        bw.flush();
	        
	        BufferedReader br;
	        int resCode = conn.getResponseCode();
	        if(resCode == 200) {
	            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        
	        StringBuilder resBuilder = new StringBuilder();
	        String line;
	        while((line = br.readLine()) != null) {
	            resBuilder.append(line);
	        }
	        
	        br.close();
	        conn.disconnect();
	        
	        System.out.println(resBuilder.toString());
	        JSONParser parser = new JSONParser();
	        JSONObject jsonObj = (JSONObject)parser.parse(resBuilder.toString());
	        String accessToken = (String)jsonObj.get("access_token");
	        
	        return accessToken;
	    }


	private Member getKakaoUserInfo(String token) throws Exception {
		String userUrl = "https://kapi.kakao.com/v2/user/me";
		URL url = new URL(userUrl);

		HttpURLConnection conn = null;
		try {
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setRequestProperty("Authorization", "Bearer " + token);

			BufferedReader br = null;
			int code = conn.getResponseCode();

			if (code == 200) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			StringBuilder resBuilder = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				resBuilder.append(line);
			}

			br.close();
			conn.disconnect();

			System.out.println("카카오 응답: " + resBuilder.toString());

			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject) parser.parse(resBuilder.toString());
			Long id = (Long) jsonObj.get("id");
			JSONObject properties = (JSONObject) jsonObj.get("properties");
			String nickname = (String) properties.get("nickname");

			Member member = new Member();
			member.setKakaoId(id); //
			member.setNickname(nickname);
			
			member.setLoginType("KAKAO");
	        member.setStatus("ACTIVE");
	        member.setPointBalance(0);
	        member.setGrade("NORMAL");
	        member.setMarketingOpt(0);

			return member;

		} catch (Exception e) {
			throw new Exception("카카오 사용자 정보 조회 실패: " + e.getMessage());
		}
	}
}
