package com.itlabs.api.repository;

import com.itlabs.api.entity.Items;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ItemsRepository extends JpaRepository<Items, Integer> {}
