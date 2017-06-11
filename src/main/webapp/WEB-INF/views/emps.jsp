<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>emp page</title>
<!-- 导入Bootstrap  -->
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" >
<!-- 导入 JQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.12.4.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script
	src="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(function(){
		/* 新增 Employee */
		$("#emp_add_modal_btn").click(function(){
			//获取 Department 信息，并显示
			showDept("#add_dept");
			//弹出添加模态框
			$("#empAddModal").modal({backdrop:"static"});
		});
		
		/* 保存 */
		$("#emp_save_btn").click(function(){
			$.ajax({
				url:"${pageContext.request.contextPath}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(){
					alert("保存成功！");
					//关闭添加模态框
					$("#empAddModal").modal('hide');
				}
			});
		});
		
		/* 全选/全不选 */
		$("#check_all").click(function(){
			$(".check_emp").prop("checked",$(this).prop("checked"));
		});
		
		/* 为每条记录对应的复选框绑定事件 */
		$(document).on("click",".check_emp",function(){
			//选中的记录数
			var cNum = $(".check_emp:checked").length;
			if(cNum == $(".check_emp").length){
				$("#check_all").prop("checked",true);
			}else{
				$("#check_all").prop("checked",false);
			}
		});
		
		/* 批量删除 */
		$("#emp_delete_all_btn").click(function(){
			var delNames = "";
			var del_idstr = "";
			//获取要删除的 Employee 的 id
			$(".check_emp:checked").each(function(){
				var delName = $(this).parents("tr").find("td:eq(2)").text();
				delNames += (delName + ",");
				
				var delId = $(this).parents("tr").find("td:eq(1)").text();
				del_idstr += (delId + "-");
			});
			//去除名称字符串最后的"," 和 id 字符串的最后一个"-"
			delNames = delNames.substring(0, delNames.length-1);
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			
			//发送请求进行删除
			if(confirm("确认删除【"+ delNames +"】吗？")){
				$.ajax({
					url:"${pageContext.request.contextPath}/emp/"+del_idstr, 
					type:"DELETE"
					
				});
			}
		});
		
		/* 删除单个 Employee 信息 */
		$(document).on("click",".emp_delete_btn",function(){
			//待删除的 empId
			var empId = $(this).parents("tr").find("td:eq(1)").text();
			//待删除的 empName
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			
			if(confirm("确定删除【"+ empName +"】吗？")){
				$.ajax({
					url:"${pageContext.request.contextPath}/emp/"+empId,
					type:"DELETE"
				});
			}
		});
		
		/* 显示编辑 Employee 信息 */
		$(document).on("click",".emp_edit_btn",function(){
			//待编辑的 empId
			var empId = $(this).parents("tr").find("td:eq(1)").text();
			//查询Department 信息
			showDept("#edit_dept");
			
			//根据 empId 查询 Employee 信息
			getEmpById(empId);
			
			//打开编辑模态框
			$("#empEditModal").modal({backdrop:"static"});
			
		});
		
		/* 通过 id 进行更新 */
		$("#emp_edit_btn").click(function(){
			//待更新的 Employee 的id
			var empId = $(this).attr("edit-id");
			//通过empId 进行更新
			updateById(empId);
		});
		
		
	});
	
	/* 显示 Department 信息 */
	function showDept(ele){
		$.ajax({
			url:"${pageContext.request.contextPath}/depts",
			type:"GET",
			success:function(result){
				$.each(result,function(){
					$(ele).append("<option value='"+this.deptId+"'>"+ this.deptName +"</option>");
				});
			}
		});
	}
	
	/* 通过 empId 获取 Employee 信息 */
	function getEmpById(id){
		$.ajax({
			url:"${pageContext.request.contextPath}/emp/"+id,
			type:"GET",
			success:function(result){
				//将对应的值赋给编辑模态框
				$("#edit_empname").val(result.empName);
				$("#edit_email").val(result.email);
				$("#empEditModal input[name='gender']").val([result.gender]);
				$("#edit_dept").val([result.dId]);
				
				//保存当前 empId 方便更新
				$("#emp_edit_btn").attr("edit-id",result.empId);
			}
		});
	}
	
	/* 通过 empId 更新 Employee 信息 */
	function updateById(id){
		$.ajax({
			url:"${pageContext.request.contextPath}/emp/"+id,
			type:"PUT",
			data:$("#empEditModal form").serialize(),
			success:function(){
				//关闭编辑模态框
				$("#empEditModal").modal('hide');
			}
		});
	}

