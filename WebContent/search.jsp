<%@page import="java.net.URLDecoder"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.*"%>
<%@page import="com.cugb.javaee.onlinefoodcourt.utils.DAOFactory"%>
<%@page import="com.cugb.javaee.onlinefoodcourt.bean.Dish"%>
<%@page import="com.cugb.javaee.onlinefoodcourt.bean.Customer"%>
<%@page import="com.cugb.javaee.onlinefoodcourt.dao.*"%>
<%@page import="com.cugb.javaee.onlinefoodcourt.biz.*"%>
<%@page import="com.cugb.javaee.onlinefoodcourt.utils.*"%>
<%@page import="com.cugb.javaee.onlinefoodcourt.utils.ConfigFactory" %>
<%@page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%

if(session.getAttribute("pageSize") == null){
	// 第一次访问该页面
	session.setAttribute("pageSize", ConfigFactory.readProperty("pageSize"));
}
if(request.getParameter("pageNO") == null){
	request.setAttribute("pageNO", "1");
}
else{
	request.setAttribute("pageNO", request.getParameter("pageNO"));
}


//根据页码生成相应的dishlist
int pageNO = Integer.parseInt((String)request.getAttribute("pageNO"));
int pageSize = Integer.parseInt((String)session.getAttribute("pageSize"));
String str = request.getParameter("query");


if(str==null){
	response.sendRedirect("index.jsp");
}
DishService dishserv = new DishService();
//PageModel<Dish> pagemodel = dishserv.findDish5PageList(pageNO, pageSize,str);
//request.setAttribute("pageModel", pagemodel); 
//request.setAttribute("dishlist", pagemodel.getList());


String headerfile = "";
if(session.getAttribute("loginuser") == null){
	 headerfile = "header.jsp";
}
else{
	Customer cusx = (Customer) session.getAttribute("loginuser");
	String adminUsername = ConfigFactory.readProperty("username");
	if(cusx.getUsername().equals(adminUsername) ){
		headerfile="headerAdmin.jsp";
		//<jsp:include page="headerAdmin.jsp"></jsp:include>										
	}
	else{
		 headerfile = "header.jsp";
		//<jsp:include page="header.jsp"></jsp:include>
	}
}

%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>网上订餐</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/prettyPhoto.css" rel="stylesheet">
<link href="css/price-range.css" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<link href="css/responsive.css" rel="stylesheet">
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
<link rel="shortcut icon" href="images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="images/ico/apple-touch-icon-57-precomposed.png">
</head>
<!--/head-->

<body>

 	<jsp:include page="<%= headerfile %>"></jsp:include>
 
 	
 <section>
		<div class="container">
			<div class="row">
				
				
				<div class="col-sm-12 padding-right">
					<!--features_items-->
					
					<div class="category-tab"><!--category-tab-->
						
						<div class="tab-content">


							<div class="tab-pane fade active in">

								<c:forEach items="${requestScope.dishlist}" var="currentdish"
									varStatus="status">
									<div class="col-sm-3">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<a  href="action?actiontype=detail&dishid=${currentdish.getDishID()}"><img src="${currentdish.picSize("256")}" alt=""></a>													
													<h2>¥${currentdish.getPrice()}</h2>
													<a href="action?actiontype=detail&dishid=${currentdish.getDishID()}"><p>${currentdish.getName()}</p></a>
													<a href="action?actiontype=detail&dishid=${currentdish.getDishID()}" class="btn btn-default add-to-cart"><i class="fa fa-eye"></i>详情</a>
													&nbsp;
													<a href="action?actiontype=addone&dishid=${currentdish.getDishID()}" class="btn btn-default add-to-cart"><i
														class="fa fa-shopping-cart"></i>购物车</a>
												</div>

											</div>
										</div>
									</div>
								</c:forEach>


								<!-- <div class="col-sm-3">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<img src="images/home/gallery1.jpg" alt="">
												<h2>$56</h2>
												<p>Easy Polo Black Edition</p>
												<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
											</div>
											
										</div>
									</div>
								</div> -->


							</div>

						</div>
					</div><!--/category-tab-->
					
					<div class="col-sm-12">
						<table>
						
					<tr>
					<ul class="pager">
					<li><a name="btnTopPage" id="btnTopPage" href="action?actiontype=search&pageNO=1&query=-1" >首页</a></li>
    <li><a name="btnPreviousPage" id="btnPreviousPage"
									href="action?actiontype=search&pageNO=${requestScope.pageModel.prevPageNO}&query=-1" >上一页</a></li>
    <li class="disabled"><a href="#">${requestScope.pageNO} / ${requestScope.pageModel.bottomPageNO}
</a></li>
    <li><a name="btnNextPage" id="btnNextPage"
									href="action?actiontype=search&pageNO=${requestScope.pageModel.nextPageNO}&query=-1"  >下一页</a></li>
    <li><a name="btnBottomPage"	id="btnBottomPage"
									href="action?actiontype=search&pageNO=${requestScope.pageModel.bottomPageNO}&query=-1" >尾页</a></li>
</ul>
					</tr>
						</table>
					
					</div>
					<%--- 
				 	<div class="recommended_items"><!--recommended_items-->
						<h2 class="title text-center">recommended items</h2>
						
						<div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
							<div class="carousel-inner">
								<div class="item active left">	
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend1.jpg" alt="">
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend2.jpg" alt="">
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend3.jpg" alt="">
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
								</div>
								<div class="item next left">	
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend1.jpg" alt="">
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend2.jpg" alt="">
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="images/home/recommend3.jpg" alt="">
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
								</div>
							</div>
							 <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
								<i class="fa fa-angle-left"></i>
							  </a>
							  <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
								<i class="fa fa-angle-right"></i>
							  </a>			
						</div>
					</div><!--/recommended_items-->
					 --%>
				</div>
			</div>
		</div>
	</section>
  
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>