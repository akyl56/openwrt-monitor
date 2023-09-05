#!/bin/sh

# 电池日志文件
battery_log="/out-battery.txt"  

# logread日志文件
logread_log="/out-logread.txt"   

# 在子shell中后台运行logread,输出重定向到logread_log
 (
   logread -f >> "$logread_log" 2>&1 &  
 )

# 循环记录电池信息
while true; do

  # 获取当前日期时间
  datetime=$(date "+%Y-%m-%d %H:%M:%S")

  # 读取电池电量
  battery_ChargePercentage=$(cat /run/state/namespaces/Battery/ChargePercentage)   
  battery_Voltage=$(cat /run/state/namespaces/Battery/Voltage)  
  battery_OnBattery=$(cat /run/state/namespaces/Battery/OnBattery) 
  uptime_cpufree=$(cat /proc/uptime) 
  temperature=$(cat /sys/class/thermal/thermal_zone0/temp)
   
  # 输出到终�?  
  echo "$datetime   ChargePercentage: $battery_ChargePercentage%   Voltage: $battery_Voltage   OnBattery: $battery_OnBattery   UpTime_CpuFree: $uptime_cpufree   CPU_Temperature: $temperature"

  # 输出到电池日志文�?   
   echo "$datetime   ChargePercentage: $battery_ChargePercentage%   Voltage: $battery_Voltage   OnBattery: $battery_OnBattery   UpTime_CpuFree: $uptime_cpufree   CPU_Temperature: $temperature" >> "$battery_log"

  # 睡眠60�?  
  sleep 60

done