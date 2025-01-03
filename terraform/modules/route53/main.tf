# Define a Route 53 hosted zone for the domain "example.com"
resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

# Create an A record in the hosted zone for the naked domain (example.com)
resource "aws_route53_record" "naked" {
  # Reference the hosted zone ID created above
  zone_id = aws_route53_zone.example_com.zone_id

  # Specify the record name (naked domain)
  name    = "example.com"

  # Record type is A, indicating an IPv4 address
  type    = "A"

  # Alias configuration for pointing the record to a target
  alias {
    # The DNS name of the target (e.g., a CloudFront distribution, ALB, etc.)
    name                   = var.domain_name

    # The hosted zone ID of the target
    zone_id                = var.zone_id

    # Indicates whether to evaluate the health of the alias target
    evaluate_target_health = true
  }
}
