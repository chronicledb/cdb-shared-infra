resource "aws_vpc" "cdb_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "cdb-vpc"
    }
}

resource "aws_subnet" "cdb_private_subnet" {
    vpc_id            = aws_vpc.cdb_vpc.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = var.az

    tags = {
        Name = "cdb-private-subnet"
    }
}