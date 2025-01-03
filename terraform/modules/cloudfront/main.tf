# Define a CloudFront distribution to serve content from the S3 bucket (or other origins).
resource "aws_cloudfront_distribution" "distribution" {
  # Configure the origin for the CloudFront distribution.
  origin {
    # The domain name of the origin (in this case, the S3 website endpoint).
    domain_name = var.website_endpoint

    # A unique identifier for the origin (often the bucket's regional domain name or another unique string).
    origin_id = var.bucket_regional_domain_name

    # Uncomment and replace with the OAC or OAI if restricting bucket access to CloudFront.
    # origin_access_control_id = aws_cloudfront_origin_access_identity.origin_access_identity.id

    # Configuration for a custom origin (used when the origin is not an S3 bucket directly integrated with CloudFront).
    custom_origin_config {
      http_port              = "80"           # Port for HTTP requests.
      https_port             = "443"          # Port for HTTPS requests.
      origin_protocol_policy = "http-only"    # Allow only HTTP for requests to the origin.
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]  # Supported SSL/TLS protocols.
    }
  }

  # Enable the CloudFront distribution.
  enabled = true

  # Enable IPv6 support for the distribution.
  is_ipv6_enabled = true

  # Set the default root object served by the distribution.
  default_root_object = "index.html"  # This is typically the homepage for static websites.

  # Define alternate domain names (CNAMEs) for the distribution.
  aliases = ["example.com"]  # Replace with your actual domain name(s).

  # Configure the default cache behavior.
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]  # HTTP methods supported.
    cached_methods   = ["GET", "HEAD"]  # HTTP methods cached by CloudFront.
    target_origin_id = var.bucket_regional_domain_name  # Link the behavior to the specified origin.

    # Configure how query strings and cookies are forwarded.
    forwarded_values {
      query_string = false  # Do not forward query strings to the origin.

      cookies {
        forward = "none"  # Do not forward cookies to the origin.
      }
    }

    # Define the protocol policy for viewers.
    viewer_protocol_policy = "allow-all"  # Allow both HTTP and HTTPS connections from viewers.

    # Configure time-to-live (TTL) settings for caching.
    min_ttl     = 0      # Minimum time objects are cached (in seconds).
    default_ttl = 3600   # Default time objects are cached (in seconds).
    max_ttl     = 86400  # Maximum time objects are cached (in seconds).
  }

  # Configure SSL/TLS settings for the distribution.
  viewer_certificate {
    acm_certificate_arn = var.certificate_arn  # The ARN of the ACM certificate for the distribution.
    ssl_support_method  = "sni-only"          # Use SNI (Server Name Indication) for SSL.
  }

  # Restrict geographic access to the distribution.
  restrictions {
    geo_restriction {
      restriction_type = "none"  # Allow access from all geographic locations.
    }
  }
}
