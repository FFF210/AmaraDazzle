package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand2.BannerDAO;
import dao.brand2.BannerDAOImpl;
import dto.Banner;

public class AdbannerServiceImpl implements AdbannerService {

	private BannerDAO bannerDAO;
	
	public AdbannerServiceImpl() {
		bannerDAO = new BannerDAOImpl();
	}
	/*
	 * @Override public void registerBanner(BannerForm bannerForm) throws Exception
	 * {
	 * 
	 * try { SqlSession sqlSession =
	 * MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	 * 
	 * // MyBatis에서 Mapper 구현체 생성 BannerDAO bannerDAO =
	 * sqlSession.getMapper(BannerDAO.class); UploadFileDAO uploadFileDAO =
	 * sqlSession.getMapper(UploadFileDAO.class); AdminPaymentDAO adminPaymentDAO =
	 * sqlSession.getMapper(AdminPaymentDAO.class);
	 * 
	 * // 1. 업로드 파일 DTO 변환 + 저장 UploadFile file = new UploadFile();
	 * file.setUploadFileId(bannerForm.getUploadFileId());
	 * uploadFileDAO.insertUploadFile(file);
	 * 
	 * // 2. 배너 DTO 변환 + 저장 Banner banner = new Banner();
	 * banner.setBrandId(bannerForm.getBrandId());
	 * banner.setManagerName(bannerForm.getManagerName());
	 * banner.setManagerTel(bannerForm.getManagerTel());
	 * banner.setStartDate(bannerForm.getStartDate());
	 * banner.setEndDate(bannerForm.getEndDate());
	 * banner.setBannerName(bannerForm.getBannerName());
	 * banner.setBannerMessage(bannerForm.getBannerMessage());
	 * banner.setBrandUrl(bannerForm.getBrandUrl()); banner.setStatus("PENDING");
	 * 
	 * bannerDAO.insertBanner(banner);
	 * 
	 * // 3. 결제 DTO 변환 + 저장 AdminPayment payment = new AdminPayment();
	 * payment.setBrandId(bannerForm.getBrandId());
	 * adminPaymentDAO.insertAdminPayment(payment);
	 * 
	 * sqlSession.commit(); } catch (Exception e) { e.printStackTrace();
	 * 
	 * } }
	 */
	
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
}