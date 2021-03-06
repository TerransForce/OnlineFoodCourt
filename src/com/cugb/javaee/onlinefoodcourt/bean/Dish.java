package com.cugb.javaee.onlinefoodcourt.bean;

public class Dish {
	private int dishID;
	private String name;
	private float price;
	private String description;
	private String imgURL;
	private float discount;
	
	public String picSize(String pxl){
		return imgURL.substring(0, 93)+pxl+"x"+pxl;
	}
	
	public int getDishID() {
		return dishID;
	}
	public void setDishID(int dishID) {
		this.dishID = dishID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public float getDiscount() {
		return discount;
	}
	public void setDiscount(float discount) {
		this.discount = discount;
	}
	
	

	
	
}
