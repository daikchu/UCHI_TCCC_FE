package com.vn.osp.util;

public class RegexUtil {
    public static final String PASSWORD_PATTERN =
            "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,20})";
    public static final String PHONE =
            "^[0-9]{10,15}$";
    public static final String FILE_NAME = "[^-_.A-Za-z0-9]";
}
