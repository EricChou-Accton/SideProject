#!/bin/sh
testlist="192.168.1.110
192.168.1.121"
target_account="root"
target_password="iamNCGTLMroot"


nn=1
while [ $nn -gt 0 ]; do		#nn>=0 true
	for dev_ip in $testlist
	do
	echo "ping $dev_ip start"
	ping_test=`ping $dev_ip -c 1 2>/dev/null`
	echo $dev_ip
	chk_ping_test=`echo $ping_test|grep "100% packet loss"`
	[ -z "$chk_ping_test" ] || {
		echo "ping $dev_ip Fail"
		if [ "$MPingO_n" = "5" ]; then
 		echo "MiniPC Ping OmniPC over 5"
		fi
		sleep 1
		continue
	}
	echo "ping $dev_ip end"
	sleep 1
	File_Day=$(date +"%m%d")-$dev_ip.txt
	./monitor-CN.sh $dev_ip $target_account $target_password >> $File_Day

#/home/accuser/Documents/Alex_Chiang/Test_Code/just_qcmbr_ustop.sh $dev_ip $target_account $target_password $nn
	done
	echo "============================================"
	echo "TEST No. #$nn, telnet to deivce..."
	echo ""
	#	./test.sh $target_ip root admin123 $nn
	sleep 1
	exit
	nn=$(($nn + 1))
done
