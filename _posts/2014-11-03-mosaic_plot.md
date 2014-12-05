---
layout: post
title: Мозаичные диаграммы в ggplot2
---

Сегодня на повестке дня мозаичные диаграммы в **R** при помощи `ggplot2`. И,
да, в `ggplot2` нет их реализации "из коробки", но с должным умением и
достаточно большой кувалдой дело можно поправить.

В процессе поиска подходящей реализации (идей) мне попалось несколько вариантов
построения мозаичной диаграммы в `ggplot2`, лучшей из всех, на мой взгляд,
является реализация пользователя [Edwin][1] со stackoverflow с дополнениями из
блога [Learning R][2]. Если будете изучать способ из блога - учтите что
рекомендации несколько устарели (`ddply`, `opts`, `theme_line`) и автор забыл
упомянуть о (`library(reshape2)` и `library(plyr)`).

Нам потребуется только `ggplot2`:

```r
library(ggplot2)
```

Для примера будем использовать массив данных о бриллиантах, он идет в комплекте
с `ggplot2`:

```r
head(diamonds)
```

```
##   carat       cut color clarity depth table price    x    y    z
## 1  0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
## 2  0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
## 3  0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
## 4  0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
## 5  0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
## 6  0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
```

Мозаичную диаграмму мы будем строить через вспомогательную функцию `ggMMplot`,
которая будет принимать две дискретные переменные:

```r
ggMMplot <- function(var1, var2){
  # ggplot2 должен быть загружен
  require(ggplot2)

  # Подсчитываем диапазон значений дискретных переменных
  levVar1 <- length(levels(var1))
  levVar2 <- length(levels(var2))

  # Строим таблицу вероятностей
  jointTable <- prop.table(table(var1, var2))

  # Начинаем собирать data.frame, который будет использован для построения
  # диаграммы, для начала добавим в него сконвертированную таблицу вероятностей
  plotData <- as.data.frame(jointTable)

  # Добавляем в data.frame информацию о ширине каждого из столбцов
  plotData$marginVar1 <- prop.table(table(var1))

  # Добавляем в data.frame информацию о высоте каждой секции столбца
  plotData$var2Height <- plotData$Freq / plotData$marginVar1

  # Добавляем в data.frame информацию о положении центра каждого столбца
  plotData$var1Center <- c(0, cumsum(plotData$marginVar1)[1:levVar1 - 1]) +
    plotData$marginVar1 / 2

  # Строим диаграмму
  ggplot(plotData, aes(var1Center, var2Height)) +
    geom_bar(stat = "identity", aes(width = marginVar1, fill = var2),
             col = "black") +

    # Подписи над столбцами
    geom_text(aes(label = as.character(var1), x = var1Center,
                 y = 1.05), size = 3, color = "black") +

    # Изменяем название легенды и меняем цветовую схему
    scale_fill_brewer(name="Clarity", palette = "Set2") +

    # Черно-белая тема для окружения
    theme_bw() +

    # Убираем названия осей
    labs(x = NULL, y = NULL, fill = NULL) +

    # Сетка на фоне не нужна
    theme(panel.grid.major = element_line(colour = NA),
          panel.grid.minor = element_line(colour = NA))

  }

# Строим мозаичную диаграмму, переменные: качество огранки vs. чистота
ggMMplot(diamonds$cut, diamonds$clarity)
```

![plot of chunk unnamed-chunk-1](../images/2014-11-03-mosaic_plot/1.png)

Что почитать еще? Из всех источников, что мне попались в процессе поиска, я
могу посоветовать взглянуть на пост из [блога][3], который ведут
Christopher DeSante и David Sparks (Университет Дьюка). Если вы
хотите разместить на диаграмме больше текста - изучите подробнее пост в
[Learning R][2].

  [1]: http://stackoverflow.com/a/19258045 "Edwin's answer"
  [2]: http://learnr.wordpress.com/2009/03/29/ggplot2_marimekko_mosaic_chart/
  [3]: http://is-r.tumblr.com/post/33290921643/simple-marimekko-mosaic-plots
