terraform {
    backend "s3" {
        bucket = "terraform-state-revolut"
        key = "terraform.tfstate"
        dynamodb_table = "terraform-state-lock-revolut"
        region = "eu-west-1"
    }
}