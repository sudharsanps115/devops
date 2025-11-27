provider "aws" {
  alias  = "apsouth"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "useast"
  region = "us-east-1"
}

resource "aws_instance" "east_instance" {
  provider      = aws.useast
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
}

resource "aws_instance" "ap_south_instance" {
  provider      = aws.apsouth
  ami           = "ami-02b8269d5e85954ef"
  instance_type = "t3.micro"

}

# output

output "ap_south_public_ip" {
  value = aws_instance.ap_south_instance.public_ip
}

output "east_instance_public_ip" {
  value = "aws_instance.east_instance.public_ip"
}