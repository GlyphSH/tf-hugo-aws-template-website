# Create an S3 bucket with the name provided in the "var.name" variable.
resource "aws_s3_bucket" "bucket" {
  bucket = var.name
}

# Configure the S3 bucket as a static website.
resource "aws_s3_bucket_website_configuration" "website" {
  # Reference the S3 bucket created above.
  bucket = aws_s3_bucket.bucket.id

  # Specify the default document to serve for requests to the bucket's root.
  index_document {
    suffix = "index.html"  # The file to be served as the homepage.
  }
}

# Enable server-side encryption (SSE) for the S3 bucket to protect data at rest.
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  # Reference the S3 bucket created above.
  bucket = aws_s3_bucket.bucket.id

  # Define the encryption rule to apply by default.
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # Use AES256 encryption for all objects by default.
    }
  }
}

# Set up a public access block configuration for the S3 bucket.
resource "aws_s3_bucket_public_access_block" "access" {
  # Reference the S3 bucket created above.
  bucket = aws_s3_bucket.bucket.id

  # Control public access settings:
  block_public_acls       = false  # Allow public ACLs on objects.
  block_public_policy     = false  # Allow public bucket policies.
  ignore_public_acls      = false  # Do not ignore public ACLs.
  restrict_public_buckets = false  # Do not restrict access to the entire bucket.
}

# Enable versioning for the S3 bucket to maintain previous versions of objects.
resource "aws_s3_bucket_versioning" "versioning" {
  # Reference the S3 bucket created above.
  bucket = aws_s3_bucket.bucket.id

  # Configure versioning to be enabled.
  versioning_configuration {
    status = "Enabled"  # Enable versioning to keep track of object versions.
  }
}
