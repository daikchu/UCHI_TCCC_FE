package com.vn.osp.task;

import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.*;
import com.vn.osp.modelview.MailSendList;
import com.vn.osp.service.QueryFactory;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Logger;

public class CheckBackupDBThread implements Runnable{
    private static final Logger logger = Logger.getLogger(CheckBackupDBThread.class.getName());
    private ServletContext context;

    public CheckBackupDBThread() {

    }


    public CheckBackupDBThread(ServletContext context) {
        this.context = context;
    }

    public List<String> convertListBooleanToListString() {
        List<String> listDateBackup = new ArrayList<String>();
        List<Boolean> listDate = null;
        if (FileUtil.checkFileExits("backup-config.xml", SystemProperties.getProperty("system_backup_folder"))) {
            if (org.apache.commons.lang3.StringUtils.isBlank(XmlHandler.getValueNode("DatesBackup")) == false) {
                listDate = EditString.parseListDateBackup1(XmlHandler.getValueNode("DatesBackup"));
                for (int i = 0; i < listDate.size(); i++) {
                    if (listDate.get(i) == true) {
                        if (i == 6) {
                            listDateBackup.add("Sunday");
                        } else {
                            listDateBackup.add(TimeUtil.getDayOfWeek(i + 2));
                        }
                    }
                }
            }
        } else {
            listDate = EditString.parseListDateBackup1(SystemProperties.getProperty(Constants.CONFIG_DATE_BACKUP));
        }
        return listDateBackup;
    }


    public void run() {
        Calendar cal = Calendar.getInstance();
        List<String> listDateBackup = convertListBooleanToListString();
        String timeBackup = "";
        String status = "";
        String dayOfWeek = TimeUtil.getDayOfWeek(cal.get(Calendar.DAY_OF_WEEK));
        if (FileUtil.checkFileExits("backup-config.xml", SystemProperties.getProperty("system_backup_folder"))) {
            timeBackup = XmlHandler.getValueNode("TimeBackup");
            status = XmlHandler.getValueNode("StatusBackup");
        } else {
            timeBackup = SystemProperties.getProperty(Constants.CONFIG_TIME_BACKUP);
            status = SystemProperties.getProperty(Constants.CHECK_BACKUP_DATABASE);
        }

        if (listDateBackup.size() > 0) {
            for (int i = 0; i < listDateBackup.size(); i++) {
                if (dayOfWeek.equals(listDateBackup.get(i))) {
                    try {
                        //set time check backup after time backup 1 hour
                        int hourBackup = Integer.parseInt(timeBackup.split(":")[0]);
                        int hourCheckBackup =  hourBackup == 23 ? 0 : hourBackup + 1;

                        if ((cal.get(Calendar.HOUR_OF_DAY) > hourCheckBackup) ||
                                (cal.get(Calendar.HOUR_OF_DAY) == hourCheckBackup &&
                                cal.get(Calendar.MINUTE) > Integer.parseInt(timeBackup.split(":")[1]))) {
                            if (status.equals("true") && Util.CHECKED_BACKUP==0) {
                                logger.info("Check backup-----------------------------------");
                                this.checkBackupDB();

                            } else {
                                logger.info("Khong check------------------");

                            }
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                }
            }
        }
    }

    private void checkBackupDB(){
        try {
            //find file backup
            File folder = new File(SystemProperties.getProperty(Constants.CONFIG_BACKUP_DATABASE_FOLDER));
            File[] files = folder.listFiles();
            long sizeFileBeforeDate = 0;
            int flg_exist_file_backup = 0;
            int flg_backupFalse = 0;//check is true
            if(Util.FILE_NAME_BACKUP == null) return;
            for(int i = files.length-1; i>=0; i--){
                String fileName = files[i].getName();
                if(fileName.substring(fileName.lastIndexOf(".")).equals(".sql") && fileName.equals(Util.FILE_NAME_BACKUP)){
                    flg_exist_file_backup = 1;
                   // if(Util.FLG_CHECK==1){

                        long thisFileSize = files[i].length();
                        if(Util.FILE_SIZE > 0 && thisFileSize == Util.FILE_SIZE){
                            //get size of before backup file
                            for(int j = i-1; j>=0; j--){
                                String thisFileName = files[j].getName();
                               // String tienToFileName = thisFileName.split("-")[0];//is "backup scheduller" or "backup now"
                                if(thisFileName.contains("backup") && thisFileName.substring(thisFileName.lastIndexOf(".")).equals(".sql")){
                                    //is this file
                                    sizeFileBeforeDate = files[j].length();
                                    break;
                                }
                            }
                            //check this size and before file size
                            if(thisFileSize < sizeFileBeforeDate){
                                flg_backupFalse = 1;//gan co de dua ra canh bao toi nguoi dung ve viec backup
                            }
                            Util.CHECKED_BACKUP = 1;//is checked
                        }
                        else{
                            Util.FILE_SIZE = thisFileSize;
                        }
                    break;
                    }

              //  }
            }
            /*check dong bo file backup len google*/
            //check exist file from google
            //0 is true, 1 is not exist, 2 is existed but false

            if(flg_exist_file_backup==0 || flg_backupFalse == 1){
                String contentCheckFalse = "";
                if(flg_exist_file_backup==0) {
                    contentCheckFalse += "<div>  + Tệp sao lưu không tồn tại.<div> ";
                }
                if(flg_backupFalse==1){
                    contentCheckFalse += "<div>  + Tệp sao lưu có dấu hiệu bất thường.<div> "+"<div>• Tên file: " + Util.FILE_NAME_BACKUP + "<div>";
                }

                //dua ra canh bao k ton tai file backup
                String[] emails = XmlHandler.getValueNode("Emails").replaceAll("\\s+", "").split(",");
                String emailTitle = XmlHandler.getValueNode("EmailTitle");
                String content = "<h3 style='color:black'>Cảnh báo việc sao lưu dữ liệu, cần kiểm tra:</h3>" +
                        "<div>• Vấn đề:<div>"+ contentCheckFalse +
                        "<div>• Thư mục lưu trữ: " + SystemProperties.getProperty("system_backup_database_folder") + "<div>";
                /*SendMailUtil.sendGmail(emails, "[Uchi] Sao Lưu Dữ Liệu Thành Công", content);*/
                MailSendList mailSendList = new MailSendList(emails,content,emailTitle);
                Boolean result = QueryFactory.sendMailOSP(mailSendList.generateAddJson());
                if(result == true){
                    System.out.println("Gửi Mail thành công");
                }else {
                    System.out.println(" Gửi Mail thất bại");
                }
            }


            /*InetAddress ip = InetAddress.getLocalHost();
            String IP = ip.getHostAddress();
            String ipServer = SystemProperties.getProperty("IP_SERVER");*/

        } catch (Exception e) {
            logger.info(e.getMessage());
        }
    }

}
