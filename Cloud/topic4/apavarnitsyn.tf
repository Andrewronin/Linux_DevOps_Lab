provider "aws" {
  region     = 	"${var.region}"
  profile    = 	"default"
}

resource "aws_s3_bucket" "example" {
  bucket = "s3-apavarnitsyn-terra4"
  acl    = "private"
}

resource "aws_instance" "example" {
  ami           = "ami-0b898040803850657"
  instance_type = "t2.micro"
  depends_on = ["aws_s3_bucket.example"]
}


resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"

  provisioner "local-exec" {
	command = "echo ${aws_eip.ip.public_ip} > address.txt"
	on_failure = "continue"
  }
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}