package com.vn.osp.modelview;

import com.vn.osp.common.util.TimeUtil;

import java.util.Date;
import java.util.List;

/**
 * Created by Admin on 2018-05-25.
 */
public class SalesWrapper {
    public static String SESSION_KEY = "Sales";
    private List<SalesByDrafts> salesByDraftsList;
    private List<SalesByNotarys> salesByNotarysList;
    private List<SalesByKindContract> salesByKindContracts;

    private String toDate;
    private String fromDate;
    private String timeType;
    private String notaryDateFromFilter;
    private String notaryDateToFilter;

    Long notaryNumberContractTotal ;
    Long notary91Total ;
    Long notaryDraftTotal ;
    Long notaryOutsideTotal ;
    Long notaryDetermineTotal;
    Long notaryTotal;

    Long draftNumberContractTotal ;
    Long draft91Total ;
    Long draftDraftTotal ;
    Long draftOutsideTotal ;
    Long draftDetermineTotal;
    Long draftTotal;

    Long kindNumberContractTotal ;
    Long kind91Total ;
    Long kindDraftTotal ;
    Long kindOutsideTotal ;
    Long kindDetermineTotal;
    Long kindTotal;

    private String printFromDate;
    private String printToDate;

    public SalesWrapper() {
    }

    public SalesWrapper(List<SalesByDrafts> salesByDraftsList, List<SalesByNotarys> salesByNotarysList, List<SalesByKindContract> salesByKindContracts) {
        this.salesByDraftsList = salesByDraftsList;
        this.salesByNotarysList = salesByNotarysList;
        this.salesByKindContracts = salesByKindContracts;
    }

