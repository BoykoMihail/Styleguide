# Планирование внешних поставок

## Расписание поставок
Ниже для простоты под поставкой будем понимать _любой показ или отправку билда куда-либо за пределы компании Touch Instinct._

Спланировав спринт и установив дату поставки, координатор проекта должен поставить в известность об этом релиз-менеджера и предоставить следующую информацию:

1. Дата, время поставки и номер новой версии

2. Цель. Это может быть:

- демо заказчику новой функциональности по итогам спринта

- отправка билда заказчику на приемочное тестирование

- отправка билда заказчику для внутренней презентации руководству

- релиз в маркет

- хотфикс

- etc.

2. Список задач, которые должны войти в поставку, со ссылкой на их описания.

3. Критерии готовности поставки. Это может быть:

- успешное прохождение приемочных кейсов, заранее утвержденных с заказчиком

- успешное прохождение демо-сценария, согласованного с менеджером

- отсутствие багов выше заданного приоритета, найденных при тестировании по утвержденной с менеджером тестовой стратегии

- отсутствие багов выше заданного приоритета в определенных функциональных областях

- etc.

4. Возможность сдвига даты. Если поставка завязана на внешние факторы бизнеса и сдвинута быть не может, это стоит заранее обозначить для успешной расстановки приоритетов.

_В случае оповещения релиз-менеджера о планируемой поставке в telegram-чате необходимо поставить тег "#qaRelease"_

При получении соответствующей информации релиз-менеджер вносит поставку в [расписание](https://www.notion.so/de43a76af37b4497b4a6886ba2a0530e?v=5b17c22b35cb43c5a062dabc1ec820f3)

Если поставка не указана в расписании, она не может состояться.

Информация о планируемой поставке должна поступать не позднее, чем за 1-2 недели до нее. В обратном случае возможен отказ в тестировании к данной поставке в силу отсутствия свободных ресурсов тестирования. Исключением может быть только хотфикс -- его можно назначить день-в-день.

По умолчанию осуществление поставки в обход отдела тестирования запрещено. Для осуществления поставки без тестирования ее необходимо утверждать лично с Всеволодом Ивановым.

## Одобрение поставки тестированием 
Процедура одобрения поставки тестированием происходит следующим образом:

1. Тестировщик получает на руки сборку релиз-кандидат

2. Тестировщик находит в [расписании](https://www.notion.so/de43a76af37b4497b4a6886ba2a0530e?v=5b17c22b35cb43c5a062dabc1ec820f3) поставку, которую он готовит, и сверяет соответствие релиз-кандидата требованиям, указанным в плане поставок. Необходимо удостовериться, что:

- все перечисленные задачи присутствуют в сборке
    
- в сборку не попала новая функциональность, которая в плане не указана (такое может произойти при работе над двумя релизами параллельно)
    
- критерии готовности поставки выполняются: по всем задачам все необходимые активности проведены, и каждая -- с нужным результатом

3. В случае, если релиз-кандидат соответствует требованиям к поставке, тестировщик должен написать в общий чат проекта сообщение с:

- тегом "#releaseCandidate"
    
- releaseID из плана релизов
    
- номера одобряемых им сборок

4. В случае, если релиз-кандидат не соответствует требованиям к поставке, тестировщик одобрить поставку не может, и должен как можно скорее вынести этот вопрос на обсуждение в общем чате, чтобы форсировать решение проблем, блокирующих поставку. 

_Это хороший повод написать [Тревожное Письмо](https://github.com/TouchInstinct/Styleguide/blob/master/qa/report.md#%D1%82%D1%80%D0%B5%D0%B2%D0%BE%D0%B6%D0%BD%D0%BE%D0%B5-%D0%BF%D0%B8%D1%81%D1%8C%D0%BC%D0%BE) если еще есть время что-то исправить в сложившейся ситуации_

5. Если релиз несдвигаемый (в колонке "Можно сдвигать?" стоит "нет"), день релиза уже подходит к концу, а сборка по-прежнему не удовлетворяет требованиям к поставке, информацию об этом тестировщик обязан донести до релиз-менеджера. Релиз-менеджер совместно с менеджером проекта принимают решение о снижении уровня требуемого качества, пересматривают приоритеты задач и тестовых активностей.

_Принятое решение обязано быть зафиксировано комментарием к релизу в расписании. Так же о нем необходимо оповестить реководителя отдела тестирования и исполнительного директора (ответственный -- релиз-менеджер)._

6. Наличие поставки в расписании -- обязательное условие для одобрения тестировщиком релиз-кандидата. В случае, если тестировщик не находит нужной поставки в расписании или информация по ней неполна (см раздел Расписание поставок, п.1-4), он должен оповестить об этом релиз-менеджера.

## Обязанности релиз-менеджера
1. Каждый понедельник и каждую пятницу необходимо лично запросить информацию о поставках у координатора каждого проекта.

2. Внести в [расписание поставок](https://www.notion.so/de43a76af37b4497b4a6886ba2a0530e?v=5b17c22b35cb43c5a062dabc1ec820f3) информацию о планируемых поставках согласно чек-листу, приведенному выше.

3. Если координатор проекта не может предоставить полную информацию, и возможно заполнить строку таблицы лишь частично -- это все равно необходимо сделать, оставив пропуски. В дальнейшем желательно раз в несколько дней запрашивать уточнения у координатора, пока строка не будет заполнена полностью.

4. На еженедельном митинге менеджеров необходимо по каждому проекту еще раз опросить менеджеров на предмет появления новой информации по поставкам.

5. Поддерживать в расписании актуальный статус поставки.

6. Фиксировать сдвиги поставок и их причины комментариями и в поле "Задержка релиза".

7. Оповещать реководителя отдела тестирования и исполнительного директора об изменениях критериев готовности поставок в угоду скорости осуществления поставки.
