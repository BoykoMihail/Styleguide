# Подключение BuildScripts

1. Подключаем [Build-Scripts](https://github.com/TouchInstinct/BuildScripts) в проект в качестве сабмодуля в подпапке libraries/BuildScripts
Для подключения можно использовать GitKraken

2. Проверяем, что в проекте версия Gradle 4.9 и выше

3. В build.gradle подключаем скрипты:
```groovy
buildscript {
...
    repositories {
        ...
        maven { url "https://plugins.gradle.org/m2/" }
    }

    dependencies {
        classpath 'de.aaschmid:gradle-cpd-plugin:1.0'
        classpath "io.gitlab.arturbosch.detekt:detekt-gradle-plugin:1.0.0-RC12"
    }

}

repositories {
    ...
    maven { url "https://plugins.gradle.org/m2/" }
}

...

//в конце файла
ext.buildScriptsDir = "$rootProject.projectDir/libraries/BuildScripts"
apply from: "${rootDir}/libraries/BuildScripts/gradle/staticAnalysis.gradle"
```
4. Проверяем работу выполнением комнады
```
./gradlew sSA
```
