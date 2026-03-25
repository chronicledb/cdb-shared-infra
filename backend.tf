terraform {
    backend "s3" {
        key = "shared-infra/terraform.tfstate"
    }
}