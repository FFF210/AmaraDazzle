package util;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import dto.admin.SearchConditionDTO;

public class SearchUtil {

	// 검색조건 DTO에 담기
	public SearchConditionDTO buildSearchDTO(Map<String, String> paramMap) {
		SearchConditionDTO sc_DTO = new SearchConditionDTO();

		String s1 = paramMap.get("startDate");
		String e1 = paramMap.get("endDate");

		if ((s1 != null && !s1.isEmpty()) && (e1 != null && !e1.isEmpty())) {
			Map<String, Timestamp> result = dateConversion(s1, e1);
			sc_DTO.setStartDateTime(result.get("startLdt"));
			sc_DTO.setEndDateTime(result.get("endExclusiveLdt"));
		}
		
		String s2 = paramMap.get("startDate2");
	    String e2 = paramMap.get("endDate2");
	    if (s2 != null && !s2.isEmpty() && e2 != null && !e2.isEmpty()) {
	    	Map<String, Timestamp> result = dateConversion(s2, e2);
			sc_DTO.setStartDateTime2(result.get("startLdt"));
			sc_DTO.setEndDateTime2(result.get("endExclusiveLdt"));
	    }
		
		sc_DTO.setQ_select(paramMap.get("q_select"));
		sc_DTO.setMiddleFilter(paramMap.get("middleFilter"));
		sc_DTO.setTotalSearch(paramMap.get("totalSearch"));
		sc_DTO.setKeyword(paramMap.get("keyword"));

		return sc_DTO;
	}

	// 날짜 변환
	private Map<String, Timestamp> dateConversion(String s, String e) {
		Map<String, Timestamp> map = new HashMap<>();
		if ((s != null && !s.isEmpty()) && (e != null && !e.isEmpty())) {
			LocalDate start = LocalDate.parse(s);
			LocalDate end = LocalDate.parse(e);

			LocalDateTime startLdt = start.atStartOfDay();
			LocalDateTime endExclusiveLdt = end.plusDays(1).atStartOfDay();

			map.put("startLdt", Timestamp.valueOf(startLdt));
			map.put("endExclusiveLdt", Timestamp.valueOf(endExclusiveLdt));
			
		} else {
			map.put("startLdt", null);
			map.put("endExclusiveLdt", null);
		}
		return map;
	}

}
