package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Banner;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class BannerDAOImpl implements BannerDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	//전체 배너 총 개수 
	@Override
	public Integer bannerAllCount(SearchConditionDTO sc_DTO) throws Exception {
		return ss.selectOne("mapper.banner.BannerAllCnt", sc_DTO);
	}

	//전체 배너 신청 리스트 
	@Override
	public List<Banner> bannerAllList(Map<String, Object> listMap) throws Exception {
		return ss.selectList("mapper.banner.selectAllBannerList",listMap);
	}

	//전체 배너 중 검색 리스트
	@Override
	public List<Banner> bannerSearchList(SearchConditionDTO sc_DTO) throws Exception {
		return ss.selectList("mapper.banner.selectSearchBannerList",sc_DTO);
	}

	//어드민 배너 등록
	@Override
	public int adminBannerWrite(Banner banner) {
		int result = ss.insert("mapper.banner.adminBannerWrite",banner);
		if(result > 0) {
			ss.commit();
		} else {
			ss.rollback();
		}
		
		return result;
	}

}
