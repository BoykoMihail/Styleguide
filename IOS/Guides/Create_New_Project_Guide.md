# Разворачивание проекта необходимо выполнять только [скриптом](https://github.com/TouchInstinct/project-template-ios#Разворачивание-нового-проекта)

Остальные шаги приведены здесь для ясности

## Нейминг

Подробнее о нейминге *bundle_id* и основных файлов можно прочитать [здесь](Naming_Agreement.md)

## Файловая структура проекта

Проект должен включать в себя следующие основные разделы (то есть папки на диске и, соответствующие им, группы в дереве проекта):

- Appearance (включает конфигурацию шрифтов, цветов, начертаний)
- Controllers
- Extensions
- Services
- Views (включает в себя все классы, отнаследованные от `UIView`)
- Сells (включает в себя все классы, отнаследованные от `UITableViewCell/UICollectionViewCell`)
- Models
- Protocols
- Networking
- Resourses (включает в себя файлы .xcassets, а также файлы локализации)

Optional: (Должны присутствовать при создании проекта, но должны быть удалены при первом релизе, если являются пустыми).

- Analytics
- Realm (включает в себя модели Realm, а также базовые сервисы для работы с Realm).

Разделы в дереве проекта должны быть отсортированы в алфавитном порядке.

Для контроллеров используется xib файлы. Все классы-наследники от `UITableViewCell/UICollectionViewCell` должны быть сделаны c использованием xib. 

Файл AppDelegate не должен относиться к какой-либо папке и должен находиться в корне проекта.

## Настройка podfile проекта

Необходимо добавить .gitignore файл в проект. 

## Подключение Fabric/Crashlitycs к проекту

[Здесь](Fabric_Guide.md) написана пошаговая инструкция, помогающая подключить данный framework к проекту.

## Настройка shared scheme в проекте

Для того, чтобы работали системы CI (continuous integration) в проекте, необходимо сделать следующее.

В xcode в запущенном проекте выбрать вкладку Product -> Scheme -> Manage schemes.

Далее выбрать корневую схему проекта (её название совпадает с названием проекта), в графе "Container" выбрать workspace. А в графе "Shared" поставить напротив данной схемы галочку.

## Настройка build configurations проекта

Подробнее о настройках конфигураций в проекте рассказано [здесь](https://github.com/TouchInstinct/Styleguide/blob/master/IOS/Guides/Xcode_Build_Configurations_Guide.md)

## Подключение generamba в проект

Подробнее о добавлении конфигурационного файла рассказано [здесь](https://github.com/TouchInstinct/Styleguide/blob/master/IOS/Guides/Generamba_Guide.md)

## Подключение сабмодулей

Добавьте в проект следующие сабмодули с указанными именами:

Имя | Ссылка
-- | --
common | git@github.com:TouchInstinct/ProjectName-common.git
build-scripts | git@github.com:TouchInstinct/BuildScripts.git

- **common** – общий репозиторий. Содержит строки и схемы для апи генератора. ProjectName – имя вашего проекта.
- **build-scripts** содержит скрипты для билд фаз.

## Подключение скриптов билд фаз

Подробное руководство по подключению скриптов билд фаз находится [здесь](BuildScripts/Build_Scripts_Guide.md).

## Настройка `fastlane`

[`Fastlane`](https://docs.fastlane.tools) позволяет автоматизировать сборку приложения. При создании нового проекта необходимо [настроить fastlane](Fastlane_Guide.md).
