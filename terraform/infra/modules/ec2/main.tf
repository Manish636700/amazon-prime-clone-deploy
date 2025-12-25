resource "aws_security_group" "this" {
    name          = "${var.name}-sg"
    vpc_id        = var.vpc_id

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
        Name = "${var.name}-sg"
    }

}

resource "aws_key_pair" "this" {
    key_name   = var.key_name
    public_key = var.public_key  
}
resource "aws_iam_role" "this" {
  name                = "${var.name}-role"

  assume_role_policy  = jsonencode({
    Version      = "2012-10-17"
    Statement    = [{
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
    }]
  }) 
}


resource "aws_iam_role_policy_attachment" "ssm" {
    role         = aws_iam_role.this.name
    policy_arn   = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"    
}


resource "aws_iam_instance_profile" "this" {
    name          = "${var.name}-profile"
    role          = aws_iam_role.this.name  
}



resource "aws_instance" "this" {
    ami                    = var.ami_id
    instance_type          = var.instance_type
    subnet_id              = var.subnet_id
    key_name               = aws_key_pair.this.key_name
    vpc_security_group_ids = [aws_security_group.this.id]
    iam_instance_profile   = aws_iam_instance_profile.this.name  

    associate_public_ip_address = true

    metadata_options {
        http_tokens     = "required"
    }

    root_block_device {
        volume_size           = var.volume_size
        volume_type           = "gp3"
        encrypted             = true
        delete_on_termination = true  
    }
    user_data = file("${path.module}/userdata.sh")


    tags = {
        Name        = var.name
        Environment = "production"
        Role        = "bastion-jenkins"
    }
}

