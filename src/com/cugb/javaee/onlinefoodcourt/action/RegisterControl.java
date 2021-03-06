package com.cugb.javaee.onlinefoodcourt.action;
import java.lang.Math;
import java.net.URLEncoder;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import com.cugb.javaee.onlinefoodcourt.bean.Customer;
import com.cugb.javaee.onlinefoodcourt.biz.CustomerService;
import com.cugb.javaee.onlinefoodcourt.dao.CustomerDAOMySqlImpl;
import com.cugb.javaee.onlinefoodcourt.test.BaseService;
/**
 * 
 * @author fanleehao
 * 用户注册servlet
 * 2017年5月28日
 */
@WebServlet("/register")
public class RegisterControl extends BaseService {

	
	public RegisterControl() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//super.doGet(req, resp);
		//获取参数
		String username = req.getParameter("registerName");
		String password = req.getParameter("registerPass");
		String email = req.getParameter("registerEmail");
		Customer customer = new Customer();
		customer.setUsername(username);
		customer.setPassword(password);
		customer.setEmail(email);
		//判断是否冲突后，将用户存储到数据库中
		CustomerService cService = new CustomerService();
		RequestDispatcher rd = null;
		try {
			if(cService.isExistCustomer(username)){
				//如果用户已存在
				PrintWriter out = resp.getWriter();
//				resp.setContentType("text/html;charset=utf-8");
//				resp.setCharacterEncoding("UTF-8");
//				out.print("<!DOCTYPE html><html><meta charset=\"utf-8\"><body><script>alert(\"用户已存在\");window.location.href=\"login.jsp\";</script></body></html>");
				String a = URLEncoder.encode("用户已经存在！", "UTF-8");  
		        out.print("<script>alert(decodeURIComponent('"+a+"') );window.location.href='login.jsp'</script>"); 
				
				//resp.sendRedirect("login.html");
			}
			else{
				//注册成功
				CustomerDAOMySqlImpl cuMySqlImpl = new CustomerDAOMySqlImpl();
				cuMySqlImpl.addCustomer(customer);
				String a = URLEncoder.encode("注册成功 请登陆！", "UTF-8");  
				resp.getWriter().print("<script>alert(decodeURIComponent('"+a+"') );window.location.href='login.jsp'</script>");
			}
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
	
}
