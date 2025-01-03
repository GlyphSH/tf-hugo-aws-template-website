# Configure the Terraform backend to store the state file in an S3 bucket.
# This allows for remote state management and collaboration between team members.
terraform {
  backend "s3" {
    bucket = "bucket-name-tf"  # The name of the S3 bucket where the Terraform state will be stored.
    key    = "terraform.tfstate"  # The key (path) within the bucket to store the state file.
    region = "us-east-1"  # The AWS region where the S3 bucket is located.
  }
}

# Configure the AWS provider.
# This specifies which AWS region to operate in for all resources defined in this configuration.
provider "aws" {
  region = "us-east-1"  # The region for AWS operations, matching the backend S3 bucket region.
}

# Module to create an S3 bucket.
module "bucket" {
  source = "./modules/s3"  # Path to the module responsible for creating the S3 bucket.
  name   = "bucket-name-hugo"  # The name of the S3 bucket to be created.
}

# Module to create a CloudFront distribution that serves content from the S3 bucket.
module "distribution" {
  source = "./modules/cloudfront"  # Path to the module responsible for creating the CloudFront distribution.

  # Pass outputs from the S3 bucket module to the CloudFront distribution module.
  bucket_id                   = module.bucket.bucket_id  # ID of the S3 bucket.
  bucket_arn                  = module.bucket.bucket_arn  # ARN of the S3 bucket.
  bucket_regional_domain_name = module.bucket.bucket_regional_domain_name  # Regional domain name of the S3 bucket.
  website_endpoint            = module.bucket.website_endpoint  # Endpoint URL for the static website.
  certificate_arn             = module.tls.certificate_arn  # ARN of the ACM certificate for HTTPS.
}

# Module to create an ACM certificate for securing HTTPS connections.
module "tls" {
  source = "./modules/acm"  # Path to the module responsible for creating the ACM certificate.
}

# Module to configure Route 53 DNS settings.
module "dns" {
  source = "./modules/route53"  # Path to the module responsible for managing Route 53 DNS records.

  # Pass the ACM certificate and domain information to the DNS module.
  certificate_arn                     = module.tls.certificate_arn  # ARN of the ACM certificate.
  domain_validation_options           = module.tls.domain_validation_options  # Domain validation options from the ACM certificate.
  domain_name                         = module.distribution.domain_name  # Domain name for the CloudFront distribution.
  zone_id                             = module.distribution.zone_id  # ID of the Route 53 hosted zone.
}
