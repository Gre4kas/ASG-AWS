# Создание Launch Template для EC2 инстансов
resource "aws_launch_template" "app" {
  name          = "app-launch-template"
  image_id      = "ami-066784287e358dad1" 
  instance_type = "t2.micro"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = base64encode(<<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "<h1>Welcome to the web server!</h1>" > /var/www/html/index.html
                EOF
              )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-instance"
    }
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

