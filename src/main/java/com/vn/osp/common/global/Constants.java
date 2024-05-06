package com.vn.osp.common.global;


import com.vn.osp.common.util.SystemMessageProperties;

/**
 * <P>Constants</P>
 *
 * @author  Nguyen Thanh Hai
 * @version $Revision: 20437 $
 */
public class Constants {

    /** Filter Kind */
    public enum FilterKind {
        /** Full */
        FULL
        /** Left */
        , LEFT
        /** Middle */
        , MIDDLE

        ;


        public Integer getValue() {
            switch (this) {
            case FULL:
                return 0;
            case LEFT:
                return 1;
            case MIDDLE:
                return 2;
            default:
                return null;
            }
        }


        public static FilterKind changeValue(Integer value) {
            if (value == null) {
                return null;
            }
            switch (value) {
            case 0:
                return FULL;
            case 1:
                return LEFT;
            case 2:
                return MIDDLE;
            default:
                return null;
            }
        }
    };

    public static  final String SESSION_ACTION = "action";
    public static final int ROW_PER_PAGE = 20;
    /** Authority Code */
    public static final String AUTHORITY_CONTRACT		= "01";
    public static final String AUTHORITY_PREVENT_DATA	= "02";
    public static final String AUTHORITY_BANK_REPORT	= "03";
    public static final String AUTHORITY_ADMIN 			= "04";
    public static final String AUTHORITY_ANNOUNCEMENT   = "05";
        
    /*Role*/
    public static final String CAN_BO_TIEP_NHAN   = "06";
    public static final String CONG_CHUNG_VIEN   = "07";
    public static final String LANH_DAO     = "08";
    public static final String REPORT     = "09";
    
    public static final String VAN_THU      = "010";
    public static final String OTHER        = "99";

    //Loai tai san
    public static final String NHA_DAT = "01";
    public static final String OTO_XEMAY = "02";
    public static final String TAI_SAN_KHAC = "99";
    
    /**Type Prevent */
    public static final int TIEP_NHAN = 1;
    public static final int DA_TRINH = 2;
    public static final int CHUA_XU_LY = 3;
    public static final int DA_DUYET = 4;
    public static final int KHONG_DUYET = 5;
    public static final Boolean GIAI_TOA = true;

    /** Notary Office Type */
    public static final Byte OFFICE_TYPE_JUSTICE	= 1;
    public static final Byte OFFICE_TYPE_NOTARY		= 2;
    public static final Byte OFFICE_TYPE_ORTHER		= 3;

    /** Common Integer */
    public static final int LENGTH_STRING_LIMIT = 100;
    public static final int LENGTH_OUTPUT_LIMIT = 200;

    /** Common String */
    public static final String DOT3 = "...";
    public static final String ENTER = "\n";
    public static final String SPACE = " ";
    public static final String COLON = ":";
    public static final String MASK = "\"";
    public static final String PLUS = "\\+";
    public static final String MINUS = "\\-";
    public static final String SEMI_COLON = ";";
    public static final String UNIT_SEPARATOR = "_";
    public static final String PERCENT = "%";
    public static final String VERTICAL_LINE = "|";
    public static final String SHARP = "#";
    public static final String BULLET = "-";
    
    /** Execute data key */
    public static final String PREVENT_ENTRY_KEY = "PREVENT_ENTRY";
    public static final String PREVENT_UPDATE_KEY = "PREVENT_UPDATE";
    public static final String PREVENT_DELETE_KEY = "PREVENT_DELETE";
    public static final String PREVENT_RELEASE_KEY = "PREVENT_RELEASE";
    public static final String PREVENT_SUBMIT_LEADER = "SUBMIT_LEADER";
    public static final String PREVENT_APPROVE = "APPROVE";
    public static final String PREVENT_DIVISION = "DIVISION";
    public static final String PREVENT_SUBMIT_APPROVE = "SUBMIT_APPROVE";

