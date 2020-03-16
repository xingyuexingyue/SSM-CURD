package com.sangyu.controller;

/**
 * 处理员工CRUD请求
 * User: pengyapan
 * Date: 2020/3/16
 * Time: 下午6:37
 */

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sangyu.bean.Employee;
import com.sangyu.bean.Msg;
import com.sangyu.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class EmployeeController {


    @Autowired
    EmployeeService employeeService;

    /**
     * @ResponseBody 正常工作需要导jackson包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps, 5);
        System.out.println(page);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 员工保存
     * 1、支持JSR303
     * 2、导入Hibernate-Validator
     * @return
     */
    @RequestMapping(value="/emp",method= RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            // 校验失败，应该返回失败，在状态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors){
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误信息： " + fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }


    }

    /**
     * 检查用户名是否可用
     * @param name
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(@RequestParam("name") String name){
        // 先判断用户名的格式是否合法的
        System.out.println(name);
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        System.out.println(name.matches(regx));
        if(!name.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }

        // 数据库用户名重复校验
        boolean b = employeeService.checkUser(name);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名重复");
        }
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @RequestMapping(value="/emp/{id}",method = RequestMethod.GET )
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 如果直接发送ajax=PUT形式的请求
     * 会发现的问题：请求体中有数据，但是Employee对象封装不上，导致employee中除了id其他都为null
     * 原因：Tomcat：将请求体中的数据，封装一个map，通过request.getParameter("empName")从map中取值，
     * 当SpringMVC封装POJO对象的时候，会把每个POJO中的属性的值，通过这种方式从map中取出
     * 如果AJAX发送PUT请求时， Tomcat一看是PUT类型就不会封装请求体中的数据，所以request.getParameter("empName")拿不到
     * 只有POST类型的请求才封装请求体为map
     *
     * 如果要支持发送PUT之类的请求还要封装请求体中的数据
     * 1、 配置FormContentFilter
     * 2、它的作用是将请求中数据解析包装成一个map
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取出来
     *
     * 更新员工
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
    public Msg savaEmp( Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据员工Id删除
     * 支持多个和单个删除
     * 批量删除1-2-3
     * 单个删除1
     *
     */
    @ResponseBody
    @RequestMapping(value="/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for(String id:str_ids){
                del_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
}

