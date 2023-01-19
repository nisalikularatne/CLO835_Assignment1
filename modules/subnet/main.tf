resource "aws_subnet" "this" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}
