package xyz.lesik.labs.springlab.repository;

import xyz.lesik.labs.springlab.entity.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
}
