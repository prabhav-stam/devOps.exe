provider "aws" {
  region = "us-east-1" # You can change this to your preferred region (e.g., ap-south-1 for Mumbai)
}

# 1. Create a Security Group for the EC2 Instance
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_security_group"
  description = "Allow SSH and HTTP traffic for Jenkins"

  # Allow SSH from anywhere (for demonstration purposes only)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP traffic on port 8080 (Default Jenkins port)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic (so the server can download packages like Jenkins, Java, Docker)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Ensure a default subnet exists (Fixes the "No subnets found" error)
resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1a"
}

# 3. Provision the EC2 Instance (Free Tier Eligible)
resource "aws_instance" "jenkins_server" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS AMI in us-east-1.
  instance_type = "t3.micro"              # Free tier eligible (newer accounts use t3.micro)
  subnet_id     = aws_default_subnet.default_az1.id

  # Attach the security group we created above
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  # (Optional but recommended) Specify an SSH key pair name if you want to log into this instance later
  # key_name = "your-key-pair-name"

  tags = {
    Name = "Jenkins-CI-Server"
    Project = "Clean India DevOps"
  }
}

# 4. Output the public IP of the instance so we can easily connect to it
output "jenkins_server_public_ip" {
  value       = aws_instance.jenkins_server.public_ip
  description = "The public IP address of the Jenkins EC2 instance"
}
