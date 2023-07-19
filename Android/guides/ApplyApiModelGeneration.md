# Подключение генератора моделей api

1. Подключаем [Build-Scripts](https://github.com/TouchInstinct/BuildScripts) в проект, если еще не сделано:
2. В конец build.gradle(модуля) импортируем генератор строк, например:: 
```groovy
apply plugin: 'com.android.application'
android {
  ...
}
dependencies{
  ...
}
apply from: "${rootDir}/libraries/BuildScripts/gradle/apiGenerator.gradle"
```

4. Указываем путь к json-схеме моделей:
```groovy
apply plugin: 'com.android.application'
android {
  ...
  {
    defaultConfig {
      rootProject.extensions.pathToApiSchemes = "${rootDir}/common/PartiyaEdi-common/schemes"
    }
  }

}
dependencies{
  ...
}

apply from: "${rootDir}/libraries/BuildScripts/gradle/apiGenerator.gradle"
```