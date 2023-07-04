variable "sm-iam-role" {
    type = string
    default = "arn:aws:iam::575773971780:role/service-role/AmazonSageMaker-ExecutionRole-20230704T095800"
    description = "The IAM Role for SageMaker Endpoint Deployment"
}

variable "container-image" {
    type = string
    default = "575773971780.dkr.ecr.us-west-2.amazonaws.com/mlmodel:latest"
    description = "The container you are utilizing for your SageMaker Model"
}

variable "model-data" {
    type = string
    default = "s3://sagemaker-us-west-2-575773971780/sagemaker-scikit-learn-2023-07-04-04-55-31-871/output/model.tar.gz"
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