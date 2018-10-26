<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>
<rapid:override name="title">
    - 分类列表
</rapid:override>
<rapid:override name="header-style">
    <style>
  
        .layui-input {
            display: inline-block;
            width: 33.333% !important;
        }

        .layui-input-block {
            margin: 0px 10px;
        }
	.breadcrumb {
	    padding: 8px 15px;
	    margin-bottom: 20px;
	    margin-left:-15px;
	    margin-right:15px;
	    list-style: none;
	    background-color: #f5f5f5;
	    border-radius: 4px;
   }
    #form1 {
    	margin-bottom:15px;
        margin-left:-15px;
    }	

    </style>
</rapid:override>

<rapid:override name="content"> 


  <div class="container">  
        <ul class="breadcrumb">  
            <li><a href="articleList"> 首页</a></li>  
            <li class="active"><a href="#">分类管理</a></li>  
        </ul>  
   </div>  
   
	<form class = "col-md-4" action="##" method="post" id = "form1">
		<div class = "input-group">
			<input type ="text" name ="categoryName" class="form-control" placeholder = "请输入类名"/>
			<span class = "input-group-addon btn" onclick="addCategory()">新增</span>
		</div>
  	</form>
	
	<br>
	<br>
	
    <div class="layui-tab layui-tab-card">

                <form id="articleForm" method="post">
                    <input type="hidden" name="currentUrl" id="currentUrl" value="">
                    <table class="layui-table">
                        <colgroup>
                            <col width="50">
                            <col width="300">
                            <col width="300">
                            <col width="200">
                            <col width="200">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>id</th>
                            <th>类名</th>
                            <th>文章数目</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${categoryList}" var="a">
                         
                                <tr>
                                    <td>${a.categoryId}</td>
                                    <td>
                                        <a href="selectByCategory?categoryId=${a.categoryId}"
                                           target="_blank">
                                               ${a.categoryName}

                                        </a></td>
                                   
                                    <td>${a.articlecount}</td>
                                    <td>
                                        <button id="deleteButton" class="layui-btn layui-btn-danger layui-btn-mini" onclick="deleteCategory('${a.categoryId}')">删除</button>
                                    </td>
                                </tr>
                 
                        </c:forEach>
                        </tbody>
                    </table>
                </form>
                
                <p style="text-align: right;color: red;position: absolute" id="info"></p>
                
                 <div class="container">
                 	<div class="row">
                 		<div class="col-sm-6 col-sm-offset-4">
	                 		<ul class="pagination" >
				               <li> <a href = "categoryList?page=1">首页</a> </li>
							    	<li <c:if test="${pageInfo.pageNum==1}">class="disabled"</c:if>><a href="categoryList?page=${pageInfo.pageNum-1 }">&laquo;</a></li>
					                <c:forEach begin="${pageInfo.navigateFirstPage }" end="${pageInfo.navigateLastPage}" step="1" var="pageNo">
					                    <li <c:if test="${pageInfo.pageNum==pageNo}">class="active"</c:if>><a href="categoryList?page=${pageNo}">${pageNo}</a></li>
					                </c:forEach>
					                <li <c:if test="${pageInfo.pageNum==pageInfo.pages}">class="disabled"</c:if>><a href="categoryList?page=${pageInfo.pageNum+1}">&raquo;</a></li>
							   <li> <a href = "categoryList?page=${pageInfo.pages }">尾页</a> </li>
				            </ul>
                 		</div>
	                 	
                 	</div>  
       			 </div>

</rapid:override>
<rapid:override name="footer-script">
    <script>
 	
 	function deleteCategory(id){
 		if (confirm("你确定要删除该分类以及该类下的所有博文吗？")){
 			alert("进入了");
 			$.ajax({
 				url:"deleteCategory",
 				type:"post",
 				dataType:'json',
 				async:false,
 				data:{
 					"id":id
 				},
 				success:function(){
 					window.location.reload();
 				}
 			})
 			alert("出来了");
 		}
 	}
 	
 	function addCategory(){
 		$.ajax({
 			url:"addCategory",
 			type:"post",
 			dateType:"json",
 			data:$("#form1").serialize(),
 			async:false,
 			success:function(data){
 			    console.log(data);//打印服务端返回的数据(调试用)
 				if (data.stateCode == 1)
 				{
 					alert("增加成功");
 					window.location.reload();
 				}
 				else
 					alert("增加失败")
 			},
 			error : function() {
                    alert("异常！");
            }
 		})
 	}
	
    </script>
</rapid:override>
<%@ include file="../../base/framework.jsp" %>
