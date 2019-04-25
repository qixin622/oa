package cn.edu.huat.oa.common;

import java.util.ArrayList;
import java.util.List;

public class Contant {

    public static final String SALT = "salt";

    //职务
    public static final String POST_STAFF="员工";
    public static final String POST_TEACHER="教师";
    public static final String POST_FM="院长";
    public static final String POST_AM="处长";
    public static final String POST_GM="校长";
    public static final String POST_CASHIER="会计";

    //报销单状态
    public static final String CLAIMVOUCHER_CREATED="新创建";
    public static final String CLAIMVOUCHER_SUBMIT="已提交";
    public static final String CLAIMVOUCHER_APPROVED="已审核";
    public static final String CLAIMVOUCHER_BACK="打回";
    public static final String CLAIMVOUCHER_TERMINATED="已终止";
    public static final String CLAIMVOUCHER_RECHECK="待复审";
    public static final String CLAIMVOUCHER_PAID="已打款";

    //审核额度
    public static final double LIMIT_CHECK=5000.00;

    //处理方式
    public static final String DEAL_CREATE="创建";
    public static final String DEAL_SUBMIT="提交";
    public static final String DEAL_UPDATE="修改";
    public static final String DEAL_BACK="打回";
    public static final String DEAL_REJECT="拒绝";
    public static final String DEAL_PASS="通过";
    public static final String DEAL_PAID="打款";

    //职务
    public static List<String> getPosts() {
        List<String> list = new ArrayList<String>();
        list.add(POST_STAFF);
        list.add(POST_TEACHER);
        list.add(POST_FM);
        list.add(POST_AM);
        list.add(POST_GM);
        list.add(POST_CASHIER);
        return list;
    }

    //费用类别
    public static List<String> getItems() {
        List<String> list = new ArrayList<String>();
        list.add("交通");
        list.add("餐饮");
        list.add("住宿");
        list.add("办公");
        list.add("耗材");
        return list;
    }

    //头像
    public static List<String> getImgUrls() {
        List<String> list = new ArrayList<String>();
        for (int i = 1; i <= 7; i++) {
            list.add(i+".jpg");
        }
        return list;
    }

    //报销单状态
    public static List<String> getStatus() {
        List<String> list = new ArrayList<String>();
        list.add(CLAIMVOUCHER_CREATED);
        list.add(CLAIMVOUCHER_SUBMIT);
        list.add(CLAIMVOUCHER_APPROVED);
        list.add(CLAIMVOUCHER_BACK);
        list.add(CLAIMVOUCHER_TERMINATED);
        list.add(CLAIMVOUCHER_RECHECK);
        list.add(CLAIMVOUCHER_PAID);
        return list;
    }

    //最高学历
    public static List<String> getQualification() {
        List<String> list = new ArrayList<String>();
        list.add("博士");
        list.add("硕士");
        list.add("本科");
        list.add("专科");
        list.add("中专");
        return list;
    }

}
