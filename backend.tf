# backend
terraform {
  backend "s3" {
    bucket = "aws-study-tf-keit0773"
    key    = "stage/terraform.tfstate"
    region = "ap-northeast-1"
  }
}