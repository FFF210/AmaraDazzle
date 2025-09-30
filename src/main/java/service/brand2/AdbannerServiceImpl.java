package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dao.brand2.BannerDAO;
import dao.brand2.BannerDAOImpl;
import dto.Banner;
import dto.brand2.BannerForm;
import util.MybatisSqlSessionFactory;

public class AdbannerServiceImpl implements AdbannerService {

	private BannerDAO bannerDAO;
//	private AdminPaymentDAO adminPaymentDAO;

	public AdbannerServiceImpl() {
		// dto 객체 초기화
		bannerDAO = new BannerDAOImpl();
//		this.adminPaymentDAO = new AdminPaymentDAOImpl();
	}

//	배너 신청
	@Override
	public void registerBanner(BannerForm bannerForm) throws Exception {

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
//            AdminPaymentDAO adminPaymentDAO = sqlSession.getMapper(AdminPaymentDAO.class);

			// 2. 배너 DTO 변환 + 저장
			Banner banner = Banner.from(bannerForm);
			bannerDAO.insertBannerForm(banner);

//			// 3. 결제 DTO 변환 + 저장
//			AdminPayment payment = new AdminPayment();
//			payment.setBrandId(bannerForm.getBrandId());
//			adminPaymentDAO.insertAdminPayment(payment);

			sqlSession.commit();
		} catch (Exception e) {
			e.printStackTrace();

		}
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
}