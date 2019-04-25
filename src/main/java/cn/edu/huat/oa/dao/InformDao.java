package cn.edu.huat.oa.dao;

import cn.edu.huat.oa.entity.Inform;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("informDao")
public interface InformDao {
    void insert(Inform inform);
    void delete(int id);
    void deleteBatch(int[] ids);
    void update(Inform inform);
    Inform select(int id);

    List<Inform> selectBySn(String sn);
    List<Inform> selectBySnAndText(@Param("sn") String sn, @Param("text") String text);
    List<Inform> selectByDsn(String dsn);

}
