package xyz.lesik.labs.springlab.controller;

import org.springframework.web.bind.annotation.*;
import xyz.lesik.labs.springlab.entity.OrderItem;
import xyz.lesik.labs.springlab.service.OrderItemService;

@RestController
@RequestMapping("/api/orders/{orderId}/items")
public class OrderItemController {

    private final OrderItemService orderItemService;

    public OrderItemController(OrderItemService orderItemService) {
        this.orderItemService = orderItemService;
    }

    @PostMapping
    public OrderItem addItem(@PathVariable Long orderId, @RequestBody OrderItem item) {
        return orderItemService.addItem(orderId, item);
    }
}
