
resource "aws_key_pair" "this" {
    key_name   = var.key_name
    public_key = var.public_key  
}

resource "aws_instance" "this" {
    ami                    = var.ami_id
    instance_type          = var.instance_type
    subnet_id              = var.subnet_id
    key_name               = aws_key_pair.this.key_name
    vpc_security_group_ids = var.vpc_security_group_ids
    iam_instance_profile   = var.iam_instance_profile  

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

