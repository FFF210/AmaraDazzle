package service.consumer;

import java.util.List;

import dto.Banner;
import dto.consumer.BrandSearchResult;

public interface BannerService {
	// 메인페이지 배너 노출 목록 조회
	List<Banner> getBannerList() throws Exception;
}
