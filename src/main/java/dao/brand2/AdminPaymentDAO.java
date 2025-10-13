package dao.brand2;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import dto.AdminPayment;
import dto.brand2.AdminToss;

@Mapper
public interface AdminPaymentDAO {
	
	void insertAdminPayment(AdminPayment payment) throws Exception;
	
	void updateSuccessByOrderId(AdminPayment adminPayment);

	// 배너, 상세보기 - 결제대기/결제완료용
	int existsByBannerId(long bannerId) throws Exception;
	
	// 배너 ID로 결제 내역 조회 (취소 시 사용)
    AdminPayment selectPaymentByBannerId(Long bannerId) throws Exception;
	
}