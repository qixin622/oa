package cn.edu.huat.oa.service;

import cn.edu.huat.oa.entity.Inform;

import java.util.List;

public interface InformBiz {

    Inform get(int id);
    List<Inform> getBySn(String sn);
    List<Inform> getByDsn(String dsn);
    List<Inform> getBySnAndText(String sn,String text);


    void removeBatch(int[] ids);

    void remove(int id);

    void add(Inform inform);

    void edit(Inform inform);
}
