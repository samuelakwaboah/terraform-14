data "aws_route53_zone" "selected" {
  name         = "samakwaboah.life"
  private_zone = false
}
#Lookup the existing Route53 hosted zone for your domain
data "aws_route53_zone" "primary" {
  name         = "samakwaboah.life"
  private_zone = false
}

# Lookup the existing wildcard certificate in us-east-1
data "aws_acm_certificate" "wildcard" {
  
  domain   = "*.samakwaboah.life"
  statuses = ["ISSUED"]
  most_recent = true
}

# Generate an IAM policy document granting s3 access to Cloufront OAC
data "aws_iam_policy_document" "s3_oac_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.frontend_bucket.arn}/*"]

# Restrict principal strictly to the CloudFront service
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    # Restrict permission condition to this specific CloudFront Distribution ARN
    condition {
    test     = "StringEquals"
    variable = "AWS:SourceArn"
    values   = [aws_cloudfront_distribution.frontend_cdn.arn]
    }
  }
}
