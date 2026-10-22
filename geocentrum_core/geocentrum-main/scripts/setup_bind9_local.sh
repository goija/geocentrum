#!/bin/bash
set +H

echo "🚀 VORTEX OS - BIND9 Lokale DNS Setup..."

# Maak een configuratiemap voor de DNS server
mkdir -p dns_server/config

echo "⚙️ named.conf.options genereren (Forwarding & Security)..."
cat << 'BIND_EOF' > dns_server/config/named.conf.options
options {
    directory "/var/cache/bind";
    recursion yes;
    allow-query { any; };
    forwarders {
        1.1.1.1; # Cloudflare DNS als fallback voor externe sites
        8.8.8.8;
    };
    dnssec-validation auto;
    listen-on { any; };
    listen-on-v6 { any; };
};
BIND_EOF

echo "⚙️ named.conf.local genereren (Lokale Zones)..."
cat << 'BIND_EOF' > dns_server/config/named.conf.local
zone "vortex.local" {
    type master;
    file "/etc/bind/db.vortex.local";
};
BIND_EOF

echo "⚙️ db.vortex.local (Zone File) genereren..."
cat << 'BIND_EOF' > dns_server/config/db.vortex.local
$TTL    604800
@       IN      SOA     ns.vortex.local. admin.vortex.local. (
                              2026101801 ; Serial
                              604800     ; Refresh
                               86400     ; Retry
                             2419200     ; Expire
                              604800 )   ; Negative Cache TTL
;
@       IN      NS      ns.vortex.local.
@       IN      A       127.0.0.1
ns      IN      A       127.0.0.1
turn    IN      A       127.0.0.1
matrix  IN      A       127.0.0.1
dashboard IN    A       127.0.0.1
BIND_EOF

echo "✅ BIND9 configuratiebestanden succesvol klaargezet in 'dns_server/config/'."
echo "💡 Kopieer deze bestanden naar /etc/bind/ of gebruik ze in een docker-compose setup."
