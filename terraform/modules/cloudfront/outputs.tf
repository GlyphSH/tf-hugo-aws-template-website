# Output the hosted zone ID of the CloudFront distribution.
# This ID is useful for referencing the distribution in DNS configurations and can help identify the route53 hosted zone.
output "zone_id" {
  value = aws_cloudfront_distribution.distribution.hosted_zone_id
}

# Output the domain name of the CloudFront distribution.
# This is the URL that clients can use to access the content served by the distribution.
output "domain_name" {
  value = aws_cloudfront_distribution.distribution.domain_name
}
