package com.vn.osp.service;

import com.vn.osp.common.global.Constants;
import com.vn.osp.context.CommonContext;
import com.vn.osp.modelview.*;
import org.springframework.http.HttpStatus;


import javax.servlet.http.HttpServletRequest;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by tranv on 12/20/2016.
 */
public class STPQueryFactory {
    public static String getClientInfo(HttpServletRequest request) {
        String clientInfo = request.getRemoteAddr() + " [" + request.getSession().getId() + "]";
        return clientInfo;
    }

    public static List<DataPreventInfor> daTiepNhan(String token,int page, String advanceSearchFilter) {

        int entry_user_id = 1;
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        String filter = "where delete_flg = 0 and status = 1 and(ndp.entry_user_id = " + entry_user_id + " or ndp.leader_id = " + entry_user_id + " or ndp.divison_id = " + entry_user_id + ") " + advanceSearchFilter + " ORDER BY ndp.prevent_doc_receive_date DESC, ndp.update_date_time DESC LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        List<DataPreventInfor> result = APIUtil.daTiepNhan(Constants.STP_API_LINK + "/prevent/getDataPreventInfor", filter);
        return result;
    }

    public static int countTotalList(String token,int status, int entry_user_id, int leader_id, int divison_id, String advanceSearchFilter) {
        String filter = "where delete_flg = 0 and status = " + status + " and(ndp.entry_user_id = " + entry_user_id + " or ndp.leader_id = " + leader_id + " or ndp.divison_id = " + divison_id + ") " + advanceSearchFilter;
        int result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/prevent/countTotalByFilter", filter);
        return result;
    }

    public static int countTotalTransactionList(String token,String advanceSearchFilter) {
        int result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/transaction/countTotalByFilter", " where 1=1");
        return result;
    }

    public static int countTotalAnnouncementList(String token,String advanceSearchFilter) {
        int result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/announcement/countTotal", " where 1=1");
        return result;
    }

    public static int countTotalUserList(String token,String query) {
        int result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/users/countTotal", query);
        return result;
    }

    public static List<Announcement> getAnouncementList0(int page, String advanceSearchFilter) {

        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = "1=1";
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        String filter = "where " + advanceSearchFilter + " ORDER BY send_date_time DESC LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        filter = "where " + advanceSearchFilter + " ORDER BY send_date_time DESC ";
        List<Announcement> result = APIUtil.getAnnouncementList(Constants.STP_API_LINK + "/announcement/findAnnouncementByFilter", filter);
        return result;
    }

    public static List<Announcement> getAnouncementList(int page, String advanceSearchFilter) {

        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = "1=1";
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        String filter = advanceSearchFilter + paggingQuery;
        List<Announcement> result = APIUtil.getAnnouncementList(Constants.STP_API_LINK + "/announcement/findAnnouncementByFilter", filter);
        return result;
    }

    public static List<UnitRequest> getUnitRequests() {
        List<UnitRequest> result = APIUtil.getUnitRequestByFilter(Constants.STP_API_LINK + "/UnitRequest/selectUnitRequest", " where active_flg=1");
        return result;
    }


    public static List<DataPreventInfor> daTrinhLanhDao(int page, String advanceSearchFilter) {

        int entry_user_id = 1;
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        String filter = "where delete_flg = 0 and status = 2 and(ndp.entry_user_id = " + entry_user_id + " or ndp.leader_id = " + entry_user_id + " or ndp.divison_id = " + entry_user_id + ") " + advanceSearchFilter + " ORDER BY prevent_doc_receive_date DESC, update_date_time DESC LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        List<DataPreventInfor> result = APIUtil.daTiepNhan(Constants.STP_API_LINK + "/prevent/getDataPreventInfor", filter);
        return result;
    }

    public static List<DataPreventInfor> dangXuLy(int page, String advanceSearchFilter) {

        int entry_user_id = 1;
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        String filter = "where delete_flg = 0 and status = 3 and(ndp.entry_user_id = " + entry_user_id + " or ndp.leader_id = " + entry_user_id + " or ndp.divison_id = " + entry_user_id + ") " + advanceSearchFilter + " ORDER BY prevent_doc_receive_date DESC, update_date_time DESC LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        List<DataPreventInfor> result = APIUtil.daTiepNhan(Constants.STP_API_LINK + "/prevent/getDataPreventInfor", filter);
        return result;
    }

