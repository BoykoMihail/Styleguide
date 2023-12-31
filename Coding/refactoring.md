# Рефакторинг

## Что такое рефакторинг

Рефакторинг — это контролируемый процесс улучшения кода, без написания новой функциональности. Результат рефакторинга — это чистый код и простой дизайн.

Почему рефакторинг становится необходимым и что такое технический долг - [https://refactoring.guru/ru/refactoring/technical-debt](https://refactoring.guru/ru/refactoring/technical-debt)

## Зачем нужен рефакторинг

1. Сделать [код чистым и читаемым](https://refactoring.guru/ru/refactoring/what-is-refactoring). Все делается для того, чтобы новый разработчик после вас меньше вас проклинал.
2. Почистить костыли из прошлого. Костыли - быстрые, простые и вынужденные решения, которые решают текущую проблему, но создают бо́льшие проблемы в будущем.
3. Сделать Франкенштейна нормальным человеком. Бизнес-требования часто меняются. Экраны дорабатываются новым функционалом. Классы растут, supress'ы добавляются. Когда-то это превращается в монстра.
4. Актуализировать код под новые стандарты.

## Какой может быть рефакторинг

1. Глобальный. Изменения всего проекта. Переезд на новую либку, переход на нормальный packaging, новый способ обработки ошибок.
2. Местный. Изменение экрана или фичи. Вынести повторяющийся код в отдельные сущности, уменьшить связность кода. 

## Важные правила рефакторинга

1. Рефакторинг должен сделать лучше
2. Любой рефакторинг нужно протестировать
3. Любой рефакторинг нужно продать

## Как сделать рефакторинг

1. **Заложить в новый спринт.** При оценке нового спринта нужно смотреть код, который нужно будет изменять. Если вы видите, что этот код нуждается в изменении, то можно размазать время на рефакторинг этого кода по задачам. 

    Глобальный рефакторинг таким способом не сделать! 

    1. Глобальный рефакторинг затрагивает все экраны. Full regress занимает много времени, от двух недель до месяца. Это время тестирования незаметно не размажешь
    2. Глобальный рефакторинг нужно делать единоразово, не по частям. Иначе код превратится в еще большую свалку.
2. **Положить задачу в [список техдолга](https://docs.google.com/spreadsheets/d/13J3YIIkola1CSydFCQkaRR-Y_xEJLzUQ1oS3mUVP8A0/edit?usp=sharing).** Это табличка, откуда лиды будут брать задачи и добавлять на пресейле. В эту табличку можно положить глобальный рефакторинг или местный рефакторинг, который нескоро попадет в спринт. Такой способ нескоро решит эту проблему. Но чем лучше обосновать пользу ваших изменений, тем быстрее они попадут в работу.

## Как можно обосновать пользу рефакторинга

Польза лучше всего показывается через денежную выгоду. Вот хорошие способы сделать это:

1. **Количество багов.** Если вы хотите отрефакторить функционал, который часто ломается, то продать это будет легко. Баги - это время на фикс. Меньше багов, меньше времени на багфикс. А время - деньги.
2. **Будущее время.** На любом проекте есть функционал, который часто переписывается/дописывается. Чем сложнее код этого функционала, тем менее он читаемый и поддерживаемый, тем больше времени занимает разработка новых фич. А время - деньги.
3. **Оптимизация** Если показать, что экран лагает или запрос выполняется долго, то рефакторинг можно обосновать через удобство пользователя. Чем удобнее пользователю, тем больше он будет пользоваться приложением. Это напрямую конвертируется в деньги. Таким образом можно продать оптимизацию ui, сетевого слоя.
