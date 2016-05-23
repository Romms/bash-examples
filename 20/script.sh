#!/bin/bash

CDROM=/dev/cdrom # CD ROM пристрій
OF=/tmp/cdimage.iso # Вихідний файл

BLOCKSIZE=2048
DEVICE="1,0,0"

echo; echo "Insert source CD, but do *not* mount it."
echo "Press ENTER when ready. "
read ready # Чекаємо введення, $ready не використовується.

echo;
echo "Copying the source CD to $OF."
echo "This may take a while. Please be patient."
dd if=$CDROM of=$OF bs=$BLOCKSIZE # Копіювання даних.

echo;
echo "Remove data CD."
echo "Insert blank CDR."
echo "Press ENTER when ready. "
read ready # Чекаємо введення, $ready не використовується.

echo "Copying $OF to CDR."
wodim -v -isosize dev=$DEVICE $OF

echo;
echo "Done copying $OF to CDR on device $CDROM."
echo "Do you want to erase the image file (y/n)? "
read answer

case "$answer" in
    [yY])
        rm -f $OF
        echo "$OF erased.";;

    *) 
        echo "$OF not erased.";;
esac

echo

exit 0	
