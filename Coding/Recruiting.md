# Рекрутинг разработчика

Статья для тех, кто будет собеседовать разработчиков, и про то, как делать это хорошо.

## Этапы собеседования

1. **Телефонное интервью с рекрутером.** Цель - по простейшим маркерам отсеить неподходящих кандидатов. Простейшие маркеры - зп, устная речь, простые технические вопросы, мотивация, желаемый график работы, неадекватная причина смены работы, неподходящее поведение, отсутствие релевантного опыта работы и так далее.
2. **Техническое интервью с разработчиком.** Цель - определить технический грейд кандидата, умение мыслить, способность обсуждать технические темы. 
3. **Интервью с HR и CTO.** Цель - проверить софт-скиллы и умение мыслить, а также обсудить ЗП ожидания. Умение мыслить проверяет CTO, начиная с простых технических вопросов, и далее идет в глубь, смотрит, как рассуждает кандидат.

## Как проводить техническое собеседование

### Цель технического интервью

Главная цель - определить технический грейд кандидата. За основу использовать табличку для грейдов.

Также еще важно смотреть на софт-скиллы. Представь, что выбираешь человека, с которым тебе придется плотно работать ближайший год. Обрати внимание на аутичность, агрессивность, склонность к спорам, ЧСВшность, негатив, эмоциональную незрелость. Даже если кандидат суперумный гений, но постоянно спорит, то с ним будет очень тяжело работать.

Обрати внимание на то, как кандидат думает, умеет ли он размышлять, логичны ли его выводы. Если кандидат имеет слабую базу, но очень хорошо думает, то его можно будет легко всему обучить.

### Примерная структура собеседования

1. **Разговор по душам.** Примерно 10 минут. Нужно расслабить кандидата. Для начала можно представиться и рассказать о формате технического интервью. Например, "В техническом интервью будут вопросы по базовому computer science, общие вопросы по платформе, вопросы по UIKit и вопросы по Swift." Потом можно спросить про предыдущий опыт и про самые сложные задачи, которые встречались на своем пути. На основе ответов всегда можно завести дискуссию, обсудить холивары и провести расслабленный разговор. 
2. **Фильтрующие вопросы.** Примерно 20 минут. С самого начала нужно задавать вопросы, которые лучше всего фильтруют тупарей.  Например, можно начать с вопросов про HashMap, сборщик мусора, индексы в БД и Fragment. Уже за эти 20 минут можно понять, продолжать разговор или нет.
3. **Остальные вопросы.** Примерно 20 минут. На этом этапе нужно задавать остальные вопросы для определения текущего уровня собеседника.
4. **Конец собеса.** Примерно 10 минут. Ответы на вопросы кандидата. Фидбек о том, что было сказано хорошо и плохо кандидатом. Прощание. **ВАЖНО:** можно сказать, где был не прав собеседник, но не нужно говорить свою оценку его знаниям.

### Как понравиться собеседнику?

Собеседование - это работа с двух сторон. Мы также должны понравиться ему. Возможно, он про нас скажет другим людям, либо между двумя компаниями он выберет нас.

1. Вопросы должны быть интересными. Чем больше практических кейсов и чем меньше сухой теории, тем круче. Даже в сугубо базовом вопросе можно вывести в интересную задачу. Например, `Как будет вести себя HashMap, если hashCode будет возвращать одно и то же значение, а equals всегда будет false?`. Или `Почему приложение должно быть Single-Activity?`. Или `Как написать layout, который располагает элементы по окружности?`.
2. В конце собеседования нужно обязательно дать фидбек. Лучше начинать с похвалы, далее указать на недостатки. Почти никто на рынке не говорит после собеса недостатки кандидата. И это бесит. А мы тем самым будем запоминаться. И сделаем мир лучше. **ВАЖНО:** можно сказать, где был не прав собеседник, но не нужно говорить свою оценку его знаниям.
3. Нужно быть вежливым. Проявлять уважение к кандидату. 
4. После собеседования можно скинуть ссылки на материалы для изучения слабых сторон кандидата.

### Как завернуть тупаря

Если по первым вопросам становится понятно, что кандидат нам не подходит, то не нужно его тянуть дальше. Время драгоценно. Подвести к концу интервью нужно деликатно.

#### Совет от Вани Смолина

Если кандидат не отвечает на базовые вопросы, то у меня обычно это выглядит следующим образом:
> Смотри, из 6 вопросов по базовому computer science ты ответил только на 2 с половиной. Они требуются для прохождения следующего этапа собеседования с техническим директором. Я могу поспрашивать тебя ещё по iOS/Android, но без этих вопросов на следующий этап собеседования не попасть. Поэтому предлагаю следующее: ты подготовишься и мы проведём ещё одно собеседование.

#### Совет от Макса Бачинского

Я обычно спрашиваю по одному вопросу с каждой области в начале интервью. Если по ним понятно, что кандидат не подходит, то я говорю "Вопросов у меня больше нет". Обычно, кандидат почти на все вопросы не дает ответа. В такой ситуации всем становится понятно, что кандидат не готов. А если кандидат не понимает и задает удивленные вопросы, то он действительно тупарь. В таком случае можно вежливо сказать: "Ты не ответил на большинство вопросов. Твой уровень недостаточно высок для нашей компании. Подучи слабые темы и приходи через полгода."

### Фидбек на кандидата

После собеседования интервьюер должен занести свой фидбек по кандидату в [Поток](https://app.potok.io/). В нем должны быть отражены темы, которые обсуждались на интервью, и уровень знаний кандидата по ним, а также в конце вывод о грейде собеседуемого. Возможны дополнительные комментарии по софт-скиллам кандидата. 

Этот фидбек читает СТО и HR. Если мы решили, что кандидат нам сейчас не подходит, мы все равно должны занести отзыв о нем, т.к. через какое-то время он может подтянуть свои знания и вернуться к нам. В таком случае нам нужно знать причину, по которой мы отклонили кандидата в прошлый раз.

Пример формата:

    HashMap - знает
    Сборщик мусора - не знает
    Activity-Fragment - знает основы
    RecyclerView - знает базу
    Индекс в бд - знает
    SharedPref - не знает
    Паттерны проектирования - знает больше половины
    Синглтон в Java - слабо
    Архитектура - знает основы (MVP, MVVM)
    Deadlock - знает с небольшой ошибкой
    Многопоточность в Android - не знает
    
    Вывод: крепкий стажер
    
## Цитатка напоследок

Лучше ошибиться и отказать хорошему кандидату, чем ошибиться и взять плохого.

