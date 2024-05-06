package com.vn.osp.util;

import java.util.Random;

public class Utils {
    public static String randomCode(int length) {
        String result = "";
        try {
            String pattern = "123456789qwertyupasdfghjkzxcvbnm";
            for (int i = 0; i < length; i++) {
                Random rand = new Random();
                int pos = rand.nextInt((31 - 0) + 1) + 0;
                result += pattern.charAt(pos);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }

}
