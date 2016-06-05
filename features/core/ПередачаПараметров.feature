# language: ru

Функционал: Пустой функционал
	# Как Разработчик
	# Я Хочу чтобы файл фичи успешно прочитался

Сценарий: Использование параметров Число

	Когда я передаю параметр 5
	Тогда я получаю параметр с типом "Число"

Сценарий: Использование параметров Дата с годом из 4-х цифр
	Когда я передаю параметр 11.02.2010
	Тогда я получаю параметр с типом "Дата"

Сценарий: Использование параметров Дата с годом из 2-х цифр
	Когда я передаю параметр 11.02.10
	Тогда я получаю параметр с типом "Дата"

Сценарий: Использование параметров Строка с кавычками внутри апострофов
		Когда я передаю параметр 'Начало "ВнутриКавычек" Конец'
		Тогда я получаю параметр с типом "Строка"

Сценарий: Использование знака минуса в тексте и в числах
		Когда я передаю параметр -5
		Тогда я использую строку-в-которой-есть-минус

Сценарий: Использование параметров ЧислоВнутриСтроки

	Когда я передаю параметр число2
	Тогда я получаю параметр с типом "Строка"

Сценарий: Использование многострочных строк

	Когда я передаю параметр
   	"""
   		первая строка
   		вторая строка
   	"""
	Тогда я получаю параметр с типом "Строка"
	И количество строк у параметра равно 2
	И 1 строка у параметра равна "первая строка"
	И 2 строка у параметра равна "вторая строка"

Сценарий: Использование параметров разных типов в одном шаге

	Когда я передаю два параметра разных типов 1 и "Строка1"
	Тогда я в первом параметре получаю значение 1
	И я в втором параметре получаю значение "Строка1"
	И я в первом параметре получаю значение с типом "Число"
	И я в втором параметре получаю значение с типом "Строка"
