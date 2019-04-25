package cn.edu.huat.oa.service.impl;

import cn.edu.huat.oa.dao.InformRecordDao;
import cn.edu.huat.oa.entity.InformRecord;
import cn.edu.huat.oa.service.InformRecordBiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service("informRecordBiz")
public class InformRecordBizImpl implements InformRecordBiz {
    @Autowired
    private InformRecordDao informRecordDao;

    @Override
    public void add(InformRecord record) {
        record.setReadTime(new Date());
        informRecordDao.insert(record);
    }

    @Override
    public InformRecord getByInformIdAndReadSn(int id, String sn) {
        return informRecordDao.selectByInformIdAndReadSn(id, sn);
    }

    @Override
    public List<InformRecord> getByInformId(int id) {
        return informRecordDao.selectByInformId(id);
    }

    @Override
    public List<InformRecord> getBySn(String sn) {
        return informRecordDao.selectBySn(sn);
    }

}
