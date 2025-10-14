package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import util.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> selectAvailableProducts(Map<String, Object> params) throws Exception {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectList("mapper.product.selectAvailableProducts", params);
        }
    }
}
