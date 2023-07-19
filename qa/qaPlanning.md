# Планирование итерации тестирования 
1. Перед началом спринта на этапе формирования скоупа и оценки задач разработчиками менеджер проекта предоставляет тестированию:
- Предполагаемый скоуп задач спринта
- Описание задач
- Макеты к задачам спринта
- Документацию АПИ к задачам спринта
- ТЗ если имеется

2. На основании предоставленной информации тестирование должно до начала спринта:
- [Протестировать требования](https://github.com/TouchInstinct/Styleguide/blob/master/qa/analyse.md), если ресурсы позволяют сделать это заранее
- Составить список задач тестирования (тест-план)
- Дать [оценку](https://github.com/TouchInstinct/Styleguide/blob/master/general/estimations.md) всем задачам тестирования в итерацию и предоставить ее менеджменту

3. На основании найденных багов требований, оценки на тестирование задач итерации, а также критериев готовности сборок и общих договоренностей с заказчиком об уровне конечного качества скоуп задач итерации и/или сроки поставки могут быть пересмотрены менеджментом.

4. В начале спринта задачи из тест-плана распределяются между исполнителями. Когда исполнитель закончил задачу, он фиксирует фактически затраченное на нее время.

5. В течение итерации тест-план может меняться при возникновении новых обстоятельств (например, обнаруживаются проблемы, требующие дополнительного исследования), но происходить это должно с оповещением менеджмента. Любая задача, добавленная в тест-план, должна быть оценена.

6. В случае, если какая-то из задач тестирования не влезает к сроку отдачи билда, а срок несдвигаемый, задача может быть отложена в техдолг. Техдолг — это отдельный тест-план, его закрытие должно быть так же запланировано в дальнейших итерациях.

__Важно:__ оценки нельзя менять после начала работы над задачей. Оценка дается в момент постановки задачи, дальше утверждается и согласовывается, и меняться после утверждения в течение итерации не должна.

# Как декомпозировать задачи тестирования
## 1. Тестирование новых функциональных блоков
Такие задачи необходимо декомпозировать по типам тестовых активностей, которые необходимо провести. В качестве примера, для любой задачи на разработку можно выделить следующие задачи на тестирование:
- анализ требований и поиск потерь
- подготовка тестовых данных
- оформление тестовой документации (mindmap декомпозиции, чек-лист, тест-кейсы)
- тестирование методов АПИ для данной функциональности
- проверка непосредственно функциональности клиента — исследовательское и скриптовое тестирование
- регрессионные проверки связанной функциональности
- нефункциональное тестирование, которое необходимо
 
## 2. Доработки существующей функциональности
Даже если доработки очень мелкие, они могут повлечь за собой необходимость правок тестовой документации и проверки связанных кейсов. Таким образом, могут быть выделены следующие задачи для QA:
- ревью и правки тестовой документации
- проверка задачи по описанию
- прогон измененных/связанных кейсов
 
## 3. Регрессионное тестирование
Тест-план на регрессионное тестирование представляет собой список фич, по которым необходимо полностью прогнать чек-листы. 
NB: Проведение регрессионного тестирования без готовых чек-листов невозможно, оно всегда должно быть скриптовым. Соответственно, если фича не покрыта чек-листом, она не может быть запланирована в регресс без задачи на написание чек-листа.
## 4. Регулярные задачи
В любую итерацию необходимо проводить:
- верификацию багфиксов
- тестирование миграций
- финальный прогон (в зависимости от ваших приоритетов это мб смоук или какой-то набор кейсов от заказчика или еще что-то) перед отдачей билда

Оценки на такие задачи могут иметь чуть большую погрешность, поскольку задачи могут переоткрываться по несколько раз за спринт за счет влияния внешних факторов.