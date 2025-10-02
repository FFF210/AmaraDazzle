package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ProductDetail {
	// 기본 정보
	private Long productId; // 상품 고유 ID (PK)
	private Long brandId; // 브랜드 관리자 ID
	private String name; // 상품명

	private Integer isExclusive; // 단독 판매 여부 (0=비단독, 1=단독)
	private Integer isVisible; // 상품 공개 여부 (0=비공개/판매중지, 1=공개/판매중)
	private Integer isPlanned; // 기획 상품 여부 (0=일반, 1=기획)

	private Long category1Id; // 대분류 카테고리 ID
	private Long category2Id; // 중분류 카테고리 ID
	private Long category3Id; // 소분류 카테고리 ID

	// 파일 FK만 저장
	private Long thumbnailFileId;
	private Long image1FileId;
	private Long image2FileId;
	private Long image3FileId;
	private Long image4FileId;
	private Long image5FileId;

	private String ingredients; // 전성분
	private BigDecimal price; // 판매가 (기본가)
	private Integer orderLimit; // 1회 주문 수량 제한
	private Integer hasOption; // 옵션 존재 여부 (0=없음, 1=있음)
	private Integer stockQty; // 단일 상품 재고 (옵션 없을 때만 사용)
	private String shippingMethod; // 배송 방법 (DEFAULT=기본배송, FREE=무료배송)
	private String discountType; // 할인 방식 (RATE=정률, AMOUNT=정액)
	private BigDecimal salePrice; // 할인 값 (퍼센트 or 금액)
	private Timestamp createdAt; // 등록일
	private Timestamp updatedAt; // 수정일

	// 필터 정보 (code:name 형태의 CSV 문자열)
	// 예: "ATOPIC:아토피,CALM:진정"
	private String skinIssues; // 피부 고민 필터 (SKIN_ISSUE)
	private String skinTypes; // 피부 타입 필터 (SKIN_TYPE)
	private String personalColors; // 퍼스널컬러 필터 (PERSONAL_COLOR)

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Long getBrandId() {
		return brandId;
	}

	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getIsExclusive() {
		return isExclusive;
	}

	public void setIsExclusive(Integer isExclusive) {
		this.isExclusive = isExclusive;
	}

	public Integer getIsVisible() {
		return isVisible;
	}

	public void setIsVisible(Integer isVisible) {
		this.isVisible = isVisible;
	}

	public Integer getIsPlanned() {
		return isPlanned;
	}

	public void setIsPlanned(Integer isPlanned) {
		this.isPlanned = isPlanned;
	}

	public Long getCategory1Id() {
		return category1Id;
	}

	public void setCategory1Id(Long category1Id) {
		this.category1Id = category1Id;
	}

	public Long getCategory2Id() {
		return category2Id;
	}

	public void setCategory2Id(Long category2Id) {
		this.category2Id = category2Id;
	}

	public Long getCategory3Id() {
		return category3Id;
	}

	public void setCategory3Id(Long category3Id) {
		this.category3Id = category3Id;
	}

	public Long getThumbnailFileId() {
		return thumbnailFileId;
	}

	public void setThumbnailFileId(Long thumbnailFileId) {
		this.thumbnailFileId = thumbnailFileId;
	}

	public Long getImage1FileId() {
		return image1FileId;
	}

	public void setImage1FileId(Long image1FileId) {
		this.image1FileId = image1FileId;
	}

	public Long getImage2FileId() {
		return image2FileId;
	}

	public void setImage2FileId(Long image2FileId) {
		this.image2FileId = image2FileId;
	}

	public Long getImage3FileId() {
		return image3FileId;
	}

	public void setImage3FileId(Long image3FileId) {
		this.image3FileId = image3FileId;
	}

	public Long getImage4FileId() {
		return image4FileId;
	}

	public void setImage4FileId(Long image4FileId) {
		this.image4FileId = image4FileId;
	}

	public Long getImage5FileId() {
		return image5FileId;
	}

	public void setImage5FileId(Long image5FileId) {
		this.image5FileId = image5FileId;
	}

	public String getIngredients() {
		return ingredients;
	}

	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Integer getOrderLimit() {
		return orderLimit;
	}

	public void setOrderLimit(Integer orderLimit) {
		this.orderLimit = orderLimit;
	}

	public Integer getHasOption() {
		return hasOption;
	}

	public void setHasOption(Integer hasOption) {
		this.hasOption = hasOption;
	}

	public Integer getStockQty() {
		return stockQty;
	}

	public void setStockQty(Integer stockQty) {
		this.stockQty = stockQty;
	}

	public String getShippingMethod() {
		return shippingMethod;
	}

	public void setShippingMethod(String shippingMethod) {
		this.shippingMethod = shippingMethod;
	}

	public String getDiscountType() {
		return discountType;
	}

	public void setDiscountType(String discountType) {
		this.discountType = discountType;
	}

	public BigDecimal getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(BigDecimal salePrice) {
		this.salePrice = salePrice;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getSkinIssues() {
		return skinIssues;
	}

	public void setSkinIssues(String skinIssues) {
		this.skinIssues = skinIssues;
	}

	public String getSkinTypes() {
		return skinTypes;
	}

	public void setSkinTypes(String skinTypes) {
		this.skinTypes = skinTypes;
	}

	public String getPersonalColors() {
		return personalColors;
	}

	public void setPersonalColors(String personalColors) {
		this.personalColors = personalColors;
	}

}