    public static List<DataPreventInfor> daDuyet(int page, String advanceSearchFilter) {

        int entry_user_id = 1;
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        String filter = "where delete_flg = 0 and status = 4 and(ndp.entry_user_id = " + entry_user_id + " or ndp.leader_id = " + entry_user_id + " or ndp.divison_id = " + entry_user_id + ") " + advanceSearchFilter + " ORDER BY prevent_doc_receive_date DESC, update_date_time DESC LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        List<DataPreventInfor> result = APIUtil.daTiepNhan(Constants.STP_API_LINK + "/prevent/getDataPreventInfor", filter);
        return result;
    }

    public static List<DataPreventInfor> daDuyetAll(int page, String advanceSearchFilter) {

        int entry_user_id = 1;
        String filter = "where delete_flg = 0 and status = 4 and(ndp.entry_user_id = " + entry_user_id + " or ndp.leader_id = " + entry_user_id + " or ndp.divison_id = " + entry_user_id + ") " + advanceSearchFilter + " ORDER BY prevent_doc_receive_date DESC, update_date_time DESC ";
        List<DataPreventInfor> result = APIUtil.daTiepNhan(Constants.STP_API_LINK + "/prevent/getDataPreventInfor", filter);
        return result;
    }


    public static List<DataPreventInfor> khongDuyet(int page, String advanceSearchFilter) {

        int entry_user_id = 1;
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        String filter = "where delete_flg = 0 and status = 5 and(ndp.entry_user_id = " + entry_user_id + " or ndp.leader_id = " + entry_user_id + " or ndp.divison_id = " + entry_user_id + ") " + advanceSearchFilter + " ORDER BY prevent_doc_receive_date DESC, update_date_time DESC LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        List<DataPreventInfor> result = APIUtil.daTiepNhan(Constants.STP_API_LINK + "/prevent/getDataPreventInfor", filter);
        return result;
    }

    public static DataPreventInfor getDataPreventInforById(String token,Long preventId) {
        List<DataPreventInfor> result = STPAPIUtil.daTiepNhan(token,Constants.STP_API_LINK + "/search/prevent-detail", String.valueOf(preventId));
        if (result != null && result.size() > 0) return result.get(0);
        else return null;
    }
    public static List<PropertyPrevent> getPropertyPreventById(String token,Long propertyId) {
        String filter = "where npp.id=" + propertyId;
        List<PropertyPrevent> result = APIUtil.getPropertyPreventByFilter(token,Constants.STP_API_LINK + "/prevent/getPropertyPreventByFilter", filter);
        return result;
    }
    public static List<DataPreventInfor> getDataPreventInforAll() {
        String filter = " where ndp.delete_flg=0 ";
        List<DataPreventInfor> result = APIUtil.daTiepNhan(Constants.STP_API_LINK + "/prevent/getDataPreventInfor", filter);
        return result;
    }

    public static List<PreventHistory> getPreventHistoryList(String token,Long preventId) {
        List<PreventHistory> result = APIUtil.getPreventHistoryList(token,Constants.STP_API_LINK + "/search/prevent-history", String.valueOf(preventId));
        return result;
    }

    public static List<TransactionProperty> getTransactionPropertyList(String token,int page, String advanceSearchFilter) {
        //notary_date desc
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = "";
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        advanceSearchFilter = advanceSearchFilter + " limit " + offset + "," + Constants.ROW_PER_PAGE;
        List<TransactionProperty> result = STPAPIUtil.getTransactionPropertyList(token,Constants.STP_API_LINK + "/transaction/findTransactionByFilter", advanceSearchFilter);
        return result;
    }

    public static List<TransactionProperty> getTransactionPropertyByFilter(String token,String filter) {
        List<TransactionProperty> result = STPAPIUtil.getTransactionPropertyList(token,Constants.STP_API_LINK + "/transaction/findTransactionByFilter", filter);
        return result;
    }

    public static List<TransactionProperty> getTransactionPropertyAll(String token,String advanceSearchFilter) {
        List<TransactionProperty> result = STPAPIUtil.getTransactionPropertyList(token,Constants.STP_API_LINK + "/transaction/findTransactionByFilter", advanceSearchFilter);
        return result;
    }

