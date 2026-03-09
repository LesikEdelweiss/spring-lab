package xyz.lesik.labs.springlab.repository;

import xyz.lesik.labs.springlab.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
