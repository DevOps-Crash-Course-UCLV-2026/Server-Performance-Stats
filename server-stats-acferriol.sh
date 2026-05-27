#!/bin/bash


#Ejecutar: ./server-stats-acferriol.sh
echo "Metricas de Sistema"

#Uso de CPU
echo "####################"
echo "# USO TOTAL DE CPU #" 
echo "####################"
cpu_line=$(top -bn1 | grep "Cpu(s)")
libre=$(echo "$cpu_line" | grep -o '[0-9.]\+ id' | awk '{print $1}')
echo "CPU libre    : ${libre}%"
echo "CPU usada    : $(awk "BEGIN {printf \"%.1f\", 100 - $libre}")%"


#Uso de Memoria
echo "########################"
echo "# USO TOTAL DE MEMORIA #"
echo "########################"
mem_line=$(free -m | grep "Mem:")
total_mem=$(echo "$mem_line" | awk '{print $2}')   
used_mem=$(echo "$mem_line" | awk '{print $3}')
free_mem=$(echo "$mem_line" | awk '{print $4}')
mem_percent=$(awk "BEGIN {printf \"%.1f\", ($used_mem / $total_mem) * 100}")
echo "Memoria total : ${total_mem} MB"
echo "Memoria usada : ${used_mem} MB"
echo "Memoria libre : ${free_mem} MB"
echo "Porcentaje de memoria usada: ${mem_percent}%"

#Uso de Disco
echo "########################"
echo "# USO TOTAL DE DISCO #"
echo "########################"
disk_line=$(df -h / | tail -1)
total_disk=$(echo "$disk_line" | awk '{print $2}')
used_disk=$(echo "$disk_line" | awk '{print $3}')
free_disk=$(echo "$disk_line" | awk '{print $4}')
disk_used_percent=$(echo "$disk_line" | awk '{print $5}' | tr -d '%')
echo "Disco total : ${total_disk}"
echo "Disco usado : ${used_disk}"
echo "Disco libre : ${free_disk}"
echo "Porcentaje de disco usado: ${disk_used_percent}%"

#Top 5 procesos por uso de CPU
echo "#################################"
echo "# TOP 5 PROCESOS POR USO DE CPU #"
echo "#################################"
process=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)
echo "$process"

#Top 5 procesos por uso de Memoria
echo "#####################################"
echo "# TOP 5 PROCESOS POR USO DE MEMORIA #"
echo "#####################################"
process=$(ps -eo pid,comm,%mem --sort=-%mem | head -n 6)
echo "$process"

#Sistema Operativo
echo "#######################"
echo "#  SISTEMA OPERATIVO  #"
echo "#######################"
distro=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
echo "Distribución: $distro"

#UpTime del Sistema y carga media
echo "######################"
echo "# UPTIME DEL SISTEMA #"
echo "######################"
uptime=$(uptime -p)
echo "Uptime: $uptime"
carga=$(uptime | awk -F'load average:' '{print $2}')
echo "Carga media  : $carga"

#Usuarios conectados
echo "#######################"
echo "# USUARIOS CONECTADOS #"
echo "#######################"
users=$(who | awk '{print $1}' | sort )
echo "Usuarios conectados: $users"

#Logins fallidos
echo "###################"
echo "# LOGINS FALLIDOS #"
echo "###################"
failed_logins=$(grep "Failed password" /var/log/auth.log | wc -l)
echo "Número de logins fallidos: $failed_logins"

