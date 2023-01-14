resource "aws_subnet" "this" {
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "public-subnet"
  }
}
