package com.c2.g4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.c2.g4.entity.ProductInOrder;
import com.c2.g4.entity.User;
import com.c2.g4.repository.ProductInOrderRepository;

import java.util.concurrent.atomic.AtomicReference;

@Service
public class ProductInOrderService {
	
	@Autowired
    ProductInOrderRepository productInOrderRepository;

    @Transactional
    public void update(String itemId, Integer quantity, User user) {
        var op = user.getCart().getProducts().stream().filter(e -> itemId.equals(e.getProductId())).findFirst();
        op.ifPresent(productInOrder -> {
            productInOrder.setCount(quantity);
            productInOrderRepository.save(productInOrder);
        });

    }

    public ProductInOrder findOne(String itemId, User user) {
        var op = user.getCart().getProducts().stream().filter(e -> itemId.equals(e.getProductId())).findFirst();
        AtomicReference<ProductInOrder> res = new AtomicReference<>();
        op.ifPresent(res::set);
        return res.get();
    }
}
