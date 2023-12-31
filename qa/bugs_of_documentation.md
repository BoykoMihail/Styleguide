# Процесс заведения багов на документацию

## Обнаружение проблем в документации

После получения от менеджера тз, документации api, макетов необходимо:

1. [Протестировать всю документацию](https://github.com/TouchInstinct/Styleguide/blob/master/qa/analyse.md)
2. Обсудить с менеджером все возникшие вопросы (потенциальные баги) 
3. Выделить скоуп багов (багом считается вопрос, который требует времени для решения - остальные изменения вносятся во время обсуждения)
4. Если на момент начала разработки документация окончательно не согласована, то скоуп оставшихся багов нужно завести в JIRA

---

## Заведение в багтрекинговую систему

### Issue type

Clarification

### Заголовок

Кратко и понятно описать суть проблемы и указать часть документации, в которой эта проблема возникла (тз, документация api, макеты).

### Приоритет

В поле приоритет указать **критичность** данной проблемы с точки зрения тестировщика. Подробнее о выделении приоритета в статье [Правила баг трекинга](https://github.com/TouchInstinct/Styleguide/blob/master/qa/bugtrackerRules.md).

### Компоненты

Указать раздел или несколько разделов документации, в которых возникла проблема.

Возможные значения:

- Design IOS
- Design Android
- Documentation API
- Specification

### Исполнитель

Баг назначить на **менеджера**.

### Fix version

В поле Fix version указать версию, в которую входит функционал по рассматриваемой документации.

### Описание

1. Описать **проблему**, требующую решения, вне зависимости от того, что написано в заголовке.
2. Указать часть/части документации, в которых требуются изменения (ссылки, номера макетов и тд).
3. Описать согласованный с менеджером путь решения, если таковой имеется.

### Связанные задачи

Если разработка уже начата и есть декомпозированные задачи - прилинковать их со значением зависимости *is dependent by.*

---

## Жизненный цикл тикета

После решения вопроса:

1. Баг переводится менеджером в статус *Resolved*, в комментарии указываются внесенные в документацию изменения
2. Багфикс верифицируется тестировщиком и
    - Переводится в статус *Closed* (если изменения внесены в документацию и в задачи разработки)
    - Переводится в статус *Reopened* (если не хватает каких-либо изменений или фикс привел к другим проблемам документации) с подробным указанием причины переоткрытия
3. Баг линкуется ко всем связанным таскам, если это еще не сделано

---

## Информирование разработчиков об изменениях

Как только к задаче разработки в багтрекинговой системе линкуется тикет Clarification, необходимо уведомить разработчиков о будущих/произошедших изменениях в документации.

1. Если задача разработки в статусе *Open* или *In progress -* включить в qaReport и тегнуть разработчика в чате проекта
2. Если задача разработки в статусе *In code review* или *Resolved* и выполнена согласно новым изменениям документации - включить в qaReport
3. Если задача разработки в статусе *In code review* или *Resolved* и требуется доработка согласно новым изменениям документации - перевести задачу разработки в статус *Reopened* и тегнуть разработчика в чате проекта
