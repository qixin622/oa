package cn.edu.huat.oa.controller;

import cn.edu.huat.oa.common.Contant;
import cn.edu.huat.oa.common.Result;
import cn.edu.huat.oa.dto.InformInfo;
import cn.edu.huat.oa.entity.Employee;
import cn.edu.huat.oa.entity.Inform;
import cn.edu.huat.oa.service.DepartmentBiz;
import cn.edu.huat.oa.service.EmployeeBiz;
import cn.edu.huat.oa.service.InformBiz;
import cn.edu.huat.oa.service.InformRecordBiz;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller("informController")
@RequestMapping("/inform")
public class InformController {

    @Autowired
    private InformBiz informBiz;

    @Autowired
    private InformRecordBiz informRecordBiz;

    @RequestMapping("/list")
    public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                       @RequestParam(value = "searchText", required = false) String searchText,
                       HttpSession session,
                       Map<String,Object> map){

        Employee creater = (Employee) session.getAttribute("employee");
        PageHelper.startPage(pn, 5);

        if(searchText!=null){
            PageInfo page = new PageInfo(informBiz.getBySnAndText(creater.getSn(),searchText), 5);
            map.put("pageInfo",page);
            map.put("text",searchText);
        } else {
            PageInfo page = new PageInfo(informBiz.getBySn(creater.getSn()), 5);
            map.put("pageInfo",page);
        }

        return "inform_list";
    }

    @RequestMapping("/detail")
    public String detail(@RequestParam("id") int id, Model model) {
        InformInfo informInfo = new InformInfo();
        informInfo.setInform(informBiz.get(id));
        informInfo.setInformRecords(informRecordBiz.getByInformId(id));
        model.addAttribute("informInfo", informInfo);
        return "inform_detail";
    }

    @RequestMapping("/to_add")
    public String toAdd(Map<String,Object> map){
        map.put("inform",new Inform());
        return "inform_add";
    }

    @RequestMapping("/add")
    public String add(HttpSession session, Inform inform){
        Employee creater = (Employee) session.getAttribute("employee");
        inform.setCreater(creater);
        informBiz.add(inform);
        return "redirect:list";
    }

    @RequestMapping(value = "/to_update",params = "id")
    public String toUpdate(int id,Map<String,Object> map){
        map.put("inform",informBiz.get(id));
        return "inform_update";
    }

    @RequestMapping("/update")
    public String update(Inform inform){
        informBiz.edit(inform);
        return "redirect:list";
    }

    @RequestMapping(value = "/remove",params = "id")
    public String remove(String id){
        if(id.contains(",")){
            String[] del_ids = id.split(",");
            int[] ids = new int[del_ids.length];
            for (int i=0;i<del_ids.length;i++) {
               ids[i]=Integer.parseInt(del_ids[i]);
            }
            informBiz.removeBatch(ids);
        } else {
            informBiz.remove(Integer.parseInt(id));
        }
        return "redirect:list";
    }

}
