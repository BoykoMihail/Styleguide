# Список того, что важно знать

**[Android Developer Roadmap 2019](https://raw.githubusercontent.com/mobile-roadmap/android-developer-roadmap/master/images/android_roadmap.png)**

## Android System
 - Dalvik VM и Garbage collector (что такое, как происходит сборка мусора)
 - Manifest, Multidex и ресурсы приложения (основные настройки в манифесте, виды ресурсов, организация ресурсов приложения, подключение jniLibs, использование ассетов, кастомных шрифтов)
 - Activity (жизненный цикл, настройки манифеста, интент, ActivityResult)
 - Service (создание, особенности IntentService, состояние foreground, доступ к сервису другим приложениям)
 - Broadcast Receiver (как используется, прослушивание и отправка сообщений, выполнение длительных задач)
 - Deeplink
 - Widget (виды виджетов, настройка, обновление)
 - Handler
 - работа с SQLite (Cursor, основные отличия от полноценных БД)
 - Permissions (объявление в Manifest, запрос вручную на Android M+)
 - процессы (запуск Activity/Service в отдельном процессе, способы взаимодействия с ними, AIDL)
 - SharedPreferences, организация доступа к ресурсам приложения из других приложений
 - получение данных о системе (основные сервисы Android, получение данных через getprop/getenv)
 - проигрывание аудио/видео (MediaPlayer, AudioTrack, как проигрывать HLS на Android, проигрывание музыки в фоне, DRM)

## Android Navigation
 - переходы между Activity
 - Fragment (жизненный цикл, retainInstance, взаимодействие с Activity, TargetFragment)
 - FragmentManager (навигация на его основе, backStack)
 - DrawerLayout, Toolbar, TabLayout, ViewPager
 - Toast, Dialog, PopupWindow, Snackbar
 - Notification (в том числе custom)

## Android UI
 - базовые ViewGroup (FrameLayout, LinearLayout, RelativeLayout)
 - базовые View (TextView, EditText, ImageView, SwitchCompat, Spinner, CheckBox)
 - RecyclerView (особенности, LayoutManager, Decoration)
 - создание адаптера (обновление конкретных ячеек, разные типы ViewHolder'ов)
 - продвинутые элементы (Percent layouts, CoordinatorLayout)
 - загрузка картинок на основе Fresco
 - основные виды Drawable (shape, selector, layer-list, ripple)
 - создание кастомного Drawable (как рисовать, как сделать анимированным)
 - работа с Canvas
 - создание кастомной View (этапы: onMeasure, onLayout, onDraw)
 - методы View.forceLayout, View.requestLayout, View.invalidate (как работают, когда использовать)

## Android Animation
 - задание анимации переходов между Activity
 - задание анимации переходов между Fragment
 - задание анимации изменения наборов элементов RecyclerView
 - AnimationDrawable
 - анимация с помощью android:animationLayoutChanges (как работает, как настраивается)
 - класс Animation (основные параметры, как использовать)
 - ObjectAnimator
 - анимация на основе CoordinatorLayout

## Google Services
 - Geolocation (интеграция, настройки)
 - Maps (интеграция, кастомизация, кластеризация маркеров)
 - Push-Notification, GCM (регистрация, как работает)
 - In-app (интеграция, виды, использование)
 - Google AdMob (интеграция, особенности)

## Java RX
  - паттерн Observer, как реализован в Java RX
  - Observable.create - что такое, как работает
  - PublishSubject, BehaviorSubject - как работают, зачем нужны
  - hot/cold subscriptions - в чем отличия, как использовать
  - Schedulers - что такое, когда какие использовать
  - ошибка MissingBackpressure - когда возникает, как избежать
  - ConnectableObservable - что такое, когда использовать, основные операторы
  - основные операторы, как работают
  - создание сложных цепочек потоков данных

## RoboSwag (пока не готова)
  - использование логгера (Lc.*, Lc.assertion)
  - навигация с помощью pushFragment/setFragment
  - использование кастомных TextView, EditText
  - настройка ActionBar в зависимости от фрагмента
  - загрузка контента, выполнение запросов
  - использование Storable
  - постраничные списки

## Сторонние библиотеки
 - Android Support Library (appcompat, design, percent, multidex etc.)
 - Android Services (geolocation, maps, in-apps, gcm, admob, google-plus)
 - Crashlytics
 - Rx Android
 - OkHttp
 - Fresco
 - Socket.io
 - ExoPlayer
 - Jackson JSON (в том числе google-http-client-android)
 - ORMLite
