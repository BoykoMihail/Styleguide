# Подключение генератора строк

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
apply from: "${rootDir}/libraries/BuildScripts/gradle/stringGenerator.gradle"
```
3. Указываем на каком этапе сборки проекта будут генерироваться строки
```groovy
apply plugin: 'com.android.application'
android {
  ...
}
dependencies{
  ...
}

gradle.projectsEvaluated { preBuild.dependsOn('stringGenerator') }

apply from: "${rootDir}/libraries/BuildScripts/gradle/stringGenerator.gradle"
```

4. Описываем какие языки будут использоваться и где будет лежать json-схема с текстами:
```groovy
apply plugin: 'com.android.application'
android {
  ...
  extensions.languageMap = [
  "ru": "common/example-common/common_strings_ru.json",
  "de": "common/example-common/common_strings_de.json"
]

}
dependencies{
  ...
}

gradle.projectsEvaluated { preBuild.dependsOn('stringGenerator') }

apply from: "${rootDir}/libraries/BuildScripts/gradle/stringGenerator.gradle"
```

Язык "по умолчанию" выбирается следующим путем:

  - если есть английский(en), то используется он;
  - если нет английского и есть русский(ru), то используется он;
  - если нет ru или en, то используется первый, определенный в схеме.

В случае если велась работа с несколькими языками, но потом от какого-либо пришлось отказаться, то сгенерированный файл строк необходимо удалить самостоятельно.

Если в ходе конвертации обнаружится, что в каком-либо файле будет нехватить ключей, то генерация будет прервана и список ключей можно будет увидеть в логах.