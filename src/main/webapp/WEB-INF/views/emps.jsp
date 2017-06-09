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
</script>
</head>
<body>
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
									<input type="checkbox" id="check_emp" />
								</td>
								<td>${emp.empId }</td>
								<td>${emp.empName }</td>
								<td>${emp.gender == 'Male'?'男':'女'}</td>
								<td>${emp.email}</td>
								<td>${emp.dept.deptName }</td>
								<td>
									<button class="btn btn-primary btn-xs" id="emp_edit_btn">
										<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
									</button>
									<button class="btn btn-danger btn-xs" id="emp_delete_btn">
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