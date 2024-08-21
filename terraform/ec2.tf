# Создание Launch Template для EC2 инстансов
resource "aws_launch_template" "app" {
  name          = "app-launch-template"
  image_id      = "ami-04a81a99f5ec58529" 
  instance_type = "t2.micro"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = filebase64("${path.module}/nginx.sh")
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-instance"
    }
  }
  # Required with an autoscaling group.
  lifecycle {
    create_before_destroy = true
  }
}

# Создание Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = module.vpc.public_subnets # Размещение в публичных подсетях

  target_group_arns = [aws_lb_target_group.app_tg.arn] # Опционально, если используется Load Balancer
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.app_asg.id
  lb_target_group_arn    = aws_lb_target_group.app_tg.id
}
