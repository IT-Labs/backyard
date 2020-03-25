package com.itlabs.api.controllers;

import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemModel;
import com.itlabs.api.service.ItemService;
import io.swagger.annotations.Api;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
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
@CrossOrigin(maxAge = 3600)
@RequestMapping("/api/v1/item/")
public class ItemController {
  private final ItemService itemService;

  public ItemController(ItemService itemService) {
    this.itemService = itemService;
  }

  @GetMapping()
  public List<ItemModel> get(Pageable pageable) {
    return itemService.get(pageable);
  }

  @PostMapping()
  public ResponseEntity<ItemModel> post(@RequestBody ItemEditModel model) {
    return new ResponseEntity<>(itemService.save(model), HttpStatus.CREATED);
  }

  @GetMapping(path = "{id}")
  public ResponseEntity<ItemModel> getItem(@PathVariable("id") int id) {
    return new ResponseEntity<>(itemService.get(id), HttpStatus.OK);
  }

  @PutMapping(path = "{id}")
  public ResponseEntity<ItemModel> put(
      @PathVariable("id") int id, @RequestBody ItemEditModel model) {

    return new ResponseEntity<>(itemService.update(id, model), HttpStatus.CREATED);
  }

  @DeleteMapping(path = "{id}")
  public ResponseEntity<String> delete(@PathVariable("id") int id) {

    itemService.delete(id);
    return new ResponseEntity<>("deleted", HttpStatus.NO_CONTENT);
  }
}
