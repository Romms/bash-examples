#!/bin/bash

number=0 # Відстежує, скільки файлів перейменовані

for filename in * #Обхід всіх файлів в каталозі
do
	echo "$filename" | grep -q " " # Перевіряє чи ім’я файлу
	if [ $? -eq 0 ]                #+містить пропуски
	then
		fname=$filename                    
		n=`echo $fname | sed -e "s/ /_/g"` # Замінюємо " " на "_"

		mv "$fname" "$n" && {              # Виконуємо переіменування
			echo "The file ${fname} renamed to ${n}"
		}

		let "number += 1"
	fi
done


if [ "$number" -eq 1 ] # Для правильної граматики.
then
	echo "$number file renamed."
else
	echo "$number files renamed."
fi

exit 0