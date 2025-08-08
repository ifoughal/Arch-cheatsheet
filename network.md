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

