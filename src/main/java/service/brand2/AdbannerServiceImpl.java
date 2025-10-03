package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand2.AdminPaymentDAO;
import dao.brand2.AdminPaymentDAOImpl;
import dao.brand2.BannerDAO;
import dao.brand2.BannerDAOImpl;
import dto.AdminPayment;
import dto.Banner;

public class AdbannerServiceImpl implements AdbannerService {
	private BannerDAO bannerDAO;
//	private UploadFileDAO uploadFileDAO;
	private AdminPaymentDAO adminPaymentDAO;

	public AdbannerServiceImpl() {
		bannerDAO = new BannerDAOImpl();
//		uploadFileDAO = new UploadFileDAOImpl();
		adminPaymentDAO = new AdminPaymentDAOImpl();
	}

	// 배너 신청
	@Override
	public void registerBanner(Banner banner) throws Exception {
//		uploadFileDAO.insertFile(uploadFile); // 파일을 먼저 저장
//		banner.setUploadFileId(uploadFile.getUploadFileId()); // 반환된 pk를 banner에 저장
		bannerDAO.insertBannerForm(banner);
	}

	// 배너 신청 목록 조회
	@Override
	public Map<String, Object> AdbannerListByPage(Map<String, Object> params) throws Exception {
		// 신청 목록 조회
		List<Banner> adbannerList = bannerDAO.selectAdbannerList(params);

		// 총 배너 개수 조회
		int totalCount = bannerDAO.selectAdbannerCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("bannerList", adbannerList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 배너 상세보기 버튼
	@Override
	public Banner getBannerById(long bannerId) throws Exception {
		return bannerDAO.selectBannerById(bannerId);
	}

	// 배너 취소 버튼
	@Override
	public void cancelBanner(Map<String, Object> params) throws Exception {
	    bannerDAO.updateBannerStatus(params);   // DAO 호출
	}

	// 배너 결제
	@Override
	public void savePayment(AdminPayment adminPayment) throws Exception {
		adminPaymentDAO.insertAdminPayment(adminPayment);
	}
}