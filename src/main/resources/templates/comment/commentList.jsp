<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>

<rapid:override name="title">
    - 评论列表
</rapid:override>
<rapid:override name="header-style">
    <style>
        /*覆盖 layui*/
        .layui-table {
            margin-top: 0;
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
     
    </style>
</rapid:override>

<rapid:override name="content">
    <%-- <blockquote class="layui-elem-quote">
        <span class="layui-breadcrumb" lay-separator="/">
              <a href="/admin">首页</a>
              <a><cite>评论列表</cite></a>
        </span>
    </blockquote> --%>
    
     <div class="container">  
        <ul class="breadcrumb">  
            <li><a href="articleList"> 首页</a></li>  
            <li class="active"><a href="#">评论管理</a></li> 
            <li class="active"><a href="#">所有评论</a></li>  
        </ul>  
   </div>
   
   
    <div class="layui-tab layui-tab-card">
        <ul class="layui-tab-title">
            <li class="layui-this">全部评论(${pageInfo.total})</li>
        </ul>
        <div class="layui-tab-content" >
            <div class="layui-tab-item layui-show" style="margin-bottom: -10px">
                <table class="layui-table" lay-even lay-skin="nob">
                    <colgroup>
                        <col width="100">
                        <col width="200">
                        <col width="270">
                        <col width="150">
                        <col width="80">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>作者</th>
                        <th>评论内容</th>
                        <th>所在文章</th>
                        <th>评论时间</th>
                        <th>是否回复</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${commentCustomList}" var="c">
                        <tr>
                            <td>
                                <strong>${c.userName}</strong>
                            </td>
                            <td class="dashboard-comment-wrap">
                            	<div class="row-actions">
                            		<span id="content${c.commentId }">
                            			${c.commentContent}
                            		</span>
                            	</div>  
                                <div class="row-actions">
                                	<span id="reply${c.commentId }" style="display:none">
                                	回复 ${c.userName }：${c.reply }
                                	</span>
                                </div>
                                <div class="row-actions" id="link${c.commentId }">
                                     <span class="">
                                     <%--       <c:choose>
                                               <c:when test="${c.commentCustom.commentStatus==0}">
                                                   <a href="javascript:void(0)" style="color:#5FB878;!important;" onclick="approveComment(${c.commentCustom.commentId})">批准</a>
                                               </c:when>
                                               <c:otherwise>
                                                   <a href="javascript:void(0)" style="color:#FF5722;!important;" onclick="hideComment(${c.commentCustom.commentId})">屏蔽</a>
                                               </c:otherwise>
                                           </c:choose> --%>
                                     </span> |
                                     <span class="">
                                        <%-- <a href="commentReply?id=${c.commentId}">
                                            回复
                                        </a> --%>
                                        <a href="#" id="reply${c.commentId }" <c:if test="${c.replyState ==0 }"> onclick="reply('${c.commentId}')"</c:if> >回复</a> 
                                     </span>
                                     <span class=""> |
                                        <a href="#" onclick="deleteComment('${c.commentId}')">删除</a>
                                     </span>
                                </div>
                                
                                <form action="#" class="form-inline" id="form${c.commentId }" method="post">
                                	<div class="form-group">
                                		<input id="replyInput${c.commentId }" type="text" name="reply" style="display:none;" class="form-control">
                                		<input name="commentId" value="${c.commentId }" type="hidden">
                                	</div>
									<button class="btn btn-sm" id="replyButton${c.commentId }" style="display:none;" onclick="replySubmit('${c.commentId}')">确定</button>
                                </form>
                            </td>
                            <td>
                                <a href="../../article?id=${c.articleId}"
                                   target="_blank">${c.articleTitle}</a>
                            </td>
                            <td>
                                <fmt:formatDate value="${c.commentTime}" pattern="yyyy年MM月dd日 HH:dd:ss"/>
                            </td>
                            <td>
                                    <c:if test="${c.replyState == 1 }">已回复  <a href="#" id="look${c.commentId }" onclick="lookReply('${c.commentId}')">查看</a></c:if>
                                    <c:if test="${c.replyState == 0 }"><span style="color:red">未回复</span></c:if>
                            </td>

                        </tr>
                    </c:forEach>
                    </tbody>

                </table>

                
                </div>
            </div>
            
        </div>
        
        <div class="container">
                 	<div class="row">
                 		<div class="col-sm-6 col-sm-offset-4">
	                 		<ul class="pagination" >
				               <li> <a href = "commentList?page=1">首页</a> </li>
							    	<li <c:if test="${pageInfo.pageNum==1}">class="disabled"</c:if>><a href="commentList?page=${pageInfo.pageNum-1 }">&laquo;</a></li>
					                <c:forEach begin="${pageInfo.navigateFirstPage }" end="${pageInfo.navigateLastPage}" step="1" var="pageNo">
					                    <li <c:if test="${pageInfo.pageNum==pageNo}">class="active"</c:if>><a href="commentList?page=${pageNo}">${pageNo}</a></li>
					                </c:forEach>
					                <li <c:if test="${pageInfo.pageNum==pageInfo.pages}">class="disabled"</c:if>><a href="commentList?page=${pageInfo.pageNum+1}">&raquo;</a></li>
							   <li> <a href = "commentList?page=${pageInfo.pages }">尾页</a> </li>
				            </ul>
                 		</div>
	                 	
                 	</div>  
       	 </div>
  


</rapid:override>
<rapid:override name="footer-script">
    <script>
		function reply(commentId){
			var replyInput = document.getElementById("replyInput"+commentId);
			var replyButton = document.getElementById("replyButton"+commentId);
			if (replyInput.style.display == "none"){
				replyInput.style.display = "block";
				replyButton.style.display = "block";
			}	
			else{
				replyInput.style.display = "none";
				replyButton.style.display = "none";
			}		
		}
		
		/* function replySubmit(){
			$.ajax({
				url:"addReply",
				type:"post",
				data:$("#form2").serialize(),
				dataType:"json",
				async:false,
				success:function(data){
					console.log(data);
					if(data.stateCode == 1){
						alert("回复成功！");
						window.location.reload();
					}
					else{
						alert("回复失败！");
						window.location.reload();
					}
				},
				error:function(){
					alert("异常！");
				}
			})
		} */
		
		function replySubmit(id){
			$("#form"+id).attr("action", "addReply");
			$("#form" + id).submit();
			alert("回复成功!");
			window.location.reload();
		}
		
		function deleteComment(id){
			$.ajax({
				url:"deleteComment",
				type:"post",
				dataType:"json",
				async:false,
				data:{
					commentId:id
				},
				success:function(data){
					console.log(data);
					if (data.stateCode == 1){
						alert("删除成功！");
						window.location.reload();
					}else{
						alert("删除失败！");
						window.location.reload();
					}
				},
				error:function(){
					alert("异常！");
				}
			})
		}
		
		function lookReply(commentId){
			if ($("#reply"+commentId).is(':hidden')){
				$("#link" +commentId).hide();
				$("#reply"+commentId).show();
				$("#reply" +commentId).css("color","BlueViolet");
	/* 			$("#content"+commentId).css("color","red"); */
				$("#look" +commentId).text("收起");
			}else{
				$("#reply"+commentId).hide();
				$("#link" +commentId).show();
				$("#look"+commentId).text("查看");
			}
			
		}
    </script>
</rapid:override>

<%@ include file="../../base/framework.jsp" %>
