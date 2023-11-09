resource "google_service_account" "gke_service_account" {
  account_id   = "gke-SA"
  display_name = "GKE Service Account"
}

resource "google_project_iam_member" "gke_cluster_role" {
  project = "devops-403405"
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_service_account.email}"
}


# Create a GKE cluster
resource "google_container_cluster" "gke-cluster" {
  name     = "gke-cluster"
  location = "us-east1"
  deletion_protection ="false"
  initial_node_count = 2
  remove_default_node_pool = true
}

# Create a GKE node pool
resource "google_container_node_pool" "node_pool" {
  name       = "node-pool"
  location   = google_container_cluster.gke-cluster.location
  cluster    = google_container_cluster.gke-cluster.name
  initial_node_count = 2

  node_config {
    service_account = google_service_account.gke_service_account.email
    disk_size_gb = "10"
    machine_type = "e2-small" # Replace with your desired machine type
    # Additional node configurations
  }
}
