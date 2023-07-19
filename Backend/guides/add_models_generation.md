# Генерация dto

  Файлы с api-моделями из апи-генератора создаются в папке **/src/main/kotlin/&lt;package-name&gt;/api**.
  
  Для автогенерации необходимо:
  
  1. Подключить [Build-Scripts](https://github.com/TouchInstinct/Styleguide/blob/feature/api_generation_for_kotlin_server/Backend/guides/add_build_scripts.md)
  
  2. В файле **build.gradle** прописать:
  * rootProject.extensions.pathToApiSchemes - путь к схеме API
  * rootProject.extensions.apiPackageName - package-name, должен соответствовать структуре папок в /src/main/kotlin/
  * подключить .gradle файл с генератором серверых моделей из BuildScripts и сделать зависимость таски compileKotlin от генерации моделей
```groovy
//в конце файла
ext.buildScriptsDir = "$rootProject.projectDir/libraries/BuildScripts"
apply from: "${rootDir}/libraries/BuildScripts/gradle/staticAnalysis.gradle"

rootProject.extensions.pathToApiSchemes = "${rootDir}/libraries/VTBAccounting-common/api"
rootProject.extensions.apiPackageName = "ru.vtb.middleware.dto"
apply from: "$buildScriptsDir/gradle/apiGeneratorKotlinServer.gradle"

compileKotlin.dependsOn generateApiModelsKotlinServer
```

3. Модели сгенерятся при следующем запуске build
