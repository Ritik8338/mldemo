variable "sm-iam-role" {
    type = string
    default = "Add your SageMaker IAM Role ARN here"
    description = "The IAM Role for SageMaker Endpoint Deployment"
}

variable "container-image" {
    type = string
    default = "683313688378.dkr.ecr.us-east-1.amazonaws.com/sagemaker-scikit-learn:0.23-1-cpu-py3"
    description = "The container you are utilizing for your SageMaker Model"
}

variable "model-data" {
    type = string
    default = "s3://sagemaker-us-east-1-474422712127/model.tar.gz"
    description = "The pre-trained model data/artifacts, replace this with your training job."
}

variable "instance-type" {
    type = string
    default = "ml.m5.xlarge"
    description = "The instance behind the SageMaker Real-Time Endpoint"
}

variable "memory-size" {
    type = number
    default = 4096
    description = "Memory size behind your Serverless Endpoint"
}

variable "concurrency" {
    type = number
    default = 2
    description = "Concurrent requests for Serverless Endpoint"
}
