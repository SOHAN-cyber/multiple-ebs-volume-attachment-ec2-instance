resource "aws_instance" "this" {
  count         = length(var.ec2_name)
  ami           = "ami-04f8d7ed2f1a54b14"
  instance_type = "t2.micro"
  availability_zone = element(var.ebs_availability_zone, count.index)
  tags = {
    Name = element(var.ec2_name, count.index)
  }
}

resource "aws_ebs_volume" "mongo-secondary" {
  count             = 3 * length(module.ec2_instance)
  availability_zone = count.index < 3 ? element(var.ebs_availability_zone, 0) : element(var.ebs_availability_zone, 1)
  size              = element(var.ebs_size, count.index % length(var.ebs_size))
  tags = {
    Name = count.index < 3 ? format("mongo-secondary-storage-1-%d", count.index + 1)  : format("mongo-secondary-storage-2-%d", count.index - 2)
  }
}

resource "aws_volume_attachment" "ebs_att" {
  count       = 3 * length(module.ec2_instance)
  device_name = element(var.device_name, count.index % length(var.device_name))
  volume_id   = element(aws_ebs_volume.mongo-secondary.*.id, count.index)
  instance_id = count.index < 3 ? module.ec2_instance[0].instance_id : module.ec2_instance[1].instance_id
}
