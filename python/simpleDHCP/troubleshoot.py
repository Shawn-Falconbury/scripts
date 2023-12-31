import json
import network
import dhcp

def load_config():
    """
    This function loads the configuration from the config.json file.
    """
    try:
        with open('config.json', 'r') as f:
            config = json.load(f)
        return config
    except Exception as e:
        print(f"Error loading config: {e}")
        return None

def troubleshoot_network():
    """
    This function troubleshoots the network by sending a DHCP request and printing the results.
    """
    try:
        # Load the config
        config = load_config()
        if config is None:
            return

        # Get the network interface
        interface = network.get_interface()
        if interface is None:
            return

        # Get the local IP
        local_ip = network.get_local_ip(interface)
        if local_ip is None:
            return

        # Get the MAC address
        mac_address = dhcp.get_mac_address(interface)
        if mac_address is None:
            return

        # Send a DHCP discover packet
        dhcp.send_dhcp_discover_packet(interface)

        # Print the results
        print(f"Interface: {interface}")
        print(f"Local IP: {local_ip}")
        print(f"MAC Address: {mac_address}")
    except Exception as e:
        print(f"Error troubleshooting network: {e}")

if __name__ == "__main__":
    troubleshoot_network()
