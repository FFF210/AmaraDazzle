package util;

import java.time.LocalDate;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import service.admin.SettlementService;
import service.admin.SettlementServiceImpl;

//정산 자동 실행 
public class SettlementBatch {
	private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
	 
	public static void start() {
		Runnable task = () -> {
		    System.out.println("[🔥정산 배치🔥] 매시간별 자동 실행 시작");
		    LocalDate today = LocalDate.now();
		    LocalDate firstDayPrevMonth = today.minusMonths(1).withDayOfMonth(1);
			LocalDate lastDayPrevMonth = today.minusMonths(1).withDayOfMonth(today.minusMonths(1).lengthOfMonth());
			
		    SettlementService settle_svc = new SettlementServiceImpl();
		    int result = settle_svc.autoSettle(firstDayPrevMonth, lastDayPrevMonth);
		};
		
//	    scheduler.scheduleAtFixedRate(task, 0, 24, TimeUnit.HOURS);	// 매 24시간마다 실행
		scheduler.scheduleAtFixedRate(task, 5, 5, TimeUnit.MINUTES); //프로그램 실행 후 5초후에 시작 -> 10분마다 반복
		}
	
	public static void stop() {
	    scheduler.shutdown();
	}
}
