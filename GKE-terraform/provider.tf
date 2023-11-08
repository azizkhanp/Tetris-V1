terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "google" {
    credentials = "devops-403405-ea5d8b6254a3.json"
    project = "devops-403405"
    region = "us-west4"  
}