# Именование файлов приложений

В модуле BuildScripts имеется скрипт для именования файла приложения (apk/aab) в формате  
`${applicationId}-${versionName}-${versionCode}-${buildName}`

Для использования в проекте необходимо:

1) Обновить сабмодуль `BuildScripts`

2) В build.gradle модуля **app** иметь определенные значения  
`android.defaultConfig.applicationId`  
`android.defaultConfig.versionName`  
`android.defaultConfig.versionCode`  

<img width="630" alt="image" src="https://user-images.githubusercontent.com/25684167/73743031-b953db80-475e-11ea-9e43-0ba85c9a83cf.png">

3) В build.gradle модуля **app** добавить строчку  
`apply from: "$buildScriptsDir/gradle/applicationFileNaming.gradle"`

Пример именования:  
***ru.serebryakovas.lukoilmobileapp-3.4.10000-10000-noObfuscate-touchinTest-withoutSSLPinning-debug.apk***
