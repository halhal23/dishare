resource "aws_instance" "dishare-ecs-instance" {
    ami = "${var.ami_id}"
    instance_type = "t2.small"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${aws_security_group.dishare-ecs-instance-sg.id}"]
    subnet_id = "${aws_subnet.dishare-public-sb-1a.id}"
    associate_public_ip_address = "true"
    iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
    tags = {
        Name = "dishare-ecs-instance"
    }
    user_data = "${file("user_data.sh")}"
}

variable "ami_id" {}
variable "key_name" {}