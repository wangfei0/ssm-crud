<%--
  Created by IntelliJ IDEA.
  User: wf
  Date: 19-11-20
  Time: 上午10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- 引入Bootstrap
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306）;需要加上项目名
            http://localhost:3306/crud
    -->
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工修改Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empEmail_add" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="empEmail_update" placeholder="email@123.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadio3" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadio4" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 员工增加Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empEmail_add" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="empEmail_add" placeholder="email@123.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="inlineRadio1" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="inlineRadio2" value="F"> 女
                                </label>
                            </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



<!--搭建显示界面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_modal_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
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
    <!--显示分页信息-->
    <div class="row">
        <div class="col-md-6" id="page_info_area">
            当前页，总共页,总共条记录
        </div>
        <!--分页条-->
        <div class="col-md-6" id="page_nav_area">

        </div>

    </div>
</div>
<script type="text/javascript">

    var totalRecord,currentPage;

    //1.页面加载完成后，直接发送一个ajax请求，要到分页数据
    $(function () {
        ajax_to_page(1);
    });
    
    function ajax_to_page(pageNum) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pageNumber="+pageNum,
            type:"get",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                // 2.解析并显示导航信息
                build_page_nav(result);
            }
        });
    }

    /**
     * 解析并显示员工数据表格
     * @param result
     */
    function build_emps_table(result) {
        // 清空上一页的显示数据
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class = 'check_item'></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender = item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            //为按钮添加一个自定义的属性，表示当前员工id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为按钮添加一个自定义的属性，表示当前员工id
            delBtn.attr("del-id",item.empId);
            $("<tr></tr>").append(checkBoxTd)
                            .append(empIdTd)
                            .append(empNameTd)
                            .append(genderTd)
                            .append(emailTd)
                            .append(deptNameTd)
                            .append(editBtn)
                            .append(delBtn)
                            .appendTo("#emps_table tbody");
        })
    }

    /**
     * 解析并显示分页信息
     * @param result
     */
    function build_page_info(result) {
        // 清空上一页的显示数据
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+ result.extend.pageInfo.pageNum+" 页，\
							共"+ result.extend.pageInfo.pages+"页，\
							共"+ result.extend.pageInfo.total+ "条记录");
        totalRecord = result.extend.pageInfo.pages;
        currentPage = result.extend.pageInfo.pageNum;
    }

    /**
     * 将获取的json数据解析并显示到table导航信息部分
     * @param result
     */
    function build_page_nav(result) {
        // 清空上一页的显示数据
        $("#page_nav_area").empty();
        // 每个导航数字 1 2 3都在li标签里面，所有li在一个ul里面，ul在nav里面
        var ul = $("<ul></ul>").addClass("pagination");
        // var nav = $("<nav></nav>").attr("aria-label","Page navigation");
        // 首页li
        var firstLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
        // 上一页li
        var prevLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"));
        // 绑定事件（不在第一页时，点击首页和上一页才发送请求）
        if(result.extend.pageInfo.hasPreviousPage == true){
            firstLi.click(function () {
                ajax_to_page(1);
            });
            prevLi.click(function () {
                ajax_to_page(result.extend.pageInfo.pageNum-1);
            });
        }
        ul.append(firstLi).append(prevLi);

        //遍历此次pageInfo中的导航页，并构建li标签，添加到ul
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var navLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
            // 遍历到当前显示的页，就高亮，且不能点击
            if(result.extend.pageInfo.pageNum == item){
                navLi.addClass("active");
            }else {
                // 绑定单击事件
                navLi.click(function () {
                    // 传入页号，获取数据
                    ajax_to_page(item);
                });
            }
            ul.append(navLi);
        });

        // 下一页li
        var nextLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
        // 尾页li
        var lastLi = $("<li></li>").append($("<a></a>").attr("href","#").append("尾页"));
        // 绑定事件（不在最后页时，点击尾页和下一页才发送请求）
        if(result.extend.pageInfo.hasNextPage == true){
            nextLi.click(function () {
                ajax_to_page(result.extend.pageInfo.pageNum+1);
            });
            lastLi.click(function () {
                ajax_to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(nextLi).append(lastLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }


    /**
     * 重置表单内容
     */
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    /**
     * 点击新增按钮，弹出模态框
     */
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据（表单重置）
        reset_form("#myModal form");

        // //提示信息重置
        // show_valiable_msg("#empName_add","","");
        // show_valiable_msg("#empEmail_add","","");
        //发送ajax请求，将部门列表添加到下拉框
        getDepts("#dept_add_select");
        //弹出模态框
        $("#myModal").modal({
            backdrop:"static"
        });
    });

    /**
     * 获取所有可选的部门信息，显示在指定的下拉列表中
     */
    function getDepts(elemSelector) {
        // 清空上一次的内容
        $(elemSelector).empty();
        $.ajax({
            url:"${APP_PATH}/dept/list",
            type:"GET",
            success:function (result) {
                $.each(result.extend.depts,function () {
                    var option = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    option.appendTo(elemSelector);
                    //$("#dept_add_select").append(option);
                });
            }
        });
    }

    /**
     * 校验表单的合法
     */
    function validate_add_form(){
        //校验用户名
        var empName = $("#empName_add").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户名可以是2-5位中文或者6-16位英文和数字组合")
            //应该清空这个元素之前的值
            show_valiable_msg("#empName_add","error","用户名可以是2-5位中文或者6-16位英文和数字组合");
            return false;
        }else {
            show_valiable_msg("#empName_add","success","");

        };
        var email = $("#empEmail_add").val();
        var emailtest = /\w+@[a-z0-9]+\.[a-z]{2,4}/;
        if (!emailtest.test(email)){
            //alert("请输入正确的邮箱格式")
            show_valiable_msg("#empEmail_add","error","请输入正确的邮箱格式");
            // $("#empEmail_add").parent().addClass("has-error");
            // $("#empEmail_add").next("span").text("请输入正确的邮箱格式");
            return false;
        }else{
            show_valiable_msg("#empName_add","success","");
            // $("#empEmail_add").parent().addClass("has-success");
            // $("#empEmail_add").next("span").text("验证通过");
        };
        return true;
    }

    /**
     * 校验
     * */
    function show_valiable_msg(ele,status,msg){
        //应该清空这个元素之前的值
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    /**
     * 动态校验用户名
     */
    $("#empName_add").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+ empName,
            type:"POST",
            success:function(result) {
                if(result.code == 100){
                    show_valiable_msg("#empName_add","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_valiable_msg("#empName_add","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    /**
     * 保存按钮事件
     */
    $("#emp_save_btn").click(function () {

        //前端校验
        if(!validate_add_form()){
            return false;
        }

        //用户名校验,可用继续，不可用不能继续
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        //发送ajax请求保存用户
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data: $("#myModal form").serialize(),
            success:function (result) {
               // alert(result.msg);
                if (result.code == 100){

                    //关闭模态框
                    $("#myModal").modal('hide');
                    ajax_to_page(totalRecord);
                }else {
                    //显示失败信息
                    //有哪个字段的错误信息，就返回哪个字段
                    if (undefined != result.extend.errorFields.email ){
                        //显示邮箱错误信息
                        show_valiable_msg("#empEmail_add","error",result.extend.errorFields.email);

                    }else if(undefined != result.extend.errorFields.empName){
                        //显示员工名字错误信息
                        show_valiable_msg("#empName_add","error",result.extend.errorFields.empName);
                    }
                }
            }
        })
    });

    /**
     * 绑定编辑按钮单击事件
     */
    $(document).on("click",".edit_btn",function () {
        //alert("edit");
        //查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //查出部门信息，显示部门列表
        getDepts("#dept_update_select")
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    /**
     * 绑定删除按钮单击事件
     */
    $(document).on("click",".delete_btn",function () {
        //1.弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        if (confirm("确认删除["+empName+"]吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页
                    ajax_to_page(currentPage);
                }
            });
        }
    });
    /**
     * 查员工信息
     *
     */
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            data: $("#myModal form").serialize(),
            success:function (result) {
                // console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#empEmail_update").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#dept_update_select").val([empData.dId]);
            }
        });
    }

    /**
     * 更新按钮的事件
     */
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#empEmail_update").val();
        var emailtest = /\w+@[a-z0-9]+\.[a-z]{2,4}/;
        if (!emailtest.test(email)){
            show_valiable_msg("#empEmail_add","error","请输入正确的邮箱格式");
            return false;
        }else{
            show_valiable_msg("#empName_add","success","");
        };
        //发送ajax请求，保存员工
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data: $("#empUpdateModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                //关闭对话框
                $("#empUpdateModal").modal("hide");
                //回到页面
                ajax_to_page(currentPage);
            }
        });
    });

    /**
     * 全选按钮
     */
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    /**
     * 判断当前页面的数据是否全部选中了
     */
    $(document).on("click",".check_item",function () {
        //判断当前选中的元素是不是全部选中了if
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    })

    /**
     * 批量删除按钮点击事件
     */
    $("#emp_delete_modal_btn").click(function () {
        var empNames = "";
        var del_idstr ="";
        $.each($(".check_item:checked"),function () {
           empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
           //员工id
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除emps多余的,
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确认删除["+empNames+"]吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    ajax_to_page(currentPage);
                }
            });
        }
    });
</script>

</body>
</html>