    public static TransactionProperty getTransactionPropertyById(String token,Long tpid) {
        List<TransactionProperty> result = STPAPIUtil.getTransactionPropertyList(token,Constants.STP_API_LINK + "/search/transaction-detail", String.valueOf(tpid));
        if (result != null) {
            if(result.size() > 0){
                return result.get(0);
            }
        }
        return null;
    }


    public static List<ReportByGroupTotal> getReportTotalListByGroup(String notaryDateFromFilter, String notaryDateToFilter) {
        NotaryDateFilter notaryDateFilter = new NotaryDateFilter();
        notaryDateFilter.setNotaryDateFromFilter(notaryDateFromFilter);
        notaryDateFilter.setNotaryDateToFilter(notaryDateToFilter);
        List<ReportByGroupTotal> result = APIUtil.getReportByGroupList(Constants.STP_API_LINK + "/contract/selectReportByGroupTotal", notaryDateFilter.generateJsonObject().toString());
        return result;
    }

    public static User getUserById(String token,Long id) {
        String filter = "where id=" + id;
        List<User> result = STPAPIUtil.getUserByFilter(token,Constants.STP_API_LINK + "/users/selectByFilter", filter);
        if (result != null) return result.get(0);
        else return null;
    }

    public static List<User> getUserByAccount(String token,String username) {
        String filter = "where account like '" + username + "'";
        List<User> result = STPAPIUtil.getUserByFilter(token,Constants.STP_API_LINK + "/users/selectByFilter", filter);
        return result;
    }

    public static List<User> getUserList(String token,int page, String filter) {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (offset < 0) offset = 0;
        filter = filter + " limit " + offset + "," + Constants.ROW_PER_PAGE;
        List<User> result = STPAPIUtil.getUserByFilter(token,Constants.STP_API_LINK + "/users/selectByFilter", filter);
        return result;
    }

    public static List<User> getAllUser(String token) {
        String filter = " where active_flg=1";
        List<User> result = STPAPIUtil.getUserByFilter(token,Constants.STP_API_LINK + "/users/selectByFilter", filter);
        return result;
    }

    public static Boolean updateUser(String data) {
        Boolean result = APIUtil.updateUserAPI(Constants.STP_API_LINK + "/users/update-user", data);
        return result;
    }

    public static Boolean removeUser(String data) {
        Boolean result = APIUtil.updateUserAPI(Constants.STP_API_LINK + "/users/remove-user", data);
        return result;
    }

    public static List<GroupRole> getActiveGroupRole(String filter) {
        List<GroupRole> result = APIUtil.getGroupRoleByFilter(Constants.STP_API_LINK + "/users/select-group-role", "where active_flg=1");
        return result;
    }

    public static List<GroupRole> getActiveGroupRoleByPage(int page, String titleFilter) {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (offset < 0) offset = 0;
        String filter = " where active_flg =1 and grouprolename like '%" + titleFilter + "%'";
        filter = filter + " limit " + offset + "," + Constants.ROW_PER_PAGE;
        ////System.out.println(filter);
        List<GroupRole> result = APIUtil.getGroupRoleByFilter(Constants.STP_API_LINK + "/users/select-group-role", filter);
        return result;
    }

    public static List<GroupRole> getGroupRoleByPage(int page, String titleFilter) {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (offset < 0) offset = 0;
        String filter = " where grouprolename like '%" + titleFilter + "%'";
        filter = filter + " limit " + offset + "," + Constants.ROW_PER_PAGE;
        ////System.out.println(filter);
        List<GroupRole> result = APIUtil.getGroupRoleByFilter(Constants.STP_API_LINK + "/users/select-group-role", filter);
        return result;
    }

    public static Integer countTotalActiveGroupRole(String token,String titleFilter) {
        String filter = " where active_flg =1 and grouprolename like '%" + titleFilter + "%'";
        Integer result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/users/count-total-group-role", filter);
        return result;
    }

    public static Integer countTotalGroupRole(String token,String titleFilter) {
        String filter = " where grouprolename like '%" + titleFilter + "%'";
        Integer result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/users/count-total-group-role", filter);
        return result;
    }

