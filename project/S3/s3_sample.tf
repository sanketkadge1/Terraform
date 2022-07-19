module "s3_bucket" {
  source = "https://github.com/sanketkadge1/Terraform/tree/AWS/Modules/S3"

  bucket = "my-s3-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

}
