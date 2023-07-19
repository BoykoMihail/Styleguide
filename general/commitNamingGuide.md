# Как правильно оформлять наименование коммита

Существует три типа коммитов.
1) Новая функциональность.
2) Правка бага.
3) Рефакторинг.

**Каждый тип коммита следует называть строго согласно определенному алгоритму:**

1) В тексте коммита необходимо четко и лаконично описывать разработанную функциональность. 
Пример: вы разработали анимацию появления контроллера.
good commit name: Create custom controller transition from contacts controller to chat controller.
bad commit name: animation added.

2) При исправлении бага полностью копируем информацию из тикета, включая название проекта и номер тикета в багтрекере.
Пример: вы исправили [drive-10] Приложение крашится на старте.
good commit name: drive-10: Приложение крашится на старте. fixed
bad commit name: fixes.

3) Коммиты с рефакторингом должен сопровождаться полным описанием изменений.
Пример: вы заменили сетевой слой с alamofire + object mapper на rxalamofire + lyft + realm.
good commit name: Refactoring network layer using rxalamofire + lyft + realm instead of alamofire + object mapper.
bad commit name: small refactoring.