resource "aws_key_pair" "aws_key" {
  key_name = "${var.env}-infra-app-key"
  public_key = file("terra-key-ec2.pub")
  tags = {
    Environment = var.env
  }
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
        Name = "${var.env}-default-vpc"
  }
}

resource "aws_subnet" "default" {
  vpc_id = aws_vpc.default.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-terraform-subnet"
  }
}

resource "aws_internet_gateway" "ig1" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.env}-infra-app-igwTF"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig1.id
  }
  tags = {
    Name = "${var.env}-public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.default.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_security_group" "my_sg" {
    name = "${var.env}-infra-app-sg"
    description = "this is sg acc to env"
    vpc_id = aws_vpc.default.id
     ingress {
    description = "Allow HTTP ACCESS"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH ACCESS "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-infra-app-sg-TF"
  }
}


resource "aws_instance" "my_instance" {
  count = var.instance_count
  key_name = aws_key_pair.aws_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id = aws_subnet.default.id
  ami = var.ec2_ami_id
  instance_type =  var.instance_type
  
  
  root_block_device {
    volume_size = var.env == "prd" ? 10: 8
    volume_type = "gp3"
  }
  tags = {
    Environment = "${var.env}-infra-app-instance"
    Name = var.env
  }

}


