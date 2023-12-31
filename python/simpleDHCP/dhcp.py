import socket
import struct
import binascii
import fcntl

def get_mac_address(interface):
    """
    This function returns the MAC address of the given network interface.
    """
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        info = fcntl.ioctl(s.fileno(), 0x8927,  struct.pack('256s', interface[:15].encode('utf-8')))
        return ''.join(['%02x:' % char for char in info[18:24]])[:-1]
    except Exception as e:
        print(f"Error getting MAC address: {e}")
        return None

def send_dhcp_discover_packet(interface):
    """
    This function sends a DHCP discover packet on the given network interface.
    """
    try:
        # Create a new socket and bind it to the interface
        s = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_UDP)
        s.bind((interface, socket.IPPROTO_UDP))

        # Build the DHCP discover packet
        mac_address = get_mac_address(interface)
        mac_bytes = binascii.unhexlify(mac_address.replace(':', ''))
        packet = b'\x01\x01\x06\x00'  # Message type: Boot Request (1), Hardware type: Ethernet (1), Hardware address length: 6, Hops: 0
        packet += b'\x00\x00\x00\x00'  # Transaction ID
        packet += b'\x00\x00'  # Seconds elapsed
        packet += b'\x80\x00'  # Bootp flags: 0x8000 (Broadcast)
        packet += b'\x00\x00\x00\x00'  # Client IP address
        packet += b'\x00\x00\x00\x00'  # Your (client) IP address
        packet += b'\x00\x00\x00\x00'  # Next server IP address
        packet += b'\x00\x00\x00\x00'  # Relay agent IP address
        packet += mac_bytes  # Client MAC address
        packet += b'\x00' * 10  # Client hardware address padding
        packet += b'\x00' * 67  # Server host name
        packet += b'\x00' * 125  # Boot file name
        packet += b'\x63\x82\x53\x63'  # Magic cookie: DHCP
        packet += b'\x35\x01\x01'  # Option: (53) DHCP Message Type (Length: 1) - Discover
        packet += b'\xff'  # End option

        # Send the DHCP discover packet
        s.sendto(packet, ('<broadcast>', 68))
    except Exception as e:
        print(f"Error sending DHCP discover packet: {e}")
