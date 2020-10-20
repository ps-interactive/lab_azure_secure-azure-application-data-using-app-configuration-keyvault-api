
locals {
  resource_group_name = var.resource_group_name # refer to previously defined RG in PS terraform sandbox
  location = var.location
  github_repo_url = "https://github.com/Azure/AppConfiguration/tree/main/examples/DotNetFramework/WebDemo/Microsoft.Azure.AppConfiguration.WebDemo"
  github_repo_folder = "Microsoft.Azure.AppConfiguration.WebDemo"
  
  # if scm_username is preceeeded by a $ sign it is interpreted as a variable so prepend a `
  scm_username_temp = azurerm_app_service.myappservice.site_credential.0.username
  # dollar signs and backslashes are tricky in bash and tf
  # refer https://github.com/hashicorp/terraform/issues/23007
  scm_username = replace(local.scm_username_temp,"$","$")
  scm_password = azurerm_app_service.myappservice.site_credential.0.password
  repo_uri     = replace(azurerm_app_service.myappservice.source_control.0.repo_url, "https://", "")
  repository_cred_url = "https://${local.scm_username}:${local.scm_password}@${local.repo_uri}/${azurerm_app_service.myappservice.name}.git"
}


resource "azurerm_app_service_plan" "myappserviceplan" {
  name                = "${local.resource_group_name}-asp"
  location            = local.location
  resource_group_name = local.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "myappservice" {
  name                = "${var.prefix}-${local.resource_group_name}-appservice"
  location            = local.location
  resource_group_name = local.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.myappserviceplan.id



  site_config {
    dotnet_framework_version = "v4.0"
    remote_debugging_enabled = true
    remote_debugging_version = "VS2019"
    # git use per https://github.com/terraform-providers/terraform-provider-azurerm/issues/3696
    scm_type = "LocalGit"
  }


  # source_control {
  #   repo_url = "https://github.com/Azure-Samples/app-service-web-html-get-started"
  #   branch   = "master"  
  # }



    #some app settings to replace with app configuration
    app_settings = {
    "SOME_KEY" = "some-value"
    "BACKGROUND_COLOR" = "white"
  }
}

# resource "azurerm_app_service_source_control" "mysc" {
#   app_service_id        = azurerm_app_service.myappservice.id
#   repo_url              = "https://github.com/Azure-Samples/app-service-web-html-get-started"
#   is_manual_integration = true
#   branch                = "master"
# }
