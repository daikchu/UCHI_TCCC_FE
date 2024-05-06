package com.vn.osp.task;


import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.SystemProperties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.TimerTask;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

public class AutoRunAPITask extends TimerTask implements ServletContextListener {
    private static final Logger logger = Logger.getLogger(AutoRunAPITask.class.getName());
    private ScheduledExecutorService scheduler;

    public void contextInitialized(ServletContextEvent event) {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        Runnable command = new AutoRunAPI(event.getServletContext());
        // Delay 1 Minute to first execution

        long initialDelay = 1;
        TimeUnit unit = TimeUnit.MINUTES;
        // period the period between successive executions
        long period = Long.parseLong(SystemProperties.getProperty(Constants.AUTO_RESET_TIME));// 1 Minute!

        if(Boolean.parseBoolean(SystemProperties.getProperty(Constants.AUTO_RESET_ENABLE)))
        scheduler.scheduleAtFixedRate(command, initialDelay, period, unit);
    }

    public void contextDestroyed(ServletContextEvent event) {
        scheduler.shutdownNow();
    }

    @Override
    public void run() {
        logger.info("AutoRunAPITask-----------------------------------");
    }
}