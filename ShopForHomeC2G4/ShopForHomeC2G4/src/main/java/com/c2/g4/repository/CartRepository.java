package com.c2.g4.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.c2.g4.entity.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer>{

}
