#!/bin/bash

# is Apache running
if systemctl is-active --quiet apache2; then
    echo "$(date): Apache is running."
else
    echo "$(date): Apache is not running. Restarting..."
    systemctl restart apache2

    if systemctl is-active --quiet apache2; then
        echo "$(date): Apache restarted successfully."
    else
        echo "$(date): Apache failed to restart."
    fi
fi
