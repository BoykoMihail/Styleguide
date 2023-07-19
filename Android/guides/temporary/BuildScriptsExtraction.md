# Вынесение BuildScripts в отдельный submodule

1) Обновить submodule RoboSwag до последней версии
2) Удалить папку **.git/modules/Roboswag/modules/BuildScripts**
3) Удалить папку **Roboswag/BuildScripts**
4) В корне проекта прописать  
`git submodule add git@github.com:TouchInstinct/BuildScripts.git BuildScripts`
5) Изменить значение переменной `buildScriptsDir` в build.gradle проекта на  
`"$rootProject.projectDir/BuildScripts"`


