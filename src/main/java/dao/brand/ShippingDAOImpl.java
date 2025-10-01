package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand.ShippingDetailItem;
import dto.brand.ShippingList;
import util.MybatisSqlSessionFactory;

public class ShippingDAOImpl implements ShippingDAO {

	// 배송 목록 조회
	@Override
	public List<ShippingList> selectShippingListForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orderItem.selectShippingListForBrand", params);
		}
	}

	// 배송 목록 개수
	@Override
	public Integer selectShippingCountForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orderItem.selectShippingCountForBrand", params);
		}
	}

	// 배송 단일 조회
	@Override
	public ShippingList selectShippinDetailForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orderItem.selectShippinDetailForBrand", params);
		}
	}

	// 배송 상품 상세 조회
	@Override
	public List<ShippingDetailItem> selectShippingDetailItemsForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orderItem.selectShippingDetailItemsForBrand", params);
		}
	}

}
