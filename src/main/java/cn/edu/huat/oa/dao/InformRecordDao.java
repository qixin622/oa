package cn.edu.huat.oa.dao;

import cn.edu.huat.oa.entity.InformRecord;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("informRecordDao")
public interface InformRecordDao {
    void insert(InformRecord record);

    //查看指定通知编号和职工编号的查看记录
    InformRecord selectByInformIdAndReadSn(@Param("id") int id, @Param("sn") String sn);
    //查看某个通知的查看记录
    List<InformRecord> selectByInformId(int id);
    //查看某个职工已查看通知的记录
    List<InformRecord> selectBySn(String sn);


}
