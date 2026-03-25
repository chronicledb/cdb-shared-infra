output "cdb_vpc_id" {
    description = "ID of the shared VPC"
    value       = aws_vpc.cdb_vpc.id
}

output "cdb_private_subnet_id" {
    description = "ID of the private subnet"
    value       = aws_subnet.cdb_private_subnet.id
}