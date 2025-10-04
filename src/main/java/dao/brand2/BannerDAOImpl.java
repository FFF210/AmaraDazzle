package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Banner;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class BannerDAOImpl implements BannerDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	// 배너 신청
	@Override
	public void insertBannerForm(Banner banner) throws Exception {
		sqlSession.insert("mapper.banner.insertBannerForm", banner);
		sqlSession.commit();
	}

	// 배너 신청 목록 조회
	@Override
	public List<Banner> selectAdbannerList(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.banner.selectAdbannerList", params);
	}

	// 신청 개수 조회
	@Override
	public Integer selectAdbannerCount(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.banner.selectAdbannerCount", params);
	}
	// 배너 상세보기 버튼
	@Override
	public Banner selectBannerById(long bannerId) throws Exception {
		return sqlSession.selectOne("mapper.banner.selectBannerById", bannerId);
	}

	// 배너 취소 버튼
	@Override 
	public void updateBannerStatus(Map<String, Object> params) { 
		sqlSession.update("mapper.banner.updateBannerStatus", params);
		sqlSession.commit();
	}
	
	
	// ***ADMIN********************************************************
	
	//전체 배너 총 개수 
	@Override
	public Integer bannerAllCount(SearchConditionDTO sc_DTO) throws Exception {
		return sqlSession.selectOne("mapper.banner.BannerAllCnt", sc_DTO);
	}

	//전체 배너 신청 리스트 
	@Override
	public List<Banner> bannerAllList(Map<String, Object> listMap) throws Exception {
		return sqlSession.selectList("mapper.banner.selectAllBannerList",listMap);
	}

	//전체 배너 중 검색 리스트
	@Override
	public List<Banner> bannerSearchList(SearchConditionDTO sc_DTO) throws Exception {
		return sqlSession.selectList("mapper.banner.selectSearchBannerList",sc_DTO);
	}
}
