package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dao.brand2.AdminPaymentDAO;
import dao.brand2.BannerDAO;
import dao.brand2.BannerDAOImpl;
import dto.Banner;
import dto.admin.SearchConditionDTO;
import dto.brand2.AdminToss;
import dto.brand2.BannerForm;
import util.MybatisSqlSessionFactory;
import util.Paging;
import util.SearchUtil;

public class AdbannerServiceImpl implements AdbannerService {
	private BannerDAO bannerDAO;
	private AdminPaymentDAO adminPaymentDAO;

	public AdbannerServiceImpl() {
		// dto 객체 초기화
		bannerDAO = new BannerDAOImpl();
//		this.adminPaymentDAO = new AdminPaymentDAOImpl();
	}
	
	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();
	
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

	@Override
	public void savePayment(AdminToss payment) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			sqlSession.insert("mapper.adminPayment.insertAdminPayment", payment);

			sqlSession.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	// ***ADMIN********************************************************
	
	//전체 배너 총 개수 
	@Override
	public Integer bannerAllCnt(Map<String, String> cntMap) throws Exception {
		SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return bannerDAO.bannerAllCount(sc_DTO);
	}

	//전체 배너 신청 리스트 
	@Override
	public List<Banner> bannerAllList(Integer p_no) throws Exception {
		Map<String, Object> listMap = m_pg.paging(p_no);

		List<Banner> bannerAllList = bannerDAO.bannerAllList(listMap);
		return bannerAllList;
	}

	//전체 배너 중 검색 리스트
	@Override
	public List<Banner> bannerSearchList(Map<String, String> searchContent, Integer p_no) throws Exception {
		Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return bannerDAO.bannerSearchList(sc_DTO);
	}
}