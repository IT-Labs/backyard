package itlabs.controllers;

import io.swagger.annotations.Api;
import itlabs.models.PropertyModel;
import itlabs.models.PropertyViewModel;
import itlabs.services.NotificationService;
import itlabs.services.PropertiesService;
import java.util.UUID;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.annotations.ApiIgnore;

@Api
@Slf4j
@RequestMapping(Routes.JDBC_PROPERTIES_ROUTE)
@RestController
public class JdbcPropertiesController {

  private final PropertiesService propertiesService;

  private final NotificationService notificationService;

  ;

  public JdbcPropertiesController(
      PropertiesService propertiesService, NotificationService notificationService) {
    this.propertiesService = propertiesService;
    this.notificationService = notificationService;
  }

  @GetMapping
  public Page<PropertyViewModel> get(
      @ApiIgnore Pageable pageable, @RequestParam(required = false) String application) {
    return propertiesService.get(pageable, application);
  }

  @PostMapping
  public ResponseEntity<PropertyViewModel> post(
      @RequestBody @Validated PropertyModel model, @RequestHeader HttpHeaders headers) {
    final var propertyViewModel = propertiesService.save(model);
    notificationService.notifyApplicationsForConfigurationChange(headers, model.getApplication());
    return new ResponseEntity<>(propertyViewModel, HttpStatus.CREATED);
  }

  @GetMapping(path = "/{id}")
  public ResponseEntity<PropertyViewModel> getItem(@PathVariable("id") UUID id) {
    return new ResponseEntity<>(propertiesService.get(id).get(), HttpStatus.OK);
  }

  @PutMapping(path = "/{id}")
  public ResponseEntity<PropertyViewModel> put(
      @PathVariable("id") UUID id,
      @RequestBody PropertyModel model,
      @RequestHeader HttpHeaders headers) {
    final var update = propertiesService.update(id, model);
    notificationService.notifyApplicationsForConfigurationChange(headers, model.getApplication());
    return new ResponseEntity<>(update, HttpStatus.CREATED);
  }

  @DeleteMapping(path = "/{id}")
  public ResponseEntity<String> delete(
      @PathVariable("id") UUID id, @RequestHeader HttpHeaders headers) {
    propertiesService
        .get(id)
        .ifPresent(
            model -> {
              propertiesService.delete(id);
              notificationService.notifyApplicationsForConfigurationChange(
                  headers, model.getApplication());
            });
    return new ResponseEntity<>("deleted", HttpStatus.NO_CONTENT);
  }
}
