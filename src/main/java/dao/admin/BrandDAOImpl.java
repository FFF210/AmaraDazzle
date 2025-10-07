package dao.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Brand;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class BrandDAOImpl implements BrandDAO {
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	//가입한 브랜드 총 개수 
	@Override
	public Integer brandAllCount(SearchConditionDTO sc_DTO) {
		return ss.selectOne("mapper.brand.brandAllCnt", sc_DTO);
	}

	//브랜드 검색 리스트 
	@Override
	public List<Brand> brandSearchList(SearchConditionDTO sc_DTO) {
		return ss.selectList("mapper.brand.brandSearchList",sc_DTO);
	}

}
