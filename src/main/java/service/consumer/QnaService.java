package service.consumer;

import java.util.List;

import dto.Qna;

public interface QnaService {
	List<Qna> getQnasByProductId(Long productId) throws Exception;
    Integer getQnaCount(Long productId) throws Exception;

}
