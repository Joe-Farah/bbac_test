package com.bank.management.customer_management;

import com.bank.management.customer_management.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<Customer, Long> {
}