    /** Synchronize data key */
    public static final Byte SYNCHRONIZE_TYPE_PREVENT = 1;
    public static final Byte SYNCHRONIZE_TYPE_HISTORY = 2;
    public static final Byte SYNCHRONIZE_TYPE_ANNOUNCEMENT = 3;

    public static final Byte SYNCHRONIZE_ACTION_REGIST = 1;
    public static final Byte SYNCHRONIZE_ACTION_EDIT = 2;
    public static final Byte SYNCHRONIZE_ACTION_DELETE = 3;
    public static final Byte SYNCHRONIZE_ACTION_RELEASE = 4;

    // 3 loai quyen: quan tri HT, chuc nang, bao cao
    public static final int AUTHORITY_TYPE_SYSTEM_MANAGER = 1;
    public static final int AUTHORITY_TYPE_FUNCION = 2;
    public static final int AUTHORITY_TYPE_REPORT = 3;

    //gia tri thap phan cua role
    public static final int AUTHORITY_XEM = 64;
    public static final int AUTHORITY_THEM = 32;
    public static final int AUTHORITY_SUA = 16;
    public static final int AUTHORITY_XOA = 8;
    public static final int AUTHORITY_TIMKIEM = 4;
    public static final int AUTHORITY_IN = 2;
    public static final int AUTHORITY_BACKUP = 1;

    // max size file upload
    public static final long MAX_SIZE_FILE_UPLOAD = 20971520;

    public static final long MAX_SIZE_FILE_UPLOAD_5MB = 4194304;
    public static final long MAX_SIZE_FILE_UPLOAD_10MB = 8388608;

    //access history type
    public static final int LOGIN = 0;
    public static final int LOGOUT = 1;
    public static final int VIEW = 2;
    public static final int ADD = 3;
    public static final int EDIT = 4;
    public static final int DEL = 5;

    //backup
    public static final String CONFIG_BACKUP_DATABASE_FOLDER = "system_backup_database_folder";
    public static final String CHECK_BACKUP_DATABASE = "backup_check";
    public static final String CONFIG_MYSQL_DUMP_FOLDER = "system_mysql_mysqldump_folder";
    public static final String CONFIG_TIME_BACKUP = "time_backup";
    public static final String CONFIG_DATE_BACKUP = "date_backup";
    public static final String CONFIG_EMAIL_BACKUP = "email";
    public static final String FILE_NAME_BACKUP = "backupnow.bat";
    public static final String FILE_NAME_RESTORE = "restore.bat";
    public static final String FOLDER_NAME_BACKUP_ON_GOOGLE_DRIVER = "UCHI_TCCC_BACKUP";
    public static final String CONFIG_EMAIL_TITLE_BACKUP = "email_title";
    public static final String CONFIG_URL_SVN_SYNC = "url_svn_backup_sync_vip";
    public static final String CONFIG_LOGIN_SVN_USERNAME = "svn_sync_username";
    public static final String CONFIG_LOGIN_SVN_PASSWORD = "svn_sync_password";

   /* public static final String STP_API_LINK = "http://localhost:8081/api";
    public static final String VPCC_API_LINK = "http://localhost:8082/api";
    public static final String OSP_API_LINK = "http://localhost:8083/api";*/

//    public static final String STP_API_LINK = "http://congchung.haugiang.gov.vn:8081/apistphgi";
    public static final String STP_API_LINK = SystemMessageProperties.getSystemPropertyFromClassPath("system.properties","STP_API_LINK");
    public static final String VPCC_API_LINK = SystemMessageProperties.getSystemPropertyFromClassPath("system.properties","VPCC_API_LINK");
    public static final String OSP_API_LINK = SystemMessageProperties.getSystemPropertyFromClassPath("system.properties","OSP_API_LINK");
    //Dong bo hop dong
    public static final int CREATE_CONTRACT = 1;
    public static final int UPDATE_CONTRACT = 2;
    public static final int DELETE_CONTRACT = 3;
    public static final int CANCEL_CONTRACT = 4;
    public static final int FREE_CONTRACT = 5;

