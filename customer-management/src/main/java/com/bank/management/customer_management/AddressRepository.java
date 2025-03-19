package com.bank.management.customer_management;

import com.bank.management.customer_management.Address;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AddressRepository extends JpaRepository<Address, Long> {
}
