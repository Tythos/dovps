locals {
  user_data = templatefile("${path.module}/user_data.yaml.tpl", {
    PERSISTENT_VOLUME_NAME = digitalocean_volume.dovpsstorage.name
  })
}

resource "digitalocean_droplet" "dodroplet" {
  image     = "ubuntu-22-04-x64"
  name      = "dodroplet"
  region    = var.DO_REGION
  size      = "s-4vcpu-8gb"
  ssh_keys  = [digitalocean_ssh_key.dosshkey.id]
  user_data = local.user_data
}
