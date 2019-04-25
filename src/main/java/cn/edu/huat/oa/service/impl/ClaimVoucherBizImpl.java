package cn.edu.huat.oa.service.impl;


import cn.edu.huat.oa.service.ClaimVoucherBiz;
import cn.edu.huat.oa.dao.ClaimVoucherDao;
import cn.edu.huat.oa.dao.ClaimVoucherItemDao;
import cn.edu.huat.oa.dao.DealRecordDao;
import cn.edu.huat.oa.dao.EmployeeDao;
import cn.edu.huat.oa.entity.ClaimVoucher;
import cn.edu.huat.oa.entity.ClaimVoucherItem;
import cn.edu.huat.oa.entity.DealRecord;
import cn.edu.huat.oa.entity.Employee;
import cn.edu.huat.oa.common.Contant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Random;

@Service("claimVoucherBiz")
public class ClaimVoucherBizImpl implements ClaimVoucherBiz {
    @Autowired
    private ClaimVoucherDao claimVoucherDao;
    @Autowired
    private ClaimVoucherItemDao claimVoucherItemDao;
    @Autowired
    private DealRecordDao dealRecordDao;
    @Autowired
    private EmployeeDao employeeDao;

    public void save(ClaimVoucher claimVoucher, List<ClaimVoucherItem> items) {
        claimVoucher.setCreateTime(new Date());
        claimVoucher.setNextDealSn(claimVoucher.getCreateSn());
        claimVoucher.setStatus(Contant.CLAIMVOUCHER_CREATED);
        claimVoucherDao.insert(claimVoucher);

        for(ClaimVoucherItem item:items){
            item.setClaimVoucherId(claimVoucher.getId());
            claimVoucherItemDao.insert(item);
        }
    }

    public ClaimVoucher get(int id) {
        return claimVoucherDao.select(id);
    }

    public List<ClaimVoucherItem> getItems(int cvid) {
        return claimVoucherItemDao.selectByClaimVoucher(cvid);
    }

    public List<DealRecord> getRecords(int cvid) {
        return dealRecordDao.selectByClaimVoucher(cvid);
    }

    public List<ClaimVoucher> getForSelf(String sn) {
        return claimVoucherDao.selectByCreateSn(sn);
    }

    public List<ClaimVoucher> getForDeal(String sn) {
        return claimVoucherDao.selectByNextDealSn(sn);
    }

    public void update(ClaimVoucher claimVoucher, List<ClaimVoucherItem> items) {
        claimVoucher.setNextDealSn(claimVoucher.getCreateSn());
        claimVoucher.setStatus(Contant.CLAIMVOUCHER_CREATED);
        claimVoucherDao.update(claimVoucher);

        List<ClaimVoucherItem> olds = claimVoucherItemDao.selectByClaimVoucher(claimVoucher.getId());
        for(ClaimVoucherItem old:olds){
            boolean isHave=false;
            for(ClaimVoucherItem item:items){
                if(item.getId()==old.getId()){
                    isHave=true;
                    break;
                }
            }
            if(!isHave){
                claimVoucherItemDao.delete(old.getId());
            }
        }
        for(ClaimVoucherItem item:items){
            item.setClaimVoucherId(claimVoucher.getId());
            if(item.getId()!=null && item.getId()>0){
                claimVoucherItemDao.update(item);
            }else{
                claimVoucherItemDao.insert(item);
            }
        }

    }

