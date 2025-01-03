The bash script  uses `systemctl` to check Apache's status. It then logs the result of the check. If the service is not running, it attempts to restart it, and logs the result of that attempt to `journal`.

To run this periodically, I would define a `systemd` service unit at `/etc/systemd/system/service-monitor.service`:

```ini
[Unit]
Description=Apache Service Monitoring Script
After=network.target

[Service]
ExecStart=/usr/local/bin/monitor_service.sh
StandardOutput=journal
StandardError=journal
Restart=on-failure
Type=simple

[Install]
WantedBy=multi-user.target
```

And then a `systemd` Timer unit at `/etc/systemd/system/service-monitor.timer`:

```ini
[Unit]
Description=Run Service Monitoring Script Periodically

[Timer]
OnBootSec=10min
OnUnitActiveSec=1h
Unit=service-monitor.service

[Install]
WantedBy=timers.target
```

To make the script reusable, I would modify it in the following way:

```shell
#!/bin/bash

SERVICE=$1

if systemctl is-active --quiet "$SERVICE"; then
    echo "$(date): $SERVICE is running."
else
    echo "$(date): $SERVICE is not running. Restarting..."
    systemctl restart "$SERVICE"

    if systemctl is-active --quiet "$SERVICE"; then
        echo "$(date): $SERVICE restarted successfully."
    else
        echo "$(date): $SERVICE failed to restart."
    fi
fi
```

In so doing, I would also modify the `systemd` service file:

```ini
[Unit]
Description=Apache Service Monitoring Script
After=network.target

[Service]
ExecStart=/usr/local/bin/monitor_service.sh apache2
StandardOutput=journal
StandardError=journal
Restart=on-failure
Type=simple

[Install]
WantedBy=multi-user.target
```

I can reuse this configuration for any service I wish to monitor in the future, changing only the argument passed to the  `monitor_service.sh` script at `ExecStart`.

I would add a `systemd` timer unit file for any additional services I wished to monitor in this way.

I could also run a simple `cron` job for this task. However, I would need to define logging output more strictly as cronjob logs are harder to correlate with specific tasks, whereas `systemd` tasks are tightly integrated with `journalctl`. In the event of a failure, I'd have to build in error handling mechanisms into the script. In the context of `Apache`, `systemd` will ensure the monitoring script is run after the network is online, whereas a `cron` is time dependent.