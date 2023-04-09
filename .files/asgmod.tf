module "asg" {
  source = "HENNGE/autoscaling-mixed-instances/aws"
  version = "3.0.0"

  name = "${var.project}-asg"

  # Launch template
  lt_name = "project1-lt"

  image_id        = var.image_id //ami-03d3eec31be6ef6f9
  security_groups = ["${var.project}-sg"]

  block_device_mappings = [
    {
      # Root block device
      device_name = "/dev/xvda"

      ebs = [
        {
          volume_type = "gp2"
          volume_size = 8
        },
      ]
    },
    #{
      # EBS Block Device
      #device_name = "/dev/xvdz"

      #ebs = [
      #  {
      #    volume_type = "gp2"
      #    volume_size = 8
      #  },
     # ]
    #},
  ]

  # Auto scaling group
  asg_name                  = "${var.project}-asg"
  vpc_zone_identifier       = ["${var.region}a", "${var.region}b"]
  health_check_type         = "EC2"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  ignore_desired_capacity_changes = true

  tags = [
    {
      key                 = "Environment"
      value               = "${var.env}"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "${var.project}"
      propagate_at_launch = true
    },
  ]

  #tags_as_map = {
  #  extra_tag1 = "extra_value1"
  #  extra_tag2 = "extra_value2"
  #}

  instance_types = [
    {
      instance_type = "${var.instance_type}",
      #weighted_capacity = 1,
    },
    #{
    #  instance_type = "t3.micro",
    #  weighted_capacity = 1,
    #},
    #{
    #  instance_type = "t2.small",
    #  weighted_capacity = 2,
    #},
    #{
    #  instance_type = "t3.small",
    #  weighted_capacity = 2,
    #},
    #{
    #  instance_type = "t2.medium",
    #  weighted_capacity = 4,
    #},
  ]

  on_demand_base_capacity                  = 0
  on_demand_percentage_above_base_capacity = 100
}