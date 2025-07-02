resource "digitalocean_project" "doproject" {
  name        = "dovps"
  description = "Namespace for encapsulation of cloud resources"
  purpose     = "Demonstration"
  environment = "Development"

  resources = [
    digitalocean_droplet.dodroplet.urn,
    digitalocean_volume.dovpsstorage.urn
  ]
}
