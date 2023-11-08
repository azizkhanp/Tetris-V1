terraform {
  backend "gcs" {
    bucket  = "aziz-terraform-pro" # replace with your GCS bucket name
    credentials = "devops-403405-ea5d8b6254a3.json"
    
  }
}
