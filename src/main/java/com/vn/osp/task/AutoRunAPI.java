package com.vn.osp.task;


import com.vn.osp.common.global.Constants;
import com.vn.osp.common.util.*;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.net.Socket;
import java.util.logging.Logger;

public class AutoRunAPI implements Runnable {
    private static final Logger logger = Logger.getLogger(AutoRunAPI.class.getName());
    private ServletContext context;
    public AutoRunAPI() {

    }
    public AutoRunAPI(ServletContext context) {
        this.context = context;
    }
  /*  public static void main(String[] args) throws Exception
    {
        logger.info("log:"+serverListening("localhost", 8082));

    }*/
    public static boolean serverListening(String host, int port)
    {
        Socket s = null;
        try
        {
            s = new Socket(host, port);
            return true;
        }
        catch (Exception e)
        {
            return false;
        }
        finally
        {
            if(s != null)
                try {s.close();}
                catch(Exception e){}
        }
    }



    public void run() {
        boolean checkTelnet= serverListening("localhost", Integer.parseInt(SystemProperties.getProperty(Constants.AUTO_RESET_PORT)));
        if(checkTelnet){
            logger.info("Telnet API:"+checkTelnet);
        }else{
            try {
                logger.info("Telnet API:"+checkTelnet);
                Runtime c = Runtime.getRuntime();
                String cmd = "cmd /c start " + SystemProperties.getProperty(Constants.AUTO_RESET_FOLDER) + "api_tccc.bat";
                if (SystemProperties.getProperty("system_backup_os").equals("0")) {
                    c.exec(cmd, null,new File(SystemProperties.getProperty(Constants.AUTO_RESET_FOLDER)));
                } else {
                    c.exec(SystemProperties.getProperty(Constants.AUTO_RESET_FOLDER) + "api_tccc.sh",
                            null, new File(SystemProperties.getProperty(Constants.AUTO_RESET_FOLDER)));

                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }


}
