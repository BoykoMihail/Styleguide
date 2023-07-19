# Git Hooks

При каждом пуше в remote предварительно прогоняется static analysis, который в случае провала запрещает пушить и создает в корне проекта папку **build_log** содержащую файл с полным выхлопом статика.

### Подключение:

1. В build.gradle модуля **app** добавить строчку  
`apply from: "$buildScriptsDir/gradle/installGitHooks.gradle"`