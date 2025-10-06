package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand.CancelOrderItemDetail;
import dto.brand.CancelOrderList;
import dto.brand.CancelOrderSummary;
import dto.brand.ExchangeOrderList;
import dto.brand.OrdersItemDetail;
import dto.brand.OrdersList;
import dto.brand.OrdersSummary;
import dto.brand.ReturnOrderList;
import util.MybatisSqlSessionFactory;

public class OrdersDAOImpl implements OrdersDAO {

	// 주문 목록 조회
	@Override
	public List<OrdersList> selectOrdersListForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.selectOrdersListForBrand", params);
		}
	}

	// 주문 개수 조회
	@Override
	public Integer selectOrdersCountForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.selectOrdersCountForBrand", params);
		}
	}

	// 주문 요약 조회
	@Override
	public OrdersSummary selectOrderSummaryForBrand(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.selectOrderSummaryForBrand", params);
		}
	}

	// 주문 상품 목록 조회
	@Override
	public List<OrdersItemDetail> selectOrderItemsForBrand(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.selectOrderItemsForBrand", params);
		}
	}

	// 취소 주문 목록 조회
	@Override
	public List<CancelOrderList> selectCancelledOrdersList(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.selectCancelledOrdersList", params);
		}
	}

	// 취소 주문 개수 조회
	@Override
	public Integer selectCancelledOrdersCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.selectCancelledOrdersCount", params);
		}
	}

	// 취소 주문 요약 조회
	@Override
	public CancelOrderSummary selectCancelledOrderSummaryForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.selectCancelledOrderSummaryForBrand", params);
		}
	}

	// 취소 상품 목록 조회
	@Override
	public List<CancelOrderItemDetail> selectCancelledOrderItemsForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.selectCancelledOrderItemsForBrand", params);
		}
	}

	// 반품 주문 목록 조회
	@Override
	public List<ReturnOrderList> selectReturnedOrdersList(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.selectReturnedOrdersList", params);
		}
	}

	// 반품 주문 개수 조회
	@Override
	public Integer selectReturnedOrdersCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.selectReturnedOrdersCount", params);
		}
	}

	// 교환 주문 목록 조회
	@Override
	public List<ExchangeOrderList> selectExchangeOrdersList(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.selectExchangeOrdersList", params);
		}
	}

	// 교환 주문 개수 조회
	@Override
	public Integer selectExchangeOrdersCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.selectExchangeOrdersCount", params);
		}
	}

}
