terraform {
  backend "s3" {
    bucket = "matiabhi"                           // Bucket where to SAVE Terraform State
    key    = "prod-matiram/network/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                              // Region where bucket is created
  }
}