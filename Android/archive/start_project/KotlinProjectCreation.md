# Создание проекта на Koltin

1. Узнаем у Менеджера проекта Application ID. Используя этот ID, cоздаем проект в Android Studio без всего (без активити и прочего).

     В проекте автоматически создаются два `build.gradle` файла: `build.gradle` **проекта**, находящийся в корневой папке, и `build.gradle` **модуля** в папке `app`:

     ![Gradle-файлы](images/gradle_files.png?raw=true)

2. Устанавливаем плагин `Kotlin для Android Studio`, если версия Android Studio меньше 3.0.
      * переходим в File > Settings > Plugins > Install JetBrains plugin… > ищем плагин и устанавливаем его;
      * перезапускаем Android Studio после установки.

3. Подключаем Kotlin плагин, если версия Android Studio меньше 3.0:
    * в файле `build.gradle` **модуля** добавляем строку:

        ```groovy
        apply plugin: 'kotlin-android'
        ```

    * в файле `build.gradle` **проекта** указываем последнюю ([например, см на сайте](https://plugins.gradle.org/plugin/org.jetbrains.kotlin.android)) версию плагина:

        ```groovy
        buildscript {
          ext.kotlin_version = ':#latest_version'
          ...
          dependencies {
            classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"        
            ...
            }
         }
        ```

4. Создаем git-репозиторий:        
    * в папке проекта выполняем команду:

        ```
        git init
        ```

    * меняем `.gitignore` файл проекта на [этот](https://github.com/TouchInstinct/Styleguide/blob/master/android/guides/common/project.gitignore)

5. Подключаем сабмодули Touch Instinct. Легче всего это делать через приложение [Sourcetree](https://www.sourcetreeapp.com/) (Repository -> Add submodule).
    * в папке **проекта** создаем папку `libraries`
    * подключаем сабмодуль [BuildScripts](https://github.com/TouchInstinct/BuildScripts):

        `git@github.com:TouchInstinct/BuildScripts.git` в папку `libraries/BuildScripts`
    * подключаем сабмодуль [RoboSwag-core](https://github.com/TouchInstinct/RoboSwag-core)

        `git@github.com:TouchInstinct/RoboSwag-core.git` в папку `libraries/core`
    * подключаем сабмодуль [RoboSwag-components](https://github.com/TouchInstinct/RoboSwag-components)

        `git@github.com:TouchInstinct/RoboSwag-components.git` в папку `libraries/components`
    * подключаем сабмодуль [android-templates](https://github.com/TouchInstinct/android-templates)

        `git@github.com:TouchInstinct/android-templates.git` в папку `libraries/templates`
    * файл `settings.gradle` после подключение сабмодулей должен выглядеть так:

        ```groovy
        include ':app', 'libraries:core', 'libraries:components', 'libraries:templates'
        ```
    * в файле `build.gradle` **модуля** добавляем в раздел `dependencies`:

        ```groovy
        dependencies {
                ...
                implementation project(path: ':libraries:templates')
        }
        ```

6. Обновляем версию Gradle и подключаем VectorDrawable:
    * в файле `gradle-wrapper.properties` меняем версию на последнюю ([например, см на сайте](http://services.gradle.org/distributions)) в параметре `distributionUrl`;
    * в файле `build.gradle` **проекта** меняем версию `com.android.tools.build:gradle` на последнюю ([например, см на сайте](https://bintray.com/android/android-tools/com.android.tools.build.gradle)):

        ```groovy
        dependencies {
            classpath 'com.android.tools.build:gradle:#latest_version'
        }
        ```
    * также в файле `build.gradle` **модуля** добавляем включаем поддержку VectorDrawable:

        ```groovy
        defaultConfig {
            vectorDrawables.useSupportLibrary = true
        }
        ```
        Так же в Application классе добавляем в ```onCreate```
        ```kotlin
         override fun onCreate() {
             super.onCreate()
             AppCompatDelegate.setCompatVectorFromResourcesEnabled(true)
         }
        ```

7. Подключаем функции Java 8:
    * в `build.gradle` **модуля** добавляем:

        ```groovy
        android {
            ...
            compileOptions {
                sourceCompatibility JavaVersion.VERSION_1_8
                targetCompatibility JavaVersion.VERSION_1_8
            }
         }
        ```

8. Переименовываем иконки `ic_launcher` -> `global_app_icon_normal` и `ic_launcher_round` -> `global_app_icon_round`, а также имя приложения в соответствии с https://github.com/TouchInstinct/team/blob/master/processes/Strings-And-Images-Naming-Rules.md

9. Настраиваем основные параметры `build.gradle` **модуля**:
    * `compileSdkVersion`, `targetSdkVersion` выставляются самыми актуальными;
    * Устанавливаем версии compileSdk, SupportLib и RxJavaэтого необходимо в файле build.gradle **проета**:
       ```
       ext {
               compileSdk = useLatestVersionHere
               supportLibraryVersion = 'useLatestVersionHere'
               rxAndroidVersion = 'useLatestVersionHere'
               rxJavaVersion = 'useLatestVersionHere'
          }
       ```
    * `applicationId` и `minSdkVersion` в зависимости от требований заказчика;
    * меняем именование версий:

        ```groovy
        android {
            ...
            defaultConfig {
                ...
                versionCode System.getenv("BUILD_NUMBER") as Integer ?: 10000
                versionName "1.0." + versionCode
            }

            buildTypes {
                debug {
                    ...
                    versionNameSuffix ".debug"
                }
            }
        }
        ```

10. Настраиваем оптимизации размера APK (ProGuard, Shrinking, Cruncher):
    * создаем в папке `модуля` папку `proguard` и вкладываем туда [конфигурации] (https://github.com/TouchInstinct/Styleguide/tree/master/android/guides/common)
    * чтобы ProGuard не трогал классы моделей, распологаем их в package'ах, содержащих названия **"model"**. Например, `ru.dbo.logic.api.model.TestResponse.java` или `ru.dbo.logic.db.model.User.java`;
    * в `build.gradle` **модуля** включаем Proguard и Shrinking ресурсов только для `release` версии:

        ```groovy
        android {
            ...
            buildTypes {
                debug {
                    minifyEnabled false
                    shrinkResources false
                }
                release {
                    minifyEnabled true
                    shrinkResources true
                }
            }
        }
        ```

    * из `build.gradle` **модуля** убираем строку с настройками `proguardFiles`:

        ```groovy
        android {
            ...
            buildTypes {
                release {
                    proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
                }
            }
        }
        ```

    * удаляем файл proguard-rules.pro из папки `app`
    * в `build.gradle` **модуля** добавляем специальный `flavor` для обфускации и оптимизации Proguard:

        ```groovy
        android {
            ...
            flavorDimensions "proguardSettings"

            productFlavors {
                noObfuscate {
                    dimension "proguardSettings"
                    proguardFile file("proguard/proguard-debug.cfg")
                }

                obfuscate {
                    dimension "proguardSettings"
                    proguardFile file("proguard/proguard-release.cfg")
                }
            }
            ...
        }
        ```
    * в `build.gradle` **модуля** отключаем Cruncher:

        ```groovy
        android {
            ...
            aaptOptions {
                cruncherEnabled false
            }
            ...
        }
        ```

 11. Подключаем MultiDex
      * в `build.gradle` **модуля** добавляем:

        ```groovy
        android {
            ...
            dexOptions {
                javaMaxHeapSize "4g"
            }
            defaultConfig {
                multiDexEnabled = true
            }
        }
        ```
      * наследуем класс `Application` приложения (если нет, добавляем) от класса `ru.touchin.templates.TouchinApp`, либо в класс `Application` приложения вставляем:

        ```kotlin
        override fun attachBaseContext(base: Context) {
            super.attachBaseContext(base)
            MultiDex.install(base)
        }
        ```

      * добавляем в файле `AndroidManifest.xml` в объект `<application/>` поле `android:name=".YourApp"`,где `YourApp` - название класса, который наследуется от класса `Application`.

12. Подключаем статический анализ, как описано в [этой статье](../../guides/static/StaticAnalysisPlugin.md)

13. Добавляем Signing Keys проекта:
    * если проект уже выложен в маркет, просим у заказчика;
    * если проект новый или в маркете будет лежать под другим package-name, то генерируем ключи http://developer.android.com/intl/ru/tools/publishing/app-signing.html#studio
    * кладем сгенерированный ключ в папку `project/app/keystore/`;
    * добавляем код в файл `build.gradle` **модуля**, где `YOUR_KEY_NAME` - имя созданного или полученного ключика, а поля `***` - соответствующие данные из ключика:

        ```groovy
        android {
            ...
            signingConfigs {
                releaseConfig {
                    storeFile file("keystore/YOUR_KEY_NAME.jks")
                    storePassword "***"
                    keyAlias "***"
                    keyPassword "***"
                }
            }
        }
        ```

14. Удаляем лишние классы и зависимости:
    * удаляем все классы и папки, необходимые для тестирования;
    * удаляем из файла `build.gradle` **модуля** строчку `testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"`;
    * удаляем из файла `build.gradle` **модуля** строчку `compile fileTree(dir: 'libs', include: ['*.jar'])`
    * удаляем из файла `build.gradle` **модуля** все остальное, что связано с тестированием;
    * удаляем из файла `styles.xml` все строчки, находящиеся внутри `AppTheme`.


# Подключение Stetho (если нужен)

1. Подключаем Stetho в Gradle:
      *  в `build.gradle` **модуля** добавляем, где `#latest_version` - последняя версия stetho ([можно посмотреть здесь](http://facebook.github.io/stetho/#download)):

      ```groovy
      debugCompile 'com.facebook.stetho:stetho:#latest_version'
      debugCompile 'com.facebook.stetho:stetho-okhttp3:#latest_version'
      ```

2. Наследуем класс `Application` приложения от класса `ru.touchin.templates.TouchinApp` **либо** в классе `Application` вставляем:

      ```kotlin
      override fun onCreate() {
          super.onCreate()
          try {
            Stetho.initializeWithDefaults(this)
          } catch (error: NoClassDefFoundError) {
            Lc.e("Stetho initialization error! Did you forget to add debugCompile 'com.facebook.stetho:stetho:+' to your build.gradle?")
          }
      }
      ```

3. Добавляем Interceptor

     * обновляем функцию создания OkHttpClient:

       ```kotlin
       val builder = OkHttpClient.Builder()
       if (BuildConfig.DEBUG) {
            configureInterceptor(builder)
       }
       ```

     * В app/src, рядом с main, создаём ещё 2 директории: debug и release.
       В соответствующие имени пакета директории кладём файл `StethoInterceptorDebugOnly.kt`, содержащий функцию `configureInterceptor`:

       В `debug`:
       ```kotlin
       fun configureInterceptor(httpClientBuilder: OkHttpClient.Builder) {
          httpClientBuilder.addNetworkInterceptor(StethoInterceptor())
       }
       ```

       А в `relese`:
       ```kotlin
       fun configureInterceptor(httpClientBuilder: OkHttpClient.Builder) {
          // do nothing
       }
       ```       

# Подключение Fabric   

1. Получаем у Менеджера проекта аккант для входа в Fabric https://fabric.io/ (если его еще нет)

2.  Создаем проект на Fabric:
      * если проект уже создан, нам потребуются API_KEY и название группы для тестирования, переходим к следующему пункту;
      * в настройках создаем новую организацию (https://fabric.io/settings/organizations). Менеджер проекта должен дать название;
      * добавляем в команду всех, кого скажет менеджер проекта. Также меняем им роль с `Team` на `Admin` по информации от менеджера;
      * в настройках, под название проекта, копируем `API Key`, он понадобится в следующем шаге.

3. Подключаем Fabric:
    * установливаем плагин `Fabric for Android Studio`(File > Settings > Plugins > ищем плагин и устанавливаем его), перезапускаем Android Studio после установки;

    * в `build.gradle` **проекта** добавляем, где `#latest_version` - последняя версия ([например, см на сайте](https://docs.fabric.io/android/changelog.html#fabric-gradle-plugin)):

        ```groovy
        buildscript {
            repositories {
                jcenter()
                maven { url 'https://maven.fabric.io/public' }
            }
            dependencies {
                ...
                classpath 'io.fabric.tools:gradle:#latest_version'
            }
        }

        allprojects {
            repositories {
                jcenter()
                maven { url 'https://maven.fabric.io/public' }
            }
        }
        ```
    * в `build.gradle` **модуля** добавляем:

        ```groovy
        ...
        apply plugin: 'io.fabric'

        android {
            ...
            buildTypes {
                ...
                 release {
                ...
                    ext.enableCrashlytics = true
                }
            }
        }

        dependencies {
            ...
            compile('com.crashlytics.sdk.android:crashlytics:+') {
                transitive = true;
            }
        }
        ```

    * в `AndroidManifest.xml` добавляем (API_KEY мы получили в предыдущем шаге):

        ```xml
        <manifest ...>
            <uses-permission android:name="android.permission.INTERNET" />

            <application ...>
                ...

                <meta-data
                    android:name="io.fabric.ApiKey"
                    android:value="API_KEY" />

            </application>

        </manifest>
        ```

4. Активируем Fabric
    * Для успешной активации выполняем все действия переведя проект в конфигурацию ```Release```. В класс `Application` приложения (даже если он наследуется от класса `ru.touchin.templates.TouchinApp`) вставляем:

        ```kotlin
            override fun onCreate() {
               super.onCreate()
               Fabric.with(this, Crashlytics())
            }
        ```

    * запускаем приложение. Fabric должен инициализироваться. Проверьте, что в dashboard на сайте появилось приложение в организации проекта

5. Активируем Fabric Events
    * Для успешной активации выполняем все действия переведя проект в конфигурацию ```Release```. Заменяем код в классе `Application` на:

        ```kotlin
        override fun onCreate() {
           super.onCreate()
           Fabric.with(this, Answers())
        }
        ```

    * открываем в dashboard проекта на сайте Fabric, заходим в раздел Events, включаем Events для данного приложения;
    * запускаем приложение. После этого обновляем страницу сайта и проверяем, что раздел Events стал доступен.

6. Завершаем настройку Fabric.

     * на сайте заходим в dashboard (https://fabric.io/home), выбираем наш проект, затем в боковом меню выбираем `Beta` > `Manage Groups`. Создаем новую группу и добавляем туда пользователей, которые будут принимать участие в тестировании (спросить у менеджера проекта). Запоминаем название группы, оно нам понадобится в следующем шаге;
     * в `build.gradle` **модуля** добавляем, где `FABRIC_TESTERS_GROUP` - название группы тестировщиков из Fabric "Beta", которое мы получили в предыдущем шаге:

        ```groovy

        android {
            ...
            buildTypes {
                debug {
                ...
                    ext.enableCrashlytics = false
                }
                release {
                ...
                    ext.enableCrashlytics = true
                    ext.betaDistributionGroupAliases = "FABRIC_TESTERS_GROUP"
                    ext.betaDistributionReleaseNotesFilePath = file("release-notes.txt")
                }
            }
        }
        ```

    * если класс `Application` приложения от класса `ru.touchin.templates.TouchinApp`, то убираем инициализацию Fabric из метода onCreate
