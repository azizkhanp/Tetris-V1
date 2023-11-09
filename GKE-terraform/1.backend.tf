terraform {
  backend "gcs" {
    bucket  = "aziz-terraform-pro" # replace with your GCS bucket name
    prefix = "terraform/state"

  }
}
