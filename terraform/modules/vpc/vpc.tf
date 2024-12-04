

#VPC
resource "aws_vpc" "VPCIP8000N8" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

output "aws-vpc-name" {
  value       = aws_vpc.VPCIP8000N8.id
  description = "This can be use in ansible script or other tools" # use terraform output or terraform output aws-vpc-name to see the value 
}

#Subnet Creation
#1.First Subnet
resource "aws_subnet" "SUB-1-VPCIP8000N8" {
  vpc_id            = aws_vpc.VPCIP8000N8.id
  availability_zone = "us-west-2a"
  cidr_block        = var.SUB_cidr_block[0]
  map_public_ip_on_launch = true

  tags = {
    Name = var.SUB_Tag_Name[0]
  }
}

#2. Second Subnet
resource "aws_subnet" "SUB-2-VPCIP8000N8" {
  vpc_id            = aws_vpc.VPCIP8000N8.id
  availability_zone = "us-west-2b"
  cidr_block        = var.SUB_cidr_block[1]
  map_public_ip_on_launch = true

  tags = {
    Name = var.SUB_Tag_Name[1]
  }
}

#3. Third Subnet
resource "aws_subnet" "SUB-3-VPCIP8000N8" {
  //vpc_id            = "vpc-0d627de12f26a2650"
  vpc_id            = aws_vpc.VPCIP8000N8.id
  availability_zone = "us-west-2c"
  //cidr_block        = "172.16.64.0/19"
  cidr_block        = var.SUB_cidr_block[2]
  map_public_ip_on_launch = true

  tags = {
    Name = var.SUB_Tag_Name[2]
  }
}

#4. Fourth Subnet
resource "aws_subnet" "SUB-4-VPCIP8000N8" {
  //vpc_id            = "vpc-0d627de12f26a2650"
  vpc_id            = aws_vpc.VPCIP8000N8.id
  availability_zone = "us-west-2d"
  //cidr_block        = "172.16.96.0/19"
  cidr_block        = var.SUB_cidr_block[3]
  map_public_ip_on_launch = true

  tags = {
    Name = var.SUB_Tag_Name[3]
  }
}

output "aws_subnet-name1" {
  value       = aws_subnet.SUB-1-VPCIP8000N8.id
  description = "This can be use in ansible script or other tools" # use terraform output or terraform output aws-vpc-name to see the value 
}
output "aws_subnet-name2" {
  value       = aws_subnet.SUB-2-VPCIP8000N8.id
  description = "This can be use in ansible script or other tools" # use terraform output or terraform output aws-vpc-name to see the value 
}
output "aws_subnet-name3" {
  value       = aws_subnet.SUB-3-VPCIP8000N8.id
  description = "This can be use in ansible script or other tools" # use terraform output or terraform output aws-vpc-name to see the value 
}
output "aws_subnet-name4" {
  value       = aws_subnet.SUB-4-VPCIP8000N8.id
  description = "This can be use in ansible script or other tools" # use terraform output or terraform output aws-vpc-name to see the value 
}

#$ terraform import aws_internet_gateway.gw igw-c0a643a9
resource "aws_internet_gateway" "IG_VPCIP8000N8" {
  //vpc_id = "vpc-0d627de12f26a2650"
  vpc_id            = aws_vpc.VPCIP8000N8.id

  tags = {
    Name = var.ig_name
  }
}

resource "aws_route_table" "Route-VPCIP8000N8" {
  vpc_id = "${aws_vpc.VPCIP8000N8.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IG_VPCIP8000N8.id}"
  }
  
  tags = {
    Name = var.route_name
  }
}

resource "aws_main_route_table_association" "Route-VPCIP8000N8" {
    vpc_id         = "${aws_vpc.VPCIP8000N8.id}"
    route_table_id = "${aws_route_table.Route-VPCIP8000N8.id}"
}

#subnet associations
resource "aws_route_table_association" "SUB-1-VPCIP8000N8" {
  subnet_id      = aws_subnet.SUB-1-VPCIP8000N8.id
  route_table_id = aws_route_table.Route-VPCIP8000N8.id
}
resource "aws_route_table_association" "SUB-2-VPCIP8000N8" {
  subnet_id      = aws_subnet.SUB-2-VPCIP8000N8.id
  route_table_id = aws_route_table.Route-VPCIP8000N8.id
}
resource "aws_route_table_association" "SUB-3-VPCIP8000N8" {
  subnet_id      = aws_subnet.SUB-3-VPCIP8000N8.id
  route_table_id = aws_route_table.Route-VPCIP8000N8.id
}
resource "aws_route_table_association" "SUB-4-VPCIP8000N8" {
  subnet_id      = aws_subnet.SUB-4-VPCIP8000N8.id
  route_table_id = aws_route_table.Route-VPCIP8000N8.id
}
