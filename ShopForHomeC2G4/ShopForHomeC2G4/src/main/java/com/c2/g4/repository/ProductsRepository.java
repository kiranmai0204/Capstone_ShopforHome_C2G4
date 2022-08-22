package com.c2.g4.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.c2.g4.entity.ProductInfo;

@Repository
public interface ProductsRepository extends JpaRepository<ProductInfo, String>{
	
	ProductInfo findByProductId(String id);
    
    Page<ProductInfo> findAllByProductStatusOrderByProductIdAsc(Integer productStatus, Pageable pageable);

    Page<ProductInfo> findAllByCategoryTypeOrderByProductIdAsc(Integer categoryType, Pageable pageable);

    Page<ProductInfo> findAllByOrderByProductId(Pageable pageable);
}
