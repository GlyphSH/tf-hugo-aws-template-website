resource "aws_route53_zone" "pianka_io" {
  name = "pianka.io"
}

resource "aws_route53_record" "google_workspace_txt" {
  zone_id = aws_route53_zone.pianka_io.zone_id
  name    = ""
  type    = "TXT"
  ttl     = "300"
  records = ["google-site-verification=uSf9ThHvSXm0L4YaQbxJF6BMiIYS7cuDU00oTsmPRRo"]
}

resource "aws_route53_record" "google_workspace_mx" {
  zone_id = aws_route53_zone.pianka_io.zone_id
  name    = ""
  type    = "MX"
  ttl     = "300"
  records = ["10 smtp.google.com"]
}

resource "aws_route53_record" "naked" {
  zone_id = aws_route53_zone.pianka_io.zone_id
  name    = "pianka.io"
  type    = "A"

  alias {
    name                   = var.domain_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}
