provider "azurerm" {
  version = "~>2.0"
  features {}
}

provider "random" {
  version = "~> 3.0"
}


# this resource returns a random 14 character string that contains 7 lowercase and 7 uppercase letters
resource "random_string" "sa_random_id" {
  length      = 14
  upper       = false
  lower       = true
  min_lower   = 7
  min_numeric = 7
  special     = false
}

variable "resource_group_name" {
  # this variable is automatically assigned by the cloud sandbox
}
variable "location" {
  # this variable is automatically assigned by the cloud sandbox
}
