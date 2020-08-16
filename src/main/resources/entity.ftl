package ${entityPackage};

import com.kimaya.entity.CommonFieldEntityMongo;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;

@Getter
@Setter
public class ${entityClass} extends CommonFieldEntityMongo {
    private ObjectId id;
}
