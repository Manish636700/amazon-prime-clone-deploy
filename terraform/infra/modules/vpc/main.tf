resource "aws_vpc" "this" {
    cidr_block              = var.vpc_cidr
    enable_dns_support      = true
    enable_dns_hostnames    = true

    tags = {
      Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "${var.vpc_name}-igw"
    }
}


resource "aws_subnet" "public" {
    count                   = length(var.public_subnets)
    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.public_subnets[count.index]
    availability_zone       = var.azs[count.index]
    map_public_ip_on_launch = true


    tags = {
      Name = "${var.vpc_name}-public-${count.index + 1}"
      Tier = "public"
    }
}


resource "aws_subnet" "private" {
    count                   = length(var.private_subnets)
    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.private_subnets[count.index]
    availability_zone     = var.azs[count.index]

    tags = {
        Name = "${var.vpc_name}-private-${count.index + 1}"
        Tier = "private"

    }    
}


resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id

    }
    tags = {
        Name = "${var.vpc_name}-public-rt"
    }
}


resource "aws_route_table_association" "public" {
    count             = length(aws_subnet.public)
    subnet_id         = aws_subnet.public[count.index].id
    route_table_id    = aws_route_table.public.id   
}


resource "aws_eip" "nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "this" {
    allocation_id   = aws_eip.nat.id
    subnet_id       = aws_subnet.public[0].id

    depends_on      = [aws_internet_gateway.this] 
}


resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.this.id
    }
}

resource "aws_route_table_association" "private" {
    count            = length(aws_subnet.private)
    subnet_id         = aws_subnet.private[count.index].id
    route_table_id    = aws_route_table.private.id
}

resource "aws_security_group" "this" {
    name          = "${var.ec2-sg-name}-sg"
    vpc_id        = aws_vpc.this.id

    dynamic "ingress" {
        for_each   = var.ingress_rules
        content {
            description   = ingress.value.description
            from_port     = ingress.value.from_port
            to_port       = ingress.value.to_port
            protocol      = ingress.value.protocol
            cidr_blocks   = ingress.value.cidr_blocks 
        }
    }

    egress {
        from_port         = 0
        to_port           = 0
        protocol          = "-1"
        cidr_blocks       = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.ec2-sg-name}-sg"
    }

}
