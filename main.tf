resource "aws_vpc" "cdb" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "cdb-vpc"
    }
}

resource "aws_subnet" "cdb_private" {
    vpc_id            = aws_vpc.cdb.id
    cidr_block        = "10.0.0.0/24"
    availability_zone = var.az

    tags = {
        Name = "cdb-private-subnet"
    }
}

resource "aws_subnet" "cdb_public" {
    vpc_id            = aws_vpc.cdb.id
    cidr_block        = "10.0.10.0/24"
    availability_zone = var.az

    tags = {
        Name = "cdb-public-subnet"
    }
}

resource "aws_internet_gateway" "cdb" {
    vpc_id = aws_vpc.cdb.id

    tags = {
        Name = "cdb-igw"
    }
}

resource "aws_route_table" "cdb_public" {
    vpc_id = aws_vpc.cdb.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.cdb.id
    }

    tags = {
        Name = "cdb-public-rt"
    }
}

resource "aws_route_table_association" "cdb_public" {
    subnet_id      = aws_subnet.cdb_public.id
    route_table_id = aws_route_table.cdb_public.id
}
