package com.itlabs.api.service;

import com.itlabs.api.entity.Items;
import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemModel;
import com.itlabs.api.repository.ItemsRepository;
import java.util.stream.Collectors;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ItemServiceImpl implements ItemsService {

  private final ItemsRepository itemRepository;

  public ItemServiceImpl(ItemsRepository itemRepository) {

    this.itemRepository = itemRepository;
  }

  /**
   * @param id
   * @return ItemModel
   * @throws EmptyResultDataAccessException
   */
  @Override
  public ItemModel get(Integer id) {
     return  getModel(getDatabaseItem(id));
  }

  /**
   * @param pageable
   * @return Page<ItemModel>
   */
  @Override
  public Page<ItemModel> get(Pageable pageable) {
    final var all = itemRepository.findAll(pageable);
    final var items = all.stream()
            .map(this::getModel)
            .collect(Collectors.toList());

    return new PageImpl<>(items, pageable, all.getTotalElements());
  }
  /**
   * @param model
   * @return ItemModel
   */
  @Override
  public ItemModel save(ItemEditModel model) {
    var item = new Items();
    item.setName(model.getName());
    item.setStatus(model.getStatus());
    item.setType("PERSONAL");
    item.setDescription(model.getDescription());
    return getModel(itemRepository.save(item));
  }

  /**
   * @param id
   * @param editModel
   * @return ItemModel
   * @throws EmptyResultDataAccessException
   */
  @Override
  public ItemModel update(int id, ItemEditModel editModel) {
    var item = getDatabaseItem(id);
    item.setName(editModel.getName());
    item.setStatus(editModel.getStatus());
    item.setDescription(editModel.getDescription());
    return getModel(itemRepository.save(item));
  }

  /** @param id */
  @Override
  public void delete(int id) {
    itemRepository.deleteById(id);
  }

  private Items getDatabaseItem(Integer id) {
    return itemRepository
        .findById(id)
        .orElseThrow(
            () ->
                new EmptyResultDataAccessException(
                    String.format("Item with id %d not found", id), 1));
  }

  private ItemModel getModel(Items item) {
    return ItemModel.builder()
        .id(item.getId())
        .name(item.getName())
        .description(item.getDescription())
        .status(item.getStatus())
        .build();
  }
}
