package cn.edu.huat.oa.service;

import cn.edu.huat.oa.entity.InformRecord;

import java.util.List;

public interface InformRecordBiz {

    void add(InformRecord record);
    InformRecord getByInformIdAndReadSn(int id,String sn);
    List<InformRecord> getByInformId(int id);
    List<InformRecord> getBySn(String sn);


}
