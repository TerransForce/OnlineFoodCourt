package com.cugb.javaee.onlinefoodcourt.biz;

import java.util.ArrayList;

import com.cugb.javaee.onlinefoodcourt.dao.*;
import com.cugb.javaee.onlinefoodcourt.utils.*;
import com.cugb.javaee.onlinefoodcourt.bean.*;
//import edu.cugb.xg.javaee.dao.DishDAO;
//import edu.cugb.xg.javaee.bean.Dish;
//import edu.cugb.xg.javaee.utils.DAOFactory;
//import edu.cugb.xg.javaee.utils.PageModel;

public class DishService {
	private IDishDAO dishdao;

	public IDishDAO getDishdao() {
		return dishdao;
	}

	public void setDishdao(IDishDAO dishdao) {
		this.dishdao = dishdao;
	}
	
	/**
	 * @param pageNO
	 * @param pageSize
	 * @return
	 * @throws ClassNotFoundException 
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 */
	public PageModel<Dish> findDish4PageList(int pageNO,int pageSize) throws InstantiationException, IllegalAccessException, ClassNotFoundException{
		dishdao = (IDishDAO) DAOFactory.newInstance("IDishDAO");
		String strsql = "select dishid DishID, name Name, price Price, description Description, imgurl ImgURL, discount Discount from Dish limit ?,?";
		int actualpageNO = (pageNO-1)*pageSize;
		Object[] params = {actualpageNO,pageSize};
		ArrayList<Dish> dishlist = dishdao.findDishs(strsql, params);
//		PageModel<Dish> pagemodel = new PageModel<Dish>();
//		pagemodel.setList(dishlist);
//		pagemodel.setPageNO(pageNO);
//		pagemodel.setPageSize(pageSize);
//		pagemodel.setTotalrecords(getTotalDishs());
		PageModel<Dish> pagemodel = new PageModel<Dish>(pageSize,pageNO,getTotalDishs(),dishlist);
		return pagemodel;
//		return dishdao.findDishs(strsql, params);
	}
	
	public PageModel<Dish> findDish5PageList(int pageNO,int pageSize,String str) throws InstantiationException, IllegalAccessException, ClassNotFoundException{
		dishdao = (IDishDAO) DAOFactory.newInstance("IDishDAO");
	    //System.out.println(str);
//		String strsql = "select dishid DishID, name Name, price Price, description Description, imgurl ImgURL, discount Discount from Dish where name like '%?%' limit ?, ?";
		String strsql = "select dishid DishID, name Name, price Price, description Description, imgurl ImgURL, discount Discount from Dish where name like '%"+str+"%' limit ?, ?";
		int actualpageNO = (pageNO-1)*pageSize;
		Object[] params = {actualpageNO, pageSize};
		ArrayList<Dish> dishlist = dishdao.findDishs(strsql, params);
		System.out.println(dishlist.size());
//		PageModel<Dish> pagemodel = new PageModel<Dish>();
//		pagemodel.setList(dishlist);
//		pagemodel.setPageNO(pageNO);
//		pagemodel.setPageSize(pageSize);
//		pagemodel.setTotalrecords(getTotalDishs());
		PageModel<Dish> pagemodel = new PageModel<Dish>(pageSize,pageNO,getPerDishs(str),dishlist);
		return pagemodel;
//		return dishdao.findDishs(strsql, params);
	}
	
	public int getTotalDishs() throws InstantiationException, IllegalAccessException, ClassNotFoundException{
		dishdao = (IDishDAO) DAOFactory.newInstance("IDishDAO");
		String strsql = "select count(*) from Dish";
		return dishdao.getTotalDishs(strsql);
	}
	
	public int getPerDishs(String str) throws InstantiationException, IllegalAccessException, ClassNotFoundException{
		dishdao = (IDishDAO) DAOFactory.newInstance("IDishDAO");
		String strsql = "select count(*) from Dish where name like '%"+str+"%'";
		return dishdao.getTotalDishs(strsql);
	}
	
}