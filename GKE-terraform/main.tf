# Create a GKE cluster
resource "google_container_cluster" "gke-cluster" {
  name     = "gke-cluster"
  location = "us-west4"
  deletion_protection ="false"
  initial_node_count = 2
  remove_default_node_pool = true
}

# Create a service account for the GKE nodes
resource "google_service_account" "node_service_account" {
  account_id = "node-sa"
}

# Grant necessary permissions to the service account
resource "google_project_iam_member" "service_account_permissions" {
  project = "devops-403405"
  role    = "roles/container.admin" # Replace with the necessary role
  member  = "serviceAccount:node-sa@devops-403405.iam.gserviceaccount.com"
}

# Create a GKE node pool
resource "google_container_node_pool" "node_pool" {
  name       = "node-pool"
  location   = google_container_cluster.gke-cluster.location
  cluster    = google_container_cluster.gke-cluster.name
  node_count = 1

  node_config {
    service_account = google_service_account.node_service_account.email
    disk_size_gb = "10"
    machine_type = "e2-small" # Replace with your desired machine type
    # Additional node configurations
  }
}
