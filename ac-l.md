# current session only
sudo sh -c 'sysctl -w abi.vsyscall32=0'
# reboot persistency 
sudo sh -c 'echo "abi.vsyscall32 = 0" >> /etc/sysctl.conf && sysctl -p'
