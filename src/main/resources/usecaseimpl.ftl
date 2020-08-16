package ${usecaseImplPackage};

import com.kimaya.model.SortModel;
import ${modelImport};
import ${repoImport};
import ${usecaseImport};
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("${usecaseImplClass?uncap_first}")
class ${usecaseImplClass} implements ${usecaseClass} {

    @Autowired
    private ${repoClass} ${repoClass?uncap_first};

    @Override
    public String create(${modelClass} model) {
        return ${repoClass?uncap_first}.create(model);
    }

    @Override
    public ${modelClass} getById(String id) {
        return ${repoClass?uncap_first}.getById(id);
    }

    @Override
    public ${modelClass} getByIdAndOrg(String id, String organisationId) {
        return ${repoClass?uncap_first}.getByIdAndOrg(id, organisationId);
    }

    @Override
    public void delete(String id) {
        ${repoClass?uncap_first}.delete(id);
    }

    @Override
    public void update(${modelClass} model) {
        ${repoClass?uncap_first}.update(model);
    }

    @Override
    public List<${modelClass}> getAll(String organisationId, List<SortModel> sort, Integer pageNumber, Integer pageSize) {
        return ${repoClass?uncap_first}.getAll(organisationId, sort, pageNumber, pageSize);
    }

    @Override
    public long count(String organisationId) {
        return ${repoClass?uncap_first}.count(organisationId);
    }
}
