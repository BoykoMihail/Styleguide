### Передача данных

1. Создаем пакет dto (data transfer object) и помещаем в него классы, предназначенные для передачи данных.
В нашем примере класс с информацией о товаре и его категории.

![new package](Pictures/dto1.PNG?raw=true)

Spring Boot по умолчанию использует __Jackson__ в качестве JSON mapper-а, поэтому мы используем аннотации @JsonProperty, @JsonIgnore и т.д.
Переменные на данном этапе декларируем внутри класса, а не в конструкторе, далее мы это исправим. 

```kotlin
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.Date

class Product(
	title: String,
        description: String,
        categoryName: String,
        creationDate: Date
) {

    val title = title

    val description = description

    @JsonProperty("category_name")
    val categoryName = categoryName

    @JsonProperty("creation_date")
    val creationDate = creationDate

}
```

2. Используем объект класса __Product__ в качесте ответа на запрос __product/info__. 
Для этого в пакете controllers создаем новый класс __ProductController__ и добавляем в него метод __info__.
Чтобы не добавлять в каждом методе _"product"_, прописываем аннотацию __@RequestMapping("product")__ для всего контроллера.

```kotlin
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import ru.touchin.test.dto.Product
import java.util.Date

@RestController
@RequestMapping("product")
class ProductController {

    @GetMapping("info")
    fun info(): ResponseEntity<Product> {
        val product = Product("Choco pie", "Choco pie made by Orion", "candy", Date())
        return ResponseEntity.ok(product)
    }

}
```

3. Проверяем работу метода в браузере 

![check](Pictures/dto2.PNG?raw=true)


На данном этапе все работает, но есть несколько улучшений, которые стоит внести.

4. Аннотации __@JsonProperty__ копируют названия полей с использованием snake case, поэтому от них можно избавиться.
Настройки Jackson-а можно изменить через класс application.properties либо через настройки __bean-компонентов__.
Bean – это объекты, которые являются основой приложения и управляются Spring IoC контейнером (Inversion of Control, он же Dependency Injection). 
Подробнее можно почитать здесь: http://spring-projects.ru/guides/lessons/lesson-2/

Рассмотри настройку Jackson mapper-а через Bean. Для этого создадим класс __BeanConfig__ и поместим в него __@Bean fun jacksonObjectMapper()__

```kotlin
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.PropertyNamingStrategy
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.transaction.annotation.EnableTransactionManagement

@Configuration
@EnableTransactionManagement
class BeanConfig {

    @Bean
    fun jacksonObjectMapper() = ObjectMapper().setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE)

}
```

После этого убираем аннотации __@JsonProperty__ из класса __Product__ и проверяем, что названия полей браузере не изменились.

```kotlin
import java.util.Date

class Product(title: String,
              description: String,
              categoryName: String,
              creationDate: Date) {

    val title = title

    val description = description

    val categoryName = categoryName

    val creationDate = creationDate

}
```

5. Далее IDEA нам посказывает, что можно декларировать переменные напрямую в конструкторе. 
Это дествительно можно сделать, и при передаче объекта в качестве ответа никаких проблем не возникнет.
Если же использовать этот объект в качестве body, но Jackson не сможет определить, какие поля json-a использовать для конструктора.
Есть два простых решения. 

_Первый_ - использовать в конструкторе аннотации @JsonProperty. Его мы использовать не будем, но выглфдть класс будет примерно так:  

```kotlin
class Product(
	@JsonProperty("title") val title: String,
        @JsonProperty("description") val description: String,
	...
)
```
			  
_Второй_ - использовать модуль для Kotlin (https://github.com/FasterXML/jackson-module-kotlin)
* добавляем модуль в список зависимостей в build.gradle

```groovy
dependencies {
...
    compile "com.fasterxml.jackson.module:jackson-module-kotlin:2.9.0"
}
```

* регистрируем модуль в настройках jacksonObjectMapper bean-а 

```kotlin
 @Bean
fun jacksonObjectMapper() = ObjectMapper()
		.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE)
                .registerModule(KotlinModule())
```
					
* декларируем переменные непосредственно в конструкторе

```kotlin
import java.util.Date

class Product(
	val title: String,
        val description: String,
        val categoryName: String,
        val creationDate: Date
)
```
			  
6. Исправляем формат даты.
Если необходимо изменить формат даты для всего проекта, то можно установить его в настройках bean-а.

* создаем пакет __util__ и добавляем в него файл __CommonUtils__. В этот файл помещаем переменную, содержащую __SimpleDateFormat__

```kotlin
package utils

import java.text.SimpleDateFormat
import java.util.TimeZone

val dateFormatter = getFormatterWithGMTZone("yyyy-MM-dd'T'HH:mm:ss.SSS")

private fun getFormatterWithGMTZone(pattern: String) = SimpleDateFormat(pattern).apply { timeZone = TimeZone.getTimeZone("GMT") }
```

* добавляем этот формат в настройки mapper-а

```kotlin
@Configuration
@EnableTransactionManagement
class BeanConfig {

    @Bean
    fun jacksonObjectMapper() = ObjectMapper().setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE)
                    .registerModule(KotlinModule())
                    .setDateFormat(dateFormatter)

}
```

* Проверяем формат даты в ответе

![check](Pictures/dto3.PNG?raw=true)

7. Обновляем формат ответа. 

* Добавляем базовый класс для ответа, ошибки и enum для списка ошибок:

```kotlin
enum class ApiError(val code: Int, val description: String) {

    INVALID_PARAMETERS(1, "Неверные параметры запроса.")

}
```

```kotlin
class BaseException(val apiError: ApiError,
                    description: String?
) : RuntimeException("${apiError.description}${description?.let { " $it" }.orEmpty()}") {

    constructor(apiError: ApiError) : this(apiError, null)

}
```

```kotlin
class BaseResponse<T>(
        val result: T?,
        val errorCode: Int,
        val errorMessage: String?
) {

    constructor(exception: Exception) : this(null, (exception as? BaseException)?.apiError?.code ?: -1, exception.message)

    constructor(result: T) : this(result, 0, null)

}
```


* Все классы контроллеров будем наследовать от базового класса. В него же добавим функцию __ok__ для возвращения ответа.

```kotlin
abstract class BaseExceptionHandlingController {

    @ExceptionHandler(BaseException::class)
    @ResponseStatus(value = HttpStatus.OK)
    fun handleException(exception: BaseException) = BaseResponse<Any>(exception)

    @ExceptionHandler(Exception::class)
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    fun handleException(exception: Exception) = BaseResponse<Any>(Exception(HttpStatus.INTERNAL_SERVER_ERROR.name)) 

    fun <T> ok(value: T) = ResponseEntity.ok(BaseResponse(value))

}
```

До релиза __Exception(HttpStatus.INTERNAL_SERVER_ERROR.name)__ можно заменить на __BaseResponse<Any>(BaseException(ApiError.INVALID_PARAMETERS, exception.message))__, чтобы легче было отлаживать.

* Обновляем ProductController :

```kotlin
@RestController
@RequestMapping("product")
class ProductController : BaseExceptionHandlingController() {

    @GetMapping("info")
    fun info(): ResponseEntity<BaseResponse<Product>> {
        val product = Product("Choco pie", "Choco pie made by Orion", "candy", Date())
        return ok(product)
    }

}
```

* Проверяем результат в браузере

![check](Pictures/dto4.PNG?raw=true)
