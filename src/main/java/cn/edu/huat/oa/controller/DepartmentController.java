package cn.edu.huat.oa.controller;

import cn.edu.huat.oa.common.Result;
import cn.edu.huat.oa.service.DepartmentBiz;
import cn.edu.huat.oa.entity.Department;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private DepartmentBiz departmentBiz;

    @RequestMapping("/list")
    public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                       Map<String,Object> map) {
        PageHelper.startPage(pn, 5);
        PageInfo page = new PageInfo(departmentBiz.getAll(), 5);
        map.put("pageInfo", page);
        return "department_list";
    }

    @RequestMapping("/to_add")
    public String toAdd(Map<String,Object> map){
        map.put("department",new Department());
        return "department_add";
    }
    @RequestMapping("/add")
    public String add(Department department){
        departmentBiz.add(department);
        return "redirect:list";
    }


    @RequestMapping(value = "to_update", params = "sn")
    public String toUpdate(String sn, Map<String,Object> map) {
        map.put("department", departmentBiz.get(sn));
        return "department_update";
    }

    @RequestMapping("update")
    public String update(Department department) {
        departmentBiz.edit(department);
        return "redirect:list";
    }

    @RequestMapping(value = "remove", params = "sn")
    public String remove(String sn) {
        if(sn.contains(",")){
            String[] del_sns = sn.split(",");
            departmentBiz.removeBatch(del_sns);
        } else {
            departmentBiz.remove(sn);
        }
        return "redirect:list";
    }

    /**
     * 检查部门编号是否可用
     * @param sn
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkSn")
    public Result checkSn(@RequestParam("sn") String sn){
        //先判断用户名是否是合法的表达式;
        String regx = "(^[0-9]{3}$)";
        if(!sn.matches(regx)){
            return Result.fail().add("va_msg", "部门编号为3位数字");
        }

        //数据库用户名重复校验
        Department dept = departmentBiz.get(sn);
        if(dept!=null){
            return Result.fail().add("va_msg", "部门编号重复");
        }else{
            return Result.success();
        }
    }

}
