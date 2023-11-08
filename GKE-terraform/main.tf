# Create a GKE cluster
resource "google_container_cluster" "gke-cluster" {
  name     = "gke-cluster"
  location = "us-west4"
  deletion_protection ="false"

  node_pool {
    name       = "default-pool"
    initial_node_count = 1
    
  }

  # Additional configurations like network, node configuration, etc.
}

# Create a service account for the GKE nodes
resource "google_service_account" "node_service_account" {
  account_id = "node-sa"
}

# Grant necessary permissions to the service account
resource "google_project_iam_member" "node_service_account_roles" {
  project = "devops-403405"
  role = "roles/compute.viewer" # Replace with the necessary role
  member = "serviceAccount:${google_service_account.node_service_account.email}"
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
    machine_type = "e2-medium" # Replace with your desired machine type
    # Additional node configurations
  }
}
