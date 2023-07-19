# Fastlane cheat sheet

## Загрузка билда в AppStore

Установка версии приложения:

```sh
fastlane run increment_version_number version_number:XXXX
```

Установка номера билда:

```sh
fastlane run increment_build_number build_number:XXXX
```

Сборка и загрузка в AppStore:

```sh
fastlane AppStoreRelease
```

## Установка сертификатов и provision profile'ов

Для сборки на девайс:

```sh
fastlane SyncCodeSigning
```

Для сборки в AppStore:

```sh
fastlane SyncCodeSigning type:appstore
```

## Генерация пуш сертификатов

Для development окружения:

```sh
fastlane CreatePushCertificate
```

Для appstore окружения:

```sh
fastlane CreatePushCertificate type:appstore development:false
```

Для appstore окружения с development сертификатом:

```sh
fastlane CreatePushCertificate type:appstore
```

## Создание сертификатов и provision profile'ов для нового приложения в аккаунте клиента

```sh
fastlane SyncCodeSigning type:appstore readonly:false
```

## Добавление или обновление существующих сертификатов и provision profile'ов

```sh
fastlane ManuallyUpdateCodeSigning
```

## Обновление dSYM в Firebase

### Загрузка dSYM из AppStore в Firebase

```sh
bundle exec fastlane SyncSymbols type:appstore
```

### Загрузка локальных dSYM в Firebase

```sh
bundle exec fastlane SyncSymbols type:enterprise
```