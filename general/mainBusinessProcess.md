# Основной бизнес-процесс

### PRESALE
#### Аккаунтинг
К нам в компанию поступает запрос на разработку проекта, либо мы сами находим заинтересованного клиента. Как правило, этот клиент приходит через одного из менеджеров по продажам, который в дальнейшем будет являться аккаунт-менеджером данного проекта и будет решать все спорные ситуации с клиентом. Если есть разногласия по скоупу работ, например, клиент не хочет оплачивать какие-либо из наших услуг, то данную проблему решает аккаунт-менеджер проекта. Так же в обязанности аккаунт-менеджера входит периодический опрос клиента об удовлетворенности работой с нами, возможностях улучшения, а также внедрение полученных предложений.

#### Оценка
До этапа подписания контракта по проекту, как правило, требуется несколько предварительных оценок. Первичные оценки выполняют менеджеры по продажам согласно следующему документу: [Оценка проекта](../pm/presaleProcess.md) 

В случае затруднений или крупных проектов они обращаются за помощью к техническому директору или лидам.
Если первичные оценки клиента устраивают, и общение продолжается, то должна последовать оценка отдела производства, за которую он несет ответственность.
* В случае, если есть дизайн-макеты или хотя бы достаточно подробная навсхема/wireframe, то оценку выполняют лиды (все платформы + тестирование + арт-директор), причем могут делать это независимо. Затем оценку согласовывает технический директор.
* В случае, если дизайн приложения не разработан совсем, то оценка выполняется техническим директором, потому что влияние рисков и неопределенности на этот проект больше, чем технических аспектов. В случае недоступности технического директора оценка может выполняться лидами, однако обязательно необходимо коллегиальное обсуждение для общего понимания, что в оценку входит, а еще более желательна общая проработка wireframe дизайнерами.

### Производство
Процесс работы в нашей компании производится этапами/итерациями/спринтами. То есть общий скоуп задач разбивается на некоторые куски, которые выполняются последовательно. Даже если заказчик не настаивает на разбиение работы на этапы, производится внутреннее разбиение.
Длительность этапа составляет в среднем 2 недели, однако может варьироваться от недели до месяца в зависимости от проекта.
Фактически, каждый этап представляет собой небольшой самостоятельный проект, поэтому описанное ниже применимо как к проекту целиком, так и к каждому этапу в частности.

#### Входные данные этапа
Без выполнения данных требований этап не может начаться. То же относится к проекту, однако, в случае T&M-проектов допустимо выполнение этих требований не для проекта целиком, а только для первого этапа.

* Выделенная команда. Ответственный технический директор.
    * Менеджер/координатор проекта
    * Разработчик(и)
    * Тестировщик(и)
    * Дизайнер(ы)
* Созданный репозиторий в гите, куда заливается весь код. Ответственный технический директор.
* Созданный проект в джире, куда трекается время. Ответственный технический директор.
* Созданный проект в basecamp. Ответственный технический директор.
* Баг-трекер
    * В случае работы в трекере заказчика туда должны быть доступы у всех членов команды. Должно существовать понимание о формате работы там. Ответственный менеджер/координатор проекта.
    * В случае работы в нашей джире там должна быть создана версия, соответствующая текущему этапу. Ответственный менеджер/координатор проекта.
* API. Должна существовать документация и работающий сервер или его прототип, который работает согласно документации. Процесс создания и приемки API будет разработан позднее.
* Дизайн-макеты. Допускается начало работ при наличии только wireframe/навсхемы, однако реализовывать при этом можно только логику и навигацию. Ответственный менеджер/координатор проекта и дизайнер.
* Список задач, которые должны быть выполнены в рамках этапа. Ответственный менеджер/координатор проекта.
* Понимание функционала, который требуется реализовать. Ответственный менеджер/координатор проекта за общее понимание, дизайнер за работу конкретных функций и UI/UX.

#### Результат этапа
В конце каждого этапа должен быть получен билд, в котором реализованы все запланированные на этап функции. Качество билда должно достаточным, чтобы его можно было показать заказчику без стыда.

#### План работы
Для проекта в целом должен существовать план разбиения задач по этапам с датами завершения. Ответственный менеджер/координатор проекта. Детализация плана описывается в следующем пункте.
#### Начало этапа
В начале каждого этапа должно состояться собрание с участием лидов по платформам, дизайнера, тестировщика и менеджера/координатора проекта.
Вообще говоря, ответственный - менеджер/координатор проекта. Однако все участники должны проявить заинтересованность и настойчивость при организации данного собрания.
На этом собрании должно произойти подробное обсуждение всех задач, которые нужно реализовать в рамках этапа и разбор возникающих вопросов. При этом часть непонятных задач может быть решено перенести на следующий этап.
Затем должен быть составлен детальный план этапа. Это список задач, у каждой из которых определен разработчик, который будет ее делать, а также дата передачи билда с этой функциональностью в тестирование.
План проекта должен быть занесен в джиру в дашборд, будет описано подробно позже.
#### Тестирование
В общем случае билды уходят в тестирование 2 раза в неделю, причем задачи на неделю должны быть разбиты примерно равномерно на эти 2 билда.
По каждому полученному билду тестировщики пишут отчет в закрытую тему в basecamp для каждой платформы.
 
[Формат отчета](../qa/projectOverview.md)

Тестирование выполняется согласно этому документу: [Порядок написания и прогона чек-листов](../qa/checkListGuide.md)
