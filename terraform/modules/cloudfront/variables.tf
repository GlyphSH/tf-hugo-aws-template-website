# Variable to store the unique identifier of the S3 bucket.
# This ID is used to reference the bucket in various AWS services and configurations.
variable "bucket_id" {
  type  = string
}

# Variable to store the Amazon Resource Name (ARN) of the S3 bucket.
# The ARN is a globally unique identifier used for permissions and in IAM policies.
variable "bucket_arn" {
  type  = string
}

# Variable to store the regional domain name of the S3 bucket.
# This domain name is used to access the bucket directly in its respective AWS region.
variable "bucket_regional_domain_name" {
  type  = string
}

# Variable to store the Amazon Resource Name (ARN) of the ACM certificate.
# This certificate is used for securing HTTPS connections in the CloudFront distribution.
variable "certificate_arn" {
  type  = string
}

# Variable to store the endpoint URL for the S3 website configuration.
# This URL is used to access the static website hosted on the S3 bucket.
variable "website_endpoint" {
  type  = string
}
