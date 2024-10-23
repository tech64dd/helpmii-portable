echo '===== Wii Linux HelpMii Log Dump ====='
echo "Date according to Linux: $(date)"
echo
echo '==== /proc/cpuinfo start ===='
cat /proc/cpuinfo
echo '====  /proc/cpuinfo end  ===='
echo
echo 'Memory info:'
free -h
echo
echo '==== Disk Info start ===='
echo '== /proc/mounts start =='
cat /proc/mounts
echo '==  /proc/mounts end  =='
echo '== df -h start =='
df -h
echo '==  df -h end  =='
echo '====  Disk Info end  ===='
echo
echo '==== Kernel Log messages start ===='
dmesg
echo '====  Kernel Log messages end  ===='
echo
echo '==== journalctl for current boot start ===='
journalctl -b
echo '====  journalctl for current boot end  ===='

echo '==== Network Info start ===='
echo '== journalctl -bu NetworkManager start =='
journalctl -b 0 -u NetworkManager
echo '==  journalctl -bu NetworkManager end  =='
echo '== nmcli start =='
nmcli
echo '==  nmcli end  =='
echo '====  Network Info end  ===='
