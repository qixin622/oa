package cn.edu.huat.oa.common;

import cn.edu.huat.oa.entity.Employee;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        String url = httpServletRequest.getRequestURI();
        if(url.toLowerCase().indexOf("login")>=0){
            return true;
        }

        HttpSession session = httpServletRequest.getSession();
        Employee employee = (Employee) session.getAttribute("employee");
        if(employee != null){
            String role = employee.getRole();
            //普通用户无法操作基础信息管理模块：包括员工和部门管理
            if(role.equals("0")){
                if(url.toLowerCase().indexOf("employee")>0 || url.toLowerCase().indexOf("department")>0){
                    httpServletResponse.sendRedirect("/self");
                    return false;
                }
            }
            //如是普通员工、教师和会计则无法进行通知管理
            if(employee.getPost().equals(Contant.POST_CASHIER) || employee.getPost().equals(Contant.POST_STAFF) || employee.getPost().equals(Contant.POST_TEACHER)) {
                if(url.toLowerCase().indexOf("inform")>0){
                    httpServletResponse.sendRedirect("/self");
                    return false;
                }
            }
            return true;
        }
        httpServletResponse.sendRedirect("/to_login");
        return false;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
