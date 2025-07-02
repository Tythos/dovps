terraform {
  required_version = ">= 1.0.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.6"
    }

    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.58"
    }
  }
}


provider "cloudflare" {
  # email   = var.CLOUDFLARE_EMAIL
  api_token = var.CLOUDFLARE_API_TOKEN
}

provider "digitalocean" {
  token = var.DO_TOKEN
}
