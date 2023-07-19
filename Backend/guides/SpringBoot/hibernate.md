### Hibernate

В качестве упражнения создадим базу с двумя таблицами и подключимся к ней.

Таблица __categories__ содержит список категорий товаров и таблица __items__ содержит товары, каждый из которых относится к определенной категории.

1. Для подключения Hibernate в файле __build.gradle__ добавляем __spring-boot-starter-data-jpa__ в список зависимостей

```groovy
dependencies {
	...
    	compile 'org.springframework.boot:spring-boot-starter-data-jpa'
}
```

2. Создаем package __model__

3. Создаем классы для описания таблиц базы данных: categories и items.

```kotlin
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.Index
import javax.persistence.Table

@Entity
@Table(name = "categories",
        indexes = arrayOf(
                Index(columnList = "id"),
                Index(columnList = "deleted")
        )
)
class Category {

    @Id
    @Column(name = "id", unique = true)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long? = null

    @Column(name = "deleted", nullable = false)
    var deleted: Boolean = false

    @Column(name = "name", nullable = false)
    lateinit var name: String

}
```

```kotlin
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.Index
import javax.persistence.Table

@Entity
@Table(name = "items",
        indexes = arrayOf(
                Index(columnList = "id"),
                Index(columnList = "deleted")
        )
)
class Items {

    @Id
    @Column(name = "id", unique = true)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long? = null

    @Column(name = "deleted", nullable = false)
    var deleted: Boolean = false

    @Column(name = "name", nullable = false)
    lateinit var name: String

    @Column(name = "description", nullable = true)
    var description: String? = null

}
```

4. Создаем _many-to-one_ связь между таблицами.
Для этого в класс items добавляем поле, содержащее ссылку на категорию товара, используя аннотацию __@ManyToOne__

```kotlin
class Items {

...

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false)
    lateinit var parentCategory: Category
    
}
```

А в класс categories добавляем поле, содержащее список элементов

```kotlin
class Category {

...

    @OneToMany(mappedBy = "parentCategory", cascade = arrayOf(CascadeType.ALL), fetch = FetchType.LAZY)
    lateinit var itemsList: List<Items>

}
```

__mappedBy__ - обязательно указываем название поля в классе Items (_parentCategory_), а не название поля в таблице.

5. Настраиваем подключение к бае данных.
Для примера возьмем базу данных potgresql.

* Устанавливаем potgresql
* Создаем базу с именем __test__
* Указываем настройки подключения к базе в файле __application.properties__

```
spring.datasource.url=jdbc:postgresql://localhost:5432/test?serverTimezone=UTC
spring.datasource.username= #enter username
spring.datasource.password= #enter password

spring.jpa.show-sql=true
spring.datasource.validationQuery=SELECT 1 # used for ddl-auto = validate
spring.jpa.hibernate.ddl-auto=none
spring.jpa.hibernate.naming-strategy=org.hibernate.cfg.ImprovedNamingStrategy
spring.jpa.hibernate.use-new-id-generator-mappings=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect #data types will be created based on selected dialect
spring.jpa.properties.hibernate.current_session_context_class=org.springframework.orm.hibernate4.SpringSessionContext
```

