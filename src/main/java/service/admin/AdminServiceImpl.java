package service.admin;

import java.util.HashMap;
import java.util.Map;

import dao.admin.AdminDAO;
import dao.admin.AdminDAOImpl;
import dto.AdminInfo;

public class AdminServiceImpl implements AdminService {
	
	private AdminDAO a_dao;

	public AdminServiceImpl() {
		a_dao = new AdminDAOImpl();
	}
	
	Map<String, String> map = null;

	//관리자 로그인
	@Override
	public AdminInfo adminLoginConfirm(String aid, String apass) throws Exception {
		this.map = new HashMap<>();
		this.map.put("id", aid);
		this.map.put("password", apass);
		
		AdminInfo admin_DTO = a_dao.adminLoginConfirm(this.map);
		return admin_DTO;
	}

}
