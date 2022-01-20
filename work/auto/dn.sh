#!/bin/sh
DN_ip="172.19.99.99"
DN18_ip="192.168.1.20"
DN_user="root"

nn=1
ping_unm=10
ping_cont=1
loop_unm=2
while [ $nn -gt 0 ]; do
        if [ "$nn" -ge "$loop_unm" ]; then
                DN=$DN_ip
        else
                DN=$DN18_ip
        fi
        File_Day=$(date +"%m%d")-$DN.txt

        ping_test=`ping $DN -c 1 2>/dev/null`
        chk_ping_test=`echo $ping_test|grep "100% packet loss"`
        echo " "  >> $File_Day
        echo " "  >> $File_Day
        [ -z "$chk_ping_test" ] || {
                echo "**** ping $DN loss $ping_cout ****"  >> $File_Day
                echo "**** ping $DN loss $ping_cout ****"
                if [ "$ping_cont" -ge "$ping_unm" ]; then
                        echo "**** Ping Device over $ping_unm ****" >> $File_Day
                        echo "**** Ping Device over $ping_unmF ****"
                        exit
                fi
                ping_cont=$(($ping_cont + 1))
                sleep 2
                continue
        }
        echo "**** ping $DN PASS ****" >> $File_Day
        echo "**** ping $DN PASS ****"
        sleep 2
        TODAY=$(date +"%y-%m-%d %H:%M:%S")
        echo $TODAY >> $File_Day
        echo "==================DN Start=====================" >> $File_Day

        #./monitor-DN.sh $DN_user $DN
        ./Test-DNtoDN/monitor-DN.sh $DN_user $DN  >> $File_Day
        TODAY=$(date +"%y-%m-%d %H:%M:%S")
        echo $TODAY >> $File_Day
        echo "==================DN End=======================" >> $File_Day
        if [ "$nn" -ge "$loop_unm" ]; then
                echo "Test End - DN * $nn"
                exit
        fi
        nn=$(($nn + 1))
done
