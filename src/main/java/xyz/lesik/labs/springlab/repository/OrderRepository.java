package xyz.lesik.labs.springlab.repository;

import xyz.lesik.labs.springlab.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
