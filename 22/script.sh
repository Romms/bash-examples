#!/bin/bash
# Modification of /usr/sbin/mkdict (/usr/sbin/cracklib-forman) script.
# Original script copyright 1993, by Alec Muffett.

E_BADARGS=85

if [ ! -r "$1" ] # Потрібно принаймні один аргумент
then
    echo "Usage: $0 files-to-process"
    exit $E_BADARGS
fi

cat $* | # Вивід вказаних файлів в stdout.
tr A-Z a-z | # Перетворити в нижній регістр.
tr ' ' '\012' | # Замінюємо пропуски на символи нового рядка
tr -c '\012a-z' '\012' | # Замінюємо всі символи що не є літерами
 sort | # Сортуємо
 uniq | # Видаляємо дублікати
 grep -v '^#' | # Видаляємо рядки що починаються з #.
 grep -v '^$' # Видаляємо пусті рядки.

exit $? # Повертаємо останній результат виконання
