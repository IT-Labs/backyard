package com.itlabs.api.controllers;

import com.itlabs.api.models.ProductEditModel;
import com.itlabs.api.models.ProductModel;
import io.swagger.annotations.Api;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Api
@RequestMapping("/api/v1/product/")
public class ProductController {


    @GetMapping()
    public Page<ProductModel> get(){
        final ProductModel build = ProductModel.builder().name(UUID.randomUUID().toString()).id(Math.toIntExact(new Date().getTime())).build();
    return new PageImpl<>(List.of(build));
    }
    @PostMapping()
    public ProductModel post( @RequestBody ProductEditModel model){
        return  ProductModel.builder().build();
    }

    @GetMapping(path = "{id}")
    public ProductModel getItem(@PathVariable("id") int id){
        return  ProductModel.builder().name(UUID.randomUUID().toString()).id(id).build();
    }

    @PutMapping(path = "{id}")
    public ProductModel put( @PathVariable("id") int id,@RequestBody   ProductEditModel model){
        return  ProductModel.builder().build();
    }

    @DeleteMapping(path = "{id}")
    public ProductModel delete( @PathVariable("id") int id){
        return  ProductModel.builder().build();
    }

}
