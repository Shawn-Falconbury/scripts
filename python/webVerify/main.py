import port_scanner

def main():
    ip_list = port_scanner.read_ip_list('ip_list.txt')
    open_ports = port_scanner.scan_ports(ip_list)
    port_scanner.write_results('results.txt', open_ports)

if __name__ == "__main__":
    main()