</script>
</head>
<body>
	<!-- -------- begin 添加Employe  ------------- -->
	<div id="empAddModal" class="modal fade" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">Add Emp</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
	          <div class="form-group">
			    <label for="add_empname" class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-10">
			      <input type="text" id="add_empname" name="empName" class="form-control" placeholder="empName">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="add_email" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" id="add_email" name="email" placeholder="name@163.com">
			    </div>
			  </div>
			  
			  <div class="form-group">
			  	<label  class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  <input type="radio" name="gender" id="add_gender1" value="M" > 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="add_gender2" value="F"> 女
					</label>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-5">
				    <select class="form-control" id="add_dept" name="dId">
					</select>
			    </div>
			  </div>
			  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">Add</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- -------- end 添加Employe    ------------- -->
	
	<!-- -------- begin 编辑Employe  ------------- -->
	<div id="empEditModal" class="modal fade" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">Edit Emp</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
	          <div class="form-group">
			    <label for="edit_empname" class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-10">
			      <input type="text" id="edit_empname" name="empName" class="form-control" >
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="edit_email" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" id="edit_email" name="email" >
			    </div>
			  </div>
			  
			  <div class="form-group">
			  	<label  class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  <input type="radio" name="gender" id="edit_gender1" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="edit_gender2" value="F"> 女
					</label>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-5">
				    <select class="form-control" id="edit_dept" name="dId">
					</select>
			    </div>
			  </div>
			  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	        <button type="button" class="btn btn-primary" id="emp_edit_btn">Edit</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- -------- end 编辑Employe    ------------- -->
	
	<div class="container">
		<!-- 顶部 -->
		<div class="row">
			<div class="col-md-12">
				<h1>EMP-INFO</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>

		<!-- 中部数据显示区 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all" />
							</th>
							<th>#</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>  
					</thead>
					<tbody>
						<c:forEach items="${pageInfo.list }" var="emp">
							<tr>
								<td>
									<input type="checkbox" class="check_emp" />
								</td>
								<td>${emp.empId }</td>
								<td>${emp.empName }</td>
								<td>${emp.gender == 'M'?'男':'女'}</td>
								<td>${emp.email}</td>
								<td>${emp.dept.deptName }</td>
								<td>
									<button class="btn btn-primary btn-xs emp_edit_btn">
										<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
									</button>
									<button class="btn btn-danger btn-xs emp_delete_btn">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
									</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 底部分页信息区 -->
		<div class="row">
			<!-- 分页文字信息 -->	
			<div class="col-md-6">
				当前第${pageInfo.pageNum }页，共${pageInfo.pages }页，共${pageInfo.total }条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				    <li>
						<a id="pre_page" href="${pageContext.request.contextPath }/emps?pageNum=${pageInfo.pageNum -1}" aria-label="Previous">
					    	<span aria-hidden="true">&laquo;</span>
					    </a>
				    </li>
				    <c:forEach items="${pageInfo.navigatepageNums }" var="navPageN">
					    <c:if test="${pageInfo.pageNum == navPageN }">
						    <li class="nav_page_num active"><a href="${pageContext.request.contextPath }/emps?pageNum=${navPageN}">${navPageN}</a></li>
					    </c:if>
					    <c:if test="${pageInfo.pageNum != navPageN }">
						    <li class="nav_page_num"><a href="${pageContext.request.contextPath }/emps?pageNum=${navPageN}">${navPageN}</a></li>
					    </c:if>
				    </c:forEach>
				    <li>
				      <a href="${pageContext.request.contextPath }/emps?pageNum=${pageInfo.pageNum + 1}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>

</body>
</html>