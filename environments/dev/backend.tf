terraform {
  backend "s3" {
    bucket = "dev-clo835-assignment1"
    key    = "infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}
