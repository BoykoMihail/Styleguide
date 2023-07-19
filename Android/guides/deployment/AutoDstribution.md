# Автоматизированный релиз в Play Store

## Для андройда:

На стороне приложения необходимо убедиться в наличии плагина `com.github.triplet.play`
в `app` модуле и `serviceAccountCredentials`:

```
play {
    serviceAccountCredentials = file("полный путь на сервере до json с api ключём от стора")
}
```

## Для CI:

Перед тем, как заработает плагин для публикации, должны быть соблюдены следующие критерии:

     1. У приложения полностью заполнена страница в сторе
     2. Первая версия приложения выложена вручную, в любой из треков
 
Перед публикацией необходимо выполнить ```./gradlew bootstrap``` для инициализации плагина, перевод из одного трека работает и без неё.

Публикация альфа версии происходит через таск `publish(Apk|Bundle)`:

``` ./gradlew publishApk --artifact-dir полный/путь/до/артефакта --track alpha ```

или

``` ./gradlew publishBundle --artifact-dir полный/путь/до/артефакта --track alpha ```

ВАЖНО:  **ВСЕ** артефакты из ```--artifact-dir``` будут опубликованы (все apk или все бандлы)

Для перевода версии приложения из альфы в релиз:

``` ./gradlew promoteArtifact --from-track alpha --promote-track production ```

### Release notes:

Файл должен находится по пути: `src/main/play/release-notes/ru-RU/[track].txt`

где `track` в нашем случае либо `alpha` либо `production`. Вместо конкретного трека можно указать `default`, из `default.txt`
будут взяты release notes, если нет файла с конкретным треком. 

Пример: по заданному пути есть два файла `alpha.txt` и `default.txt` при `publish --track alpha` release notes будут взяты из `alpha.txt`, при `promoteArtifact` в `production` будут взяты из `default.txt`

`ru-RU` - код языка, может быть любым из [поддерживаемых гуглом](https://support.google.com/googleplay/android-developer/answer/3125566). Для каждого языка свои release notes
