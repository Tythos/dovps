resource "cloudflare_dns_record" "cfrecorda" {
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = var.DOMAIN_NAME
  type    = "A"
  content = digitalocean_droplet.dodroplet.ipv4_address
  ttl     = 3600
}
