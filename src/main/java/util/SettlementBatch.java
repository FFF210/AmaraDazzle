package util;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import dao.admin.SettlementDAO;
import dao.admin.SettlementDAOImpl;

//정산 자동 실행 
public class SettlementBatch {
	private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
	 
	public static void start() {
		Runnable task = () -> {
		    System.out.println("[정산 배치] 자동 실행 시작");
		    
		    SettlementDAO settle_dao = new SettlementDAOImpl();
		    settle_dao.autoSettle();
		};
		
//	    scheduler.scheduleAtFixedRate(task, 0, 24, TimeUnit.HOURS);	// 매 24시간마다 실행
		scheduler.scheduleAtFixedRate(task, 5, 60, TimeUnit.MINUTES); //프로그램 실행 후 5초후에 시작 -> 60분마다 반복
		}
	
	public static void stop() {
	    scheduler.shutdown();
	}
}
