package util;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import service.admin.SettlementService;
import service.admin.SettlementServiceImpl;

public class MonthlySettlementListener implements ServletContextListener {
	private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		Runnable task = () -> {
			LocalDate today = LocalDate.now();

			// 매달 1일에만 실행
			if (today.getDayOfMonth() == 1) {
				LocalDate firstDayPrevMonth = today.minusMonths(1).withDayOfMonth(1);
				LocalDate lastDayPrevMonth = today.minusMonths(1).withDayOfMonth(today.minusMonths(1).lengthOfMonth());

				System.out.println("[🔥월별 정산 배치🔥] " + firstDayPrevMonth + " ~ " + lastDayPrevMonth + " 정산 실행 시작");

				SettlementService settle_svc = new SettlementServiceImpl();
				int result = settle_svc.monthlyInsertSettle(firstDayPrevMonth, lastDayPrevMonth);
				if(result > 0) {
					System.out.println("[🔥월별 정산 배치 인서트 성공🔥]");
				}
			}
		};

		// 자정 기준으로 매일 한 번 실행
		long initialDelay = getInitialDelayUntilMidnight();
		scheduler.scheduleAtFixedRate(task, initialDelay, 24 * 60 * 60, TimeUnit.SECONDS);
	}

	private long getInitialDelayUntilMidnight() {
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime midnight = now.toLocalDate().plusDays(1).atStartOfDay();
		return Duration.between(now, midnight).getSeconds();
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		scheduler.shutdown();
	}
}
