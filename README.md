# clean-architecture-crud-scaffolding
Generate CRUD for clean architecture for Spring Boot Apps

Usage : ```java -jar cleanarchitecture-scaffolding.jar  --baseEndpoint=test --packageName=feature --basePackage=com.mbz.test --basePath=/tmp/test --className=Feature```

* `baseEndpoint` -> Base Endpoint
* `packageName` -> package name to be used in all layers
* `basePackage` -> base package of all the layers
* `basePath` -> root path of the project dir
* `className` -> class name to be used in generated files

It will create directories automatically at any level if needed

After Running above command the following directory tree will be generated

---------------------------------
```
project (/tmp/test)
│
└───contracts
│   └───src/main/java/com/mbz/test/feature/
│       └───model
│           │   FeatureModel.java
│       └───repo
│           │   FeatureRepo.java
│       └───usecase
│           │   FeatureUseCase
└───repository
│   └───src/main/java/com/mbz/test/feature/
│       └───entity
│           │   FeatureEntity.java
│       └───mapper
│           │   FeatureMapper.java
│       └───repo
│           │   FeatureRepoImpl
└───rest-delivery
│   └───src/main/java/com/mbz/test/feature/
│       └───controller
│           │   FeatureController.java
│       └───request
│           │   AddFeatureRequest.java
│           │   UpdateFeatureRequest.java
│       └───mapper
│           │   FeatureRestMapper
└───usecases
│   └───src/main/java/com/mbz/test/feature/
│       │   FeatureUseCaseImpl.java
```
--------------------------------------------

Happy Coding :wink:
