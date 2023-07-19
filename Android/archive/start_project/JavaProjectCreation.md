# Создание проекта

1. Создаем проект в Android Studio без всего (без активити и прочего)

2. Подключаем сабмодули Touch Instinct. Легче всего это делать через приложение [Sourcetree](https://www.sourcetreeapp.com/) (Repository -> Add submodule). 
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
        buildscript {
            dependencies {
                ...
                compile project(path: ':libraries:templates')
            }
        }
        ```
3. Выставляем последнюю версию Gradle:
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
4. Переименовываем иконку и имя приложения в соответствии с https://github.com/TouchInstinct/team/blob/master/processes/Strings-And-Images-Naming-Rules.md

5. Меняем `.gitignore` файл проекта на https://github.com/TouchInstinct/Styleguide/blob/master/android/project.gitignore

6. Настраиваем основные параметры `build.gradle` **модуля**:
    * `compileSdkVersion`, `buildToolsVersion`, `targetSdkVersion` выставляются самыми актуальными;
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
7. Настраиваем оптимизации размера APK (ProGuard, Shrinking, Cruncher):
    * создаем в папке `модуля` папку `proguard` и вкладываем туда конфигурации https://github.com/TouchInstinct/Styleguide/tree/master/android/proguard
    * чтобы ProGuard не трогал классы моделей, распологайте их в package'ах, содержащих названия **"model"**. Например, `ru.dbo.logic.api.model.TestResponse.java` или `ru.dbo.logic.db.model.User.java`
    * в `build.gradle` **модуля** включаем Proguard только для `release` версии:
    
        ```groovy
        android {
            ...
            buildTypes {
                debug {
                    minifyEnabled false
                }
                release {
                    minifyEnabled true
                }
            }
        }
        ```
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
    * в `build.gradle` **модуля** включаем Shrinking ресурсов только для `release` версии:
    
        ```groovy
        android {
            ...
            buildTypes {
                debug {
                    shrinkResources false
                }
                release {
                    shrinkResources true
                }
            }
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
8. Подключаем MultiDex
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
    
        ```java
        @Override
        protected void attachBaseContext(@NonNull final Context base) {
            super.attachBaseContext(base);
            MultiDex.install(base);
        }
        ```
    * добавляем в файле `AndroidManifest.xml` в объект `<application/>` поле `android:name=".YourApp"`,где `YourApp` - название класса, который наследуется от класса `Application`.

9. Подключаем RetroLambda
    * убедитесь, что установлена системная переменная `JAVA_HOME`
    * в `build.gradle` **проекта** добавляем:
    
        ```groovy
        buildscript {
            ...
            dependencies {
                ...
                classpath 'me.tatarka:gradle-retrolambda:+'
            }
        }
        ```
    * в `build.gradle` **модуля** добавляем
        
        ```groovy
        apply plugin: 'com.android.application'
        apply plugin: 'me.tatarka.retrolambda'
        ...

        android {
            ...
            compileOptions {
                sourceCompatibility JavaVersion.VERSION_1_8
                targetCompatibility JavaVersion.VERSION_1_8
            }
         }
         
         retrolambda {
             jdk System.getenv("JAVA_HOME")
             jvmArgs '-noverify'
         }
        ...
        ```

10. Создаем проект на Fabric:
    * если проект уже создан, нам потребуются API_KEY и название группы для тестирования, переходим к следующему пункту;
    * в настройках создаем новую организацию. Менеджер проекта должен дать название;
    * добавляем в команду всех, кого скажет менеджер проекта. Также меняем им роль с `Team` на `Admin` по информации от менеджера;
    * в настройках, под название проекта, копируем `API Key`, он понадобится в следующем шаге;
    * заходим в dashboard, выбираем наш проект, затем выбираем `Beta`, `Manage Groups`. Создаем новую группу и добавляем туда пользователей, которые будут принимать участие в тестировании (спросить у менеджера проекта). Запоминаем название группы, оно нам понадобится в слудующем шаге.

11. Подключаем Fabric:
    * установите плагин `Fabric for Android Studio`:
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
    * в `build.gradle` модуля добавляем, где `FABRIC_TESTERS_GROUP` - название группы тестировщиков из Fabric "Beta", которое мы получили в предыдущем шаге:
    
        ```groovy
        ...
        apply plugin: 'io.fabric'

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
    * наследуем класс `Application` приложения (если нет, добавляем) от класса `ru.touchin.templates.TouchinApp`;
    * либо в классе `Application` вставляем:
        
        ```java
        @Override
        public void onCreate() {
            super.onCreate();
            if (!BuildConfig.DEBUG) {
                final Crashlytics crashlytics = new Crashlytics();
                Fabric.with(this, crashlytics);
            }
        }
        ```
    
12. Активируем Fabric:
    * временно, **только на момент активации** удаляем строчку `ext.enableCrashlytics = false` из файла `build.gradle` **модуля** `buildTypes{ debug { ... } }`;
    * в класс `Application` вставляем код:
    
        ```java
        @Override
        public void onCreate() {
            super.onCreate();
            Fabric.with(this, new Crashlytics());
        }
        ```
    * запускаем приложение. Fabric должен инициализироваться. Проверьте, что в dashboard на сайте появилось приложение в организации проекта;
    * заменяем код в классе `Application` на:
    
        ```java
        @Override
        public void onCreate() {
            super.onCreate();
            Fabric.with(this, new Answers());
        }
        ```
    * открываем в dashboard проекта на сайте Fabric, заходим в раздел Answers;
    * запускаем приложение. После этого, на сайте должна обновиться информация и раздел Answers должен стать доступен;
    * удаляем все изменения, которые были сделаны в классе `Application`;
    * восстанавливаем строчку `ext.enableCrashlytics = false`, удаленную на первом шаге активации Fabric.
 
13. Подключаем статический анализ:
    * добавляем в `build.gradle` **проекта**, где `#latest_version` - это актуальная версия библиотеки ([например, см на сайте](https://github.com/aaschmid/gradle-cpd-plugin)):
    
        ```groovy
        buildscript {
            ...
            dependencies {
                ...
                classpath 'de.aaschmid.gradle.plugins:gradle-cpd-plugin:#lastest_version'
            }
            ...
        }
        ```
    * добавляем в конец файла `build.gralde` **модуля**:
    
        ```groovy
        ...

        apply from: "${rootDir}/libraries/BuildScripts/gradle/staticAnalysis.gradle"
        ```
    * если какие-то модули нужно исключить из статик анализа, в `build.gradle` **модуля** добавляем:
    
        ```groovy
        android {
            ...
            defaultConfig {
                ...
                rootProject.extensions.staticAnalysisExcludes = [':module_1_name', ':module_2_name']
            }
            ...
        }
        ```
    
14. Добавляем Signing Keys проекта:
    * если проект уже выложен в маркет, просим у заказчика
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

15. Удаляем лишние классы и зависимости:
    * удаляем все классы и папки, необходимые для тестирования;
    * удаляем из файла `build.gradle` **модуля** строчку `testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"`;
    * удаляем из файла `build.gradle` **модуля** строчку `compile fileTree(dir: 'libs', include: ['*.jar'])`
    * удаляем из файла `build.gradle` **модуля** все остальное, что связано с тестированием.
    * удаляем из файла `styles.xml` все строчки, находящиеся внутри `AppTheme`.


16. Подключаем Stetho (если нужен):
    * в `build.gradle` **модуля** добавляем, где `#latest_version` - последняя версия stetho ([можно посмотреть здесь](http://facebook.github.io/stetho/#download)):

    ```
    debugCompile 'com.facebook.stetho:stetho:#latest_version'
    debugCompile 'com.facebook.stetho:stetho-okhttp3:#latest_version'
    ```
    * наследуем класс `Application` приложения (если нет, добавляем) от класса `ru.touchin.templates.TouchinApp`;
**либо** в классе `Application` вставляем:
        
     ```java
     @Override
     public void onCreate() {
         super.onCreate();
         if (BuildConfig.DEBUG) {
             Stetho.initializeWithDefaults(this);
         }
     }
     ```
    * добавляем Interceptor
       ```java
       final OkHttpClient.Builder builder = new OkHttpClient.Builder();
       if (BuildConfig.DEBUG) {
           StethoInterceptorDebugOnly.configureInterceptor(builder);
       }
       ```

       В app/src, рядом с main, создаём ещё 2 директории: debug и release.
       В соответствующие имени пакета директории кладём `StethoInterceptorDebugOnly`
       
       В `debug`
       ```java
       public final class StethoInterceptorDebugOnly {

         public static void configureInterceptor(@NonNull final OkHttpClient.Builder httpClientBuilder) {
           httpClientBuilder.addNetworkInterceptor(new StethoInterceptor());
         }

         private StethoInterceptorDebugOnly() {
         }

       }
       ```

       А в `relese`
       ```java
       public final class StethoInterceptorDebugOnly {

         public static void configureInterceptor(@NonNull final OkHttpClient.Builder httpClientBuilder) {
           // do nothing
         }

         private StethoInterceptorDebugOnly() {
         }

       }
       ```
       
17. Указываем версии основных библиотек в extentsion корневого `build.gradle`:
       ```groovy
       ...
       ext {
          compileSdk = #compile_sdk_version
          buildTools = '#build_tools_version'

          supportLibraryVersion = '#support_library_version'
          rxAndroidVersion = '#rx_android_version'
          rxJavaVersion = '#rx_java_version'
      }
      ```
