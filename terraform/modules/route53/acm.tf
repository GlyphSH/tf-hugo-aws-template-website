resource "aws_route53_record" "example" {
  for_each = {
    for dvo in var.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.pianka_io.zone_id
}

resource "aws_acm_certificate_validation" "pianka_io" {
  certificate_arn         = var.certificate_arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}
