# cdb-shared-infra

Provisions shared AWS networking resources (VPC, subnets) used by other services via Terraform remote state.

## First-time setup

The S3 bucket and DynamoDB table for remote state must exist before the main config can be initialized. They are managed separately in `bootstrap/` with local state.

```bash
cd bootstrap
terraform init
terraform apply -var="region=<region>"  # e.g. us-east-1
```

Then create `backend.hcl` in the repo's root from the outputs:

```bash
terraform output
```

```hcl
# backend.hcl
bucket         = "<cdb_tf_state_bucket output>"
region         = "<cdb_tf_state_bucket_region output>"
dynamodb_table = "<cdb_tf_locks_dynamodb_table output>"
```

## Deploying

```bash
cd ..  # back to repo root
terraform init -backend-config=backend.hcl
terraform apply -var="region=<region>" -var="az=<az>"  # e.g. us-east-1, us-east-1a
```

## Consuming outputs in another repo

```hcl
data "terraform_remote_state" "shared_infra" {
    backend = "s3"

    config = {
        bucket         = "cdb-tf-state-<aws-account-id>"
        key            = "shared-infra/terraform.tfstate"
        region         = "<region>"
        dynamodb_table = "cdb-tf-locks"
    }
}

# Then reference:
# data.terraform_remote_state.shared_infra.outputs.vpc_id
# data.terraform_remote_state.shared_infra.outputs.private_subnet_id
```