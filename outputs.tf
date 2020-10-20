output "out_resource_group_name" {
  value = var.resource_group_name
}
# output "out_resource_group_name_id" {
#   value = azurerm_resource_group.resource_group_name.id
# }


output "out_app_service_name" {
  value = azurerm_app_service.myappservice.name
}

output "out_app_service_default_hostname" {
  value = "https://${azurerm_app_service.myappservice.default_site_hostname}"
}

output "repository_cred_url" {
  value = local.repository_cred_url
}

output "website_url" {
  value = azurerm_app_service.myappservice.default_site_hostname
}