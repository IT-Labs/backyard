package com.itlabs.api.service;

import com.itlabs.api.entity.Items;
import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemModel;
import com.itlabs.api.repository.ItemsRepository;
import java.util.UUID;
import java.util.stream.Collectors;
import javax.transaction.Transactional;
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
	 * @param uuid
	 * @return ItemModel
	 * @throws EmptyResultDataAccessException
	 */
	@Override
	public ItemModel get(UUID uuid) {
		return getModel(getDatabaseItem(uuid));
	}

	/**
	 * @param pageable
	 * @return Page<ItemModel>
	 */
	@Override
	public Page<ItemModel> get(Pageable pageable) {
		final var all = itemRepository.findAll(pageable);
		final var items = all.stream().map(this::getModel).collect(Collectors.toList());

		return new PageImpl<>(items, pageable, all.getTotalElements());
	}

	/**
	 * @param model
	 * @return ItemModel
	 */
	@Override
	@Transactional
	public ItemModel save(ItemEditModel model) {
		var item = new Items();
		item.setName(model.getName());
		item.setStatus(model.getStatus());
		item.setType("PERSONAL");
		item.setGuid(UUID.randomUUID());
		item.setDescription(model.getDescription());
		item = itemRepository.save(item);
		return getModel(item);
	}

	/**
	 * @param uuid
	 * @param editModel
	 * @return ItemModel
	 * @throws EmptyResultDataAccessException
	 */
	@Override
	@Transactional
	public ItemModel update(UUID uuid, ItemEditModel editModel) {
		var item = getDatabaseItem(uuid);
		item.setName(editModel.getName());
		item.setStatus(editModel.getStatus());
		item.setDescription(editModel.getDescription());
		return getModel(itemRepository.save(item));
	}

	/**
	 * @param uuid
	 */
	@Override
	@Transactional
	public void delete(UUID uuid) {
		itemRepository.deleteByGuid(uuid);
	}

	private Items getDatabaseItem(UUID uuid) {
		return itemRepository.findByGuid(uuid).orElseThrow(
				() -> new EmptyResultDataAccessException(String.format("Item with id %d not found", uuid), 1));
	}

	private ItemModel getModel(Items item) {
		return ItemModel.builder().id(item.getGuid().toString()).name(item.getName()).description(item.getDescription())
				.status(item.getStatus()).build();
	}

}
