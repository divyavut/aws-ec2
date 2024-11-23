
# create EC2 instance
module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = var.ec2_name
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-08eed4ca0fd852a9e"]
  subnet_id              = "subnet-0509f144a358e12de"
  ami = data.aws_ami.ami_info.id
  user_data = file("bastion.sh")
  # Define the root volume size and type
  root_block_device = [
    {
        volume_size = 30 # GiB
        volume_type = "standard" # general purpose ssd
        delete_on_termination = true # automatically delete the volumes when the instance is terminated
    }
  ]
  tags = {
    Name = var.ec2_name
  }
}