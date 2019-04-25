package cn.edu.huat.oa.dto;

import cn.edu.huat.oa.entity.Inform;
import cn.edu.huat.oa.entity.InformRecord;

import java.util.List;

public class InformInfo {

    private Inform inform;
    private List<InformRecord> informRecords;

    public Inform getInform() {
        return inform;
    }

    public void setInform(Inform inform) {
        this.inform = inform;
    }

    public List<InformRecord> getInformRecords() {
        return informRecords;
    }

    public void setInformRecords(List<InformRecord> informRecords) {
        this.informRecords = informRecords;
    }
}
