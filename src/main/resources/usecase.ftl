package ${usecasePackage};

import com.kimaya.model.SortModel;
import ${modelImport};

import java.util.List;

public interface ${usecaseClass} {
    String create(${modelClass} model);

    ${modelClass} getById(String id);

    ${modelClass} getByIdAndOrg(String id, String organisationId);

    void delete(String id);

    void update(${modelClass} model);

    List<${modelClass}> getAll(String organisationId, List<SortModel> sort, Integer pageNumber, Integer pageSize);

    long count(String organisationId);
}
