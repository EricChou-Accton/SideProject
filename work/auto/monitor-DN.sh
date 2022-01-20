#!/usr/bin/expect

set file_dir "/tmp/"

set timeout 5
set DN_user [lindex $argv 0]
set DN_ip [lindex $argv 1]

spawn ssh -o StrictHostKeyChecking=no $DN_user@$DN_ip


expect ":~#"
send "tg2 stats driver-if |grep -E 'txPower|srssi|mcs|perE6|rxPerE6'\n"
sleep 5
send "\03"
expect ":~#"
sleep 2
send "\n"
send "tg2 stats driver-if --dump |grep BeamIdx\n"
expect ":~#"
send "exit\n"

expect eof
exit 0
