from scapy.all import *
conf.checkIPaddr = False  # Disable IP address checking

def dhcp_discover():
    # Build the DHCP discover packet
    ethernet = Ether(src=RandMAC(), dst="ff:ff:ff:ff:ff:ff")
    ip = IP(src="0.0.0.0", dst="255.255.255.255")
    udp = UDP(sport=68, dport=67)
    bootstrap = BOOTP(chaddr=[RandByte() for _ in range(12)])  # Modified this line
    dhcp = DHCP(options=[("message-type", "discover"), "end"])

    discover_packet = ethernet/ip/udp/bootstrap/dhcp
    return discover_packet


def main():
    # Send the DHCP discover packet and capture the response
    response, _ = srp(dhcp_discover(), multi=True, timeout=10, iface="eth0", verbose=0)

    for _, rcv in response:
        if DHCP in rcv:
            for item in rcv[DHCP].options:
                if item[0] == "message-type":
                    continue
                print(f"{item[0]:15} : {item[1]}")

if __name__ == "__main__":
    main()
