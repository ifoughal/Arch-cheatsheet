# list network hardware:

## list hardware path | device name | class | Description
### option 1
```bash
lshw -class network -short
```

### option 2
```bash
sudo lspci -vd ::0200   # Ethernet controllers
sudo lspci -vd ::0280   # Wireless controllers
```


## list interface details such as speed, link mode etc

```bash
ethtool <interface-name>
```

## get network devices status

```bash
nmcli device status
```

## show all interfaces with their speed:
```bash
for nic in $(ls /sys/class/net | grep -v lo); do
  echo -n "$nic: "
  ethtool $nic 2>/dev/null | grep -i "Speed"
done
```

## show all interfaces with their state & macaddress:
```bash
ip -br link
```

## delete all nmcli connections (clean slate)
```bash
nmcli -t -f NAME connection show | awk '{print "\"" $0 "\""}' | xargs -n1 nmcli connection delete
```
