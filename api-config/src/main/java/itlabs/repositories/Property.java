package itlabs.repositories;

import javax.persistence.Entity;
import javax.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "properties")
public class  Property extends  BaseEntity {

    String value;
    String key;
    String profile;
    String application;
    String label;
}
