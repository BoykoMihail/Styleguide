 # Шпаргалки
 
### Файлы в формате base64
##### pdf
https://docs.google.com/document/d/1UQ0ZDolsZUHNB1Ig301rXVpRM7-iKcXc79x5GZ2LT9o/edit
##### png
https://docs.google.com/document/d/1gjL4GRpGuVvFnfe3ER-JF72HyEJajnk5VVSlEqJsfho/edit

### Тестирование локализации
Если приложение работает только с en/ru, пробовать установить другой системный язык (Чешский, Японский, Арабский)

### Пагинация без якорей
- скролим список n (чего угодно)
- приложенька запрашивает еще m элементов списка
- тут же приходит от сервера новый элемент списка
- приложенька выводит n + m элементов списка + выводит пришедшее сообщение
Итог:
- в месте соединения первой и второй страницы списка будет дублирование элемента

### FAB
проверять сокращение списка в нижней позиции скролла когда FAB скрыта -- она может не появиться

