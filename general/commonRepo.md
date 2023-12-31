# Common репозиторий

## Что это такое

Это репозиторий, который хранит общие данные между несколькими платформами одного проекта. Примеры данных:

- строки
- api-спецификацию сервера
- структуированные данные в виде json-файла
- картинки и другие ресурсы

Репозиторий называется ProjectName-common, где ProjectName — имя проекта.

Репозиторий должен быть организован следующим образом:
- схемы апи должны находиться в папке api
- строки должны находиться в папке strings

```
ProjectName-common
├─ api
│  ├─ main.json
│  ├─ generation.meta.json
│  ├─ methods
│  └─ structures
└─ strings
   ├─ default_common_strings_en.json
   ├─ common_strings_de.json
   └─ common_strings_fr.json
```

## Wiki

База знаний проекта должна находится в wiki common репозитория. База знаний нужна для того, чтобы [bus factor](https://ru.wikipedia.org/wiki/%D0%A4%D0%B0%D0%BA%D1%82%D0%BE%D1%80_%D0%B0%D0%B2%D1%82%D0%BE%D0%B1%D1%83%D1%81%D0%B0) был больше единицы. В базу знаний должны входить следующие данные:

- ссылки на макеты, апи спецификации, ТЗ и таблицы
- url'ы серверов
- аккаунты к внешним сервисам
- тестовые аккаунты ко всем серверам
- и любая другая информация, которая необходима для работы на проекте.

Ответственный за поддержание wiki в актуальном состоянии - техлид или менеджер проекта, в случае отсутствия техлида.

## Чаты

Все изменения в репозитории должны пройти через pull request. PR должен проверить по одному разработчику с каждой платформы. На каждом проекте есть чат common. В этот чат можно отправлять PR на проверку. В сообщении обязательно должно быть протэганы ревьюеры. 

Чтобы вас добавили в чат, попросите лидов платформ или разработчиков, которые уже есть в этом чате.

## Общие правила работы с гитом

В целом, правила аналогичны тем, что описаны в статье ["Как работать с Гитом"](gitGuide.md). Но есть нюанс.
 
При создании PR develop (project) -> master (project):

- должен быть создан PR develop (common) -> master (common)
- сабмодуль common в этот момент ссылается на ветку develop (common)
- после релиза приложения в сторе просиходит:
	-  мерж develop (common) -> master (common)
	-  обновление сабмодуля common в ветке develop
	-  мерж develop (project) -> master (project)

## Как не сломать жизнь другой платформе

Ваш пул может помешать работе приложения у других разработчиков. Например, если вы изменяете название строки или удаляете поле в модельке. Такие изменения могут поломать сборку проекта. В таком случае необходимо сообщить всем разработчикам на проекте о данном изменении.

Ответственность за обновление, помимо разработчика, отправившего *pull request*, берет на себя разработчик, поставивший *approve*, либо ответственность делигируется другому разработчику и закрепляется в пуле. Например, в пуле пишем "Строки мигрирует *@kopytovs* потому что <...>". Таким образом, человек, ответственный за попадание проблемных строк, должен обновить ветку *develop* для компиляции проекта с новыми строками.

## Как называть файлы строк

Файл, содержащий строки для конкретного языка должен называться common_strings_langId.json, где langId - 
идентификатор языка по стандарту [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1). Например, файл, содержащий английские строки, должен называться common_strings_en.json

Файл, содержащий строки на языке по умолчанию, должен называться default_common_strings_langId.json.

Если ваш проект использует только русские строки, будет достаточно файла default_common_strings_ru.json.

## Полезные ссылки:
- [Правила именования строк](CommonNamingConvention.md)
- [Спецификация апи генератора в таче](/Backend/guides/api_scheme_specification_guide.md)
