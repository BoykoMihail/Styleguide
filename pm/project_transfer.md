# Процесс передачи артефактов проекта клиенту
Должен применяться как для передачи артефактов проекта по акту в рамках закрытия этапа работ, так и по завершению проекта целиком.

1. Определить, состояние проекта на какую именно дату мы хотим передать. Если передача идет по завершению работ, необходимо передавать все последние коммиты. Если передача идет после завершения этапа работ, а проект еще продолжается, то передать необходимо состояние проекта именно на дату составления акта либо состояние проекта, соответствующее нужному ТЗ. При этом необходимо, чтобы передаваемое состояние проекта было консистентным, например, чтобы версия сервера была именно той, с которой работают мобильные приложения из этого коммита. Даже если она была задеплоена раньше даты завершения этапа по мобильным приложениям.
1. Найти в каждом репозитории коммиты, соответствующие этой дате/состоянию.
1. Для каждого репозитория, содержащего самостоятельную часть проекта, которая может быть задеплоена отдельно (например, репозитории -ios, -android, -server, -assets и т.д. Но не репозитории типа -common, которые могут использоваться только как сабмодули):
	1. Сделать git clone репозитория в чистую папку рекурсивно с сабмодулями.
	1. Удалить все папки и файлы .git в папке репозитория и всех подпапках, в т.ч. в подпапках с сабмодулями.
1. Собрать все полученные папки с репозиториями в одной папке.
1. Заархивировать папку с исходным кодом, назвать архив <название проекта>-src-<дата>.zip
1. При наличии чек-листов по проекту сделать их экспорт.
1. Сделать экспорт дизайн-макетов проекта либо создать текстовый файл со ссылкой на фигму с нужным состоянием проекта.
1. Проверить, что еще требуется передать клиенту по акту. Например, может быть дополнительная документация и инструкции по деплою. Создать дополнительные требуемые артефакты.
1. Артефакты из предыдущих 4 пунктов собрать вместе в папку и заархивировать ее, назвать архив <название проекта>-<дата>.zip
1. Переслать архив, список того, что в него входит, и форму акта исполнительному директору.

*p.s. По мотивам пунктов 1-5 написан скрипт [export_src.sh](https://github.com/TouchInstinct/BuildScripts/blob/master/export_src.sh). Скрипт берет последний коммит из мастера и собирает все исходники в одном архиве. Пример ввода: `./export_src.sh project_name android ios middle`*