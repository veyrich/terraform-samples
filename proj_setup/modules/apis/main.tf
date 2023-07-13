#enable APIs
#cloudresourcemanager is enabled by default  
locals {
       required_apis = [ "cloudresourcemanager.googleapis.com" ]
       #APIs requested by the user
       all_apis = concat(local.required_apis,var.apis)
}

resource "google_project_service" "api" {
  count = length(local.all_apis)
  service = local.all_apis[count.index]
  disable_dependent_services=true
}
