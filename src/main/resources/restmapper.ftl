package ${restMapperPackage};

import ${modelImport};
import ${addRequestImport};
import ${updateRequestImport};
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public abstract class ${restMapperClass} {
    public abstract ${modelClass} toModel(${addRequestClass} request);

    public abstract void toModel(${updateRequestClass} request, @MappingTarget ${modelClass} model);
}
