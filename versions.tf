terraform {
  required_version = ">= 0.13"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    http = {
      source = "hashicorp/http"
    }
  }
}
