package ${mapperPackage};

import ${modelImport};
import ${entityImport};
import com.kimaya.mapper.ParentMapper;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public abstract class ${mapperClass} extends ParentMapper {
    public abstract ${modelClass} toModel(${entityClass} entity);

    public abstract List<${modelClass}> toModels(List<${entityClass}> entity);


    public abstract ${entityClass} toEntity(${modelClass} model);
}
