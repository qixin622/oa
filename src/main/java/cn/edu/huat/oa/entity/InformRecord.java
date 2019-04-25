package cn.edu.huat.oa.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class InformRecord {

    private Integer id;
    private Integer informId;
    private String readSn;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date readTime;
    private Employee reader;
    private Inform inform;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getInformId() {
        return informId;
    }

    public void setInformId(Integer informId) {
        this.informId = informId;
    }

    public String getReadSn() {
        return readSn;
    }

    public void setReadSn(String readSn) {
        this.readSn = readSn;
    }

    public Date getReadTime() {
        return readTime;
    }

    public void setReadTime(Date readTime) {
        this.readTime = readTime;
    }

    public Employee getReader() {
        return reader;
    }

    public void setReader(Employee reader) {
        this.reader = reader;
    }

    public Inform getInform() {
        return inform;
    }

    public void setInform(Inform inform) {
        this.inform = inform;
    }
}
