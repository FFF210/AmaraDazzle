package service.consumer;

import java.util.List;

import dao.consumer.QnaDAO;
import dao.consumer.QnaDAOImpl;
import dto.Qna;

public class QnaServiceImpl implements QnaService {

	private QnaDAO qnaDAO;

	public QnaServiceImpl() {
		this.qnaDAO = new QnaDAOImpl();
	}

	@Override
	public List<Qna> getQnasByProductId(Long productId) throws Exception {
		if (productId == null || productId <= 0) {
            throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
        }
        
        List<Qna> qnas = qnaDAO.selectQnasByProductId(productId);
        return qnas; // 빈 리스트라도 반환
	}

	@Override
	public Integer getQnaCount(Long productId) throws Exception {
		if (productId == null || productId <= 0) {
            throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
        }
        
        return qnaDAO.getQnaCountByProductId(productId);
	}

	@Override
	public void createQna(Qna qna) throws Exception {
		qnaDAO.insertQna(qna);	
	}

}
