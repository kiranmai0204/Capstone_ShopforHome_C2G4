package com.c2.g4.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.c2.g4.entity.ProductInfo;
import com.c2.g4.helper.CSVHelper;
import com.c2.g4.repository.ProductsRepository;


@Service
public class CSVService {
	
	@Autowired
	ProductsRepository productsrepository;
	
	public void save(MultipartFile file) {
	    try {
	      List<ProductInfo> tutorials = CSVHelper.csvToTutorials(file.getInputStream());
	      productsrepository.saveAll(tutorials);
	    } catch (IOException e) {
	      throw new RuntimeException("fail to store csv data: " + e.getMessage());
	    }
	  }
	
	  public List<ProductInfo> getAllTutorials() {
	    return productsrepository.findAll();
	  }

}
