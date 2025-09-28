package dao.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.CartItem;
import util.MybatisSqlSessionFactory;

public class CartItemDAOImpl implements CartItemDAO {

	private SqlSession sqlSession;

	public CartItemDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	@Override
	public void insertCartItem(CartItem cartItem) throws Exception {
		sqlSession.insert("mapper.cartItem.insertCartItem", cartItem);
		sqlSession.commit();
	}

	@Override
	public List<Map<String, Object>> selectCartItemByMemberId(Long memberId) throws Exception {
		return sqlSession.selectList("mapper.cartItem.selectCartItemByMemberId", memberId);
	}

	@Override
	public void updateCartItemQuantity(Long cartItemId, Long memberId, int quantity) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("cartItemId", cartItemId);
		params.put("memberId", memberId);
		params.put("quantity", quantity);

		sqlSession.update("mapper.cartItem.updateCartItemQuantity", params);
		sqlSession.commit();
	}

	@Override
	public void deleteCartItemById(Long cartItemId, Long memberId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("cartItemId", cartItemId);
		params.put("memberId", memberId);

		sqlSession.delete("mapper.cartItem.deleteCartItemById", params);
		sqlSession.commit();
	}

	@Override
	public int countCartItemByMemberId(Long memberId) throws Exception {
		Integer result = sqlSession.selectOne("mapper.cartItem.countCartItemByMemberId", memberId);
		return result != null ? result : 0;
	}

	@Override
	public List<Map<String, Object>> selectCartItemsByIds(Long memberId, List<Long> cartItemIds) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("cartItemIds", cartItemIds);

		return sqlSession.selectList("mapper.cartItem.selectCartItemsByIds", params);
	}

}
