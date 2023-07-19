# Установка `api-generator`

## Установка/Обновление java

Необходимо убедиться, что на локальной машине стоит **java**

```
java -version
```

Если **java** не установлена, то его можно будет скачать [здесь](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

## Использование в проекте

### Подключение сабмодуля для генератора

Для работы генератора в проекте должен быть подключен сабмодуль [__common__](https://github.com/TouchInstinct/Styleguide/blob/master/general/commonRepo.md) (общий репозиторий для проекта, который содержит схемы для генератора). Ссылки на репозиторий указаны в [гайде по созданию проекта](Create_New_Project_Guide.md).

## Как использовать в ios проекте

Для использования в ios проекте, необходимо [добавить](BuildScripts/Build_Scripts_Guide.md) соответствующую билд фазу.
