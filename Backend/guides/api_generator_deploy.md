# Api Generator deploy guide

1. Клонировать [репозиторий](https://github.com/TouchInstinct/api-generator.git)
2. Cобирать джарник командой `cd api-generator/src && ./gradlew fatJar`
3. Войти на [bintray](https://bintray.com) (логин и пароль взять у Android/iOS лида)
4. Перейти на страницу [api-generator](https://bintray.com/touchin/touchin-tools/api-generator)
5. Создать новую версию, нажав на кнопку **New Version**, название версии должно соответствовать собственно версии, например *1.0.4*
6. После создания версии, перейти к ней, затем *Files -> Upload Files*
7. В параметре **Target Repository Path** указать */ru/touchin/api-generator/__<версия>__*
8. Загрузить файл с названием *api-generator-__<версия>__.jar*
9. Затем нажать *Save Changes -> Publish*
10. Подождать пару минут публикации и проверить наличие джарника в [списке](https://dl.bintray.com/touchin/touchin-tools/ru/touchin/api-generator/)
