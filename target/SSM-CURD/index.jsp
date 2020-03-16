<%--
  Created by IntelliJ IDEA.
  User: pengyapan
  Date: 2020/3/16
  Time: 下午4:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>员工列表</title>
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="static/js/jquery-1.12.4.min.js"></script>

    <!-- Bootstrap -->
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--员工修改的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@xx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="gender1_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label for="gender2_add_input" class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept_add_seleect" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4" name="id" id="dept_update_seleect">
                            <select class="form-control" name="deptid">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加模态框 -->
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="empName_add_input"
                                   placeholder="员工姓名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@xx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="gender1_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label for="gender2_add_input" class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept_add_seleect" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4" name="id" id="dept_add_seleect">
                            <select class="form-control" name="deptid">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--搭建显示页面--%>

<div class="container">
    <%-- 标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CURD</h1>

        </div>
    </div>
    <%-- 按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%-- 显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>

<script type="text/javascript">

    //========= 功能一、实现列表数据展示===============

    // 定义两个变量，用来保存数据
    var totalRecord, currentPage;
    // 功能：显示列表信息
    // 1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        to_page(1);
    })

    // 2、定义跳到指定的页码
    function to_page(pn) {
        $.ajax(
            {
                url: "/emps",
                data: "pn=" + pn,
                type: "GET",
                success: function (result) {
                    // 获得返回的数据后，如何处理
                    // 1、解析并显示员工数据
                    build_emps_table(result);
                    // 2、解析并显示分页文字数据
                    build_page_info(result);
                    // 3、解析并显示分页条数据
                    build_page_nav(result);
                }
            }
        )
    }

    // 定义解析并显示员工数据
    function build_emps_table(result) {
        // 找到表格的表格体并清空数据，防止数据重复累计加载
        $("#emps_table tbody").empty();

        // 从请求返回的数据中得到所有数据
        var emps = result.extend.pageInfo.list;

        // 遍历员工数据
        // 绑定显示样式及数据
        $.each(emps, function (index, item) {
            var chackBoxTd = $("<td><input type='checkbox' class = 'check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.id);
            var empNameTd = $("<td></td>").append(item.name);
            var DeptIdTd = $("<td></td>").append(item.department.deptName);
            var GenderTd = $("<td></td>").append(item.gender == 'M' ? '男' : '女');
            var EmailTd = $("<td></td>").append(item.email);
            var editBtn = $("<button></button>")
                .addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append(" 编辑");

            // 为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id", item.id);

            // 删除按钮的样式
            var delBtn = $("<button></button>")
                .addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon glyphicon-trash"))
                .append(" 删除");

            // 为删除按钮添加一个自定义的属性，来表示当前员工id
            delBtn.attr("del-id", item.id);

            // 删除/编辑按钮
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            // append 方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(chackBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(GenderTd)
                .append(EmailTd)
                .append(DeptIdTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");

        });

    }

    // 定义解析并显示分页文字数据
    function build_page_info(result) {
        // 清空分页文字信息左侧的
        $("#page_info_area").empty();
        // 为page_info_area添加样式
        $("#page_info_area").append("当前 "
            + result.extend.pageInfo.pageNum + " 页，共 "
            + result.extend.pageInfo.pages + " 页 , 共 "
            + result.extend.pageInfo.total + " 条记录")
        // 给两个变量赋值，得到总记录数和当前页码数
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    // 定义解析并显示分页数据
    // 1. 显示分页条信息
    // 2. 点击分页要能去下一页
    function build_page_nav(result) {
        // 清空分页条信息
        $("#page_nav_area").empty();
        // 定义样式
        var ul = $("<ul></ul>").addClass("pagination");
        // 构建元素
        // 构建首页和下一页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        // 判断是否包含上一页
        // 如果不包含，则将样式变为不可点
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }

        // 为首页元素添加点击翻页的事件
        firstPageLi.click(function () {
            if (result.extend.pageInfo.hasPreviousPage == false) {
                return;
            }
            to_page(1);
        });

        // 为上一页增加点击翻页的事件
        prePageLi.click(function () {
            if (result.extend.pageInfo.hasPreviousPage == false) {
                return;
            }
            to_page(result.extend.pageInfo.pageNum - 1);
        });

        // 构建末页和下一页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        // 判断是否包下一页
        // 如果不包含，则将样式变为不可点
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }

        // 为下一页增加点击翻页的事件
        nextPageLi.click(function () {
            if (result.extend.pageInfo.hasNextPage == false) {
                return;
            }
            to_page(result.extend.pageInfo.pageNum + 1);
        });

        // 为末页增加点击翻页的事件
        lastPageLi.click(function () {
            if (result.extend.pageInfo.hasNextPage == false) {
                return;
            }
            to_page(result.extend.pageInfo.pages);
        });

        // 添加首页和前一页的样式
        ul.append(firstPageLi).append(prePageLi);

        // 遍历页码，遍历后给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        });

        // 添加下一页和末页的样式
        ul.append(nextPageLi).append(lastPageLi);

        // 把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // ============== 二、添加功能 ===================
    // 点击新增按钮弹出模态框
    $("#em_add_modal_btn").click(function () {
        // 清空新增模态框
        reset_from("#empAddModal form");
        // 发送ajax请求，查出部门信息，显示在下拉课表
        getDepts("#empAddModal select");

        // 弹出模态框
        $("#empAddModal").modal({
            // 定义只有点击关闭按钮才能关闭
            backdrop: "static"
        });
    });

    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var name = this.value;
        $.ajax({
            url: "/checkuser",
            data: "name=" + name,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    $("#emp_save_btn").click(function () {
        // 1. 模态框中填写的表单数据提交给服务器进行保存
        // 2. 先对要提交给服务器的数据进行校验
        // if(!validate_add_form()){
        //     return false;
        // }

        // 2. 校验名字是否可用 是否成功了
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        // 2. 发送ajax请求保存员工
        $.ajax({
            url: "/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                if (result.code == 100) {
                    // 员工保存成功；
                    //1、关闭模态框
                    $("#empAddModal").modal('hide');

                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalRecord);
                } else {
                    // 显示失败信息
                    // console.log(result);
                    // 有哪个字段的错误信息就显示哪个错误信息
                    if (undefined != result.extend.errorFields.email) {
                        // 显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email)
                    }
                    if (undefined != result.extend.errorFields.name) {
                        // 显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.name)

                    }
                }

            }
        });
    });

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    // 校验表单数据
    function validate_add_form() {
        // 拿到要校验的数据，使用正则表达式
        // 校验用户名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }


        // 校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确")
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框。
    $("#emp_add_modal_btn").click(function(){
        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#empAddModal form");
        //s$("")[0].reset();
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    // 查出所有的部门信息并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "/depts",
            type: "GET",
            success: function (result) {
                $("#empAddModal select").empty();
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.id);
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    // ============== 三、编辑功能 ===================
    // 先加载js代码绑定事件，在发送ajax请求
    // 1. 我们是按钮创建之前就绑定了click，所以绑定不上
    // 2. 可以在创建按钮绑定 或者 2）绑定点击，为后来的元素绑定事件live，但jQuery新版本已经去掉了，用on去掉了
    $(document).on("click", ".edit_btn", function () {
        // alert("edit");
        // 0、查询员工信息，并显示员工信息
        getEmp($(this).attr("edit-id"));

        // 1. 查出部门信息， 并显示部门列表
        getDepts("#empUpdateModal select");

        // 2、把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    // 根据getEmp查询用户信息并同步到编辑弹窗中
    function getEmp(id) {
        $.ajax({
            url: "/emp/" + id,
            type: "GET",
            success: function (result) {
                //console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.name);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.deptid]);
            }
        });
    }

    // 点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        // 验证邮箱是否合法
        // 1、校验邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确")
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        // 2、发送ajax请求保存更新的员工数据
        $.ajax({
            url: "/emp/" + $(this).attr("edit-id"),
            // // 使用JQuery的PUT方法
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            // type:"POST",
            // data:$("#empUpdateModal form").serialize()+"&_method=PUT",//调用表单序列化的结果
            success: function (result) {
                // 1、关闭对话框
                $("#empUpdateModal").modal("hide");
                // 2、回到本页面
                to_page(currentPage); // 如何知道本页数

            }
        });
    });

    // ============== 四、删除功能 ===================
    $(document).on("click", ".delete_btn", function () {
        // 1、 弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var id = $(this).attr("del-id");
        // alert($(this).parents("tr").find("td:eq(1)").text());
        if (confirm("确认删除【" + empName + "】吗？")) {
            $.ajax({
                url: "/emp/" + id,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    // 回到本页
                    to_page(currentPage);
                }
            })
        }

    });

    // ============== 五、全选/全不选批量删除功能 ===================
    // 完成全选/全不选功能
    // att获取checked是undefined
    // dom原生的属性，通过prop获取
    // attr获取自定义的属性的值
    $("#check_all").click(function () {
        // alert($(this).attr("checked"));
        // alert($(this).prop("checked"));
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".check_item", function () {
        // 判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);

    });

    // 点击全部删除，就批量删除

    $("#emp_delete_all_btn").click(function () {
        var name = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            // this
            name += $(this).parents("tr").find("td:eq(2)").text() + ",";
            // 组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";

        });
        // 去除empName多余的逗号
        name = name.substring(0, name.length - 1);
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + name + "】吗？")) {
            // 发送ajax请求
            $.ajax(
                {
                    url: "/emp/" + del_idstr,
                    type: "DELETE",
                    success: function (result) {
                        alert(result.msg);
                        to_page(currentPage);

                    }
                }
            )
        }

    });
</script>
</body>
</html>
