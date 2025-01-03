# The ARN of the ACM certificate that needs to be validated.
# This is a string representing the unique identifier for the certificate in AWS.
variable "certificate_arn" {
  type = string
}

# The primary domain name for which DNS records will be managed.
# Example: "example.com".
variable "domain_name" {
  type = string
}

# The ID of the Route 53 hosted zone where DNS records will be created.
# This ID uniquely identifies the hosted zone within AWS.
variable "zone_id" {
  type = string
}

# A list of objects representing domain validation options required for ACM certificate validation.
# Each object in the list must contain the following fields:
# - `domain_name`: The domain requiring validation (e.g., "example.com" or "sub.example.com").
# - `resource_record_name`: The name of the DNS record to create for validation (e.g., "_abc.example.com").
# - `resource_record_value`: The value of the DNS record to create (e.g., a CNAME or TXT record value).
# - `resource_record_type`: The type of DNS record (e.g., "CNAME" or "TXT").
variable "domain_validation_options" {
  type = list(object({
    domain_name           = string
    resource_record_name  = string
    resource_record_value = string
    resource_record_type  = string
  }))
}
