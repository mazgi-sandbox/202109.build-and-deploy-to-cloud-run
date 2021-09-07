resource "google_cloud_run_domain_mapping" "website" {
  name     = var.base_dnsdomain
  location = var.gcp_default_region
  metadata {
    namespace = var.gcp_project_id
    annotations = {
      "run.googleapis.com/launch-stage" = "BETA"
    }
  }
  spec {
    route_name = google_cloud_run_service.website.name
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}

resource "google_cloud_run_service" "website" {
  name     = "${var.project_unique_id}-website"
  location = var.gcp_default_region
  template {
    spec {
      container_concurrency = 80
      containers {
        image = "gcr.io/${var.gcp_project_id}/website:latest"
        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "256M"
          }
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "2"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  metadata {
    namespace = var.gcp_project_id
  }
  lifecycle {
    ignore_changes = [
      metadata,
      template,
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "website" {
  location = google_cloud_run_service.website.location
  project  = google_cloud_run_service.website.project
  service  = google_cloud_run_service.website.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
