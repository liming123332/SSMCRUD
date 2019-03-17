<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2019/3/13
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <script type="text/javascript" src="static/js/vue.min.js"></script>
    <script type="text/javascript" src="static/js/jquery-2.0.min.js"></script>
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
</head>
<body>
    <!-- 员工新增 -->
    <div class="modal fade" id="empAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="empName_add_input" placeholder="empName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="email_add_input" placeholder="email">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender_add_input" id="inlineRadio1" value="M"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender_add_input" id="inlineRadio2" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-default">新增</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
  <div id="pageInfo">
      <%--bootstrap栅格系统--%>
      <div class="container">
          <%--标题--%>
          <div class="row">
              <div class="col-md-12">
                  <h1>SSMCRUD系统</h1>
              </div>
          </div>
          <%--按钮--%>
          <div class="row">
              <div class="col-md-4 col-md-offset-8">
                  <button class="btn btn-primary" @click="empAdd()">新增</button>
                  <button class="btn btn-danger">删除</button>
              </div>
          </div>
          <%--表格--%>
          <div class="row">
              <div class="col-md-12">
                  <table class="table table-hover">
                      <tr>
                          <th>#</th>
                          <th>empName</th>
                          <th>gender</th>
                          <th>email</th>
                          <th>deptName</th>
                          <th>操作</th>
                      </tr>
                      <tr v-for="(emp,index) in pageInfo.list">
                          <th>{{emp.empId}}</th>
                          <th>{{emp.empName}}</th>
                          <th>{{emp.gender}}</th>
                          <th>{{emp.email}}</th>
                          <th>{{emp.department.deptName}}</th>
                          <th>
                              <button class="btn btn-primary btn-sm">
                                  <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                  编辑
                              </button>
                              <button class="btn btn-danger btn-sm">
                                  <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                  删除
                              </button>
                          </th>
                      </tr>
                  </table>
              </div>
          </div>
          <%--分页信息--%>
          <div class="row">
              <div class="col-md-6">
                  当前页数{{pageInfo.pageNum}},总{{pageInfo.pages}}页,总记录数:{{pageInfo.total}}
              </div>
              <div class="col-md-6">
                  <nav aria-label="Page navigation">
                  <ul class="pagination">
                      <li :class="{'disabled':pageInfo.isFirstPage}"><a href="javascript:;" @click="jump(1)">首页</a></li>
                      <li :class="{'disabled':pageInfo.isFirstPage}">
                          <a href="javascript:;" @click="jump(pageInfo.pageNum-1)" aria-label="Previous">
                              <span aria-hidden="true">&laquo;</span>
                          </a>
                      </li>
                        <%--v-bind:class 同等于 :class--%>
                        <li :class="{'active':(value==pageInfo.pageNum)}" v-for="value,index in pageInfo.navigatepageNums">
                            <a href="javascript:;" @click="jump(value)">{{value}}</a>
                        </li>
                      <li :class="{'disabled':pageInfo.isLastPage}">
                          <a href="javascript:;" @click="jump(pageInfo.pageNum+1)" aria-label="Next">
                              <span aria-hidden="true">&raquo;</span>
                          </a>
                      </li>
                      <li :class="{'disabled':pageInfo.isLastPage}"><a href="javascript:;" @click="jump(pageInfo.pages)">末页</a></li>
                  </ul>
              </nav>
              </div>
          </div>
      </div>
  </div>
    <script>
        var vue=new Vue({
            el: '#pageInfo',
            data: {
                pageInfo: {},
            },

            created: function () {
                $.ajax({
                    type:"get",
                    url: "employee/emps/",
                    data:{pn:1},
                    success: function (result) {
                        //alert(data);
                        vue.pageInfo = result.pageInfo;
                        //判断json集合里面的每个对象的gender值 如果是M 就改成女 渲染在页面上 如果是F就改成男
                        for(var i=0;i<vue.pageInfo.list.length;i++){
                            if(vue.pageInfo.list[i].gender=='M'){
                                vue.pageInfo.list[i].gender='男';
                            }else if(vue.pageInfo.list[i].gender=='F'){
                                vue.pageInfo.list[i].gender='女';

                            }
                        }
                    },

                });
            },
            methods:{
                jump:function (value) {
                    if(value<=0){
                        value=1;
                    }
                    $.ajax({
                        type:"get",
                        url: "employee/emps/",
                        data:{pn:value},
                        success: function (result) {
                            //alert(data);
                            vue.pageInfo = result.pageInfo;
                            //判断json集合里面的每个对象的gender值 如果是M 就改成女 渲染在页面上 如果是F就改成男
                            for(var i=0;i<vue.pageInfo.list.length;i++){
                                if(vue.pageInfo.list[i].gender=='M'){
                                    vue.pageInfo.list[i].gender='男';
                                }else if(vue.pageInfo.list[i].gender=='F'){
                                    vue.pageInfo.list[i].gender='女';

                                }
                            }
                        },

                    });
                },
                empAdd:function () {
                    $(function () {
                        $('#empAdd').modal({
                            backdrop:false
                        })
                    })
                }

            }
        })
    </script>
</body>
</html>
