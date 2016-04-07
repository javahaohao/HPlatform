package com.hplatform.core.common.util;

/** 
 * @Description:  
 * 
 * @Title: QuartzManager.java 
 * @Package com.joyce.quartz 
 * @Copyright: Copyright (c) 2014 
 * 
 * @author Comsys-LZP 
 * @date 2014-6-26 下午03:15:52 
 * @version V2.0 
 */  
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.impl.StdSchedulerFactory;

import com.hplatform.core.entity.ScheduleJob;
import com.hplatform.core.exception.CRUDException;
import com.hplatform.core.service.ScheduleJobService;
  
/** 
 * @Description: 定时任务管理类 
 *  
 * @ClassName: QuartzManager 
 * @Copyright: Copyright (c) 2014 
 *  
 * @author Comsys-LZP 
 * @date 2014-6-26 下午03:15:52 
 * @version V2.0 
 */  
public class QuartzManager {  
    private SchedulerFactory gSchedulerFactory = new StdSchedulerFactory();  
    private final transient Log log = LogFactory.getLog(QuartzManager.class);
    public void initJobs(){
    	List<ScheduleJob> jobList = new ArrayList<ScheduleJob>();
		ScheduleJobService scheduleJobService = SpringUtils.getBean(ScheduleJobService.class);
		try {
			jobList.addAll(scheduleJobService.findAll(new ScheduleJob(ConstantsUtil.get().DICT_YES_PARENT_ID)));
			for(ScheduleJob scheduleJob : jobList){
				addJob(scheduleJob);
			}
			startJobs();
		} catch (CRUDException e) {
			log.error("加载定时任务调度列表失败！", e);
		}
    }
    /** 
     * @Description: 添加一个定时任务 
     *  
     * @param jobName 
     *            任务名 
     * @param jobGroupName 
     *            任务组名 
     * @param triggerName 
     *            触发器名 
     * @param triggerGroupName 
     *            触发器组名 
     * @param jobClass 
     *            任务 
     * @param time 
     *            时间设置，参考quartz说明文档 
     *  
     * @Title: QuartzManager.java 
     * @Copyright: Copyright (c) 2014 
     *  
     * @author Comsys-LZP 
     * @date 2014-6-26 下午03:48:15 
     * @version V2.0 
     */  
    public void addJob(ScheduleJob scheduleJob) {  
        try {  
            Scheduler sched = gSchedulerFactory.getScheduler();  
            JobDetail jobDetail = new JobDetail(scheduleJob.getJobName(), scheduleJob.getJobGroup(), Class.forName(scheduleJob.getJobImpl()));// 任务名，任务组，任务执行类  
            jobDetail.getJobDataMap().put("scheduleJob", scheduleJob);
            // 触发器  
            CronTrigger trigger = new CronTrigger(scheduleJob.getJobName(), scheduleJob.getJobGroup());// 触发器名,触发器组  
            trigger.setCronExpression(scheduleJob.getCronExpression());// 触发器时间设定  
            sched.scheduleJob(jobDetail, trigger);  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
    }  
  
    /** 
     * @Description: 修改一个任务的触发时间 
     *  
     * @param triggerName 
     * @param triggerGroupName 
     * @param time 
     *  
     * @Title: QuartzManager.java 
     * @Copyright: Copyright (c) 2014 
     *  
     * @author Comsys-LZP 
     * @date 2014-6-26 下午03:49:37 
     * @version V2.0 
     */  
    public void modifyJobTime(ScheduleJob scheduleJob) {  
        try {  
            Scheduler sched = gSchedulerFactory.getScheduler();  
            CronTrigger trigger = (CronTrigger) sched.getTrigger(scheduleJob.getJobName(), scheduleJob.getJobGroup());  
            if (trigger == null) {  
                return;  
            }
            trigger.getJobDataMap().put("scheduleJob", scheduleJob);
            String oldTime = trigger.getCronExpression();  
            if (!oldTime.equalsIgnoreCase(scheduleJob.getCronExpression())) {  
                CronTrigger ct = (CronTrigger) trigger;  
                // 修改时间  
                ct.setCronExpression(scheduleJob.getCronExpression());  
                // 重启触发器  
                sched.resumeTrigger(scheduleJob.getJobName(), scheduleJob.getJobGroup());  
            }  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
    }  
  
    /** 
     * @Description: 移除一个任务 
     *  
     * @param jobName 
     * @param jobGroupName 
     * @param triggerName 
     * @param triggerGroupName 
     *  
     * @Title: QuartzManager.java 
     * @Copyright: Copyright (c) 2014 
     *  
     * @author Comsys-LZP 
     * @date 2014-6-26 下午03:50:01 
     * @version V2.0 
     */  
    public void removeJob(ScheduleJob scheduleJob) {  
        try {  
            Scheduler sched = gSchedulerFactory.getScheduler();  
            sched.pauseTrigger(scheduleJob.getJobName(), scheduleJob.getJobGroup());// 停止触发器  
            sched.unscheduleJob(scheduleJob.getJobName(), scheduleJob.getJobGroup());// 移除触发器  
            sched.deleteJob(scheduleJob.getJobName(), scheduleJob.getJobGroup());// 删除任务  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
    }  
  
    /** 
     * @Description:启动所有定时任务 
     *  
     *  
     * @Title: QuartzManager.java 
     * @Copyright: Copyright (c) 2014 
     *  
     * @author Comsys-LZP 
     * @date 2014-6-26 下午03:50:18 
     * @version V2.0 
     */  
    public void startJobs() {  
        try {  
            Scheduler sched = gSchedulerFactory.getScheduler();  
            sched.start();  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
    }  
  
    /** 
     * @Description:关闭所有定时任务 
     *  
     *  
     * @Title: QuartzManager.java 
     * @Copyright: Copyright (c) 2014 
     *  
     * @author Comsys-LZP 
     * @date 2014-6-26 下午03:50:26 
     * @version V2.0 
     */  
    public void shutdownJobs() {  
        try {  
            Scheduler sched = gSchedulerFactory.getScheduler();  
            if (!sched.isShutdown()) {  
                sched.shutdown();  
            }  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
    }  
}