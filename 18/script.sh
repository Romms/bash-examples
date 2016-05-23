#!/bin/bash

ARGS=2
E_BADARGS=65

if [ $# -ne "$ARGS" ]
then
    echo "Usage: `basename $0` first-number second-number"
    exit $E_BADARGS
fi

if ! [ "$1" -eq "$1" ] 2>/dev/null || [ "$1" -lt 1 ] 
then
    echo "The first argument must be a positive number"
    exit $E_BADARGS
fi

if ! [ "$2" -eq "$2" ] 2>/dev/null || [ "$2" -lt 1 ] 
then
    echo "The second argument must be a positive number"
    exit $E_BADARGS
fi


gcd ()
{
    dividend=$1
    divisor=$2
                                 
    remainder=1   # Ініціалізуємо зміну довільним числом

    until [ "$remainder" -eq 0 ]
    do
        let "remainder = $dividend % $divisor"
        dividend=$divisor            
        divisor=$remainder
        # Повторити цикл з новими вихідними даними
    done

} # Останнім $dividend і є нод.


gcd $1 $2

echo "GCD for $1 and $2 = $dividend"

exit 0