    public static Integer countUserAuthorityByGroupId(String token,Long groupId) {
        String filter = " where groupid=" + groupId;
        Integer result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/users/count-user-authority", filter);
        return result;
    }

    public static GroupRole getGroupRole(long id) {
        String filter = " where id=" + id + " ";
        List<GroupRole> result = APIUtil.getGroupRoleByFilter(Constants.STP_API_LINK + "/users/select-group-role", filter);
        if (result != null && result.size() > 0) {
            return result.get(0);
        }
        return null;
    }

    public static List<UserGroupRole> getUserGroupRoleList(String token,Long userId) {
        String filter = " where nua.user_Id =" + userId + " and active_flg=1";
        List<UserGroupRole> result = STPAPIUtil.getUserGroupRoleByFilter(token,Constants.STP_API_LINK + "/users/select-user-group-role", filter);
        return result;
    }

    public static Boolean permissionUser(String token,String data) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/users/permission-user", data);
        return result;
    }

    public static Boolean deleteGroupRoleAuthority(String token,Long groupid) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/users/delete-group-role-authority-by-groupid", groupid.toString());
        return result;
    }

    public static Boolean deleteGroupRole(String token,Long groupid) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/users/delete-group-role-by-groupid", groupid.toString());
        return result;
    }


    public static ArrayList<Authority> getAuthorityByFilter(String stringFilter) {
        ArrayList<Authority> result = APIUtil.getAuthorityByFilter(Constants.STP_API_LINK + "/users/get-authority-by-filter", stringFilter);
        return result;
    }

    public static ArrayList<GrouproleAuthority> getGroupRoleAuthorityByFilter(String stringFilter) {
        ArrayList<GrouproleAuthority> result = APIUtil.getGroupRoleAuthorityFilter(Constants.STP_API_LINK + "/users/select-group-role-authority", stringFilter);
        return result;
    }

    public static GrouproleAuthority getGroupRoleAuthority(long grouprole_id) {
        String stringFilter = " where grouprole_id=" + grouprole_id;
        ArrayList<GrouproleAuthority> result = APIUtil.getGroupRoleAuthorityFilter(Constants.STP_API_LINK + "/users/select-group-role-authority", stringFilter);
        if (result != null && result.size() > 0) return result.get(0);
        else return null;
    }

    public static List<GrouproleAuthority> getGroupRoleAuthorites(long grouprole_id) {
        String stringFilter = " where grouprole_id=" + grouprole_id;
        ArrayList<GrouproleAuthority> result = APIUtil.getGroupRoleAuthorityFilter(Constants.STP_API_LINK + "/users/select-group-role-authority", stringFilter);
        return result;
    }

    public static ArrayList<UserAuthority> getUserAuthorityByFilter(String stringFilter) {
        ArrayList<UserAuthority> result = APIUtil.getUserAuthorityFilter(Constants.STP_API_LINK + "/users/select-user-authority-by-filter", stringFilter);
        return result;
    }

    public static ArrayList<Authority> getAuthorityByType(int type) {
        String filter = " where type=" + type;
        ArrayList<Authority> result = APIUtil.getAuthorityByFilter(Constants.STP_API_LINK + "/users/get-authority-by-filter", filter);
        return result;
    }

    public static ArrayList<Announcement> getLatestAnnouncement(int number) {
        ArrayList<Announcement> result = (ArrayList<Announcement>) APIUtil.getAnnouncementList(Constants.STP_API_LINK + "/announcement/findLatestAnnouncement", String.valueOf(number));
        return result;
    }

    public static String getSystemConfigByKey(String token,String key) {
        String result = STPAPIUtil.getSystemConfigByKey(token,Constants.STP_API_LINK + "/systemmanager/getConfigValue", key);
        return result;
    }

    public static ArrayList<Authority> getAuthorities(String token) {
        ArrayList<Authority> result = STPAPIUtil.getAuthorityByFilter(token,Constants.STP_API_LINK + "/users/get-authority-by-filter", "where 1=1");
        return result;
    }

    public static Boolean createGroupRole(String token,String data) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/users/add-grouprole", data);
        return result;
    }

    public static Boolean updateGroupRole(String token,String data) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/users/update-grouprole", data);
        return result;
    }

    /*------------------ Begin Bank --------------------------- */
    public static Boolean createBank(String token,String data) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/bank/addBank", data);
        return result;
    }

    public static Boolean updateBank(String token,String data) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/bank/updateBank", data);
        return result;
    }
