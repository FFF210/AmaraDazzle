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

	private String thumbPath; // 썸네일 저장 경로
	private String thumbFile; // 썸네일 리네임 파일명

	private String image1Path; // 이미지1 저장 경로
	private String image1File; // 이미지1 리네임 파일명
	private String image2Path; // 이미지2 저장 경로
	private String image2File; // 이미지2 리네임 파일명
	private String image3Path; // 이미지3 저장 경로
	private String image3File; // 이미지3 리네임 파일명
	private String image4Path; // 이미지4 저장 경로
	private String image4File; // 이미지4 리네임 파일명
	private String image5Path; // 이미지5 저장 경로
	private String image5File; // 이미지5 리네임 파일명

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

	public String getThumbPath() {
		return thumbPath;
	}

	public void setThumbPath(String thumbPath) {
		this.thumbPath = thumbPath;
	}

	public String getThumbFile() {
		return thumbFile;
	}

	public void setThumbFile(String thumbFile) {
		this.thumbFile = thumbFile;
	}

	public String getImage1Path() {
		return image1Path;
	}

	public void setImage1Path(String image1Path) {
		this.image1Path = image1Path;
	}

	public String getImage1File() {
		return image1File;
	}

	public void setImage1File(String image1File) {
		this.image1File = image1File;
	}

	public String getImage2Path() {
		return image2Path;
	}

	public void setImage2Path(String image2Path) {
		this.image2Path = image2Path;
	}

	public String getImage2File() {
		return image2File;
	}

	public void setImage2File(String image2File) {
		this.image2File = image2File;
	}

	public String getImage3Path() {
		return image3Path;
	}

	public void setImage3Path(String image3Path) {
		this.image3Path = image3Path;
	}

	public String getImage3File() {
		return image3File;
	}

	public void setImage3File(String image3File) {
		this.image3File = image3File;
	}

	public String getImage4Path() {
		return image4Path;
	}

	public void setImage4Path(String image4Path) {
		this.image4Path = image4Path;
	}

	public String getImage4File() {
		return image4File;
	}

	public void setImage4File(String image4File) {
		this.image4File = image4File;
	}

	public String getImage5Path() {
		return image5Path;
	}

	public void setImage5Path(String image5Path) {
		this.image5Path = image5Path;
	}

	public String getImage5File() {
		return image5File;
	}

	public void setImage5File(String image5File) {
		this.image5File = image5File;
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

	@Override
	public String toString() {
		return "ProductDetail [productId=" + productId + ", brandId=" + brandId + ", name=" + name + ", isExclusive="
				+ isExclusive + ", isVisible=" + isVisible + ", isPlanned=" + isPlanned + ", category1Id=" + category1Id
				+ ", category2Id=" + category2Id + ", category3Id=" + category3Id + ", thumbPath=" + thumbPath
				+ ", thumbFile=" + thumbFile + ", image1Path=" + image1Path + ", image1File=" + image1File
				+ ", image2Path=" + image2Path + ", image2File=" + image2File + ", image3Path=" + image3Path
				+ ", image3File=" + image3File + ", image4Path=" + image4Path + ", image4File=" + image4File
				+ ", image5Path=" + image5Path + ", image5File=" + image5File + ", ingredients=" + ingredients
				+ ", price=" + price + ", orderLimit=" + orderLimit + ", hasOption=" + hasOption + ", stockQty="
				+ stockQty + ", shippingMethod=" + shippingMethod + ", discountType=" + discountType + ", salePrice="
				+ salePrice + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", skinIssues=" + skinIssues
				+ ", skinTypes=" + skinTypes + ", personalColors=" + personalColors + "]";
	}
}