Отдельно стоит отметить __spring.jpa.hibernate.ddl-auto__. Она может принимать несколько значений, см (https://docs.jboss.org/hibernate/orm/5.2/userguide/html_single/Hibernate_User_Guide.html#configurations-hbmddl)

Если требуется создать базу на основе описанных выше моделей, то можно использовать __create__ или __create-drop__.  В случае наличия маппингов (_@ManyToOne_, _@OneToOne_ или _@OneToMany_) нет гарантии, что база будет создана правильно, поэтому лучше создать физическую базу и потом подключаться к ней, используя __update__, __none__ или __validate__.

Если база все таки будет создана используя hibernate, то после первого запуска, значение __ddl_auto__ можно поменять, чтобы не пересоздавать базу каждый раз. Поменять можно на __update__ или __none__. Несмотря на то, что сам hibernate и создал базу, при запуске с параметром __validate__, появится ошибка о несовпадении типов данных. Диалект __org.hibernate.dialect.PostgreSQLDialect__, например, создает многие поля с типом numeric, валидатору это не нравится.


* добавляем класс коннектора в зависимости в файле __build.gradle__

```groovy
dependencies {
	...
    	compile 'org.postgresql:postgresql:42.1.4'
}
```

* Для доступа к классам используем __DAO (Data Access Object)__. Создаем пакет __dao__ и в нем класс __ItemsDao__

```kotlin
import org.hibernate.criterion.Restrictions
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component
import ru.touchin.test.dto.Product
import ru.touchin.test.models.Category
import ru.touchin.test.models.Items
import ru.touchin.test.utils.cast
import ru.touchin.test.utils.withEntityManagerTransaction
import ru.touchin.test.utils.withSessionTransaction
import javax.persistence.EntityManagerFactory

@Component
class ItemsDao {

    @Autowired
    lateinit var entityManagerFactory: EntityManagerFactory

    fun create(product: Product) = entityManagerFactory.withSessionTransaction { session ->
        val category = Category()
        with(category) {
            deleted = false
            name = product.categoryName
        }
        session.persist(category)

        val item = Items()
        with(item) {
            name = product.title
            deleted = false
            description = product.description
            parentCategory = category
        }
        session.persist(item)
    }

    fun getAllItemsWithTitle(itemTitle: String): List<Items> = entityManagerFactory.withSession { session ->
        session.createCriteria(Items::class.java)
                .add(Restrictions.like("name", itemTitle))
                .list()
                .cast()
    }

    fun deleteItem(item: Items) = entityManagerFactory.withEntityManagerTransaction { entityManager ->
        entityManager.detach(item)
        item.deleted = true
        entityManager.persist(item)
    }

}
```

__DaoUtils__
```kotlin

package ru.touchin.test.utils

import org.hibernate.Session
import ru.touchin.test.dto.exceptions.ShouldNotHappenException
import javax.persistence.EntityManager
import javax.persistence.EntityManagerFactory

fun EntityManager.getSession() = this.unwrap(Session::class.java)

fun <T> EntityManagerFactory.withSessionTransaction(transactionBody: (Session) -> T): T =
        this.withSession { session ->
            val transaction = session.beginTransaction()
            try {
                val result = transactionBody(session)
                transaction.commit()
                result
            } catch (exception: Exception) {
                transaction.rollback()
                throw exception
            }
        }

fun <T> EntityManagerFactory.withSession(body: (Session) -> T): T {
    val session = createEntityManager().getSession()
    try {
        return body(session)
    } finally {
        session.disconnect()
        session.close()
    }
}

fun <T> EntityManagerFactory.withEntityManager(body: (EntityManager) -> T): T {
    val entityManager = createEntityManager()
    try {
        return body(entityManager)
    } finally {
        entityManager.close()
    }
}

fun <T> EntityManagerFactory.withEntityManagerTransaction(transactionBody: (EntityManager) -> T): T =
        this.withEntityManager { entityManager ->
            val transaction = entityManager.transaction
            transaction.begin()
            val result = transactionBody(entityManager)
            transaction.commit()
            result
        }

fun <T> EntityManagerFactory.withEntityManagerSessionTransaction(transactionBody: (EntityManager, Session) -> T): T =
        this.withEntityManager { entityManager ->
            val transaction = entityManager.transaction
            transaction.begin()
            try {
                val result = transactionBody(entityManager)
                transaction.commit()
                result
            } catch (exception: Exception) {
                transaction.rollback()
                throw exception
            }
        }

inline fun <reified T, reified R> T.cast(failureDescription: String? = null): R =
        this as? R ?: throw ShouldNotHappenException("Unable to cast ${this} to ${R::class.java}." +
                " ${failureDescription?.let { "Additional info: $it" }.orEmpty()}")

```
		
```kotlin
package ru.touchin.test.dto.exceptions

class ShouldNotHappenException(description: String) : RuntimeException(description)
```

* Напрямую обратиться к dao не получится, возникнет ошибка отсутсвия поддержки транзакций. Необходимо иметь контроллер с аннотацией __@Transactional__

Создадим интерфейс для сервиса и его имплементацию:

![new package](Pictures/hibernate1.PNG?raw=true)

```kotlin
package ru.touchin.test.services

import ru.touchin.test.dto.Product

interface ProductsService {

    fun createProduct(product: Product)

}
```

```kotlin
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import ru.touchin.test.dao.ItemsDao
import ru.touchin.test.dto.Product
import ru.touchin.test.services.ProductsService

@Service
@Transactional
class ProductServiceImpl : ProductsService {

    @Autowired
    lateinit var itemsDao: ItemsDao

    override fun createProduct(product: Product) = itemsDao.create(product)

}
```

* Теперь этот интерфейс можно применить в контроллере

```kotlin
@RestController
@RequestMapping("product")
class ProductController : BaseExceptionHandlingController() {

    @Autowired
    lateinit var productService: ProductsService

    @PostMapping("create")
    fun create(@RequestBody product: Product): ResponseEntity<BaseResponse<Boolean>> {
        productService.createProduct(product)
        return ok(true)
    }

...

}
```

* Проверяем выполнение запроса через Postman

![check](Pictures/hibernate2.PNG?raw=true)
