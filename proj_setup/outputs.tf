output "vpc_network_name" {
       value = module.vpc.vpc_network_name
}

output "services_enabled" {
       value = module.apis.api[*].service
}