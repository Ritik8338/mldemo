provider "aws" {
  region = "us-west-2"  # Replace with your desired region
  access_key = "AKIAYMDWNSVCNPTHCJF5"
  secret_key = "6JDamODj9Qw2abr+1Rm7+JrnvdQVENfV7ay9g2Lb"
}

resource "aws_sagemaker_notebook_instance" "ni" {
  name          = "my-notebook-instance"
  role_arn      = "arn:aws:iam::575773971780:role/sagemaker-role"
  instance_type = "ml.t2.medium"

  tags = {
    Name = "foo"
  }
}
