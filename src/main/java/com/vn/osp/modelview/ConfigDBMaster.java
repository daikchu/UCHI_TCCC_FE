package com.vn.osp.modelview;

public class ConfigDBMaster {
    private String master_dbName;
    private String master_serverip;
    private String master_serverport;
    private String master_driver;
    private String master_databaseUserName;
    private String master_databasePassword;

    public String getMaster_dbName() {
        return master_dbName;
    }

    public void setMaster_dbName(String master_dbName) {
        this.master_dbName = master_dbName;
    }

    public String getMaster_serverip() {
        return master_serverip;
    }

    public void setMaster_serverip(String master_serverip) {
        this.master_serverip = master_serverip;
    }

    public String getMaster_serverport() {
        return master_serverport;
    }

    public void setMaster_serverport(String master_serverport) {
        this.master_serverport = master_serverport;
    }

    public String getMaster_driver() {
        return master_driver;
    }

    public void setMaster_driver(String master_driver) {
        this.master_driver = master_driver;
    }

    public String getMaster_databaseUserName() {
        return master_databaseUserName;
    }

    public void setMaster_databaseUserName(String master_databaseUserName) {
        this.master_databaseUserName = master_databaseUserName;
    }

    public String getMaster_databasePassword() {
        return master_databasePassword;
    }

    public void setMaster_databasePassword(String master_databasePassword) {
        this.master_databasePassword = master_databasePassword;
    }
}
