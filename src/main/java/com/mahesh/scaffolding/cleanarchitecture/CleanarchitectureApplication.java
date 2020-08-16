package com.mahesh.scaffolding.cleanarchitecture;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.Version;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.*;
import java.util.*;

import static com.mahesh.scaffolding.cleanarchitecture.Constants.*;

@SpringBootApplication
public class CleanarchitectureApplication implements ApplicationRunner {

    public static void main(String[] args) {
        SpringApplication.run(CleanarchitectureApplication.class, args);
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        Set<String> optionNames = args.getOptionNames();

        if (!validArguments(optionNames)) {
            System.out.println("Required Arguments are Missing!");
            return;
        }

        Configuration cfg = new Configuration(new Version("2.3.30"));

        cfg.setClassForTemplateLoading(CleanarchitectureApplication.class, "/");
        cfg.setDefaultEncoding("UTF-8");
        writeTemplate(cfg, args);
    }

    private void writeTemplate(Configuration cfg, ApplicationArguments arguments) throws IOException, TemplateException {
        Map<String, String> params = generateTemplateParams(arguments);
        List<TemplatePackageMapping> templatePackageMappings = new ArrayList<>();

        templatePackageMappings.add(new TemplatePackageMapping("controller.ftl", CONTROLLER_PACKAGE, CONTROLLER_CLASS, REST_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("addrequest.ftl", REQUEST_PACKAGE, ADD_REQUEST_CLASS, REST_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("entity.ftl", ENTITY_PACKAGE, ENTITY_CLASS, REPOSITORY_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("mapper.ftl", MAPPER_PACKAGE, MAPPER_CLASS, REPOSITORY_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("model.ftl", MODEL_PACKAGE, MODEL_CLASS, CONTRACTS_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("repo.ftl", REPO_PACKAGE, REPO_CLASS, CONTRACTS_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("repoimpl.ftl", REPO_IMPL_PACKAGE, REPO_IMPL_CLASS, REPOSITORY_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("restmapper.ftl", REST_MAPPER_PACKAGE, REST_MAPPER_CLASS, REST_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("updaterequest.ftl", REQUEST_PACKAGE, UPDATE_REQUEST_CLASS, REST_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("usecase.ftl", USECASE_PACKAGE, USECASE_CLASS, CONTRACTS_LAYER));
        templatePackageMappings.add(new TemplatePackageMapping("usecaseimpl.ftl", USECASE_IMPL_PACKAGE, USECASE_IMPL_CLASS, USECASES_LAYER));

        for (TemplatePackageMapping mapping : templatePackageMappings) {
            write(cfg.getTemplate(mapping.getTemplateName()), getLayerPath(arguments, mapping.getLayer())
                    + packageToPath(params, mapping.getPackageNameParamName()), params.get(mapping.getClassNameParamName()) + ".java", params);
        }
    }

    private String getLayerPath(ApplicationArguments arguments, String layer) {
        return arguments.getOptionValues(BASE_PATH).get(0) + File.separator + layer + File.separator + "src" +
                File.separator + "main" + File.separator + "java" + File.separator;
    }

    private String packageToPath(Map<String, String> params, String packageName) {
        return params.get(packageName).replaceAll("\\.", File.separator) + File.separator;
    }

    private void write(Template template, String basePath, String packagePath, Map<String, String> input) throws IOException, TemplateException {
        File file = new File(basePath);

        if (!file.exists()) {
            file.mkdirs();
        }

        Writer writer = new FileWriter(new File(basePath + packagePath));
        template.process(input, writer);
        writer.close();
    }

    private boolean validArguments(Set<String> args) {
        List<String> requiredArgs = Arrays.asList(BASE_ENDPOINT_PARAM, CLASS_NAME, BASE_PACKAGE, BASE_PATH, PACKAGE_NAME);
        long count = requiredArgs.stream().filter(arg -> args.contains(arg)).count();
        return count == requiredArgs.size();
    }

    private Map<String, String> generateTemplateParams(ApplicationArguments args) {
        Map<String, String> templateParams = new HashMap<>();
        templateParams.put(BASE_ENDPOINT, String.valueOf(args.getOptionValues(BASE_ENDPOINT_PARAM).get(0)));

        // packages
        templateParams.put(REQUEST_PACKAGE, getBasePackage(args) + ".request" );
        templateParams.put(CONTROLLER_PACKAGE, getBasePackage(args) + ".controller" );
        templateParams.put(ENTITY_PACKAGE, getBasePackage(args) + ".entity" );
        templateParams.put(MAPPER_PACKAGE, getBasePackage(args) + ".mapper" );
        templateParams.put(MODEL_PACKAGE, getBasePackage(args) + ".model" );
        templateParams.put(REPO_PACKAGE, getBasePackage(args) + ".repo" );
        templateParams.put(REPO_IMPL_PACKAGE, getBasePackage(args) + ".repo" );
        templateParams.put(REST_MAPPER_PACKAGE, getBasePackage(args) + ".mapper" );
        templateParams.put(USECASE_PACKAGE, getBasePackage(args) + ".usecase");
        templateParams.put(USECASE_IMPL_PACKAGE, getBasePackage(args));

        templateParams.put(ADD_REQUEST_CLASS, "Add" + args.getOptionValues(CLASS_NAME).get(0) + "Request");
        templateParams.put(UPDATE_REQUEST_CLASS, "Update" + args.getOptionValues(CLASS_NAME).get(0) + "Request");
        templateParams.put(CONTROLLER_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "Controller");
        templateParams.put(REST_MAPPER_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "RestMapper");

        templateParams.put(USECASE_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "UseCase");
        templateParams.put(MODEL_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "Model");
        templateParams.put(MAPPER_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "Mapper");
        templateParams.put(ENTITY_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "Entity");
        templateParams.put(REPO_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "Repo");
        templateParams.put(REPO_IMPL_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "RepoImpl");
        templateParams.put(USECASE_IMPL_CLASS, args.getOptionValues(CLASS_NAME).get(0) + "UseCaseImpl");

        templateParams.put(USECASE_IMPORT, templateParams.get(USECASE_PACKAGE) + "." + templateParams.get(USECASE_CLASS));
        templateParams.put(MODEL_IMPORT, templateParams.get(MODEL_PACKAGE) + "." + templateParams.get(MODEL_CLASS));
        templateParams.put(ENTITY_IMPORT, templateParams.get(ENTITY_PACKAGE) + "." + templateParams.get(ENTITY_CLASS));
        templateParams.put(REPO_IMPORT, templateParams.get(REPO_PACKAGE) + "." + templateParams.get(REPO_CLASS));
        templateParams.put(REST_MAPPER_IMPORT, templateParams.get(REST_MAPPER_PACKAGE) + "." + templateParams.get(REST_MAPPER_CLASS));
        templateParams.put(MAPPER_IMPORT, templateParams.get(MAPPER_PACKAGE) + "." + templateParams.get(MAPPER_CLASS));
        templateParams.put(ADD_REQUEST_IMPORT, templateParams.get(REQUEST_PACKAGE) + "." + templateParams.get(ADD_REQUEST_CLASS));
        templateParams.put(UPDATE_REQUEST_IMPORT, templateParams.get(REQUEST_PACKAGE) + "." + templateParams.get(UPDATE_REQUEST_CLASS));

        templateParams.put(CLASS_NAME, args.getOptionValues(CLASS_NAME).get(0));

        return templateParams;
    }

    private String getBasePackage(ApplicationArguments args) {
        return args.getOptionValues(BASE_PACKAGE).get(0) + "." + args.getOptionValues(PACKAGE_NAME).get(0);
    }
}