    public static final String EMAIL_USERNAME = SystemMessageProperties.getSystemPropertyFromClassPath("system.properties","email.username");
    public static final String EMAIL_PASSWORD = SystemMessageProperties.getSystemPropertyFromClassPath("system.properties","email.password");


    public static final String AUTO_RESET_ENABLE = "auto_reset_enable";
    public static final String AUTO_RESET_TIME = "auto_reset_time";
    public static final String AUTO_RESET_FOLDER = "auto_reset_folder";
    public static final String AUTO_RESET_PORT = "auto_reset_port";

    /**config type câu hỏi trợ giúp tại tccc*/
    public static final int type_QATCCC = 2;

    /**Config cấp tài khoản chứng thực thuộc xã/huyện/tỉnh*/
    public static String LEVEL_CERT_XA = "XA";
    public static String LEVEL_CERT_HUYEN = "HUYEN";
    public static String LEVEL_CERT_TINH = "TINH";

    /**Config trang thai hop dong online*/
    public static int HDOL_CHO_KY = 0;
    public static int HDOL_DA_KY = 1;
    public static int HDOL_TRA_VE = 2;
    public static int HDOL_LUU_TAM = 3;
    public static int HDOL_DONG_DAU = 4;
    public static int HDOL_HUY = 5;

    /**Config trang thai hop dong offline*/
    public static int HDOFF_LUU_TAM = 5;

    //capcha
    public static final String CAPCHA_PARAM_NAME = "captcha";

    //login
    public static final String NAME_OF_LIMIT_TIME_LOGIN_FAIL_FIELD_SHOW_CAPTCHA = "limit_time_login_fail_show_captcha";
    public static final String NAME_OF_LIMIT_TIME_LOGIN_FAIL_FIELD_TEMP_BLOCK = "limit_time_login_fail_temp_block";
    public static final String NAME_OF_LIMIT_TIME_LOGIN_FAIL_FIELD_BLOCK = "limit_time_login_fail_block";
    public static final String FLG_SHOW_CAPTCHA = "1"; //else "0"
    public static final Integer ACTIVE_FLG_TEMP = 2; //field: active_flg
    public static final String NAME_OF_PASSWORD_DEFAULT = "password_default";

    //Config loại chứng thực
    public static int CERTIFICATE_TYPE_SIGNATURE = 1;
    public static int CERTIFICATE_TYPE_COPY = 2;
    public static int CERTIFICATE_TYPE_CONTRACT = 3;
    public static int CERTIFICATE_TYPE_TRANSLATOR = 4;
    /** Config trạng thái sổ công chứng/chứng thực */
    public static int STATUS_NOTARY_BOOK_LOCK_UP = 1;
    public static int STATUS_NOTARY_BOOK_OPEN = 0;

    //Config loại mẫu lời chứng chứng thực
    public static int ATTSETATION_TYPE_CT_BAN_SAO = 1;
    public static int ATTSETATION_TYPE_CT_CHU_KY = 2;
    public static int ATTSETATION_TYPE_CT_CHU_KY_NGUOI_DICH = 3;

    /**Config các loại sổ công chứng, chứng thực*/
/*    public static final int SO_CT_HD_GIAO_DICH = 1;
    public static final int SO_CT_BAN_SAO = 2;
    public static final int SO_CT_CHU_KY = 3;*/

    //Config loại phí chứng thực
    public static int FEE_CERT_CHU_KY = 1;
    public static int FEE_CERT_BAN_SAO = 2;
    public static int FEE_CERT_HDGD = 3;
    public static int FEE_CERT_HDGD_SUADOI = 4;
    public static int FEE_CERT_HDGD_SUADOI_DACHUNGTHUC = 5;
    public static int FEE_CERT_TRANSLATOR = 6;
    public static int FUNCTION_ON = 1;
    public static int FUNCTION_OFF = 0;
}
