# App with mini apps

Приложение состоит из 4 экранов:

- Главный экран с списком мини-приложений
- Мини-приложение "Погода"
- Мини-приложение "Текущий город"
- Мини-приложение "Крестики-нолики"

## Главный экран

Главный экран содержит Collection View, состоящий из 10 элементов (P.S: элементы высотой 1/8 не доступны для пользователя)
![Главный экран](images/1.png)

Если пользователь кликнул на недоступный элемент
![Главный экран](images/2.png)

## Погода

При переходе в мини-приложение "Погода" у пользователя запрашивается разрешение на использование геопозиции
![Главный экран](images/3.png)

Затем показывается погода
![Главный экран](images/4.png)

## Текущий город

Экран данного мини-приложения выглядит следующим образом:
![Главный экран](images/5.png)

## Крестики-нолики

Экран данного мини-приложения выглядит следующим образом:
![Главный экран](images/6.png)
При нажатии на ячейку ставится Х или О в зависимости от текущего хода:
![Главный экран](images/7.png)
При победной комбинации символы окрашиваются в красный и выводится сообщение о победе
![Главный экран](images/8.png)
