data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.al2023.id
  instance_type = var.instance_type
  tags          = { Name = var.name }
}
