# output "apis_id" {
# 	 #need to use count/array syntax here since input is a list
# 	 value = google_project_service.api[*].id
# 	 description = "ID of APIs resource for dependencies"
# }

output "api" {
       value = google_project_service.api
}
