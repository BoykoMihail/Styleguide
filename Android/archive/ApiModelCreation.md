## API модель

Под API моделью будем понимать объект, приходящий с сервера в определенном формате (JSON, XML, protobuf etc.).

В идеале все API-модели должны быть автосгенерированны. Для этого создан специальный проект, [api-generator](https://github.com/TouchInstinct/api-generator). Про подключение читайте в Wiki этого проекта или в Wiki проекта Styleguide.

Модель при создании проходит следующие стадии:

1. Получаем данные с сервера или закешированные данные с диска в виде массива байт.
За этот этап отвечает сетевой уровень и соответствующие библиотеки. Мы используем [OkHttp](http://square.github.io/okhttp/) + [Retrofit](http://square.github.io/retrofit/).
2. Данные парсятся в объект.
За этот этап отвечают библиотеки парсинга конкретных типов объектов. Для JSON-объектов мы используем библиотеку [LoganSquare](https://github.com/bluelinelabs/LoganSquare).
3. Объект проходит валидацию и приводится к нормальному виду. За этот этап отвечает метод объекта validate(), вызывающийся сразу после парсинга соответствующими конвертерами.
Этот метод есть у абстрактного класса ApiModel, так что все API модели должны наследоваться от этого класса.

## Требования к модели

* Класс модели должен наследоваться от класса ApiModel. Этот класс является сериализуемым (implements Serializable). 
* В модели должны содержаться private поля, соответствующие всем данным, приходящим с сервера.
* Типы и классы объектов, содержащихся в полях, должны быть доступны для парсинга.
* Каждое поле должно иметь публичный getter и setter.
* Все getter'ы и setter'ы должны быть аннотированы NonNull/Nullable.
* Коллекции, возвращаемые в getter'ах и устанавливаемые в setter'ах должны быть не модифицируемыми.
* Модель должна иметь публичный конструктор без параметров.
* Модель должна переопределять методы equals/hashCode. Все поля должны влиять на результат этих методов.
* Модель дополнительно может переопределять метод validate(), если требуется проверить валидность значений в полях объекта.
* Модель дополнительно может иметь переопределенные методы сериализации (writeObject, readObject).
* Модель дополнительно может иметь переопределенный метод toString.

## Валидация

Этап валидации необходим, чтобы проверить, что данные пришедшие с сервера соответствуют требованиям (документации).
То есть, например, если с сервера в значении поля пришел null, а по документации такого быть не должно, то считается, что модель не валидна и использовать ее в приложении нельзя.

Для валидации используется метод validate() класса ApiModel. Если модель не валидна, то необходимо выкинуть ValidationException.

Также в этом методе необходимо провалидировать все API модели, содержащиеся в значениях полей и в коллекциях.

При валидации коллекции нужно использовать метод ApiModel.validateCollection(Collection, CollectionValidationRule). При это CollectionValidationRule - это стратегия обработки не валидных объектов в коллекции: выкидывать экспешн при любом не валидном объекте в коллекции (EXCEPTION_IF_ANY_INVALID), удалять невалидные объекты из коллекции (REMOVE_INVALID_ITEMS) или выкидывать экспешн только если все объекты в коллекции были не валидны и удалены (EXCEPTION_IF_ALL_INVALID). 

## Разметка модели для LoganSquare

Для разметки класса модели необходимо:
* Класс помечается аннотацией @JsonObject(serializeNullObjects = true).
* Класс наследуется от класса LoganSquareJsonModel.
* Все поля помечаютс аннотацией @JsonField(name = "name_of_field_from_api").
* Если есть поля с датой/временем, используется класс org.joda.time.DateTime и в методе onCreate() класса Application добавляется строчка LoganSquare.registerTypeConverter(DateTime.class, new LoganSquareJodaTimeConverter()).
* Если есть enum поля, добавляется новый класс enum и в методе onCreate() класса Application добавляется регистрация его конвертера.
* При валидации все поля, в которых не должно содержаться null должны быть проверены методом validateNotNull().
* При валидации все объекты, содержащиеся в полях модели и наследующиеся от класса ApiModel должны быть провалидированы (вызван их метод validate()).
* При валидации все коллекции, содержащиеся в полях модели и содержащие в себе объекты, наследующиеся от класса ApiModel должны быть провалидированы методом validateCollection().

Для разметки enum класса необходимо:
* Enum имплементировал интерфейс LoganSquareEnum.
* Enum содержал класс конвертера, наследующегося от класса LoganSquareEnumConverter.

### Пример разметки enum класса
```java
package myapp.logic.api.model.enums;

import android.support.annotation.NonNull;

import ru.touchin.templates.logansquare.LoganSquareEnum;
import ru.touchin.templates.logansquare.LoganSquareEnumConverter;

public enum TestApiEnum implements LoganSquareEnum {

    MALE("female"),
    FEMALE("male");

    @NonNull
    private final String valueName;

    TestApiEnum(@NonNull final String valueName) {
        this.valueName = valueName;
    }

    @NonNull
    @Override
    public String getValueName() {
        return valueName;
    }

    public static class LoganSquareConverter extends LoganSquareEnumConverter<TestApiEnum> {

        public LoganSquareConverter() {
            super(values());
        }

    }

}
```
### Пример разметки класса модели
```java
package myapp.logic.api.model;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.bluelinelabs.logansquare.annotation.JsonField;
import com.bluelinelabs.logansquare.annotation.JsonObject;

import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import myapp.logic.api.model.enums.TestApiEnum;
import ru.touchin.roboswag.core.utils.ObjectUtils;
import ru.touchin.templates.logansquare.LoganSquareJsonModel;

@JsonObject(serializeNullObjects = true)
public class TestApiModel extends LoganSquareJsonModel {

    @JsonField(name = "simple_type_field")
    private int simpleTypeField;
    @JsonField(name = "simple_object_nullable_field")
    private TestApiModel simpleObjectNullableField;
    @JsonField(name = "enum_field")
    private TestApiEnum enumField;
    @JsonField(name = "date_time_field")
    private DateTime dateTimeField;
    @JsonField(name = "list_field")
    private List<Integer> listField;
    @JsonField(name = "map_field")
    private Map<String, TestApiModel> mapField;

    public int getSimpleTypeField() {
        return simpleTypeField;
    }

    public void setSimpleTypeField(final int simpleTypeField) {
        this.simpleTypeField = simpleTypeField;
    }

    @Nullable
    public TestApiModel getSimpleObjectNullableField() {
        return simpleObjectNullableField;
    }

    public void setSimpleObjectNullableField(@Nullable final TestApiModel simpleObjectNullableField) {
        this.simpleObjectNullableField = simpleObjectNullableField;
    }

    @NonNull
    public TestApiEnum getEnumField() {
        return enumField;
    }

    public void setEnumField(@NonNull final TestApiEnum enumField) {
        this.enumField = enumField;
    }

    @NonNull
    public DateTime getDateTimeField() {
        return dateTimeField;
    }

    public void setDateTimeField(@NonNull final DateTime dateTimeField) {
        this.dateTimeField = dateTimeField;
    }

    @NonNull
    public List<Integer> getListField() {
        return Collections.unmodifiableList(listField);
    }

    public void setListField(@NonNull final List<Integer> listField) {
        this.listField = new ArrayList<>(listField);
    }

    @NonNull
    public Map<String, TestApiModel> getMapField() {
        return Collections.unmodifiableMap(mapField);
    }

    public void setMapField(@NonNull final Map<String, TestApiModel> mapField) {
        this.mapField = new HashMap<>(mapField);
    }

    @Override
    public void validate() throws ValidationException {
        super.validate();
        if (simpleObjectNullableField != null) {
            simpleObjectNullableField.validate();
        }
        validateNotNull(enumField);
        validateNotNull(dateTimeField);
        validateNotNull(listField);
        validateCollection(listField, CollectionValidationRule.EXCEPTION_IF_ANY_INVALID);
        validateNotNull(mapField);
        validateCollection(mapField.values(), CollectionValidationRule.EXCEPTION_IF_ANY_INVALID);
    }

    @Override
    public boolean equals(@Nullable final Object object) {
        if (this == object) {
            return true;
        }
        if (object == null || getClass() != object.getClass()) {
            return false;
        }

        final TestApiModel that = (TestApiModel) object;

        return simpleTypeField == that.simpleTypeField
                && ObjectUtils.equals(simpleObjectNullableField, that.simpleObjectNullableField)
                && ObjectUtils.equals(enumField, that.enumField)
                && ObjectUtils.equals(dateTimeField, that.dateTimeField)
                && ObjectUtils.isCollectionsEquals(listField, that.listField)
                && ObjectUtils.isMapsEquals(mapField, that.mapField);
    }

    @Override
    public int hashCode() {
        return ObjectUtils.hashCode(simpleTypeField, simpleObjectNullableField,
            enumField, dateTimeField, listField, mapField);
    }

}

```
