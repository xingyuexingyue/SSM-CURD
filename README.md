
## 关于CRUD功能涉及到的技术点包括

后端 spring+springmvc+mybaits

前端 boostrap

数据库 MySQL

## 其他细节相关

使用boostrap快速搭建前端页面、使用mybatis逆向工程、使用Rest风格的URI、使用@ResponseBody注解返回前端JSON数据、前端使用ajax发送请求，jQuery前端校验、JSR303后端校验、log4j12日志记录

## 涉及到的表结构 

tbl_emp（员工表）（tbl_emp的d_id关联tbl_dept的dept_id）

tbl_dept（部门表）

建表SQL

```
create database my_ssm_crud;

create table `tbl_emp`( 
`emp_id` int(10) auto_increment, 
`emp_name` varchar(255) NOT NULL, 
`gender` char(1) NOT NULL, 
`email` varchar(255) NOT NULL, 
`d_id` int(11) NOT NULL, 
PRIMARY KEY ( `emp_id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

```
create table `tbl_dept`(
`dept_id` int(10) auto_increment, 
`dept_name` varchar(255) NOT NULL, 
PRIMARY KEY ( `dept_id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

## CRUD的功能点包括

1、员工列表的展示

2、员工编辑

3、员工单个/批量删除

4、员工添加

5、分页条，分页信息
 
## REST的URI

/emp/{id} GET 查询员工

/emp POST 保存员工

/emp/{id} PUT 修改员工

/emp/{id} DELETE删除员工

## 完成后的页面展示

![](https://upload-images.jianshu.io/upload_images/2765653-3c3a78c9f43a1a18.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

