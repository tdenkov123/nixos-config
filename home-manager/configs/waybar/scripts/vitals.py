#!/usr/bin/env python3
import subprocess
import json
import psutil

def get_vitals():
    try:
        cpu_percent = psutil.cpu_percent(interval=1)
        
        memory = psutil.virtual_memory()
        ram_percent = memory.percent
        
        temp = 0
        try:
            temps = psutil.sensors_temperatures()
            if temps:
                for name, entries in temps.items():
                    if entries:
                        temp = entries[0].current
                        break
            else:
                with open('/sys/class/thermal/thermal_zone0/temp', 'r') as f:
                    temp = int(f.read().strip()) / 1000
        except:
            temp = 0
        
        return {
            "text": f"CPU: {int(cpu_percent)}% | RAM: {int(ram_percent)}% | TEMP: {int(temp)}°C",
            "tooltip": f"System Vitals\nCPU: {cpu_percent:.1f}%\nRAM: {ram_percent:.1f}%\nTemperature: {temp:.1f}°C",
            "class": "vitals"
        }
        
    except Exception as e:
        return {
            "text": "System info unavailable",
            "tooltip": str(e),
            "class": "error"
        }

if __name__ == "__main__":
    vitals = get_vitals()
    print(json.dumps(vitals))
