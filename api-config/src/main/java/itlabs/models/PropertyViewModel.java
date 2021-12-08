package itlabs.models;

import java.util.UUID;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PropertyViewModel extends  PropertyModel{
   UUID uuid ;
}
