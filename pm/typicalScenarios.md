# Сценарии различных ситуаций

Здесь описаны различные ситуации, которые могут возникнуть на любом проекте.
Большая часть из них возникнет. Стоит быть готовым к этому.

# Заказчик нашел баг в приложении 
## До исследования 
Задать дополнительные вопросы, если требуется. Выяснить, насколько критичной является проблема и как скоро клиент хотел бы видеть ее исправленной. Сказать, что мы передали описание проблемы техническим специалистам и скоро вернемся с ответом. 
## Исследование
Нам требуется еще некоторое время, чтобы определить, чем вызвана проблема и понять, как лучше ее решить; 
## Баг найден и наш 
Мы работаем над исправлением проблемы. Еще раз проговорить сроки исправления. 
## Баг найден и не наш 
Описать, чем вызвана проблема, добавив данные по ее воспроизведению. Например, если проблема с сервера, описать, какой именно метод ведет себя неправильно и описать ожидаемое поведение. 
Для проблемы со сторонней библиотекой дать ссылки с ее описанием на трекере библиотеки, а также оценить время, необходимое для перехода на другую библиотеку. 
## Баг не воспроизводится 
Просим у клиента дополнительные данные по оборудованию, версии ОС и условиях воспроизведения. Можно попросить записать видео. 
Если баг так и не воспроизводится, нужно попросить клиента удалить приложение, поставить последнюю версию, обновить ОС и т.д. 
# Клиент просит фичу 
## Фича адекватная 
Говорим, что нам нужно оценить и оцениваем. Говорим цену, если это применимо, и сроки. Если это фича в середине разработки и должна войти в текущий релиз, предупреждаем, что сроки сдвинутся и выясняем, насколько это ок для клиента. Если не ок – смотрим как можно впихнуть ее в те же сроки (добавить ресурсы, убрать другие фичи, и т.д.). В особых случаях можем запросить у клиента оплату овертаймов.
Самое главное, чтобы результат был представлен в срок или раньше, и полностью соответствовал или предвосхищал ожидания.
Очень просто сделать не то и не тогда. Пусть это будет мелкий факап, но они копятся и формируют отношение.
## Фича неадекватная 
Говорим, что надо подумать и посмотреть, как это можно сделать. Разговариваем с нашими техническими специалистами. Собираем подробное объяснение того, почему делать это нерационально: это могут быть запредельные сроки, цена, плохой UX. 
Мы не говорим, что не можем чего-то делать. Мы приводим клиента к пониманию того, почему он не хотел бы это делать.

В первую очередь надо держать себя в руках и не допускать резких высказываний.
Конструктивно донесите свое мнение, попробуйте узнать у клиента, почему он просит сделать именно это. Попробуйте предложить решение лучше. Подключайте к обсуждению Севу, приводите различные доводы и аргументы. Делать это стоит лишь один раз. Если наша позиция не была принята, то делаем как говорит клиент. Описываем все возможные риски и подчеркиваем, что мы не можем гарантировать каких-то моментов.
Клиент платит деньги, и клиент решает, что нам делать. Если его решение по вашему мнению несет риски и может навредить проекту — опишите это и зафиксируйте в переписке в почте.

Ни в коем случае нельзя показывать клиенту свое раздражение или допускать высказываний или подозрений в его некомпетентности. Лучше показывайте свой профессионализм, уважение и заботу о проекте.
«Кирилл, я понимаю что могу не обладать всей информацией о проекте и мое замечание может показаться глупым, но решение использовать USSD запросы вместо апи — не самое хорошее. Это никак не поможет сделать нам приложение приятным для использования. Почему был предложен такой вариант?"

Зачастую никакие решения не принимаются просто так, и наша реакция на глупые просьбы появляется исключительно от незнания причин и непонимания полной картины мира клиента.
В каких условиях он принимает решения? Перед кем он несет ответственность и от кого сам получает задачи? Чего на самом деле они хотят достичь? Существует ли лучший способ, чем тот, который они предлагают?
Зачастую можно даже не докопаться до истинных причин, почему просят ерунду. Но обычно такая причина есть, и для клиента она крайне логичная и понятна.


