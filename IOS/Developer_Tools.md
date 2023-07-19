# Список утилит и софта необходимого iOS разработчику
Данная статья является неким чек-листом перед началом разработки. Здесь собраны самые необходимые утилиты для ежедневной работы. 

## Установка среды iOS разработчика

Установка среды разработки Xcode. [Сюда](https://developer.apple.com/download/)

## Настройка Git-аккаунта

Если нет git аккаунта, то создать новый [тут](https://github.com/). Далее обратиться к **CTO**/**Dev Lead** с целью добавить данный аккаунт в репозиторий компании.

Также необходимо настроить SSH для Git-аккаунта. [Помощь](https://help.github.com/categories/ssh/)

Скачать программу для работы с Git-репозиториями, например, [SourceTree](https://www.sourcetreeapp.com)

## Установка пакетного менеджера
Для установки некоторого софта используется использутеся пакетный менеджер [Homebrew](https://brew.sh):

- ```/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"```

## Установка JDK
Для работы ряда утилит необходимо скачать и установить [JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

Проверить текущую версию JDK можно следующей командой:

```
java -version
```

## Установка менеджеров зависимостей

Для управления зависимостями на данный момент используется два менеждера зависимостей:

- [Cocoapods](https://cocoapods.org) - ```sudo gem install cocoapods```
- [Carthage](https://github.com/Carthage/Carthage#quick-start) - ```brew install carthage```

## Установка программ для работы с дизайном

- Для работы с дизайн-макетами используется [Figma](https://www.figma.com/downloads/)

## Установка программ для автоматизации процессов разработки
Для автоматизации процессов настройки сертификатов и provision profile'ов, а также отправки билдов в fabric и AppStore мы используем [Fastlane](https://docs.fastlane.tools):

- ```sudo gem install fastlane -NV```

Для проверки кода на наличие копипасты мы используем [pmd](https://pmd.github.io):

- ```brew install pmd```

## Дополнительные программы

- [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

  **Описание:** Так или иначе с терминалом работать приходится. Чтобы этот процесс был более приятным и понятным, рекомендуется установить фреймворк для уравления конфигурацией zsh.

 
- [Sublime](http://www.sublimetext.com/3)

  **Описание:** Текстовый редактор. Под него есть куча плагинов и скриптов для обработки текста (например, [форматирование/валидация JSON](https://github.com/dzhibas/SublimePrettyJson).


- [Charles](https://www.charlesproxy.com/) 
 
  **Описание:** Для работы с API. Проксирование запросов, работает и на симуляторе и на девайсе.  
  
  
- [Proxyman](https://github.com/ProxymanApp/Proxyman)

  **Описание:** Хорошая замена Charles, котора не ломает работу интернета и обладает современным дизайном.
  
  
- [DBeaver](https://dbeaver.io) 
 
  **Описание:** Тулза для подключения к БД и работе с ними.


- [MacDown](https://macdown.uranusjr.com)

  **Описание:** Программа для редактирования markdown локально. Моментально рендерит результат в превью, намного удобнее и быстрее гитхаба.

- [Postman](https://www.getpostman.com/downloads/)

  **Описание:** Улитита для отправки запросов.
  
- Adobe Photoshop

  **Описание**: Иногда для работы с дизайнами и проведением Pixel Perfect требуется Adobe Photoshop (к **CTO**/**Design Lead** с вопросом откуда взять)


- [Curl](https://ru.wikipedia.org/wiki/CURL)

  **Описание:** Отправка запросов в консоли.


- [Pixel Perfect](https://itunes.apple.com/ru/app/pixel-perfect/id916097243?mt=12)

  **Описание:** Программа для pixel perfect. Накладывает макет изображения поверх симулятора. Есть настройки прозрачности, масштаба.


- [OpenSim](https://github.com/luosheng/OpenSim)

  **Описание:** Программа для простого и удобного поиска папки приложения, установленного в симуляторе.
  

- [FengNiao](https://github.com/onevcat/FengNiao)

  **Описание:** Программа для поиска и удаления неиспользуемых ресурсов. Гораздо быстрее ручного поиска.
  
- [Kin](https://github.com/Karumi/Kin)

  **Описание:** Программа для поиска ошибок в project.pbxproj, которые могут появиться при слиянии веток. Советую устнавливать через easy_install.
