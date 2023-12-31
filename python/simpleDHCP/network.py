import socket
import fcntl
import struct

def get_interface():
    """
    This function returns the default network interface of the system.
    """
    try:
        default_interface = open('/proc/net/route').readlines()[1].split()[0]
        return default_interface
    except Exception as e:
        print(f"Error getting network interface: {e}")
        return None

def get_local_ip(interface):
    """
    This function returns the local IP address of the given network interface.
    """
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        return socket.inet_ntoa(fcntl.ioctl(
            sock.fileno(),
            0x8915,  # SIOCGIFADDR
            struct.pack('256s', interface[:15].encode('utf-8'))
        )[20:24])
    except Exception as e:
        print(f"Error getting local IP: {e}")
        return None
