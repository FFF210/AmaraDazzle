package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Brand;
import service.brand.BrandService;
import service.brand.BrandServiceImpl;

/**
 * Servlet implementation class BrandApply
 */
@WebServlet("/brand/brandApply")
public class BrandApply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final BrandService service = new BrandServiceImpl();

	public BrandApply() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/brand/brandApply.jsp").forward(request, response);
	}

	/**
	 * 브랜드 입점신청 (POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		Long brandId = (Long) request.getSession().getAttribute("brandId");

		Brand brand = new Brand();
		brand.setBrandId(brandId);
		String logoFileIdStr = request.getParameter("logoFileId");
		if (logoFileIdStr != null && !logoFileIdStr.isEmpty()) {
			brand.setLogoFileId(Long.valueOf(logoFileIdStr));
		}
		String heroFileIdStr = request.getParameter("heroFileId");
		if (heroFileIdStr != null && !heroFileIdStr.isEmpty()) {
			brand.setHeroFileId(Long.valueOf(heroFileIdStr));
		}
		brand.setIntro(request.getParameter("intro"));
		brand.setBank(request.getParameter("bank"));
		brand.setAccountNumber(request.getParameter("accountNumber"));
		brand.setAccountHolder(request.getParameter("accountHolder"));
		brand.setSettlementDate(request.getParameter("settlementDate"));
		brand.setBrandStatus("APPLY_SUBMITTED"); // 상태 변경

		try {
			service.applyForBrand(brand);
			request.getRequestDispatcher("/brand/brandApplyComplete.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
