# provider "aws"{
#     region = "us-west-2"
# }

# # Define variables
# variable "image_repository_name" {
#   description = "demorepo"
#   type        = string
#   default     = "my-container-repo"
# }

# variable "image_tag" {
#   description = "Tag for the Docker image"
#   type        = string
#   default     = "latest"
# }

# resource "aws_ecr_repository" "noiselesstech" {
# 	  name = "noiselesstech"
	

# 	  image_scanning_configuration {
# 	    scan_on_push = true
# 	  }
# }

# resource "aws_ecr_lifecycle_policy" "default_policy" {
#   repository = aws_ecr_repository.noiselesstech.name
	

# 	policy = <<EOF
# {
#   "rules": [
#     {
#       "rulePriority": 1,
#       "description": "Expire images older than 7 days",
#       "selection": {
#         "tagStatus": "any",
#         "countType": "sinceImagePushed",
#         "countUnit": "days",
#         "countNumber": 7
#       },
#       "action": {
#         "type": "expire"
#       }
#     }
#   ]
# }
# EOF
# }



# # resource "null_resource" "docker_packaging" {
	
# # 	  provisioner "local-exec" {
# # 	    command = <<EOF
# # 	    aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 575773971780.dkr.ecr.us-west-2.amazonaws.com
# #         docker build -t noiselesstech .
      
# # 	    docker tag noiselesstech:latest 575773971780.dkr.ecr.us-west-2.amazonaws.com/noiselesstech:latest -f noiselesstech/Dockerfile .
# # 	    docker push 575773971780.dkr.ecr.us-west-2.amazonaws.com/noiselesstech:latest
# # 	    EOF
# # 	  }
	

# # 	  triggers = {
# # 	    "run_at" = timestamp()
# # 	  }
	

# # 	  depends_on = [
# # 	    aws_ecr_repository.noiselesstech,
# # 	  ]
# # }

# # Build and push the container image
# resource "null_resource" "build_push_image" {
#   provisioner "local-exec" {
#     command = <<EOT
     
#       docker build -t noiselesstech:latest .
      
      
#       docker tag my-container:latest ${aws_ecr_repository.noiselesstech.repository_url}:latest -f noiselesstech/Dockerfile .
      
      
#       aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 575773971780.dkr.ecr.us-west-2.amazonaws.com
      
      
#       docker push ${aws_ecr_repository.noiselesstech.repository_url}:latest
#     EOT
#     # working_dir = "C:\\Users\\kriti\\dockerfile\\Dockerfile"  # Replace with the path to your Dockerfile directory
#   }

#   depends_on = [aws_ecr_repository.noiselesstech]
# }


provider "aws" {
  region = "us-west-2"
}



resource "aws_ecr_repository" "my_repository" {
  name = "my-repo"
}

resource "aws_ecr_repository_policy" "my_repository_policy" {
  repository = aws_ecr_repository.my_repository.name

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowPull",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}

resource "docker_image" "my_image" {
  name          = "my-image"
  build_context = "./noiselesstech/dockerfile"
}

resource "aws_ecr_image" "my_ecr_image" {
  repository_name = aws_ecr_repository.my_repository.name
  image_name      = docker_image.my_image.name
  image_tag       = docker_image.my_image.latest

  depends_on = [docker_image.my_image]
}

data "aws_caller_identity" "current" {}

output "ecr_repository_url" {
  value = aws_ecr_repository.my_repository.repository_url
}

output "ecr_image_url" {
  value = "${aws_ecr_repository.my_repository.repository_url}:${docker_image.my_image.latest}"
}



