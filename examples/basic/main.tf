terraform {
  required_version = ">= 1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "1234-1234-1234-1234-1234"
}

module "event_hub" {
  source = "../.."

  
resource_group = {
  name     = "example-rg"
  location = "West Europe"
}

event_hub_namespace = {
  name = "test-ateventshub-namespace"
  config = {
    sku                      = "Standard"
    capacity                 = 1
    minimum_tls_version      = "1.2"
    auto_inflate_enabled     = true
    maximum_throughput_units = 2 # This value must be greater than `capacity`

  }
}

tags = {
  Environment = "Production"
}

user_assigned_identity_id = "/subscriptions/1234-1234-1234-1234-1234/resourceGroups/test-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/test-mid"

}