package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand.CancelOrderItemDetail;
import dto.brand.CancelOrderList;
import dto.brand.CancelOrderSummary;
import dto.brand.ExchangeDetail;
import dto.brand.ExchangeOrderList;
import dto.brand.OrdersItemDetail;
import dto.brand.OrdersList;
import dto.brand.OrdersSummary;
import dto.brand.ReturnItemDetail;
import dto.brand.ReturnOrderList;
import dto.brand.ReturnSummary;
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

	// 반품 요약 조회
	@Override
	public ReturnSummary selectReturnSummaryForBrand(Long returnId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.selectReturnSummaryForBrand", returnId);
		}
	}

	// 반품 상품 상세 조회
	@Override
	public List<ReturnItemDetail> selectReturnItemsForBrand(Long returnId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.selectReturnItemsForBrand", returnId);
		}
	}

	// 반품 상태 변경
	@Override
	public void updateReturnStatus(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orders.updateReturnStatus", params);
			sqlSession.commit();
		}

	}

	// 반품 거절 처리
	@Override
	public void updateReturnRejection(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orders.updateReturnRejection", params);
			sqlSession.commit();
		}

	}

	// 반품 송장 업데이트
	@Override
	public void updateReturnTrackingNo(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orders.updateReturnTrackingNo", params);
			sqlSession.commit();
		}
	}

	// 반품 완료 처리
	@Override
	public void autoCompleteReturn(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orders.autoCompleteReturn", params);
			sqlSession.commit();
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

	// 교환 상세 조회
	@Override
	public ExchangeDetail selectExchangeDetailForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.selectExchangeDetailForBrand", params);
		}
	}

	// 교환 거절
	@Override
	public void updateExchangeRejection(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orders.updateExchangeRejection", params);
			sqlSession.commit();
		}
	}

	// 교환 승인
	@Override
	public void updateExchangeApprove(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orders.updateExchangeApprove", params);
			sqlSession.commit();
		}
	}

	// 교환 배송
	@Override
	public void updateExchangeShipping(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orders.updateExchangeShipping", params);
			sqlSession.commit();
		}
	}

	// 교환 완료
	@Override
	public void updateExchangeCompleted(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orders.updateExchangeCompleted", params);
			sqlSession.commit();
		}
	}

	// 상품 배송
	@Override
	public void updateShippingInfo(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orderItem.updateShippingInfo", params);
			sqlSession.commit();
		}
	}

	// 배송 완료
	@Override
	public void updateStatusToDelivered(long orderId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.orderItem.updateStatusToDelivered", orderId);
			sqlSession.commit();
		}
	}
}
