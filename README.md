### **NetWatchdog**
```md
# NetWatchdog - Internet Connection Monitor

NetWatchdog is a lightweight tool to **monitor internet stability** by logging:
- **Internet connection status** (`UP` or `DOWN`)
- **Ping values** to measure network response time
- **Download & upload speeds** over time

This helps **diagnose network issues** and **gather proof** for reporting problems to your ISP.

---

## Setup Instructions

### ** 1️. Clone the Repository**
```bash
git clone https://github.com/yourusername/NetWatchdog.git
cd NetWatchdog
```

### ** 2️. Create & Activate a Virtual Environment**
First, install `python3-venv` (if not already installed):
```bash
sudo apt update && sudo apt install python3-venv -y
```

Now, create and activate the virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate  # Linux/macOS
```
(For Windows: `venv\Scripts\activate`)

### ** 3️. Install Dependencies**
```bash
pip install -r requirements.txt
```
This installs:
- `speedtest-cli` → for measuring internet speed.

---

## ⚙️ Running the Scripts

### ** 1️. Start Monitoring Internet Connection**
This script logs **whether the internet is UP or DOWN** and saves the results in `internet_status.log`.
```bash
nohup ./internet_monitor.sh > /dev/null 2>&1 &
```

### ** 2️. Start Logging Internet Speed**
This script logs **ping, download, and upload speeds** every 3 minutes and saves the results in `internet_speed.log`.

#### **Ensure it runs inside the virtual environment**
```bash
nohup ./speedtest_log.sh > /dev/null 2>&1 &
```

---

## Viewing Logs

### **Check Internet Status Logs**
```bash
tail -f internet_status.log
```
**Example Output:**
```
2025-02-26 02:10:09, UP, 41.7
2025-02-26 02:10:19, UP, 43.2
2025-02-26 02:10:29, DOWN, 0
```

### **Check Internet Speed Logs**
```bash
tail -f internet_speed.log
```
**Example Output:**
```
2025-02-26 02:10:09, 5.9, 101.04, 11.50
2025-02-26 02:13:09, 6.2, 98.4, 10.9
2025-02-26 02:16:09, 5.7, 99.2, 11.1
```

---

## Stopping the Scripts
```bash
pkill -f internet_monitor.sh
pkill -f speedtest_log.sh
```

---

## Restarting Everything
```bash
pkill -f internet_monitor.sh
pkill -f speedtest_log.sh
rm -f internet_status.log internet_speed.log
nohup ./internet_monitor.sh > /dev/null 2>&1 &
nohup ./speedtest_log.sh > /dev/null 2>&1 &
```

---

## Troubleshooting

### **Speed Test Logging "DOWN, 0, 0" Constantly?**
1. Check if `speedtest-cli` works:
   ```bash
   speedtest-cli --simple
   ```
   If it fails, reinstall it:
   ```bash
   pip install --upgrade speedtest-cli
   ```

2. Check the debug log for issues:
   ```bash
   tail -f speedtest_debug.log
   ```

---

## Automate Monitoring with Cron
To **run these scripts automatically** at system startup, add them to your crontab:
```bash
crontab -e
```
Then add:
```
@reboot cd /path/to/NetWatchdog && nohup ./internet_monitor.sh > /dev/null 2>&1 &
@reboot cd /path/to/NetWatchdog && nohup ./speedtest_log.sh > /dev/null 2>&1 &
```

---

## Contributing
Feel free to submit **pull requests, feature requests, or bug reports**! 🚀

---

## ⚖️ License
This project is licensed under the **MIT License**.