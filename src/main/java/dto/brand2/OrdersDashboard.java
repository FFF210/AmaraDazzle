package dto.brand2;

import java.math.BigDecimal;

public class OrdersDashboard {
	// 오늘
    private BigDecimal salesToday;        // 오늘 매출 합계
    private Integer productCountToday;    // 오늘 판매 수량

    // 어제
    private BigDecimal salesYesterday;
    private Integer productCountYesterday;

    // 이번 주
    private BigDecimal salesWeek;
    private Integer productCountWeek;

    // 최근 30일 (그래프용)
    private String orderDate;             // yyyy-MM-dd
    private BigDecimal dailySales;        // 하루 매출
    
    private String month;
    private Long thisYear;
    private Long lastYear;

    // ===== Getter/Setter =====
    public BigDecimal getSalesToday() {
        return salesToday;
    }
    public void setSalesToday(BigDecimal salesToday) {
        this.salesToday = salesToday;
    }
    public Integer getProductCountToday() {
        return productCountToday;
    }
    public void setProductCountToday(Integer productCountToday) {
        this.productCountToday = productCountToday;
    }

    public BigDecimal getSalesYesterday() {
        return salesYesterday;
    }
    public void setSalesYesterday(BigDecimal salesYesterday) {
        this.salesYesterday = salesYesterday;
    }
    public Integer getProductCountYesterday() {
        return productCountYesterday;
    }
    public void setProductCountYesterday(Integer productCountYesterday) {
        this.productCountYesterday = productCountYesterday;
    }

    public BigDecimal getSalesWeek() {
        return salesWeek;
    }
    public void setSalesWeek(BigDecimal salesWeek) {
        this.salesWeek = salesWeek;
    }
    public Integer getProductCountWeek() {
        return productCountWeek;
    }
    public void setProductCountWeek(Integer productCountWeek) {
        this.productCountWeek = productCountWeek;
    }

    public String getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getDailySales() {
        return dailySales;
    }
    public void setDailySales(BigDecimal dailySales) {
        this.dailySales = dailySales;
    }
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public Long getThisYear() {
		return thisYear;
	}
	public void setThisYear(Long thisYear) {
		this.thisYear = thisYear;
	}
	public Long getLastYear() {
		return lastYear;
	}
	public void setLastYear(Long lastYear) {
		this.lastYear = lastYear;
	}
	@Override
	public String toString() {
		return "OrdersDashboard [salesToday=" + salesToday + ", productCountToday=" + productCountToday
				+ ", salesYesterday=" + salesYesterday + ", productCountYesterday=" + productCountYesterday
				+ ", salesWeek=" + salesWeek + ", productCountWeek=" + productCountWeek + ", orderDate=" + orderDate
				+ ", dailySales=" + dailySales + ", month=" + month + ", thisYear=" + thisYear + ", lastYear="
				+ lastYear + "]";
	}
}