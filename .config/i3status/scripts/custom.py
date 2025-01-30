#!/usr/bin/env python3

import sys
import os
import json
import time
import psutil
import datetime
import logging
import traceback
import socket
import speedtest
import threading
from pathlib import Path
import subprocess

# Ensure log directory exists
LOG_DIR = '/tmp/i3_status_bar_logs'
os.makedirs(LOG_DIR, exist_ok=True)

# Configure logging
logging.basicConfig(
    filename=f'{LOG_DIR}/debug.log', 
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class NetworkSpeedTester:
    """Lightweight network speed testing with minimal overhead."""
    def __init__(self, test_interval=1800):
        self.download_speed = 0
        self.upload_speed = 0
        self.last_test_time = 0
        self.test_interval = test_interval
        self.testing = False
        self.test_thread = None

    def run_quick_speed_test(self):
        """Run a quick speed test in a separate thread."""
        if self.testing:
            return
        
        def test():
            try:
                st = speedtest.Speedtest()
                st.get_best_server()
                
                # Quick, less aggressive speed test
                download = st.download() / 1_000_000  # Mbps
                upload = st.upload() / 1_000_000  # Mbps
                
                # Update speeds atomically
                self.download_speed = round(download, 1)
                self.upload_speed = round(upload, 1)
                self.last_test_time = time.time()
                
                logging.info(f"Speed test complete: ↓{self.download_speed} Mbps, ↑{self.upload_speed} Mbps")
            except Exception as e:
                logging.error(f"Speed test error: {e}")
                self.download_speed = 0
                self.upload_speed = 0
            finally:
                self.testing = False

        # Start test in a thread if not already testing
        if not self.testing:
            self.testing = True
            self.test_thread = threading.Thread(target=test)
            self.test_thread.start()

    def get_network_status(self):
        """Get current network status."""
        current_time = time.time()
        
        # Trigger speed test if needed
        if (self.download_speed == 0 or 
            current_time - self.last_test_time >= self.test_interval):
            self.run_quick_speed_test()
        
        # Check current status
        if self.download_speed > 0:
            return {
                'full_text': f'🌐 ↓{self.download_speed}Mbps ↑{self.upload_speed}Mbps',
                'color': '#00FF00'  # Green
            }
        else:
            return {
                'full_text': '🌐 Testing...',
                'color': '#FFFF00'  # Yellow
            }

def safe_function_wrapper(func):
    """Wrap functions with error handling."""
    def wrapper(*args, **kwargs):
        try:
            return func(*args, **kwargs)
        except Exception as e:
            logging.error(f"Error in {func.__name__}: {e}")
            return {
                'full_text': f'{func.__name__} Error',
                'color': '#FF0000'  # Red
            }
    return wrapper

@safe_function_wrapper
def get_datetime_info():
    """Get current date and time."""
    now = datetime.datetime.now()
    return {
        'full_text': now.strftime('%a %b %d %H:%M'),
        'color': '#FFFFFF'  # White
    }

@safe_function_wrapper
def get_cpu_usage():
    """Get current CPU usage percentage."""
    cpu_percent = psutil.cpu_percent(interval=1)
    color = '#00FF00'  # Green
    
    if cpu_percent > 70:
        color = '#FF0000'  # Red
    elif cpu_percent > 50:
        color = '#FFFF00'  # Yellow
    
    return {
        'full_text': f'💻 CPU: {cpu_percent}%',
        'color': color
    }

@safe_function_wrapper
def get_memory_usage():
    """Get current memory usage."""
    memory = psutil.virtual_memory()
    used_percent = memory.percent
    color = '#00FF00'  # Green
    
    if used_percent > 80:
        color = '#FF0000'  # Red
    elif used_percent > 60:
        color = '#FFFF00'  # Yellow
    
    return {
        'full_text': f'🧠 Mem: {used_percent}%',
        'color': color
    }

@safe_function_wrapper
def get_battery_status():
    """Get battery information."""
    battery = psutil.sensors_battery()
    if battery is None:
        return None
    
    percent = battery.percent
    time_left = battery.secsleft
    
    # Determine color based on battery percentage
    color = '#00FF00'  # Green
    if percent < 20:
        color = '#FF0000'  # Red
    elif percent < 40:
        color = '#FFFF00'  # Yellow
    
    # Format time left
    if time_left == psutil.POWER_TIME_UNLIMITED:
        time_text = 'Charging'
    elif time_left == psutil.POWER_TIME_UNKNOWN:
        time_text = 'Unknown'
    else:
        hours, remainder = divmod(time_left, 3600)
        minutes, _ = divmod(remainder, 60)
        time_text = f'{hours}h {minutes}m'
    
    return {
        'full_text': f'🔋 {percent}% {time_text}',
        'color': color
    }

def main():
    # Initialize network speed tester
    network_speed_tester = NetworkSpeedTester(test_interval=300)  # Test every 30 minutes
    
    logging.info("Initializing i3 status bar")
    
    # Print header for i3bar protocol
    try:
        print('{"version":1}')
        print('[')
        print('[]')
        sys.stdout.flush()
    except Exception as e:
        logging.critical(f"Initialization error: {e}")
        sys.exit(1)

    # Simple loop to output status
    while True:
        try:
            # Create status entries
            status = [
                get_datetime_info(),
                get_cpu_usage(),
                get_memory_usage(),
                network_speed_tester.get_network_status(),
            ]
            
            # Add battery status if available
            battery_status = get_battery_status()
            if battery_status:
                status.append(battery_status)
            
            # Print the status
            print(f',{json.dumps(status)}')
            sys.stdout.flush()
            
            # Wait for 2 seconds
            time.sleep(2)
        
        except Exception as e:
            logging.error(f"Unexpected error in main loop: {e}")
            
            # Create an error status
            error_status = [{
                'full_text': f'Fatal Error: {str(e)}',
                'color': '#ff0000'
            }]
            
            try:
                print(f',{json.dumps(error_status)}')
                sys.stdout.flush()
            except:
                pass
            
            # Prevent tight error loop
            time.sleep(5)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        logging.info("Status bar stopped by user")
        print("\nStatus bar stopped.")
        sys.stdout.flush()
    except Exception as e:
        logging.critical(f"Unhandled exception: {e}")
        sys.exit(1)
