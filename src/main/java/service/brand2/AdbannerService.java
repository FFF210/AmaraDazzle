package service.brand2;

import java.util.Map;

import dto.AdminPayment;
import dto.Banner;
import dto.UploadFile;

public interface AdbannerService {
	
	// 배너 신청 등록
	public void registerBanner(Banner banner) throws Exception;
	
	// 배너 신청 목록 조회
	Map<String, Object> AdbannerListByPage(Map<String, Object> params) throws Exception;
	
	// 배너 상세보기 버튼
	Banner getBannerById(long bannerId) throws Exception;
	
	// 배너 취소 버튼
	void cancelBanner(Map<String, Object> params) throws Exception;
	
	// AdminToss 결제 저장
	void savePayment(AdminPayment adminPayment) throws Exception;
	
	// 파일 저장
	void registerUploadFile(UploadFile uploadFile);
}
