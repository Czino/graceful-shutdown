# graceful-shutdown
For machines connected to UPS without ability to send shutdown signal.

This script shuts down the machine if no network is detected for x amount of time.

## Set it up as a service

- Create a service file
    `sudo nano /etc/systemd/system/gracefulShutdown.service`
    Content:
    ```
    [Unit]
    Description=Graceful shutdown

    [Service]
    ExecStart=/PATH/TO/graceful-shutdown/gracefulShutdown.sh
    RuntimeDirectory=checkPowerSupply
    Restart=on-failure
    User=USER

    [Install]
    WantedBy=multi-user.target
    ```

- rename /PATH/TO the the location of shell script
- replace USER with actual user

- start and enable service
    `sudo systemctl enable gracefulShutdown.service`
    `sudo systemctl start gracefulShutdown.service`

## Options

The script contains 2 important variables `INTERFACE` & `MINUTES`

**INTERFACE** (default eth0): the interface your device is connected with (see full list with `ip link show`)

**MINUTES** (default 10): the minutes the script waits until it sends the shutdown signal