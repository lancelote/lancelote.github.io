<!--
.. title: Перевод книги "Intermediate Python"
.. slug: intermediate-python
.. date: 2016-02-18 00:00:00 UTC+03:00
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text
-->

Не так давно я закончил перевод небольшой книги от разработчика из
Пакистана - [Yasoob Khalid](https://twitter.com/yasoobkhalid) -
"[Intermediate Python](https://github.com/lancelote/interpy-ru)". Не уверен как
лучше перевести *Intermediate* в данном контексте, но смысл в том что книга для
уже освоивших базовый Python программистов. Её основная идея дать читателю краткий обзор
нюансов языка, которые остаются за кадром базовых курсов/книг/руководств, ведь в
Python при всей его интуитивности и простоте есть немало сложных, специфических,
да и просто традиционных решений, как впрочем и в любом другом языке.

## О книге

Книга представляет сборник небольших несвязанных глав, каждая из которых описывает
определенный "нюанс" языка. Главы не претендуют на полноценное описание вопроса,
а скорее просто дают читателю общее представление и пути для дальнейшего исследования.
Думаю всем начинающим, а может быть и опытным питонистам будет интересно.
Ниже приведено содержание с ссылками на главы, чтобы проще было сориентироваться
в затронутых тематиках.

## Содержание

- Средства разработки
  - [Виртуальное окружение](https://lancelote.gitbooks.io/intermediate-python/content/book/virtual_environment.html)
  - [Отладка](https://lancelote.gitbooks.io/intermediate-python/content/book/debugging.html)
  - [Анализ объекта](https://lancelote.gitbooks.io/intermediate-python/content/book/object_introspection.html)
- Синтаксис
  - [Исключения](https://lancelote.gitbooks.io/intermediate-python/content/book/exceptions.html)
  - [for - else](https://lancelote.gitbooks.io/intermediate-python/content/book/for_-_else.html)
  - [Тернарные операторы](https://lancelote.gitbooks.io/intermediate-python/content/book/ternary_operators.html)
  - [global и return](https://lancelote.gitbooks.io/intermediate-python/content/book/global_&_return.html)
  - [Функция open](https://lancelote.gitbooks.io/intermediate-python/content/book/open_function.html)
  - [\*args и \*\*kwargs](https://lancelote.gitbooks.io/intermediate-python/content/book/args_and_kwargs.html)
  - [Менеджеры контекста](https://lancelote.gitbooks.io/intermediate-python/content/book/context_managers.html)
- Функциональное программирование
  - [enumerate](https://lancelote.gitbooks.io/intermediate-python/content/book/enumerate.html)
  - [Анонимные функции](https://lancelote.gitbooks.io/intermediate-python/content/book/lambdas.html)
  - [Структура данных set](https://lancelote.gitbooks.io/intermediate-python/content/book/set_-_data_structure.html)
  - [map и filter](https://lancelote.gitbooks.io/intermediate-python/content/book/map_filter.html)
  - [Абстракция списков](https://lancelote.gitbooks.io/intermediate-python/content/book/comprehensions.html)
- Структуры данных
  - [Генераторы](https://lancelote.gitbooks.io/intermediate-python/content/book/generators.html)
  - [Корутины](https://lancelote.gitbooks.io/intermediate-python/content/book/coroutines.html)
- Типы данных
  - [collections](https://lancelote.gitbooks.io/intermediate-python/content/book/collections.html)
  - [Изменяемость](https://lancelote.gitbooks.io/intermediate-python/content/book/mutation.html)
  - [Магия \_\_slots\_\_](https://lancelote.gitbooks.io/intermediate-python/content/book/__slots__magic.html)
- Декораторы
  - [Что такое декоратор?](https://lancelote.gitbooks.io/intermediate-python/content/book/decorators.html)
  - [Кэширование функций](https://lancelote.gitbooks.io/intermediate-python/content/book/function_caching.html)
- Разное
  - [Однострочники](https://lancelote.gitbooks.io/intermediate-python/content/book/one_liners.html)
  - [Python C расширения](https://lancelote.gitbooks.io/intermediate-python/content/book/python_c_extension.html)
  - [Разработка под Python 2+3](https://lancelote.gitbooks.io/intermediate-python/content/book/targeting_python_2_3.html)

*Разбивка на части условна*

## Ссылки

Книга:

 - [Онлайн версия на gitbook][2]
 - [Скачать с gitbook (pdf, mobi, epub)][4]
 - [Скачать с github (pdf, mobi, epub)][3]

Репозитории:

 - [Репозиторий перевода][1]
 - [Репозиторий оригинала (ENG)][5]

Фидбек:

 - [Отзывы/пожелания/баги][6]
 - [Pull requests][7]

## Помощь проекту

Если вы хотите отблагодарить автора книги за работу, то отличным вариантом будет
купить специальную версию его книги на [Gumroad](https://gum.co/intermediate_python).

И оригинал и перевод с удовольствием принимают [сообщения об ошибках][6] и
[pull request'ы][7], в том числе новые главы, исправление или изменение старых и т.п.

## Другие подобные ресурсы "второго шага"

 - [Python: основы и применение][8] - курс от Stepic.org, не пугайтесь названия, он
 хоть и простой, но затронуты интересные темы, которые часто опускаются (например,
 Method Resolution Order), плюс немного интересной практики
 - [Effective Python - Brett Slatkin][9] - книга от инженера Google, представляет
 собой 49 "мантр" написание качественного Python кода, оценки на Amazon говорят
 сами за себя
 - [PyTricks](https://github.com/brennerm/PyTricks) - репозиторий с примерами
 различных темных и не очень уголков языка, представляет собой code snippets
 - ...

 [1]: https://github.com/lancelote/interpy-ru
 [2]: https://lancelote.gitbooks.io/intermediate-python/content/
 [3]: https://github.com/lancelote/interpy-ru/releases/tag/v1.0.0
 [4]: https://www.gitbook.com/book/lancelote/intermediate-python/details
 [5]: https://github.com/yasoob/intermediatePython
 [6]: https://github.com/lancelote/interpy-ru/issues/new
 [7]: https://github.com/lancelote/interpy-ru/pull/new/master
 [8]: https://stepic.org/course/Python-%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D1%8B-%D0%B8-%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5-512
 [9]: https://www.amazon.com/Effective-Python-Specific-Software-Development/dp/0134034287
