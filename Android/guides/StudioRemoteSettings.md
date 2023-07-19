# Подключение общего репозитория настроек
- В Android Studio переходим: Preferences - Tools - Settings Repository;
- В список Read-only Sources добавляем адрес репозитория: git@github.com:TouchInstinct/Idea-settings.git, флаг Auto Sync должен быть включен;
- Далее сохраняем настройки студии (Apply) чтобы подгрузился репозиторий, после чего в меню Editor - Code Style появится схема TouchInstinct. Выбираем ее, profit.

Синхронизация настроек производится при закрытии Android Studio. Поэтому если нужно подгрузить новые изменения из удаленного репозитория, ее надо перезапустить.
