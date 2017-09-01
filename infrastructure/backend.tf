terraform {
  backend "s3" {
    bucket         = "buffer-terraform-state"
    key            = "state"
    region         = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}