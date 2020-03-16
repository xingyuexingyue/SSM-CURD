package com.sangyu;

import com.github.pagehelper.PageInfo;
import com.sangyu.bean.Employee;
import com.sangyu.dao.DepartmentMapper;
import com.sangyu.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;
import java.util.UUID;

/**
 * 测试dao层的工作
 * 也可以使用spring的单元测试，可以自动注入我们需要的组件
 * 1. pom导入springTest模块注入
 * 2. 在测试类增加注解@ContextConfiguration("classpath:applicationContext.xml")指定spring配置文件的位置
 * 3. 使用@Runwith(SpringJUnit4ClassRunner.class) 哪个单元测试来运行
 * 4. 这样就可以原生的@Autowired 来注入组件
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, 1, "0", uid + "@atguigu.com"));
        }
        System.out.println("批量完成");
    }

}