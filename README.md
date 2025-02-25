# 📡 NetWatchdog - Internet Connection Monitor  

NetWatchdog is a lightweight tool that helps detect **internet connection drops** and **speed fluctuations** over time. It logs network failures and provides a **visual report** of your internet stability, helping you diagnose problems and report them to your **Internet Service Provider (ISP)**.

---

## 🚀 Features  
✅ **Detects connection drops** (logs when the internet goes down)  
✅ **Measures download & upload speeds periodically**  
✅ **Stores logs for analysis** (timestamped logs of outages and speeds)  
✅ **Generates a graph** to visualize **speed trends and downtime**  
✅ **Runs in a virtual environment for isolation**  

---

## 🛠️ Installation  

### **1️⃣ Clone the Repository**
```bash
git clone https://github.com/yourusername/NetWatchdog.git
cd NetWatchdog
```

### **2️⃣ Set Up a Virtual Environment**
```bash
sudo apt install python3-venv -y  # Ensure venv is installed
python3 -m venv venv              # Create a virtual environment
source venv/bin/activate          # Activate it (Linux/macOS)
```
(For Windows: `venv\Scripts\activate`)

### **3️⃣ Install Required Dependencies**
```bash
pip install -r requirements.txt
```
📄 **`requirements.txt`** (included in the repo)
```txt
pandas
matplotlib
speedtest-cli
```

### **4️⃣ Make Scripts Executable**
```bash
chmod +x internet_monitor.sh speedtest_log.sh
```

---

## ⚙️ Usage  

### **1. Monitor Internet Stability (Detect Connection Drops)**
This script **pings Google (8.8.8.8) every 10 seconds** and logs when the internet **goes down**.
```bash
nohup ./internet_monitor.sh > internet_monitor.log 2>&1 &
```
📄 **Log File:** `internet_status.log`
```
2025-02-25 14:00:10, UP, 15.23
2025-02-25 14:00:20, UP, 14.98
2025-02-25 14:00:30, DOWN, 0
```
🟥 If `"DOWN, 0"` appears, your internet **disconnected** at that time.

---

### **2. Monitor Internet Speed (Every 30 Minutes)**
Logs **download & upload speeds** at set intervals.
```bash
nohup ./speedtest_log.sh > speedtest.log 2>&1 &
```
📄 **Log File:** `internet_speed.log`
```
Timestamp, Ping (ms), Download (Mbps), Upload (Mbps)
2025-02-25 14:00:00, 12, 92.3, 11.4
2025-02-25 14:30:00, 18, 45.2, 8.3
2025-02-25 15:00:00, DOWN, 0, 0
```
🟥 **If `0 Mbps` appears**, your connection was either **down or too slow**.

---

### **3. Summarize Connection Issues for Your ISP**
After a day, analyze the logs and summarize **how often** your internet dropped.

📢 **Count how many times the internet dropped**
```bash
grep "DOWN" internet_status.log | wc -l
```
📢 **List all times the internet was down**
```bash
grep "DOWN" internet_status.log
```

📢 **Summarize average speeds over time**
```bash
awk -F',' '{sum+=$3; count++} END {print "Average Download Speed:", sum/count, "Mbps"}' internet_speed.log
```

---

### **4. Generate a Speed & Downtime Graph**
After running the scripts for a few hours/days, analyze the logs and **generate a graph**.

#### **Run the Python Analysis Script**
Activate the virtual environment:
```bash
source venv/bin/activate
python analyze_logs.py
```
📊 **Graph Includes:**  
- 📈 **Speed over time**  
- 🟥 **Red markers when the internet was down**  
- 📊 Clear trends to report to your **ISP**  

---

## 🔄 Stopping & Restarting the Monitoring Scripts  

To **stop monitoring**:
```bash
pkill -f internet_monitor.sh
pkill -f speedtest_log.sh
```

To **restart**:
```bash
nohup ./internet_monitor.sh > internet_monitor.log 2>&1 &
nohup ./speedtest_log.sh > speedtest.log 2>&1 &
```

---

## 📌 Automate Analysis (Optional)
To run daily reports automatically, add this to **cron**:
```bash
crontab -e
```
Add the line:
```bash
0 23 * * * /path/to/your/project/venv/bin/python /path/to/your/project/analyze_logs.py
```
This runs **every day at 11 PM**.

---

## 📌 Contributing  
Feel free to fork this project, submit PRs, or suggest improvements! 🚀  

---

## ⚖️ License  
This project is licensed under the **MIT License**.  

---

### 🔥 Developed for users who need proof of unstable internet! 📡💡

