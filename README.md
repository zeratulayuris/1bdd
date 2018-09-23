# 1BDD для OneScript
<!-- TOC -->

- [1BDD для OneScript](#1bdd-для-onescript)
    - [Командная строка запуска](#командная-строка-запуска)
    - [Формат файла фичи](#формат-файла-фичи)
        - [Пример файла фичи](#пример-файла-фичи)
    - [Формат файла шагов](#формат-файла-шагов)
        - [Пример файла шагов](#пример-файла-шагов)
    - [API фреймворка](#api-фреймворка)
        - [Стандартная библиотека](#стандартная-библиотека)

<!-- /TOC -->

[![GitHub release](https://img.shields.io/github/release/artbear/1bdd.svg)](https://github.com/artbear/1bdd/releases) [![Build Status](http://build.oscript.io/buildStatus/icon?job=oscript-library/1bdd/develop)](http://build.oscript.io/job/oscript-library/job/1bdd/job/develop/) [![Build status](https://ci.appveyor.com/api/projects/status/vbnk445352crljjn?svg=true)](https://ci.appveyor.com/project/artbear/1bdd)
[![Build Status](https://travis-ci.org/artbear/1bdd.svg?branch=develop)](https://travis-ci.org/artbear/1bdd)
[![Quality Gate](https://sonar.silverbulleters.org/api/badges/gate?key=opensource-1bdd)](https://sonar.silverbulleters.org/dashboard?id=opensource-1bdd)
[![Tech Debt](https://sonar.silverbulleters.org/api/badges/measure?key=opensource-1bdd&metric=sqale_debt_ratio)](https://sonar.silverbulleters.org/dashboard?id=opensource-1bdd)

[![Join the chat at https://gitter.im/artbear/1bdd](https://badges.gitter.im/artbear/1bdd.svg)](https://gitter.im/artbear/1bdd?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)  Здесь вы можете задавать любые вопросы разработчикам и активным участникам.

`1bdd` - инструмент для выполнения автоматизированных требований/тестов, написанных на обычном, не программном языке.

Иными словами, это консольный фреймворк, реализующий `BDD` для проекта [OneScript](https://github.com/EvilBeaver/OneScript).
Для Windows и Linux.

Идеи черпаются из проекта [Cucumber](https://cucumber.io).

Основная документация находится [в каталоге документации](./docs/readme.md)

- в т.ч. библиотека полезных стандартных шагов
- API продукта

Ниже краткая информация о возможностях продукта.

## Командная строка запуска

```cmd
oscript bdd.os <features-path> [ключи]
oscript bdd.os <команда> <параметры команды> [ключи]

Возможные команды:
	<features-path> [ключи]
	или
	exec <features-path> [ключи]
		Выполняет сценарии BDD для Gherkin-спецификаций
		Параметры:
			features-path - путь к файлам *.feature.
			Можно указывать как каталоги, так и конкретные файлы.

			-fail-fast - Немедленное завершение выполнения на первом же не пройденном сценарии

			-name <ЧастьИмениСценария> - Выполнение сценариев, в имени которого есть указанная часть
			-junit-out <путь-файла-отчета> - выводить отчет тестирования в формате JUnit.xml

	gen <features-path> [ключи]
		Создает заготовки шагов для указанных Gherkin-спецификаций
		Параметры:
			features-path - путь к файлам *.feature.
				Можно указывать как каталог, так и конкретный файл.

Возможные общие ключи:
	-require <путь каталога или путь файла> - путь к каталогу фича-файлов или к фича-файлу, содержащим библиотечные шаги.
		Если эта опция не задана, загружаются все os-файлы шагов из каталога исходной фичи и его подкаталогов.
		Если опция задана, загружаются только os-файлы шагов из каталога фича-файлов или к фича-файла, содержащих библиотечные шаги.

	-out <путь лог-файла>
	-debug <on|off> - включает режим отладки (полный лог + остаются временные файлы)
	-verbose <on|off> - включается полный лог
```

Для подсказки по конкретной команде наберите
`bdd help <команда>`.

## Формат файла фичи

Файл фичи должен иметь расширение `feature` и написан согласно синтаксису языка `Gherkin`

### Пример файла фичи

```gherkin
# language: ru

Функционал: Выполнение файловых операций
    Как Пользователь
    Я хочу иметь возможность выполнять различные файловые операции в тексте фич
    Чтобы я мог проще протестировать и автоматизировать больше действий на OneScript

Сценарий: Каталог проекта
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я устанавливаю временный каталог как рабочий каталог
    Когда Я сохраняю каталог проекта в контекст
    Тогда Я показываю каталог проекта
    И Я показываю рабочий каталог
```

или

```gherkin
# language: ru

Функционал: Использование программного контекста
	Как Разработчик
	Я Хочу чтобы шаги разных сценариев могли обмениваться данными через програмнный контекст продукта

Сценарий: Первый сценарий

  Когда Я сохранил ключ "Ключ1" и значение 10 в программном контексте
  И я получаю ключ "Ключ1" и значение 10 из программного контекста

Сценарий: Следующий сценарий

  Тогда я получаю ключ "Ключ1" и значение 10 из программного контекста
```

## Формат файла шагов

Это обычный os-скрипт, который располагает в подкаталоге `step_definitions` относительно файла фичи.

В этом файле должна быть служебная функция `ПолучитьСписокШагов`, которая возвращает массив всех шагов, заданных в этом скрипте.

Также внутри файла шагов могут располагаться специальные методы-обработчики (хуки) событий `ПередЗапускомСценария`/`ПослеЗапускаСценария`

### Пример файла шагов

```bsl
// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯСохранилКлючИЗначениеВПрограммномКонтексте");
	ВсеШаги.Добавить("ЯПолучаюКлючИЗначениеИзПрограммногоКонтекста");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт

КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт

КонецПроцедуры

//Я сохранил ключ "Ключ1" и значение 10 в программном контексте
Процедура ЯСохранилКлючИЗначениеВПрограммномКонтексте(Знач Ключ, Знач Значение) Экспорт
	БДД.СохранитьВКонтекст(Ключ, Значение);
КонецПроцедуры

//я получаю ключ "Ключ1" и значение 10 из программного контекста
Процедура ЯПолучаюКлючИЗначениеИзПрограммногоКонтекста(Знач Ключ, Знач ОжидаемоеЗначение) Экспорт
	НовоеЗначение = БДД.ПолучитьИзКонтекста(Ключ);
	Ожидаем.Что(НовоеЗначение).Равно(ОжидаемоеЗначение);
КонецПроцедуры
```

## API фреймворка

Есть несколько вариантов использования API фреймворка из кода реализации шагов.

Основная документация по шагам находится [в каталоге документации](./docs/readme.md#api-фреймворка)

### Стандартная библиотека

Стандартные библиотечные шаги, подключаемые автоматически для любой фичи, находятся в каталоге `features/lib`

- `ВыполнениеКоманд.feature` - выполнение команд системы и запуск процессов
- `ФайловыеОперации.feature` - создание файлов/каталогов, их копирование, анализ содержимого файлов

Основная документация по шагам находится [в каталоге документации](./docs/readme.md#стандартная-библиотека-шагов)
