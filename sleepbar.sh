#!/bin/sh

sleeptime=$1

ECHO='echo -e'
case `$ECHO` in
    -e)
        ECHO=echo;;
esac

print_bar() {
    now=$1

    column=`expr 71 \* "$now" / "$sleeptime"`
    nspace=`expr 71 - "$column"`

    bar='\r['
    set dummy
    while [ $# -le "$column" ]
    do
        bar=$bar'='
        set - "$@" dummy
    done
    bar=$bar'>'

    set dummy
    while [ $# -le "$nspace" ]
    do
        bar=$bar' '
        set - "$@" dummy
    done
    bar=$bar'] '$now's '`expr 100 \* "$now" / "$sleeptime"`'%\c'

    $ECHO "$bar"
}

i=0
while [ "$i" -le $sleeptime ]
do
    print_bar "$i"
    i=`expr "$i" + 1`
    sleep 1
done
echo
