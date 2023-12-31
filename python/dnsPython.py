import dns.resolver


def query_dns_records(domain, record_type):
    try:
        answers = dns.resolver.resolve(domain, record_type)
        return answers
    except dns.resolver.NoAnswer:
        return []
    except dns.resolver.NXDOMAIN:
        return []
    except Exception as e:
        print(f"Error querying {domain} for {record_type}: {e}")
        return []


def get_all_records(domain, subdomains=None):
    if subdomains is None:
        subdomains = ['www', 'mail']

    record_types = ['A', 'AAAA', 'MX', 'CNAME', 'TXT', 'NS', 'SOA', 'SRV', 'PTR']
    records = {rtype: [] for rtype in record_types}

    # Query for the main domain
    for record_type in record_types:
        records[record_type].extend(query_dns_records(domain, record_type))

    # Query for subdomains
    for subdomain in subdomains:
        full_domain = f"{subdomain}.{domain}"
        for record_type in record_types:
            records[record_type].extend(query_dns_records(full_domain, record_type))

    return records


if __name__ == "__main__":
    domain = input("Enter the domain name: ")
    records = get_all_records(domain)

    for record_type, answers in records.items():
        print(f"\n{record_type} Records:")
        for answer in answers:
            print(answer)
