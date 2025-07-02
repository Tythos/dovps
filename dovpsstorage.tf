resource "digitalocean_volume" "dovpsstorage" {
  region                  = var.DO_REGION
  name                    = "dovpsstorage"
  size                    = 100
  initial_filesystem_type = "ext4"
  description             = "Persistent storage for server configuration and data"
}
