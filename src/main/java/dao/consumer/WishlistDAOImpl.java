package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import util.MybatisSqlSessionFactory;

public class WishlistDAOImpl implements WishlistDAO {

	// ================[소비자] 상품 찜 버튼 클릭 ===================
	@Override
	public void insertWishlist(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.wishlist.insertWishlist", params);
			sqlSession.commit();
		}
	}

	// ================[소비자] 이미 찜한 상품인지 확인 ===================
	@Override
	public int existsWishlist(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.wishlist.existsWishlist", params);
		}
	}

	// ================[소비자] 찜 취소 ===================
	@Override
	public void deleteWishlist(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.delete("mapper.wishlist.deleteWishlist", params);
			sqlSession.commit();
		}
	}

	// ================[소비자] 위시리스트 목록 조회 ===================
	@Override
	public List<Map<String, Object>> selectWishlistByMemberId(Long memberId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.wishlist.selectWishlistByMemberId", memberId);
		}
	}

	// ================[소비자] 찜 개수 조회 ===================
	@Override
	public int countWishlistByMemberId(Long memberId){
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.wishlist.countWishlistByMemberId", memberId);
		}
	}

}
