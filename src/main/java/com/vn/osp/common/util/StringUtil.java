package com.vn.osp.common.util;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {

    public static String removeSpecialCharactersNotSpace(String value) {
        String ALPHANUMERIC = "[^\\p{L}\\p{N} ]+";
        try {
            return value.replaceAll(ALPHANUMERIC, "");
        } catch (Exception var2) {
            return null;
        }
    }
    public static String removeSpecialCharactersNotHTML(String value) {
        String ALPHANUMERIC = "[^\\p{L}\\p{N} ~`!@#$%^&*()_=+{}<>\"/;=&:\\-\\[\\]\t\\\\°C≥≤≡≠×÷±→?.,|«©®£¨»½¼¾ǂʼʾʿˀˁ˅ΣΞΘΔθπФ‰†‡⅓⅔⅕⅖⅗⅘⅙⅚⅛⅜⅝⅞⅟―Γʽ←↑→↓↔↕←↑→↓↔↕↖↗↘↙↚↛↜↝↞↟↠↡↢↣↤↥↦↧↨↩↪↫↬↭↮↯↰↱↲↳↴↵↶↷↸↹↺↻↼↽↾↿⇀⇁⇂⇃⇄⇅⇆⇇⇈⇉⇊⇋⇌⇍⇎⇏⇐⇑⇒⇓⇔⇕⇖⇗⇘⇙⇚⇛⇜⇝⇞⇟⇠⇡⇢⇣⇤⇥⇦⇧⇨⇩⇪⇫⇬⇭⇮⇯⇰⇱⇲⇳⇴⇵⇶⇷⇸⇹⇺⇻⇼⇽⇾⇿∀∁∂∃∄∅∆∇∈∉∊∋∌∍∎∏∐∑−∓∔∕∖∗∘∙√∛∜∝∞∟∠∡∢∣∤∥∦∧∨∩∪∫∬∭∮∯∰∱∲∳∴∵∶∷∸∹∺∻∼∽∾∿≀≁≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊌⊍⊎⊏⊐⊑⊒⊓⊔⊕⊖⊗⊘⊙⊚⊛⊜⊝⊞⊟⊠⊡⊢⊣⊤⊥⊦⊧⊨⊩⊪⊫⊬⊭⊮⊯⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊺⊻⊼⊽⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈⋉⋊⋋⋌⋍⋎⋏⋐⋑⋒⋓⋔⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋮⋯⋰⋱⋲⋳⋴⋵⋶⋷⋸⋹⋺⋻⋼⋽⋾⋿]+";
        try {
            return value.replaceAll(ALPHANUMERIC, "");
        } catch (Exception var2) {
            return null;
        }
    }
    public static boolean checkSpecialCharacter(String value) {
        String ALPHANUMERIC = "^[\\p{L}\\p{N} ]+";
        try {
            Pattern p = Pattern.compile(ALPHANUMERIC, Pattern.CANON_EQ | Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE);
            Matcher m = p.matcher(value);
            return m.matches();
        } catch (Exception var2) {
            return false;
        }
    }

    //Function escape special char
    public static String escapeSpecialChar(String str){
        /*String testStr = "< > \" &";
        System.out.println("Original : " + testStr);
        System.out.println("Escaped : " + StringEscapeUtils.escapeHtml4(testStr));*/

        //comment tạm thời
/*        if(!StringUtils.isBlank(str)) return StringEscapeUtils.escapeHtml4(str);
        else return str;*/

        return str;
    }
}
