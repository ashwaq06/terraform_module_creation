resource "aws_vpc" "zenskar" {
  cidr_block             = var.vpc_cidr_block
  enable_dns_support     = true
  enable_dns_hostnames   = true
  tags = {
    Name = "zenskar-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count                  = length(var.public_subnet_cidr_blocks)
  vpc_id                 = aws_vpc.zenskar.id
  cidr_block             = var.public_subnet_cidr_blocks[count.index]
  availability_zone      = var.availability_zones[count.index]
  tags = {
    Name = "zenskar-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                  = length(var.private_subnet_cidr_blocks)
  vpc_id                 = aws_vpc.zenskar.id
  cidr_block             = var.private_subnet_cidr_blocks[count.index]
  availability_zone      = var.availability_zones[count.index]
  tags = {
    Name = "zenskar-private-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "zenskar_igw" {
  vpc_id = aws_vpc.zenskar.id
  tags = {
    Name = "zenskar-igw"
  }
}

resource "aws_eip" "nat_eip" {
  count = length(var.availability_zones)
  tags = {
    Name = "zenskar-nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count           = length(var.availability_zones)
  allocation_id   = aws_eip.nat_eip[count.index].id
  subnet_id       = aws_subnet.public_subnet[count.index].id
  tags = {
    Name = "zenskar-nat-gateway-${count.index + 1}"
  }
}
