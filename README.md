System Health Snapshot Monitor
A lightweight Bash-based system health monitoring script designed for both interactive troubleshooting and automated logging.
It provides real-time insights into CPU, memory, disk usage, uptime, and Docker service status, with configurable thresholds for alerting.

Features:  
Dual Mode Execution

Interactive Mode: Color-coded output for quick on-screen analysis.
Logging Mode: Appends clean reports to daily log files for record-keeping and automation.

Configurable thresholds for CPU usage, available memory, and disk space.

Service Monitoring

Currently checks Docker service status and version.

Automated Log Management

Logs are automatically pruned after 7 days to conserve disk space.

Customizable Output

Easily change header colors and thresholds.

Sample Output (Interactive Mode)

================================
System Health Snapshot Report
host: myserver / 07-31-2025 15:30
================================
________________________________

CPU:      12.5%
Memory:   2.3G/8G free
Disk:     20GB free
Uptime:   3 days, 4 hours, 15 minutes
Docker:   running (version 24.0.5)
________________________________

Color-coded alerts highlight high resource usage or service issues.

Usage
1. Interactive Mode
For live troubleshooting with formatted, color-coded output:

    ./system_health.sh interactive

2. Logging Mode
For automated runs (e.g., via cron). Outputs to a daily log file:

    ./system_health.sh log

Logs are stored in ~/system_health_logs/ by default.

Configuration
Thresholds (edit inside the script):

cpuThreshold=90.0     # Max allowed CPU usage (%)
memThreshold=1000     # Min available memory (MB)
diskThreshold=5       # Min available disk space (GB)

Setup
Make the script executable:

chmod +x system_health.sh
(Optional) Schedule with cron:

    crontab -e

    0 * * * * /path/to/system_health.sh log
    (Runs every hour in logging mode.)

Requirements
Linux system with:

bash
Docker (optional: for Docker service check)

Planned Enhancements
Enhanced alert levels (OK / WARNING / CRITICAL)

Improved formatted “dashboard” output

Email or webhook notifications for critical alerts

License
MIT License. Use at your own risk.
