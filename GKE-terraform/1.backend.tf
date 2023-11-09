terraform {
  backend "gcs" {
    bucket  = "aziz-terraform-pro" # replace with your GCS bucket name
    prefix = "terraform/state"
    credentials = "devops-403405-ea5d8b6254a3.json"

  }
}
