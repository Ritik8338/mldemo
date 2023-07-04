provider "aws" {
    region = "us-west-2"
  
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "buhbhkcketritik8338"
  # Add other bucket configuration properties as needed
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CrossAccountAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::327525734399:role/s3-cross-account-role-A"
      },
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::buhbhkcketritik8338/*",
        "arn:aws:s3:::buhbhkcketritik8338"
      ]
    }
  ]
}
EOF
}


