## Гайд по проведению проверки миграции

## Проверка разработчиком

Перед отдачей тестировщикам разработчику нужно протестировать миграцию самостоятельно. Это должно происходить только на тестовом сервере.

- Разработчику необходимо найти в системе контроля версий нужный коммит, с которого билд был отправлен в AppStore с последним релизом. 
- Изменить url-адрес сервера, на который смотрит приложение, на тестовый. Запустить локально билд на девайсе с данного коммита.
- Перейти к последнему коммиту, который должен уйти в релиз и поверх предыдущего билда поставить новую версию.

## Проверка тестировщиком

Существует два пути проведения проверки миграции в приложении: проверка боевых версий и проверка тестовых версий. Проверка боевой версии должна осуществляться после проверки тестовой.

### Проверка боевых версий

#### iOS

Заключается в установке версии из TestFlight поверх последней версии приложения из AppStore.

Разработчик заливает финальную версию приложения с ключами AppStore, смотрящую на production-сервер в TestFlight и шарит на qa@touchin.ru. Тестировщикам приходит уведомление, после чего они могут установить приложение из TestFlight.

**Невозможно выполнить, если отсутствует доступ к TestFlight.**

#### Android:

Заключается в установке версии приложения, смотрящей на production-сервер, поверх последней из Google Play.

### Проверка тестовых версий

Заключается в установке текущей тестовой девелоперской версии поверх последней зафиксированной релизной версии, также установленной с помощью разработчика.

### Основные этапы проведения тестирования

Вне зависимости от выбранной боевой или тестовой версии, необходимо выполнить ряд шагов для тестирования.

- Поставить предыдущую релизную версию.
- Пройтись по основным use-cases, исходя из особенностей приложения -- прогнать чек-лист на update (забить кеш, локально хранимые данные).
- Поставить поверх версию приложения, которая готовится уйти в релиз.
- Пройтись по основным use-cases, исходя из особенностей приложения и знаний о персистентных данных и состояниях, хранимых в приложении. Необходимо убедиться, что после обновления приложение продолжает корректно работать, а локальные пользовательские данные сохранились.