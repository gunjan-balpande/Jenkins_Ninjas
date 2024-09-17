terraform {
    backend "s3" {
        bucket = var.s3_backup
        key = "statefile/terraform.tfstate"
        region = "us-west-1"
    }
}