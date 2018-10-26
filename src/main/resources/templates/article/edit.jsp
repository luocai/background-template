<%--保留此处 start--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>
<%--保留此处 end--%>
    <rapid:override name="title">
        - 新建文章
    </rapid:override>
<rapid:override name="header-style">
    <style>
	.breadcrumb {
	    padding: 8px 15px;
	    margin-bottom: 20px;
	    margin-left:-15px;
	    margin-right:15px;
	    list-style: none;
	    background-color: #f5f5f5;
	    border-radius: 4px;
   }
   
     #cover{
   		width:120px;
   		height:120px;
   		margin:0 0 20px 111px;
   		/* display:none; */
   }

    </style>
</rapid:override>
<rapid:override name="content">

     <div class="container">  
        <ul class="breadcrumb">  
            <li><a href="articleList"> 首页</a></li>  
            <li class="active"><a href="#">修改文章</a></li>  
        </ul>  
   </div> 



    <form class="layui-form"  method="post" id="myForm"  enctype="multipart/form-data">
		<input type="hidden" name="articleId" value="${article.articleId}">
        <div class="layui-form-item">
            <label class="layui-form-label">标题 <span style="color: #FF5722; ">*</span></label>
            <div class="layui-input-block">
                <input type="text" name="articleTitle" lay-verify="title" id="title" autocomplete="off" value="${article.articleTitle }" class="layui-input">
            </div>
        </div>
        
        <div class="layui-form-item">
            <label class="layui-form-label">摘要 <span style="color: #FF5722; ">*</span></label>
            <div class="layui-input-block">
                <input type="text" name="summary" lay-verify="title" id="summary" autocomplete="off" placeholder="请输入文章摘要" value="${article.summary }" class="layui-input">
            </div>
        </div>

		<!-- 修改部分 -->
       <div>
        	<textarea name="articleContent" id="articlContent" style="display:none;" value="${article.articleContent }"></textarea>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">内容 <span style="color: #FF5722; ">*</span></label>
            <div class="layui-input-block">
            	<div  id="editor" name="articleContent"  id="content">
					<p>${article.articleContent }</p>
            	</div>
                <!-- <div id="editor">
			        <p>欢迎使用 <b>wangEditor</b> 富文本编辑器</p>
			    </div>  -->
            </div>
        </div>

		<div class="layui-form-item">
            <label class="layui-form-label">封面<span style="color: #FF5722; ">*</span> </label>
            <div class="layui-input-block">
	      		  <input type="file" value="更换封面" accept="image/*" name="articleCover" id="articleCover" onchange="show(this)">
            </div>
           
        </div> 
        
         <img alt="封面" src="${article.cover }" id="cover">

        <div class="layui-form-item">
            <label class="layui-form-label">分类 <span style="color: #FF5722; ">*</span> </label>
            <div class="layui-input-block"  style="width:200px;">
                <select name="articleCategory" id="articleCategory" lay-filter="articleCategory" required>
                    <option value="${article.category }" selected="">${categoryName }</option>
                    <c:forEach items="${categoryList}" var="c">
                            <option value="${c.categoryId}">${c.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="radio" name="state" value="1" title="发布" checked>
                <input type="radio" name="state" value="0" title="草稿" >
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
               <input type="button" class="layui-btn" id="submitForm" value="修改">
                <button type="reset" class="layui-btn layui-btn-primary" onclick="getCateIds()">重置</button>
            </div>
        </div>


    </form>


</rapid:override>

<rapid:override name="footer-script">

    <script>
        layui.use(['form', 'layedit', 'laydate'], function() {
            var form = layui.form
                , layer = layui.layer
                , layedit = layui.layedit
                , laydate = layui.laydate;

   		 });
   		 
   		  var E = window.wangEditor;
        var editor = new E('#editor');
        // 或者 var editor = new E( document.getElementById('editor') )
        
        editor.customConfig.uploadImgServer = 'uploadImg';  // 上传图片到服务器
        // 隐藏“网络图片”tab
    	editor.customConfig.showLinkImg = false;
    	editor.customConfig.uploadFileName = 'picture';
    	
    	editor.customConfig.uploadImgHooks = {
   			 customInsert: function (insertImg, result, editor) {
   			 	console.log(result);
                // 图片上传并返回结果，自定义插入图片的事件（而不是编辑器自动插入图片！！！）
                // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果
         
                // 举例：假如上传图片成功后，服务器端返回的是 {url:'....'} 这种格式，即可这样插入图片：
                var url =result.url;
                insertImg(url);
                console.log(url);
         
                // result 必须是一个 JSON 格式字符串！！！否则报错
            }
        }
        //给texteara赋值
        var $text1 = $('#articlContent');
        editor.customConfig.onchange = function (html) {
            // 监控变化，同步更新到 textarea
           // alert("改变了");
            $text1.val(html)
        }
        
        editor.customConfig.zIndex = 100;
        editor.create();
        
        $("#submitForm").click(function(){
	    	alert("进啦了");
	    	var flag = confirm("确定要修改吗？");
	    	if(flag == false){
	    		return false;
	    	}
	    	$("#myForm").ajaxSubmit({
	            type:"POST",
	            url:"/myblog/admin/editArticle",
	            async:false,
	            dataType:"json",
	            success:function(result){
	                alert("修改成功");
	                location.href="articleList"
	            },
	            error:function () {
	                alert("出错啦");
	            }
       	   });
       	   alert("出啦");
	    })
	    
        
      //选择图片后实行图片预览  
      function show(f) {
        var rd = new FileReader();//创建文件读取对象
        var files = f.files[0];//获取file组件中的文件
        rd.readAsDataURL(files);//文件读取装换为base64类型
        rd.onloadend = function(e) {
            //加载完毕之后获取结果赋值给img
            document.getElementById("cover").src = this.result;
        }
        $("#cover").show();
    }
    </script>

</rapid:override>


<%--此句必须放在最后--%>
<%@ include file="../base/framework.html"%>

