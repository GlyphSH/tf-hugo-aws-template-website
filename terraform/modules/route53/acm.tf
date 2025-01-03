# Create Route 53 DNS records for validating an ACM certificate
resource "aws_route53_record" "example" {
  # Dynamically create a Route 53 record for each domain validation option
  for_each = {
    for dvo in var.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name        # Record name for validation (e.g., _abc.example.com)
      record = dvo.resource_record_value       # Value for validation record
      type   = dvo.resource_record_type        # Type of record (e.g., CNAME or TXT)
    }
  }

  # Allow overwriting existing records if necessary
  allow_overwrite = true

  # Use the dynamically defined values for the record name, value, and type
  name    = each.value.name                    # DNS record name
  records = [each.value.record]                # DNS record value
  ttl     = 60                                 # Time-to-live for the record
  type    = each.value.type                    # DNS record type

  # Associate the record with the hosted zone created earlier
  zone_id = aws_route53_zone.example_com.zone_id
}

# Validate an ACM certificate using the DNS validation records
resource "aws_acm_certificate_validation" "example_com" {
  # Specify the ARN of the ACM certificate to validate
  certificate_arn = var.certificate_arn

  # Use the FQDNs of the created Route 53 validation records for validation
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}