    public void submit(int id) {
        //待处理报销单
        ClaimVoucher claimVoucher = claimVoucherDao.select(id);
        //报销单创建人
        Employee creater = employeeDao.select(claimVoucher.getCreateSn());

        claimVoucher.setStatus(Contant.CLAIMVOUCHER_SUBMIT);
        //如果报销人是校长，则直接提交财务处长审核
        if (creater.getPost().equals(Contant.POST_GM)) {
            List<Employee> cashiers = employeeDao.selectByPost(Contant.POST_CASHIER);
            claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(cashiers.get(0).getDepartmentSn(),Contant.POST_AM).get(0).getSn());
        }else if(creater.getPost().equals(Contant.POST_FM) || creater.getPost().equals(Contant.POST_AM)){
            claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(null,Contant.POST_GM).get(0).getSn());
        } else if(creater.getPost().equals(Contant.POST_TEACHER)) {
            claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(creater.getDepartmentSn(),Contant.POST_FM).get(0).getSn());
        } else if(creater.getPost().equals(Contant.POST_STAFF)) {
            claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(creater.getDepartmentSn(),Contant.POST_AM).get(0).getSn());
        } else if(creater.getPost().equals(Contant.POST_CASHIER)) {
            claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(creater.getDepartmentSn(),Contant.POST_AM).get(0).getSn());
        }

        claimVoucherDao.update(claimVoucher);

        DealRecord dealRecord = new DealRecord();
        dealRecord.setDealWay(Contant.DEAL_SUBMIT);
        dealRecord.setDealSn(creater.getSn());
        dealRecord.setClaimVoucherId(id);
        dealRecord.setDealResult(Contant.CLAIMVOUCHER_SUBMIT);
        dealRecord.setDealTime(new Date());
        dealRecord.setComment("无");
        dealRecordDao.insert(dealRecord);
    }

    public void deal(DealRecord dealRecord) {
        ClaimVoucher claimVoucher = claimVoucherDao.select(dealRecord.getClaimVoucherId());
        Employee dealer = employeeDao.select(dealRecord.getDealSn());
        Employee creater = employeeDao.select(claimVoucher.getCreateSn());
        dealRecord.setDealTime(new Date());


        if(dealRecord.getDealWay().equals(Contant.DEAL_PASS)){//如果处理方式为通过
            if(claimVoucher.getTotalAmount()<=Contant.LIMIT_CHECK || dealer.getPost().equals(Contant.POST_GM)){
                //如果报销总金额小于审核上限或者处理人为校长，则审核通过
                claimVoucher.setStatus(Contant.CLAIMVOUCHER_APPROVED);

                //审核通过则由会计中的任意一人来处理,如果报销单创建人是会计职务，则不能由自己来处理
                List<Employee> cashiers = employeeDao.selectByDepartmentAndPost(null,Contant.POST_CASHIER);
                if(creater.getPost().equals(Contant.POST_CASHIER)){
                    cashiers.remove(creater);
                }
                Random random = new Random();
                claimVoucher.setNextDealSn(cashiers.get(random.nextInt(cashiers.size())).getSn());

                dealRecord.setDealResult(Contant.CLAIMVOUCHER_APPROVED);
            }else{
                claimVoucher.setStatus(Contant.CLAIMVOUCHER_RECHECK);
                claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(null,Contant.POST_GM).get(0).getSn());

                dealRecord.setDealResult(Contant.CLAIMVOUCHER_RECHECK);
            }
        }else if(dealRecord.getDealWay().equals(Contant.DEAL_BACK)){//如果处理方式为打回
            claimVoucher.setStatus(Contant.CLAIMVOUCHER_BACK);
            claimVoucher.setNextDealSn(claimVoucher.getCreateSn());

            dealRecord.setDealResult(Contant.CLAIMVOUCHER_BACK);
        }else if(dealRecord.getDealWay().equals(Contant.DEAL_REJECT)){//如果处理方式为拒绝
            claimVoucher.setStatus(Contant.CLAIMVOUCHER_TERMINATED);
            claimVoucher.setNextDealSn(null);

            dealRecord.setDealResult(Contant.CLAIMVOUCHER_TERMINATED);
        }else if(dealRecord.getDealWay().equals(Contant.DEAL_PAID)){//如果处理方式为打款
            claimVoucher.setStatus(Contant.CLAIMVOUCHER_PAID);
            claimVoucher.setNextDealSn(null);

            dealRecord.setDealResult(Contant.CLAIMVOUCHER_PAID);
        }

        claimVoucherDao.update(claimVoucher);
        dealRecordDao.insert(dealRecord);
    }

}
