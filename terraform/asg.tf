# Создание Launch Template для EC2 инстансов
resource "aws_launch_template" "app" {
  name          = "${var.prefix}-app-launch-template"
  description   = "App Launch Template"
  image_id      = var.ami
  instance_type = "t2.micro"

  update_default_version = true
  user_data              = base64encode(templatefile("${path.module}/script.sh", local.vars))
  vpc_security_group_ids = [aws_security_group.asg_sg.id]

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.prefix}-app-instance"
    }
  }
  # Required with an autoscaling group.
  lifecycle {
    create_before_destroy = true
  }
}

# Создание Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = module.vpc.private_subnets
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.app.id
    version = aws_launch_template.app.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.prefix}-app-instance"
    propagate_at_launch = true
  }
}
