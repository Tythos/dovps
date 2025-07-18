resource "digitalocean_volume" "dovpsstorage" {
  region                  = var.DO_REGION
  name                    = "volume-sfo3-01"
  size                    = 100
  initial_filesystem_type = "ext4"
}
