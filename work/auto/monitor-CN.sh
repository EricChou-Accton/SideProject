#!/usr/bin/expect

set timeout 300
set CN_ip [lindex $argv 0]
set CN_user [lindex $argv 1]
set CN_pw [lindex $argv 2]
set file_dir "/tmp/"

spawn ssh -o StrictHostKeyChecking=no $CN_user@$CN_ip

expect "password:"
send "$CN_pw\n"

expect ":~#"
send "tg2 stats driver-if |grep -E 'txPower|srssi|mcs|perE6|rxPerE6'\n"
sleep 3
send "\03"
expect ":~#"
send "\n"
send "tg2 stats driver-if |grep -i beam\n"
expect "codebookBeam"
sleep 2
send "\03"

expect ":~#"
send "exit\n"
expect eof
exit 0
