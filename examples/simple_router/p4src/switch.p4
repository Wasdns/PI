#define ETHERTYPE_VLAN         0x8100
#define ETHERTYPE_QINQ         0x9100
#define ETHERTYPE_MPLS         0x8847
#define ETHERTYPE_IPV4         0x0800
#define ETHERTYPE_IPV6         0x86dd
#define ETHERTYPE_ARP          0x0806
#define IP_PROTOCOLS_IPHL_ICMP         0x501
#define IP_PROTOCOLS_IPHL_IPV4         0x504
#define IP_PROTOCOLS_IPHL_TCP          0x506
#define IP_PROTOCOLS_IPHL_UDP          0x511

header_type ethernet_t {
    fields {
        dstAddr : 48;
        srcAddr : 48;
        etherType : 16;
    }
}

header_type ipv4_t {
    fields {
        version : 4;
        ihl : 4;
        diffserv : 8;
        totalLen : 16;
        identification : 16;
        flags : 3;
        fragOffset : 13;
        ttl : 8;
        protocol : 8;
        hdrChecksum : 16;
        srcAddr : 32;
        dstAddr: 32;
    }
}

header_type icmp_t {
    fields {
        typeCode : 16;
        hdrChecksum : 16;
    }
}

header_type tcp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        seqNo : 32;
        ackNo : 32;
        dataOffset : 4;
        res : 4;
        flags : 8;
        window : 16;
        checksum : 16;
        urgentPtr : 16;
    }
}

header_type udp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        length_ : 16;
        checksum : 16;
    }
}

parser start {
    return parse_ethernet;
}

header ethernet_t ethernet;

parser parse_ethernet {
    extract(ethernet);
    return select(latest.etherType) {
        ETHERTYPE_IPV4 : parse_ipv4;
        default: ingress;
    }
}

header ipv4_t ipv4;

parser parse_ipv4 {
    extract(ipv4);
    return select(latest.fragOffset, latest.ihl, latest.protocol) {
        IP_PROTOCOLS_IPHL_ICMP : parse_icmp;
        IP_PROTOCOLS_IPHL_TCP : parse_tcp;
        IP_PROTOCOLS_IPHL_UDP : parse_udp;
        default: ingress;
    }
}

header icmp_t icmp;

parser parse_icmp {
    extract(icmp);
    return select(latest.typeCode) { 
        default: ingress;
    }
} 

header tcp_t tcp;

parser parse_tcp {
    extract(tcp);
    return select(latest.dstPort) { 
        default: ingress;
    }
}

header udp_t udp;

parser parse_udp {
    extract(udp);
    return select(latest.dstPort) { 
        default: ingress;
    }
}

action _drop() {
	drop();
}

action _nop() {
}

action set_nhop(port) {
	modify_field(standard_metadata.egress_spec, port);
}

table ipv4_lpm {
	reads { 
		ipv4.dstAddr : lpm;
	}
	actions {
		_nop; set_nhop;
	}	
}

control ingress {
	apply(ipv4_lpm);
}

control egress {
}
