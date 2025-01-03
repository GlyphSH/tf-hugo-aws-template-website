# Output the unique ID of the S3 bucket.
# This can be used as a reference in other Terraform configurations or modules.
output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

# Output the Amazon Resource Name (ARN) of the S3 bucket.
# The ARN is a globally unique identifier for the bucket and can be used in permissions or other AWS services.
output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

# Output the regional domain name of the S3 bucket.
# This is useful for accessing the bucket directly via its regional endpoint.
output "bucket_regional_domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}

# Output the website endpoint for the S3 bucket's static website hosting.
# This is the URL where the static website can be accessed.
output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}
