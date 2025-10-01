package service.admin;

import dto.AdminInfo;

public interface AdminService {

	AdminInfo adminLoginConfirm(String aid, String apass) throws Exception;	//관리자 로그인

}