    public void createFromToDate(){
        if(this.timeType == null || this.timeType.equals("")){
            this.timeType = "03";
        }
        if(timeType.equals("01")){
            this.notaryDateFromFilter = TimeUtil.toTimestamp(true,TimeUtil.getDay(new Date())).toString();
            this.notaryDateToFilter = TimeUtil.toTimestamp(false,TimeUtil.getDay(new Date())).toString();

            fromDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(true,TimeUtil.getDay(new Date())));
            toDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(false,TimeUtil.getDay(new Date())));
            printFromDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(true,TimeUtil.getDay(new Date())));
            printToDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(false,TimeUtil.getDay(new Date())));
        } else if(timeType.equals("02")){
            this.notaryDateFromFilter = TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfWeek(new Date())).toString();
            this.notaryDateToFilter = TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfWeek(new Date())).toString();

            fromDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfWeek(new Date())));
            toDate =  TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfWeek(new Date())));
            printFromDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfWeek(new Date())));
            printToDate =  TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfWeek(new Date())));
        } else if(timeType.equals("03")){
            this.notaryDateFromFilter = TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfMonth(new Date())).toString();
            this.notaryDateToFilter = TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfMonth(new Date())).toString();

            fromDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfMonth(new Date())));
            toDate =  TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfMonth(new Date())));
            printFromDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfMonth(new Date())));
            printToDate =  TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfMonth(new Date())));
        } else if(timeType.equals("04")){
            this.notaryDateFromFilter = TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfYear(new Date())).toString();
            this.notaryDateToFilter = TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfYear(new Date())).toString();

            fromDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfYear(new Date())));
            toDate =  TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfYear(new Date())));
            printFromDate = TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(true,TimeUtil.getDateByFirstDayOfYear(new Date())));
            printToDate =  TimeUtil.convertTimeStampToString(TimeUtil.toTimestamp(false,TimeUtil.getDateByLastDayOfYear(new Date())));
        } else if(timeType.equals("05")){
            this.notaryDateFromFilter = TimeUtil.toTimestamp(true,fromDate).toString();
            this.notaryDateToFilter = TimeUtil.toTimestamp(false,toDate).toString();;
            printFromDate = fromDate;
            printToDate = toDate;
        }
    }

    public List<SalesByDrafts> getSalesByDraftsList() {
        return salesByDraftsList;
    }

    public void setSalesByDraftsList(List<SalesByDrafts> salesByDraftsList) {
        this.salesByDraftsList = salesByDraftsList;
    }

    public List<SalesByNotarys> getSalesByNotarysList() {
        return salesByNotarysList;
    }

    public void setSalesByNotarysList(List<SalesByNotarys> salesByNotarysList) {
        this.salesByNotarysList = salesByNotarysList;
    }

    public List<SalesByKindContract> getSalesByKindContracts() {
        return salesByKindContracts;
    }

    public void setSalesByKindContracts(List<SalesByKindContract> salesByKindContracts) {
        this.salesByKindContracts = salesByKindContracts;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getTimeType() {
        return timeType;
    }

    public void setTimeType(String timeType) {
        this.timeType = timeType;
    }

    public String getNotaryDateFromFilter() {
        return notaryDateFromFilter;
    }

    public void setNotaryDateFromFilter(String notaryDateFromFilter) {
        this.notaryDateFromFilter = notaryDateFromFilter;
    }

    public String getNotaryDateToFilter() {
        return notaryDateToFilter;
    }

    public void setNotaryDateToFilter(String notaryDateToFilter) {
        this.notaryDateToFilter = notaryDateToFilter;
    }

    public Long getNotaryNumberContractTotal() {
        return notaryNumberContractTotal;
    }

    public void setNotaryNumberContractTotal(Long notaryNumberContractTotal) {
        this.notaryNumberContractTotal = notaryNumberContractTotal;
    }

    public Long getNotary91Total() {
        return notary91Total;
    }

    public void setNotary91Total(Long notary91Total) {
        this.notary91Total = notary91Total;
    }

    public Long getNotaryDraftTotal() {
        return notaryDraftTotal;
    }

    public void setNotaryDraftTotal(Long notaryDraftTotal) {
        this.notaryDraftTotal = notaryDraftTotal;
    }

    public Long getNotaryOutsideTotal() {
        return notaryOutsideTotal;
    }

    public void setNotaryOutsideTotal(Long notaryOutsideTotal) {
        this.notaryOutsideTotal = notaryOutsideTotal;
    }

    public Long getNotaryDetermineTotal() {
        return notaryDetermineTotal;
    }

    public void setNotaryDetermineTotal(Long notaryDetermineTotal) {
        this.notaryDetermineTotal = notaryDetermineTotal;
    }

    public Long getNotaryTotal() {
        return notaryTotal;
    }

    public void setNotaryTotal(Long notaryTotal) {
        this.notaryTotal = notaryTotal;
    }

    public Long getDraftNumberContractTotal() {
        return draftNumberContractTotal;
    }

    public void setDraftNumberContractTotal(Long draftNumberContractTotal) {
        this.draftNumberContractTotal = draftNumberContractTotal;
    }

    public Long getDraft91Total() {
        return draft91Total;
    }

    public void setDraft91Total(Long draft91Total) {
        this.draft91Total = draft91Total;
    }

    public Long getDraftDraftTotal() {
        return draftDraftTotal;
    }

    public void setDraftDraftTotal(Long draftDraftTotal) {
        this.draftDraftTotal = draftDraftTotal;
    }

    public Long getDraftOutsideTotal() {
        return draftOutsideTotal;
    }

    public void setDraftOutsideTotal(Long draftOutsideTotal) {
        this.draftOutsideTotal = draftOutsideTotal;
    }

    public Long getDraftDetermineTotal() {
        return draftDetermineTotal;
    }

    public void setDraftDetermineTotal(Long draftDetermineTotal) {
        this.draftDetermineTotal = draftDetermineTotal;
    }

    public Long getDraftTotal() {
        return draftTotal;
    }

    public void setDraftTotal(Long draftTotal) {
        this.draftTotal = draftTotal;
    }

    public String getPrintFromDate() {
        return printFromDate;
    }

    public void setPrintFromDate(String printFromDate) {
        this.printFromDate = printFromDate;
    }

    public String getPrintToDate() {
        return printToDate;
    }

    public void setPrintToDate(String printToDate) {
        this.printToDate = printToDate;
    }

    public Long getKindNumberContractTotal() {
        return kindNumberContractTotal;
    }

    public void setKindNumberContractTotal(Long kindNumberContractTotal) {
        this.kindNumberContractTotal = kindNumberContractTotal;
    }

    public Long getKind91Total() {
        return kind91Total;
    }

    public void setKind91Total(Long kind91Total) {
        this.kind91Total = kind91Total;
    }

    public Long getKindDraftTotal() {
        return kindDraftTotal;
    }

    public void setKindDraftTotal(Long kindDraftTotal) {
        this.kindDraftTotal = kindDraftTotal;
    }

    public Long getKindOutsideTotal() {
        return kindOutsideTotal;
    }

    public void setKindOutsideTotal(Long kindOutsideTotal) {
        this.kindOutsideTotal = kindOutsideTotal;
    }

    public Long getKindDetermineTotal() {
        return kindDetermineTotal;
    }

    public void setKindDetermineTotal(Long kindDetermineTotal) {
        this.kindDetermineTotal = kindDetermineTotal;
    }

    public Long getKindTotal() {
        return kindTotal;
    }

    public void setKindTotal(Long kindTotal) {
        this.kindTotal = kindTotal;
    }
}
