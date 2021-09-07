resource "google_dns_record_set" "website-verification" {
  name         = "${var.base_dnsdomain}."
  type         = "TXT"
  ttl          = 3600
  managed_zone = google_dns_managed_zone.main.name
  rrdatas      = ["google-site-verification=********"]
}

resource "google_dns_record_set" "website-a" {
  name         = "${var.base_dnsdomain}."
  type         = "A"
  ttl          = 3600
  managed_zone = google_dns_managed_zone.main.name
  rrdatas = [
    for rr in google_cloud_run_domain_mapping.website.status[0].resource_records :
    rr.rrdata if rr.type == "A"
  ]
}

resource "google_dns_record_set" "website-aaaa" {
  name         = "${var.base_dnsdomain}."
  type         = "AAAA"
  ttl          = 3600
  managed_zone = google_dns_managed_zone.main.name
  rrdatas = [
    for rr in google_cloud_run_domain_mapping.website.status[0].resource_records :
    rr.rrdata if rr.type == "AAAA"
  ]
}
