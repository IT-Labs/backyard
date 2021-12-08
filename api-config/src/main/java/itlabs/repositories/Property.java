package itlabs.repositories;

import javax.persistence.Entity;
import javax.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Data
@Table(name = "properties")
@EqualsAndHashCode(callSuper=false)
public class  Property extends  BaseEntity {

    String value;
    String key;
    String profile;
    String application;
    String label;
}
