package com.vn.osp.task;


import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.*;
import com.vn.osp.modelview.ConfigBackupDatabaseManager;
import com.vn.osp.modelview.MailSendList;
import com.vn.osp.service.QueryFactory;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.logging.Logger;

public class BackupThread implements Runnable {
    private static final Logger logger = Logger.getLogger(BackupDBTask.class.getName());
    private ServletContext context;

    public BackupThread() {

    }


    public BackupThread(ServletContext context) {
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

                        if (cal.get(Calendar.HOUR_OF_DAY) == Integer.parseInt(timeBackup.split(":")[0])) {
                            if (cal.get(Calendar.MINUTE) == Integer.parseInt(timeBackup.split(":")[1])) {
                                if (status.equals("true")) {
                                    logger.info("Tiến hành backup-----------------------------------");
                                    this.backupDB();
                                } else {
                                    logger.info("Ngày không tiến hành sao lưu dữ liệu-----------------------------------");
                                }
                            } else {
                                logger.info("Chờ-----------------------------------");
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

    private void backupDB() throws IOException {
        try {
            ConfigBackupDatabaseManager cfManager = new ConfigBackupDatabaseManager();
            String fileName = cfManager.createBackupFileBat();
            Runtime c = Runtime.getRuntime();
            String cmd = "cmd /c start " + SystemProperties.getProperty("system_backup_database_folder") + "backup.bat";

            if (SystemProperties.getProperty("system_backup_os").equals("0")) {
                c.exec(cmd, null,new File(SystemProperties.getProperty("system_backup_database_folder")));
            } else {
                c.exec(SystemProperties.getProperty("system_backup_database_folder") + "backup.sh",
                        null, new File(SystemProperties.getProperty("system_backup_database_folder")));
            }
            /*boolean checkout = SyncSVN.syncToSVN();*/
            Util.CHECKED_BACKUP = 0;

            /*InetAddress ip = InetAddress.getLocalHost();
            String IP = ip.getHostAddress();
            String ipServer = SystemProperties.getProperty("IP_SERVER");*/
            String[] emails = XmlHandler.getValueNode("Emails").replaceAll("\\s+", "").split(",");
            String emailTitle = XmlHandler.getValueNode("EmailTitle");
            String content = "<h3 style='color:black'>Dữ liệu đã sao lưu thành công:</h3>" +
                    "<div>• Thư mục lưu trữ: " + SystemProperties.getProperty("system_backup_database_folder") + "<div>" +
                    "<div>• Tên file: " + fileName + "<div>" +
                    "<div>• Thời gian lưu trữ: " + new Date().toString() + "<div>";
            /*SendMailUtil.sendGmail(emails, "[Uchi] Sao Lưu Dữ Liệu Thành Công", content);*/
            MailSendList mailSendList = new MailSendList(emails,content,emailTitle);
            Boolean result = QueryFactory.sendMailOSP(mailSendList.generateAddJson());
            if(result == true){
                System.out.println("Gửi Mail thành công");
            }else {
                System.out.println(" Gửi Mail thất bại");
            }
            Util.FILE_NAME_BACKUP = fileName;



/*
            String folderId = "0BwwA4oUTeiV1TGRPeTVjaWRDY1E";
            File fileMetadata = new File();
            fileMetadata.setName("photo.jpg");
            fileMetadata.setParents(Collections.singletonList(folderId));
            java.io.File filePath = new java.io.File("files/photo.jpg");
            FileContent mediaContent = new FileContent("image/jpeg", filePath);
            File file = driveService.files().create(fileMetadata, mediaContent)
                    .setFields("id, parents")
                    .execute();
            System.out.println("File ID: " + file.getId());*/



        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
