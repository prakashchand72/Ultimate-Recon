#!/bin/bash

domain="$1"
output="$domain"

mkdir -p "$output"

echo "[*] Starting recon for $domain using Mutiple Tool..."

interlace -t "$domain" -o "$output" -cL cmd.script --silent

echo "[✓] Cooking finished for $domain."

echo "[✓] Combining all subdomains for $domain."
cat "$output"/*.txt | sort -u > subdomain.txt

echo "[+] Resolving and enriching..."
cat subdomain.txt | alterx -enrich --silent | dnsx --silent > dnsx.txt

echo "[+] Port scanning with Naabu..."
naabu -list dnsx.txt -silent > naabu.txt
echo "[✓] Done. Happy Hacking!!"
