output "DROPLET_IP" {
  description = "IP address of the Droplet"
  value       = digitalocean_droplet.dodroplet.ipv4_address
}

output "PRIVATE_KEY" {
  description = "Private key for the Droplet"
  value       = tls_private_key.tlskey.private_key_pem
  sensitive   = true
}
