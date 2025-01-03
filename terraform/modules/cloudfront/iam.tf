# Attach a bucket policy to the specified S3 bucket.
# This policy grants permissions for CloudFront to access the bucket.
resource "aws_s3_bucket_policy" "bucket_policy" {
  # Reference the S3 bucket by its ID (passed as a variable).
  bucket = var.bucket_id

  # Use the policy document defined in the data block below.
  policy = data.aws_iam_policy_document.cloudfront_policy.json
}

# Create a CloudFront Origin Access Identity (OAI).
# The OAI allows CloudFront to securely access the S3 bucket without exposing the bucket publicly.
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "cloudfront_origin_access"  # An optional comment for identifying the OAI.
}

# Generate an IAM policy document that grants CloudFront access to the S3 bucket.
data "aws_iam_policy_document" "cloudfront_policy" {
  # Define a single policy statement.
  statement {
    sid = "1"  # An optional identifier for the policy statement.

    # Specify the principal (who has access). In this case, it's set to "*", which can be customized.
    principals {
      type        = "AWS"      # Specify that the principal is an AWS entity.
      identifiers = ["*"]      # Replace "*" with the ARN of the CloudFront Origin Access Identity for tighter security.
    }

    # Define the allowed actions. Here, it's limited to reading objects from the bucket.
    actions = [
      "s3:GetObject"            # Allow CloudFront to retrieve objects from the S3 bucket.
    ]

    # Define the resources this policy applies to.
    resources = [
      "${var.bucket_arn}/*"     # Apply the policy to all objects within the specified S3 bucket.
    ]
  }
}
