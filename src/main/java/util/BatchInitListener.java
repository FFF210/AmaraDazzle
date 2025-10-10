package util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class BatchInitListener implements ServletContextListener {
	
	@Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("[BatchInitListener] 서버 시작됨 - 배치 스케줄러 시작");
        SettlementBatch.start();  // 자동정산 시작
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("[BatchInitListener] 서버 종료됨 - 배치 스케줄러 중지");
        SettlementBatch.stop();
    }

}
