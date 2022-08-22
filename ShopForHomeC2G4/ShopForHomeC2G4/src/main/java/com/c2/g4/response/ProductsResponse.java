package com.c2.g4.response;

import java.util.List;

import com.c2.g4.entity.ProductInfo;

public class ProductsResponse {
	
	private List<ProductInfo> productList;

	public List<ProductInfo> getProductList() {
		return productList;
	}

	public void setProductList(List<ProductInfo> productList) {
		this.productList = productList;
	}
	

}