## Фикса 
Для фиксы имеет значение объем усилий, которые нужны на реализацию. Небольшие вещи, которые делаются максимум пару дней и не сдвигают сроки, мы можем делать бесплатно. Мы даем клиенту больше, чем обещали, и он доволен. Большие вещи нужно обязательно учитывать и проговаривать с клиентом их цену, оплату и тот факт, что они сдвигают сроки. 
## T&M 
В T&M нам нужно только предупредить о переносе сроков, если это применимо, и о том, в какую итерацию/релиз фича должна быть сделана. 
## Виртуальный T&M 
Это подход, где оплата по часам, но у клиента есть потолок, за который он не может выйти. 
Для значительных (больше 2 дней) вещей мы обязательно предупреждаем клиента, что существует большой риск выхода за его исходный бюджет и получаем от него подтверждение по почте, что это ок для него. 
# Нам требуется рефакторинг, как его продать 
Существует два подхода: 
* Продавать как рефакторинг, описывая ценность как уменьшение количества багов и экономию времени при разработке следующих фич 
* Размазывать время на рефакторинг по другим задачам 
# Мы не уложились в план, срыв сроков 
Об этом нужно сообщить клиенту как можно скорее. Перед разговором оценить, на сколько именно не уложились и сколько реально дополнительного времени нужно. Продумать предложения об оплате, если это применимо (T&M). Проставить приоритеты по фичам и оценить, какие можно исключить из релиза. Оценить, помогут ли овертаймы. Если это вопрос пары выходных, может быть, клиента не надо беспокоить. 
Описать все это клиенту и прийти к соглашению по новым срокам и фичам. 
# Мы делали задачу, которую клиент не просил 
## Рефакторинг 
Это можно объяснить необходимостью уменьшить количество проблем и сокращением сроков разработки следующих фич. 
## Задачу не из этой итерации 
Если этому есть какое-то обоснование – без этой задачи нельзя сделать задачу из текущей итерации – объяснить это. Если это просто ошибка – так и сказать. 
## Отчет 
Если задачи имеют ценность для клиента, с которой он согласен, нужно подтвердить, что мы можем включить их в отчет. 
Если же задачи не могут быть продемонстрированы клиенту как ценные и стоящие потраченных часов, мы не включаем их в отчет. 
Также можно не включать в отчет ценные задачи, если нужно улучшить лояльность клиента, а увеличившийся размер счета этому повредит. 
# Мы работаем по плану, а клиент считает, что мы не успеем 
Созвониться с клиентом и показать ему детальный план проекта. Проговорить оценки на оставшиеся фичи и либо подтвердить их с клиентом, либо вписать новые в силу каких-то обстоятельств, которые были известны клиенту. 
Если план все же меняется, обговорить новые сроки или удаление каких-то фич. 
# Заказчик задерживает макеты 
Предупредить о том, что есть риск сдвига сроков. Узнать о том, можем ли мы помочь с помощью наших дизайнеров и как это будет оплачиваться. 
Если нам нужно избежать простоя разработчиков, мы можем нарисовать макеты за свой счет. 
Если задержка серьезная или есть высокая вероятность того, что она велика, – перевести ресурсы на другие проекты. Объяснить заказчику, что если мы снимем разработчиков, то не сможем их моментально вернуть.  
# Заказчик задерживает API 
В общем случае лучше для любого проекта делать заглушку самим, это исключает риски и повышает возможности тестирования. 
Предупредить о том, что есть риск сдвига сроков. Узнать о том, можем ли мы сделать свои заглушки – для этого понадобится хотя бы утвержденная схема. Если мы делаем свои заглушки, нужно посмотреть, как это будет оплачиваться.  
Мы можем делать заглушки бесплатно, так как это недорого обходится и часто значительно помогает поднять эффективность разработчиков. 
Если задержка серьезная или есть высокая вероятность того, что она велика, – перевести ресурсы на другие проекты. Объяснить заказчику, что если мы снимем разработчиков, то не сможем их моментально вернуть.  
# Заказчик постоянно просит что-то оценивать 
Если это укладывается в часы по текущему проекту по фиксе или T&M, то почему нет. Хотя до заказчика стоит донести, что он оплачивает эти часы. Если на это тратятся неоплачиваемые усилия – не пытаться силами менеджера давать верхнеуровневые оценки, а детально просчитывать только то, что точно надо.  
# Заказчик устраивает очень много совещаний 
На каждом совещании должны присутствовать только те, кому действительно необходимо там быть. Перед каждым совещанием должен быть известен и понятен список вопросов, которые на нем будут обсуждаться. 
Если выясняется, что обсуждать нечего – предлагать отменить совещание. 
Клиенту может казаться важным, чтобы на совещании присутствовало много людей. Здесь помогает заранее подготовленный список вопросов для обсуждения. 
Опираясь на него, можно предлагать вроде «выглядит так, что для такого-то сотрудника здесь нет вопросов, вы не возражаете, если он не будет присутствовать?». 
Также помогает отправка протоколов совещаний всем заинтересованным. Опираясь на них также можно предлагать освободить кого-то, кто находится там «просто послушать». 
# API заказчика неадекватно спроектировано 
Выяснить, могут ли они его подстраивать под наши рекомендации. Описать, какие именно фичи не смогут быть сделаны и почему, а какие – займут слишком много усилий в разработке. Если выхода нет – учесть дополнительное время, нужное на поддержку такого API в плане проекта. 
Также мы можем делать свою заглушку, заручившись обещанием переделать API со стороны клиента по ее образу. 
Еще одним вариантом является разработка своего бэкенда, но это должно быть продано клиенту. 
# API не работает постоянно 
Рассказать о том, что это тормозит разработку и тестирование и попросить исправить это. Можно попросить выделить стабильную версию на отдельный сервер и использовать в разработке ее, обновляя, скажем, раз в неделю. 
В качестве подтверждения нужно использовать письма от бота или логи автотестов. 
# Макеты от заказчика неадекватные 
Описать, какие именно фичи не смогут быть сделаны и почему, а какие – займут слишком много усилий в разработке. Показать примеры хорошо сделанных приложений, и объяснить, почему там сделано именно так. Предложить помощь наших дизайнеров. Если требуется много усилий со стороны наших дизайнеров – посмотреть, будут ли они оплачены. Если выхода нет – учесть дополнительное время, нужное на поддержку таких макетов в плане проекта. 
# Заказчик все время меняет требования 
Предупредить о том, что есть риска сдвига сроков. Если это проект по фиксе – фиксировать все значительные изменения и вносить в допсоглашения, проговорив это предварительно с клиентом. 
Значительными являются изменения, требующие больше 8 часов разработки на платформу. 
Это вполне ок, если клиент лучше понимает, как должен работать его продукт и просит что-то поменять, но нужно, чтобы он понимал, что сроки от этого могут сдвигаться. 
# Заказчик просит выделить больше людей, чем есть 
## Это адекватно 
Смотрим, в какие сроки мы можем увеличить команду, и согласовываем это с заказчиком. Согласовываем увеличение оплаты, если это T&M, и проверяем, не выйдем ли мы за бюджет, если это фикса. 
## Это неадекватно 
Если это не адекватно потому, что мы и так попадаем в сроки и в бюджет – надо продемонстрировать это заказчику, показав планы, прогресс и т.д. 
Если столько людей просто будут больше мешать друг другу, чем помогать, то мы пробуем объяснить это заказчику. 
# Заказчик пропадает и не отвечает 
Если есть другие контактные лица, пробуем связаться с ними. Если их нет, и заказчик отсутствует длительный срок и нет предоплаты, то ставим проект на холд. 
Если предоплата внесена и требования не уточнить, мы делаем то, в чем есть хоть какая-то уверенность, но стараемся тратить на это как можно меньше ресурсов. 
# Заказчик недоволен качеством, хотя приложение хорошее 
Выясняем конкретный список проблем, которые его беспокоят и фиксим их. Если это на самом деле не проблема и работает так, как и задумано – показываем похожие приложения. Объясняем, почему сделано так. 
Показываем отзывы и оценки в сторе, если это применимо. 
Если проблема не с нашей стороны, а с данными или сервером, хорошо будет показать подтверждения в виде лога автотестов, скриншотов данных и т.д. 