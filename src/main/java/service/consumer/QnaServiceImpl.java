package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.QnaDAO;
import dao.consumer.QnaDAOImpl;
import dto.Qna;

public class QnaServiceImpl implements QnaService {

	private QnaDAO qnaDAO;

	public QnaServiceImpl() {
		this.qnaDAO = new QnaDAOImpl();
	}

	// 상품별 문의 목록 조회
	@Override
	public List<Qna> getQnasByProductId(Long productId) throws Exception {
		if (productId == null || productId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
		}

		List<Qna> qnas = qnaDAO.selectQnasByProductId(productId);
		return qnas; // 빈 리스트라도 반환
	}

	// 페이지네이션용 문의 조회
	@Override
	public List<Qna> getQnasByProductIdWithPaging(Long productId, int page, int pageSize) throws Exception {
		if (productId == null || productId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
		}
		if (page < 1) {
			page = 1; // 최소 1페이지
		}
		if (pageSize < 1) {
			pageSize = 10; // 기본값 10개
		}

		// OFFSET 계산: (페이지 - 1) × 페이지당 개수
		int offset = (page - 1) * pageSize;

		// Map으로 파라미터 전달
		Map<String, Object> params = new HashMap<>();
		params.put("productId", productId);
		params.put("limit", pageSize);
		params.put("offset", offset);

		return qnaDAO.selectQnasByProductIdWithPaging(params);
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
