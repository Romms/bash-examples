#!/bin/bash

ARGS=2         # Рчікується два параметра командного рядка.
E_PARAM_ERR=85 # Код помилки параметрыв.
REFYR=1600     # Рік відліку.
CENTURY=100
DIY=365
ADJ_DIY=367    # З поправкою на високосний рік
MIY=12
DIM=31
LEAPCYCLE=4
MAXRETVAL=255  # Найбільший допустимий
               #+ позитивне значення повернення з функції.

diff=          # Глобальна змінну для різниці дат.
value=         # Глобальна змінна для абсолютної величини.
day=           # Глобальна змінна для дня.
month=         # Глобальна змінна для місяця.
year=          # Глобальна змінна для року.

Param_Error () # Параметри командного рядка невірні
{
    echo "Usage: `basename $0` [M]M/[D]D/YYYY [M]M/[D]D/YYYY"
    echo " (date must be after 1/3/1600)"
    exit $E_PARAM_ERR
}

Parse_Date () # Розбір дати з параметрів командного рядка
{
    month=${1%%/**}
    dm=${1%/**} # день та місяці.
    day=${dm#*/}
    let "year = `basename $1`" # Не ім'я файлу, але працює точно так само.
}

check_date () # Перевіряємо чи дата правильна.
{
    [ "$day" -gt "$DIM" ] || [ "$month" -gt "$MIY" ] ||
    [ "$year" -lt "$REFYR" ] && Param_Error
}

strip_leading_zero () # Видалити нулі зпереду дня та місяця
{
    return ${1#0}
}

day_index () # Gauss' Formula:
{ # К-ть дні з 1 березня 1600 року до дати
  #            ^^^^^^^^^^^^^^
    day=$1
    month=$2
    year=$3

    let "month = $month - 2"
    if [ "$month" -le 0 ]
    then
        let "month += 12"
        let "year -= 1"
    fi

    let "year -= $REFYR"
    let "indexyr = $year / $CENTURY"
    let "Days = $DIY*$year + $year/$LEAPCYCLE - $indexyr \
    + $indexyr/$LEAPCYCLE + $ADJ_DIY*$month/$MIY + $day - $DIM"

    echo $Days
}

calculate_difference () # Різниця між двома датами.
{
    let "diff = $1 - $2" # Global variable.
} 

abs () # Абсолютне значення
{ # Використовує глобальну зміну "value".
    if [ "$1" -lt 0 ] # Якщо від’ємне
    then #+ then
        let "value = 0 - $1" #+ змінює знак
    else #+ else
        let "value = $1" #+ залишає незмінним
    fi
}

if [ $# -ne "$ARGS" ] # Вимагаються два аргумента.
then
    Param_Error
fi

Parse_Date $1
check_date $day $month $year # Перевіряється правильність дати.
strip_leading_zero $day # Видалення нулів спереду
day=$? #+ в дні та місяці
strip_leading_zero $month
month=$?
let "date1 = `day_index $day $month $year`"

Parse_Date $2
check_date $day $month $year
strip_leading_zero $day
day=$?
strip_leading_zero $month
month=$?
date2=$(day_index $day $month $year) # Інший спосіб

calculate_difference $date1 $date2
abs $diff # Переконуємося що значення додатнє

diff=$value
echo $diff

exit 0