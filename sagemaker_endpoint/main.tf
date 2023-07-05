# SageMaker Model Object
resource "aws_sagemaker_model" "sagemaker_model" {
  name = "sagemaker-model-sklearn"
  execution_role_arn = var.sm-iam-role

  primary_container {
    image = var.container-image
    mode = "SingleModel"
    model_data_url = var.model-data 
    environment = {
      "SAGEMAKER_PROGRAM" = "inference.py"
      "SAGEMAKER_SUBMIT_DIRECTORY" = var.model-data
    }
  }

  tags = {
    Name = "sagemaker-model-terraform"
  }
}

# Create SageMaker endpoint configuration
resource "aws_sagemaker_endpoint_configuration" "sagemaker_endpoint_configuration" {
  name = "sagemaker-endpoint-configuration-sklearn"

  production_variants {
    initial_instance_count = 1
    instance_type = var.instance-type
    model_name = aws_sagemaker_model.sagemaker_model.name
    variant_name = "AllTraffic"
  }

  tags = {
    Name = "sagemaker-endpoint-configuration-terraform"
  }
}

# Create SageMaker Real-Time Endpoint
resource "aws_sagemaker_endpoint" "sagemaker_endpoint" {
  name = "sagemaker-endpoint-sklearn"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.name

  tags = {
    Name = "sagemaker-endpoint-terraform"
  }

}
