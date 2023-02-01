terraform {
  backend "s3" {
    bucket = "meiosdepagamento-prd-terraform-states-bucket"
    key    = "infraestrutura/lambda-snapshot-opensearch/terraform.tfstate"
    region = "ca-central-1"
  }
}
provider "aws" {
  region = var.region
}
