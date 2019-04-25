package cn.edu.huat.oa.service.impl;

import cn.edu.huat.oa.dao.InformDao;
import cn.edu.huat.oa.entity.Inform;
import cn.edu.huat.oa.service.InformBiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service("informBiz")
public class InformBizImpl implements InformBiz {
    @Autowired
    private InformDao informDao;

    @Override
    public Inform get(int id) {
        return informDao.select(id);
    }

    @Override
    public List<Inform> getBySn(String sn) {
        return informDao.selectBySn(sn);
    }

    @Override
    public List<Inform> getByDsn(String dsn) {
        return informDao.selectByDsn(dsn);
    }

    @Override
    public List<Inform> getBySnAndText(String sn, String text) {
        return informDao.selectBySnAndText(sn,text);
    }

    @Override
    public void removeBatch(int[] ids) {
        informDao.deleteBatch(ids);
    }

    @Override
    public void remove(int id) {
        informDao.delete(id);
    }

    @Override
    public void add(Inform inform) {
        inform.setCreateSn(inform.getCreater().getSn());
        inform.setReceiveDsn(inform.getCreater().getDepartmentSn());
        inform.setCreateTime(new Date());
        informDao.insert(inform);
    }

    @Override
    public void edit(Inform inform) {
        inform.setCreateTime(new Date());
        informDao.update(inform);
    }
}
