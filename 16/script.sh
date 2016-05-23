#!/bin/bash

exchange()
{
	local temp=${Regions[$1]}
	Regions[$1]=${Regions[$2]}
	Regions[$2]=$temp

	return
}

Regions=(Odessa Dnipropetrovsk Chernihiv Kharkiv Zhytomyr Poltava Kherson\
Kiev Zaporizhia Luhansk Donetsk Vinnytsia Mykolaiv Kirovohrad Sumy Lviv\
Cherkasy Khmelnytskyi Volyn Rivne Ivano-Frankivsk Ternopil Zakarpattia\
Chernivtsi
)

echo "0: ${Regions[*]}"

number_of_elements=${#Regions[@]}
let "comparisons = $number_of_elements - 1"

count=1

while [ "$comparisons" -gt 0 ]
do

    index=0

    while [ "$index" -lt "$comparisons" ]
    do
        if [[ ${Regions[$index]} > ${Regions[`expr $index + 1`]} ]]
        then
            exchange $index `expr $index + 1`
        fi

        let "index += 1"
    done 


    let "comparisons -= 1"

    echo "$count: ${Regions[@]}"

    let "count += 1"

done

exit 0