package cn.edu.huat.oa.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Inform {

    private Integer id;
    private String createSn;
    private String receiveDsn;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date createTime;
    private String informContent;

    private Employee creater;
    private Department department;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCreateSn() {
        return createSn;
    }

    public void setCreateSn(String createSn) {
        this.createSn = createSn;
    }

    public String getReceiveDsn() {
        return receiveDsn;
    }

    public void setReceiveDsn(String receiveDsn) {
        this.receiveDsn = receiveDsn;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getInformContent() {
        return informContent;
    }

    public void setInformContent(String informContent) {
        this.informContent = informContent;
    }

    public Employee getCreater() {
        return creater;
    }

    public void setCreater(Employee creater) {
        this.creater = creater;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}
