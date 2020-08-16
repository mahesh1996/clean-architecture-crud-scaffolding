package ${repoImplPackage};

import com.kimaya.model.SortDirection;
import com.kimaya.model.SortModel;
import ${entityImport};
import ${mapperImport};
import ${modelImport};
import ${repoImport};
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import org.springframework.util.ObjectUtils;

import java.util.List;
import java.util.stream.Collectors;

@Repository("${repoImplClass?uncap_first}")
@Profile("mongo")
class ${repoImplClass} implements ${repoClass} {
    
    @Autowired
    private ${mapperClass} mapper;
    
    @Autowired
    private MongoTemplate mongoTemplate;
    
    @Value("${className?uncap_first}")
    private String collection;
    
    private Class<${entityClass}> clazz = ${entityClass}.class;
    
    @Override
    public String create(${modelClass} model) {
        ${entityClass} entity = mapper.toEntity(model);
        mongoTemplate.insert(entity, collection);
        return entity.getId().toString();
    }
    
    @Override
    public ${modelClass} getById(String id) {
        Query query = Query.query(Criteria.where("_id").is(new ObjectId(id)).and("deleted").is(false));
        return mapper.toModel(mongoTemplate.findOne(query, clazz, collection));
    }

    @Override
    public ${modelClass} getByIdAndOrg(String id, String organisationId) {
        Query query = Query.query(Criteria.where("_id").is(new ObjectId(id)).and("deleted").is(false)
                            .and("organisationId").is(new ObjectId(organisationId)));
        return mapper.toModel(mongoTemplate.findOne(query, clazz, collection));
    }
    
    @Override
    public void delete(String id) {
        Query query = Query.query(Criteria.where("_id").is(new ObjectId(id)));
        Update update = Update.update("deleted", true);
        mongoTemplate.updateFirst(query, update, clazz, collection);
    }
    
    @Override
    public void update(${modelClass} model) {
        mongoTemplate.save(model, collection);
    }
    
    @Override
    public List<${modelClass}> getAll(String organisationId, List<SortModel> sort, Integer pageNumber, Integer pageSize) {
        Criteria criteria = getCriteria(organisationId);
        Query query = Query.query(criteria);

        if (!ObjectUtils.isEmpty(sort)) {
            List<Sort.Order> orders = sort.stream().map(s -> new Sort.Order(s.getDirection().equals(SortDirection.ASC) ? Sort.Direction.ASC : Sort.Direction.DESC, s.getProperty())).collect(Collectors.toList());
            query.with(Sort.by(orders));
        } else {
            query.with(Sort.by(Sort.Direction.DESC, "createdOn"));
        }

        if (!ObjectUtils.isEmpty(pageNumber) && !ObjectUtils.isEmpty(pageSize) && pageNumber != -1 && pageSize != -1) {
            query.with(PageRequest.of(pageNumber, pageSize));
        }

        return mapper.toModels(mongoTemplate.find(query, clazz, collection));
    }

    @Override
    public long count(String organisationId) {
        return mongoTemplate.count(Query.query(getCriteria(organisationId)), clazz, collection);
    }

    private Criteria getCriteria(String organisationId) {
        return Criteria.where("organisationId").is(new ObjectId(organisationId)).and("deleted").is(false);
    }
}
