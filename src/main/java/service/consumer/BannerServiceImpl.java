package service.consumer;

import java.util.List;

import dao.consumer.BannerDAO;
import dao.consumer.BannerDAOImpl;
import dto.Banner;

public class BannerServiceImpl implements BannerService {

	private BannerDAO bannerDAO;

	public BannerServiceImpl() {
		bannerDAO = new BannerDAOImpl();
	}

	// 메인페이지 배너 노출 목록 조회
	@Override
	public List<Banner> getBannerList() throws Exception {
		return bannerDAO.selectBannerListForMain();
	}

}
