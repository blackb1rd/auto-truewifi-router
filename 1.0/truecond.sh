#!/bin/sh

utime=`echo ICT-7 > /etc/TZ`

sleep 10

trueusername='username'
truepassword='password'
trueyourmac='AA-BB-CC-00-11-22'
wlanip='xxx.xxx.xxx.xxx'
nasip='xxx.xxx.xxx.xxx'
VLAN='eth/x/x/x:xxx.xxx'

logout=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --insecure "https://portal.trueinternet.co.th/wifiauthen/logout_result.php"`
parameter=$(curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --location --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --insecure 'https://portal.trueinternet.co.th/wifiauthen/internet.co.th/wifiauthen/login.do?wlanuserip=$wlanip&nasip=$nasip&wlanparameter=$trueyourma c &VLAN=$VLAN' | grep param= | sed -e 's/.*param=//' -e 's/\".*>//)
login=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --location --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt  --insecure "https://portal.trueinternet.co.th/wifiauthen/web/wifi-login.php?param=$parameter"`
log_in=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --referer "https://portal.trueinternet.co.th/wifiauthen/login.php" --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --data "username=$trueusername&password=$truepassword&param=$parameter" --insecure "https://portal.trueinternet.co.th/wifiauthen/login_result.php"`

sleep 5

while [ 1 ]; do

up=`curl www.google.com | grep ' WISPAccessGatewayParam'` #check web external site
if [ -z "$up" ]; then
ip=`wget -O /tmp/ip.txt http://automation.whatismyip.com/n09230945.asp`
extip=`cat /tmp/ip.txt`

# synctime to avoid crontab time missing
sync=`ntpdate ntp.ubuntu.com`

sleep 10500 # delay for 175 minute which is default truewifi disconnect every 180 minute

logout=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --insecure "https://portal.trueinternet.co.th/wifiauthen/logout_result.php"`
logouter=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --connect-timeout 5 --location --insecure --data "param=$parameter" 'https://portal.trueinternet.co.th/wifiauthen/web/wifi-logout-success.php?param=$parameter'`
parameter=$(curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --location --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --insecure 'https://portal.trueinternet.co.th/wifiauthen/internet.co.th/wifiauthen/login.do?wlanuserip=$wlanip&nasip=$nasip&wlanparameter=$trueyourmac&VLAN=$VLAN' | grep param= | sed -e 's/.*param=//' -e 's/\".*>//)
login=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --location --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt  --insecure "https://portal.trueinternet.co.th/wifiauthen/web/wifi-login.php?param=$parameter"`
log_in=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --referer "https://portal.trueinternet.co.th/wifiauthen/login.php" --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --data "username=$trueusername&password=$truepassword&param=$parameter" --insecure "https://portal.trueinternet.co.th/wifiauthen/login_result.php"`

else

logout=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --insecure "https://portal.trueinternet.co.th/wifiauthen/logout_result.php"`
logouter=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --connect-timeout 5 --location --insecure --data "param=$parameter" 'https://portal.trueinternet.co.th/wifiauthen/web/wifi-logout-success.php?param=$parameter'`
parameter=$(curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --location --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --insecure 'https://portal.trueinternet.co.th/wifiauthen/internet.co.th/wifiauthen/login.do?wlanuserip=$wlanip&nasip=$nasip&wlanparameter=$trueyourmac&VLAN=$VLAN' | grep param= | sed -e 's/.*param=//' -e 's/\".*>//)
login=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --location --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt  --insecure "https://portal.trueinternet.co.th/wifiauthen/web/wifi-login.php?param=$parameter"`
log_in=`curl --user-agent "Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0" --referer "https://portal.trueinternet.co.th/wifiauthen/login.php" --cookie /tmp/cookiejar.txt --cookie-jar /tmp/cookiejar.txt --data "username=$trueusername&password=$truepassword&param=$parameter" --insecure "https://portal.trueinternet.co.th/wifiauthen/login_result.php"`

fi

sleep 2
rm /tmp/cookiejar.txt
rm /tmp/ip.txt

done
