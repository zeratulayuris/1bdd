# language: ru

Функционал: Получение версии продукта
    Как Пользователь
    Я хочу иметь возможность выполнять команды
    Чтобы я мог проще автоматизировать больше действий на OneScript

# Очищаю параметры команд
Контекст:
  Дано Я очищаю параметры команды "oscript" в контексте 
  И я включаю отладку лога с именем "bdd.tests"
  И я выключаю отладку лога с именем "bdd.tests"
  И я включаю полную отладку логов пакетов OneScript
  И я выключаю полную отладку логов пакетов OneScript

Сценарий: Выполнение команды без параметров
    Когда Я выполняю команду "oscript"
    Тогда я вижу в консоли вывод "Version"
    И Код возврата равен 0

Сценарий: Выполнение команды с параметрами в одной строке
    Когда Я выполняю команду "oscript" с параметрами "-version"
    Тогда Я сообщаю вывод команды "oscript"
    И я вижу в консоли вывод "."
    И Код возврата равен 0

Сценарий: Выполнение команды с параметрами, добавляемыми раздельно
    Когда Я добавляю параметр "-version" для команды "oscript"
    И Я выполняю команду "oscript"
    Тогда я вижу в консоли вывод "."
    И Код возврата равен 0

Сценарий: Выполнение команды с параметрами, переданными в таблице
    Когда Я добавляю параметры для команды "oscript"
    | -version |
    И Я выполняю команду "oscript"
    Тогда я вижу в консоли вывод "."
    И Код возврата равен 0

Сценарий: Выполнение команды с параметрами-шаблонами
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>"
    Тогда Код возврата команды "oscript" равен 2
    И Вывод команды "oscript" не содержит "КаталогПроекта"

Сценарий: Получение вывода последней команды
    Когда Я выполняю команду "oscript"
    Тогда Я показываю вывод команды
    Тогда я вижу в консоли вывод
    """
        Usage:

        I. Script execution: oscript.exe <script_path> [script arguments..]

        II. Special mode: oscript.exe <mode> <script_path> [script arguments..]
        Mode can be one of these:
    """ 
    И я не вижу в консоли вывод "Несуществующий вывод команды"

Сценарий: Проверка вывода последней команды с помощью таблицы подстрок
    Когда Я выполняю команду "oscript"
    Тогда я вижу в консоли вывод
        | Usage |
        | Special mode: oscript.exe <mode> |
    Тогда я не вижу в консоли вывод
        | Несуществующая строка |
        | Несуществующая строка |

Сценарий: Проверка вывода команды с помощью таблицы подстрок
    Когда Я выполняю команду "oscript"
    Тогда Вывод команды "oscript" содержит
        | Usage |
        | Special mode: oscript.exe <mode> |
    Тогда Вывод команды "oscript" не содержит
        | Несуществующая строка |
        | Несуществующая строка |

Сценарий: Проверка вывода регулярными выражениями
    Когда Я выполняю команду "oscript" с параметрами "-version"
    Тогда я вижу в консоли строку подобно "(\d+\.){3}\d+"
    И я не вижу в консоли строку подобно "(\d+\.){5}"

Сценарий: Получение кода возврата последней команды
    Когда Я выполняю команду "oscript"
    Тогда Код возврата равен 0

Сценарий: Получение вывода команды, запущенной внутри шага, а не через шаги выполнения команд
    Когда Я выполняю команду "oscript"
    Тогда я вижу в консоли вывод
        | Usage |

# можно использовать нативную подстановку переменных из контекста
Сценарий: Использование переменных контекста
    Дано Я сохраняю значение 356 в переменную "ПеременнаяДляУстановки"
    Тогда Значение "ПеременнаяДляУстановки" равно 356

    Когда Я сохраняю значение "ПеременнаяДляУстановки" в переменную "ВтораяПеременнаяДляЧтения"
    Тогда Значение "ВтораяПеременнаяДляЧтения" равно 356

Сценарий: Установка переменных среды
    # можно использовать нативную подстановку переменных из контекста
    Дано Я сохраняю значение 123 в переменную "ПеременнаяДляУстановки"
    Когда Я устанавливаю переменную окружения "BDDVAR1" из переменной "ПеременнаяДляУстановки"
    Тогда я получаю переменную окружения "BDDVAR1" в переменную "ПеременнаяДляЧтения" 
    Тогда Значение "ПеременнаяДляЧтения" равно "123"

    Когда Я сохраняю значение 123 в переменную окружения "ИмяПеременнойОкружения"
    
    Тогда я получаю переменную окружения "ИмяПеременнойОкружения" в переменную "ТретьяПеременнаяДляЧтения" 
    Тогда Значение "ТретьяПеременнаяДляЧтения" равно "123"
    Тогда Значение "ТретьяПеременнаяДляЧтения" не равно "ПеременнаяДляУстановки"
    
    Когда я получаю переменную окружения "BDDVAR1" в переменную "ЧетвертаяПеременнаяДляЧтения" 
    Тогда Значение "ЧетвертаяПеременнаяДляЧтения" равно "123"
    Тогда Значение "ЧетвертаяПеременнаяДляЧтения" не равно "ПеременнаяДляУстановки"

Сценарий: Подмена команды
    Дано Я очищаю параметры команды "МоеПриложение" в контексте 
    И Я сохраняю каталог проекта в контекст
    Когда Я устанавливаю путь выполнения команды "МоеПриложение" как "КаталогПроекта/src/bdd.os"
    И Я выполняю команду "МоеПриложение"
    Тогда Вывод команды "МоеПриложение" содержит "BDD for OneScript ver."
    И Я очищаю параметры команды "МоеПриложение" в контексте 
