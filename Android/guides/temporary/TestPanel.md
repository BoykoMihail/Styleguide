# Тестовая панель

На каждом нашем проекте должны быть flavor'ы `withTestPanel/withoutTestPanel`, отвечающие за доступность тестовых инструментов. Сейчас только за `Chucker` и `LeakCanary`. 

Добавлять в проект так:

1. Добавить в build.gradle модуля **app** к flavorDimensions `"testPanel"`

2.  В productFlavors добавить
    ```groovy
    withTestPanel {
        dimension "testPanel"
    }
    withoutTestPanel {
        dimension "testPanel"
    }
    ```

3. Добавить зависимости:
    ```groovy
    // Chucker
    withTestPanelImplementation "com.github.ChuckerTeam.Chucker:library:3.1.1"
    withoutTestPanelImplementation "com.github.ChuckerTeam.Chucker:library-no-op:3.1.1"

    // LeakCanary
    withTestPanelImplementation "com.squareup.leakcanary:leakcanary-android:2.1"
    ```

4. Добавить  
`addInterceptor(ChuckerInterceptor(context))`  
к OkHttpClient.Builder() в NetworkModule (+ нужно контекст прокинуть)

5. Выбрать флейвор с тестовой панелью и наслаждатся повышенным качеством собственной рабочей среды

6. (Опционально) если при билде без тестовой панели вылезла ошибка  
`Using 'decodeHex(String): ByteString' is an error`  
то к зависимостям нужно добавить:
    ```groovy
    // Okio
    implementation "com.squareup.okio:okio:2.4.3"
    ```

Пул где всё это сделано на примере ликарда –
https://github.com/TouchInstinct/Licard-android/pull/927/files

<img src="https://user-images.githubusercontent.com/25684167/73825033-502aa180-480c-11ea-84a1-5e06bc1b7c34.png" width="75" height="75">

**Добавление flavor'а сломает билд на сервере ! По поводу починки писать [Саше Бунтакову](http://t.me/abuntakov)**

<img src="https://user-images.githubusercontent.com/25684167/73825033-502aa180-480c-11ea-84a1-5e06bc1b7c34.png" width="75" height="75">

**Нужно быть аккуратным с изменением CI, потому что это может сломать сборку из других веток.** Например, на проекте есть ветка release4 и release5. Если добавить новый флейвор в release5 и поменять CI, то сломается сборка на release4. Есть несколько вомзожных вариантов:
1. Ждать, когда смержится release4
2. Внедрять изменения во все ветки сразу