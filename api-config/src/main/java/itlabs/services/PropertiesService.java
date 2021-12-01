package itlabs.services;

import itlabs.models.PropertyModel;
import itlabs.models.PropertyViewModel;
import itlabs.repositories.PropertiesRepository;
import itlabs.repositories.Property;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class PropertiesService {
  private final PropertiesRepository propertiesRepository;

  public PropertiesService(PropertiesRepository propertiesRepository) {
    this.propertiesRepository = propertiesRepository;
  }

  public PropertyViewModel save(PropertyModel model) {
    return getModel(propertiesRepository.save(getEntity(model, null)));
  }

  public PropertyViewModel get(UUID id) {
    return getModel(propertiesRepository.findByGuid(id).get());
  }

  public PropertyViewModel update(UUID id, PropertyModel model) {
    return getModel(
        propertiesRepository.save(getEntity(model, propertiesRepository.findByGuid(id).get())));
  }

  public void delete(UUID id) {
    propertiesRepository.deleteByGuid(id);
  }

  public Page<PropertyViewModel> get(Pageable pageable, String application) {
    var dbItems =
        StringUtils.hasLength(application)
            ? propertiesRepository.findByApplication(pageable, application)
            : propertiesRepository.findAll(pageable);
    return new PageImpl<>(
        dbItems.map(this::getModel).toList(), pageable, dbItems.getTotalElements());
  }

  private PropertyViewModel getModel(Property entity) {
    if (entity == null) {
      return null;
    }
    var model = new PropertyViewModel();
    if (StringUtils.hasLength(entity.getApplication())) {
      model.setApplication(entity.getApplication());
    }
    if (StringUtils.hasLength(entity.getKey())) {
      model.setKey(entity.getKey());
    }
    if (StringUtils.hasLength(entity.getProfile())) {
      model.setProfile(entity.getProfile());
    }
    if (StringUtils.hasLength(entity.getLabel())) {
      model.setLabel(entity.getLabel());
    }
    if (StringUtils.hasLength(entity.getValue())) {
      model.setValue(entity.getValue());
    }
  model.setUuid(entity.getGuid());
    return model;
  }

  private Property getEntity(PropertyModel property, Property entity) {
    if (entity == null) {
      entity = new Property();
      entity.setGuid(UUID.randomUUID());
    }
    if (StringUtils.hasLength(property.getApplication())) {
      entity.setApplication(property.getApplication());
    }
    if (StringUtils.hasLength(property.getKey())) {
      entity.setKey(property.getKey());
    }
    if (StringUtils.hasLength(property.getProfile())) {
      entity.setProfile(property.getProfile());
    }
    if (StringUtils.hasLength(property.getLabel())) {
      entity.setLabel(property.getLabel());
    }
    if (StringUtils.hasLength(property.getValue())) {
      entity.setValue(property.getValue());
    }
    return entity;
  }
}
