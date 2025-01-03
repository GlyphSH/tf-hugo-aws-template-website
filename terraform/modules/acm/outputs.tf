# Output the Amazon Resource Name (ARN) of the ACM certificate.
# The ARN uniquely identifies the certificate and can be used in other AWS services or configurations.
output "certificate_arn" {
  value = aws_acm_certificate.certificate.arn
}

# Output the domain validation options for the ACM certificate.
# This includes the necessary information for validating domain ownership and can be used for setting up DNS records.
output "domain_validation_options" {
  value = aws_acm_certificate.certificate.domain_validation_options
}
