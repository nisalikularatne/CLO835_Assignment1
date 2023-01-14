terraform {
  backend "s3" {
    bucket = "dev-clo835-assignment"
    key    = "infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}
