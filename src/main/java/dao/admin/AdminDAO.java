package dao.admin;

import java.util.Map;

import dto.AdminInfo;

public interface AdminDAO {

	AdminInfo adminLoginConfirm(Map<String, String> map) throws Exception;	//관리자 로그인

}
