package util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import dto.Product;

/**
 * 가격 계산 유틸리티 클래스
 * 세일가, 할인율 등을 계산합니다.
 */
public class PriceCalculator {
    
    /**
     * 상품의 세일 정보를 계산합니다.
     * 
     * @param product 상품 객체
     * @return Map - isSale(boolean), finalPrice(BigDecimal), saleRate(BigDecimal)
     */
    public static Map<String, Object> calculateSaleInfo(Product product) {
        Map<String, Object> result = new HashMap<>();
        
        boolean isSale = false;
        BigDecimal finalPrice = product.getPrice(); // 기본값은 원가
        BigDecimal saleRate = BigDecimal.ZERO;
        
        // 세일 여부 체크
        if (product.getDiscountType() != null && product.getDiscountValue() != null) {
            Date now = new Date();
            Date startDate = product.getStartDate();
            Date endDate = product.getEndDate();
            
            // 시작일이 없거나 현재가 시작일 이후 && 종료일이 없거나 현재가 종료일 이전
            boolean isInPeriod = (startDate == null || !now.before(startDate)) 
                              && (endDate == null || !now.after(endDate));
            
            if (isInPeriod) {
                isSale = true;
                
                // 할인가 계산
                if ("RATE".equals(product.getDiscountType())) {
                    // 정율 할인 (예: 10% 할인)
                    saleRate = product.getDiscountValue();
                    finalPrice = product.getPrice()
                        .multiply(BigDecimal.ONE.subtract(product.getDiscountValue().divide(new BigDecimal("100"))))
                        .setScale(0, RoundingMode.HALF_UP);
                } else if ("AMOUNT".equals(product.getDiscountType())) {
                    // 정액 할인 (예: 5,000원 할인)
                    BigDecimal discountAmount = product.getDiscountValue();
                    finalPrice = product.getPrice().subtract(discountAmount);
                    // 할인율 계산 (정액 할인도 %로 표시하기 위해)
                    saleRate = discountAmount.divide(product.getPrice(), 4, RoundingMode.HALF_UP)
                        .multiply(new BigDecimal("100"))
                        .setScale(0, RoundingMode.HALF_UP);
                }
            }
        }
        
        result.put("isSale", isSale);
        result.put("finalPrice", finalPrice);
        result.put("saleRate", saleRate);
        
        return result;
    }
    
    /**
     * Map 형태의 상품 데이터로 세일 정보 계산
     */
    public static Map<String, Object> calculateSaleInfoFromMap(Map<String, Object> productData) {
        Map<String, Object> result = new HashMap<>();
        
        boolean isSale = false;
        BigDecimal price = (BigDecimal) productData.get("price");
        BigDecimal finalPrice = price; // 기본값은 원가
        BigDecimal saleRate = BigDecimal.ZERO;
        
        String discountType = (String) productData.get("discountType");
        BigDecimal discountValue = (BigDecimal) productData.get("discountValue");
        Date startDate = (Date) productData.get("startDate");
        Date endDate = (Date) productData.get("endDate");
        
        if (discountType != null && discountValue != null) {
            Date now = new Date();
            boolean isInPeriod = (startDate == null || !now.before(startDate)) 
                              && (endDate == null || !now.after(endDate));
            
            if (isInPeriod) {
                isSale = true;
                
                if ("RATE".equals(discountType)) {
                    saleRate = discountValue;
                    finalPrice = price
                        .multiply(BigDecimal.ONE.subtract(discountValue.divide(new BigDecimal("100"))))
                        .setScale(0, RoundingMode.HALF_UP);
                } else if ("AMOUNT".equals(discountType)) {
                    finalPrice = price.subtract(discountValue);
                    saleRate = discountValue.divide(price, 4, RoundingMode.HALF_UP)
                        .multiply(new BigDecimal("100"))
                        .setScale(0, RoundingMode.HALF_UP);
                }
            }
        }
        
        result.put("isSale", isSale);
        result.put("finalPrice", finalPrice);
        result.put("saleRate", saleRate);
        
        return result;
    }
    

    //최종가 계산
    public static BigDecimal calculateFinalPrice(Product product) {
        Map<String, Object> saleInfo = calculateSaleInfo(product);
        return (BigDecimal) saleInfo.get("finalPrice");
    }
    

    //세일 여부 확인
    public static boolean isSale(Product product) {
        Map<String, Object> saleInfo = calculateSaleInfo(product);
        return (boolean) saleInfo.get("isSale");
    }
}