#!/bin/bash

LOG_DIR=/var/log
ROOT_UID=0     # Тільки користувач з $ UID 0 має привілеї root.
LINES=50       # Кількість збережених рядків за замовчуванням.
E_XCD=66       # Код помилки коли неможливо змінити каталог.
E_NOTROOT=67   # Ознака відсутності root-привілеїв.


if [ "$UID" -ne "$ROOT_UID" ]
then
    echo "The script requires root privileges." >&2
    exit $E_NOTROOT
fi

if [ -n "$1" ] # Перевірка наявності аргументу командного рядка.
then
    lines=$1
else
    lines=$LINES # Значення за замовчуванням, якщо число не задано в командному 
               #+рядку
fi

cd $LOG_DIR || {
    echo "You can not go to the required directory." >&2
    exit $E_XCD;
}

tail -$lines messages > mesg.temp # Зберегти останні рядки в лог-файлі.
mv mesg.temp messages

cat /dev/null > wtmp 
echo "Log files are cleared."

exit 0
# Значення, що повертається 0
#+вказує на успішне завершення роботи сценарію.