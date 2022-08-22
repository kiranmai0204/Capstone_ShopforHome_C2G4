package com.c2.g4.service;

import java.util.Collection;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.c2.g4.entity.Cart;
import com.c2.g4.entity.OrderMain;
import com.c2.g4.entity.ProductInOrder;
import com.c2.g4.entity.User;
import com.c2.g4.repository.CartRepository;
import com.c2.g4.repository.OrderRepository;
import com.c2.g4.repository.ProductInOrderRepository;
import com.c2.g4.repository.UsersRepository;

@Service
public class CartService {
    @Autowired
    ProductService productService;
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    UsersRepository userRepository;

    @Autowired
    ProductInOrderRepository productInOrderRepository;
    @Autowired
    CartRepository cartRepository;
    @Autowired
    UserService userService;

    public Cart getCart(User user) {
        return user.getCart();
    }

    @Transactional
    public void mergeLocalCart(Collection<ProductInOrder> productInOrders, User user) {
        Cart finalCart = user.getCart();
        productInOrders.forEach(productInOrder -> {
            Set<ProductInOrder> set = finalCart.getProducts();
            Optional<ProductInOrder> old = set.stream().filter(e -> e.getProductId().equals(productInOrder.getProductId())).findFirst();
            ProductInOrder prod;
            if (old.isPresent()) {
                prod = old.get();
                prod.setCount(productInOrder.getCount() + prod.getCount());
            } else {
                prod = productInOrder;
                prod.setCart(finalCart);
                finalCart.getProducts().add(prod);
            }
            productInOrderRepository.save(prod);
        });
        cartRepository.save(finalCart);

    }

    @Transactional
    public void delete(String itemId, User user) {
        var op = user.getCart().getProducts().stream().filter(e -> itemId.equals(e.getProductId())).findFirst();
        op.ifPresent(productInOrder -> {
            productInOrder.setCart(null);
            productInOrderRepository.deleteById(productInOrder.getId());
        });
    }



    
    @Transactional
    public void checkout(User user) {
        // Creating the order
        OrderMain order = new OrderMain(user);
        orderRepository.save(order);

        user.getCart().getProducts().forEach(productInOrder -> {
            productInOrder.setCart(null);
            productInOrder.setOrderMain(order);
            productService.decreaseStock(productInOrder.getProductId(), productInOrder.getCount());
            productInOrderRepository.save(productInOrder);
        });

    }
}
