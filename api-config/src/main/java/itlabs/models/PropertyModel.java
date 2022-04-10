package itlabs.models;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PropertyModel {

  @ApiModelProperty(notes = "application properties value", example = "WARN")
  String value;

  @ApiModelProperty(notes = "application properties key format", example = "logging.level.root")
  String key;

  @ApiModelProperty(notes = "active profile", example = "default")
  String profile;

  @ApiModelProperty(notes = "application name ", example = "application")
  String application;

  @ApiModelProperty(notes = "branch or feature name", example = "master")
  String label = "master";
}
