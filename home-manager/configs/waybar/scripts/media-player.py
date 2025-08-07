#!/usr/bin/env python3
import subprocess
import json
import sys

def get_media_info():
    try:
        status = subprocess.run(['playerctl', 'status'], 
                              capture_output=True, text=True).stdout.strip()
        
        if status == "No players found":
            return {"text": "", "tooltip": "No media playing", "class": "stopped"}
        
        artist = subprocess.run(['playerctl', 'metadata', 'artist'], 
                              capture_output=True, text=True).stdout.strip()
        title = subprocess.run(['playerctl', 'metadata', 'title'], 
                             capture_output=True, text=True).stdout.strip()
        
        if not artist or not title:
            title = subprocess.run(['playerctl', 'metadata', 'xesam:title'], 
                                 capture_output=True, text=True).stdout.strip()
            artist = subprocess.run(['playerctl', 'metadata', 'xesam:artist'], 
                                  capture_output=True, text=True).stdout.strip()
        
        icon = "" if status == "Playing" else "" if status == "Paused" else ""
        
        max_length = 30
        display_text = f"{artist} - {title}" if artist and title else title
        if len(display_text) > max_length:
            display_text = display_text[:max_length-3] + "..."
        
        return {
            "text": f"{icon} {display_text}",
            "tooltip": f"{status}: {artist} - {title}" if artist and title else title,
            "class": status.lower()
        }
        
    except Exception as e:
        return {"text": "", "tooltip": str(e), "class": "stopped"}

if __name__ == "__main__":
    info = get_media_info()
    print(json.dumps(info))
