package com.c2.g4.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.c2.g4.entity.ProductInOrder;

@Repository
public interface ProductInOrderRepository extends JpaRepository<ProductInOrder, Long>{

}
