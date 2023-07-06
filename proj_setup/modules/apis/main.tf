#enable APIs
resource "google_project_service" "api" {
  count = length(var.apis)
  service = var.apis[count.index]
  disable_dependent_services=true
}
