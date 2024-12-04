
#SG (ingress is incoming traffic , egress is outgoing traffic)
resource "aws_security_group" "SG_VPCIP8000N8" {
  name        = "SG_VPCIP8000N8"
  description = "Allow All traffic"
  vpc_id      = "${aws_vpc.VPCIP8000N8.id}"

  tags = {
    Name = "SG_VPCIP8000N8"
  }
}

resource "aws_security_group_rule" "ICMP" {
  type              = "ingress"
  description       = var.ICMP-description[1] # come from variables.tf 
  from_port         = 0
  to_port           = "-1"
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.SG_VPCIP8000N8.id
}

resource "aws_security_group_rule" "ICMP_Out" {
  type        = "egress"
  description = var.ICMP-description[1] # come from variables.tf 
  from_port   = 0
  to_port     = "-1"
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG_VPCIP8000N8.id
}

resource "aws_security_group_rule" "TCP" {
  type        = "ingress"
  description = var.TCP-description["TCP-desc"] # come from variables.tf 
  from_port   = 0
  to_port     = 0
  #protocol   = "tcp"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG_VPCIP8000N8.id
}

resource "aws_security_group_rule" "TCP_Out" {
  type        = "egress"
  description = var.TCP-description["TCP_Out-desc"] # come from variables.tf 
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG_VPCIP8000N8.id
}
