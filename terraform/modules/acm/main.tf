# Create an ACM (AWS Certificate Manager) certificate for the specified domain.
# This certificate will be used to enable HTTPS for the domain in CloudFront or other AWS services.
resource "aws_acm_certificate" "certificate" {
  # The domain name for which the certificate is being requested.
  domain_name       = "example.com"  # Replace with your actual domain name.

  # Specify the method for validating the domain ownership.
  validation_method = "DNS"  # DNS validation requires adding a CNAME record to the DNS settings.

  # Manage the lifecycle of the certificate resource.
  lifecycle {
    # Ensure that a new certificate is created before the old one is destroyed.
    create_before_destroy = true  # This prevents downtime during certificate updates.
  }
}
