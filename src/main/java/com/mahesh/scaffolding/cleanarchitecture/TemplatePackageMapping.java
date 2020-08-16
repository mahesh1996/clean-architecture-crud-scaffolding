package com.mahesh.scaffolding.cleanarchitecture;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TemplatePackageMapping {
    private String templateName;
    private String packageNameParamName;
    private String classNameParamName;
    private String layer;

    public TemplatePackageMapping(String templateName, String packageNameParamName, String classNameVariableName, String layer) {
        this.templateName = templateName;
        this.packageNameParamName = packageNameParamName;
        this.classNameParamName = classNameVariableName;
        this.layer = layer;
    }
}
