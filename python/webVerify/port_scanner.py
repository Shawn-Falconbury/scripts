import socket

def scan_ports(ip_list):
    open_ports = {}
    for ip in ip_list:
        open_ports[ip] = []
        for port in [80, 443]:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.settimeout(1)
            result = sock.connect_ex((ip, port))
            if result == 0:
                open_ports[ip].append(port)
            sock.close()
    return open_ports

def read_ip_list(file_name):
    with open(file_name, 'r') as file:
        ip_list = file.read().splitlines()
    return ip_list

def write_results(file_name, open_ports):
    with open(file_name, 'w') as file:
        for ip, ports in open_ports.items():
            file.write(f'{ip}: {ports}\n')

if __name__ == "__main__":
    ip_list = read_ip_list('ip_list.txt')
    open_ports = scan_ports(ip_list)
    write_results('results.txt', open_ports)
