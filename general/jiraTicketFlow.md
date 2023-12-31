# JIRA ticket flow

### Дисклеймер: Тикет в Jira - элемент жиры, например задача или баг.

## Статусы тикета

У каждого тикета в жире есть статус. В нашей системе тикет может иметь одно из следующих состояний:

**Open** - Над задачей никто не работает. Ее можно взять в работу.

**In progress** - Задачу взяли в работу. В данный момент Assignee занимается этой задачей.

**In code review** - Код задачи в данный момент находится на ревью.

**Resolved** - Разработчик сделал задачу и ее можно тестировать. Указывается Resolution. По умолчанию, Fixed.

**Closed** - Тестировщик закрыл задачу. 

**Suspended** - Тикет поставлен на паузу с нашей стороны.

**Blocked** - Тикет поставлен на паузу из-за проблем со стороны заказчика.

**Reopened** - Тикет был переоткрыт.

### Флоу таски и сабтаски

<p align="center">
  
  <img width="80%" src="https://i.ibb.co/1vyHghp/Clean-Shot-2019-09-09-at-16-45-28-2x.png" alt="Флоу таски и сабтаски (Если не работает картинка, напиши @maxbach"/>
  
</p>


### Флоу бага

<p align="center">
  
  <img width="80%" src="https://i.ibb.co/n1v0mKg/Clean-Shot-2019-09-09-at-16-42-19-2x.png" alt="Флоу таски и сабтаски (Если не работает картинка, напиши @maxbach" align="middle"/>
  
</p>

## Resolutions

Тикет можно закрыть с одним из следующих Resolution:

| Resolution | Описание | Дополнительное действие | Обязательность доп действия |
|---|---|---|---|
| Fixed | Разработчик выполнил тикет | Оставить комментарий: на что стоит обратить внимание тестировщику | Нет |
| Won’t fix | Тикет не будет выполнен | Оставить комментарий: почему задача не будет исправлена | Да |
| Done | Задача сделана, но ее не нужно тестировать. Например, аналитика. | - | - |
| Won’t do | Задача не будет сделана | Оставить комментарий: почему задача не будет сделана | Да |
| Duplicate | Уже создан подобный тикет | Проставить linked issue у тикета | Да |
| Incomplete | Невыполнимый тикет, плохо сформированные требования или описание тикета | Оставить комментарий: список того, чего не хватает в требованиях. Или список того, что мешает выполнению тикета. | Да |
| Cannot reproduce | Невозможно воспроизвести баг | Оставить комментарий: "Не воспроизводится. ${Номер билда, в котором проводилась проверка}" | Да |
| Not a bug | Не баг, а фича | Оставить комментарий: объяснение, почему не баг | Да |

## Правила перевода тикетов

* Таски закрывает только тестировщик. **Баги либо закрывает тестировщик, либо закрывает разработчик с уведомлением и апрувом тестировщика.** Это очень важно, так как тестировщик может упустить из виду важный баг.

* Поддерживайте Jira в актуальном состоянии. Не забывайте переводить таски в нужный статус. С помощью Jira менеджер следит за текущим прогрессом.

