resource "digitalocean_domain" "domain" {
  name       = var.domain
  ip_address = data.http.get_local_ip.response_body
  lifecycle { ignore_changes = [ip_address] }
}

resource "digitalocean_record" "record" {
  for_each   = toset(var.a_records)
  domain     = var.domain
  name       = each.value
  type       = "A"
  value      = data.http.get_local_ip.response_body
  ttl        = var.default_ttl
  depends_on = [digitalocean_domain.domain]
}

resource "digitalocean_record" "ns" {
  count  = var.ns_count
  domain = var.domain
  name   = format("ns%s", (count.index + 1))
  type   = "NS"
  value  = format("ns%s.%s.", (count.index + 1), var.domain)
  ttl    = var.default_ttl
}

resource "digitalocean_certificate" "domain" {
  name = var.domain
  type = var.certificate_type
  domains = [
    var.domain
    #digitalocean_record.domain_wildcard.fqdn
    # TODO: this is a provider limitation, either a DO alternative or some kind of better way to handle this would be slick
    # TODO: if the cert can be managed elsewhere it can probably just get loaded into DO every time
  ]
}
