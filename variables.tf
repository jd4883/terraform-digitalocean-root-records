variable "domain" {
  type        = string
  description = "The domain name used with Digital Ocean"
}

variable "certificate_type" {
  type    = string
  default = "lets_encrypt"
}

variable "get_public_ip" {
  type    = string
  default = "https://ipecho.net/plain"
}

variable "ns_count" {
  type        = number
  default     = 3
  description = "Default is 3, this is customizable if desired"
}

variable "default_ttl" {
  type        = number
  description = "TTL in seconds, default is 3600"
  default     = 3600
}

variable "a_records" {
  type = list(string)
  default = [
    "*",
    "www",
  ]
  description = "a list of default a records to add for the root domain"
}