# DHCP Troubleshooting Tool

This project is a Python script that pulls DHCP requests from the local network for troubleshooting purposes. It is designed to help network administrators diagnose and resolve network issues related to DHCP.

## Files

The project consists of the following files:

- `network.py`: Contains functions to get the default network interface and local IP address of the system.
- `dhcp.py`: Contains functions to get the MAC address of a network interface and to send a DHCP discover packet.
- `troubleshoot.py`: Contains functions to load the configuration from a JSON file and to troubleshoot the network.
- `main.py`: The main script that initiates the network troubleshooting process.
- `config.json`: The configuration file for the script.
- `README.md`: This file.

## Usage

To use this script, follow these steps:

1. Update the `config.json` file with your network configuration.
2. Run the `main.py` script.

```bash
python3 main.py
```

## Configuration

The `config.json` file contains the following configuration options:

- `network`: The network configuration.
  - `interface`: The network interface to use (e.g., "eth0").
  - `subnet`: The subnet of the network (e.g., "192.168.1.0/24").
- `dhcp`: The DHCP configuration.
  - `server`: The IP address of the DHCP server (e.g., "192.168.1.1").
  - `port`: The port number of the DHCP server (e.g., 67).
- `troubleshoot`: The troubleshooting configuration.
  - `log_level`: The log level (e.g., "INFO").
  - `log_file`: The path to the log file (e.g., "/var/log/dhcp_troubleshoot.log").

## Dependencies

This script requires Python 3 and the following Python libraries:

- `socket`
- `struct`
- `binascii`
- `fcntl`
- `json`

## License

This project is licensed under the MIT License - see the LICENSE file for details.
