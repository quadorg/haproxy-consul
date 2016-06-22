#!/bin/bash
set -e
echo "Starting HA Proxy"
/sbin/iptables -I INPUT -p tcp --dport 80 --syn -j DROP
/sbin/iptables -I INPUT -p tcp --dport 443 --syn -j DROP
/sbin/iptables -I INPUT -p tcp --dport 1936 --syn -j DROP
sleep 2
/usr/sbin/haproxy -p /var/run/haproxy.pid -D -f /haproxy/haproxy.cfg -sf $(cat /var/run/haproxy.pid)
/sbin/iptables -D INPUT -p tcp --dport 80 --syn -j DROP
/sbin/iptables -D INPUT -p tcp --dport 443 --syn -j DROP
/sbin/iptables -D INPUT -p tcp --dport 1936 --syn -j DROP
echo "HA Proxy now running"
exit 0