/*------------------ End Bank --------------------------- */


    /*
    * author vietmanh
    * date 3/14/2017
    * Ham dem so trang
    * */
    public static int countPage(int total) {
        int rowPerpage = Constants.ROW_PER_PAGE;
        int result = 0;
        result = total / rowPerpage;
        int temp = total % rowPerpage;
        if (temp > 0) {
            result = result + 1;
            return result;
        } else return result;
    }

    public static List<Bank> getBankList(String advanceSearchFilter) {

        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String filter = advanceSearchFilter;
        List<Bank> result = APIUtil.getBankList(Constants.STP_API_LINK + "/bank/selectBank", filter);
        return result;
    }

/*
    public static List<TransactionProperty> getContractList(String bankname, int page, String notaryDateFromFilter, String notaryDateToFilter) {
        ReportByBank reportByBank = new ReportByBank();
        reportByBank.setNotaryDateFromFilter(notaryDateFromFilter);
        reportByBank.setNotaryDateToFilter(notaryDateToFilter);
        reportByBank.setBank_name(bankname);
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        String s1 = "?numOffset=" + offset;
        String s2 = "&numLimit=" + Constants.ROW_PER_PAGE;
        ////System.out.println("offset" + offset);
        List<TransactionProperty> result = APIUtil.getTransactionPropertyList(Constants.STP_API_LINK+"/transaction/findTransactionByBank" + s1 + s2, reportByBank.generateJsonObject().toString());
        return result;
    }
*/

    public static int countTotalContractByBank(String token,String bankname, String notaryDateFromFilter, String notaryDateToFilter) {
        NotaryDateFilter notaryDateFilter = new NotaryDateFilter();
        notaryDateFilter.setNotaryDateFromFilter(notaryDateFromFilter);
        notaryDateFilter.setNotaryDateToFilter(notaryDateToFilter);
        String s1 = "?bankname=" + bankname;
        int result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/transaction/countTotalContractByBank" + s1, notaryDateFilter.generateJsonObject().toString());
        return result;
    }

    public static List<TransactionProperty> getReportByNotary(String token,String notaryOfficeName, String notaryName, int page, String notaryDateFromFilter, String notaryDateToFilter) {
        ReportByNotaryDateFilter reportByNotaryDateFilter = new ReportByNotaryDateFilter();
        reportByNotaryDateFilter.setNotary_office_name(notaryOfficeName);
        reportByNotaryDateFilter.setNotary_person(notaryName);
        reportByNotaryDateFilter.setNotaryDateFromFilter(notaryDateFromFilter);
        reportByNotaryDateFilter.setNotaryDateToFilter(notaryDateToFilter);
        ////System.out.println("notary office Name" + notaryOfficeName);
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        String s1 = "?numOffset=" + offset;
        String s2 = "&numLimit=" + Constants.ROW_PER_PAGE;
        List<TransactionProperty> result = STPAPIUtil.getTransactionPropertyList(token,Constants.STP_API_LINK + "/transaction/selectReportByNotary" + s1 + s2, reportByNotaryDateFilter.generateJsonObject().toString());
        return result;
    }

    public static int countTotalReportByNotary(String token,String notaryOfficeName, String notaryName, String notaryDateFromFilter, String notaryDateToFilter) {
        ReportByNotaryDateFilter reportByNotaryDateFilter = new ReportByNotaryDateFilter();
        reportByNotaryDateFilter.setNotary_office_name(notaryOfficeName);
        reportByNotaryDateFilter.setNotary_person(notaryName);
        reportByNotaryDateFilter.setNotaryDateFromFilter(notaryDateFromFilter);
        reportByNotaryDateFilter.setNotaryDateToFilter(notaryDateToFilter);
        int result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/transaction/countTotalReportByNotary", reportByNotaryDateFilter.generateJsonObject().toString());
        return result;
    }

    public static List<NotaryOfficeList> selectVPCC() {
        List<NotaryOfficeList> result = APIUtil.getNotaryOfficeList(Constants.STP_API_LINK + "/transaction/selectVPCC", "");
        return result;
    }

    public static List<NotaryName> getNotaryName(String notaryOfficeName) {
        ReportByNotary reportByNotary = new ReportByNotary();
        reportByNotary.setNotary_office_name(notaryOfficeName);
        ////System.out.println("office 1 " + notaryOfficeName);
        List<NotaryName> result = APIUtil.getNotaryName(Constants.STP_API_LINK + "/transaction/findNotary", reportByNotary.getNotary_office_name());
        ////System.out.println("size name " + result.size());
        return result;
    }


    public static int countTotalReportByUser(String token,String notaryOfficeName, String entryUserName, String notaryDateFromFilter, String notaryDateToFilter) {
        ReportByUserDateFilter reportByUserDateFilter = new ReportByUserDateFilter();
        reportByUserDateFilter.setNotary_office_name(notaryOfficeName);
        reportByUserDateFilter.setEntry_user_name(entryUserName);
        reportByUserDateFilter.setNotaryDateFromFilter(notaryDateFromFilter);
        reportByUserDateFilter.setNotaryDateToFilter(notaryDateToFilter);
        int result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/transaction/countTotalReportByUser", reportByUserDateFilter.generateJsonObject().toString());
        return result;
    }

    public static List<TransactionProperty> getReportByUser(String token,String notaryOfficeName, String entryUserName, int page, String notaryDateFromFilter, String notaryDateToFilter) {
        ReportByUserDateFilter reportByUserDateFilter = new ReportByUserDateFilter();
        reportByUserDateFilter.setNotary_office_name(notaryOfficeName);
        reportByUserDateFilter.setEntry_user_name(entryUserName);
        reportByUserDateFilter.setNotaryDateFromFilter(notaryDateFromFilter);
        reportByUserDateFilter.setNotaryDateToFilter(notaryDateToFilter);
        int offset = Constants.ROW_PER_PAGE * (page - 1);

        String s1 = "?numOffset=" + offset;
        String s2 = "&numLimit=" + Constants.ROW_PER_PAGE;
        ////System.out.println(s1);
        ////System.out.println(s2);
        List<TransactionProperty> result = STPAPIUtil.getTransactionPropertyList(token,Constants.STP_API_LINK + "/transaction/selectReportByUser" + s1 + s2, reportByUserDateFilter.generateJsonObject().toString());
        return result;
    }

    public static List<TransactionProperty> getContractCertify(String token,String contractKind, String notaryDateFromFilter, String notaryDateToFilter) {
        NotaryDateFilter notaryDateFilter = new NotaryDateFilter();
        notaryDateFilter.setNotaryDateToFilter(notaryDateToFilter);
        notaryDateFilter.setNotaryDateFromFilter(notaryDateFromFilter);

        String s1 = "?contractKind=" + contractKind;
        List<TransactionProperty> result = STPAPIUtil.getTransactionPropertyList(token,Constants.STP_API_LINK + "/transaction/selectContractCertify" + s1, notaryDateFilter.generateJsonObject().toString());
        return result;
    }

    public static List<Bank> getBank(int page, String titleFilter) {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (offset < 0) offset = 0;
        String filter = titleFilter + " limit " + offset + "," + Constants.ROW_PER_PAGE;
        ////System.out.println(filter);
        List<Bank> result = APIUtil.getBankList(Constants.STP_API_LINK + "/bank/selectBank", filter);
        return result;
    }

    public static Integer countBank(String token,String titleFilter) {
        Integer result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/bank/countBank", titleFilter);
        return result;
    }

    public static List<Manual> getManual(int page, String advanceSearchFilter) {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        String filter = advanceSearchFilter + paggingQuery;
        ////System.out.println("stringFilter "+ advanceSearchFilter);
        List<Manual> result = APIUtil.getManual(Constants.STP_API_LINK + "/manual/findManualByFilter", filter);
        return result;
    }

    public static int countTotalManual(String token,int page, String advanceSearchFilter) {
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String filter = advanceSearchFilter;

        Integer result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/manual/countTotalByFilter", filter);
        return result;
    }

    public static Boolean updateManual(String token,String data) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/manual/updateManual", data);
        return result;
    }

    public static Boolean addUnitRequest(String token,String data) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/UnitRequest/addUnit", data);
        return result;
    }

    public static List<UnitRequest> getUnitRequest(int page, String advanceSearchFilter) {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        String filter = advanceSearchFilter + paggingQuery;
        List<UnitRequest> result = APIUtil.getUnitRequest(Constants.STP_API_LINK + "/UnitRequest/selectUnitRequest", filter);
        return result;
    }

    public static int countTotalUnitRequest(String token,int page, String advanceSearchFilter) {
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String filter = advanceSearchFilter;

        Integer result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/UnitRequest/countTotal", filter);
        return result;
    }

    public static Boolean updateUnitRequest(String token,String data) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/UnitRequest/updateUnit", data);
        return result;
    }
     /*
    * author minhbq
    * date 3/4/2017
    * Danh sách văn phòng công chứng
    * */

    public static List<NotaryOffice> getNotaryOffice(String advanceSearchFilter) {

        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String filter = advanceSearchFilter;
        List<NotaryOffice> result = APIUtil.getNotaryOffice(Constants.STP_API_LINK + "/notaryoffice/selectByFilter", " where office_type = 2");
        return result;
    }

    public static List<NotaryOffice> getAllNotaryOffice() {
        List<NotaryOffice> result = APIUtil.getNotaryOffice(Constants.STP_API_LINK + "/notaryoffice/selectByFilter", " where 1=1 ");
        return result;
    }

    public static List<User> getUser(String token,String filter) {
        List<User> result = STPAPIUtil.getUserByFilter(token,Constants.STP_API_LINK + "/users/selectByFilter", "where 1=1");
        return result;
    }

    public static List<Announcement> getAnnouncementInternalList(int page, String advanceSearchFilter) {

        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (advanceSearchFilter == null || advanceSearchFilter.equals(""))
            advanceSearchFilter = " where announcement_type = 0 ";
/*
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
*/
        String filter = advanceSearchFilter;
        List<Announcement> result = APIUtil.getAnnouncementList(Constants.STP_API_LINK + "/announcement/findAnnouncementByFilter", filter);
        return result;
    }

    /* COUNT DANH SACH THONG BAO */
    public static int countTotalInternalAnnouncement(String token,int page, String advanceSearchFilter) {

        if (advanceSearchFilter == null || advanceSearchFilter.equals(""))
            advanceSearchFilter = " where announcement_type = 0";
        String filter = advanceSearchFilter;

        int result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/announcement/countTotalByFilter", filter);
        return result;
    }

    public static List<Announcement> getAnnouncementPublicList(int page, String advanceSearchFilter) {

        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (advanceSearchFilter == null || advanceSearchFilter.equals(""))
            advanceSearchFilter = " where announcement_type = 1 OR announcement_type = 2 ";
/*
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
*/
        String filter = advanceSearchFilter;
        List<Announcement> result = APIUtil.getAnnouncementList(Constants.STP_API_LINK + "/announcement/findAnnouncementByFilter", filter);
        return result;
    }

    public static int countTotalAccessHistory(String token,int page, String advanceSearchFilter) {
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String filter = advanceSearchFilter;


        Integer result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/systemmanager/countTotal", filter);
        return result;
    }

    /*
  * author minhbq
  * date 3/23/2017
  * lich su truy cap he thong
  * */
    public static List<AccessHistory> getAccesHistory(int page, String advanceSearchFilter) {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (offset < 0) offset = 0;
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        String filter = advanceSearchFilter + paggingQuery;
        ////System.out.println("Query vao "+ filter);
        List<AccessHistory> result = APIUtil.getAccessHistory(Constants.STP_API_LINK + "/systemmanager/selectAccessHistoryByFilter", filter);
        return result;
    }

    /*
  * author MANHTV
  * date 3/23/2017
  * lich su truy cap he thong
  * */
    public static Boolean setAccesHistory(String token,AccessHistory accessHistory) {
        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/systemmanager/setAccessHistory", accessHistory.generateUpdateJson());
        return result;
    }

    /*
  * author minhbq
  * date 4/19/2017
  * Get All Province
  * */
    public static List<ProvinceList> getAllProvince() {
        String filter = " where 1=1 ";
        List<ProvinceList> result = APIUtil.getProvinceList(Constants.STP_API_LINK + "/province/findProvinceFilter", filter);
        return result;
    }

    public static int countTotalNotaryOffice(String token,int page, String advanceSearchFilter) {
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String filter = advanceSearchFilter;

        Integer result = STPAPIUtil.countTotalList(token,Constants.STP_API_LINK + "/notaryoffice/countTotalNotaryOffice", filter);
        return result;
    }

    public static List<NotaryOffice> getNotaryOffice(int page, String advanceSearchFilter) {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        String filter = advanceSearchFilter + paggingQuery;
        List<NotaryOffice> result = APIUtil.getNotaryOffice(Constants.STP_API_LINK + "/notaryoffice/selectByFilter", filter);
        return result;
    }

    /*
  * author minhbq
   * date 5/15/2017
  * Get Announcement From Stp
  * */
    public static AnnouncementFromStpWrapper getAnnouncementFromStpWrapper(String token,int page, String advanceSearchFilter) throws KeyManagementException, NoSuchAlgorithmException {
        int offset = Constants.ROW_PER_PAGE * (page - 1);
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String paggingQuery = " LIMIT " + offset + ", " + Constants.ROW_PER_PAGE;
        String filter = advanceSearchFilter + paggingQuery;
        AnnouncementFromStpWrapper result = STPAPIUtil.getAnnouncementFromStpWrapper(token,Constants.STP_API_LINK + "/announcement/selectAnnouncementFromStp", filter);

        return result;
    }

    public static AnnouncementFromStpWrapper getAnnouncementFromStpWrapperHomePage(String token) throws KeyManagementException, NoSuchAlgorithmException {
        String filter = " where nar.authentication_id = '" + CommonContext.authentication_id + "' order by send_date_time desc limit 3  ";
        AnnouncementFromStpWrapper result = STPAPIUtil.getAnnouncementFromStpWrapper(token,Constants.STP_API_LINK + "/announcement/selectAnnouncementFromStp", filter);
        return result;
    }

    public static int countTotalAnnouncementFromStp(String token,int page, String advanceSearchFilter) {
        if (advanceSearchFilter == null || advanceSearchFilter.equals("")) advanceSearchFilter = " where 1=1";
        String filter = advanceSearchFilter;
        Integer result = STPAPIUtil.countTotalList(token,Constants.VPCC_API_LINK + "/systemmanager/countTotal", filter);
        return result;
    }

    public static PreventContractList getPreventContractList(String token,String data) {
            PreventContractList result = STPAPIUtil.getPreventContractList(token,Constants.STP_API_LINK + "/search/transaction", data);
        return result;
    }

    public static List<SynchonizeContractKey> synchronizeContract(String token,String data) {
        List<SynchonizeContractKey> result = STPAPIUtil.synchronizeContract(token,Constants.STP_API_LINK + "/transaction/synchronizeContract", data);
        return result;
    }

    public static List<AnnouncementFromStp> getAnnouncementPopupFromSTP(String token,String advanceSearchFilter) {
        List<AnnouncementFromStp> result = STPAPIUtil.announcementFromSTPList(token,Constants.STP_API_LINK + "/announcement/selectPopupAnnouncementFromSTP", advanceSearchFilter);
        return result;
    }

    public static Boolean synchronizeNotaryNumber(String token,String filter) {

        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/notaryoffice/synchronizeNotaryNumber", filter);
        return result;
    }
    public static void downloadAnnouncementSTP(Long aid, int index) {


        APIUtil.downloadAnnouncementSTP(Constants.STP_API_LINK + "/announcement/download-from-stp-api/"+aid+"/"+index);

    }
    public static void addSuggestPrivyAll(String token,String filter) {

        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/contract/addSuggestPrivyAll", filter);

    }
    public static void addSuggestPrivyAllOnline(String token,String filter) {

        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/contract/addSuggestPrivyAllOnline", filter);

    }
    public static void addSuggestPropertyAll(String token,String filter) {

        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/contract/addSuggestPropertyAll", filter);

    }
    public static void addSuggestPropertyAllOnline(String token,String filter) {

        Boolean result = STPAPIUtil.callAPIResult(token,Constants.STP_API_LINK + "/contract/addSuggestPropertyAllOnline", filter);

    }

    public static String authenticationSTP(String data) {

        String result = APIUtil.callAPIGetAuthen(Constants.STP_API_LINK+"/authenticate", data);
        return result;
    }
}
