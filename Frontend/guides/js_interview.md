## Вопросы для собеседования на JavaScript-разработчика

* [Общие вопросы](#1-Общие-вопросы)
* [ES5](#2-ES5)
* [ES6](#3-ES6)
* [ES7](#4-ES7)
* [React](#5-React)
* [JQuery](#6-JQuery)
* [DOM](#7-DOM)

## 0 Очень общие вопросы
  - Какие используешь библиотеки/фреймворки?
  - Принципы ООП
  - Какие паттерны проектирования ты знаешь и какие использовал(а)?
  - ФП
  - Функции высшего порядка

## 1 Общие вопросы
  - Основные парадигмы программирования на js. Как работает прототипно-ориентированное программирование?
  - Что такое асинхронные функции, и почему они так важны на фронтэнде?
  - Почему мы можем вызвать методы у примитивных типов?
  - Разница между == и ===
  - Что такое callback-hell

## 2 ES5

#### 2.1. Всплытие объявления (hoisting)

```js
var a = 'out';
function fn() {
  console.log(a); // ?
  var a = 'in';
}
fn();
```

### 2.2. Замыкания (closures)

```js
for (var i = 0; i < 5; i++) {
  setTimeout(() => console.log(i), 0); // ?
}
// Как сделать, чтобы числа выводились по порядку?
```

```js
function fn() {
  // ...
  return 'some info';
}
function timedFn(fn) { ... }
// Написать функцию декорирующую ф-ию fn:
// [время] Hello, [время работы]
```

Какие потенциальные проблемы в чрезмерном использовании замыканий?

### 2.3. Контекст

```js
var bar = 777;
function fn() {
  console.log(this.bar); // От чего зависит значение this, каким оно может быть?
}
fn(); // ? и что будет, если включен 'use strict';
({ bar: 666, fn: fn }).fn(); // ?
```

```js
function fn() {
  console.log(this); // От чего зависит значение this, каким оно может быть?
}
```

### 2.4. Общие вопросы
```js
function getLuckyNumber() {
  var a = b = c = 777; // Почему объявлять переменные через assigment плохо?
  return a;
}
getLuckyNumber();
// window.b и window.c теперь 777, засорили глобальное пространство
```

```js
function printme() {
  console.log('1')
  
  setTimeout(function() {
    console.log('2')
  }, 0)
    
  setTimeout(function() {
    console.log('4')
  }, 0)
  
  setTimeout(function() {
    console.log('3')
  }, 0)

  
  console.log('5')
  
  var i = 1000000;
  while(i--) {
    // do nothing
  }
  
  console.log('6')
  
  print7()
  
  console.log('8')
  
}

function print7() {
  console.log('7')
}

printme()
```

```js
function arrWithTea(arr) {
  arr.push('tea');
  return arr;
}
var x = ['coffee', 'water'];
var y = arrWithTea(x);
x // ?
y // ?
```

```js
var a = 'abc';
var b = new String('abc');
typeof a; // ?
typeof b; // ?
a === b; // ?
```
