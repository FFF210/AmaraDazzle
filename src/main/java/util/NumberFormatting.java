package util;

public class NumberFormatting {
	
	//연락처 가운데 마스킹처리 메소드
	public String formatPhoneNumber(String phone) {
        phone = phone.replaceAll("[^0-9]", "");

        // 010으로 시작하고, 총 10자리 또는 11자리인 경우만 처리
        if (phone.matches("^01[0-9]{8,9}$")) {
            // 그룹 나누기
            String formatted = phone.replaceFirst("^(\\d{3})(\\d{3,4})(\\d{4})$", "$1-$2-$3");
            // 가운데 부분 마스킹
            return formatted.replaceFirst("-(\\d{3,4})-", "-****-");
        } else {
            // 형식이 맞지 않으면 그대로 반환
            return phone;
        }
    }
	
	//금액 숫자 -> 금액단위로 포매팅
	public String formatMoney(Integer amount) {
		if (amount < 1_000) {
	        return amount + "원";
	        
	    } else if (amount < 10_000) { // 1,000~9,999
	        return (amount / 1_000) + "천원";
	        
	    } else if (amount < 100_000) { // 10,000~99,999
	        return (amount / 10_000) + "만원";
	        
	    } else if (amount < 1_000_000) { // 100,000~999,999
	        return (amount / 10_000) + "만원"; 
	        
	    } else if (amount < 10_000_000) { // 1,000,000~9,999,999
	        return (amount / 10_000) + "만원"; // 백만원까지는 그냥 500만원처럼 표시
	        
	    } else { // 10,000,000~99,999,999
	        return (amount / 10_000_000) + "천만원";
	    } 
	}

}

