package service.brand2;

import org.apache.ibatis.session.SqlSession;

import dao.brand2.AdminPaymentDAO;
import dao.brand2.BannerDAO;
import dao.brand2.UploadFileDAO;
import dto.AdminPayment;
import dto.Banner;
import dto.UploadFile;
import dto.brand2.BannerForm;
import util.MybatisSqlSessionFactory;

public class AdbannerServiceImpl implements AdbannerService {

	@Override
	public void registerBanner(BannerForm bannerForm) throws Exception {

		try {
			SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

			// MyBatis에서 Mapper 구현체 생성
			BannerDAO bannerDAO = sqlSession.getMapper(BannerDAO.class);
			UploadFileDAO uploadFileDAO = sqlSession.getMapper(UploadFileDAO.class);
			AdminPaymentDAO adminPaymentDAO = sqlSession.getMapper(AdminPaymentDAO.class);

			// 1. 업로드 파일 DTO 변환 + 저장
			UploadFile file = new UploadFile();
			file.setUploadFileId(bannerForm.getUploadFileId());
			uploadFileDAO.insertUploadFile(file);

			// 2. 배너 DTO 변환 + 저장
			Banner banner = new Banner();
			banner.setBrandId(bannerForm.getBrandId());
			banner.setManagerName(bannerForm.getManagerName());
			banner.setManagerTel(bannerForm.getManagerTel());
			banner.setStartDate(bannerForm.getStartDate());
			banner.setEndDate(bannerForm.getEndDate());
			banner.setBannerName(bannerForm.getBannerName());
			banner.setBannerMessage(bannerForm.getBannerMessage());
			banner.setBrandUrl(bannerForm.getBrandUrl());
			banner.setStatus("PENDING");

			bannerDAO.insertBanner(banner);

			// 3. 결제 DTO 변환 + 저장
			AdminPayment payment = new AdminPayment();
			payment.setBrandId(bannerForm.getBrandId());
			adminPaymentDAO.insertAdminPayment(payment);

			sqlSession.commit();
		} catch (Exception e) {
			e.printStackTrace();

		}
	}
}