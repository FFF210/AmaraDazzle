package service.admin;

import dao.admin.SettlementDAO;
import dao.admin.SettlementDAOImpl;
import util.Paging;
import util.SearchUtil;

public class SettlementServiceImpl implements SettlementService{
	private SettlementDAO settle_dao;

	public SettlementServiceImpl() {
		settle_dao = new SettlementDAOImpl();
	}

	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();
	

}
