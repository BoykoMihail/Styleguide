# Чеклист нового Android тачонка.

Привет! Добро пожаловать в Touch Instinct. Чтобы начать работу, нужно прочитать много гайдов и статей, подготовить рабочее место и познакомиться с командой.

## Что тебе нужно с нашей стороны

Необходимо запросить доступ в приватные репозитории компании на github.com, получить корпоративную электронную почту, логин в jira. Всем этим занимается технический директор - @sevaask в Telegram. Нужно написать ему.

Также мы прикрепим тебя к проекту. На проекте ты будешь потихоньку внедряться в рабочий процесс. Если ты еще не знаешь название проекта, доставай лида каждые пять минут - @maxbach в Telegram. Лид должен познакомить с менеджером, прислать репозитории.

В Telegram у нас много важных чатов, куда тебя нужно добавить:

* общий канал для всех тачат с новостями компании

* чат android команды

* чат учета девайсов

* чат твоего проекта

## Софт и настройка рабочего места

Пока Сева создает тебе аккаунты, нужно настроить рабочий компьютер.

### Android Studio.

1. Установи JDK8 и пропиши JAVA_HOME. Гайд для [Ubuntu](https://thishosting.rocks/install-java-ubuntu/), [Mac](https://docs.oracle.com/javase/8/docs/technotes/guides/install/mac_jdk.html), [Windows](https://www.fandroid.info/ustanovka-jdk-java-development-kit/).

2. [Скачай](https://developer.android.com/studio) и [установи](https://developer.android.com/studio/install) последнюю стабильную версию студии.

3. Установи в студию наш [плагин](https://github.com/arso8/StAnalysisRunner) для static analysis. Чуть позже ты прочитаешь, что это такое.

4. Когда у тебя появится доступ к гитхабу, установи по [гайду](guides/StudioRemoteSettings.md) Remote Configs в студию.

5. Для продуктивной работы нужно хорошо знать студию. Почитай про [лайфхаки](https://proglib.io/p/android-studio-tricks/) и [shortcuts](https://medium.com/mindorks/11-android-studio-shortcuts-every-android-developer-must-know-a153e736e611).

### Git

1. Если нет git аккаунта, то создать новый [тут](https://github.com/). Далее обратиться к CTO/Dev Lead с целью добавить данный аккаунт в репозиторий компании.

2. Также необходимо настроить SSH для Git-аккаунта. [Помощь](https://help.github.com/categories/ssh/)

3. Добавить GitHub аккаунт в Android Studio. [Помощь](https://www.jetbrains.com/help/idea/github.html)

4. Изучить, как работать удобно с git'ом в студии. [Статья1](https://www.jetbrains.com/help/idea/using-git-integration.html), [статья2](https://javarush.ru/groups/posts/767-rukovodstvo-poljhzovatelja-intellij-idea-osnovih-rabotih-s-sistemami-kontrolja-versiy).

Примечание: Никто тебя не заставляет использовать именно эти инструменты. Используй тот инструмент, который лучше всего подходит тебе. Но у нас в компании **запрещено использовать нелицензированное ПО**.

### Что еще установить

* Текстовый редактор. [Atom](https://atom.io/) или [Sublime](https://www.sublimetext.com/). Под них есть куча плагинов и скриптов для обработки текста

* [Charles](https://www.charlesproxy.com/). Для работы с API. Проксирование запросов, работает и на симуляторе и на девайсе. [Здесь](https://docs.google.com/document/d/1gDElDmLDg6HAm2js0ynfziuN6R279OvJnqmatn-dsQU/edit?usp=drivesdk) описано, как им пользоваться. В качестве альтернативы можно использовать [Profiler из студии](https://developer.android.com/studio/profile/network-profiler) или [mitmproxy](https://medium.com/sean3z/debugging-mobile-apps-with-mitmproxy-4596e56b3da2).

* [DBeaver](https://dbeaver.io/). Тулза для подключения к БД и работе с ними. [Здесь](/general/dbeaverCheatSheet.md) описано, как им пользоваться.

* [Postman](https://www.getpostman.com/downloads/). Утилита для отправки HTTP запросов.

* [Figma](https://www.figma.com). Здесь мы работаем с макетами. Создай аккаунт, если еще нет. Можно использовать веб-версию или скачать себе приложение.

* [Telegram](https://telegram.org/). Здесь мы общаемся. Чтобы спрятать чатики с мемами, почитай [это](https://teleggid.com/kak-gruppirovat-telegram-chaty/).

## Наши технологии, наш стек.

Настало время познакомится с инструментами, которые мы используем в повседневной работе. Если ты не знаком с технологией, почитай статеек или попроси помощи у лида.

|Название|Описание|Что почитать для ознакомления|
|--- |--- |--- |
|Kotlin|Основной язык программирования.|[Официальная документация](https://kotlinlang.org/docs/reference/)|
|Roboswag|Библиотека нашей компании. Ее обязательно нужно изучить.|[Репозиторий с кодом](https://github.com/TouchInstinct/RoboSwag)|
|AAC|Фреймворк от гугла, через который мы настраиваем MVVM.|[Документация про Lifecycle](https://developer.android.com/topic/libraries/architecture/lifecycle), [LiveData](https://developer.android.com/topic/libraries/architecture/livedata), [ViewModel](https://developer.android.com/topic/libraries/architecture/viewmodel), статья про нашу архитектуру *(скоро)*|
|RxJava 2|Инструмент для многопоточности и реактивного программирования.|[Документация](http://reactivex.io/documentation/operators.html ) (хорошое объяснение операторов), [статья1](https://habr.com/ru/post/265269/), [статья2](https://habr.com/ru/company/epam_systems/blog/353852/), [статья3](https://habr.com/ru/company/badoo/blog/328434/)|
|Dagger 2|Di-фреймворк.|[Серия статей 1](https://habr.com/ru/post/279125/), [серия статей 2](https://habr.com/ru/post/343248/)|
|Retrofit + OkHttp|Библиотека для HTTP запросов.|[Официальный сайт](https://square.github.io/retrofit/), [статья1](https://habr.com/ru/post/429058/), [статья2](https://habr.com/ru/post/314028/)|
|Room + SqLite|Инструмент для создания базы данных и работы с ней.|[Статья1](https://developer.android.com/training/data-storage/room), [статья2](https://startandroid.ru/ru/courses/architecture-components/27-course/architecture-components/529-urok-5-room-osnovy.html), [статья3](https://medium.freecodecamp.org/room-sqlite-beginner-tutorial-2e725e47bfab)|
|Proguard / R8|Вырезает лишнее, оптимизирует и запутывает наше творчество|[Статья1](https://habr.com/ru/post/415499/), [статья2](https://habr.com/ru/post/436564/), [статья3](https://android-developers.googleblog.com/2018/11/r8-new-code-shrinker-from-google-is.html)|
|Lint + Detekt + Cpd|Наш Static Analysis - Статический анализ кода.|[Как пользоваться статиком](guides/static/StaticAnalysisPlugin.md), [Lint](https://developer.android.com/studio/write/lint), [Detekt](https://github.com/arturbosch/detekt)|

Остальные библиотеки можно посмотреть [здесь](Libs.md).

## Styleguide

Если Сева дал доступ к github компании, то можно продолжить наше путешествие в кладезь знаний Тачина. [Styleguide](https://github.com/TouchInstinct/Styleguide) - база процессов и правил компании. Она постоянно пополняется. Здесь можно найти все. В первую очередь прочитай разделы android и general. Удели особое внимание этим гайдам:

* [Работа с гитом и код ревью](/Coding/CodeReview.md)

* [Кодстайл, которого мы придерживаемся](https://github.com/RedMadRobot/kotlin-style-guide)

* [Правила именования ресурсов](/processes/Strings-And-Images-Naming-Rules.md)

* [Основной бизнес процесс компании](/general/mainBusinessProcess.md)

* [Как трекать время в Jira](/general/jiraTimeTracking.md)

* [Как оценивать задачи](/general/estimations.md)

* [Что такое curl](/general/curlGuide.md)

* [Jira. Воркфлоу задачи и правила работы с тасками.](/general/jiraTicketFlow.md)

* [Как отдавать билды в тестирование](/general/AppDistributionGuide.md)

* [Что такое common репозитории?](/general/commonRepo.md)

* [Какие могут быть сборки в проекте](/general/setupBuildGuide.md)

* [Дистрибуция приложений](/general/AppDistributionGuide.md)

* [Как запускать staticAnalysis и понимать, что он хочет](guides/static/StaticAnalysisPlugin.md)

* [Основная архитектура приложений. Версия 2.0.](Arch2.md)

После android и general ознакомься в свободное время с остальными разделами.

## Что дальше?

* Склонировать проект

* Запустить на эмуляторе или своем девайсе

* Попросить у менеджера таски

* Работать, работать, работать

* Общаться и знакомиться со всеми

## К кому обратиться за помощью?

|Сотрудник|По каким вопросам обращаться|
|--- |--- |
|Куратор - разработчик, назначается лидом| вопросы про устройству кода на проекте|
|Менеджер проекта|<ul><li>если нет заданий</li><li>по всем проекто-зависимым вопросам</li></ul>|
|Тестировщик| <ul><li>вопросы по багам </li><li> если нужно помочь со сборкой билда</li></ul>|
|Дизайнер|вопросы по макетам|
|Лид|по всем остальным вопросам|
|HR|по нерабочим вопросам|

Если у тебя есть вопросы, не стесняйся. Здесь никто не кусается.

Надеюсь, тебе понравится у нас ;)
