# Define a local variable to hold the unique identifier for the CloudFront origin.
# This identifier is used to reference the origin configuration within the CloudFront distribution.
locals {
  origin_id = "your-website-origin"  # Replace with a meaningful name that describes your origin.
}
