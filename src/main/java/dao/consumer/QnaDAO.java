package dao.consumer;

import java.util.List;

import dto.Qna;

public interface QnaDAO {
	List<Qna> selectQnasByProductId(Long productId) throws Exception;
    Integer getQnaCountByProductId(Long productId) throws Exception;
}
