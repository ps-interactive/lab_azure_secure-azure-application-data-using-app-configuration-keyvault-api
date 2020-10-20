# depends on valeus defined in main.tf
resource "azurerm_storage_account" "sa_cloudshell" {

  # this line uses that random string and appends pssacs to the front.
  name                     = "pssacs${lower(random_string.sa_random_id.result)}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "standard"
  account_replication_type = "LRS"
  account_kind             = "Storagev2"
  allow_blob_public_access = "true"  
}

resource "azurerm_storage_share" "cloudshell" {
  name                 = "cloudshell"
  storage_account_name = azurerm_storage_account.sa_cloudshell.name
  quota                = 50

}