package com.c2.g4.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.c2.g4.entity.ProductCategory;
import com.c2.g4.enums.ResultEnum;
import com.c2.g4.exception.MyException;
import com.c2.g4.repository.ProductCategoryRepository;

@Service
public class ProductCategoryService {

	@Autowired
    ProductCategoryRepository productCategoryRepository;

    public List<ProductCategory> findAll() {
        List<ProductCategory> res = productCategoryRepository.findAllByOrderByCategoryType();
        return res;
    }


    public ProductCategory findByCategoryType(Integer categoryType) {
        ProductCategory res = productCategoryRepository.findByCategoryType(categoryType);
        if(res == null) throw new MyException(ResultEnum.CATEGORY_NOT_FOUND);
        return res;
    }


    public List<ProductCategory> findByCategoryTypeIn(List<Integer> categoryTypeList) {
        List<ProductCategory> res = productCategoryRepository.findByCategoryTypeInOrderByCategoryTypeAsc(categoryTypeList);
        return res;
    }

    @Transactional
    public ProductCategory save(ProductCategory productCategory) {
        return productCategoryRepository.save(productCategory);
    }

}
