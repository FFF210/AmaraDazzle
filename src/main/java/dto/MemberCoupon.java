package dto;

import java.sql.Timestamp;

public class MemberCoupon {
    private Long memberCouponId; // 쿠폰 내역 ID (PK, AUTO_INCREMENT)
    private Long couponId;       // 쿠폰 ID (FK → coupon.coupon_id)
    private Long memberId;     // 고객 ID (FK → member.member_id)
    private String status;       // 쿠폰 상태 (USED, AVAILABLE, EXPIRED)
    private Timestamp usedDate;  // 사용일자
    private String orderId;      // 주문번호 (FK → orders.order_id)
    private Timestamp createdAt; // 발급받은 일자
    
    //조인용컬럼
    private String cname;
    private String startDate;
    private String endDate;
    private String amount;
    private String pCode;
    private String categoryId;
    private String amountCondition;
    private String reason;
    private String provision;
    private String writerType;
    private String writerId;
    private String couponCreatedAt;
    
    private String fullCategoryPath; //category 풀표기용
    private String codeName; //code_detail.name 
    private String WriterName; //admin_info.aname or brand.brand_name
    private String mName; //회원명
    private String mEmail; //회원아이디
    
    public MemberCoupon() {}

    public Long getMemberCouponId() {
        return memberCouponId;
    }
    public void setMemberCouponId(Long memberCouponId) {
        this.memberCouponId = memberCouponId;
    }

    public Long getCouponId() {
        return couponId;
    }
    public void setCouponId(Long couponId) {
        this.couponId = couponId;
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getUsedDate() {
        return usedDate;
    }
    public void setUsedDate(Timestamp usedDate) {
        this.usedDate = usedDate;
    }

    public String getOrderId() {
        return orderId;
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    
    public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getAmountCondition() {
		return amountCondition;
	}

	public void setAmountCondition(String amountCondition) {
		this.amountCondition = amountCondition;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getProvision() {
		return provision;
	}

	public void setProvision(String provision) {
		this.provision = provision;
	}

	public String getWriterType() {
		return writerType;
	}

	public void setWriterType(String writerType) {
		this.writerType = writerType;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}

	public String getCouponCreatedAt() {
		return couponCreatedAt;
	}

	public void setCouponCreatedAt(String couponCreatedAt) {
		this.couponCreatedAt = couponCreatedAt;
	}

	public String getFullCategoryPath() {
		return fullCategoryPath;
	}

	public void setFullCategoryPath(String fullCategoryPath) {
		this.fullCategoryPath = fullCategoryPath;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getWriterName() {
		return WriterName;
	}

	public void setWriterName(String writerName) {
		WriterName = writerName;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	@Override
    public String toString() {
        return "MemberCoupon [memberCouponId=" + memberCouponId + ", couponId=" + couponId +
                ", memberId=" + memberId + ", status=" + status +
                ", usedDate=" + usedDate + ", orderId=" + orderId +
                ", createdAt=" + createdAt + "]";
    }
}
