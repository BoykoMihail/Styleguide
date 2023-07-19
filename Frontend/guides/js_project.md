# Common

В качестве пакетного менеджера использовать __yarn__

Перед каждым коммитом запускается __js-linter__ и __css-linter__, запрещается коммитить, если проверка линтеров провалилась.

# Структура проекта

```bash
├── app
│   ├── components
│   │   ├── Common
│   │   ├── FormControls
│   │   ├── AnyComponentGroupName
│   │   │    ├── AnyComponentName.jsx
|   |   |    └── AnyComponentNameContainer.jsx
│   ├── modules
│   │   ├── moduleName
│   │   │    ├── actions.js
│   │   │    ├── logic.js
│   │   │    ├── transform.js
|   |   |    └── reducer.js
│   │   ├── logics.js
│   │   └── reducers.js
│   ├── pages
│   │   ├── App
|   |   |    └── App.jsx
│   │   ├── PageName
│   │   │    ├── route.js
|   |   |    └── PageName.jsx
│   ├── fonts
│   │   ├── src
|   |   └── generatedFonts.*
│   ├── images
|   ├── styles
|   │   ├── blocks
|   │   ├── common
|   │   └── index.scss
│   ├── utils
│   ├── apiRoutes.js
│   ├── configStore.js
│   ├── index.html
│   ├── index.js
│   ├── Root.jsx
│   └── routeConfig.js
├── deploy
│   ├── process.test.json
│   ├── process.production.json
│   ├── projectname.touchin.com.conf
│   └── projectname.com.conf
├── locale
├── node_modules
├── scripts
│   ├── js-checker
│   ├── css-checker
│   ├── deploy_server.sh
│   └── deploy_web.sh
├── src
├── tests
├── .babelrc
├── .editorconfig
├── .eslintrc
├── .gitignore
├── package.json
├── postcss.config.js
├── version
└── webpack.config.js
```

## Файлы конфигурации

[.babelrc](./js_project/.babelrc) - файл нельзя менять без согласования со всей командой

[.editorconfig](./js_project/.editorconfig) - правила для редактора

[.eslintrc](./js_project/.eslintrc) - файл нельзя менять без согласования со всей командой

`version` - текущая версия приложения, увеличение версии происходит при каждом деплое

`webpack.config.js` - файл нельзя менять без согласования со всей командой

## Deploy

`process.test.json` - конфигурация для запуска бекенда на тестовом сервере

`process.production.json` - конфигурация для запуска бекенда на production сервере

`projectname.touchin.com.conf` - конфигурация __nginx__ для тестового сервера

`projectname.com.conf` - конфигурация __nginx__ для production сервера

## Скрипты

[js-checker](./js_project/js-checker) - проверка js-кода перед коммитом

`css-checker` - проверка css-кода перед коммитом

[deploy_web.sh](./js_project/deploy_web.sh) - деплоит собранный web-проект на сервер. Если указана `NODE_ENV=production`, то деплоит на продакшн. Если аргументы не переданы, то версия проекта не увеличивается. При передаче одного из аргументов `-p` `-m` `-M` увеличиваются патч-версия, минорная версия, мажорная версия соответственно.

## Web

`/app/index.jsx` - единая точка входа

`/app/Root.jsx` - тут происходит коннект роутов и redux-стора

`/app/pages` - директория, в которой лежат страницы-компоненты.

`/app/pages/App` - главная страница, она задает общий layout. Другие страницы вкладываются в `App`, а так же содержат `route` 

`/app/apiRoutes.js` - набор api-endpoint'во для всего приложения

`/app/components` - каждый компонент помещается в отдельную папку.
Причем, в основном, в папке лежат [Умные и глупые компоненты](#Умные-и-глупые-компоненты)

`/app/modules/%moduleName%/` - тут лежит все, что относится к redux'у.

`/app/fonts/src` - тут лежат svg-иконки для шрифта. Размер каждой должен быть 640х640, без фона. Цвет иконки - черный.

`/app/styles` - папка со стилями для всего приложения

### Умные и глупые компоненты

Умные компоненты достают данные из redux-стора, подготавливают набор action'ов и передают это все глупым компонентам.
Глупые компоненты только отрисовывают контент и используют переданные колбеки. Умные компоненты не содержат разметки.


# Библиотеки, которые используются в проекте

- lodash/fp

- react

- redux

- redux-logic

- redux-form

- axios

- immutable

- moment

- reselect
