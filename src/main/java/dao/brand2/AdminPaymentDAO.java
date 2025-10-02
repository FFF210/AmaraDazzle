package dao.brand2;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import dto.AdminPayment;
import dto.brand2.AdminToss;

@Mapper
public interface AdminPaymentDAO {
	
	void insertAdminPayment(AdminPayment payment) throws Exception;
	
	void updateSuccessByOrderId(AdminPayment adminPayment);

}

