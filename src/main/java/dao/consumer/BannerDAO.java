package dao.consumer;

import java.util.List;

import dto.Banner;

public interface BannerDAO {
	// 메인페이지 배너 노출 목록
	List<Banner> selectBannerListForMain() throws Exception;
}
