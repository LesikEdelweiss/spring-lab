package xyz.lesik.labs.springlab.service;

import org.springframework.stereotype.Service;
import xyz.lesik.labs.springlab.entity.Order;
import xyz.lesik.labs.springlab.entity.OrderItem;
import xyz.lesik.labs.springlab.repository.OrderItemRepository;
import xyz.lesik.labs.springlab.repository.OrderRepository;

@Service
public class OrderItemService {

    private final OrderItemRepository orderItemRepository;
    private final OrderRepository orderRepository;

    public OrderItemService(OrderItemRepository orderItemRepository,
                            OrderRepository orderRepository) {
        this.orderItemRepository = orderItemRepository;
        this.orderRepository = orderRepository;
    }

    public OrderItem addItem(Long orderId, OrderItem item) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found: " + orderId));
        item.setOrder(order);
        return orderItemRepository.save(item);
    }
}
