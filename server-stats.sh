#!/bin/bash
 echo "server performance stats"
 echo "========================"
 echo ""

 echo " OS version"
 echo lsb_release -a 2>/dev/null
 echo ""

 echo "uptime and load"
 uptime
 echo ""
 
echo "CPU Usage"
echo "🖥️ Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU Usage: " 100 - $1"%"}'
echo ""
  # Memory Usage
echo "💾 Total Memory Usage:"
free -h | awk '/^Mem:/ {
  used=$3;
  free=$4;
  total=$2;
  used_percent=($3/$2)*100;
  printf("Used: %s | Free: %s | Total: %s | Usage: %.2f%%\n", used, free, total, used_percent)
}'
echo ""

# Disk Usage
echo "🗄️ Total Disk Usage:"
df -h --total | awk '/^total/ {
  used=$3;
  avail=$4;
  total=$2;
  percent=$5;
  printf("Used: %s | Available: %s | Total: %s | Usage: %s\n", used, avail, total, percent)
}'
echo ""

# Top 5 Processes by CPU Usage
echo "🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# Top 5 Processes by Memory Usage
echo "🧠 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

