package cn.edu.huat.oa.controller;

import cn.edu.huat.oa.common.CodeCaptchaServlet;
import cn.edu.huat.oa.common.Contant;
import cn.edu.huat.oa.common.MD5Util;
import cn.edu.huat.oa.common.Result;
import cn.edu.huat.oa.entity.InformRecord;
import cn.edu.huat.oa.service.EmployeeBiz;
import cn.edu.huat.oa.service.GlobalBiz;
import cn.edu.huat.oa.entity.Employee;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("globalController")
public class GloablController {
    @Autowired
    private GlobalBiz globalBiz;

    @Autowired
    private EmployeeBiz employeeBiz;

    @Autowired
    private InformBiz informBiz;

    @Autowired
    private InformRecordBiz informRecordBiz;

    @RequestMapping("/to_login")
    public String toLogin(){
        return "login";
    }

    @RequestMapping("/login")
    public String login(Model model,
                        HttpSession session,
                        @RequestParam String sn,
                        @RequestParam String password){
        password = MD5Util.encodeToHex(Contant.SALT+password);
        Employee employee = globalBiz.login(sn,password);
        if (employee == null) {
            model.addAttribute("error","您的用户名或密码错误!");
            return "login";
        }
        session.setAttribute("employee",employee);
        return "redirect:self";
    }
    @RequestMapping("/self")
    public String self(HttpSession session, Map<String,Object> map){
        Employee employee = (Employee) session.getAttribute("employee");
        map.put("employee",employeeBiz.get(employee.getSn()));
        return  "self";
    }

    @RequestMapping("/list")
    public String list(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                       HttpSession session,
                       Map<String,Object> map){

        Employee emp = (Employee) session.getAttribute("employee");
        PageHelper.startPage(pn, 5);
        PageInfo page = new PageInfo(informBiz.getByDsn(emp.getDepartmentSn()), 5);

        List<InformRecord> records = informRecordBiz.getBySn(emp.getSn());

        map.put("pageInfo",page);
        map.put("records", records);

        return "list";
    }

    @RequestMapping("/to_read")
    public String toRead(int id, Model model,HttpSession session){
        //根据通知id和用户编号查看是否已经有阅读记录
        Employee emp = (Employee) session.getAttribute("employee");
        InformRecord record = informRecordBiz.getByInformIdAndReadSn(id, emp.getSn());
        //如果阅读记录为空则新建一条阅读记录
        if (record==null) {
            record = new InformRecord();
        }
        record.setInformId(id);
        record.setInform(informBiz.get(id));
        model.addAttribute("informRecord", record);
        return "read";
    }

    @RequestMapping("/read")
    public String read(HttpSession session, InformRecord informRecord) {
        Employee emp = (Employee) session.getAttribute("employee");
        informRecord.setReadSn(emp.getSn());
        informRecordBiz.add(informRecord);
        return "redirect:list";
    }

    @RequestMapping("/logout")
    public String quit(HttpSession session){
        session.setAttribute("employee",null);
        return "redirect:to_login";
    }

    @RequestMapping("/to_change_password")
    public String toChangePassword(){
        return "change_password";
    }

    @RequestMapping("/change_password")
    public String changePassword(HttpSession session, @RequestParam String old, @RequestParam String new1 ,@RequestParam String new2){
        Employee employee = (Employee)session.getAttribute("employee");
        old= MD5Util.encodeToHex(Contant.SALT+old);
        if(employee.getPassword().equals(old)){
            if (new1 != null && !"".equals(new1) && new1.equals(new2)) {
                employee.setPassword(MD5Util.encodeToHex(Contant.SALT+new1));
                globalBiz.changePassword(employee);
                session.setAttribute("employee",null);
                return "redirect:to_login";
            }
        }
        return "redirect:to_change_password";
    }

    /**
     * 判断验证码是否正确
     *
     * @param model
     * @param code
     * @return
     */
    @RequestMapping("/login_checkCode")
    @ResponseBody
    public Map<String, Object> checkCode(HttpServletRequest request, Model model, @RequestParam(value = "code", required = false) String code) {
        Map map = new HashMap<String, Object>();
        String vcode = (String) request.getSession().getAttribute(CodeCaptchaServlet.VERCODE_KEY);

        if (code.equals(vcode)) {
            //验证码正确
            map.put("message", "success");
        } else {
            //验证码错误
            map.put("message", "fail");
        }

        return map;
    }

    /**
     * 检查原始密码是否正确
     * @param old
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkOldPassword")
    public Result checkSn(HttpSession session, @RequestParam("old") String old){
        Employee employee = (Employee)session.getAttribute("employee");
        old= MD5Util.encodeToHex(Contant.SALT+old);
        if(employee.getPassword().equals(old)){
            return Result.success();
        } else {
            return Result.fail().add("va_msg", "原始密码错误");
        }
    }

}
