package com.vn.osp.modelview;


import java.util.ArrayList;

/**
 * Created by Admin on 6/9/2017.
 */
public class AnnouncementForm {
    private Announcement announcementDetail;
    private ArrayList<Announcement> announcementArrayList;
    private Long checkNew ;

    public Long getCheckNew() {
        return checkNew;
    }

    public void setCheckNew(Long checkNew) {
        this.checkNew = checkNew;
    }

    public Announcement getAnnouncementDetail() {
        return announcementDetail;
    }

    public void setAnnouncementDetail(Announcement announcementDetail) {
        this.announcementDetail = announcementDetail;
    }

    public ArrayList<Announcement> getAnnouncementArrayList() {
        return announcementArrayList;
    }

    public void setAnnouncementArrayList(ArrayList<Announcement> announcementArrayList) {
        this.announcementArrayList = announcementArrayList;
    }
}
