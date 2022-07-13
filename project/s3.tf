module "s3" {
  source                  = "git@github.com:sanketkadge1/Terraform//s3?ref=AWS"
  bucket                  = local.s3
  acl                     = "private"
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
  attach_policy           = true
  policy                  = data.aws_iam_policy_document.max_feast_s3_bucket_policy.json
  tags                    = "test"
  versioning = {
    enabled = true
  }
  logging = {
    target_bucket = local.s3_bucket_log
    target_prefix = "S3Logs/${local.s3}"
  }
  lifecycle_rule = [
    {
      id      = "${local.s3}-lifecycle"
      enabled = true
      prefix  = ""
      transition = [
        {
          days          = 31
          storage_class = "GLACIER"
          }, {
          days          = 401
          storage_class = "DEEP_ARCHIVE"
        }
      ]
    }
  ]
}
