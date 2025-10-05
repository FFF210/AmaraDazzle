package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand.CancelOrderList;
import dto.brand.OrdersItemDetail;
import dto.brand.OrdersList;
import dto.brand.OrdersSummary;
import util.MybatisSqlSessionFactory;

public class OrdersDAOImpl implements OrdersDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	// 주문 목록 조회
	@Override
	public List<OrdersList> selectOrdersListForBrand(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.orders.selectOrdersListForBrand", params);
	}

	// 주문 개수 조회
	@Override
	public Integer selectOrdersCountForBrand(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.orders.selectOrdersCountForBrand", params);
	}

	// 주문 요약 조회
	@Override
	public OrdersSummary selectOrderSummaryForBrand(Map<String, Object> params) {
		return sqlSession.selectOne("mapper.orders.selectOrderSummaryForBrand", params);
	}

	// 주문 상품 상세 조회
	@Override
	public List<OrdersItemDetail> selectOrderItemsForBrand(Map<String, Object> params) {
		return sqlSession.selectList("mapper.orders.selectOrderItemsForBrand", params);
	}

	// 취소 주문 목록 조회
	@Override
	public List<CancelOrderList> selectCancelledOrdersList(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.orders.selectCancelledOrdersList", params);
	}

	// 취소 주문 개수 조회
	@Override
	public Integer selectCancelledOrdersCount(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.orders.selectCancelledOrdersCount", params);
	}

}
