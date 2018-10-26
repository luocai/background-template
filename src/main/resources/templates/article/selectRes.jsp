<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>
<rapid:override name="title">
    - 文章列表
</rapid:override>
<rapid:override name="header-style">
    <style>
        /*覆盖 layui*/
        .layui-input {
            display: inline-block;
            width: 33.333% !important;
        }

        .layui-input-block {
            margin: 0px 10px;
        }


    </style>
</rapid:override>

<rapid:override name="content">
    <blockquote class="layui-elem-quote">
        <span class="layui-breadcrumb" lay-separator="/">
          <a href="articleList">首页</a>
          <a><cite>文章列表</cite></a>
        </span>
    </blockquote>

    <div class="layui-tab layui-tab-card">
        <ul class="layui-tab-title">
            <li class="layui-this">已发布</li>
            <li>草稿</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <form id="articleForm" method="post">
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <input type="text" name="query" placeholder="请输入关键词" autocomplete="off" class="layui-input">
                            <button class="layui-btn" lay-filter="formDemo" onclick="selectArticle()">搜索</button>
                            <button class="layui-btn" lay-filter="formDemo" style="float: right;"
                                    onclick="deleteSome()">批量删除
                            </button>
                        </div>
                    </div>
                    <input type="hidden" name="currentUrl" id="currentUrl" value="">
                    <table class="layui-table">
                        <colgroup>
                            <col width="80">
                            <col width="50">
                            <col width="300">
                            <col width="200">
                            <col width="200">
                        </colgroup>
                        <thead>
                        <tr>
                            <th><input type="checkbox" name="selectAll">全选</th>
                            <th>id</th>
                            <th>标题</th>
                            <th>发布时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${articles}" var="a">
                         
                                <tr>
                                    <td><input type="checkbox" name="ids" value="${a.articleId}"></td>
                                    <td>${a.articleId}</td>
                                    <td>
                                        <a href="?id=${a.articleId}"
                                           target="_blank">
                                               ${a.articleTitle}

                                        </a></td>
                                   
                                    <td>
                                        <fmt:formatDate value="${a.publishTime}"
                                                        pattern="MM月dd日 HH:mm"/>
                                    </td>
                                    <td>
                                        <a href="editArticle?id=${a.articleId }"
                                           class="layui-btn layui-btn-mini">编辑</a>
                                        <button id="deleteButton" class="layui-btn layui-btn-danger layui-btn-mini" onclick="deleteArticle('${a.articleId}')">删除</button>
                                    </td>
                                </tr>
                 
                        </c:forEach>
                        </tbody>
                    </table>
                </form>
                
                <p style="text-align: right;color: red;position: absolute" id="info"></p>
                
                 <div style="text-align: center">
		            <ul class="pagination" >
		               <li> <a href = "articleList?page=1">首页</a> </li>
					    	<li <c:if test="${pageInfo.pageNum==1}">class="disabled"</c:if>><a href="articleList?page=${pageInfo.pageNum-1 }">&laquo;</a></li>
			                <c:forEach begin="${pageInfo.navigateFirstPage }" end="${pageInfo.navigateLastPage}" step="1" var="pageNo">
			                    <li <c:if test="${pageInfo.pageNum==pageNo}">class="active"</c:if>><a href="articleList?page=${pageNo}">${pageNo}</a></li>
			                </c:forEach>
			                <li <c:if test="${pageInfo.pageNum==pageInfo.pages}">class="disabled"</c:if>><a href="articleList?page=${pageInfo.pageNum+1}">&raquo;</a></li>
					   <li> <a href = "articleList?page=${pageInfo.pages }">尾页</a> </li>
		            </ul>
       			 </div>

</rapid:override>
<rapid:override name="footer-script">
    <script>
   /*  confirm("hehe"); */
  
  	function deleteArticle(id){
  		var flag = confirm("你确定要删除吗？");
  		if (flag){
  			alert(id);
  			$.ajax({
					url:"deleteArticle",
					type:"post",
					async:false,
					data:{articleId:id},
					dataType: 'json',
					success:function(data){
						 if(data.stateCode.trim() == "1" ) {
							window.location.reload(); 
						 }	
					}
				})
			alert("haha");
  		}
  	}
   
   function deleteSome(){
   		var checkedNum = $("input[name='ids']:checked").length;
   		if (checkedNum == 0){
   			confirm("请选择至少一项！");
   			return;
   		}
   		if (confirm("你确定要删除所选项吗？")){
   			var checkedList = new Array();
   			$("input[name='ids']:checked").each(function(){
   				checkedList.push($(this).val());
   			})
   			alert("进入了");
   			$.ajax({
   				url:"deleteSome",
   				type:"post",
   				data:{
   					"checkedList":checkedList.toString()
   				},
   				dataType:"json",
   				success:function(){
   					$("[name='ids']:checkbox").attr("checked",false);
   					window.location.reload;
   				}
   			})
   			alert("出来了");
   		}
   }
   
  
		$("input[name='selectAll']").click(function(){
			
			if($(this).is(':checked')){
				$("input[name='ids']").each(function(){
					$(this).prop("checked",true);
				})
			}
			else{
				$("input[name='ids']").each(function(){
					$(this).prop("checked",false);
				})
			}
			/* $("iniut[name='ids']").attr("checked",true); */
		})
		
	
	function selectArticle(){
		$("#articleForm").attr("action", "selectArticle");
   		$("#articleForm").submit();
	}
   
	
    </script>
</rapid:override>
<%@ include file="../base/framework.html" %>
