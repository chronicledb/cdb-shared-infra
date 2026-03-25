output "cdb_tf_state_bucket" {
    description = "S3 bucket name for Terraform state - use in backend.hcl"
    value       = aws_s3_bucket.cdb_tf_state.bucket
}

output "cdb_tf_state_bucket_region" {
    description = "Region of the S3 bucket - use in backend.hcl"
    value       = var.region
}

output "cdb_tf_locks_dynamodb_table" {
    description = "DynamoDB table name for state locking - use in backend.hcl"
    value       = aws_dynamodb_table.cdb_tf_locks.name
}
