### Создание проекта

1. Устанавливаем IntelliJ Idea (https://www.jetbrains.com/idea/download).

Котлин входит с состав IDE, начиная с версии 15.

2. Создаем новый проект в IntelliJ IDEA. 

![select kotlin](Pictures/create1.PNG?raw=true)

При создании выбираем язык - Котлин, и указываем __groupId__ и __artifactId__

![groupId and artifactId](Pictures/create2.PNG?raw=true)

3. В файле __build.gradle__ указываем зависимости

```groovy
group 'ru.touchin'
version '1.0-SNAPSHOT'

buildscript {
    ext.kotlin_version = '1.1.51'
    ext.spring_boot_version = '1.5.4.RELEASE'

    repositories {
        mavenCentral()
    }
    dependencies {
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath "org.springframework.boot:spring-boot-gradle-plugin:$spring_boot_version"
        classpath "org.jetbrains.kotlin:kotlin-allopen:$kotlin_version"
    }
}

apply plugin: 'kotlin'
apply plugin: 'kotlin-spring' //дает возможность опустить модификатор open для классов с аннотациями @Service, @Controller и т.д.
apply plugin: 'org.springframework.boot'

repositories {
    mavenCentral()
    jcenter()
}

dependencies {
    compile "org.jetbrains.kotlin:kotlin-stdlib-jre8:$kotlin_version"
    compile 'org.springframework.boot:spring-boot-starter-web'
}

compileKotlin {
    kotlinOptions.jvmTarget = "1.8"
}
compileTestKotlin {
    kotlinOptions.jvmTarget = "1.8"
}

```

3. Создаем структуру файлов, соотвествующую __groupId__. Наличие структуры файлов неободимо Spring Boot для сканирования компонентов.

4. Создаем класс __Application__ и функцию __main__, которая используется Spring Boot для запуска приложения.

```kotlin
package ru.touchin.test

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication

@SpringBootApplication
class Application

fun main(args: Array<String>) {
    SpringApplication.run(Application::class.java, *args)
}
```

5. Создаем тестовый контроллер. Лучше сразу создать для него отдельный package __"controllers"__.

В контроллере будет один get-метод, не принимающий никаких параметров.

```kotlin
package ru.touchin.test.controllers

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class GreetingController {

    @GetMapping("greeting")
    fun greeting() = ResponseEntity.ok("Hello")

}
```

6. Запускаем функцию _main_, это можно сделать, например, нажав на соотствующий значок возле функции main.

![run](Pictures/create3.PNG?raw=true)

7. Проверяем работу - в браузере переходим на страницу http://localhost:8080/greeting

![check](Pictures/create4.PNG?raw=true)

8. Создание файла настроек __application.properties__

В файле настрек можно указать порт для подключения или параметры подключения к базе.
Для создания файла нажимаем правой кнопкой на директорию resources -> New -> resource bundle -> указываем имя application и нажимаем OK

![app properties](Pictures/create5.PNG?raw=true)

9. Проверяем работу файла настроек

* добавим в файл строчку

server.port=8088

* после перезапуска сервера в браузере проверяем, что метод __greeting__ доступен при подключении к порту 8088 
http://localhost:8088/greeting

![check port](Pictures/create6.PNG?raw=true)
