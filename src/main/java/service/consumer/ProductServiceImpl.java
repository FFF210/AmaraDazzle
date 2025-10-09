package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.ProductDAO;
import dao.consumer.ProductDAOImpl;
import dao.consumer.ProductOptionDAO;
import dao.consumer.ProductOptionDAOImpl;
import dto.Product;
import dto.consumer.CommonProduct;
import dto.consumer.ModalProduct;
import dto.consumer.ProductCategory;
import dto.consumer.ProductPlan;
import dto.consumer.ProductRank;
import dto.consumer.ProductSale;
import dto.consumer.ProductSaleExclusive;
import dto.consumer.ProductSearch;

public class ProductServiceImpl implements ProductService {

	private ProductDAO productDAO;

	public ProductServiceImpl() {
		this.productDAO = new ProductDAOImpl();
	}

	// 상품 상세 페이지
	@Override
	public Product getProductDetail(Long productId) throws Exception {
		// 기본적인 비즈니스 로직
		if (productId == null || productId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
		}

		Product product = productDAO.selectProductByProductId(productId);

		if (product == null) {
			throw new Exception("상품을 찾을 수 없습니다.");
		}

		return product;

	}

	// [소비자] 기획 상품 목록 조회
	@Override
	public Map<String, Object> productPlanListByPage(Map<String, Object> params) throws Exception {
		// 기획 상품 목록 조회
		List<ProductPlan> productPlanList = productDAO.selectPlannedProducts(params);

		// 총 상품 개수 조회
		int totalCount = productDAO.selectPlannedProductsCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 16);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("productPlanList", productPlanList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// [소비자] 랭킹 상품 목록 조회
	@Override
	public Map<String, Object> productRankListByPage(Map<String, Object> params) throws Exception {
		// 랭킹 상품 목록 조회
		List<ProductRank> productRankList = productDAO.selectRankingProducts(params);

		// 총 상품 개수 조회
		int totalCount = productDAO.selectRankingProductsCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 16);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("productRankList", productRankList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// [소비자] 세일 상품 목록 조회
	@Override
	public Map<String, Object> productSaleListByPage(Map<String, Object> params) throws Exception {
		// 세일 상품 목록 조회
		List<ProductSale> productSaleList = productDAO.selectSaleProducts(params);

		Long memberId = (Long) params.get("memberId");
		// 세일&단독 상품 목록 조회
		List<ProductSaleExclusive> productSaleExclusiveList = productDAO.selectSaleExclusiveProducts(memberId);

		// 총 상품 개수 조회
		int totalCount = productDAO.selectSaleProductsCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 16);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("productSaleList", productSaleList);
		result.put("productSaleExclusiveList", productSaleExclusiveList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// [소비자] 카테고리 상품 목록 조회
	@Override
	public Map<String, Object> productCategoryListByPage(Map<String, Object> params) throws Exception {
		List<ProductCategory> productCategoryList = productDAO.selectCategoryProducts(params);

		// 총 상품 개수 조회
		int totalCount = productDAO.selectCategoryProductsCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 16);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("productCategoryList", productCategoryList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// [brandDetail용] 브랜드 상품 조회
	@Override
	public List<Map<String, Object>> getProductsByBrandId(Long brandId) throws Exception {
		return productDAO.selectProductsByBrandId(brandId);
	}

	// [소비자] 검색상품 목록 조회
	@Override
	public Map<String, Object> productSearchListByPage(Map<String, Object> params) throws Exception {
		List<ProductSearch> productSearchList = productDAO.selectSearchProducts(params);

		// 총 상품 개수 조회
		int totalCount = productDAO.selectSearchProductsCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 16);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("productSearchList", productSearchList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// [소비자] 메인 상품 조회
	@Override
	public Map<String, Object> productMainList(Map<String, Object> params) throws Exception {
		List<CommonProduct> productMyFitList = productDAO.selectMyFitProductsForMain(params);
		List<CommonProduct> productPopularList = productDAO.selectPopularProductsForMain(params);
		List<CommonProduct> productSaleList = productDAO.selectSaleProductsForMain(params);
		List<CommonProduct> productExclusiveList = productDAO.selectExclusiveProductsForMain(params);

		Map<String, Object> result = new HashMap<>();
		result.put("productMyFitList", productMyFitList);
		result.put("productPopularList", productPopularList);
		result.put("productSaleList", productSaleList);
		result.put("productExclusiveList", productExclusiveList);

		return result;

	}

	@Override
	public List<ModalProduct> getModalProducts(List<Long> productIds, Long memberId) throws Exception {
		return productDAO.getProductsByIds(productIds, memberId);
	}

	// 교환 신청용: 상품의 전체 옵션 목록 조회 (mapper 및 DAO는 productOption)
	@Override
	public List<Map<String, Object>> getProductOptions(Long productId) throws Exception {
		
		ProductOptionDAO productOptionDAO = new ProductOptionDAOImpl();
		
		return productOptionDAO.getProductOptions(productId);
	}

}
