package ${controllerPackage};

import ${usecaseImport};
import ${modelImport};
import ${restMapperImport};
import ${addRequestImport};
import ${updateRequestImport};
import com.kimaya.request.PaginationRequest;
import com.kimaya.request.RequestWrapper;
import com.kimaya.response.CommonAddResponse;
import com.kimaya.response.CommonGetResponse;
import com.kimaya.response.CommonListWithCountResponse;
import com.kimaya.response.ParentResponse;
import com.kimaya.utils.RestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RequestMapping("${baseEndpoint}")
@RestController("${controllerClass?uncap_first}")
public class ${controllerClass} {

    @Autowired
    private ${restMapperClass} mapper;

    @Autowired
    private ${usecaseClass} ${usecaseClass?uncap_first};

    @PostMapping("create")
    public ParentResponse create(@RequestBody @Valid ${addRequestClass} request, @RequestAttribute RequestWrapper requestWrapper) {
        ${modelClass} model = mapper.toModel(request);
        model.setOrganisationId(requestWrapper.getOrganisationId());
        RestUtils.setRequestMetaData(model, requestWrapper);
        String id = ${usecaseClass?uncap_first}.create(model);
        return new CommonAddResponse(200, "Successfully Done", "Successfully Done", id);
    }

    @PutMapping("update")
    public ParentResponse update(@RequestBody @Valid ${updateRequestClass} request, @RequestAttribute RequestWrapper requestWrapper) {
        ${modelClass} existingModel = ${usecaseClass?uncap_first}.getByIdAndOrg(request.getId(), requestWrapper.getOrganisationId());
        mapper.toModel(request, existingModel);
        RestUtils.setModificationMetaData(existingModel, requestWrapper);
        ${usecaseClass?uncap_first}.update(existingModel);
        return new ParentResponse(200, "Successfully Done", "Successfully Done");
    }

    @GetMapping("get/{id}")
    public ParentResponse get(@PathVariable String id, @RequestAttribute RequestWrapper requestWrapper) {
        ${modelClass} existingModel = ${usecaseClass?uncap_first}.getByIdAndOrg(id, requestWrapper.getOrganisationId());
        RestUtils.unsetMetaData(existingModel);
        return new CommonGetResponse(200, "Successfully Done", "Successfully Done", existingModel);
    }

    @PostMapping("getAll")
    public ParentResponse get(@RequestBody @Valid PaginationRequest request, @RequestAttribute RequestWrapper requestWrapper) {
        List<${modelClass}> records = ${usecaseClass?uncap_first}.getAll(requestWrapper.getOrganisationId(), request.getSort(), request.getPageNumber(), request.getPageSize());
        long count = ${usecaseClass?uncap_first}.count(requestWrapper.getOrganisationId());
        RestUtils.unsetMetaData(records);
        return new CommonListWithCountResponse(200, "Successfully Done", "Successfully Done", records, count);
    }

    @DeleteMapping("delete/{id}")
    public ParentResponse delete(@PathVariable String id, @RequestAttribute RequestWrapper requestWrapper) {
        ${usecaseClass?uncap_first}.delete(id);
        return new ParentResponse(200, "Successfully Done", "Successfully Done");
    }
}
