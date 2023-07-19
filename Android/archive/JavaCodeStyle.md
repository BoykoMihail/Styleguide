# Touch Instinct Android Style Guide

## Данный гайд формализует основные соглашения по написанию базовых кодовых конструкций в компании Touch Instinct.


### Ссылки на основы
  - [Java codestyle](https://google-styleguide.googlecode.com/svn-history/r130/trunk/javaguide.html)
  - [Android resources management](http://developer.android.com/intl/ru/guide/topics/resources/index.html)
  - Венгерская нотация запрещена! [Что это?](https://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D0%B3%D0%B5%D1%80%D1%81%D0%BA%D0%B0%D1%8F_%D0%BD%D0%BE%D1%82%D0%B0%D1%86%D0%B8%D1%8F)
 
### Порядок расположения членов класса
1. Константы (private static final Object CONST = "CONST";)
2. Статические поля (private static myStaticField;)
3. Статический конструктор (static { })
4. Статические методы (private static method() { })
5. Поля (private myField;)
6. Конструкторы (private MyClass() { })
7. Методы (private method() { })
8. Вложенные классы/интерфейсы/enum'ы

Порядок расположения конкретных членов группы не важен, но приветствуется расположение, соответствующее определенной логике (например, метод onStart идет перед методом onStop)
Между всеми членами, кроме полей и констант обязателен разделитель строки. Также разделитель должен быть в конце и начале власса.

### Именования специфичных для Android строковых констант
1. Имя константы должно содержать постфикс, объясняющий, зачем она используется.
  - постфикс _ARG для аргументов фрагмента (getArguments()) и активити (getIntent().getExtras())
  - постфикс _EXTRA для информации, содержащейся в savedInstanceState
  - постфикс _KEY для ключа в SharedPreferences
2. Значение константы должно совпадать с ее именем

Примеры:
  - `private static final ARTICLE_ID_ARG = "ARTICLE_ID_ARG";`
  - `private static final SELECTED_POSITION_EXTRA = "SELECTED_POSITION_EXTRA";`
  - `private static final USER_SESSION_ID_KEY = "USER_SESSION_ID_KEY";`

### Именование ресурсов приложения
Все ресурсы, кроме стилей и названия аттрибутов пишутся в нижнем регистре с подчеркиваниями (прим. my_resource_name).

Стили и названия аттрибутов - в стиле CamelCase (MyStyleName).

Сокращения (_ic, _btn, _lft, _rect, _bg) не приветствуются, так как в большинстве своем не стандартизированы. Используйте полные названия.

#### Именование файлов разметки (layout)
1. Префикс, описывающий, как используется layout
 - activity_ - в качестве разметки Activity
 - fragment_ - в качетсве разметки Fragment
 - item_ - в качестве разметки элемента списка
 - page_ - в качестве разметки элемента ViewPager/ViewFlipper/ViewSwitcher
 - view_ - в качестве разметки кастомной View
 - block_ - в качестве переиспользуемой в других разметках части (тегами include/merge)
 - part_ - в качестве части конеретной другой разметки, если она слишком сложная и разбита на части (тегами include/merge)
2. Средняя часть, описывающая область использования (обычно, название экрана или модуля). Например _player или _tutorial.
3. Постфикс (не обязательный), описывающий, что это. Например _friend_message.
 
Примеры:
  - `activity_player`
  - `fragment_player_settings`
  - `page_player_song_info`

#### Именование идентификаторов (ID) элементов разметки
Идентификаторы должны быть уникальными в рамках приложения, поэтому проще всего ставить префиксом часть названия разметки, в которых они используются. Например, если есть экран проигрывания музыки, в котором содержатся разметки fragment_player и item_player_song, то для обозначения названия трека в первой разметке можно использовать идентификатор fragment_player_song_title или просто player_song_title, а во второй разметке - item_player_song_title.

#### Именование строк, изображений и других ресурсов
По аналогии с [общим именованием строк и изображений](https://github.com/TouchInstinct/Styleguide/blob/master/Strings-And-Images-Naming-Rules.md)
