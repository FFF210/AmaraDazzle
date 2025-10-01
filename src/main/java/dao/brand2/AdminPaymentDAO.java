package dao.brand2;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import dto.brand2.AdminToss;

@Mapper
public interface AdminPaymentDAO {
	
	void insertAdminPayment(AdminToss payment) throws Exception;
	
	 int updateSuccessByOrderId(@Param("orderId") String orderId,
             @Param("paymentKey") String paymentKey,
//             @Param("method") String method,
             @Param("amount") Integer amount,
             @Param("approvedAt") String approvedAt); // pay_date
//             @Param("receiptUrl") String receiptUrl);
	
	 int updateFailedByOrderId(@Param("orderId") String orderId,
             @Param("paymentKey") String paymentKey);
//             @Param("failReason") String failReason);
}

